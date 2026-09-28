#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/.env"

docker run --name rabbitmq \
  -e RABBITMQ_DEFAULT_USER="${RABBITMQ_DEFAULT_USER}" \
  -e RABBITMQ_DEFAULT_PASS="${RABBITMQ_DEFAULT_PASS}" \
  -p 127.0.0.1:5672:5672 \
  -p 127.0.0.1:15672:15672 \
  -v rabbitmq_data:/var/lib/rabbitmq \
  -d rabbitmq:4-management-alpine

echo "RabbitMQ started on localhost:5672 (Management UI: localhost:15672, User: ${RABBITMQ_DEFAULT_USER})"