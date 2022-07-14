FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy curl && \
    apt-get install -qy gzip && \
    curl -sSL https://get.docker.com/ | sh

# copy backup script to crond daily folder
COPY backup-db.sh /

# copy entrypoint to usr bin
COPY entrypoint.sh /

# give execution permission to scripts
RUN chmod +x /entrypoint.sh && \
    chmod +x /backup-db.sh

RUN echo "15 23 * * * /backup-db.sh" > /etc/crontabs/root

ENTRYPOINT ["/entrypoint.sh"]