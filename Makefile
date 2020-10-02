kernel = $$(uname -s)
.PHONY: all dotfiles

all: dotfiles

dotfiles:
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".git" -not -name ".gitignore" -not -name ".gnupg"  -not -name ".ssh"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done;
	ln -sfn $(CURDIR)/$(kernel).gitignore $(HOME)/.gitignore;
