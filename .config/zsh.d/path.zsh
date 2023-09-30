command -v go > /dev/null && export PATH=$(go env GOPATH)/bin${PATH+:$PATH}

typeset -gU path

path=(
  ${HOME}/.local/bin
  "${HOME}/Library/Application Support/JetBrains/Toolbox/scripts"
  $path
)
