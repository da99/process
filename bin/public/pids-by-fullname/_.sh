
# === {{CMD}}               "cmd for grep"
# === {{CMD}}  --except PID "cmd for grep"
pids-by-fullname () {
  local -x EXCLUDE="none"
  if [[ "$1" == '--except' ]]; then
    shift
    EXCLUDE="$1"; shift
  fi

  local +x CMD="$@"
  local +x ME="$$"

  pgrep -f "$CMD" | grep -v --extended-regexp "$EXCLUDE|$ME"
} # === end function
