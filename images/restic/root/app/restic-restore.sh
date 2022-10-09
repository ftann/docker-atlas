#!/command/with-contenv bash

[[ -f /config/restic/options ]] && . /config/restic/options

s6-setuidgid abc restic restore "${RESTIC_OPTIONS[@]}" "$@"
