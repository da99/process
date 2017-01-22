
# === {{CMD}}       # Returns:  NUMBER on|off
# === {{CMD}} graph # ||||||| [MUTE|zero]

volume () {

  case "$@" in
    graph)
      set $(volume)
      local +x NUM="$1"; shift
      local +x ON_OFF="$1"; shift
      local +x GRAPH=""
      local +x REPEATS=$(($NUM / 10))
      local +x CHAR="━"

      echo -n '['
      awk 'BEGIN { while (z++ < '$REPEATS') printf "-" }'
      awk 'BEGIN { while (z++ < '$((10 - $REPEATS))') printf " " }'
      echo -n ']'

      if [[ "$ON_OFF" == "off" ]]; then
        echo "[MUTE]"
      else
        echo ""
      fi
      ;;

    "")
      amixer get Master | awk 'BEGIN { FS = "[][%]" } { if (NR == 7) print $2,$5; }'
      ;;

    *)
      echo "!!! Invalid input: $@" >&2
      ;;

  esac

} # === end function
