kernel = $$(uname -s)
.PHONY: all dotfiles

all: dotfiles

dotfiles:
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".git" -not -name ".gitignore" -not -name ".gnupg"  -not -name ".ssh"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	mkdir -p $(HOME)/.gnupg;
	ln -sfn $(CURDIR)/.gnupg/gpg.conf $(HOME)/.gnupg/gpg.conf;
	ln -sfn $(CURDIR)/.gnupg/$(kernel)-gpg-agent.conf $(HOME)/.gnupg/gpg-agent.conf;
	chmod 600 $(HOME)/.gnupg/gpg.conf;
	chmod 700 $(HOME)/.gnupg;
	ln -sfn $(CURDIR)/$(kernel).gitignore $(HOME)/.gitignore;
	mkdir -p $(HOME)/.ssh;
	ln -sfn $(CURDIR)/.ssh/config $(HOME)/.ssh/config;
	chmod 700 $(HOME)/.ssh;