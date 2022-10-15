FROM alpine:3.16

ARG USER=atlas
ARG PUID=2000
ARG PGID="${PUID}"

RUN addgroup -g "${PGID}" "${USER}" && \
    adduser -D -u "${PUID}" -G "${USER}" -s /bin/false -h /config "${USER}"

RUN apk add --no-cache bash openldap openldap-backend-all openldap-overlay-all openldap-clients openssl tzdata

EXPOSE 389 636

COPY --chown="${PUID}:${PGID}" root/ /

ENV DOMAIN=atlas.com \
    LDAP_BIND_USER=auth \
    LDAP_ROOT=root

RUN mkdir -p \
      /config/backup \
      /config/databases/openldap-data \
      /config/databases/slapd.d \
      /config/keys \
      /config/log \
      /run/openldap && \
    chown "${USER}:${USER}" -R \
      /config \
      /run/openldap

VOLUME /config

USER "${USER}"

ENTRYPOINT ["/entrypoint.sh"]
