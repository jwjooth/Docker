#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/.env"

docker run --name apache \
  -p 127.0.0.1:${APACHE_HTTP_PORT}:80 \
  -v apache_html:/usr/local/apache2/htdocs:ro \
  -d httpd:2.4-alpine

echo "Apache started on localhost:${APACHE_HTTP_PORT}"
