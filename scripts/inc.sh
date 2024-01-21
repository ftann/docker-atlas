# ask

is_answer_y() {
  local answer=$1
  [[ "${answer}" != "${answer#[Yy]}" ]]
}

ask() {
  local question="${1:-sure}"
  echo -n "${question} (y/n)? "
  read -r answer
  if is_answer_y "${answer}"; then
    return 0
  else
    return 1
  fi
}

# fw

fw_perm() {
  firewall-cmd --permanent "$@"
}

add_service_fw() {
  fw_perm --add-service="$1"
}

del_service_fw() {
  fw_perm --remove-service="$1"
}

reload_fw() {
  firewall-cmd --reload
}

# openssl

gen_private_key() {
  openssl genrsa 4096
}

gen_public_key() {
  local private_key=$1
  echo "${private_key}" | openssl rsa -outform PEM -pubout
}

# pw

rnd_pw() {
  local length="${1:-16}"
  local pattern="A-Za-z0-9"
  # LC_CTYPE macos fix.
  env LC_CTYPE=C tr -dc "${pattern}" </dev/urandom | head -c "${length}"
  echo
}

# root

is_root() {
  [[ $(id -u) == "0" ]]
}

check_root() {
  if is_root; then
    return 0
  else
    echo "run as root!"
    exit 2
  fi
}

# secret

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

# selinux

selinux_chcon() {
  local label=$1
  local level=$2
  shift 2
  chcon -R -t "${label}" -l "${level}" "$@"
}

# var

read_vars() {
  . ./.env
}

get_var() {
  read_vars
  eval "echo \${$1}"
}

get_cloudflare_token() {
  get_var CLOUDFLARE_TOKEN
}

get_protonmail_password() {
  get_var PROTONMAIL_PASSWORD
}

get_protonmail_password_mailbox() {
  get_var PROTONMAIL_PASSWORD_MAILBOX
}
