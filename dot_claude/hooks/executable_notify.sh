#!/bin/bash
INPUT=$(cat)

# Stop hookの無限ループ防止
if [ "$(echo "$INPUT" | jq -r '.stop_hook_active // false')" = "true" ]; then
  exit 0
fi

EVENT="$1"
case "$EVENT" in
  Finished) SOUND="Hero" ;;
  Waiting)  SOUND="Tink" ;;
  *)        SOUND="default" ;;
esac
SESSION=$(echo "$INPUT" | jq -r '.session_id // "default"')
CWD=$(echo "$INPUT" | jq -r '.cwd // ""')
REPO=$(basename "$(git -C "$CWD" rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo "")

# メッセージ取得: hook入力 → transcript → フォールバック
MESSAGE=$(echo "$INPUT" | jq -r '.last_assistant_message // .message // empty' 2>/dev/null)
if [ -z "$MESSAGE" ]; then
  TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path // empty' 2>/dev/null)
  if [ -n "$TRANSCRIPT" ] && [ -f "$TRANSCRIPT" ]; then
    MESSAGE=$(grep '"type":"assistant"' "$TRANSCRIPT" \
      | jq -c 'select(.message.content | any(.type=="text"))' \
      | tail -1 \
      | jq -r '[.message.content[] | select(.type=="text") | .text] | join(" ")' 2>/dev/null)
  fi
fi
MESSAGE=$(echo "${MESSAGE:-DONE}" | tr '\n' ' ' | sed 's/  */ /g' | cut -c1-100)

# クリック時のアクション
if [ -n "${TMUX_PANE:-}" ]; then
  TMUX_SESSION=$(tmux display-message -p '#S' 2>/dev/null)
  if [ -n "$TMUX_SESSION" ]; then
    # tmux情報をファイルに保存してクリックハンドラから読み取る
    CLICK_INFO="/tmp/claude-notify-${SESSION}"
    printf '%s\n%s' "$TMUX_SESSION" "$TMUX_PANE" > "$CLICK_INFO"
    terminal-notifier \
      -title "Claude Code" \
      -subtitle "${REPO:+$REPO - }${EVENT}" \
      -message "$MESSAGE" \
      -sound "$SOUND" \
      -group "claude-$SESSION" \
      -appIcon /Applications/Claude.app/Contents/Resources/AppIcon.icns \
      -execute "$HOME/.claude/hooks/notify-click.sh $CLICK_INFO"
    exit 0
  fi
fi

terminal-notifier \
  -title "Claude Code" \
  -subtitle "${REPO:+$REPO - }${EVENT}" \
  -message "$MESSAGE" \
  -sound "$SOUND" \
  -group "claude-$SESSION" \
  -appIcon /Applications/Claude.app/Contents/Resources/AppIcon.icns \
  -activate com.mitchellh.ghostty
