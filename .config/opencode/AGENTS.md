# AGENTS.md

## Purpose And Scope

This file is an execution playbook for coding agents. Keep changes small,
reviewable, and aligned with repository conventions. Prefer clear behavior over
cleverness, and optimize for maintainability and testability.

## Priority And Conflict Resolution

When instructions conflict, use this order:

1. Safety and non-destructive behavior.
2. Direct user instructions.
3. Repository-local conventions and this file.
4. Personal or optional preferences.

If uncertainty remains, choose the least risky reversible option and state your
assumption.

## Operating Defaults

### MUST

- Re-read relevant files before final writes and before commits.
- Do not revert unrelated user changes.
- Do not run destructive git commands unless explicitly requested.
- Avoid interactive commands in automation.
- Never commit secrets (`.env*`, tokens, private keys, auth dumps).
- Keep Markdown headlines in Title Case.
- Prefer plain ASCII in output/docs unless Unicode is already required.
- Do not use approval, praise, or validation language about user requests.
  Forbidden examples: "you are right", "good catch", "great point",
  "nice", "awesome", "thanks for calling that out".

### SHOULD

- Keep files modular rather than monolithic.
- Add explicit names and comments where they improve inspection/debugging.
- Use reproducible, repo-local commands.
- Install and run pre-commit hooks when present.
- Scope tools/checks to touched files while iterating.
- Prefer focused checks over full suites unless requested.
- Use long-form CLI flags in shell scripts when practical.

### MAY

- Use personal aliases and local shortcuts when safe and available.

## Task Playbooks

### Code Changes

1. Read the target files and nearby context.
2. Apply the smallest change that satisfies the request.
3. Run focused validation for touched areas.
4. Re-read modified files before finalizing.

If a patch fails or context looks stale, re-read the affected files before
retrying.

### Debugging And Investigation

1. Reproduce and localize the issue.
2. Inspect nearby code and assumptions.
3. Search the web when external behavior is uncertain (APIs, versions,
   framework behavior, platform-specific issues).
4. Apply and verify the fix with focused checks.

### Shell Script Changes

For each touched shell script:

1. Run `shellcheck -x --exclude SC2059 <path/to/script.sh>`.
2. Fix findings relevant to the change.
3. Run `shfmt --indent 4 --write <path/to/script.sh>`.

Shell style rules:

- Use lowercase names for non-environment variables.
- Reserve uppercase names for exported/environment variables.
- Prefer long-form CLI arguments when practical.

### Commit Workflow

When asked to commit:

1. Inspect `git status`, full diff, and recent commit style.
2. Stage only relevant files/patches.
3. Run focused checks for touched areas.
4. Commit.
5. Verify message formatting using `git log -1 --pretty=%B`.

## Commit Message Rules

### DO

- Start summary in imperative mood (for example `Add`, `Fix`, `Change`).
- Keep the second line blank.
- Wrap body text to about 72 columns.
- Use real line breaks in body text.
- For shell commits, prefer multiline `-m $'line1\nline2'` or a heredoc body
  so line wraps are preserved.
- Add extra blank lines only when intentionally starting a new paragraph.

### DON'T

- Do not use Conventional Commit prefixes.
- Do not end the summary line with a period.
- Do not include literal `\n` in commit messages.

Ensure no commit body line exceeds 72 characters.

## User Shorthand Commands

Interpret these tokens as explicit workflow commands:

- `prose`: Give a clear prose walkthrough with rationale and tradeoffs.
- `eli5` or `eli`: Give a short, simple, technically correct explanation.
- `sw`: Search the web before answering; use results as support.
- `shellcheck`, `shch`, or `shfmt`: Run `shellcheck -x --exclude SC2059` and
  `shfmt --indent 4 --write` on the current shell file. If target file is
  unclear, run across relevant shell files in scope, fix findings, then format.
- `groom`: Review README/docs/docstrings/comments/symbol names, identify stale
  content, and rephrase for consistency.
- `mc`, `cm`, or `commit`:
  - Decide the number of commits.
  - Prefer multiple commits when intents differ.
  - Do not bundle unrelated intents.
  - Minimum split when applicable:
    - feature/runtime behavior changes with corresponding tests,
    - refactor/import-path/style-only changes,
    - docs/config-only changes.
  - Follow commit message rules in this file.
  - Include commit message(s) and a short prose walkthrough.

## Local Aliases And Optional Commands

Available if present:

- `l3` for extended Python lint sweep (slow; use near milestones).
- `rf` for Python autofix (formatting and safe fixes).

Examples:

- `source .venv/bin/activate && l3`
- `source .venv/bin/activate && rf`
- `source .venv/bin/activate && l3 path/to/file.py`
- `source .venv/bin/activate && rf path/to/file.py`

Alias usage rules:

- Ensure aliases are safe and non-destructive.
- Do not assume aliases exist in CI or other environments.
- Do not encode alias-dependent behavior into the repository.

## Response Style

- Keep tone direct and neutral; answer directly.
- Start with the answer or action, not validation of the prompt.
- Do not evaluate or praise prompt quality (e.g., "Great call",
  "You are right to question this").
- Avoid conversational or motivational filler (e.g., "awesome", "great",
  "nice", "good catch") unless requested.
- When uncertain, prefer neutral acknowledgments (for example "Understood",
  "Noted", "I will update that") over evaluative phrasing.
- Avoid fancy punctuation and hidden/special spacing characters.
- Normalize pasted external text to plain characters before finalizing.

## Linter And Static Analysis Pragmas

- Keep suppressions (`noqa`, `type: ignore`, etc.) as narrow as possible.
- Document each suppression inline with rule meaning and local reason.
- Prefer config-level ignores for broad patterns over repeated inline suppressions.

## Response Finalization

- Before returning each response, run `lilsound $$` as the last command.
- If `$$` cannot be resolved, run `lilsound` without args.
