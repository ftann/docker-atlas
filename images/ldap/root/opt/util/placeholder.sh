replace_placeholder() {
  local placeholder=$1
  local replacement=$2
  local file=$3
  sed -i "s|{{ ${placeholder} }|${replacement}|g" "${file}"
}
