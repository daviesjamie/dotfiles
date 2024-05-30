#!/usr/bin/env bash
set -e

BREW=/opt/homebrew/bin/brew

if ! command -v $BREW &> /dev/null
then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

$BREW analytics off

$BREW update
$BREW upgrade

$BREW install direnv
$BREW install fzf
$BREW install ghq
$BREW install git
$BREW install git-delta
$BREW install jq
$BREW install neovim
$BREW install reattach-to-user-namespace
$BREW install ripgrep
$BREW install starship
$BREW install stow
$BREW install tmux
$BREW install tree
$BREW install wget
$BREW install zsh

# base16 colours
$BREW tap tinted-theming/tinted
$BREW install tinty

# node/npm
$BREW install fnm

$BREW install --cask 1password
$BREW install --cask iterm2
$BREW install --cask monodraw
$BREW install --cask raycast
$BREW install --cask slack
$BREW install --cask sonos
$BREW install --cask spotify
$BREW install --cask tableplus
$BREW install --cask visual-studio-code
