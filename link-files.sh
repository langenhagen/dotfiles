#!/bin/sh

# links the essential  dotfiles for this specify device
# after removing existing files
#
# author: langenhagen
# version: 170721

DIR_OF_THIS_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_PATH=$DIR_OF_THIS_SCRIPT

rm ~/.vimrc
ln -s $DOTFILES_PATH/.vimrc ~/.vimrc


rm ~/.config/fish/config.fish
ln -s $DOTFILES_PATH/.config/fish/config.fish ~/.config/fish/config.fish


rm ~/.tigrc
ln -s $DOTFILES_PATH/.tigrc ~/.tigrc


rm ~/.gitconfig
ln -s $DOTFILES_PATH/.gitconfig ~/.gitconfig


rm ~/.gitignore_global
ln -s $DOTFILES_PATH/.gitignore_global ~/.gitignore_global


rm ~/.config/bpython/config
ln  -s $DOTFILES_PATH/.config/bpython/config ~/.config/bpython/config

rm ~/.ccache/ccache.conf
ln -s $DOTFILES_PATH/.ccache/ccache.conf ~/.ccache/ccache.conf


# filezilla. Can initially be a real folder, thus we rm `-rf` it.
# Later it can be a symlink, there we need the `rm` statement without commands.

FILEZILLA_CONFIG_DIR=~/.config/filezilla
if [ ! -L "$"FILEZILLA_CONFIG_DIR ] && [ -d "$FILEZILLA_CONFIG_DIR" ]; then
    # filezilla dir is a real directory
    rm -rf "$FILEZILLA_CONFIG_DIR"
elif [ -L "$FILEZILLA_CONFIG_DIR" ];  then
	#  filezilla dir is a symlink
    rm "$FILEZILLA_CONFIG_DIR"
fi
ln -s $DOTFILES_PATH/.config/filezilla "$FILEZILLA_CONFIG_DIR"


# sublime text. The folders that we want to overwrite are either a real folder or,
# if we linked the files before, we want to overwrite the symlinks.
# For real folders we need `rm -rf`, for symlinks we need just `rm`

SUBLIME_INSTALLED_PACKAGES_DIR=~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
if [ ! -L "$SUBLIME_INSTALLED_PACKAGES_DIR" ] && [ -d "$SUBLIME_INSTALLED_PACKAGES_DIR" ]; then
    # sublime installed packages dir is a real directory
    rm -rf "$SUBLIME_INSTALLED_PACKAGES_DIR"
elif [ -L "$SUBLIME_INSTALLED_PACKAGES_DIR" ];  then
	# sublime installed packages dir is a symlink
    rm "$SUBLIME_INSTALLED_PACKAGES_DIR"
fi
ln -s "$DOTFILES_PATH/sublimetext3-config/Installed Packages" "$SUBLIME_INSTALLED_PACKAGES_DIR"

SUBLIME_PACKAGES_DIR=~/Library/Application\ Support/Sublime\ Text\ 3/Packages
if [ ! -L "$SUBLIME_PACKAGES_DIR" ] && [ -d "$SUBLIME_PACKAGES_DIR" ]; then
	# sublime packages dir is a real directory
    rm -rf "$SUBLIME_PACKAGES_DIR"
elif [ -L "$SUBLIME_PACKAGES_DIR" ]; then
	# sublime packages dir is a symlink
    rm "$SUBLIME_PACKAGES_DIR"
fi
ln -s "$DOTFILES_PATH/sublimetext3-config/Packages" "$SUBLIME_PACKAGES_DIR"


# set iterm2 config settings. The applicability has yet to be confirmed.
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$DOTFILES_PATH/iterm2-config"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
