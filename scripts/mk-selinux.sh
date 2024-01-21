#!/usr/bin/env bash

. ./scripts/inc.sh

if selinuxenabled; then

  label="$(get_var SELINUX_OBJ_LABEL)"
  level="$(get_var SELINUX_OBJ_LEVEL)"
  volumes=(
    "$(get_var VOLUME_MEDIA)"
    "$(get_var VOLUME_NEXTCLOUD)"
  )

  selinux_chcon "${label}" "${level}" ./.* ./* "${volumes[@]}"
fi
