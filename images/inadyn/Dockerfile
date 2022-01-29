FROM alpine:3.15

RUN apk add --no-cache inadyn

COPY root/ /

USER inadyn:inadyn

ENTRYPOINT ["/usr/sbin/inadyn"]

CMD ["--foreground", "--no-pidfile", "--drop-privs=inadyn:inadyn", "-t", "20", "-l", "err"]
