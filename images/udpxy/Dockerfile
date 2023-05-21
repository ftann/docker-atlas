FROM alpine:3.18.0 as builder

RUN apk add --no-cache gcc make musl-dev

WORKDIR /tmp

ENV UDPXY_URL="https://github.com/pcherenkov/udpxy/archive/refs/tags/1.0-25.1.tar.gz" \
    UDPXY_CHECKSUM=a1a16e60895c6b2fd151321db47f5d5373843116f1b98ed9749e6c25a6c44497

RUN \
    wget \
        ${UDPXY_URL} -O udpxy-src.tar.gz && \
    echo "${UDPXY_CHECKSUM}  udpxy-src.tar.gz" | sha256sum -c - && \
    tar -xzvf \
        udpxy-src.tar.gz && \
    cd udpxy-*/chipmunk && \
    make && \
    make install

FROM alpine:3.18.0

EXPOSE 4022

COPY --from=builder /usr/local/bin/udpxy /usr/local/bin/udpxy

USER nobody:nobody

ENTRYPOINT ["/usr/local/bin/udpxy"]

CMD ["-T", "-p", "4022", "-B", "256kb"]
