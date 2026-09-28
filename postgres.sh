#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/.env"

docker run --name postgres \
  -e POSTGRES_PASSWORD="${POSTGRES_PASSWORD}" \
  -e POSTGRES_USER="${POSTGRES_USER}" \
  -e POSTGRES_DB="${POSTGRES_DB}" \
  -p 127.0.0.1:5432:5432 \
  -v postgres_data:/var/lib/postgresql/data \
  -d postgres:17-alpine

echo "PostgreSQL started on localhost:5432 (User: ${POSTGRES_USER}, DB: ${POSTGRES_DB})"