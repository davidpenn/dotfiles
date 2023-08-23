# Command configuration (https://zsh.sourceforge.io/Doc/Release/Options.html)
HISTFILE=~/.cache/zsh_history
HISTSIZE=50000000
SAVEHIST=50000000
# zsh sessions will append their history list to the history file, rather than replace it.
setopt append_history
# Save each command’s beginning timestamp and the duration to the history file.
setopt extended_history
# If the internal history needs to be trimmed to add the current command line,
# setting this option will cause the oldest history event that has a duplicate
# to be lost before losing a unique event from the list.
setopt hist_expire_dups_first
# Do not enter command lines into the history list if they are duplicates of the previous event.
setopt hist_ignore_dups
# If a new command line being added to the history list duplicates an older one,
# the older command is removed from the list (even if it is not the previous event).
setopt hist_ignore_all_dups
# Remove superfluous blanks from each command line being added to the history list.
setopt hist_reduce_blanks
# Remove command lines from the history list when the first character on the
# line is a space, or when one of the expanded aliases contains a leading space.
setopt hist_ignore_space
# Remove the history (fc -l) command from the history list when invoked.
setopt hist_no_store
# Whenever the user enters a line with history expansion, don’t execute the
# line directly; instead, perform history expansion and reload the line into
# the editing buffer.
setopt hist_verify
# his option works like APPEND_HISTORY except that new history lines are added
# to the $HISTFILE incrementally (as soon as they are entered)
setopt inc_append_history
unsetopt share_history
# Allow comments even in interactive shells.
setopt interactive_comments
