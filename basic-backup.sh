#!/bin/bash
KEEP=2
BACKUPS=$(find /backup/ -name "dokuwiki-*.tar.gz" | wc -l | sed 's/\ //g')
while [ "$BACKUPS" -ge "$KEEP" ]
do
ls -tr1 /backup/dokuwiki-*.tar.gz | head -n 1 | xargs rm -f
BACKUPS=$(expr "$BACKUPS" - 1)
done
DATE=$(date +%Y%m%d%H%M%S)
rm -f /backup/.dokuwiki-"${DATE}".tar.gz_INPROGRESS
cd /backup/ || exit
tar -cvpzf .dokuwiki-"${DATE}".tar.gz_INPROGRESS /var/www/dokuwiki/
mv -f /backup/.dokuwiki-"${DATE}".tar.gz_INPROGRESS /backup/dokuwiki-"${DATE}".tar.gz
exit 0
