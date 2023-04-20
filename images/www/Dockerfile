FROM nginxinc/nginx-unprivileged:1.24.0-alpine-slim

ENV NGINX_ENTRYPOINT_QUIET_LOGS=true

COPY --chown=nginx root/ /
