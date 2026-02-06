# Agent Scripts

This repo mirrors shared agent helpers and skills.

## Workflow (Early 2026)

- Guide: `docs/WORKFLOW_EARLY_2026.md`
- Meta-prompt: `prompts/AGENTS_MD_META_PROMPT.md`
- Automation prompts:
  - Bootstrap: `prompts/REPO_BOOTSTRAP_INSTRUCTIONS.md` (new repo setup + `.claude/commands/`)
  - Update: `prompts/REPO_UPDATE_INSTRUCTIONS.md` (refresh commands/guardrails; use `/update-instructions`)
  - Distill: `prompts/REPO_DISTILL_INSTRUCTIONS.md` (add 1–3 durable rules after failures; use `/distill-instructions`)

## Browser Tools

- Source: `skills/browser-tools/scripts/browser-tools.ts`
- Build: `scripts/build-browser-tools.sh`
- Binary: `skills/browser-tools/bin/browser-tools` (not tracked)

Rebuild locally when the script changes. The build script creates a temporary workspace, installs deps, compiles, and copies the binary.
