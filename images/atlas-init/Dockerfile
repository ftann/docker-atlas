FROM alpine:3.16

ENV PUID=2000 \
    PGID=2000

COPY root/ /

RUN mkdir /config

VOLUME /config/authelia /config/ldap /config/traefik

ENTRYPOINT /app/sync.sh
