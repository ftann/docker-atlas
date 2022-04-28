FROM golang:1.15-alpine3.14 AS builder

RUN apk add --no-cache bash gcc make musl-dev libsecret-dev

ENV BRIDGE_URL="https://github.com/ProtonMail/proton-bridge/archive/refs/tags/v2.1.3.tar.gz" \
    BRIDGE_CHECKSUM=81c2e3fb2980971dfef11e4f1c961af9fb13524e44622ea0b6c0cb027ecd832f

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

COPY --from=builder /tmp/proton-bridge-*/proton-bridge /app/proton-bridge
COPY root/ /

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    PROTONMAIL_ADDRESS="admin@atlas.com" \
    PROTONMAIL_PASSWORD=atlas \
    PROTONMAIL_PASSWORD_MAILBOX=secure

VOLUME /config
