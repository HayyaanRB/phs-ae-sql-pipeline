#!/usr/bin/env bash
# Runs the pipeline end to end (scripts 00 to 05) inside the container.
# Stops at the first error (-b). Output is also saved to logs/.
set -euo pipefail
cd "$(dirname "$0")"
source .env
mkdir -p logs

SQLCMD=/opt/mssql-tools18/bin/sqlcmd
docker exec phs-sql test -x "$SQLCMD" || SQLCMD=/opt/mssql-tools/bin/sqlcmd

for script in 00_create_database 01_create_staging_tables 02_load_staging \
              03_create_core_tables 04_transform_and_load 05_data_quality_checks; do
  echo "=== Running $script.sql"
  docker exec phs-sql "$SQLCMD" -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -b -I \
      -W -s " | " -i "/project/sql/$script.sql" | tee "logs/$script.log"
done

echo
echo "Pipeline complete. Run 06 and 07 in VS Code to see results and execution plans."
