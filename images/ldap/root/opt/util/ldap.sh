#!/usr/bin/env bash

create_password_hash() {
  # shellcheck disable=SC1083
  slappasswd -n -h {SSHA} -s "$1"
}

get_domain() {
  echo "$1" | cut -d, -f1 | cut -d= -f2
}
