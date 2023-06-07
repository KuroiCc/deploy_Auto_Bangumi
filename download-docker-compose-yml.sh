# 下载最新的docker-compose.yml

# qBittorrent+AutoBangumi
# wget https://raw.githubusercontent.com/EstrellaXD/Auto_Bangumi/main/docs/docker-compose/qBittorrent+AutoBangumi/docker-compose.yml

# AutoBangumi only
wget https://raw.githubusercontent.com/EstrellaXD/Auto_Bangumi/main/docs/docker-compose/AutoBangumi/docker-compose.yml

# 修改docker-compose.yml中的TZ为当前时区
timezone=$(cat /etc/timezone)
sed -i "s#TZ=.*#TZ=$timezone#g" docker-compose.yml

# AutoBangumi only的时候在environment下添加AB_DOWNLOADER_HOST
sed -i "/environment:/a \ \ \ \ \ \ - AB_DOWNLOADER_HOST=\${AB_DOWNLOADER_HOST}" docker-compose.yml
