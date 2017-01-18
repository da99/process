
# === {{CMD}}              cmd -with -args
# === {{CMD}}  X[s|m|h|d]  cmd -with -args
run-every-until () {
  local +x TIME="30s"
  if echo "$1" | grep -P "^\d+" ; then
    TIME="$1"; shift
  fi

  local +x CMD="$@"
  local +x SECS="$(mksh_setup to-seconds "$TIME")"

  while ! $CMD ; do
    sleep "$SECS"
  done
} # === end function
