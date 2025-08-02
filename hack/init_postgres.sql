CREATE USER tealbase_admin LOGIN CREATEROLE CREATEDB REPLICATION BYPASSRLS;

-- tealbase super admin
CREATE USER tealbase_auth_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION PASSWORD 'root';
CREATE SCHEMA IF NOT EXISTS auth AUTHORIZATION tealbase_auth_admin;
GRANT CREATE ON DATABASE postgres TO tealbase_auth_admin;
ALTER USER tealbase_auth_admin SET search_path = 'auth';
