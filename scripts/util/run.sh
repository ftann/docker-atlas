. ./scripts/util/usage.sh

run_if_defined() {
  if declare -f "$1" >/dev/null; then
    "$@"
  else
    print_usage
    exit 1
  fi
}
