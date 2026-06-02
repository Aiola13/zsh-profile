# =============================================================================
#  ZSHRC by Aiola
#  Environment: macOS
# =============================================================================

# -----------------------------------------------------------------------------
#  Startup command
#  Run only in interactive shells so non-interactive contexts (scp, scripts)
#  are not polluted by output.
# -----------------------------------------------------------------------------
if [[ -o interactive ]]; then
  fastfetch
fi

# -----------------------------------------------------------------------------
#  Powerlevel10k instant prompt
#  Must stay near the top of ~/.zshrc. Keep any code that produces output
#  (e.g. fastfetch, echo) below this block, otherwise the instant prompt breaks.
# -----------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------------
#  Path
# -----------------------------------------------------------------------------
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# -----------------------------------------------------------------------------
#  Oh My Zsh
# -----------------------------------------------------------------------------
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme (run `p10k configure` to customize, or edit ~/.p10k.zsh).
ZSH_THEME="powerlevel10k/powerlevel10k"

# Auto-update behavior (uncomment to change):
# zstyle ':omz:update' mode disabled   # disable automatic updates
# zstyle ':omz:update' mode auto       # update automatically without asking
# zstyle ':omz:update' mode reminder   # remind me to update when it's time
# zstyle ':omz:update' frequency 13    # how often to check (in days)

# Other optional toggles (uncomment to enable):
# CASE_SENSITIVE="true"                # case-sensitive completion
# HYPHEN_INSENSITIVE="true"            # treat _ and - as interchangeable
# DISABLE_MAGIC_FUNCTIONS="true"       # fix pasting issues
# DISABLE_LS_COLORS="true"             # disable colors in ls
# DISABLE_AUTO_TITLE="true"            # disable terminal title auto-setting
# ENABLE_CORRECTION="true"             # command auto-correction
# COMPLETION_WAITING_DOTS="true"       # show dots while waiting for completion
# HIST_STAMPS="yyyy-mm-dd"             # timestamp format in `history` output

# -----------------------------------------------------------------------------
#  Plugins
#  Standard plugins: $ZSH/plugins/  |  Custom plugins: $ZSH_CUSTOM/plugins/
#  Keep zsh-syntax-highlighting last. Too many plugins slow down startup.
# -----------------------------------------------------------------------------
plugins=(
  git
  docker
  docker-compose
  sudo
  history
  colored-man-pages
  extract
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# =============================================================================
#  User configuration
# =============================================================================

# -----------------------------------------------------------------------------
#  Environment
# -----------------------------------------------------------------------------
# export LANG=en_US.UTF-8
# export MANPATH="/usr/local/man:$MANPATH"
# export ARCHFLAGS="-arch $(uname -m)"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# -----------------------------------------------------------------------------
#  eza - modern ls replacement
#  https://github.com/eza-community/eza
# -----------------------------------------------------------------------------
alias ls="eza -a --icons"                       # short, multi-line
alias ll="eza -1a --icons"                       # list, one per line
alias ld="ll"                                    # alias of ll (alternate hand)
alias la="eza -lagh --icons"                     # list with details
alias lt="eza -a --tree --icons --level=2"       # tree view, depth 2
alias ltf="eza -a --tree --icons"                # full tree view
alias lat="eza -lagh --tree --icons"             # tree view with details

# -----------------------------------------------------------------------------
#  bat - cat clone with syntax highlighting
#  https://github.com/sharkdp/bat
# -----------------------------------------------------------------------------
alias cat='bat --style=header --pager "less -RF"'
alias catn='bat --pager "less -RF"'
alias batn='bat --pager "less -RF"'

# -----------------------------------------------------------------------------
#  btop - system monitor
#  https://github.com/aristocratos/btop
# -----------------------------------------------------------------------------
alias htop="btop"
alias top="btop"

# -----------------------------------------------------------------------------
#  cheat - command cheatsheets
#  https://github.com/cheat/cheat
# -----------------------------------------------------------------------------
alias "?"="cheat"
alias "help"="cheat"

# -----------------------------------------------------------------------------
#  Git shortcuts
# -----------------------------------------------------------------------------
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph'

# -----------------------------------------------------------------------------
#  Docker shortcuts
# -----------------------------------------------------------------------------
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dlog='docker logs -f'

# -----------------------------------------------------------------------------
#  System shortcuts
# -----------------------------------------------------------------------------
alias h='history'
alias c='clear'
alias reload='source ~/.zshrc'
alias grep='grep --color=auto'

# -----------------------------------------------------------------------------
#  Powerlevel10k prompt config
# -----------------------------------------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
