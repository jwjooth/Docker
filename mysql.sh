#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/.env"

docker run --name mysql \
  -e MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD}" \
  -e MYSQL_DATABASE="${MYSQL_DATABASE}" \
  -e MYSQL_USER="${MYSQL_USER}" \
  -e MYSQL_PASSWORD="${MYSQL_PASSWORD}" \
  -p 127.0.0.1:3306:3306 \
  -v mysql_data:/var/lib/mysql \
  -d mysql:8.0-alpine

echo "MySQL started on localhost:3306 (Root: root, User: ${MYSQL_USER}, DB: ${MYSQL_DATABASE})"