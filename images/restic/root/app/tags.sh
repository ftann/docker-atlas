mk_tag_args() {
  local tags
  local tag_args
  IFS="," read -ra tags <<<"$(echo "$1" | tr -d " ")"
  tag_args=()
  for tag in "${tags[@]}"; do
    tag_args+=("--tag" "${tag}")
  done
  echo "${tag_args[*]}"
}
