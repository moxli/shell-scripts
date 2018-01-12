#!/usr/bin/env bash
#####
# Purpose: Backup a specific directory and delete old backups
#####
# Please change the four variables below according to your needs
#####
SERVICE="dotfiles" # what the finished backup fill will be called
DIRTOBACKUP="/home/mdorner/dotfiles/" # the directory you want to backup
BACKUPDIR="/mnt/backup1.moxli.de/dotfiles/" # where the backup file will be stored
KEEP=2 # the number of backups you want to keep
#####
if [ ! -d "$BACKUPDIR" ]
then
    echo "The directory to backup to($BACKUPDIR) does not exist."
    echo "Creating $BACKUPDIR..."
    if [ ! "$(mkdir -p $BACKUPDIR)" ]
    then
        exit 1
    else
        echo "Created $BACKUPDIR successfully."

    fi
fi
BACKUPS=$(find "$BACKUPDIR" -name "$SERVICE-*.tar.gz" | wc -l | sed 's/\ //g')
while [ "$BACKUPS" -ge "$KEEP" ]; do
    ls -tr1 "$BACKUPDIR$SERVICE"-*.tar.gz | head -n 1 | xargs rm -f
    BACKUPS=$(("$BACKUPS" -1))
done
DATE=$(date +%Y%m%d%H%M%S)
rm -f "$BACKUPDIR.$SERVICE-${DATE}.tar.gz_INPROGRESS"
cd "$BACKUPDIR" || exit 1
BACKUPROOT=$(dirname $DIRTOBACKUP)
SERVICEDIR=$(basename $DIRTOBACKUP)
tar -cpzf ".$SERVICE-${DATE}.tar.gz_INPROGRESS" -C "$BACKUPROOT" "$SERVICEDIR"
mv -f "$BACKUPDIR.$SERVICE-${DATE}.tar.gz_INPROGRESS" "$BACKUPDIR$SERVICE-${DATE}.tar.gz"
exit 0
