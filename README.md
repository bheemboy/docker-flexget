FlexGet Docker Image
====================

FlexGet and transmission plugin in a Docker container, with configuration in a volume, and a configurable UID/GID for said files.

## Run

#### Docker Compose
Run this image with docker-compose, an example `docker-compose.yml` might read as follows:

```yaml
version: "3"
services:
    web:
        image: bheemboy/flexget
        container_name: flexget
        restart: unless-stopped
        environment:
            - PUID=1000
            - PGID=1000
        dns:
            - 1.1.1.1
        volumes:
            - ~/docker/flexget/:/config
            - ~/docker/transmission/watch/:/download
        cap_add: 
            - NET_ADMIN
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
`/download`     | Directry where torrents will be downloaded

## License
The content of this project itself is licensed under the [MIT License](LICENSE).

View [license information](https://github.com/Flexget/Flexget/blob/develop/LICENSE) for the software contained in this image.
