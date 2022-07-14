#!/bin/sh

cd /ttrss-docker
source .env
docker-compose exec ttrss-db /bin/bash \
  -c "export PGPASSWORD=$TTRSS_DB_PASS \
  && pg_dump -U $TTRSS_DB_USER $TTRSS_DB_NAME" \
  | gzip -9 > /backups/backup.sql.gzip
