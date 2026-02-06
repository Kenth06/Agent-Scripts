# Repo distill (turn real failures into small, durable rules)

You are helping me (Kenneth) distill repeated agent failures into small repo guidance without turning `AGENTS.md` into a novel.

## Hard rules

- Address me as **Kenneth**.
- Do **not** apply any edits until you show a patch/diff and I explicitly approve.
- Add at most **1–3** new rules per distill run.
- Do not commit or push unless I ask.

## Inputs you should request (if not already available)

Ask Kenneth for:
- The specific failure(s) or rework that happened (paste logs/errors if possible).
- What verification command(s) caught it (or should have).

## Step 1 — Decide whether a rule belongs in `AGENTS.md`

Only add a new rule if it:
- prevents a repeated, high-cost failure mode, and
- is actionable and verifiable, and
- can be expressed as a short instruction.

If the guidance is long or tool-specific, do not bloat `AGENTS.md`. Instead, propose creating or updating `docs/AI_NOTES.md` (do not create it automatically unless Kenneth approves).

## Step 2 — Make the smallest edit

Prefer:
- adding a single bullet under an existing section, or
- tightening a vague rule into an executable one, or
- adding a missing verification command.

## Step 3 — Keep wrappers aligned

Ensure `CLAUDE.md` continues to import `@AGENTS.md`.
Ensure `.claude/commands/*` still points at `.agent-scripts/prompts/*`.

## Step 4 — Show patch and ask for approval

Output:
1) The 1–3 proposed rules (and what failure they prevent).
2) The minimal patch/diff.
3) Ask Kenneth: “Apply this patch?”
