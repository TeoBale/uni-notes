-- Esempio di revoca ricorsiva

-- si vedano le pagine PostgreSQL relative a GRANT e REVOKE
-- https://www.postgresql.org/docs/current/sql-grant.html
-- https://www.postgresql.org/docs/current/sql-revoke.html

-- aprire un terminale ed eseguire le seguenti operazioni dopo aver fatto login con l'utente proprietario del database imdb 
CREATE USER dbuser1 WITH PASSWORD 'dbuser1';
GRANT USAGE ON schema imdb to dbuser1;
GRANT SELECT ON imdb.movie TO dbuser1;

CREATE USER dbuser2 WITH PASSWORD 'dbuser2';
GRANT USAGE ON schema imdb to dbuser2;
GRANT SELECT ON imdb.movie TO dbuser2 with grant option;

CREATE USER dbuser3 WITH PASSWORD 'dbuser3';
GRANT USAGE ON schema imdb to dbuser3;

-- aprire un terminale ed eseguire le seguenti operazioni dopo aver fatto login con l'utente dbuser1
-- osservare gli effetti dei seguenti comandi:
select * from imdb.movie;
select * from imdb.person;

-- aprire un terminale ed eseguire le seguenti operazioni dopo aver fatto login con l'utente dbuser2:
GRANT SELECT ON imdb.movie TO dbuser3;

-- aprire un terminale ed eseguire le seguenti operazioni dopo aver fatto login con l'utente dbuser3
-- osservare gli effetti dei seguenti comandi:
select * from imdb.movie;
select * from imdb.person;

-- con l'utente proprietario del database imdb:
REVOKE SELECT ON imdb.movie TO dbuser2;

-- con dbuser2 e dbuser3 (osservare gli effetti del comando):
select * from imdb.movie;


-- Esempio di concessione di privilegi basati su contenuto (usando una vista)

-- con l'utente proprietario del database imdb:
CREATE VIEW imdb.movies_2010 AS (
SELECT id, official_title, length FROM imdb.movie WHERE year = '2010');

GRANT SELECT ON imdb.movies_2010 TO dbuser2;

-- con l'utente dbuser2, osservare gli effetti dei seguenti comandi:
select * from imdb.movie;
select * from imdb.movies_2010;


-- osservare gli effetti dei comandi di grant sullo schema nascosto denominato information_schema (catalogo relazionale di PostgreSQL)
-- https://www.postgresql.org/docs/current/information-schema.html
select * from information_schema.role_table_grants where table_schema = 'imdb';