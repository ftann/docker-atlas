FROM alpine:3.16

ARG PUID=2000
ARG PGID="${PUID}"

COPY --chown="${PUID}:${PGID}" root/ /

RUN mkdir /config && \
    chown "${PUID}:${PGID}" /config

VOLUME /config/authelia /config/ldap /config/traefik

USER "${PUID}:${PGID}"

ENTRYPOINT ["/app/sync.sh"]
