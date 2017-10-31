#!/bin/bash
set -e

base_min() {
	setup_sudo

	if [[ ! -x /usr/local/bin/brew ]]; then
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	brew install \
	 bash bash-completion \
	 glide \
	 go \
	 gpg gpg2 gpg-agent pinentry-mac \
	 mas \
	 mtr \
	 node \
	 ssh-copy-id \
	 tree \
	 vault \
	 yarn

	setup_bash
	setup_computername
}

base() {
	base_min;

	brew cask install --appdir=/Applications \
	 1password \
	 android-studio \
	 atom \
	 datagrip \
	 docker \
	 caskroom/fonts/font-hack \
	 google-chrome \
	 java \
	 keepingyouawake \
	 slack \
	 spectacle \
	 visual-studio-code \
	 vlc
}

check_xcode() {
	if ! [ -f /Library/Developer/CommandLineTools/usr/bin/git ]; then
		/usr/bin/xcode-select --install
	fi

	while [ ! -f /Library/Developer/CommandLineTools/usr/bin/git ]; do
		sleep 5
	done
}

setup_addressbook() {
	# Show first name before last name
	defaults write com.apple.addressbook ABNameDisplay -int 0

	# Sort by First name
	defaults write com.apple.addressbook ABNameSortingFormat -string "sortingFirstName sortingLastName"

	# Show Nickname, JobTitle, Department
	defaults write com.apple.addressbook ABNicknameVisible -int 1
	defaults write com.apple.addressbook ABJobTitleVisible -int 1
	defaults write com.apple.addressbook ABDepartmentVisible -int 1

	# Show Related Names, Birthday and other dates on templates
	defaults write com.apple.addressbook ABBirthDayVisible -int 1
	defaults write com.apple.addressbook ABDatesVisible -int 1
	defaults write com.apple.addressbook ABRelatedRecordsVisible -int 1
	defaults write com.apple.addressbook ABSocialProfilesVisible -bool true
}

setup_bash() {
	if ! grep -q "/usr/local/bin/bash" /etc/shells ; then
		echo "/usr/local/bin/bash" | sudo tee -a /etc/shells > /dev/null
	fi

	if [[ "$(dscl . -read /Users/$USER UserShell)" != "UserShell: /usr/local/bin/bash" ]]; then
		chsh -s /usr/local/bin/bash
	fi
}

setup_clock() {
	defaults write com.apple.menuextra.clock DateFormat -string "EEE HH:mm"
	defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
	defaults write com.apple.menuextra.clock IsAnalog -bool true
}

setup_computername() {
	read -p "Set Hostname (default: $(hostname)): " name
	if ! [ -z "${name}" ]; then
		sudo scutil --set ComputerName "${name}"
		sudo scutil --set HostName "${name}"
		sudo scutil --set LocalHostName "${name}"
		sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${name}"
	fi
}

setup_dock() {
	# Use dark menu bar and Dock
	defaults write NSGlobalDomain AppleInterfaceStyle Dark

	# Wipe all (default) app icons from the Dock
	defaults write com.apple.dock persistent-apps -array

	# Position on screen
	defaults write com.apple.dock orientation left

	# Dock icon size
	defaults write com.apple.dock tilesize -int 36

	# Change minimize/maximize window effect
	defaults write com.apple.dock mineffect -string "scale"

	# Minimize windows into their application’s icon
	defaults write com.apple.dock minimize-to-application -bool true

	# Show indicator lights for open applications in the Dock
	defaults write com.apple.dock show-process-indicators -bool true

	# Don’t animate opening applications from the Dock
	defaults write com.apple.dock launchanim -bool false

	# Speed up Mission Control animations
	defaults write com.apple.dock expose-animation-duration -float 0.1

	# Remove the auto-hiding Dock delay
	defaults write com.apple.dock autohide-delay -float 0

	# Remove the animation when hiding/showing the Dock
	defaults write com.apple.dock autohide-time-modifier -float 0

	# Automatically hide and show the Dock
	defaults write com.apple.dock autohide -bool true

	# Make Dock icons of hidden applications translucent
	defaults write com.apple.dock showhidden -bool true

	# Hot corners
	# Possible values:
	#  0: no-op
	#  2: Mission Control
	#  3: Show application windows
	#  4: Desktop
	#  5: Start screen saver
	#  6: Disable screen saver
	#  7: Dashboard
	# 10: Put display to sleep
	# 11: Launchpad
	# 12: Notification Center

	# Top left screen corner → Mission Control
	defaults write com.apple.dock wvous-tl-corner -int 2
	defaults write com.apple.dock wvous-tl-modifier -int 262144

	# Top right screen corner → Desktop
	defaults write com.apple.dock wvous-tr-corner -int 4
	defaults write com.apple.dock wvous-tr-modifier -int 262144

	# Bottom left screen corner → Put display to sleep
	defaults write com.apple.dock wvous-bl-corner -int 10
	defaults write com.apple.dock wvous-bl-modifier -int 262144

	# Bottom right screen corner → Show application windows
	defaults write com.apple.dock wvous-br-corner -int 3
	defaults write com.apple.dock wvous-br-modifier -int 262144
}

