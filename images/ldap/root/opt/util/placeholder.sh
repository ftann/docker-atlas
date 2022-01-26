#!/usr/bin/env bash

replace_placeholder() {
  sed -i "s|{{ $1 }}|$2|g" "$3"
}
