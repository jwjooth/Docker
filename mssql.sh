#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/.env"

docker run --name mssql \
  -e "ACCEPT_EULA=Y" \
  -e "MSSQL_SA_PASSWORD=${MSSQL_SA_PASSWORD}" \
  -p 127.0.0.1:1433:1433 \
  -v mssql_data:/var/opt/mssql \
  -d mcr.microsoft.com/mssql/server:2022-latest

echo "MSSQL started on localhost:1433 (User: sa, Password: ${MSSQL_SA_PASSWORD})"