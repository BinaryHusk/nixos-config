typeset -g _TERM_CLIP_FILE="${XDG_RUNTIME_DIR:-/tmp}/term-clip-${UID}"

yy() {
  if (( $# != 1 )); then
    print -u2 "usage: yy <file>"
    return 2
  fi

  local target="${1:A}"
  if [[ ! -f "$target" ]]; then
    print -u2 "yy: file not found: $1"
    return 1
  fi

  print -r -- "$target" >| "$_TERM_CLIP_FILE"
  print -r -- "marked: $target"
}

pp() {
  if [[ ! -r "$_TERM_CLIP_FILE" ]]; then
    print -u2 "pp: no file has been marked"
    return 1
  fi

  local target="$(< "$_TERM_CLIP_FILE")"
  if [[ ! -f "$target" ]]; then
    print -u2 "pp: marked file no longer exists: $target"
    return 1
  fi

  cp -iv -- "$target" .
}
