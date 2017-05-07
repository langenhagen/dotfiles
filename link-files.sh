#!/bin/sh

# links the essential  dotfiles for this specify device
# after removing existing files
#
# author: langenhagen
# version: 170507

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



