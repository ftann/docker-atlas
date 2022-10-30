FROM alpine:3.16

ARG USER=atlas
ARG PUID=2000
ARG PGID="${PUID}"

RUN addgroup -g "${PGID}" "${USER}" && \
    adduser -D -u "${PUID}" -G "${USER}" -s /bin/false -h /config "${USER}"

RUN apk add --no-cache bash restic tzdata

COPY --chown="${USER}" root/ /

ENV RESTIC_REPOSITORY=/config/repo \
    RESTIC_BACKUP_SOURCES=/data \
    RESTIC_BACKUP_TAGS="" \
    RESTIC_CACHE_DIR=/config/restic/cache \
    RESTIC_FORGET_ARGS="--prune --keep-daily 7 --keep-weekly 4 --keep-monthly 3 --keep-yearly 1"

RUN mkdir -p \
      /config/restic/cache && \
    chown "${USER}:${USER}" -R \
      /config

VOLUME /config

USER "${USER}"

ENTRYPOINT ["/entrypoint.sh"]

CMD ["check"]
