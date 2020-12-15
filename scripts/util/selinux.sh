#!/usr/bin/env bash

is_selinux_enabled() {
  selinuxenabled
}

selinux_chcon_obj() {
  chcon -R -t "$1" "$2"
}

selinux_chcon_lvl() {
  chcon -R -l s0 "$1"
}
