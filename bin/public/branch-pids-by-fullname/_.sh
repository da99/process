
# === {{CMD}}               "cmd for grep"
# === {{CMD}}  --except PID "cmd for grep"
branch-pids-by-fullname () {
  local +x EXCLUDE="none"
  local +x ME="$$"

  if [[ "$1" == "--exclude" ]]; then
    shift
    local +x EXCLUDE="$1"; shift
  fi

  local +x CMD="$@"

  for PID in $(pgrep -f "$CMD" | grep -v --extended-regexp "$EXCLUDE|$ME") ; do
    pstree -a -A  -p -g $PID || :
  done  | cut -d',' -f1- #| sort -n | uniq | sort -n -r

} # === end function


