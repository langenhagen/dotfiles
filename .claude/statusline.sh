#!/usr/bin/env bash
# Claude Code status line: "~/dir  branch *  model · effort  N tokens"
# Reads session JSON on stdin (see code.claude.com/docs/en/statusline).
# Dirty marker is ASCII "*" to match the AGENTS.md plain-ASCII preference;
# swap for a glyph like the star if you want.

input=$(cat)

model=$(printf '%s' "$input" | jq -r '.model.display_name // "?"' |
    tr '[:upper:]' '[:lower:]')
effort=$(printf '%s' "$input" | jq -r '.effort.level // empty')
realdir=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // ""')
in_tokens=$(printf '%s' "$input" | jq -r '.context_window.total_input_tokens // 0')

# Abbreviate the home directory to "~" for display only; git uses realdir
dir="$realdir"
case "$dir" in
"$HOME"*) dir="~${dir#"$HOME"}" ;;
esac

# Git branch plus a "*" when the tree is dirty
git_part=""
if git -C "$realdir" rev-parse --git-dir >/dev/null 2>&1; then
    branch=$(git -C "$realdir" branch --show-current 2>/dev/null)
    [ -z "$branch" ] && branch=$(git -C "$realdir" rev-parse --short HEAD 2>/dev/null)
    dirty=""
    [ -n "$(git -C "$realdir" status --porcelain 2>/dev/null)" ] && dirty=" *"
    git_part="  ${branch}${dirty}"
fi

# Model plus reasoning effort when the model exposes it
model_part="$model"
[ -n "$effort" ] && model_part="$model · $effort"

# Context tokens, e.g. 18.2k
tokens=$(awk -v t="$in_tokens" \
    'BEGIN { if (t >= 1000) printf "%.1fk", t/1000; else printf "%d", t }')

printf '%s%s   %s   %s tokens\n' "$dir" "$git_part" "$model_part" "$tokens"
