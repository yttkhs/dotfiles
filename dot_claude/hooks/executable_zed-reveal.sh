#!/bin/bash
set -euo pipefail

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
[ -z "$FILE" ] && exit 0
[ -e "$FILE" ] || exit 0

ABS_FILE=$(cd -- "$(dirname -- "$FILE")" 2>/dev/null && pwd)/$(basename -- "$FILE")

GIT_ROOT=$(cd -- "$(dirname -- "$ABS_FILE")" 2>/dev/null && git rev-parse --show-toplevel 2>/dev/null || true)

if [ -n "${GIT_ROOT:-}" ]; then
  open -g -b dev.zed.Zed "$GIT_ROOT"
  sleep 0.15
fi

open -g -b dev.zed.Zed "$ABS_FILE"
