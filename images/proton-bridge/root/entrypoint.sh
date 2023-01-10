#!/usr/bin/env bash

set -euo pipefail

. /app/env.sh
. /app/set-bridge-password.sh

file_env 'PROTONMAIL_PASSWORD'
file_env 'PROTONMAIL_PASSWORD_BRIDGE'
file_env 'PROTONMAIL_PASSWORD_MAILBOX'

if [[ ! -d /config/.gnupg ]]; then
  /usr/bin/gpg --quiet --batch --passphrase "" --quick-gen-key "${PROTONMAIL_ADDRESS}" default default never
fi

if [[ ! -d /config/.password-store ]]; then
  /usr/bin/pass init "${PROTONMAIL_ADDRESS}" >/dev/null 2>&1
fi

if [[ ! -d /config/.config/protonmail ]]; then
  /app/proton-bridge --cli --log-level error <<EOF >/dev/null
login
${PROTONMAIL_ADDRESS}
${PROTONMAIL_PASSWORD}
${PROTONMAIL_PASSWORD_MAILBOX}
EOF
fi

set_bridge_password /config/.password-store "${PROTONMAIL_PASSWORD_BRIDGE}"

socat TCP-LISTEN:25,fork TCP:localhost:1025 &
socat TCP-LISTEN:143,fork TCP:localhost:1143 &

/app/proton-bridge --noninteractive
