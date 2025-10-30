#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install --cask font-meslo-lg-nerd-font
brew install git git-lfs tmux fzf ripgrep pyenv zsh powerlevel10k

git lfs install

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh

/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

stow -t ~ alacritty
stow -t ~ nvim
stow -t tmux
stow -t ~ zsh
stow -t ~ git
