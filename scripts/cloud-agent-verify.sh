#!/usr/bin/env bash
# Quick health check for the Cloud Agent development environment.
set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"

echo "== Kid Sketchbook Cloud Agent verify =="
echo "graft: $(graft version 2>&1 | head -1)"
echo

graft check
graft map --max-dirs 3
graft ask "where is the drawing canvas" --source -n 1

echo
echo "OK — graft CLI and code graph are ready."
echo "Note: iOS builds require Xcode on macOS (see AGENTS.md)."
