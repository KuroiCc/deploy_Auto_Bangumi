#! /bin/bash

# 如果env.sh存在，就source
if [ -f ./env.sh ]; then
    . ./env.sh
fi

export DOWNLOAD_PATH=${DOWNLOAD_PATH:?"Need to set DOWNLOAD_PATH non-empty"}
export QB_PORT=${QB_PORT:?"Need to set QB_PORT non-empty"}

$(sudo -E nohup docker-compose up >>$LOG_PATH 2>&1 &)
echo $!
