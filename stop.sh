#! /bin/bash

# 如果env.sh存在，就source
if [ -f ./env.sh ]; then
    . ./env.sh
fi

export GID=1000
export UID=1000
export AB_DOWNLOADER_HOST=${AB_DOWNLOADER_HOST:?"Need to set AB_DOWNLOADER_HOST non-empty"}
export QB_PORT=${QB_PORT:?"Need to set QB_PORT non-empty"}

if [ "$LOCAL_QB" = "yes" ] && [ ! -d "$DOWNLOAD_PATH" ]; then
    export DOWNLOAD_PATH=${DOWNLOAD_PATH:?"Need to set DOWNLOAD_PATH non-empty"}
    echo "mkdir $DOWNLOAD_PATH"
    mkdir -p $DOWNLOAD_PATH
fi

# 如果MOUNT_REMOTE=yes, 并且mount | grep $REMOTE_PATH没有结果(没有mount)，就mount
if [ "$MOUNT_REMOTE" = "yes" ] && [ -z "$(mount | grep $REMOTE_PATH)" ]; then
    echo "mounting $REMOTE_PATH to $DOWNLOAD_PATH"
    sudo mount -t cifs $REMOTE_PATH $DOWNLOAD_PATH -o username=$NAS918_SMB_USER_FOR_OPENWRT,password=$NAS918_SMB_PW_FOR_OPENWRT,iocharset=utf8,rw,file_mode=0766,dir_mode=0766,uid=$UID,gid=$GID
fi

docker-compose stop
