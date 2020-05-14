#!/usr/bin/env bash

exists_secret() {
  [[ -s "$1" ]]
}

create_secret() {
  local secret="$1"
  if ! exists_secret "$secret"; then
    echo -n "$2" >>"$secret"
  fi
}
