# ZSHRC By Aiola
# Environement : MACOS

### Shell Command on lauch
neofetch

### POWER10K
# https://github.com/romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

### PLUGINS ZSH
# ZSH-AUTOSUGGESTIONS : https://github.com/zsh-users/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ZSH-SYNTAX-HIGHLIGHTING : https://github.com/zsh-users/zsh-syntax-highlighting
#plugins=(zsh-syntax-highlighting)
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### EXA
# https://the.exa.website/
alias ls="exa -a --icons"                   # short, multi-line
alias ll="exa -1a --icons"                  # list, 1 per line
alias ld="ll"                               # ^^^, NOTE: Trying to move to this for alternate hand commands
alias la="exa -lagh --icons"                  # list with info
alias lt="exa -a --tree --icons --level=2"  # list with tree level 2
alias ltf="exa -a --tree --icons"           # list with tree
alias lat="exa -lagh --tree --icons"          # list with info and tree

### BAT
# https://github.com/sharkdp/bat
alias cat=bat --style="header" --pager "less -RF"
alias catn=bat --pager "less -RF"
alias batn=bat --pager "less -RF"

### BTOP
# https://github.com/aristocratos/btop
alias htop="btop"
alias top="btop"

### CHEAT
# https://github.com/cheat/cheat
alias "?"="cheat"
alias "help"="cheat"