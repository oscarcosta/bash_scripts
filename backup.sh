#!/bin/bash
#
# ex: ./backup.sh (local|remote) source_dir destination_dir
#

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

SRC=$1
DEST=$2

# set the backup type
TYPE='local'
SCP_PAT='^.*@([0-9]{1,3}.){3}[0-9]{1,3}:.*$'
if [[ $DEST =~ $SCP_PAT ]]; then
  TYPE='remote'
fi

# rsync params
DEST_FULL=$DEST/Full/
DEST_INCR=$DEST/Inc/$(date +%Y%m%d)
EXCLUDE="--exclude='.git/' --exclude='node_modules'"
#TEST='--dry-run'

if [[ "$TYPE" == "local" && -e $DEST_INCR ]] ; then
  echo 'Overriding incremental backup folder:' $DEST_INCR
  rm -fr $DEST_INCR
fi

rsync -ah $TEST --progress --delete --inplace $EXCLUDE --backup --backup-dir=$DEST_INCR $SRC $DEST_FULL

exit 0
