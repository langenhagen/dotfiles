# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repository Is

Personal dotfiles for Linux (Ubuntu/GNOME) and macOS. There is no build, no test
suite and no application code - the deliverable is configuration that gets
symlinked into `$HOME`. "Correctness" here means a config still parses and still
behaves the same on the platform you are *not* sitting on.

## Commands

```bash
# Link dotfiles into the system - DESTRUCTIVE, overwrites targets and calls rm.
# Never run these to "verify" a change; see Verifying Changes below.
./link-files-linux.sh
./link-files-macos.sh

# Required for every touched shell script.
shellcheck -x --exclude SC2059 <script.sh>
shfmt --indent 4 --write <script.sh>

./assume_unchanged.sh        # tell git to ignore local changes to listed files
./assume_unchanged.sh -no    # undo the above

./export-vscode-extensions.sh    # refresh vscode-extensions.txt
./install-vscode-extensions.sh
./export-gnome-terminal-settings.sh   # Linux only, needs dconf
./import-gnome-terminal-settings.sh   # Linux only, needs dconf
```

## Architecture

### Two Standalone Link Scripts

`link-files-linux.sh` and `link-files-macos.sh` are independent by design -
neither sources the other, and the shared links are duplicated. **A file that
applies to both platforms must be added to both scripts.** Their differences are
not cosmetic:

- Linux puts VS Code and Sublime Text config under `~/.config/`; macOS puts it
  under `~/Library/Application Support/`.
- The Nextcloud client reads `~/.config/Nextcloud/` on Linux but
  `~/Library/Preferences/Nextcloud/` on macOS.
- Linux-only targets that macOS omits entirely: `mimeapps.list`, `user-dirs.*`,
  `autostart/`, `edm`, `run-or-raise`, `xpad`, `.urserver`.
- macOS links `Nextcloud` and `feh` unconditionally, while Linux gates
  `Nextcloud` per machine inside its `case` block. The two scripts are not
  expected to match here - macOS has only one machine profile.

Two link forms recur, both deliberate:

- `ln -sf <src> <parent-dir>/` lets `ln` place the link inside the parent, used
  for `.vim` and `sublime-text/Packages`. It is re-run safe on GNU `ln`
  (verified; it replaces the existing link rather than nesting), so do not
  "fix" it by adding `-n`.
- `rm "$HOME/.config/reposets"` before linking a `reposets-*` variant. The
  `reposets-*` sources are directories and the link needs an explicit target
  name, so the old link has to go first. On a fresh machine that `rm` prints a
  harmless error; adding `-f` would be unrequested hardening.

Keep the two scripts stylistically identical to each other.
`link-files-linux.sh` is the older, long-proven one - prefer changing it only
for a concrete reason (a renamed source, a removed file, a real asymmetry with
the macOS script), and never to add speculative hardening.

### Two Dispatch Axes

Configuration branches independently on OS and on machine:

- **OS** - `uname -s` (or bare `uname`) in shell/fish, `if-shell` in tmux,
  `has('mac')` in vim. In `.tmux.conf` always use the brace-block form,
  `if-shell '<cond>' { ... } { ... }`, with the Darwin branch first - even for a
  single command, so every block in the file reads the same way.
- **Machine** - `uname -n` hostname globs: `barn-ultra`, `andreasl-yoga`, `bee`,
  `*work*`. These select `reposets` and the `$*_DIR_PATH` variables on both
  platforms, plus `edmrc` on Linux only - `edm` drives `explore-with-dmenu.sh`,
  which is X11-only, so macOS does not link it.

**Only ever use short `uname` flags.** BSD/macOS `uname` rejects GNU long
options; `uname --nodename` in `abbreviations.fish` used to abort the entire
abbreviation block on macOS, which silently disabled the `Darwin` branch nested
inside it.

### Per-Platform File Variants

Formats that cannot express an OS conditional (TOML, plain config) are split
into sibling files that the link scripts choose between. Existing instances:
`edmrc-barn` / `edmrc-work`, `reposets-barn` / `reposets-bee` / `reposets-work`,
and `alacritty-linux.toml` / `alacritty-macos.toml` (both importing the shared
`alacritty-colors.toml`). Follow this pattern rather than inventing a new one.

Alacritty skips a missing `import` silently, so if `alacritty-colors.toml` ever
stops being linked you get the stock theme and no error. Keep both link lines.

### fish Load Order

`config.fish` sources, in order: `environment-variables.fish`,
`key-bindings.fish`, `functions.fish`, `aliases.fish`, `abbreviations.fish`,
`vimlike-bookmarks.fish`. Consequences worth knowing:

- `environment-variables.fish` runs `brew shellenv` first, before any `PATH`
  manipulation, so Homebrew tools are findable by everything downstream.
- It sets `$bat_cmd` (`batcat` on Debian, `bat` on Homebrew, `cat` as fallback),
  interpolated by `abbreviations.fish`. It has to be resolved into a variable
  because `abbr` bakes its expansion in at definition time.
- Anything reading `$bat_cmd` must be sourced after
  `environment-variables.fish`.

### lf Integration

`lfrc` uses a bare `$OPENER` and nothing in this repo sets it. That is correct:
**lf exports `$OPENER` itself** (`open` on macOS, `xdg-open` elsewhere). Do not
"fix" it by defining `OPENER` in the fish config.

`lfrc` invokes `bulkrename.sh "$fs"` with the selection **quoted**, and lf's
`filesep` defaults to `"\n"`. The script therefore receives a single argument
holding every selected file separated by newlines - not one argument per file.
Split it with `while IFS= read -r`; splitting on the default `$IFS` shreds file
names that contain spaces.

