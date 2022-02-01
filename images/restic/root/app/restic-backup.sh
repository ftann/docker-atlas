#!/usr/bin/with-contenv bash

[[ -f /config/restic/options ]] && . /config/restic/options

mk_tag_args() {
  local tags
  local tag_args
  tags="$(echo "$1" | tr -d " " | tr "," "\n")"
  for tag in $tags; do
    tag_args="$tag_args --tag $tag"
  done
  echo "$tag_args"
}

TAGS="$(mk_tag_args "${RESTIC_BACKUP_TAGS}")"

# shellcheck disable=SC2086
s6-setuidgid abc restic backup $TAGS "${RESTIC_OPTIONS[@]}" --iexclude-file=/config/restic/excludes

[[ -z "$RESTIC_FORGET_ARGS" ]] && exit 0

# shellcheck disable=SC2086
s6-setuidgid abc restic forget $TAGS "${RESTIC_OPTIONS[@]}" --prune --group-by "paths,tags" $RESTIC_FORGET_ARGS
