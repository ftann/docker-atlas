#!/command/with-contenv bash

set -euo pipefail

s6-setuidgid abc mariadb \
    --host="${DB_HOST}" --port="${DB_PORT}" \
    --user="${DB_USER}" --password="${DB_PASSWORD}" \
    "${DB_NAME}" < /config/db/"${DB_NAME}".sql
