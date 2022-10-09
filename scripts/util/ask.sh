is_answer_y() {
  local answer=$1
  [[ "${answer}" != "${answer#[Yy]}" ]]
}

agree_to() {
  local question=$1
  echo -n "${question} (y/n)? "
  read -r answer
  if is_answer_y "${answer}"; then
    return 0
  else
    return 1
  fi
}

ask() {
  agree_to "sure"
}
