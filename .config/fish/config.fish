# My, andreasl's, fish config file.
# Should work on Linux and Mac OS with iterm2.

set fish_greeting ""  # deactivate the fish welcome message

### sourcing #######################################################################################

source ~/.config/fish/environment-variables.fish
source ~/.config/fish/key-bindings.fish
source ~/.config/fish/functions.fish
source ~/.config/fish/aliases.fish
source ~/.config/fish/abbreviations.fish

source ~/.config/fish/vimlike-bookmarks.fish

test -e ~/.rbenv/bin/rbenv; and status --is-interactive; and source (~/.rbenv/bin/rbenv init - | psub)

command -v pyenv 1>/dev/null 2>&1; and status is-interactive; and pyenv init --no-rehash - 2>/dev/null | source
command -v direnv 1>/dev/null 2>&1; and eval (direnv hook fish)
nvm --version 1>/dev/null 2>&1; and nvm use lts 1>/dev/null

# pnpm
set -gx PNPM_HOME "/home/andreasl/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# opencode
fish_add_path $HOME/.opencode/bin

command -v fortune 1>/dev/null 2>&1 && fortune -s
