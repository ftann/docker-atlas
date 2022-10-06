#!/command/with-contenv bash

set -euo pipefail

s6-setuidgid abc mariadb-dump \
    --host="${DB_HOST}" --port="${DB_PORT}" \
    --user="${DB_USER}" --password="${DB_PASSWORD}" \
    --hex-blob --single-transaction --routines --triggers \
    --skip-comments --skip-quick \
    "${DB_NAME}" > /config/db/"${DB_NAME}".sql
