{ pkgs, ... }:

{
  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    git-lfs

    uv
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
    tree

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

  home.file.".zsh_profile".source = 
    ./zsh/.zsh_profile;

  home.file.".tmux.conf".source =
    ./tmux/.tmux.conf;
}
