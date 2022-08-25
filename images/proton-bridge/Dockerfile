FROM golang:1.15-alpine3.14 AS builder

RUN apk add --no-cache bash gcc make musl-dev libsecret-dev

ENV BRIDGE_URL="https://github.com/ProtonMail/proton-bridge/archive/refs/tags/v2.2.2.tar.gz" \
    BRIDGE_CHECKSUM=3b53834cbe730547472e936a300cf5124ff97789eeb07d3961aa5a43480f28af

WORKDIR /tmp

RUN wget \
        ${BRIDGE_URL} -O proton-bridge.tar.gz && \
    echo "${BRIDGE_CHECKSUM}  proton-bridge.tar.gz" | sha256sum -c - && \
    tar -xzvf \
        proton-bridge.tar.gz && \
    cd proton-bridge-* && \
    make build-nogui

FROM lsiobase/alpine:3.16

EXPOSE 25 143

RUN apk add --no-cache gnupg libsecret pass socat

COPY --from=builder /tmp/proton-bridge-*/proton-bridge /app/proton-bridge
COPY root/ /

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    PROTONMAIL_ADDRESS="admin@atlas.com" \
    PROTONMAIL_PASSWORD=atlas \
    PROTONMAIL_PASSWORD_MAILBOX=secure

VOLUME /config
