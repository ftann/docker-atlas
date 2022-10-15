file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [[ -n "${!var:-}" && -n "${!fileVar:-}" ]]; then
	  echo "Both ${var} and ${fileVar} are set (but are exclusive)"
	  exit 1
	fi
	local val="${def}"
	if [[ -n "${!var:-}" ]]; then
		val="${!var}"
	elif [[ -n "${!fileVar:-}" ]]; then
		val="$(< "${!fileVar}")"
	fi
	export "${var}"="${val}"
	unset "${fileVar}"
}
