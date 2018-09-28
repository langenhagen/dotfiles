#!/bin/bash

# links dotfiles into the system
# after removing existing files and folders
#
# author: andreasl
# version: 18-09-27

dir_of_this_script="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dotfiles_path=$dir_of_this_script

rm "$HOME/.vimrc"
ln -s "$dotfiles_path/.vimrc" "$HOME/.vimrc"

rm -rf "$HOME/.vim"
ln -s "$dotfiles_path/.vim" "$HOME/.vim"

rm "$HOME/.config/fish/config.fish"
ln -s "$dotfiles_path/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
rm "$HOME/.config/fish/my-abbreviations.fish"
ln -s "$dotfiles_path/.config/fish/my-abbreviations.fish" "$HOME/.config/fish/my-abbreviations.fish"
rm "$HOME/.config/fish/my-environment-variables.fish"
ln -s "$dotfiles_path/.config/fish/my-environment-variables.fish" "$HOME/.config/fish/my-environment-variables.fish"
rm "$HOME/.config/fish/my-functions.fish"
ln -s "$dotfiles_path/.config/fish/my-functions.fish" "$HOME/.config/fish/my-functions.fish"
rm "$HOME/.config/fish/vimlike-bookmarks.fish"
ln -s "$dotfiles_path/.config/fish/vimlike-bookmarks.fish" "$HOME/.config/fish/vimlike-bookmarks.fish"

rm "$HOME/.tigrc"
ln -s "$dotfiles_path/.tigrc" "$HOME/.tigrc"

if [[ $(uname -n) == *'4demlangenha'* ]]; then
    rm "$HOME/.gitconfig"
    ln -s "$dotfiles_path/.gitconfig-mac-workmachine" "$HOME/.gitconfig"
elif [[ "$(uname -n)" =~ ('barn-ultra'|'bee') ]]; then
    rm "$HOME/.gitconfig"
    ln -s "$dotfiles_path/.gitconfig-barn" "$HOME/.gitconfig"
fi

rm "$HOME/.gitignore_global"
ln -s "$dotfiles_path/.gitignore_global" "$HOME/.gitignore_global"

rm "$HOME/.config/bpython/config"
mkdir -p "$HOME/.config/bpython"
ln  -s "$dotfiles_path/.config/bpython/config" "$HOME/.config/bpython/config"

rm "$HOME/.ccache/ccache.conf"
mkdir -p "$HOME/.ccache"
ln -s "$dotfiles_path/.ccache/ccache.conf" "$HOME/.ccache/ccache.conf"

mkdir -p "$HOME/.config/ranger"
rm "$HOME/.config/ranger/rc.conf"
ln -s "$dotfiles_path/.config/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"

if [ "$(uname)" == 'Darwin' ]; then
    sublime_installed_packages_dir="$HOME/Library/Application Support/Sublime Text 3/Installed Packages"
    rm -rf "$sublime_installed_packages_dir"
    ln -s "$dotfiles_path/sublimetext3-config/Installed Packages" "$sublime_installed_packages_dir"

    sublime_packages_dir="$HOME/Library/Application Support/Sublime Text 3/Packages"
    rm -rf "$sublime_packages_dir"
    ln -s "$dotfiles_path/sublimetext3-config/Packages" "$sublime_packages_dir"

    # set iterm2 config settings
    # specify the preferences directory
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$dotfiles_path/iterm2-config"
    # tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
fi
