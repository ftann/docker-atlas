FROM lsiobase/alpine:3.15

RUN apk add --no-cache bash openldap-clients

COPY root/ /

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    LDAP_BACKUP_SCHEDULE="30 2 * * *" \
    DOMAIN=atlas.com \
    LDAP_HOST=ldap \
    LDAP_PORT=389 \
    LDAP_BIND_USER=auth \
    LDAP_BIND_PASSWORD=auth \
    LDAP_NAME=ldap

VOLUME /config
