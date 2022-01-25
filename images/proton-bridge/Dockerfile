FROM golang:1.15-alpine3.14 AS builder

RUN apk add --no-cache bash gcc make musl-dev libsecret-dev

ENV BRIDGE_URL="https://github.com/ProtonMail/proton-bridge/archive/refs/tags/v2.1.0.tar.gz" \
    BRIDGE_CHECKSUM=2920c03289ab6d090bfaf3134630d56fff8d2bb5a3d97a502ef0c47b5b4a795e

WORKDIR /tmp

RUN wget \
        ${BRIDGE_URL} -O proton-bridge.tar.gz && \
    echo "${BRIDGE_CHECKSUM}  proton-bridge.tar.gz" | sha256sum -c - && \
    tar -xzvf \
        proton-bridge.tar.gz && \
    cd proton-bridge-* && \
    make build-nogui

FROM lsiobase/alpine:3.15

EXPOSE 25 143

RUN apk add --no-cache gnupg libsecret pass socat

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

ENV PROTONMAIL_ADDRESS="admin@atlas.com" \
    PROTONMAIL_PASSWORD=atlas \
    PROTONMAIL_PASSWORD_MAILBOX=secure

RUN mkdir -p \
        /config && \
    chown -R abc:abc /config

COPY --from=builder /tmp/proton-bridge-*/proton-bridge /app/proton-bridge
COPY root/ /

VOLUME /config
