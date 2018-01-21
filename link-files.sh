#!/bin/sh

# links the essential  dotfiles for this specify device
# after removing existing files
#
# author: langenhagen
# version: 171016

DIR_OF_THIS_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_PATH=$DIR_OF_THIS_SCRIPT

rm ~/.vimrc
ln -s $DOTFILES_PATH/.vimrc ~/.vimrc


rm ~/.config/fish/config.fish
ln -s $DOTFILES_PATH/.config/fish/config.fish ~/.config/fish/config.fish

rm ~/.config/fish/my-abbreviations.fish
ln -s $DOTFILES_PATH/.config/fish/my-abbreviations.fish ~/.config/fish/my-abbreviations.fish

rm ~/.config/fish/my-environment-variables.fish
ln -s $DOTFILES_PATH/.config/fish/my-environment-variables.fish ~/.config/fish/my-environment-variables.fish

rm ~/.config/fish/my-functions.fish
ln -s $DOTFILES_PATH/.config/fish/my-functions.fish ~/.config/fish/my-functions.fish


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
