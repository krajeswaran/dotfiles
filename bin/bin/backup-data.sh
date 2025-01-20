#!/bin/bash

HOST=$(hostname)
export DISPLAY=:0

# command line parsing fellows
while getopts dr opt; do
  case "$opt" in
  d) DRYRUN="--dry-run" ;;
  r) REVERSE=on ;;
  \?) # unknown flag
    echo >&2 \
      "usage: $0 [-d] [-r]"
    exit 1
    ;;
  esac
done
shift $(expr $OPTIND - 1)

if [ "$REVERSE" ]; then
  DEST="$HOME"
  SRC="pi@thesanepi:/data/backups/${HOST}/"
else
  SRC="$HOME"
  DEST="pi@thesanepi:/data/backups/${HOST}/"

  # get pkg list and store it in remote
  sudo dpkg --get-selections | grep -v 'deinstall' >${SRC}/pkglist.txt
  sudo apt-key exportall >${SRC}/pkgkeys.txt
  mkdir -p ${SRC}/apt
  sudo cp -avruf /etc/apt/ ${SRC}/apt

fi

if [ "$DRYRUN" ]; then
  DRYRUN="-d"
fi

command -v notify-send >/dev/null 2>&1 && NOTIFY=1

[[ "$NOTIFY" ]] && notify-send -u critical "Starting backup!"
echo '' >${HOME}/daily-backup.log

echo ---------------------- syncing home folder --------------------------------

if [ "$DRYRUN" ]; then
  DRYRUN="-n"
fi

rsync -L --one-file-system --stats --recursive --itemize-changes --progress --perms --archive --delete --protect-args --exclude-from="${HOME}/bin/backup-excludes.txt" $DRYRUN "/home" "$DEST"

echo ---------------------- end home folder ----------------------------

[[ "$NOTIFY" ]] && notify-send -u critical "Backup done!"
