#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/.env"

docker run --name redis \
  -e REDIS_PASSWORD="${REDIS_PASSWORD}" \
  -p 127.0.0.1:6379:6379 \
  -v redis_data:/data \
  -d redis:7-alpine redis-server --appendonly yes --requirepass "${REDIS_PASSWORD}"

echo "Redis started on localhost:6379"
