# Enable Powerlevel10k instant prompt
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.powerlevel10k/powerlevel10k.zsh-theme

plugins=(git)
ZSH_THEME="powerlevel10k/powerlevel10k"

## GIT alias ##
alias gb="git branch"
alias gst="git status -uno"
alias gco="git checkout"
alias ga="git add"
alias gd="git diff"
alias gds="git diff --staged"
alias gcmsg="git commit -m"
alias gcamend="git commit --amend"
alias pip='pip3'

export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

# Arrow keys
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
