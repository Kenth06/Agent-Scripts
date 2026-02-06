# Repo bootstrap (AGENTS + CLAUDE + Claude slash commands)

You are helping me (Kenneth) bootstrap AI instructions for this repo so **Codex** and **Claude Code** behave consistently.

## Hard rules

- Address me as **Kenneth**.
- Do **not** apply any edits until you show a patch/diff and I explicitly approve.
- Make the smallest changes that accomplish the goal.
- Do not commit or push unless I ask.

## Goal

Ensure the repo has:
- `AGENTS.md` (repo constitution for Codex)
- `CLAUDE.md` (repo memory for Claude Code) that imports `@AGENTS.md`
- `.claude/commands/` with:
  - `bootstrap-instructions.md`
  - `update-instructions.md`
  - `distill-instructions.md`

## Step 1 — Preflight scan (read-only)

1) Identify the stack (languages/frameworks).
2) Identify real commands:
   - dev
   - test (unit/integration/e2e if present)
   - lint/format
   - build
3) Identify CI entrypoints (GitHub Actions, etc) and what must be green.
4) Identify high-risk areas:
   - auth/security
   - migrations/schema
   - infra/deploy
   - secrets/env files

## Step 2 — Ensure `.agent-scripts` exists (portable shared rules)

If `.agent-scripts/` does not exist in this repo:
- Stop and tell Kenneth exactly what to run:

```bash
git submodule add https://github.com/Kenth06/Agent-Scripts.git .agent-scripts
```

Do not run it unless Kenneth approves.

## Step 3 — Create / update `AGENTS.md` (wrapper style)

If `AGENTS.md` exists, edit minimally. If it doesn’t, create it.

Requirements:
- Keep it short (target ≤120 lines unless Kenneth approves longer).
- Include:
  1) Purpose (1–2 lines)
  2) How we work (plan → implement → verify; paste verification output)
  3) Key commands (copy/paste ready; based on repo reality)
  4) Guardrails (what not to touch; when to stop and ask)
  5) Delegation patterns (Explorer / Implementer / Verifier / Reviewer templates)
  6) Repo map (5–10 important paths)
- First line of the wrapper must instruct the agent to read `.agent-scripts/AGENTS.md` first.

## Step 4 — Create / update `CLAUDE.md`

If `CLAUDE.md` exists, edit minimally. If it doesn’t, create it.

Content must be:

```md
# Repo memory
@AGENTS.md
```

## Step 5 — Create Claude Code slash commands (`.claude/commands/`)

Create:
- `.claude/commands/bootstrap-instructions.md` containing:

```md
@.agent-scripts/prompts/REPO_BOOTSTRAP_INSTRUCTIONS.md
```

- `.claude/commands/update-instructions.md` containing:

```md
@.agent-scripts/prompts/REPO_UPDATE_INSTRUCTIONS.md
```

- `.claude/commands/distill-instructions.md` containing:

```md
@.agent-scripts/prompts/REPO_DISTILL_INSTRUCTIONS.md
```

## Step 6 — Show patch and ask for approval

Output:
1) A summary of what you found (stack + commands + risks).
2) A unified diff/patch of all file changes you propose.
3) Ask Kenneth: “Apply this patch?”