setup_finder() {
	# Show icons for hard drives, servers, and removable media on the desktop
	defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
	defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
	defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
	defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

	defaults write com.apple.finder QuitMenuItem -bool true
	defaults write com.apple.finder NewWindowTarget -string "PfHm"
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
	defaults write com.apple.finder WarnOnEmptyTrash -bool false
	defaults write com.apple.finder EmptyTrashSecurely -bool true
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

	# Desktop view
	/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
	/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist
	/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
	/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

	# Use list view in all Finder windows by default
	# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
	defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

	# Enable AirDrop over Ethernet and on unsupported Macs running Lion
	defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

	# Show the ~/Library folder
	chflags nohidden ~/Library

	# Expand the following File Info panes:
	defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Preview -bool false \
	Privileges -bool true
}

setup_input() {
	# Mouse: enable right click on apple mouse
	defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton

	# Trackpad: enable tap to click for this user and for the login screen
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
	defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
	defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

	# Enable Lookup & data detectors
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 2

	# Enable App Expose
	defaults write com.apple.dock showAppExposeGestureEnabled -bool true

	# Keyboard:
	# Enable full keyboard access for all controls
	# (e.g. enable Tab in modal dialogs)
	defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

	# Disable press-and-hold for keys in favor of key repeat
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

	# Set a blazingly fast keyboard repeat rate
	defaults write NSGlobalDomain KeyRepeat -int 2
	defaults write NSGlobalDomain InitialKeyRepeat -int 15
}

setup_screen() {
	defaults write com.apple.screensaver askForPassword -int 1
	defaults write com.apple.screensaver askForPasswordDelay -int 0

	defaults write com.apple.screencapture location -string "${HOME}/Downloads"
	defaults write com.apple.screencapture type -string "png"
	defaults write com.apple.screencapture disable-shadow -bool true
}

setup_sudo() {
	if ! id -nG "$USER" | grep -qw "wheel" ; then
		sudo dscl . append /Groups/wheel GroupMembership $USER
	fi

	if [[ ! -f /private/etc/sudoers.d/wheel_nopasswd ]]; then
		echo "%wheel ALL=(ALL) NOPASSWD: ALL" | sudo tee /private/etc/sudoers.d/wheel_nopasswd > /dev/null
	fi
}

setup_timemachine() {
	# Prevent Time Machine from prompting to use new hard drives as backup volume
	defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

	# Disable local Time Machine backups
	# hash tmutil &> /dev/null && sudo tmutil disablelocal
}

usage() {
	echo -e "setup-macOS.sh\n\tThis script installs my basic setup for macOS\n"
	echo "Usage:"
	echo "  all                      - base, basemin, defaults"
	echo "  base                     - install base pkgs"
	echo "  basemin                  - install base min pkgs"
	echo "  defaults                 - write default settings"
}

main() {
	local cmd=$1

	if [[ -z "$cmd" ]]; then
		usage
		exit 1
	fi

	if [[ $cmd == "base" ]]; then
		check_xcode
		base
	elif [[ $cmd == "basemin" ]]; then
		check_xcode
		base_min
	elif [[ $cmd == "defaults" ]]; then
		setup_addressbook
		setup_clock
		setup_dock
		setup_finder
		setup_input
		setup_screen
		setup_timemachine
	elif [[ $cmd == "all" ]]; then
		check_xcode
		base # runs basemin
		setup_addressbook
		setup_clock
		setup_dock
		setup_finder
		setup_input
		setup_screen
		setup_timemachine
	else
		usage
	fi
}

main "$@"
