#!/bin/sh

# run backup once on container start to ensure it works
/backup-db.sh

# start crond in foreground
exec crond -f