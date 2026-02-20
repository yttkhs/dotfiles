#!/bin/bash
# 通知クリック時: tmuxセッション/ウィンドウ/ペイン切り替え → Ghosttyアクティブ化
TMUX=/opt/homebrew/bin/tmux
CLICK_INFO="$1"

# ファイルからtmux情報を読み取る
if [ -f "$CLICK_INFO" ]; then
  TMUX_SESSION=$(sed -n '1p' "$CLICK_INFO")
  PANE_ID=$(sed -n '2p' "$CLICK_INFO")
fi

CLIENT=$($TMUX list-clients -F '#{client_name}' 2>/dev/null | head -1)

if [ -n "$CLIENT" ] && [ -n "$PANE_ID" ]; then
  WINDOW=$($TMUX display-message -t "$PANE_ID" -p '#{session_name}:#{window_index}' 2>/dev/null)
  TARGET="${WINDOW:-$TMUX_SESSION}"
  $TMUX switch-client -c "$CLIENT" -t "$TARGET" 2>/dev/null
  $TMUX select-pane -t "$PANE_ID" 2>/dev/null
elif [ -n "$CLIENT" ] && [ -n "$TMUX_SESSION" ]; then
  $TMUX switch-client -c "$CLIENT" -t "$TMUX_SESSION" 2>/dev/null
fi

open -a Ghostty
