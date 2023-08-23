# Add brew env after /etc/path.d/* has set the path from /etc/zprofile
test -x /opt/homebrew/bin/brew && source <(/opt/homebrew/bin/brew shellenv)

# Load the shell dotfiles, and then some
test -d ${HOME}/.config/zsh.d && source <(cat $HOME/.config/zsh.d/*.zsh)
