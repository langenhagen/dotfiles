# AGENTS.md

Global AGENTS.md file.

## Intent

- Keep changes small, reviewable, and aligned with existing repo conventions.
- Assume files may change while you work; re-read before final writes and commits.
- Search the web proactively when debugging, investigating, researching or verifying APIs.
- Add clear comments and explicit names so structure is easy to inspect and debug.
- Prefer smaller, modular files over monolithic files when adding or refactoring code.
- Avoid over-engineering: prefer the simple solution that keeps behavior clear, maintainable and testable.
- Capitalize Markdown headlines (prefer Title Case).

## Local Workflow

Prefer reproducible, repo-local commands.

- Install/sync dependencies using the project's package manager.
- Run the main entrypoint using the project's documented command.
- Run tests using the configured test runner.
- Run linting and formatting tools before committing.
- Run type checks or static analysis if configured.
- Install and run pre-commit hooks if present.
- For shell scripts, run:
  - `shellcheck -x --exclude SC2059 <path/to/script.sh>`
  - `shfmt --indent 4 --write <path/to/script.sh>`

Scope tools to specific files when iterating quickly.
Avoid running full test suites unless explicitly requested; prefer focused checks for touched areas first.

## Personal Shell Commands

You may use personal shell commands if available in your environment.

E.g.:

- `l3` - extended Python lint sweep (slow; use near milestones).
- `rf` - Python autofix pass (formatting and safe fixes).

- Optional personal lint sweep: `source .venv/bin/activate && l3`.
- Optional personal autofix pass: `source .venv/bin/activate && rf`.
- You can scope those tools to one file when iterating quickly:
  - `source .venv/bin/activate && l3 path/to/file.py`
  - `source .venv/bin/activate && rf path/to/file.py`

When using aliases:
- Ensure they are safe and non-destructive.
- Do not assume they exist in CI or other environments.
- Do not encode alias-dependent behavior into the repository itself.

## User Shorthand Conventions

Interpret these tokens as explicit workflow commands:

- `prose`
  - Provide a clear prose walkthrough of the topic or changes.
  - Prioritize rationale, tradeoffs, and how pieces fit together.

- `eli5` or `eli`
  - Provide a short, simple, technically correct explanation.

- `sw`
  - Explicitly search the web before answering.
  - Use results as supporting context.

- `mc`, `cm`, or `commit`
  - Identify how many commits to make then make them.
  - Default to multiple commits whenever there are multiple intents.
  - Do not bundle unrelated intents into one commit.
  - Use this minimum split when applicable:
    - feature/runtime behavior changes and according tests,
    - refactor/import-path/style-only changes,
    - docs/config-only changes.
  - Follow the commit message rules below.
  - Include both the commit message and a short prose walkthrough.

## Response Finalization

- Before returning each response to the user, run `lilsound $$` with $$ being
  the current process ID as the last command.
- If $$ can not be resolved, run `lilsound` as a fallback.

## Commit Workflow

When asked to commit:

1. Inspect `git status`, full diff, and recent commit style.
2. Stage only relevant files/patches.
3. Run focused checks for touched areas.
4. Commit with a plain imperative summary line.
5. Report commit hash, message, and a short prose walkthrough.

### Commit Message Rules

DO:

- Start the summary in imperative mood (for example `Add`, `Fix`, `Change`).
- Keep the second line blank.
- Wrap body text to about 72 columns.
- Use real line breaks in the body; do not pass wrapped text as one line.
- When using shell commits, prefer multiline `-m $'line1\nline2'` or a
  heredoc body so line wraps are preserved.
- Use simple line wraps in the body and keep one paragraph by default.
- Add extra blank lines only when you intentionally start a new paragraph.

DON'T:

- Do not use Conventional Commit prefixes.
- Do not end the summary line with a period.
- Do not include literal `\n` text in commit messages; use real newlines.


Before finalizing a commit, verify formatting with:

- `git log -1 --pretty=%B`
- Ensure no body line exceeds roughly 72 characters.

Never include secrets in commits (`.env*`, tokens, private keys, auth dumps).

## Git and Editing Safety

- Do not revert unrelated user changes.
- Do not use destructive git commands unless explicitly requested.
- Avoid interactive commands in automation.
- If a patch fails or context looks stale, re-read files before retrying.

## Linter and Static Analysis Pragmas

- Keep suppressions (`noqa`, `type: ignore`, etc.) as narrow as possible.
- Document each suppression inline with:
  - the rule meaning, and
  - a short local reason.
- Prefer config-level ignores for broad patterns over repeated inline suppressions.

## Output Character Policy

- Prefer plain ASCII in output and docs unless a file already requires Unicode.
- Avoid fancy punctuation and hidden/special spacing characters.
- Normalize pasted external text to plain characters before finalizing.
