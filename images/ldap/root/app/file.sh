merge_files() {
  {
    for file in $1; do
      [[ -e "${file}" ]] || continue
      cat "${file}"
      echo
    done
  } >>"$2"
}
