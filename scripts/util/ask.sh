#!/usr/bin/env bash

is_answer_y() {
  [[ "$1" != "${1#[Yy]}" ]]
}

ask() {
  echo -n "sure (y/n)? "
  read -r answer
  if is_answer_y "$answer"; then
    return 0
  else
    return 1
  fi
}
