#!/usr/bin/env bash
# Forcefully links dotfiles into the system.
#
# author: andreasl

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dotfiles_dir="${script_dir}"

ln -sf "$dotfiles_dir/.vimrc" "$HOME/.vimrc"
ln -sf "$dotfiles_dir/.vim" "$HOME"

ln -sf "$dotfiles_dir/.gitignore_global" "$HOME/.gitignore_global"
ln -sf "$dotfiles_dir/.gitconfig" "$HOME/.gitconfig"
ln -sf "$dotfiles_dir/.gvimrc" "$HOME/.gvimrc"
ln -sf "$dotfiles_dir/.multitailrc" "$HOME/.multitailrc"
ln -sf "$dotfiles_dir/.sqliterc" "$HOME/.sqliterc"
ln -sf "$dotfiles_dir/.tigrc" "$HOME/.tigrc"
ln -sf "$dotfiles_dir/.tmux.conf" "$HOME/.tmux.conf"

mkdir -p "$HOME/.ccache"
ln -sf "$dotfiles_dir/.ccache/ccache.conf" "$HOME/.ccache/ccache.conf"

mkdir -p "$HOME/.config"
ln -sf "$dotfiles_dir/.config/mimeapps.list" "$HOME/.config/mimeapps.list"
ln -sf "$dotfiles_dir/.config/user-dirs.dirs" "$HOME/.config/user-dirs.dirs"
ln -sf "$dotfiles_dir/.config/user-dirs.locale" "$HOME/.config/user-dirs.locale"

mkdir -p "$HOME/.config/alacritty"
ln -sf "$dotfiles_dir/.config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

mkdir -p "$HOME/.config/autostart"
ln -sf "$dotfiles_dir/.config/autostart/caffeine-indicator.desktop" "$HOME/.config/autostart/caffeine-indicator.desktop"
ln -sf "$dotfiles_dir/.config/autostart/chatgpt.desktop" "$HOME/.config/autostart/chatgpt.desktop"
ln -sf "$dotfiles_dir/.config/autostart/dropbox.desktop" "$HOME/.config/autostart/dropbox.desktop"
ln -sf "$dotfiles_dir/.config/autostart/thunderbird.desktop" "$HOME/.config/autostart/thunderbird.desktop"
ln -sf "$dotfiles_dir/.config/autostart/urserver.desktop" "$HOME/.config/autostart/urserver.desktop"
ln -sf "$dotfiles_dir/.config/autostart/xpad.desktop" "$HOME/.config/autostart/xpad.desktop"

mkdir -p "$HOME/.config/bpython"
ln -sf "$dotfiles_dir/.config/bpython/config" "$HOME/.config/bpython/config"
ln -sf "$dotfiles_dir/.config/bpython/my.theme" "$HOME/.config/bpython/my.theme"

mkdir -p "$HOME/.config/Code/User"
ln -sf "$dotfiles_dir/.config/Code/User/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
ln -sf "$dotfiles_dir/.config/Code/User/settings.json" "$HOME/.config/Code/User/settings.json"
mkdir -p "$HOME/.config/Code/User/snippets"
ln -sf "$dotfiles_dir/.config/Code/User/snippets/barns-snippets.code-snippets" "$HOME/.config/Code/User/snippets/barns-snippets.code-snippets"

mkdir -p "$HOME/.config/feh"
ln -sf "$dotfiles_dir/.config/feh/keys" "$HOME/.config/feh/keys"

mkdir -p "$HOME/.config/fish"
ln -sf "$dotfiles_dir/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
ln -sf "$dotfiles_dir/.config/fish/abbreviations.fish" "$HOME/.config/fish/abbreviations.fish"
ln -sf "$dotfiles_dir/.config/fish/aliases.fish" "$HOME/.config/fish/aliases.fish"
ln -sf "$dotfiles_dir/.config/fish/environment-variables.fish" "$HOME/.config/fish/environment-variables.fish"
ln -sf "$dotfiles_dir/.config/fish/functions.fish" "$HOME/.config/fish/functions.fish"
ln -sf "$dotfiles_dir/.config/fish/key-bindings.fish" "$HOME/.config/fish/key-bindings.fish"
ln -sf "$dotfiles_dir/.config/fish/vimlike-bookmarks.fish" "$HOME/.config/fish/vimlike-bookmarks.fish"
ln -sf "$dotfiles_dir/.config/fish/completions/aws.fish" "$HOME/.config/fish/completions/aws.fish"
ln -sf "$dotfiles_dir/.config/fish/completions/fga.fish" "$HOME/.config/fish/completions/fga.fish"

