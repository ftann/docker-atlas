set_bridge_password() {
  while read -r pass_name; do
    pass_name="${pass_name/%.gpg}"
    pass_name="${pass_name/#$1\/}"
    break
  done < <(find "$1" -type f -mindepth 3 -maxdepth 3 -print)
  /usr/bin/pass insert -m "${pass_name}" <<EOF >/dev/null
$(/usr/bin/pass "${pass_name}" | base64 -d | sed -z -e "5s/.*/$2/" | base64 -w0)
EOF
}
