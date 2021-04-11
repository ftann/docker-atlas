FROM lsiobase/alpine:3.13

RUN apk add --no-cache bash restic

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

ENV RESTIC_SCHEDULE="0 3 * * *" \
    RESTIC_BACKUP_SOURCES=/data \
    RESTIC_BACKUP_TAGS="" \
    RESTIC_CACHE_DIR=/config/restic/cache

COPY root/ /

VOLUME /config
