FROM golang:1.18-alpine3.16 AS builder

RUN apk add --no-cache bash gcc make musl-dev libsecret-dev

ENV BRIDGE_URL="https://github.com/ProtonMail/proton-bridge/archive/refs/tags/v2.4.0.tar.gz" \
    BRIDGE_CHECKSUM=012879033686cd5304f628e1f5d885f50ea19b849f99f383a218007a1ef8cbd3

WORKDIR /tmp

RUN wget \
        ${BRIDGE_URL} -O proton-bridge.tar.gz && \
    echo "${BRIDGE_CHECKSUM}  proton-bridge.tar.gz" | sha256sum -c - && \
    tar -xzvf \
        proton-bridge.tar.gz && \
    cd proton-bridge-* && \
    make build-nogui

FROM alpine:3.16

ARG USER=atlas
ARG PUID=2000
ARG PGID="${PUID}"

RUN addgroup -g "${PGID}" "${USER}" && \
    adduser -D -u "${PUID}" -G "${USER}" -s /bin/false -h /config "${USER}"

RUN apk add --no-cache dbus-x11 gnupg libsecret pass tzdata

EXPOSE 1025 1143

COPY --from=builder --chown="${PUID}:${PGID}" /tmp/proton-bridge-*/proton-bridge /app/proton-bridge
COPY --chown="${PUID}:${PGID}" root/ /

RUN mkdir -p \
      /config && \
    mkfifo /tmp/fakettyp && \
    chown "${USER}:${USER}" -R \
      /config \
      /tmp/fakettyp

VOLUME /config

USER "${USER}"

ENTRYPOINT ["/entrypoint.sh"]
