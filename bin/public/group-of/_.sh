
# === {{CMD}}  PID
# ===   FROM: https://coderwall.com/p/q-ovnw/killing-all-child-processes-in-a-shell-script
group-of () {
  local +x PID="$1"; shift
  ps -o pgid= $PID | grep -o '[0-9]*'
} # === end function
