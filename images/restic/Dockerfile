FROM alpine:3.17.2

RUN apk add --no-cache bash restic tzdata

COPY root/ /

ENV RESTIC_REPOSITORY=/config/repo \
    RESTIC_BACKUP_SOURCES=/data \
    RESTIC_BACKUP_HOST=atlas \
    RESTIC_BACKUP_TAGS="" \
    RESTIC_CACHE_DIR=/config/restic/cache \
    RESTIC_FORGET_ARGS="--prune --keep-daily 7 --keep-weekly 4 --keep-monthly 3 --keep-yearly 1"

RUN mkdir -p /config/restic/cache

VOLUME /config

ENTRYPOINT ["/entrypoint.sh"]

CMD ["check"]
