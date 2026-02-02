#!/usr/bin/env bash
# ABOUTME: Build the browser-tools binary from the TypeScript source in a clean temp workspace.
# ABOUTME: Installs deps transiently and writes the compiled binary to skills/browser-tools/bin.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_DIR="$ROOT_DIR/skills/browser-tools"
SRC_FILE="$SKILL_DIR/scripts/browser-tools.ts"
OUT_DIR="$SKILL_DIR/bin"

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

mkdir -p "$WORKDIR/scripts" "$OUT_DIR"
cp "$SRC_FILE" "$WORKDIR/scripts/browser-tools.ts"

cat <<'JSON' > "$WORKDIR/package.json"
{
  "name": "browser-tools-build",
  "private": true,
  "type": "module",
  "dependencies": {
    "commander": "^11.1.0",
    "puppeteer-core": "^23.5.0"
  }
}
JSON

cd "$WORKDIR"
bun install --silent
bun build scripts/browser-tools.ts --compile --target bun --outfile "$OUT_DIR/browser-tools"
