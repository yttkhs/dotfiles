#!/bin/bash
set -euo pipefail

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
[ -z "$FILE" ] && exit 0
[ -e "$FILE" ] || exit 0

ABS_FILE=$(cd -- "$(dirname -- "$FILE")" 2>/dev/null && pwd)/$(basename -- "$FILE")

if pgrep -x Zed >/dev/null 2>&1; then
  zed --existing "$ABS_FILE"
  exit 0
fi

GIT_ROOT=$(cd -- "$(dirname -- "$ABS_FILE")" 2>/dev/null && git rev-parse --show-toplevel 2>/dev/null || true)

if [ -n "${GIT_ROOT:-}" ]; then
  zed "$GIT_ROOT" "$ABS_FILE"
else
  zed "$ABS_FILE"
fi
