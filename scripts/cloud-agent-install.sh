#!/usr/bin/env bash
# Idempotent Cloud Agent bootstrap for Kid Sketchbook.
# Installs the graft CLI and builds the local code graph (graft/ is gitignored).
set -euo pipefail

export NPM_CONFIG_PREFIX="${NPM_CONFIG_PREFIX:-$HOME/.local}"
export PATH="$HOME/.local/bin:$PATH"

if ! command -v graft >/dev/null 2>&1; then
  npm install -g @nanonets/graft
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

graft build .
