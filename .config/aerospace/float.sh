#!/usr/bin/env bash

# This seems to only work a single pip window at a time for now

ws=${1:-$AEROSPACE_FOCUSED_WORKSPACE}

IFS=$'\n' all_wins=$(aerospace list-windows --all --format '%{window-id}|%{app-name}|%{window-title}|%{monitor-id}|%{workspace}')
IFS=$'\n' all_ws=$(aerospace list-workspaces --all --format '%{workspace}|%{monitor-id}')

# Array of possible window titles
# pip_titles=("Picture-in-picture" "Picture-in-Picture" "Picture in Picture" "Picture in picture")
pip_titles=("Picture-in-Picture")

# Function to find matching PIP windows
find_pip_windows() {
  local titles=("$@")
  local result=""
  for title in "${titles[@]}"; do
    local matches
    matches=$(printf '%s\n' "$all_wins" | grep "$title")
    result="$result"$'\n'"$matches"
  done
  echo "$result" | sed '/^\s*$/d' # Remove empty lines
}

pip_wins=$(find_pip_windows "${pip_titles[@]}")
target_mon=$(printf '%s\n' "$all_ws" | grep "^$ws" | cut -d'|' -f2 | xargs)

move_win() {
  local win="$1"

  [[ -n $win ]] || return 0

  local win_mon
  win_mon=$(echo "$win" | cut -d'|' -f4 | xargs)
  local win_id
  win_id=$(echo "$win" | cut -d'|' -f1 | xargs)
  local win_ws
  win_ws=$(echo "$win" | cut -d'|' -f5 | xargs)

  # Skip if the monitor is already the target monitor or if the workspace matches
  [[ $target_mon != "$win_mon" ]] && return 0
  [[ $ws == "$win_ws" ]] && return 0

  aerospace move-node-to-workspace --window-id "$win_id" "$ws"
}

# Process each PIP window found
for win in $pip_wins; do
  move_win "$win"
done
