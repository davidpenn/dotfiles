autoload -Uz compinit && compinit -i

# Enable approximate completions
zstyle ':completion:*' completer _complete _ignored _correct _approximate

# Use menu completion
zstyle ':completion:*' menu select

# Verbose completion results
zstyle ':completion:*' verbose true

# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'

# Pretty messages during pagination
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Nicer format for completion messages
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'

# Use ls-colors for path completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

command -v kubectl > /dev/null && source <(kubectl completion zsh)
