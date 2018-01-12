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
DATE=$(date +%Y%m%d%H%M%S)
BACKUPROOT=$(dirname $DIRTOBACKUP)
SERVICEDIR=$(basename $DIRTOBACKUP)
#####
trap clean_up SIGHUP SIGINT SIGQUIT SIGTERM
#####
function clean_up() {
    echo "you propably hit Ctrl-C or I received a signal(HUP/INT/QUIT/TERM)"
    echo "removing the temporary files..."
    rm -f "$BACKUPDIR.$SERVICE-${DATE}.tar.gz_INPROGRESS"
    echo "successfully removed the temporary file"
    echo "exiting now!"
    exit 1
}
#####
if [ ! -d "$BACKUPDIR" ]
then
    echo "The directory to backup to($BACKUPDIR) does not exist."
    echo "Creating $BACKUPDIR..."
    if [ "$(mkdir -p $BACKUPDIR)" ]
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
rm -f "$BACKUPDIR.$SERVICE-${DATE}.tar.gz_INPROGRESS"
cd "$BACKUPDIR" || exit 1
tar -cpzf ".$SERVICE-${DATE}.tar.gz_INPROGRESS" -C "$BACKUPROOT" "$SERVICEDIR"
mv -f "$BACKUPDIR.$SERVICE-${DATE}.tar.gz_INPROGRESS" "$BACKUPDIR$SERVICE-${DATE}.tar.gz"
exit 0
