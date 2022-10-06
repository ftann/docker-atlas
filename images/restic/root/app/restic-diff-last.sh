#!/command/with-contenv bash

[[ -f /config/restic/options ]] && . /config/restic/options

PREV=$(s6-setuidgid abc restic snapshots --compact | tail -4 | head -1 | awk '{print $1}')
LAST=$(s6-setuidgid abc restic snapshots --compact | tail -3 | head -1 | awk '{print $1}')

s6-setuidgid abc restic diff "${PREV}" "${LAST}"
