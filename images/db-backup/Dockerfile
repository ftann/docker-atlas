FROM lsiobase/alpine:3.15

RUN apk add --no-cache bash mariadb-client

COPY root/ /

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    DB_BACKUP_SCHEDULE="0 2 * * *" \
    DB_HOST=db \
    DB_PORT=3306 \
    DB_USER=db \
    DB_PASSWORD=db \
    DB_NAME=db

VOLUME /data
