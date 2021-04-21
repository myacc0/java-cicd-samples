#!/bin/bash

set -e

docker run -d -p $1:$1 \
  --restart=unless-stopped \
  --name 'dev-gateway-server' \
  --network='development-network' \
  --add-host='docker.lan:192.168.10.12' \
  --add-host='gitlab.lan:192.168.10.12' \
  dev-gateway-server:lts

exit 0