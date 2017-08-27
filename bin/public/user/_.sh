#
# === {{CMD}} must be root
#

user () {
  case "$(echo $@ | xargs echo -n)" in
    "must be root")
      [[ "$EUID" -eq 0 ]] || {
        echo "!!! User must be root." >&2
        exit 1
      }
      ;;

    *)
      echo "!!! Invalid options: $@" >&2
      exit 5
      ;;
  esac
} # user ()
