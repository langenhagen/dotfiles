#!/usr/bin/env bash
# Forcefully links dotfiles into the system on macOS.
#
# author: andreasl

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dotfiles_dir="${script_dir}"

# macOS keeps application support data outside the XDG tree
app_support_dir="$HOME/Library/Application Support"

ln -sf "$dotfiles_dir/.vim" "$HOME"
ln -sf "$dotfiles_dir/.vimrc" "$HOME/.vimrc"

ln -sf "$dotfiles_dir/.gitconfig" "$HOME/.gitconfig"
ln -sf "$dotfiles_dir/.gitignore_global" "$HOME/.gitignore_global"
ln -sf "$dotfiles_dir/.gvimrc" "$HOME/.gvimrc"
ln -sf "$dotfiles_dir/.multitailrc" "$HOME/.multitailrc"
ln -sf "$dotfiles_dir/.sqliterc" "$HOME/.sqliterc"
ln -sf "$dotfiles_dir/.tigrc" "$HOME/.tigrc"
ln -sf "$dotfiles_dir/.tmux.conf" "$HOME/.tmux.conf"

mkdir -p "$HOME/.config"

mkdir -p "$HOME/.config/alacritty"
ln -sf "$dotfiles_dir/.config/alacritty/alacritty-colors.toml" "$HOME/.config/alacritty/alacritty-colors.toml"
ln -sf "$dotfiles_dir/.config/alacritty/alacritty-macos.toml" "$HOME/.config/alacritty/alacritty.toml"

mkdir -p "$HOME/.config/bpython"
ln -sf "$dotfiles_dir/.config/bpython/config" "$HOME/.config/bpython/config"
ln -sf "$dotfiles_dir/.config/bpython/my.theme" "$HOME/.config/bpython/my.theme"

mkdir -p "$app_support_dir/Code/User"
ln -sf "$dotfiles_dir/.config/Code/User/keybindings.json" "$app_support_dir/Code/User/keybindings.json"
ln -sf "$dotfiles_dir/.config/Code/User/settings.json" "$app_support_dir/Code/User/settings.json"
mkdir -p "$app_support_dir/Code/User/snippets"
ln -sf "$dotfiles_dir/.config/Code/User/snippets/barns-snippets.code-snippets" "$app_support_dir/Code/User/snippets/barns-snippets.code-snippets"

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

mkdir -p "$HOME/.config/fish/completions"
ln -sf "$dotfiles_dir/.config/fish/completions/aws.fish" "$HOME/.config/fish/completions/aws.fish"

mkdir -p "$HOME/.config/ghostty"
ln -sf "$dotfiles_dir/.config/ghostty/config.ghostty" "$HOME/.config/ghostty/config.ghostty"

mkdir -p "$HOME/.config/lf"
ln -sf "$dotfiles_dir/.config/lf/lfrc" "$HOME/.config/lf/lfrc"
ln -sf "$dotfiles_dir/.config/lf/bulkrename.sh" "$HOME/.config/lf/bulkrename.sh"
ln -sf "$dotfiles_dir/.config/lf/previewer.sh" "$HOME/.config/lf/previewer.sh"

# Nextcloud writes this file atomically, which fails when it is a symlink; copy
# it so the client can write through it. dotfiles stays the source of truth.
nextcloud_prefs_dir="$HOME/Library/Containers/com.nextcloud.desktopclient/Data/Library/Preferences/Nextcloud"
mkdir -p "$nextcloud_prefs_dir"
cp "$dotfiles_dir/.config/Nextcloud/sync-exclude.lst" "$nextcloud_prefs_dir/sync-exclude.lst"

# Karabiner-Elements overwrites symlinked karabiner.json; copy it so the
# GUI can write through it. dotfiles stays the source of truth.
mkdir -p "$HOME/.config/karabiner/assets/complex_modifications"
cp "$dotfiles_dir/.config/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
ln -sf "$dotfiles_dir/.config/karabiner/assets/complex_modifications/caps_lock_esc_ctrl.json" \
    "$HOME/.config/karabiner/assets/complex_modifications/caps_lock_esc_ctrl.json"
ln -sf "$dotfiles_dir/.config/karabiner/assets/complex_modifications/app_launch_shortcuts.json" \
    "$HOME/.config/karabiner/assets/complex_modifications/app_launch_shortcuts.json"

mkdir -p "$HOME/.config/opencode"
ln -sf "$dotfiles_dir/.config/opencode/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"
ln -sf "$dotfiles_dir/.config/opencode/opencode.json" "$HOME/.config/opencode/opencode.json"
ln -sf "$dotfiles_dir/.config/opencode/tui.json" "$HOME/.config/opencode/tui.json"

mkdir -p "$HOME/Library/Application Support/Mozilla.sccache"
ln -sf "$dotfiles_dir/.config/sccache/config" "$HOME/Library/Application Support/Mozilla.sccache/config"

mkdir -p "$HOME/.claude"
ln -sf "$dotfiles_dir/.config/opencode/AGENTS.md" "$HOME/.claude/CLAUDE.md"
ln -sf "$dotfiles_dir/.claude/settings.json" "$HOME/.claude/settings.json"
ln -sf "$dotfiles_dir/.claude/statusline.sh" "$HOME/.claude/statusline.sh"

mkdir -p "$app_support_dir/Sublime Text"
ln -sf "$dotfiles_dir/.config/sublime-text/Packages" "$app_support_dir/Sublime Text/"
mkdir -p "$app_support_dir/Sublime Text/Installed Packages"
ln -sf "$dotfiles_dir/.config/sublime-text/Installed Packages/Theme - Asphalt.sublime-package" \
    "$app_support_dir/Sublime Text/Installed Packages/Theme - Asphalt.sublime-package"

case "$(uname -n)" in
*work*)

    rm "$HOME/.config/reposets"
    ln -sf "$dotfiles_dir/.config/reposets-work" "$HOME/.config/reposets"
    ;;
esac
