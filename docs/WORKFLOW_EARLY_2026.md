# The Claude Code + Codex workflow (early 2026)

This is a practical workflow guide for running Claude Code and OpenAI Codex as a small “agent team” without drowning in context or process.

## What changed in Jan–Feb 2026 (worth incorporating)

- **Codex app shipped** (Feb 2026): a supervisor UI for parallel coding agents and worktrees. Read: [Introducing the Codex app (OpenAI)](https://openai.com/index/introducing-the-codex-app/) and [Ars Technica coverage](https://arstechnica.com/ai/2026/02/openai-unleashes-codex-its-most-powerful-ai-coding-agent-yet/).
- **Claude Code “agent teams” docs appeared** (Feb 2026): an experimental multi-agent coordination mode. Read: [Claude Code agent teams](https://code.claude.com/docs/en/agent-teams).
- **GitHub started integrating multiple agent vendors** (Feb 2026): useful for how you think about “agent mode” workflows in general. Read: [The Verge on Copilot agent mode + Codex/Claude](https://www.theverge.com/news/609599/github-copilot-agent-mode-openai-codex-anthropic-claude).

## The core loop (works in both tools)

**Plan → Parallelize → Execute → Verify → Review → Distill**

1) **Plan**
   - State the goal, constraints, and “done means…”.
   - Explicitly list how to verify (commands, URLs, manual checks).
   - Codex prompting guidance: [Prompting Codex](https://developers.openai.com/codex/guides/codex-prompting) and [Prompting](https://developers.openai.com/codex/guides/prompting).

2) **Parallelize (small, bounded roles)**
   - Explorer: map the relevant files and risks.
   - Implementer: make changes.
   - Verifier: run checks and report raw failures.
   - Reviewer: scan diff for edge cases + regressions.

3) **Execute**
   - Keep each agent’s task scoped to avoid “merge hell”.

4) **Verify**
   - Don’t accept “should work”. Require the actual command output.
   - The fastest teams treat tests/linters as the agent’s feedback loop, not a human-only step.

5) **Review**
   - Your job is to review deltas and product behavior, not to babysit keystrokes.

6) **Distill**
   - When an agent repeats an error, turn the fix into:
     - a one-liner in `AGENTS.md` / `CLAUDE.md`, or
     - a small script/skill, or
     - a CI check.

## Project constitution: keep one source of truth

### Codex: `AGENTS.md` (plus optional overrides)

Codex looks for instructions by walking up directories and reading `AGENTS.md` or `AGENTS.override.md`, with additional fallbacks configurable. See: [AGENTS.md in Codex](https://developers.openai.com/codex/cli/agents-md).  
If you want per-user rules without changing the repo, Codex supports a global `AGENTS.override.md` (and a global `AGENTS.md`) under your Codex home directory. See the same doc.

### Claude Code: `CLAUDE.md` memory + `@` imports

Claude Code supports project “memory” and file imports via `@path`. See: [Claude Code memory](https://docs.anthropic.com/en/docs/claude-code/memory).  
Practical pattern: keep a repo `CLAUDE.md` that imports `@AGENTS.md`, so both tools share one constitution.

## Context management (the thing that actually drives quality)

- Keep your constitution **short**; push large details into docs or skills and reference them.
- Prefer **fresh contexts for fresh tasks**. If the conversation is polluted:
  1) write a short “handoff” note (goal, current state, next steps, verification commands) to a file,
  2) start a new session and read that file.
- When you need “long memory”, store it in the repo (docs/skills), not in the chat transcript.

## Parallelism with worktrees (one agent per worktree)

