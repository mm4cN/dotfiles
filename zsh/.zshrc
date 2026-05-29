export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="jonathan"
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
zstyle ':omz:update' mode auto      # update automatically without asking
plugins=(git zsh-ssh docker rust zsh-syntax-highlighting)
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.zsh_profile ]] || source ~/.zsh_profile

