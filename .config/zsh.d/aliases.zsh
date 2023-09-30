# Shortcuts
alias k="kubectl"
alias h="helm"
alias tf="terraform"
alias a="ansible"
alias g="git"

# replace ls with eza
alias la="eza -laF --git --group-directories-first"
alias ll="eza -lF --git --group-directories-first"
alias ls="eza -F --group-directories-first"
alias lsd="eza -lFD --git"

# ip info
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"

# other aliases
alias grep="grep --color"
alias tree="eza -laF --git --group-directories-first --tree"
alias uuidgen='uuidgen | tr "[:upper:]" "[:lower:]"'
alias vi="nvim"
alias vim="nvim"
alias week="date +%V"
