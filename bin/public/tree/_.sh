
source "$THIS_DIR/bin/public/group-of/_.sh"

# === {{CMD}}  PID
# ===    Gets the GPID of process id
# ===    and uses that to print a tree.
# ===    If no GPID found, then PID is used.
tree () {
  local +x PID="$1"; shift
  local +x GPID="$(group-of $PID || :)"

  if [[ -z "$GPID" ]]; then
    print-tree $PID
    return
  fi

  print-tree $GPID
} # === end function


print-tree () {
  pstree -a -A  -p -g $1
}
