FROM alpine:3.15

RUN apk add --no-cache bash inadyn

COPY inadyn.conf /etc/inadyn/inadyn.conf

ENTRYPOINT ["/usr/sbin/inadyn"]

CMD ["--foreground", "-t", "20", "-l", "err"]
