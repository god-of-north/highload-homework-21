#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../../"

docker exec -i $(docker-compose ps -q postgres1) sh -c "psql -U \$POSTGRES_USER \$POSTGRES_DB -c 'SELECT count(*) FROM contacts;'"