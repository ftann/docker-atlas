#!/usr/bin/env bash

set -euo pipefail

/app/init.sh

exec "$@"
