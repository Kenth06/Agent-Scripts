# Meta-prompt: generate an excellent `AGENTS.md` + `CLAUDE.md`

Copy/paste this into Codex or Claude Code inside the target repo.

---

You are an agentic coding assistant helping me (Kenneth) create a great repo-level constitution for **both**:
- OpenAI Codex (driven by `AGENTS.md`)
- Anthropic Claude Code (driven by `CLAUDE.md`)

## Output requirements

Return **only** file contents for:
1) `AGENTS.md`
2) `CLAUDE.md`

Constraints:
- Target **≤120 lines** for `AGENTS.md` unless I explicitly approve longer.
- Prefer **executable instructions** (“run X, then Y”) over vague rules.
- No aspirational rules without an enforcement mechanism (tests, CI, hooks, scripts).
- If information is missing, ask questions instead of guessing.

## Step 1 — Repo scan (read-only)

Find and summarize:
- Tech stack (languages/frameworks)
- Real commands (dev/test/lint/build) from package scripts, Makefile/justfile/task runner, or CI config
- How tests run in CI (what’s required to be green)
- Files/dirs that are high-risk (migrations, auth, infra, secrets, generated code)

## Step 2 — Ask the minimum questions (max 8)

Only ask questions that materially change the constitution. Must include:
1) What I’m optimizing for (speed vs safety vs team consistency vs cost)
2) The required verification loop (exact commands and/or manual checks)
3) Forbidden edits (files/dirs that must not be touched)
4) Any “always ask before doing X” categories (rewrites, deletes, schema changes, security/auth, etc.)

## Step 3 — Write `AGENTS.md`

Must include these sections:
1) **Purpose** (1–2 lines)
2) **How we work** (plan → implement → verify; always paste verification output)
3) **Key commands** (dev/test/lint/build; copy/paste ready)
4) **Guardrails** (what not to touch, when to stop and ask)
5) **Delegation patterns** (Explorer / Implementer / Verifier / Reviewer; short templates)
6) **Repo map** (5–10 important paths + what they contain)

Keep the tone pragmatic and short.

## Step 4 — Write `CLAUDE.md` (single-source-of-truth wrapper)

Prefer the minimal wrapper that keeps Claude aligned with the repo constitution:

```md
# Repo memory
@AGENTS.md
```

## Step 5 — Quality check before final output

Confirm:
- Commands exist in the repo.
- There are no contradictions.
- Nothing is “policy for policy’s sake”; each rule prevents a real failure mode.
---
