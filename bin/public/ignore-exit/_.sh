
# === {{CMD}}  NUM   cmd with args
ignore-exit () {
  local +x NUM="$1"; shift

  "$@" || {
    local +x STAT="$?"
    if [[ "$STAT" -ne "$NUM" ]]; then
      exit "$STAT"
    fi
  }
} # === end function
