FROM lsiobase/alpine:3.16

EXPOSE 389 636

RUN \
    apk add --no-cache \
        bash openldap openldap-backend-all openldap-overlay-all openldap-clients openssl

COPY root/ /

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    DOMAIN=atlas.com \
    LDAP_BIND_USER=auth \
    LDAP_BIND_PASSWORD=auth \
    LDAP_CONFIG_PASSWORD=config \
    LDAP_ROOT=root \
    LDAP_ROOT_PASSWORD=root

VOLUME /config
