#!/usr/bin/env bash

. ./scripts/inc.sh

if is_selinux_enabled; then
  selinux_chcon "$(get_selinux_label)" "$(get_selinux_level)" ./.* ./* "$(get_volume_root)"
fi
