FROM lsiobase/alpine:3.15

EXPOSE 389 636

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

ENV LDAP_BIND_USER=auth \
    LDAP_BIND_PASSWORD=auth \
    LDAP_CONFIG_PASSWORD=config \
    LDAP_DOMAIN="dc=atlas" \
    LDAP_ROOT=root \
    LDAP_ROOT_PASSWORD=root

RUN \
    apk add --no-cache \
        bash openldap openldap-backend-all openldap-overlay-all openldap-clients openssl && \
    mkdir -p \
        /run/openldap && \
    chown abc:abc \
        /run/openldap

RUN mkdir -p \
        /config/keys \
        /config/databases/openldap-data \
        /config/databases/slapd.d && \
    chown -R abc:abc /config

COPY root/ /

VOLUME /config
