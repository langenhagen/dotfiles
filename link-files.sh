#!/bin/sh

# links the essential  dotfiles for this specify device
# after removing existing files
#
# author: langenhagen
# version: 170721
DOTFILES_PATH="/Users/langenha/personal/Dev/Zeugs/dotfiles"

rm ~/.vimrc
ln -s $DOTFILES_PATH/.vimrc ~/.vimrc


rm ~/.config/fish/config.fish
ln  -s $DOTFILES_PATH/.config/fish/config.fish ~/.config/fish/config.fish


rm ~/.tigrc
ln  -s $DOTFILES_PATH/.tigrc ~/.tigrc


rm ~/.gitconfig
ln  -s $DOTFILES_PATH/.gitconfig ~/.gitconfig


rm ~/.gitignore_global
ln  -s $DOTFILES_PATH/.gitignore_global ~/.gitignore_global


rm ~/.config/bpython/config
ln  -s $DOTFILES_PATH/.config/bpython/config ~/.config/bpython/config


rm ~/.ccache/ccache.conf
ln  -s $DOTFILES_PATH/.ccache/ccache.conf ~/.ccache/ccache.conf


# set iterm2 config settings. The applicability has yet to be confirmed.
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$DOTFILES_PATH/iterm2-config"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true