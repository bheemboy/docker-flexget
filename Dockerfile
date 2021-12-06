# Use the following commands to build and push
# docker build --build-arg FLEXGET_VERSION="3.1.155" -t bheemboy/flexget:latest -t bheemboy/flexget:3.1.155 .
# docker push --all-tags bheemboy/flexget

FROM python:alpine
LABEL maintainer="Sunil Rehman"
LABEL description="FlexGet on Alpine Linux"
ARG FLEXGET_VERSION

# Add users before any software to prevent UID/GID conflicts
RUN addgroup -S -g 1000 flexget; \
    adduser -S -H -G flexget -u 1000 flexget

# Add dependencies
RUN set -eux; \
    apk add --update --no-cache \
        libjpeg \
        zlib \
        libstdc++; \
    mkdir \
        /config \
        /download \
        /flexget; \
    pip install -U setuptools pip packaging

VOLUME /config
VOLUME /download
ADD https://github.com/Flexget/Flexget/tarball/v${FLEXGET_VERSION} flexget.tar.gz

# Install flexget
RUN set -eux; \
    apk add --update --no-cache --virtual .build-deps \
        g++ \
        gcc \
        libgcc \
        jpeg-dev \
        musl-dev \
        zlib-dev \
        linux-headers \
    ; \
    tar --strip-components=1 -xzvf flexget.tar.gz -C /flexget; \
    cd /flexget; \
    python3 setup.py install; \
    pip install -U transmission-rpc; \
    \
    rm -rf /flexget /flexget.tar.gz; \
    apk del .build-deps

COPY overlay/ /

HEALTHCHECK --interval=1m CMD /healthcheck.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["su", "-p", "-s", "/bin/sh", "flexget", "-c", "/usr/local/bin/flexget -c /config/config.yml --loglevel verbose daemon start --autoreload-config"]
