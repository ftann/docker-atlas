#!/usr/bin/env bash

. ./scripts/util/selinux.sh
. ./scripts/util/var.sh

if is_selinux_enabled; then
  LABEL=$(get_selinux_label)
  DATA=$(get_volume_root)

  selinux_chcon_obj "$LABEL" .env .gitignore *
  selinux_chcon_obj "$LABEL" "$DATA"
  selinux_chcon_lvl .env .gitignore *
  selinux_chcon_lvl "$DATA"
fi