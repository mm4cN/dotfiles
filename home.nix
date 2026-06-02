{ pkgs, ... }:

{
  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "docker" "zsh-ssh" "zsh-syntax-highlighting" "zsh-completions" ];
    };
  };

  home.packages = with pkgs; [
    git
    git-lfs

    uv
    nodejs
    python313
    neovim
    tmux
    wezterm
    lazygit

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
    delve
    gofumpt
  ];

  home.file.".config/nvim".source =
    ./nvim/.config/nvim;

  home.file.".config/wezterm".source =
    ./wezterm/.config/wezterm;

  home.file.".zshrc".source =
    ./zsh/.zshrc;

  home.file.".zsh_profile".source = 
    ./zsh/.zsh_profile;

  home.file.".tmux.conf".source =
    ./tmux/.tmux.conf;
}
