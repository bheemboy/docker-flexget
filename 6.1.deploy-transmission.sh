#!/bin/bash
if [ "$(whoami)" != "rehman" ]; then
        echo "Script must be run as user: rehman"
        exit 255
fi

# stop and remove any running instances of flexget and transmission
docker stop flexget
docker rm -f flexget
docker stop transmission
docker rm -f transmission

wget -P /home/rehman/docker/transmission/flexget-config https://raw.githubusercontent.com/bheemboy/docker-flexget/master/config.yml
wget -P /home/rehman/docker/transmission https://raw.githubusercontent.com/bheemboy/docker-flexget/master/docker-compose.yml

ln -s /home/rehman/docker/.config/transmission/.env /home/rehman/docker/transmission/.env
ln /home/rehman/docker/.config/transmission/db-config.sqlite /home/rehman/docker/transmission/flexget-config/db-config.sqlite

docker pull bheemboy/flexget
docker pull haugene/transmission-openvpn
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

docker-compose -f /home/rehman/docker/transmission/docker-compose.yml --env-file /home/rehman/docker/transmission/.env up -d
