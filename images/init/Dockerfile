FROM alpine:3.17.0

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
