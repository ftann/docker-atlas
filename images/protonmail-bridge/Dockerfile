FROM golang:1.13-alpine AS builder

RUN apk add --no-cache gcc git make musl-dev libsecret-dev

ENV BRIDGE_URL="https://github.com/ProtonMail/proton-bridge.git" \
    BRIDGE_VERSION="1.6.3"

WORKDIR /tmp

RUN git clone ${BRIDGE_URL} proton-bridge && \
    cd proton-bridge && \
    git checkout v${BRIDGE_VERSION} && \
    make build-nogui

FROM lsiobase/alpine:3.13

EXPOSE 25 143

RUN apk add --no-cache gnupg libsecret pass socat

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

COPY --from=builder /tmp/proton-bridge/proton-bridge /protonmail/bridge
COPY root/ /

VOLUME /config
