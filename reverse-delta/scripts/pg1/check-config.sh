#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../../"

echo "show archive_mode; show wal_level; show archive_timeout; show archive_command; show restore_command" | docker exec -T $(docker-compose ps -q postgres1) sh -c "psql -x -U \$POSTGRES_USER \$POSTGRES_DB -a -q -f -"