# Zsh always executes zshenv. Then, depending on the case:
# - run as a login shell, it executes zprofile;
# - run as an interactive, it executes zshrc;
# - run as a login shell, it executes zlogin.
#
# At the end of a login session, it executes zlogout, but in reverse order, the
# user-specific file first, then the system-wide one, constituting a chiasmus
# with the zlogin files.

typeset -gU cdpath

cdpath=(
  ${HOME}
  ${HOME}/src
  ${HOME}/src/github.com
  ${HOME}/src/github.com/davidpenn
  ${HOME}/src/github.com/securityscorecard
  $cdpath
)
