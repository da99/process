
# === {{CMD}}  min-cpu  seconds
# === Lists processes running for more than "seconds"
# === higher than "min-cpu": {{CMD}} 90 5
top-cpu () {
  local +x MIN_CPU="$1"; shift
  local +x SECONDS="$1"; shift

  local +x IFS=$'\n'
  local +x CACHE="$THIS_DIR"/progs/top-cpu
  mkdir -p "$CACHE"

  local +x COUNT="1"

  # IF max has been reached, reset.
  if [[ -f "$CACHE/${SECONDS}.txt" ]]; then
    rm -f "$CACHE"/*.txt
  fi

  # FIND next iteration:
  while [[ "$COUNT" -lt "$SECONDS" ]]; do
    if [[ ! -f "$CACHE/${COUNT}.txt" ]]; then
      break
    fi
    COUNT="$((COUNT + 1))"
  done

  local +x CONTENT=""
  for LINE in $(ps aux --no-headers | sort -nrk 3,3 | tr -s ' ' | head -n 10 | cut -d' ' -f2,3,11); do
    IFS=$' '
    set $LINE
    IFS=$'\n'

    local +x PID=$1
    local +x CPU=$2
    local +x CMD=$3
    if [[ ! "${CPU%.*}" -gt "$MIN_CPU" ]]; then
      continue
    fi

    if [[ -z "$CONTENT" ]]; then
      CONTENT+="$CMD"
    else
      CONTENT+="\n$CMD"
    fi
  done

  echo -e "$CONTENT" | sort | uniq > "$CACHE/${COUNT}.txt"
} # === end function
