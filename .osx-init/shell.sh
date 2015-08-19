#!/usr/bin/env bash
RUBY_VERSION="2.2.2"

set -e

if ! hash ffmpeg 2> /dev/null; then
  brew install ffmpeg --with-faac --with-fdk-aac
fi

if ! hash rbenv 2> /dev/null; then
  brew install rbenv ruby-build
fi

if ! rbenv version | grep ${RUBY_VERSION} > /dev/null; then
  rbenv install ${RUBY_VERSION}
fi

rbenv global ${RUBY_VERSION}
rbenv rehash

sudo dscl . append /Groups/wheel GroupMembership ${USER}
# sed -i '' -e '/^%admin/s/^/# /g'
sudo sed -i '' -e '/# %wheel	ALL=(ALL) NOPASSWD: ALL/s/^# //g' /etc/sudoers

brew install bash \
  bash-completion \
  brew-cask \
  docker \
  docker-machine \
  go \
  media-info \
  ssh-copy-id \
  tree \
  unrar \
  wget

#
# sudo bash -c 'echo $(which bash) >> /etc/shells'
# chsh -s $(which bash)
