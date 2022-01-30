type ..\sql\populate_db_part1.sql | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db
docker exec incremental_pg-barman_1 time barman backup postgres-source-db
type ..\sql\populate_db_part2.sql | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db
docker exec incremental_pg-barman_1 time barman backup --reuse=link postgres-source-db
type ..\sql\populate_db_part3.sql | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db
docker exec incremental_pg-barman_1 time barman backup --reuse=link postgres-source-db

