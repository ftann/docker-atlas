#!/usr/bin/with-contenv bash

[[ -f /config/restic/options ]] && . /config/restic/options

# shellcheck disable=SC2086
s6-setuidgid abc restic restore "${RESTIC_OPTIONS[@]}" "$@"
