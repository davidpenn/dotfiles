install:
  stow -t $HOME .

uninstall:
  stow -t $HOME -D .

defaults:
  ./.config/macos/defaults.sh
