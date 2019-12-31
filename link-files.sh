#!/bin/bash
# Forcefully links dotfiles into the system.
#
# author: andreasl

dir_of_this_script="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
dotfiles_path="${dir_of_this_script}";

ln -sf "$dotfiles_path/.vimrc" "$HOME/.vimrc";
ln -sf "$dotfiles_path/.vim" "$HOME";

ln -sf "$dotfiles_path/.gitignore_global" "$HOME/.gitignore_global";
ln -sf "$dotfiles_path/.gvimrc" "$HOME/.gvimrc";
ln -sf "$dotfiles_path/.multitailrc" "$HOME/.multitailrc";
ln -sf "$dotfiles_path/.tigrc" "$HOME/.tigrc";
ln -sf "$dotfiles_path/.tmux.conf" "$HOME/.tmux.conf";
ln -sf "$dotfiles_path/.zshrc" "$HOME/.zshrc";

if [[ "$(uname -n)" =~ 'barn-ultra' ]]; then
    ln -sf "$dotfiles_path/.gitconfig-barn" "$HOME/.gitconfig";
    ln -sf "$dotfiles_path/.edmrc-barn" "$HOME/.edmrc";
    rm "$HOME/.config/reposets"
    ln -sf "$dotfiles_path/.config/reposets-barn" "$HOME/.config/reposets";

elif [[ "$(uname -n)" =~ 'bee' ]]; then
    ln -sf "$dotfiles_path/.gitconfig-barn" "$HOME/.gitconfig";
    rm "$HOME/.config/reposets"
    ln -sf "$dotfiles_path/.config/reposets-bee" "$HOME/.config/reposets";

elif [[ "$(uname -n)" =~ 'celeraone' ]]; then
    ln -sf "$dotfiles_path/.edmrc-c1" "$HOME/.edmrc";
    ln -sf "$dotfiles_path/.gitconfig-c1" "$HOME/.gitconfig";
    rm "$HOME/.config/reposets"
    ln -sf "$dotfiles_path/.config/reposets-c1" "$HOME/.config/reposets";

    ln -sf "$dotfiles_path/.config/autostart/open-day-notes-file.desktop" "$HOME/.config/autostart/open-day-notes-file.desktop";
    ln -sf "$dotfiles_path/.config/autostart/slack.desktop" "$HOME/.config/autostart/slack.desktop";
fi

mkdir -p "$HOME/.buildout";
ln -sf "$dotfiles_path/.buildout/default.cfg" "$HOME/.buildout/default.cfg";

mkdir -p "$HOME/.ccache";
ln -sf "$dotfiles_path/.ccache/ccache.conf" "$HOME/.ccache/ccache.conf";

mkdir -p "$HOME/.config";
ln -sf "$dotfiles_path/.config/konsolerc" "$HOME/.config/konsolerc";
mkdir -p "$HOME/.local/share/konsole";
ln -sf "$dotfiles_path/.local/share/konsole/My-Konsole-Profile.profile" "$HOME/.local/share/konsole/My-Konsole-Profile.profile";

mkdir -p "$HOME/.config/autokey/data/"
ln -sf "$dotfiles_path/.config/autokey/data/My-Global-Phrases" "$HOME/.config/autokey/data/";
ln -sf "$dotfiles_path/.config/autokey/data/My-Global-Scripts" "$HOME/.config/autokey/data/";

mkdir -p "$HOME/.config/autostart";
ln -sf "$dotfiles_path/.config/autostart/caffeine-indicator.desktop" "$HOME/.config/autostart/caffeine-indicator.desktop";
ln -sf "$dotfiles_path/.config/autostart/dropbox.desktop" "$HOME/.config/autostart/dropbox.desktop";
ln -sf "$dotfiles_path/.config/autostart/nextcloud-client.desktop" "$HOME/.config/autostart/nextcloud-client.desktop";
ln -sf "$dotfiles_path/.config/autostart/thunderbird.desktop" "$HOME/.config/autostart/thunderbird.desktop";
ln -sf "$dotfiles_path/.config/autostart/ukuu.desktop" "$HOME/.config/autostart/ukuu.desktop";
ln -sf "$dotfiles_path/.config/autostart/urserver.desktop" "$HOME/.config/autostart/urserver.desktop";

mkdir -p "$HOME/.config/bpython";
ln  -sf "$dotfiles_path/.config/bpython/config" "$HOME/.config/bpython/config";
ln  -sf "$dotfiles_path/.config/bpython/my.theme" "$HOME/.config/bpython/my.theme";

mkdir -p "$HOME/.config/fish/";
ln -sf "$dotfiles_path/.config/fish/config.fish" "$HOME/.config/fish/config.fish";
ln -sf "$dotfiles_path/.config/fish/abbreviations.fish" "$HOME/.config/fish/abbreviations.fish";
ln -sf "$dotfiles_path/.config/fish/aliases.fish" "$HOME/.config/fish/aliases.fish";
ln -sf "$dotfiles_path/.config/fish/environment-variables.fish" "$HOME/.config/fish/environment-variables.fish";
ln -sf "$dotfiles_path/.config/fish/functions.fish" "$HOME/.config/fish/functions.fish";
ln -sf "$dotfiles_path/.config/fish/key-bindings.fish" "$HOME/.config/fish/key-bindings.fish";
ln -sf "$dotfiles_path/.config/fish/vimlike-bookmarks.fish" "$HOME/.config/fish/vimlike-bookmarks.fish";

mkdir -p "$HOME/.config/ranger";
ln -sf "$dotfiles_path/.config/ranger/rc.conf" "$HOME/.config/ranger/rc.conf";
ln -sf "$dotfiles_path/.config/ranger/scope.sh" "$HOME/.config/ranger/scope.sh";
mkdir -p "$HOME/.config/ranger/colorschemes";
ln -sf "$dotfiles_path/.config/ranger/colorschemes/mydefault.py" "$HOME/.config/ranger/colorschemes/mydefault.py";

mkdir -p "$HOME/.config/xpad";
ln -sf "$dotfiles_path/.config/xpad/default-style" "$HOME/.config/xpad/default-style";
mkdir -p "$HOME/.config/xpad/trigger";
ln -sf "$dotfiles_path/.config/xpad/trigger/GEORGIAN-trigger.sh" "$HOME/.config/xpad/trigger/GEORGIAN-trigger.sh";

mkdir -p "$HOME/.urserver/remotes";
ln -sf "$dotfiles_path/.urserver/remotes/custom" "$HOME/.urserver/remotes/";

if [ "$(uname)" == 'Linux' ]; then
    mkdir -p "$HOME/.config/sublime-text-3";
    ln -sf "$dotfiles_path/.config/sublime-text-3/Packages" "$HOME/.config/sublime-text-3/";

elif [ "$(uname)" == 'Darwin' ]; then
    mkdir -p "$HOME/.config/sublime-text-3";
    ln -sf "$dotfiles_path/.config/sublime-text-3/Packages" "$HOME/Library/Application Support/Sublime Text 3/";

    # set iterm2 config settings
    # specify the preferences directory
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$dotfiles_path/iterm2-config";
    # tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true;
fi
