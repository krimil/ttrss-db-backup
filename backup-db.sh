#!/bin/sh

pushd /ttrss-docker
source .env
docker-compose exec ttrss-db /bin/bash \
  -c "export PGPASSWORD=$TTRSS_DB_PASS \
  && pg_dump -U $TTRSS_DB_USER $TTRSS_DB_NAME" \
  | gzip -9 > /backups/backup.sql.gzip
popd

BACKUP_DIR=/backups
find $BACKUP_DIR/* -mtime +$BACKUP_DAYS -exec rm {} \;

REMOTE=$(rclone --config /config/rclone.conf listremotes | head -n 1)
rclone --config /config/rclone.conf sync $BACKUP_DIR $REMOTE$BACKUP_RCLONE_DEST
