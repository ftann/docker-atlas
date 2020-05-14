FROM alpine as builder

RUN \
    apk \
        update && \
    apk \
        add gcc make musl-dev && \
    rm -rf \
        /var/cache/apk/*

WORKDIR /tmp

ENV UDPXY_URL "http://www.udpxy.com/download/1_23/udpxy.1.0.23-12-prod.tar.gz"
ENV UDPXY_CHECKSUM 16bdc8fb22f7659e0427e53567dc3e56900339da261199b3d00104d699f7e94c

RUN \
    wget \
        ${UDPXY_URL} \
        -O udpxy-src.tar.gz && \
    echo "${UDPXY_CHECKSUM}  udpxy-src.tar.gz" | sha256sum -c - && \
    tar -xzvf \
        udpxy-src.tar.gz && \
    cd \
        udpxy-* && \
    make && \
    make install

FROM alpine

COPY --from=builder /usr/local/bin/udpxy /usr/local/bin/udpxy

EXPOSE 4022

ENTRYPOINT ["/usr/local/bin/udpxy"]

CMD ["-T", "-p", "4022"]
