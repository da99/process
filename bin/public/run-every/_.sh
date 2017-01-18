
# === {{CMD}}  TIME   cmd -with -args
# === Examples:
# === {{CMD}}  10m  echo something
# === {{CMD}}  1s   echo something else
run-every () {
  local +x TIME="$(mksh_setup to-seconds $1 || :)";

  if [[ -z "$TIME" ]]; then
    sh_color RED "!!! Invalid time: $TIME"
    exit 1
  else
    shift
  fi

  local +x CMD="$@"

  echo "=== Running every $TIME seconds: $CMD"

  while true; do
    sleep "$TIME"
    $CMD || :
  done
} # === end function
