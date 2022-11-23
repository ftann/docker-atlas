FROM alpine:3.16

COPY root/ /

RUN mkdir -p \
        /config \
        /config/authelia \
        /config/envoy \
        /config/ldap \
        /config/prometheus \
        /config/traefik

VOLUME /config/authelia /config/envoy /config/ldap /config/prometheus /config/traefik

ENTRYPOINT ["/app/sync.sh"]
