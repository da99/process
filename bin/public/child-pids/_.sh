
# === {{CMD}}  PID
# === {{CMD}}  PID [args to: ps -p PID ...]
# ===   You can then get info on each PID using xargs:
# ===   Any other way, and you will get sub-processes/sub-shells.
# ===   Example:  {{CMD}} | xargs ...     # ==> Prints out PIDs of xargs
# ===   Example:  while ... done < <({{CMD}}) # ==> Prints out PIDs of '<(my_bash ...)'
child-pids () {
    target="$1"
    shift
    this_pid="$$"

    raw="$(pstree -p $target)"
    while read PID
    do
      if [[ "$PID" != "$target" && "$PID" != "$this_pid" ]] && ps --pid $PID &>/dev/null; then
        if [[ -z "$@" ]]; then
          echo $PID
        else
          ps -p $PID "$@"
        fi
      fi
    done < <(echo "$raw" | grep -o '([0-9]\+)' | grep -o '[0-9]\+' )

} # === end function