### Vendored Third-Party Code

Roughly 500 of the ~630 tracked files are vendored dependencies, not the user's
configuration. **Do not edit, reformat, lint or "clean up" these paths:**

- `.config/sublime-text/Packages/mdpopups/`
- `.config/sublime-text/Packages/pyyaml/`
- `.config/sublime-text/Packages/sublime_lib/`
- `.vim/autoload/plug.vim`

The user's own Sublime config is `.config/sublime-text/Packages/User/` only.

## Portability Traps

Verified breakages that have already been fixed once. Do not reintroduce them:

| Trap | Correct approach |
|---|---|
| GNU long options (`uname --nodename`) | Short flags only |
| `mapfile` / `readarray` | `while IFS= read -r`; macOS ships bash 3.2 |
| `xargs -r` | BSD `xargs` rejects `-r`; it already skips on empty input. Branch on `uname` |
| `for ((...)) { ... }` brace body | Undocumented bash form; use `do ... done`, which is what `shfmt` produces anyway |
| `grep --exclude-dir` | GNU extension; macOS system grep only has it from macOS 12 |
| `xclip` / `xsel` | `pbcopy` on macOS; branch on the OS |
| `has('linux')` as a vimrc OS test | `!has('mac')`; the `linux` feature needs Vim 8.2.4839+ and returns 0 on older builds, silently dropping the branch |
| `setsid` | Linux only; branch on `uname`. Not needed on macOS, where `open` returns immediately |
| `systemctl` | `pmset sleepnow` for suspend on macOS |
| `batcat` | Debian-only binary name; use `$bat_cmd` |
| `/usr/bin/fish`, `/usr/bin/tmux` | Homebrew prefix is `/opt/homebrew/bin` |
| Hardcoded `/home/andreasl` | `$HOME` |
| Stock macOS `vim` | Built without `+clipboard`, so `"+y` silently no-ops |

## Scope Discipline

This repo is a working setup, not a codebase to harden. When making something
work on macOS, change only what is actually broken there:

- Do not add existence checks, `command -v` guards, `test -n` guards or default
  fallbacks to code that did not have them. Untested paths and unset variables
  are deliberate; loud failure is preferred over a silent default. The one
  sanctioned exception is the `test -x /opt/homebrew/bin/brew` guard in
  `environment-variables.fish`, which keeps shell startup quiet on a fresh Mac
  before Homebrew is installed. Leave it in place.
- Do not "fix" adjacent style, quoting or flags you happen to notice. This
  outranks the habit of running `shfmt --write` over a whole file: format the
  lines you touched, not the ones you merely read.
- Put an OS branch in the file that needs it, not in a shared file, unless more
  than one consumer needs the value. `lfrc` resolves `setsid` inside its own
  `${{ }}` shell block for exactly this reason.
- Prefer deleting an unused config line over porting it.
- Keep linter suppressions narrow and explain them inline, as
  `bulkrename.sh` does for `SC1090`.

## Verifying Changes

The link scripts modify the live system, so verify statically instead:

```bash
# shellcheck and shfmt take many files; bash -n and fish --no-execute do NOT -
# they check only the first and treat the rest as positional parameters.
shellcheck -x --exclude SC2059 link-files-linux.sh link-files-macos.sh
shfmt --indent 4 --diff link-files-linux.sh link-files-macos.sh
for f in link-files-linux.sh link-files-macos.sh; do
    bash -n "$f" || echo "FAIL $f"
done
for f in .config/fish/*.fish .config/fish/completions/*.fish; do
    fish --no-execute "$f" || echo "FAIL $f"
done
vim -es -u .vimrc -c 'qa!' && echo 'vimrc parses'
tmux -L check -f "$PWD/.tmux.conf" new-session -d 'sleep 5' && \
    tmux -L check show-options -g status-left && tmux -L check kill-server
```

`.tmux.conf` parses both arms of every `if-shell` at load, so a syntax error in
the Darwin branch surfaces on Linux too.

To confirm every link source actually exists (catches dangling symlinks before
they reach the system), run this for **both** scripts:

```bash
grep -o '"\$dotfiles_dir/[^"]*"' link-files-linux.sh | tr -d '"' |
    sed "s|\$dotfiles_dir|$PWD|" |
    while read -r p; do [ -e "$p" ] || echo "MISSING: $p"; done
```

To find files one script links and the other does not - the check that catches a
forgotten counterpart:

```bash
for s in link-files-linux.sh link-files-macos.sh; do
    grep -o '"\$dotfiles_dir/[^"]*"' "$s" | LC_ALL=C sort -u > "/tmp/${s}.txt"
done
LC_ALL=C comm -23 /tmp/link-files-linux.sh.txt /tmp/link-files-macos.sh.txt
```

To exercise the macOS branch of a config from Linux, shadow `uname` with a stub
early on `PATH` that prints `Darwin` for `-s` and a `*work*` hostname for `-n`.
For fish specifically a shell function is enough and writes nothing to disk:

```bash
fish --no-config -c '
    function uname
        if test "$argv[1]" = -n; echo my-work-mbp; else; echo Darwin; end
    end
    source .config/fish/abbreviations.fish
    abbr --show | string match -r "abbr -a -- pk .*"'
```

`has('mac')` is a compile-time vim feature, so a `uname` stub cannot simulate
it; the macOS side of `.vimrc` is not testable from Linux.

When touching a shared file, diff it afterwards and confirm every pre-existing
Linux value survives verbatim inside the new conditional's else-branch.
