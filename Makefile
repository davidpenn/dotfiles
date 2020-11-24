kernel = $$(uname -s)
.PHONY: all dotfiles

all: dotfiles

dotfiles:
	for file in $(shell find $(CURDIR) -maxdepth 1 -name ".*" -not -name ".git" -not -name ".gitignore" -not -name ".gitmodules"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done;
	ln -sfn $(CURDIR)/$(kernel).gitignore $(HOME)/.gitignore;
