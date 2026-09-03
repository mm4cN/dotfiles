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

  outputs = {
      nixpkgs,
      home-manager,
      mac-app-util,
      ...
  }@inputs:
  let
    mkHome = 
      { system, username, homeDirectory, extraModules ? [ ] }:
      let 
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        isDarwin = nixpkgs.lib.hasSuffix "darwin" system;
        in
          home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [
                ./home.nix
                {
                  home.username = username;
                  home.homeDirectory = homeDirectory;
                }
              ]
              ++ nixpkgs.lib.optional isDarwin mac-app-util.homeManagerModules.default
              ++ extraModules;
          };
          mkCmake331 = pkgs: pkgs.cmake.overrideAttrs (old: {
            pname = "cmake";
            version = "3.31.12";
            src = pkgs.fetchurl {
              url = "https://github.com/Kitware/CMake/archive/v3.31.12.tar.gz";
              sha256 = "sha256-P9snqYGXLWP/9disZ/NI/zubDoMWjwIShApTal/yJI8=";
            };
            patches = [];
            patchPhase = ''
              # no-op: upstream sources don't need nixpkgs patches
            '';
            });
  in {
    lib.mkHome = mkHome;
    homeConfigurations = {
      "darwin-home" = mkHome {
          system = "aarch64-darwin";
          username = "marekmacznik";
          homeDirectory = "/Users/marekmacznik";
          extraModules = [
            ({pkgs, ...}: {home.packages = [ 
              pkgs.python313 
              pkgs.cmake 
              pkgs.claude-code 
              pkgs.codex 
              ]; 
            })
          ];
      };

      "linux-home" = mkHome {
        system = "aarch64-linux";
        username = "marekmacznik";
        homeDirectory = "/home/marekmacznik";
        extraModules = [
          ({pkgs, ...}: {home.packages = [ (mkCmake331 pkgs) pkgs.python311 ]; })
        ];
      };

      "demo" = mkHome {
        system = "aarch64-linux";
        username = "user";
        homeDirectory = "/home/user";
        extraModules = [
          ({pkgs, ...}: {home.packages = [ (mkCmake331 pkgs) pkgs.python311 pkgs.gcc pkgs.binutils pkgs.gnumake ]; })
        ];
      };

    };
  };
}
