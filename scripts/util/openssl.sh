gen_private_key() {
  openssl genrsa 4096
}

gen_public_key() {
  local private_key=$1
  echo "${private_key}" | openssl rsa -outform PEM -pubout
}
