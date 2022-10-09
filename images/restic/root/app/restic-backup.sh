#!/command/with-contenv bash

[[ -f /config/restic/options ]] && . /config/restic/options

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

IFS=" " read -ra TAGS <<<"$(mk_tag_args "${RESTIC_BACKUP_TAGS}")"
s6-setuidgid abc restic backup --iexclude-file=/config/restic/excludes "${TAGS[@]}" "${RESTIC_OPTIONS[@]}" "${RESTIC_BACKUP_SOURCES}"

[[ -z "${RESTIC_FORGET_ARGS}" ]] && exit 0

IFS=" " read -ra FORGET_ARGS <<<"${RESTIC_FORGET_ARGS}"
s6-setuidgid abc restic forget "${TAGS[@]}" "${RESTIC_OPTIONS[@]}" --prune --group-by "paths,tags" "${FORGET_ARGS[@]}"
