#!/usr/bin/env bash
set -e

if ! command -v brew &> /dev/null; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	if ! command -v brew &> /dev/null; then
		echo "Failed to install homebrew" >&2
		exit 1
	fi
fi

brew analytics off

brew update
brew upgrade

brew install direnv
brew install fd
brew install fzf
brew install ghq
brew install git
brew install git-delta
brew install jq
brew install neovim
brew install reattach-to-user-namespace
brew install ripgrep
brew install starship
brew install stow
brew install tmux
brew install tree
brew install wget
brew install zsh

# base16 colours
brew tap tinted-theming/tinted
brew install tinty

# node/npm
brew install fnm

brew install --cask 1password
brew install --cask iterm2
brew install --cask monodraw
brew install --cask raycast
brew install --cask slack
brew install --cask sonos
brew install --cask spotify
brew install --cask tableplus
brew install --cask visual-studio-code

# App Store
brew install mas
mas install 904280696  # Things 3
