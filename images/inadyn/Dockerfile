FROM alpine

RUN apk add --no-cache bash inadyn

VOLUME /config

COPY inadyn.conf /config/inadyn.conf

ENTRYPOINT ["/usr/sbin/inadyn"]

CMD ["--foreground", "-f", "/config/inadyn.conf"]
