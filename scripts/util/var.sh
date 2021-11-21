#!/usr/bin/env bash

read_vars() {
  . ./.env
}

get_var() {
  read_vars
  eval "echo \${$1}"
}

get_uid() {
  get_var PUID
}

get_gid() {
  get_var PGID
}

get_b2_id() {
  get_var BACKBLAZE_ID
}

get_b2_key() {
  get_var BACKBLAZE_KEY
}

get_cloudflare_token() {
  get_var CLOUDFLARE_TOKEN
}

get_maxmind_key() {
  get_var MAXMIND_KEY
}

get_volume_root() {
  get_var VOLUME_ROOT
}

get_selinux_label() {
  get_var SELINUX_OBJ_LABEL
}
