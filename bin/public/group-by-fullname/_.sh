
# === {{CMD}}  "cmd for pgrep -f"
proc-group () {
local +x SIGNAL="-SIGINT"

  if [[ "$1" == '-'*  ]]; then
    local +x SIGNAL="$1" ; shift
  fi

  local +x CMD="$@" ;
  local +x ME=$$

  pgrep -f "$CMD" | grep -v $ME | xargs -I ID pstree -a -A  -p -g ID | grep -P "^[^[:space:]].+${CMD}$" | cut -d',' -f3 | cut -d' ' -f1 | sort | uniq
} # === end function
