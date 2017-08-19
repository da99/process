#
# === {{CMD}} every SLEEP max X or until MY CMD --ARGS
#

loop () {
  unset -f loop
  local +x origin="$@"

  case "$(echo $@ | xargs echo -n)" in
    "every "*" max "*" or until "*)
      shift; local +x SLEEP="$1"
      shift; shift; local +x MAX="$1"
      shift; shift; shift; local +x CMD="$@"
      if [[ "$MAX" -lt 1 ]]; then
        echo "!!! Invalid max, $MAX, for: loop $origin" >&2
        exit 5
      fi
      local +x COUNT=0
      while [[ "$COUNT" -lt "$MAX" ]]; do
        sleep $SLEEP
        COUNT="$((COUNT + 1))"
        $CMD && return 0 || continue
      done
      exit 5
      ;;

    *)
      echo "!!! Invalid command: $origin" >&2
      exit 1
      ;;
  esac
} # loop ()
