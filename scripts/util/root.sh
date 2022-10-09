is_root() {
  [[ $(id -u) = "0" ]]
}

check_root() {
  if is_root; then
    return 0
  else
    echo "run as root!"
    exit 2
  fi
}
