#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

apt update 
apt install -y build-essential curl wget git git-lfs tmux fzf ripgrep zsh zsh-common xsel batcat

curl -fsSL https://pyenv.run | bash

git lfs install

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

./stow_dirs.sh
