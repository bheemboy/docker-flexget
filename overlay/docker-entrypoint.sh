#!/usr/bin/env sh
set -e

PUID="${PUID:-1000}"
PGID="${PGID:-1000}"
export TZ="${TZ:-UTC}"

echo ""
echo "----------------------------------------"
echo " Starting FlexGet using the following:  "
echo "                                        "
echo "     UID: $PUID                         "
echo "     GID: $PGID                         "
echo "     TZ:  $TZ                           "
echo "----------------------------------------"
echo ""

# Copy default config files
if [ ! -f "/config/config.yml" ]; then
    echo "config.yml not found!!! Using default config.yml..."
    cp /defaults/config.yml /config/config.yml
fi

# Clear "config lock", if it exists
rm -f /config/.config-lock

# Set UID/GID of user
sed -i "s/^flexget\:x\:1000\:1000/flexget\:x\:$PUID\:$PGID/" /etc/passwd
sed -i "s/^flexget\:x\:1000/flexget\:x\:$PGID/" /etc/group

# Set permissions
chown -R $PUID:$PGID /config

echo "Starting Flexget daemon"
exec "$@"
