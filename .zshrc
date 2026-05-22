# Shell integrations
test -x /opt/homebrew/bin/brew && source <(/opt/homebrew/bin/brew shellenv zsh)
command -v fzf > /dev/null && source <(fzf --zsh)
command -v zoxide > /dev/null && source <(zoxide init --cmd cd zsh)

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::eza
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl

# Load completions
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit          # dump older than 24h -> full rebuild
else
  compinit -C       # otherwise skip the checks (fast path)
fi

zinit cdreplay -q

# Syntax highlighting (must be loaded last, after compinit/cdreplay)
zinit light zsh-users/zsh-syntax-highlighting

# Prompt
command -v oh-my-posh > /dev/null && eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
host=$(hostname -s)
mkdir -p ${HOME}/.cache/${host}/
HISTFILE=${HOME}/.cache/${host}/zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt interactivecomments

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Path
command -v go > /dev/null && export PATH=${GOPATH:-$HOME/go}/bin${PATH+:$PATH}

typeset -gU path

directories=(
  "${HOME}/Library/Application Support/JetBrains/Toolbox/scripts"
  "${HOME}/.cargo/bin"
  "${HOME}/.local/bin"
)

for dir in "${directories[@]}"; do
  if [ -d "$dir" ]; then
    path=("$dir" "${path[@]}")
  fi
done

# Aliases
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias grep="grep --color"
alias tree="eza -laF --git --group-directories-first --tree"
alias uuidgen='uuidgen | tr "[:upper:]" "[:lower:]"'
alias vi="nvim"
alias vim="nvim"
alias week="date +%V"
alias ts="date +%s"

test -f ${HOME}/.extra && source ${HOME}/.extra
