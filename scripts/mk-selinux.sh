#!/usr/bin/env bash

. ./scripts/util/selinux.sh
. ./scripts/util/var.sh

LABEL=$(get_selinux_label)
DATA=$(get_volume_root)

selinux_chcon_obj "$LABEL" .env .gitignore *
selinux_chcon_obj "$LABEL" "$DATA"
