FROM alpine:3.17.0

RUN apk add --no-cache inadyn tzdata

COPY root/ /

USER inadyn:inadyn

ENTRYPOINT ["/usr/sbin/inadyn"]

CMD ["--foreground", "--no-pidfile", "--drop-privs=inadyn:inadyn", "-t", "20", "-l", "err"]
