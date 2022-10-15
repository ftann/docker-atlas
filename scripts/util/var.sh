read_vars() {
  . ./.env
}

get_var() {
  read_vars
  eval "echo \${$1}"
}

#
# Getters for specific keys.
#

# Domains

get_domain() {
  get_var DOMAIN
}

# Secrets

get_b2_id() {
  get_var BACKBLAZE_ID
}

get_b2_key() {
  get_var BACKBLAZE_KEY
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

# Permissions

get_selinux_label() {
  get_var SELINUX_OBJ_LABEL
}

get_selinux_level() {
  get_var SELINUX_OBJ_LEVEL
}

# Volumes

get_volume_root() {
  get_var VOLUME_ROOT
}
