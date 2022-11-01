#!/usr/bin/env bash

. ./scripts/inc.sh

if selinuxenabled; then

  label="$(get_var SELINUX_OBJ_LABEL)"
  level="$(get_var SELINUX_OBJ_level)"
  volumes=(
    "$(get_var VOLUME_MEDIA)"
    "$(get_var VOLUME_NEXTCLOUD)"
    "$(get_var VOLUME_POOL)"
    "$(get_var VOLUME_SYNC)"
  )

  selinux_chcon "${label}" "${level}" ./.* ./* "${volumes[@]}"
fi
