FROM lsiobase/alpine:3.13

RUN \
    apk \
        update && \
    apk \
        add bash openldap openldap-backend-all openldap-overlay-all openldap-clients openssl && \
    mkdir -p \
        /run/openldap && \
    chown abc:abc \
        /run/openldap && \
    rm -rf \
        /var/cache/apk/*

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

COPY root/ /

EXPOSE 389 636

VOLUME /config
