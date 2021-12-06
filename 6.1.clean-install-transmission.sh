#!/bin/bash
if [ "$(whoami)" != "rehman" ]; then
        echo "Script must be run as user: rehman"
        exit 255
fi

# stop and remove any running instances of flexget and transmission
docker rm -f flexget
docker rm -f transmission

# remove the folder
rm -rf /home/rehman/docker/transmission

mkdir -p /home/rehman/docker/transmission/flexget-config
ln /home/rehman/docker/config.yml /home/rehman/docker/transmission/flexget-config/config.yml
ln /home/rehman/docker/db-config.sqlite /home/rehman/docker/transmission/flexget-config/db-config.sqlite
ln -s /home/rehman/docker/transmission.env /home/rehman/docker/transmission/.env
wget -P /home/rehman/docker/transmission https://raw.githubusercontent.com/bheemboy/docker-flexget/master/docker-compose.yml

docker pull bheemboy/flexget
docker pull haugene/transmission-openvpn
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

docker-compose -f /home/rehman/docker/transmission/docker-compose.yml --env-file /home/rehman/docker/transmission/.env up -d
