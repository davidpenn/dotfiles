# dotfiles

dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Files are symlinked into `$HOME`, with configs following the XDG `~/.config` layout.

## New machine setup

### 1. Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

This also installs the Xcode Command Line Tools (which provide `git`). Load `brew` into the current shell session:

```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. Clone this repo

Clone over HTTPS — SSH isn't set up yet on a fresh machine:

```sh
mkdir ~/src/github.com/davidpenn/
git clone https://github.com/davidpenn/dotfiles.git ~/src/github.com/davidpenn/dotfiles
cd ~/src/github.com/davidpenn/dotfiles
```

### 3. Install packages

```sh
brew bundle --file .config/homebrew/Brewfile
```

Installs everything in the Brewfile, including `stow` and `just`.

### 4. Symlink the dotfiles

```sh
just install
```

Equivalent to `stow -t $HOME .`. Start a new shell to pick up `~/.zshrc`; `zinit` and its plugins install themselves on first launch.

### 5. Apply macOS defaults

```sh
just defaults
```

Runs `.config/macos/defaults.sh`, setting global, Dock, and keyboard defaults and rebuilding the Dock (installs `dockutil` if it's missing).

### 6. Reboot

```sh
sudo reboot
```

## Managing dotfiles

| Command | Action |
| --- | --- |
| `just install` | Symlink dotfiles into `$HOME` |
| `just uninstall` | Remove the symlinks |
| `just defaults` | Apply macOS system defaults |
| `brew bundle --file .config/homebrew/Brewfile` | Sync Homebrew packages |

## Notes

- Once the dotfiles are installed, git rewrites `https://github.com/` remotes to SSH and signs commits via the 1Password SSH agent — set up 1Password and your SSH key before pushing.
