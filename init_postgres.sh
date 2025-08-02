#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER tealbase_admin LOGIN CREATEROLE CREATEDB REPLICATION BYPASSRLS;

    -- tealbase super admin
    CREATE USER tealbase_auth_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION PASSWORD 'root';
    CREATE SCHEMA IF NOT EXISTS $DB_NAMESPACE AUTHORIZATION tealbase_auth_admin;
    GRANT CREATE ON DATABASE postgres TO tealbase_auth_admin;
    ALTER USER tealbase_auth_admin SET search_path = '$DB_NAMESPACE';
EOSQL
