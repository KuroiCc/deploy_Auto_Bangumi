# 下载最新的docker-compose.yml

wget https://raw.githubusercontent.com/EstrellaXD/Auto_Bangumi/main/docs/docker-compose/qBittorrent+AutoBangumi/docker-compose.yml

# 修改docker-compose.yml中的TZ为当前时区
timezone=$(cat /etc/timezone)
sed -i "s#TZ=.*#TZ=$timezone#g" docker-compose.yml
