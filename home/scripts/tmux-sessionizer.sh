#!/usr/bin/env bash

set -euo pipefail

from_binding=0
if [[ "${1:-}" == "--from-binding" ]]; then
  from_binding=1
  shift
fi

build_roots() {
  local -a roots=()

  if [[ -n "${TMUX_SESSIONIZER_ROOTS:-}" ]]; then
    IFS=':' read -r -a roots <<< "${TMUX_SESSIONIZER_ROOTS}"
  else
    roots=(
      "$HOME/Projects"
      "$HOME/Scripts"
    )
  fi

  local -a existing=()
  local root
  for root in "${roots[@]}"; do
    [[ -d "$root" ]] || continue
    existing+=("$root")
  done

  printf '%s\n' "${existing[@]}"
}

pick_directory() {
  if [[ $# -gt 0 && -n "${1:-}" ]]; then
    printf '%s\n' "$1"
    return 0
  fi

  mapfile -t roots < <(build_roots)
  if [[ ${#roots[@]} -eq 0 ]]; then
    echo "tmux-sessionizer: no search roots found" >&2
    exit 1
  fi

  {
    local root
    for root in "${roots[@]}"; do
      printf '%s\n' "$root"
      fd . "$root" --type d --max-depth 2 2>/dev/null
    done
  } | awk 'NF && !seen[$0]++' | fzf --prompt='Project > ' --height=40% --layout=reverse --border
}

session_name_from_path() {
  local path="$1"
  local name

  name="$(basename "$path")"
  name="${name//./_}"
  name="${name// /_}"
  name="$(printf '%s' "$name" | tr -c '[:alnum:]_-' '_')"

  if [[ -z "$name" ]]; then
    name="main"
  fi

  printf '%s\n' "$name"
}

main() {
  local selected
  selected="$(pick_directory "$@")" || exit 0
  [[ -n "$selected" ]] || exit 0

  if [[ ! -d "$selected" ]]; then
    echo "tmux-sessionizer: directory not found: $selected" >&2
    exit 1
  fi

  local session_name
  session_name="$(session_name_from_path "$selected")"

  if ! tmux has-session -t="$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name" -c "$selected"
  fi

  if [[ -n "${TMUX:-}" ]]; then
    local origin_window=""
    if [[ $from_binding -eq 1 ]]; then
      origin_window="$(tmux display-message -p '#{window_id}')"
    fi

    tmux switch-client -t "$session_name"

    if [[ -n "$origin_window" ]]; then
      tmux kill-window -t "$origin_window" 2>/dev/null || true
    fi
    return 0
  fi

  exec tmux attach-session -t "$session_name"
}

main "$@"
