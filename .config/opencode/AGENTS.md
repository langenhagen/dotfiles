# AGENTS.md

## Purpose And Scope

This file is an execution playbook for coding agents. Keep changes small,
reviewable, and aligned with repository conventions. Prefer clear behavior over
cleverness, and optimize for maintainability and testability.

## Priority And Conflict Resolution

When instructions conflict, use this order:

1. Safety and non-destructive behavior.
2. Direct user instructions.
3. Repository-local `AGENTS.md` and repository conventions.
4. Global/default agent guidance (this file).
5. Personal or optional preferences.

For repository work, repository-local `AGENTS.md` instructions override this
global file when they conflict.

If uncertainty remains, choose the least risky reversible option and state your
assumption.

## Operating Defaults

### MUST

- Re-read relevant files before final writes and before commits.
- Do not revert unrelated user changes.
- Do not run destructive git commands (history-rewriting or work-discarding)
  unless explicitly requested. Examples: `git commit --amend`, `git rebase`,
  `git reset --hard`, `git push --force`, `git clean -fd`.
- Avoid interactive commands in automation.
- Never commit secrets (`.env*`, tokens, private keys, auth dumps).
- Keep temporary files and render artifacts in workspace paths (for example
  `.tmp/`) and remove them after use.
- Keep Markdown headlines in Title Case.
- Prefer plain ASCII in output/docs unless Unicode is already required.

### SHOULD

- Keep files modular rather than monolithic.
- Add explicit names and comments where they improve inspection/debugging.
- Use reproducible, repo-local commands.
- Install and run pre-commit hooks when present.
- Scope tools and checks to touched files; prefer focused checks over full
  suites unless requested.
- Prefer long-form CLI flags.
- Avoid preemptive guards and speculative fallbacks. Add guards, `try/except`
  blocks, null checks, and default-value fallbacks only when a failure mode is
  real, observed, or explicitly requested. Well-known canonical patterns (for
  example wrapping a documented-raising stdlib call) are fine. Prefer loud
  failures over silent defaults; do not add fallback behavior unless asked.

### MAY

- Use personal aliases and local shortcuts when safe and available.

## Task Playbooks

### Code Changes

1. Read the target files and nearby context.
2. Apply the smallest change that satisfies the request.
3. Run validation for touched areas.

### Debugging And Investigation

1. Reproduce and localize the issue.
2. Inspect nearby code and assumptions.
3. Search the web when external behavior is uncertain (APIs, versions,
   framework behavior, platform-specific issues).
4. Apply and verify the fix.

### Shell Script Changes

For each touched shell script:

1. Run `shellcheck -x --exclude SC2059 <path/to/script.sh>`.
2. Fix findings relevant to the change.
3. Run `shfmt --indent 4 --write <path/to/script.sh>`.

Shell style rules:

- Use lowercase names for non-environment variables.
- Reserve uppercase names for exported/environment variables.

### Commit Workflow

When asked to commit:

1. Inspect `git status`, full diff, and recent commit style.
2. Stage only relevant files/patches.
3. Run focused checks for touched areas.
4. Commit.
5. Verify message formatting using `git log -1 --pretty=%B`.

## Commit Message Rules

- Start summary in imperative mood (for example `Add`, `Fix`, `Change`);
  do not use Conventional Commit prefixes; do not end with a period.
- Keep the second line blank.
- Wrap body text to 72 columns (no line exceeds 72); use real line breaks,
  not literal `\n`.
- For shell commits, prefer multiline `-m $'line1\nline2'` or a heredoc body
  so line wraps are preserved.
- Add extra blank lines only when intentionally starting a new paragraph.

## User Shorthand Commands

Interpret these tokens as explicit workflow commands:

- `prose`: Give a clear prose walkthrough with rationale and tradeoffs.
- `eli5` or `eli`: Give a short, simple, technically correct explanation.
- `s`, `short`: Restate the previous assistant message in 1-5 sentences.
  No new work, no new tool calls; just a terse paraphrase of what was
  already said.
- `sw`: Search the web before answering; use results as support.
- `shellcheck`, `shch`, or `shfmt`: Run the `Shell Script Changes` playbook
  on the current shell file. If target is unclear, run across relevant shell
  files in scope.
- `groom`: Review README/docs/docstrings/comments/symbol names, identify stale
  content, and rephrase for consistency.
- `mc`, `cm`, or `commit`: Run the `Commit Workflow` playbook. Split into
  multiple commits when intents differ (do not bundle unrelated intents);
  typical split is feature+tests, refactor/style, docs/config. Include the
  commit message(s) and a short prose walkthrough in the response.

## Local Commands

These commands exist only on the user's local machine; they are not present
in CI or other environments. Each accepts an optional path: no path runs
against the default scope, a directory path scopes to that tree, a single
file path is the fastest invocation. Activate venv first:
`source .venv/bin/activate && l3 path/to/file.py`.

- `l3` — extended Python lint sweep (slow; use near milestones).
- `rf` — Python autofix (formatting and safe fixes).

- Do not depend on these in the repository (configs, scripts, CI, etc.).

## Response Style

- Keep tone direct and neutral; answer directly.
- Start with the answer or action, not validation of the prompt.
- Do not use approval, praise, or validation language about user requests
  or prompt quality. Forbidden examples: "you are right", "good catch",
  "great point", "great call", "nice", "awesome",
  "thanks for calling that out", "you are right to question this".
- Avoid conversational or motivational filler unless requested.
- When uncertain, prefer neutral acknowledgments (for example "Understood",
  "Noted", "I will update that") over evaluative phrasing.
- Avoid fancy punctuation and hidden/special spacing characters.
- Normalize pasted external text to plain characters before finalizing.
- Do not bike-shed. Ask only questions whose answers materially change the
  plan or output. Do not ask about cosmetic placement, ordering, or
  wording variants the user is unlikely to care about. When uncertain
  between near-equivalent options, pick one and proceed.
- End every response with a brief TL;DR summarizing the key point(s) of
  the response.
- When asking the user one or more questions, or when using a question tool,
  place a TL;DR summary of the response so far immediately before the question(s),
  so the user always sees a recap before being prompted.

## Linter And Static Analysis Pragmas

- Keep suppressions (`noqa`, `type: ignore`, etc.) as narrow as possible.
- Document each suppression inline with rule meaning and local reason.
- Prefer config-level ignores for broad patterns over repeated inline suppressions.

## Response Finalization

- Before returning each response, run `lilsound $$` as the last command.
- If `$$` cannot be resolved, run `lilsound` without args.
- `lilsound` is non-writing and safe to run in plan mode.
