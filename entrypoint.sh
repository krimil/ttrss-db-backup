#!/bin/sh

# Initialize rclone if BACKUP=rclone and $(which rclone) is blank
if [ -z "$(which rclone)" ]; then
    # Install rclone - https://wiki.alpinelinux.org/wiki/Rclone
    RCLONE=/usr/bin/rclone
    curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
    unzip rclone-current-linux-amd64.zip
    cd rclone-*-linux-amd64
    cp rclone /usr/bin/
    chown root:root $RCLONE
    chmod 755 $RCLONE
fi 

# run backup once on container start to ensure it works
/backup-db.sh

# start crond in foreground
exec crond -f