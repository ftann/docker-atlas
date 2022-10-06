fw_perm() {
  firewall-cmd --permanent "$@"
}

add_service_fw() {
  fw_perm --add-service="$1"
}

add_source_fw() {
  fw_perm --add-source="$1"
}

del_service_fw() {
  fw_perm --remove-service="$1"
}

del_source_fw() {
  fw_perm --remove-source="$1"
}

reload_fw() {
  firewall-cmd --reload
}
