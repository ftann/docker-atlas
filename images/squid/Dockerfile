FROM alpine:3.16

RUN apk add --no-cache squid tzdata

EXPOSE 3128

COPY root/ /

USER squid

ENTRYPOINT ["/usr/sbin/squid"]

CMD ["-N", "-C"]
