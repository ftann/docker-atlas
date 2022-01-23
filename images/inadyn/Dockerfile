FROM alpine:3.15

RUN apk add --no-cache bash inadyn

VOLUME /config

COPY inadyn.conf /config/inadyn.conf

ENTRYPOINT ["/usr/sbin/inadyn"]

CMD ["--foreground", "-f", "/config/inadyn.conf", "-t", "20", "-l", "err"]
