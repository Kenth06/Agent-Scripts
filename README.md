# Agent Scripts

This repo mirrors shared agent helpers and skills.

## Workflow (Early 2026)

- Guide: `docs/WORKFLOW_EARLY_2026.md`
- Meta-prompt: `prompts/AGENTS_MD_META_PROMPT.md`

## Browser Tools

- Source: `skills/browser-tools/scripts/browser-tools.ts`
- Build: `scripts/build-browser-tools.sh`
- Binary: `skills/browser-tools/bin/browser-tools` (not tracked)

Rebuild locally when the script changes. The build script creates a temporary workspace, installs deps, compiles, and copies the binary.
