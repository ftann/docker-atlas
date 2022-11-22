#!/usr/bin/env bash

set -euo pipefail

. /app/env.sh

file_env 'AWS_ACCESS_KEY_ID'
file_env 'AWS_SECRET_ACCESS_KEY'
file_env 'RESTIC_PASSWORD'

restic restore "$@"
