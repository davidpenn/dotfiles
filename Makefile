kernel = $$(uname -s)
.PHONY: all dotfiles

all: dotfiles

dotfiles:
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".git" -not -name ".gitignore" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	mkdir -p $(HOME)/.gnupg;
	ln -sfn $(CURDIR)/.gnupg/gpg.conf $(HOME)/.gnupg/gpg.conf;
	ln -sfn $(CURDIR)/.gnupg/$(kernel)-gpg-agent.conf $(HOME)/.gnupg/gpg-agent.conf;
	sudo chmod 600 $(HOME)/.gnupg/gpg.conf;
	sudo chmod 700 $(HOME)/.gnupg;
	ln -fn $(CURDIR)/gitignore $(HOME)/.gitignore;
