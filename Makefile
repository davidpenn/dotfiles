.PHONY: all default install dotfiles

all: dotfiles

default: install

install: all

dotfiles:
	# https://raw.githubusercontent.com/github/gitignore/master/Global/OSX.gitignore
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git"  -not -name ".DS_Store" -not -name ".*.swp" -maxdepth 1); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done
