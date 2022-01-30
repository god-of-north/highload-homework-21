# highload-homework-21

All backed up

- Take/create the database from your pet project
- Implement all kinds of repository models (Full, Incremental, Differential, Reverse Delta, CDP)
- Compare their parameters: size, ability to roll back at specific time point, speed of roll back, cost

## Install
```
git clone
cd ..
```


## Full

Backup
```
pg_dumpall > dumpfile
```

Restore
```
psql -f dumpfile postgres
```

Backup with gzip
```
pg_dumpall | gzip > filename.gz
```

Restore with gzip
```
gunzip -c filename.gz | psql dbname
```

- size: 
- ability to roll back at specific time point: 
- speed of roll back: 
- cost: 

## Incremental

https://github.com/softwarebrahma/PostgreSQL-Disaster-Recovery-With-Barman

```
> setup.sh
> docker-compose build
> docker-compose up -d

> type populate_db_part1.sql | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db
> docker exec incremental_pg-barman_1 time barman backup postgres-source-db
> type populate_db_part2.sql | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db
> docker exec incremental_pg-barman_1 time barman backup --reuse=link postgres-source-db

> docker exec incremental_pg-barman_1 barman list-backup postgres-source-db

> echo \d | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db

> docker exec incremental_pg-barman_1 barman recover --target-time="2022-01-30 09:26:22" postgres-source-db 20220130T092517 /tmp/data
> docker exec incremental_pg-barman_1 cp -r /tmp/data /backup/restore

> docker-compose stop postgres-source-db
> xcopy .\data\pgbarman\restore\data .\data\postgresdatabase\db\data /E /H /I /Y
> docker-compose up -d postgres-source-db

> echo \d | docker exec -i incremental_postgres-source-db_1 psql -U dbadmin db
```

## Differential


pg_basebackup 
archive_command = 'test ! -f /mnt/server/archivedir/%f && cp %p /mnt/server/archivedir/%f'
restore_command = 'cp /mnt/server/archivedir/%f %p' 


> type populate_db_part1.sql | docker exec -i differential_db_1 psql -U dbadmin postgres
wait...
> type populate_db_part2.sql | docker exec -i differential_db_1 psql -U dbadmin postgres


> echo \d | docker exec -i differential_db_1 psql -U dbadmin postgres


rm -rf /var/lib/postgresql/data/pg_xlog/*
recovery.conf
restore_command = 'cp /archive/%f %p'\n
# recovery_end_command = 'rm -fr barman_wal'
recovery_target_time = '2022-01-30 13:57:00'


## Reverse Delta

## CDP



## Comparision table

| type          | size | ability to roll back at specific time point | speed of roll back | cost |
|---------------|------|---------------------------------------------|--------------------|------|
| Full          |      |                                             |                    |      |
| Incremental   |      |                                             |                    |      |
| Differential  |      |                                             |                    |      |
| Reverse Delta |      |                                             |                    |      |
| CDP           |      |                                             |                    |      |
