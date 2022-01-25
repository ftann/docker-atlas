FROM lsiobase/alpine:3.15

RUN apk add --no-cache bash restic

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

ENV RESTIC_SCHEDULE="0 3 * * *" \
    RESTIC_BACKUP_SOURCES=/data \
    RESTIC_BACKUP_TAGS="" \
    RESTIC_CACHE_DIR=/config/restic/cache

RUN mkdir -p \
        /config/log/restic && \
    chown -R abc:abc /config

COPY root/app/ /app
COPY root/etc/ /etc
COPY --chown=abc:abc root/config/ /config

VOLUME /config
