{ pkgs, lib, ... }:

let
  zsh-ssh = pkgs.fetchFromGitHub {
    owner = "sunlei";
    repo = "zsh-ssh";
    rev = "master";
    hash = "sha256-1yJasYai4+T8j76lCvIhSFh4fm7VUoF4F4E+v8WSr2I=";
  };

  ohMyZshCustom = pkgs.runCommand "oh-my-zsh-custom" {} ''
    mkdir -p $out/plugins
    ln -s ${zsh-ssh} $out/plugins/zsh-ssh
  '';

  conanNoTests = pkgs.conan.overrideAttrs (_: {
    doCheck = false;
    doInstallCheck = false;
  });

  platformioNoTests = pkgs.platformio.overrideAttrs (_: {
    doCheck = false;
    doInstallCheck = false;
  });
in
{
  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      custom = "${ohMyZshCustom}";

      plugins = [
        "git"
        "sudo"
        "docker"
        "zsh-ssh"
      ];
    };

    history = {
      path = "$HOME/.zhistory";
      size = 999;
      save = 1000;
      share = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      sl = "ls";
    };

    initContent = lib.mkMerge [
      (lib.mkOrder 550 ''
        CASE_SENSITIVE="true"
        fpath+=("${pkgs.zsh-completions}/share/zsh/site-functions")
      '')

      ''
        zstyle ':omz:update' mode auto
        zstyle ':completion:*:*:docker:*' option-stacking yes
        zstyle ':completion:*:*:docker-*:*' option-stacking yes

        setopt hist_verify

        bindkey '^[[A' history-search-backward
        bindkey '^[[B' history-search-forward
        bindkey "^[[1;3C" forward-word
        bindkey "^[[1;3D" backward-word

        PROMPT=''${PROMPT/\%c/\%~}

        export FZF_DEFAULT_OPTS=" \
        --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
        --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
        --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
        --color=selected-bg:#494d64 \
        --multi"

        export FZF_CTRL_T_OPTS="
          --walker-skip .git,node_modules,target
          --preview 'bat -n --color=always {}'
          --bind 'ctrl-/:change-preview-window(down|hidden|)'"

        export FZF_ALT_C_OPTS="
          --walker-skip .git,node_modules,target
          --preview 'tree -C {}'"

        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

        [[ -f ~/.auths ]] && source ~/.auths
        [[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

        export PATH="$HOME/.local/bin:$PATH"
      ''
    ];

  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    nerd-fonts.meslo-lg
    git
    git-lfs
    delta

    htop
    uv
    nodejs
    python313
    neovim
    tmux
    wezterm
    lazygit
    lazydocker

    llvmPackages.clang-tools

    fd
    ripgrep
    fzf
    jq
    bat
    tree

    conanNoTests
    platformioNoTests
    cmake
    ninja

    rustup
    go
    gopls
    golangci-lint
    delve
    gofumpt

    mediainfo
    sox
    ffmpeg

    ollama

    zsh-completions
  ];

  home.file.".config/nvim".source =
    ./nvim/.config/nvim;

  home.file.".config/wezterm".source =
    ./wezterm/.config/wezterm;

  home.file.".tmux.conf".source =
    ./tmux/.tmux.conf;
}
