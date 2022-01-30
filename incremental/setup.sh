#!/usr/bin/env bash

# Local end setup..

mkdir -p ./data/postgresdatabase/db
mkdir -p ./data/postgresdatabase/db/sshkeys
mkdir -p ./data/postgresdatabase/db/data

mkdir -p ./data/pgbarman/
mkdir -p ./data/pgbarman/sshkeys
mkdir -p ./data/pgbarman/log
mkdir -p ./data/pgbarman/backupcfg
mkdir -p ./data/pgbarman/backups/postgres-source-db/incoming

ssh-keygen -b 4096 -t rsa -N '' -f ./data/postgresdatabase/db/sshkeys/id_rsa
ssh-keygen -f ./data/root/.ssh/id_rsa -y >> ./data/postgresdatabase/db/sshkeys/authorized_keys

ssh-keygen -b 4096 -t rsa -N '' -f ./data/pgbarman/sshkeys/id_rsa
ssh-keygen -f ./data/root/.ssh/id_rsa -y >> ./data/pgbarman/sshkeys/authorized_keys

ssh-keygen -f ./data/postgresdatabase/db/sshkeys/id_rsa -y >> ./data/pgbarman/sshkeys/authorized_keys
ssh-keygen -f ./data/pgbarman/sshkeys/id_rsa -y >> ./data/postgresdatabase/db/sshkeys/authorized_keys

chmod -R 777 ./data/pgbarman/sshkeys/*
chmod -R 777 ./data/postgresdatabase/db/sshkeys/*

cp postgres-source-db.conf ./data/pgbarman/backupcfg/.


# Remote end setup..

mkdir -p ./data/postgresdatabase/db_remote
mkdir -p ./data/postgresdatabase/db_remote/sshkeys
mkdir -p ./data/postgresdatabase/db_remote/data

mkdir -p ./data/pgbarman_remote/
mkdir -p ./data/pgbarman_remote/sshkeys
mkdir -p ./data/pgbarman_remote/log
mkdir -p ./data/pgbarman_remote/backupcfg
mkdir -p ./data/pgbarman_remote/backups

ssh-keygen -b 4096 -t rsa -N '' -f ./data/postgresdatabase/db_remote/sshkeys/id_rsa
ssh-keygen -f ./data/root/.ssh/id_rsa -y >> ./data/postgresdatabase/db_remote/sshkeys/authorized_keys

ssh-keygen -b 4096 -t rsa -N '' -f ./data/pgbarman_remote/sshkeys/id_rsa
ssh-keygen -f ./data/root/.ssh/id_rsa -y >> ./data/pgbarman_remote/sshkeys/authorized_keys

ssh-keygen -f ./data/postgresdatabase/db_remote/sshkeys/id_rsa -y >> ./data/pgbarman_remote/sshkeys/authorized_keys
ssh-keygen -f ./data/pgbarman_remote/sshkeys/id_rsa -y >> ./data/postgresdatabase/db_remote/sshkeys/authorized_keys

chmod -R 777 ./data/pgbarman_remote/sshkeys/*
chmod -R 777 ./data/postgresdatabase/db_remote/sshkeys/*

cp ./data/pgbarman/backupcfg/postgres-source-db.conf ./data/pgbarman_remote/backupcfg/.


