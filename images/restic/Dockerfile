FROM lsiobase/alpine:3.12

RUN \
    apk \
        update && \
    apk \
        add bash restic && \
    rm -rf \
        /var/cache/apk/*

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

ENV RESTIC_SCHEDULE "0 3 * * *"
ENV RESTIC_BACKUP_SOURCES /data
ENV RESTIC_BACKUP_TAGS ""
ENV RESTIC_CACHE_DIR /config/restic/cache

COPY root/ /

VOLUME /config
