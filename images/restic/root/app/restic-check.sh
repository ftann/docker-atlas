#!/usr/bin/with-contenv bash

[[ -f /config/restic/options ]] && . /config/restic/options

restic check "${RESTIC_OPTIONS[@]}"
