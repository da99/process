
# === {{CMD}}  min-cpu  seconds
# === Lists processes running for more than "seconds"
# === higher than "min-cpu": {{CMD}} 90 5
top-cpu () {
  local +x MIN_CPU="$1"; shift
  local +x SECONDS="$1"; shift

  if [[ "$SECONDS" -lt 1 || "$SECONDS" -gt 20 ]]; then
    echo "!!! Invalid seconds: $SECONDS" >&2
    exit 2
  fi

  local +x IFS=$'\n'
  local +x CACHE="$THIS_DIR"/tmp/top-cpu
  mkdir -p "$CACHE"

  local +x RECORD="$(refresh-cache "$CACHE" $SECONDS)"

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

    echo "$3" >> "$RECORD"
  done

  IFS=$' '
  cat "$CACHE"/* | sort | uniq -c | tr -s ' ' | cut -d' ' -f2,3 | while read -r COUNT NAME; do
    if [[ "$COUNT" -ge "$SECONDS" ]]; then
      basename "$NAME"
    fi
  done
} # === end function

refresh-cache () {
  local +x CACHE="$1"; shift
  local +x MAX="$1"; shift
  local +x NOW="$(date +"%s")"

  local +x IFS=$'\n'
  for FILE in $(find "$CACHE" -mindepth 1 -maxdepth 1 -type f); do
    if [[ ! -e "$FILE" ]]; then
      continue
    fi
    local +x AGE="$(stat --format="%Y" "$FILE")"
    if [[ "$(( NOW - AGE ))" -gt "$MAX" ]]; then
      rm -f "$FILE"
    fi
  done

  local +x COUNT="0"
  while [[ "$COUNT" -lt "$MAX" ]] ; do
    COUNT="$(( COUNT + 1 ))"
    if [[ ! -e "$CACHE"/$COUNT ]] ; then
      echo "$CACHE"/$COUNT
      return 0
    fi
  done

  echo "$CACHE"/1
} # refresh-cache

