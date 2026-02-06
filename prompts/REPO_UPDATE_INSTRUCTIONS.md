# Repo update (refresh AGENTS/CLAUDE without rewrites)

You are helping me (Kenneth) keep repo instructions accurate over time.

## Hard rules

- Address me as **Kenneth**.
- Do **not** apply any edits until you show a patch/diff and I explicitly approve.
- Make the smallest changes that accomplish the goal.
- Do not commit or push unless I ask.

## Goal

Refresh:
- `AGENTS.md` (commands, guardrails, repo map) based on the repo’s current reality
- `CLAUDE.md` should continue to import `@AGENTS.md`
- Ensure `.claude/commands/` exists and points at `.agent-scripts/prompts/*` (create if missing)

## Step 1 — Repo scan (read-only)

1) Re-discover the real dev/test/lint/build commands from package scripts, make/just/task runner, or CI.
2) Identify any new high-risk areas (migrations/auth/infra/secrets).
3) Check whether `AGENTS.md` has drifted (wrong commands, missing guardrails, too long, contradictory).

## Step 2 — Minimal edits only

Rules:
- Do not rewrite `AGENTS.md` from scratch.
- Prefer replacing incorrect lines over adding new sections.
- Keep `AGENTS.md` short (target ≤120 lines unless Kenneth approves longer).

## Step 3 — Validate Claude wrapper

Ensure `CLAUDE.md` is present and is (or stays) the minimal wrapper:

```md
# Repo memory
@AGENTS.md
```

## Step 4 — Ensure slash commands exist

If missing, create:
- `.claude/commands/bootstrap-instructions.md` → `@.agent-scripts/prompts/REPO_BOOTSTRAP_INSTRUCTIONS.md`
- `.claude/commands/update-instructions.md` → `@.agent-scripts/prompts/REPO_UPDATE_INSTRUCTIONS.md`
- `.claude/commands/distill-instructions.md` → `@.agent-scripts/prompts/REPO_DISTILL_INSTRUCTIONS.md`

## Step 5 — Show patch and ask for approval

Output:
1) What changed in the repo (commands/CI/risk areas).
2) The minimal patch/diff you propose.
3) Ask Kenneth: “Apply this patch?”
