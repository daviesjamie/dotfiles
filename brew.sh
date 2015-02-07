#!/bin/sh

# Install homebrew if it isn't already installed
if ! hash brew 2> /dev/null; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Use latest package definitions
brew update

# Upgrade old packages (if any)
brew upgrade

# Install essential homebrews
brew install fish --HEAD
brew install hub
brew install macvim --with-lua --custom-icons --override-system-vim --HEAD
brew install python
brew install ruby
brew install ssh-copy-id
brew install the_silver_searcher
brew install tree
brew install wget

# Install essential casks
brew install caskroom/cask/brew-cask
brew cask install caffeine
brew cask install dropbox
brew cask install flux
brew cask install google-chrome
brew cask install hazel
brew cask install kaleidoscope
brew cask install mplayerx
brew cask install skype
brew cask install spotify
brew cask install steam
brew cask install the-unarchiver
brew cask install torbrowser
brew cask install trim-enabler
brew cask install utorrent
brew cask install mactex

# Remove outdated versions from the Cellar
brew cleanup

# Link .app files into /Applications
brew linkapps
