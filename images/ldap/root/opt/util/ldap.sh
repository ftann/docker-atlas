create_password_hash() {
  local input=$1
  slappasswd -n -h "{SSHA}" -s "${input}"
}

get_organization() {
  local dn=$1
  echo "${dn}" | cut -d, -f1 | cut -d= -f2
}
