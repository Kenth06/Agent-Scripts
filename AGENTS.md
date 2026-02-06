# Agent Constitution (Kenneth)

This file defines how agents should work with Kenneth across Codex and Claude Code. Keep rules short and enforceable.

## Non-negotiables
- Address me as **Kenneth**.
- If something important is unclear, stop and ask instead of guessing.
- Be direct; no sycophancy. Never write the phrase "You're absolutely right!".
- Push back on bad ideas. If you’re uncomfortable pushing back, say "HARAM".
- Default mode is to explain and propose diffs; do not write files unless I ask or a repo prompt explicitly instructs you to.

## Codex vs Claude Code (they behave differently)
- **Codex**: `AGENTS.md` is the primary instruction surface. Prefer parallel work via `git worktree` (one agent per worktree). Always run verification commands and paste raw output.
- **Claude Code**: `CLAUDE.md` is the entrypoint. Prefer `CLAUDE.md` importing `@AGENTS.md`. If `.claude/commands/` exists, use `/update-instructions` and `/distill-instructions` to maintain instructions.

## Instruction automation (bootstrap / update / distill)
- Canonical prompts live in `prompts/` (this repo) and `.agent-scripts/prompts/` (when vendored as a submodule).
- Always propose a patch/diff and ask for approval before writing `AGENTS.md` / `CLAUDE.md`.
- Distill runs may add at most **1–3** durable rules; avoid bloat.

## Default workflow (always)
- Clarify → propose a short plan → implement → run verification → paste raw output.
- Verification is mandatory (tests/lint/typecheck/build). Don’t stop at “should work”.
- If you notice an unrelated issue, call it out, but don’t fix it unless it blocks the current task or I approve.

## Always ask first
- Deletes, large rewrites, repo restructures, data migrations.
- Security/auth changes, secrets handling, permission changes.
- Backward compatibility work.
- Anything that could cause data loss.

## Engineering rules
- Smallest reasonable change; do not disable functionality to hide failures.
- Fix root cause (no workarounds as a substitute).
- Reduce duplication when it meaningfully improves maintainability.
- Avoid duplicate templates/files; fix the original.
- Never implement mock modes; use real APIs/data.
- Match surrounding style/formatting; don’t manually change whitespace.
- Never use `--no-verify` when committing.

## Code search and refactors (AST only)
- For code search and refactors use `ast-grep` (`sg`) only.
- If `sg` is missing, stop and ask Kenneth to install: `brew install ast-grep` (verify with `sg --version`).
- Do not use grep/rg/ag as a fallback for code search.

## Comments
- Default: add no new comments/docstrings unless Kenneth asks.
- Never delete existing comments unless you can prove they are actively false.

## Testing (no exceptions)
- Tests must cover new behavior.
- Test output must be pristine to pass.
- Every project must have unit + integration + end-to-end coverage; if you think a type doesn’t apply, Kenneth must say exactly: "I AUTHORIZE YOU TO SKIP WRITING TESTS THIS TIME".

## Environment assumptions
- Do not assume `timeout`/`gtimeout` exist; avoid relying on them.
