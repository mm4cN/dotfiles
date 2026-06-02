CASE_SENSITIVE="true"
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.zsh_profile ]] || source ~/.zsh_profile
. "$HOME/.cargo/env"
export PATH="$HOME/.local/bin:$PATH"

