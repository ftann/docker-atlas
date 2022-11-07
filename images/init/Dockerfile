FROM alpine:3.16

ARG USER=atlas
ARG PUID=2000
ARG PGID="${PUID}"

RUN addgroup -g "${PGID}" "${USER}" && \
    adduser -D -u "${PUID}" -G "${USER}" -s /bin/false -h /config "${USER}"

COPY --chown="${USER}" root/ /

RUN mkdir -p \
        /config \
        /config/authelia \
        /config/envoy \
        /config/ldap \
        /config/traefik \ && \
    chown "${USER}:${USER}" -R /config

USER "${USER}"

VOLUME /config/authelia /config/envoy /config/ldap /config/traefik

ENTRYPOINT ["/app/sync.sh"]
