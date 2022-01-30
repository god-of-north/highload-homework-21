#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../../"

docker exec -i $(docker-compose ps -q postgres1) sh -c '/wal-g wal-push -f $PGDATA'
