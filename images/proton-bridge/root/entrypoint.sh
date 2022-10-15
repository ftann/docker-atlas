#!/usr/bin/env bash

set -euo pipefail

. /app/env.sh

BRIDGE_ARGS=("--cli" "--log-level" "panic")
BRIDGE_KEY_NAME="${PROTONMAIL_ADDRESS}"

file_env 'PROTONMAIL_PASSWORD'
file_env 'PROTONMAIL_PASSWORD_MAILBOX'

if [[ ! -d /config/.gnupg ]]; then
  /usr/bin/gpg --quiet --generate-key --batch <<EOF
  %no-protection
  Key-Type: RSA
  Key-Length: 4096
  Name-Real: ${BRIDGE_KEY_NAME}
  Expire-Date: 0
  %commit
EOF
fi

if [[ ! -d /config/.password-store ]]; then
  /usr/bin/pass init "${BRIDGE_KEY_NAME}" >/dev/null 2>&1
fi

if [[ ! -d /config/.config/protonmail ]]; then
  /app/proton-bridge "${BRIDGE_ARGS[@]}" <<EOF >/dev/null 2>&1
login
${PROTONMAIL_ADDRESS}
${PROTONMAIL_PASSWORD}
${PROTONMAIL_PASSWORD_MAILBOX}
EOF

  /app/proton-bridge "${BRIDGE_ARGS[@]}" <<EOF | grep -E 'Password' | sort -ru | cut -d ":" -f2 | tr -d "\n " >/config/protonmail_password_bridge
info
EOF
fi

# Fake a terminal, so it does not quit because of EOF.
# shellcheck disable=SC2002
cat /tmp/fakettyp | /app/proton-bridge "${BRIDGE_ARGS[@]}" --noninteractive
