{
  description = "mm4cN dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    mac-app-util.url = "github:hraban/mac-app-util";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, mac-app-util, ... }:
  let
    system = "aarch64-darwin";
    username = "marekmacznik";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    homeConfigurations.${username} =
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          mac-app-util.homeManagerModules.default
          ./home.nix
          {
            home.username = username;
            home.homeDirectory = if (builtins.match ".*darwin.*" system != null)
              then "/Users/${username}"
              else "/home/${username}";
          }
        ];
      };
  };
}