mkdir -p "$HOME/.config/lf"
ln -sf "$dotfiles_dir/.config/lf/lfrc" "$HOME/.config/lf/lfrc"
ln -sf "$dotfiles_dir/.config/lf/bulkrename.sh" "$HOME/.config/lf/bulkrename.sh"
ln -sf "$dotfiles_dir/.config/lf/previewer.sh" "$HOME/.config/lf/previewer.sh"

mkdir -p "$HOME/.config/opencode"
ln -sf "$dotfiles_dir/.config/opencode/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"
ln -sf "$dotfiles_dir/.config/opencode/opencode.json" "$HOME/.config/opencode/opencode.json"
ln -sf "$dotfiles_dir/.config/opencode/tui.json" "$HOME/.config/opencode/tui.json"

mkdir -p "$HOME/.config/run-or-raise"
ln -sf "$dotfiles_dir/.config/run-or-raise/shortcuts.conf" "$HOME/.config/run-or-raise/shortcuts.conf"

mkdir -p "$HOME/.config/sublime-text"
ln -sf "$dotfiles_dir/.config/sublime-text/Packages" "$HOME/.config/sublime-text/"
mkdir -p "$HOME/.config/sublime-text/Installed Packages"
ln -sf "$dotfiles_dir/.config/sublime-text/Installed Packages/Theme - Asphalt.sublime-package" \
    "$HOME/.config/sublime-text/Installed Packages/Theme - Asphalt.sublime-package"

mkdir -p "$HOME/.config/xpad"
ln -sf "$dotfiles_dir/.config/xpad/default-style" "$HOME/.config/xpad/default-style"
mkdir -p "$HOME/.config/xpad/trigger"
ln -sf "$dotfiles_dir/.config/xpad/trigger/GEORGIAN-trigger.sh" "$HOME/.config/xpad/trigger/GEORGIAN-trigger.sh"

mkdir -p "$HOME/.urserver/remotes"
ln -sf "$dotfiles_dir/.urserver/remotes/custom" "$HOME/.urserver/remotes/"

case "$(uname -n)" in
barn-ultra | andreasl-yoga)

    ln -sf "$dotfiles_dir/.config/edm/edmrc-barn" "$HOME/.config/edm/edmrc"
    rm "$HOME/.config/reposets"
    ln -sf "$dotfiles_dir/.config/reposets-barn" "$HOME/.config/reposets"
    mkdir -p "$HOME/.config/Nextcloud"
    ln -sf "$dotfiles_dir/.config/Nextcloud/sync-exclude.lst" "$HOME/.config/Nextcloud/sync-exclude.lst"
    ;;
bee)

    rm "$HOME/.config/reposets"
    ln -sf "$dotfiles_dir/.config/reposets-bee" "$HOME/.config/reposets"
    ;;
*work*)

    ln -sf "$dotfiles_dir/.config/edm/edmrc-work" "$HOME/.config/edm/edmrc"
    rm "$HOME/.config/reposets"
    ln -sf "$dotfiles_dir/.config/reposets-work" "$HOME/.config/reposets"
    ln -sf "$dotfiles_dir/.config/autostart/open-journal.desktop" "$HOME/.config/autostart/open-journal.desktop"
    mkdir -p "$HOME/.config/Nextcloud"
    ln -sf "$dotfiles_dir/.config/Nextcloud/sync-exclude.lst" "$HOME/.config/Nextcloud/sync-exclude.lst"
    ;;
esac
