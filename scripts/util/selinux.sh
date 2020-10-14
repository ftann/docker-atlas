#!/usr/bin/env bash

selinux_chcon_obj() {
  chcon -t "$1" -R "$2"
}
