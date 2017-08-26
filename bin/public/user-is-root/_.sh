#
# === {{CMD}}
#

user-is-root () {
  [[ "$EUID" -eq 0 ]]
}
