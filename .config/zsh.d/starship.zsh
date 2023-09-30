test "${TERM_PROGRAM}" != "WarpTerminal" \
  && command -v starship > /dev/null && source <(starship init zsh)
