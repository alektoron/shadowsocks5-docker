#!/bin/sh
set -e

echo "Starting Shadowsocks in mode: ${SOCKS_MODE}"

case "$SOCKS_MODE" in
  server) exec ssserver -c /config/config.json ;;
  manager) exec ssmanager -c /config/config.json ;;
  local) exec sslocal -c /config/config.json ;;
  *)
    echo "Invalid SOCKS_MODE: $SOCKS_MODE. Use 'server', 'manager', or 'local'."
    exit 1
    ;;
esac