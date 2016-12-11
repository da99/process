
source "$THIS_DIR/bin/public/group-of/_.sh"
source "$THIS_DIR/bin/public/childs/_.sh"
# === {{CMD}}  PID
# ===    Gets the GPID of process id
# ===    and uses that to print a tree.
# ===    If no GPID found, then PID is used.
tree () {
  local +x PID="$1"; shift
  local +x GPID="$(group-of $PID || :)"

  if [[ -z "$GPID" ]]; then
    childs $PID
    return
  fi

  childs $GPID
} # === end function
