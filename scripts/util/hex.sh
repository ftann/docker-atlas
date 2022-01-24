#!/usr/bin/bash

decode_hex() {
  echo "$1" | sed -Ee 's/[0-9a-fA-F]{2}/\\\\x&/g' | xargs printf
}

encode_hex() {
  echo -n "$1" | od -A n -t x2 --endian=big | tr -d ' \n'
}
