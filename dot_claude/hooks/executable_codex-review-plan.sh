#!/bin/bash
# PostToolUse hook: Auto-review plans with OpenAI Codex when ExitPlanMode is called.
# Reads hook input from stdin, runs codex exec, outputs a systemMessage JSON.

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')

# Only run for ExitPlanMode
if [ "$TOOL_NAME" != "ExitPlanMode" ]; then
  exit 0
fi

# Find latest plan file
PLAN_FILE=$(ls -t ~/.claude/plans/*.md 2>/dev/null | head -1)
if [ -z "$PLAN_FILE" ]; then
  exit 0
fi

PLAN_CONTENT=$(cat "$PLAN_FILE")
RESULT_FILE=$(mktemp /tmp/codex-plan-review-XXXXXX.txt)

# Run Codex review
cat << PROMPT_END | codex exec - --full-auto --sandbox read-only -o "$RESULT_FILE" 2>/dev/null
Review this implementation plan for completeness, correctness, risks, and suggest improvements.
Be concise. Format: list issues with severity (CRITICAL/WARNING/SUGGESTION), then overall verdict.

Plan:
$PLAN_CONTENT
PROMPT_END

REVIEW=$(cat "$RESULT_FILE" 2>/dev/null)
rm -f "$RESULT_FILE"

if [ -n "$REVIEW" ]; then
  jq -n --arg review "$REVIEW" '{
    "systemMessage": ("Codex Plan Review Results:\n\n" + $review + "\n\nPlease present these Codex review results to the user before they decide on plan approval.")
  }'
fi
