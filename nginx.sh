#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/.env"

docker run --name nginx \
  -p 127.0.0.1:${NGINX_HTTP_PORT}:80 \
  -v nginx_html:/usr/share/nginx/html:ro \
  -d nginx:stable-alpine

echo "Nginx started on localhost:${NGINX_HTTP_PORT}"
