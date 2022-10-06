is_selinux_enabled() {
  selinuxenabled
}

selinux_chcon() {
  local label="$1"
  local level="$2"
  shift 2
  chcon -R -t "$label" -l "$level" "$@"
}
