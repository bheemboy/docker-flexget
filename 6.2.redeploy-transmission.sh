#!/bin/bash
cd /home/rehman/docker/transmission
docker-compose down
docker pull bheemboy/flexget
docker pull haugene/transmission-openvpn
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
docker-compose up -d
cd -
