# highload-homework-21

All backed up

- Take/create the database from your pet project
- Implement all kinds of repository models (Full, Incremental, Differential, Reverse Delta, CDP)
- Compare their parameters: size, ability to roll back at specific time point, speed of roll back, cost


## Full

Populate data
```
type ..\sql\populate_db_part1.sql | docker exec -i full_db_1 psql -U pguser db
type ..\sql\populate_db_part2.sql | docker exec -i full_db_1 psql -U pguser db
type ..\sql\populate_db_part3.sql | docker exec -i full_db_1 psql -U pguser db
```

Backup
```
docker exec -i full_db_1 pg_dumpall -U pguser > /archive/backup.bak
```

Restore. Time = 
```
docker exec -i full_db_1 psql -U pguser -f /archive/backup.bak db
```

## Incremental

Based on https://github.com/softwarebrahma/PostgreSQL-Disaster-Recovery-With-Barman

Install & run
```
> setup.sh
> docker-compose build
> docker-compose up -d
```

Test
```
> type ..\sql\populate_db_part1.sql | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db
> docker exec incremental_pg-barman_1 time barman backup postgres-source-db
> type ..\sql\populate_db_part2.sql | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db
> docker exec incremental_pg-barman_1 time barman backup --reuse=link postgres-source-db
> type ..\sql\populate_db_part3.sql | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db
> docker exec incremental_pg-barman_1 time barman backup --reuse=link postgres-source-db

> docker exec incremental_pg-barman_1 barman list-backup postgres-source-db

> echo \d | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db

> docker exec incremental_pg-barman_1 barman recover --target-time="2022-01-30 14:05:00" postgres-source-db 20220130T140254 /tmp/data
> docker exec incremental_pg-barman_1 cp -r /tmp/data /backup/restore

> docker-compose stop postgres-source-db
> xcopy .\data\pgbarman\restore\data .\data\postgresdatabase\db\data /E /H /I /Y
> docker-compose up -d postgres-source-db

> echo \d | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db
```

## Reverse Delta

Based on https://github.com/stephane-klein/playground-postgresql-walg

```
./scripts/build-postgres-with-wal-g-docker-image.sh
docker-compose up -d postgres1 s3
./scripts/pg1/insert1.sh
./scripts/pg1/make-basebackup.sh
./scripts/pg1/insert2.sh
./scripts/pg1/insert3.sh
./scripts/pg2/restore.sh
```

## CDP

Used tool cdpfgl: https://github.com/dupgit/sauvegarde

```
hid   | ----------                                   -----------
to    | | client |  <------------------------------> | server |
user  | ----------                                   -----------
                                                          ^
user                  -----------                         |
client                | restore | <-----------------------|
(GUI ?)               -----------
\                                       /            \          /
 ----- Client side (on a notebook) -----              - server -
                                                         side
```

cdpfglclient config for PostgreSQL to backup only database.
```
[Client]
directory-list=/var/lib/postgresql/data
```

Restore
```
rm -rf /var/lib/postgresql/data/*
cdpfglrestore --restore="^/var/lib/postgresql/data/(.*)$" --date="2022-10-31 13:03:00" --parents --where="/var/lib/postgresql/data/"
```

## Comparision table

| type          | size | ability to roll back at specific time point | speed of roll back | cost |
|---------------|------|---------------------------------------------|--------------------|------|
| Full          | 118MB|                   -                         |            57sec   |      |
| Incremental   |1.46GB|                   +                         |            41sec   |      |
| Reverse Delta | 189MB|                   +                         |            56sec   |      |
| CDP           | 179MB|                   +                         |            44sec   |      |
