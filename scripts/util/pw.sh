rnd_pw() {
  local length="${1:-16}"
  local pattern="A-Za-z0-9"
  # LC_CTYPE macos fix.
  env LC_CTYPE=C tr -dc "${pattern}" </dev/urandom | head -c "${length}"
  echo
}
