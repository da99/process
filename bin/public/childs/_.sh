
# === {{CMD}} PID
childs () {
  local +x PID="$1"; shift
  pstree -a -A  -p -g $PID
} # === end function
