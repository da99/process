
source "$THIS_DIR/bin/public/group-of/_.sh"

# === {{CMD}}  PID
is-process-group () {
    [[ $1 == $(group-of $1) ]]
} # === end function
