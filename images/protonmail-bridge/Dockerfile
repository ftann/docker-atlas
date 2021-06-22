FROM golang:1.15-alpine AS builder

RUN apk add --no-cache bash gcc git make musl-dev libsecret-dev

ENV BRIDGE_URL="https://github.com/ProtonMail/proton-bridge.git" \
    BRIDGE_VERSION="br-1.8.7"

WORKDIR /tmp

RUN git clone ${BRIDGE_URL} proton-bridge && \
    cd proton-bridge && \
    git checkout ${BRIDGE_VERSION} && \
    make build-nogui

FROM lsiobase/alpine:3.14

EXPOSE 25 143

RUN apk add --no-cache gnupg libsecret pass socat

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

COPY --from=builder /tmp/proton-bridge/proton-bridge /protonmail/bridge
COPY root/ /

VOLUME /config
