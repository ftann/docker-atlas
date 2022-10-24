#!/usr/bin/env bash

set -euo pipefail

. /app/env.sh

BRIDGE_KEY_NAME="${PROTONMAIL_ADDRESS}"

file_env 'PROTONMAIL_PASSWORD'
file_env 'PROTONMAIL_PASSWORD_MAILBOX'

if [[ ! -d /config/.gnupg ]]; then
  /usr/bin/gpg --quiet --batch --passphrase "" --quick-gen-key "${BRIDGE_KEY_NAME}" default default never
fi

if [[ ! -d /config/.password-store ]]; then
  /usr/bin/pass init "${BRIDGE_KEY_NAME}" >/dev/null 2>&1
fi

if [[ ! -d /config/.config/protonmail ]]; then
  /app/proton-bridge --cli --log-level error <<EOF
login
${PROTONMAIL_ADDRESS}
${PROTONMAIL_PASSWORD}
${PROTONMAIL_PASSWORD_MAILBOX}
EOF

  /app/proton-bridge --cli --log-level error <<EOF | grep -E "Password" | sort -ru | cut -d ":" -f2 | tr -d "\n " >/config/protonmail_password_bridge
info
EOF
fi

socat TCP-LISTEN:25,fork TCP:127.0.0.1:1025 &
socat TCP-LISTEN:143,fork TCP:127.0.0.1:1143 &

/app/proton-bridge --noninteractive
