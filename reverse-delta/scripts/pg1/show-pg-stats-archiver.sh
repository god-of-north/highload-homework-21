#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../../"

echo "select * from pg_stat_archiver;" | docker exec -i $(docker-compose ps -q postgres1) sh -c "psql -x -U \$POSTGRES_USER \$POSTGRES_DB -a -q -f -"
