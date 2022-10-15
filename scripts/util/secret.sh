exists_secret() {
  [[ -s "$1" ]]
}

create_secret() {
  local secret=$1
  local content=$2
  if ! exists_secret "${secret}"; then
    echo -n "${content}" >>"${secret}"
  fi
}
