#!/bin/sh

# links the essential  dotfiles for this specify device
# after removing existing files
#
# author: langenhagen
# version: 170507

rm ~/.vimrc
ln -s /home/pi/dotfiles/.vimrc ~/.vimrc


rm ~/.config/fish/config.fish
ln  -s /Users/langenha/personal/Dev/Zeugs/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish


rm ~/.tigrc
ln  -s /Users/langenha/personal/Dev/Zeugs/dotfiles/.tigrc ~/.tigrc


rm ~/.gitconfig
ln  -s /Users/langenha/personal/Dev/Zeugs/dotfiles/.gitconfig ~/.gitconfig


rm ~/.gitignore_global
ln  -s /Users/langenha/personal/Dev/Zeugs/dotfiles/.gitignore_global ~/.gitignore_global


rm ~/.config/bpython/config
ln  -s /Users/langenha/personal/Dev/Zeugs/dotfiles/.config/bpython/config ~/.config/bpython/config


rm ~/.ccache/ccache.conf
ln  -s /Users/langenha/personal/Dev/Zeugs/dotfiles/.ccache/ccache.conf ~/.ccache/ccache.conf



