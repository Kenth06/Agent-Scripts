---
name: browser-tools
description: Lightweight Chrome DevTools helper CLI for local web app testing and browser automation. Use when you need to launch Chrome with remote debugging, navigate tabs, evaluate JS in-page, capture screenshots, pick DOM elements, read console logs, dump cookies, or inspect/kill DevTools sessions via a small TypeScript CLI.
---

# Browser Tools

## Use

- Use `bin/browser-tools` for compiled usage.
- Use `scripts/browser-tools.ts` with `ts-node` for quick edits.
- Rebuild binary after script changes:

```bash
bun build scripts/browser-tools.ts --compile --target bun --outfile bin/browser-tools
```

## Core Commands

- `start`: launch Chrome with `--remote-debugging-port`.
- `nav`: navigate current tab or open a new tab.
- `eval`: evaluate JavaScript in active page context.
- `screenshot`: capture current viewport to a temp PNG.
- `pick`: interactively pick DOM elements and print metadata.
- `console`: stream or capture console logs (filter by type).
- `search`: Google search + optional readable content extraction.
- `content`: readable content extraction for a URL.
- `cookies`: dump cookies for the active tab.
- `inspect`: list DevTools-enabled Chrome sessions and tabs.
- `kill`: terminate DevTools-enabled Chrome sessions.

## Recommended Workflow

1. Start Chrome (optional profile copy for authenticated sessions):

```bash
bin/browser-tools start --port 9222 --profile
```

2. Navigate to the app:

```bash
bin/browser-tools nav http://localhost:3000
```

3. Use `eval`, `pick`, `console`, or `screenshot` to debug and capture evidence.

## Notes

- Keep usage local (e.g., `localhost`) unless the user explicitly requests remote targets.
- When you edit `scripts/browser-tools.ts`, rebuild the binary before use.
