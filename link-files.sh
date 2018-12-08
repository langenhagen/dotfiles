#!/bin/bash

# links dotfiles into the system
# after removing existing files and folders.
#
# author: andreasl
# version: 18-11-03

dir_of_this_script="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dotfiles_path="${dir_of_this_script}"

rm "$HOME/.vimrc"
ln -s "$dotfiles_path/.vimrc" "$HOME/.vimrc"

rm "$HOME/.tmux.conf"
ln -s "$dotfiles_path/.tmux.conf" "$HOME/.tmux.conf"

rm -rf "$HOME/.vim"
ln -s "$dotfiles_path/.vim" "$HOME/.vim"

rm "$HOME/.config/konsolerc"
mkdir -p "$HOME/.config"
ln -s "$dotfiles_path/.config/konsolerc" "$HOME/.config/konsolerc"
rm "$HOME/.local/share/konsole/My-Konsole-Profile.profile"
mkdir -p "$HOME/.local/share/konsole"
ln -s "$dotfiles_path/.local/share/konsole/My-Konsole-Profile.profile" "$HOME/.local/share/konsole/My-Konsole-Profile.profile"

rm "$HOME/.config/fish/config.fish"
ln -s "$dotfiles_path/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
rm "$HOME/.config/fish/abbreviations.fish"
ln -s "$dotfiles_path/.config/fish/abbreviations.fish" "$HOME/.config/fish/abbreviations.fish"
rm "$HOME/.config/fish/environment-variables.fish"
ln -s "$dotfiles_path/.config/fish/environment-variables.fish" "$HOME/.config/fish/environment-variables.fish"
rm "$HOME/.config/fish/functions.fish"
ln -s "$dotfiles_path/.config/fish/functions.fish" "$HOME/.config/fish/functions.fish"
rm "$HOME/.config/fish/vimlike-bookmarks.fish"
ln -s "$dotfiles_path/.config/fish/vimlike-bookmarks.fish" "$HOME/.config/fish/vimlike-bookmarks.fish"

rm "$HOME/.tigrc"
ln -s "$dotfiles_path/.tigrc" "$HOME/.tigrc"

if [[ "$(uname -n)" =~ ('barn-ultra'|'bee') ]]; then
    rm "$HOME/.gitconfig"
    ln -s "$dotfiles_path/.gitconfig-barn" "$HOME/.gitconfig"
    rm "$HOME/.edmrc"
    ln -s "$dotfiles_path/.edmrc-barn" "$HOME/.edmrc"
elif [[ "$(uname -n)" =~ 'celeraone' ]]; then
    rm "$HOME/.gitconfig"
    ln -s "$dotfiles_path/.gitconfig-c1" "$HOME/.gitconfig"
    rm "$HOME/.edmrc"
    ln -s "$dotfiles_path/.edmrc-c1" "$HOME/.edmrc"
fi

rm "$HOME/.gitignore_global"
ln -s "$dotfiles_path/.gitignore_global" "$HOME/.gitignore_global"

rm "$HOME/.multitailrc"
ln -s "$dotfiles_path/.multitailrc" "$HOME/.multitailrc"

rm "$HOME/.config/bpython/config"
mkdir -p "$HOME/.config/bpython"
ln  -s "$dotfiles_path/.config/bpython/config" "$HOME/.config/bpython/config"

rm "$HOME/.ccache/ccache.conf"
mkdir -p "$HOME/.ccache"
ln -s "$dotfiles_path/.ccache/ccache.conf" "$HOME/.ccache/ccache.conf"

rm "$HOME/.config/ranger/rc.conf"
mkdir -p "$HOME/.config/ranger"
ln -s "$dotfiles_path/.config/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"

rm -rf "$HOME/.urserver/remotes/custom"
mkdir -p "$HOME/.urserver/remotes"
ln -s "$dotfiles_path/.urserver/remotes/custom" "$HOME/.urserver/remotes/"

rm -rf "$HOME/.config/xpad/default-style"
mkdir -p "$HOME/.config/xpad"
ln -s "$dotfiles_path/.config/xpad/default-style" "$HOME/.config/xpad/default-style"

rm "$HOME/.buildout/default.cfg"
mkdir -p "$HOME/.buildout"
ln -s "$dotfiles_path/.buildout/default.cfg" "$HOME/.buildout/default.cfg"

if [ "$(uname)" == 'Linux' ]; then
    rm -rf "$HOME/.config/sublime-text-3/Packages"
    mkdir -p "$HOME/.config/sublime-text-3"
    ln -s "$dotfiles_path/.config/sublime-text-3/Packages" "$HOME/.config/sublime-text-3/"

elif [ "$(uname)" == 'Darwin' ]; then
    rm -rf "$HOME/Library/Application Support/Sublime Text 3/Packages"
    mkdir -p "$HOME/.config/sublime-text-3"
    ln -s "$dotfiles_path/.config/sublime-text-3/Packages" "$HOME/Library/Application Support/Sublime Text 3/"

    # set iterm2 config settings
    # specify the preferences directory
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$dotfiles_path/iterm2-config"
    # tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
fi
