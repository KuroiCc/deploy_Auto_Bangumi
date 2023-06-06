#! /bin/bash

# 如果env.sh存在，就source
if [ -f ./env.sh ]; then
    . ./env.sh
fi

export GID=1000
export UID=1000
export DOWNLOAD_PATH=${DOWNLOAD_PATH:?"Need to set DOWNLOAD_PATH non-empty"}
export QB_PORT=${QB_PORT:?"Need to set QB_PORT non-empty"}

if [ ! -d "$DOWNLOAD_PATH" ]; then
    echo "mkdir $DOWNLOAD_PATH"
    mkdir -p $DOWNLOAD_PATH
fi

# 如果MOUNT_REMOTE=yes, 并且mount | grep $REMOTE_PATH没有结果(没有mount)，就mount
if [ "$MOUNT_REMOTE" = "yes" ] && [ -z "$(mount | grep $REMOTE_PATH)" ]; then
    echo "mounting $REMOTE_PATH to $DOWNLOAD_PATH"
    sudo mount -t cifs $REMOTE_PATH $DOWNLOAD_PATH -o username=$NAS918_SMB_USER_FOR_OPENWRT,password=$NAS918_SMB_PW_FOR_OPENWRT,iocharset=utf8,rw,file_mode=0766,dir_mode=0766,uid=$UID,gid=$GID
fi

$(nohup docker-compose up >>$LOG_PATH 2>&1 &)
echo $!
