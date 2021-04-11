FROM lsiobase/alpine:3.13

EXPOSE 389 636

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN \
    apk add --no-cache \
        bash openldap openldap-backend-all openldap-overlay-all openldap-clients openssl && \
    mkdir -p \
        /run/openldap && \
    chown abc:abc \
        /run/openldap

COPY root/ /

VOLUME /config
