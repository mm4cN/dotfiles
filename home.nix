{ pkgs, ... }:

let
  username = builtins.getEnv "USER";
in
{
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    git-lfs

    nodejs
    python313
    neovim
    tmux
    wezterm

    llvmPackages.clang
    llvmPackages.clang-tools

    ripgrep
    fzf
    jq
    bat

    cmake
    ninja

    rustup
    go
    gopls
    golangci-lint
  ];

  home.file.".config/nvim".source =
    ./nvim/.config/nvim;

  home.file.".config/wezterm".source =
    ./wezterm/.config/wezterm;

  home.file.".gitconfig".source =
    ./git/.gitconfig;

  home.file.".zshrc".source =
    ./zsh/.zshrc;

  home.file.".tmux.conf".source =
    ./tmux/.tmux.conf;
}