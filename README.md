FlexGet Docker Image
====================

FlexGet in a Docker container, with configuration in a volume, and a configurable UID/GID for said files.

<!--
[![](https://circleci.com/gh/bheemboy/docker-flexget.svg?style=svg)](https://circleci.com/gh/bheemboy/docker-flexget)
[![](https://img.shields.io/docker/pulls/bheemboy/flexget.svg)](https://hub.docker.com/r/bheemboy/flexget)
-->

## Install

#### Docker Hub
Pull the latest image from Docker Hub:

```shell
docker pull bheemboy/flexget
```

#### Manually
Clone this repository, and run `make build` to build an image:

```shell
git clone https://github.com/bheemboy/docker-flexget
cd docker-flexget
make build
```

If you need to rebuild the image, run `make clean build`.


## Run

#### Docker
Run this image with the `make run` shortcut, or manually with `docker run`.


```shell
docker run -v "$(pwd)/config:/config" \
           --name flexget \
           -e PUID=1111 \
           -e PGID=1112 \
           -e TZ=America/Los_Angeles \
           --restart unless-stopped \
           bheemboy/flexget:latest
```


#### Docker Compose
If you wish to run this image with docker-compose, an example `docker-compose.yml` might read as follows:

```yaml
---
version: "2"

services:
  flexget:
    image: bheemboy/flexget
    container_name: flexget
    environment:
      - PUID=1111
      - PGID=1112
    volumes:
      - </path/to/config>:/config
    restart: unless-stopped
```


## Configuration
Configuration files are stored in the `/config` volume. You may wish to mount this volume as a local directory, as shown in the examples above.

The main config file for FlexGet is `config.yml`, and will be created automatically if the container is started without a config file present. Please review the [FlexGet docs](https://flexget.com/Configuration) for more information.


#### User / Group Identifiers
If you'd like to override the UID and GID of the `flexget` process, you can do so with the environment variables `PUID` and `PGID`. This is helpful if other containers must access your configuration volume.

#### Timezone
The timezone the container uses defaults to `UTC`, and can be overridden with the `TZ` environment variable.

#### Volumes
Volume          | Description
----------------|-------------
`/config`       | Configuration directory


## License
The content of this project itself is licensed under the [MIT License](LICENSE).

View [license information](https://github.com/Flexget/Flexget/blob/develop/LICENSE) for the software contained in this image.