Codex’s recommended pattern is to isolate work in worktrees for parallel changes. See: [Codex worktrees](https://developers.openai.com/codex/app/worktrees).

Suggested convention:
- One worktree per agent, named by task + role (e.g., `wt/login-bug/impl`, `wt/login-bug/test`).
- No two agents edit the same high-churn files concurrently.

Git example:

```bash
# from repo root
git worktree add ../repo-wt-login-impl -b wt/login-impl
git worktree add ../repo-wt-login-test -b wt/login-test
```

## Claude Code orchestration

### Sub-agents

Use sub-agents for bounded tasks that report back (explore, targeted implementation, review). Read: [Claude Code sub-agents](https://docs.anthropic.com/en/docs/claude-code/sub-agents).

### Agent teams (experimental)

Use agent teams when work needs tight multi-agent coordination (cross-layer refactors, competing hypotheses debugging). Read: [Claude Code agent teams](https://code.claude.com/docs/en/agent-teams).

### Hooks + slash commands (worth it if they enforce quality)

- Hooks let you run deterministic steps around tool use (format, lint, safety checks). Read: [Claude Code hooks reference](https://docs.anthropic.com/en/docs/claude-code/hooks) and [Anthropic engineering: Hooks](https://www.anthropic.com/engineering/hooks).
- Claude Code supports built-in slash commands; use them to keep workflows consistent. Read: [Claude Code slash commands](https://docs.anthropic.com/en/docs/claude-code/slash-commands).

Rule of thumb: only add hooks/commands that (a) save time weekly and (b) reduce regressions.

## Codex orchestration

### Delegate as an “AI team”

Codex’s official guide recommends splitting work into clear roles and using parallel agents where it helps. Read: [Building AI Teams](https://developers.openai.com/codex/guides/building-ai-teams).

### Use worktrees for concurrency

If you want maximum throughput, isolate agents in worktrees and merge via review, not by interleaving edits in one working copy. See: [Codex worktrees](https://developers.openai.com/codex/app/worktrees).

## MCP vs tiny CLIs (default: start tiny)

Peter Steinberger’s practical advice is to reduce friction and keep integrations lightweight (often by building tiny CLIs instead of elaborate toolchains). Read:  
- [Shipping at inference speed](https://steipete.com/posts/shipping-at-inference-speed/)  
- [Live coding session: building Arena](https://steipete.com/posts/live-coding-session-building-arena/)

Default recommendation:
- Start with **zero or one** integration.
- Add more only when you can name the repetitive pain it eliminates.

## Safety + permissions (don’t turn “automation” into “oops”)

- Hooks and headless modes can run arbitrary commands. Treat them like production scripts.
- Add a hard rule: ask before destructive actions (deletes, rewrites, migrations, auth/security changes).

## Sharing instructions across many repos (choose the lightest thing that works)

- **Git submodule** (cross-tool): one canonical repo (e.g. `.agent-scripts/`) plus a tiny wrapper `AGENTS.md` per project.
- **Codex Team Config** (Codex-only): centralize shared config for multiple repos. See: [Codex Team Config](https://developers.openai.com/codex/guides/team-config).
- **Copy/paste**: last resort unless you have a sync mechanism; drift is real.

## Automation (bootstrap / update / distill)

The goal is to make “keep `AGENTS.md` / `CLAUDE.md` accurate” a repeatable on-demand action.

Canonical prompts live in `.agent-scripts/prompts/`:
- `REPO_BOOTSTRAP_INSTRUCTIONS.md`
- `REPO_UPDATE_INSTRUCTIONS.md`
- `REPO_DISTILL_INSTRUCTIONS.md`

Design rules:
- Always propose a patch/diff and ask for approval before writing.
- Make the smallest changes that reflect repo reality (commands/CI/guardrails).
- Keep `AGENTS.md` short; move long guidance into docs or skills.

### New repo flow

1) Add submodule:

```bash
git submodule add https://github.com/Kenth06/Agent-Scripts.git .agent-scripts
```

2) In **Codex or Claude Code**, run the bootstrap prompt:
- Claude Code: paste `@.agent-scripts/prompts/REPO_BOOTSTRAP_INSTRUCTIONS.md`
- Codex: “Read and follow `.agent-scripts/prompts/REPO_BOOTSTRAP_INSTRUCTIONS.md`”

Result:
- `AGENTS.md` wrapper + `CLAUDE.md` wrapper exist
- Claude Code gets `/bootstrap-instructions`, `/update-instructions`, `/distill-instructions` via `.claude/commands/`

### Existing repo flow

- Update commands/guardrails:
  - Claude Code: run `/update-instructions`
  - Codex: “Read `.agent-scripts/prompts/REPO_UPDATE_INSTRUCTIONS.md` and follow it”
- Distill a repeated failure into 1–3 durable rules:
  - Claude Code: run `/distill-instructions`
  - Codex: “Read `.agent-scripts/prompts/REPO_DISTILL_INSTRUCTIONS.md` and follow it”

## Copy/paste bootstrap for a new repo (portable via git submodule)

This is the “shared constitution + per-repo wrapper” pattern.

1) Add this repo as a submodule:

```bash
git submodule add https://github.com/Kenth06/Agent-Scripts.git .agent-scripts
```

2) Add `AGENTS.md` in the target repo root (wrapper):

```md
# Repo Agent Instructions

Read and follow `.agent-scripts/AGENTS.md` first.

## Repo-specific commands
- Dev: <fill in>
- Test: <fill in>
- Lint: <fill in>

## Repo-specific guardrails
- Never modify: <fill in>
```

3) Add `CLAUDE.md` in the target repo root (wrapper):

```md
# Repo memory
@AGENTS.md
```

Rationale: portable across machines and cloud sandboxes, avoids copy/paste drift, and keeps Codex + Claude aligned on one source of truth.

## Suggested delegation prompt templates

### Explorer (read-only)

“Explore the codebase for {goal}. Output:
1) the 5–10 most relevant files,
2) key risks/edge cases,
3) the exact verification command(s) I should run,
4) a short implementation plan.”

### Implementer

“Implement {goal}. Constraints: {constraints}. After changes, run {verification commands} and paste the output.”

### Verifier

“Run {verification commands} and paste raw output. If failing, propose the smallest fix and re-run until green.”

### Reviewer

“Review the diff for correctness, edge cases, and unintended changes. Call out anything risky or unclear.”

## Further reading (high-signal)

- OpenAI Codex CLI + AGENTS: [Codex CLI](https://developers.openai.com/codex/cli) and [AGENTS.md guide](https://developers.openai.com/codex/cli/agents-md)  
- Codex app + worktrees: [Codex app announcement](https://openai.com/index/introducing-the-codex-app/) and [worktrees](https://developers.openai.com/codex/app/worktrees)  
- Anthropic Claude Code docs: [memory](https://docs.anthropic.com/en/docs/claude-code/memory), [sub-agents](https://docs.anthropic.com/en/docs/claude-code/sub-agents), [hooks](https://docs.anthropic.com/en/docs/claude-code/hooks), [slash commands](https://docs.anthropic.com/en/docs/claude-code/slash-commands)  
- Practitioner workflow: [steipete’s posts](https://steipete.com/posts/)
- Practitioner workflow context (Claude Code): [InfoQ on Claude Code](https://www.infoq.com/news/2025/02/claude-code/) and [The Verge interview](https://www.theverge.com/ai-artificial-intelligence/613490/anthropic-ceo-ai-claude-coding-software-developers)
