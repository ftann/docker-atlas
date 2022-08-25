FROM alpine:3.16

RUN apk add --no-cache inadyn tzdata

COPY root/ /

USER inadyn:inadyn

ENTRYPOINT ["/usr/sbin/inadyn"]

CMD ["--foreground", "--no-pidfile", "--drop-privs=inadyn:inadyn", "-t", "20", "-l", "err"]
