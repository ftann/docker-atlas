split() {
  local IFS="."
  read -ra arr <<<"$1"
  echo "${arr[@]}"
}

prepend_each() {
  local prefix=$1
  shift
  printf "${prefix}%s " "$@"
}

join_by() {
  local IFS="$1"
  shift
  echo "$*"
}
