FROM alpine:latest

# install sqlite, curl, bash (for script)
RUN apk add --no-cache \
    curl \
    bash \
    openssl \
    tzdata \
    docker \
    docker-compose

# copy backup script to crond daily folder
COPY backup-db.sh /

# copy entrypoint to usr bin
COPY entrypoint.sh /

# give execution permission to scripts
RUN chmod +x /entrypoint.sh && \
    chmod +x /backup-db.sh

RUN echo "15 23 * * * /backup-db.sh" > /etc/crontabs/root

ENTRYPOINT ["/entrypoint.sh"]