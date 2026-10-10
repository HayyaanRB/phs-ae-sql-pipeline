#!/usr/bin/env bash
# Starts SQL Server 2022 in Docker and mounts this project folder at /project
# inside the container, so SQL Server can read the CSV files in ./data.
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ]; then
  echo "Create a .env file first (copy .env.example and set a strong password)." >&2
  exit 1
fi
source .env

docker run -d --name phs-sql \
  -e "ACCEPT_EULA=Y" \
  -e "MSSQL_SA_PASSWORD=${MSSQL_SA_PASSWORD}" \
  -p 1433:1433 \
  -v "$(pwd)":/project \
  mcr.microsoft.com/mssql/server:2022-latest

echo "SQL Server is starting. Wait about 30 seconds, then run ./run_pipeline.sh"
