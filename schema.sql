/* Database schema to keep the structure of entire database. */
-- ======================week 1 day 1==========================
-- DROP DATABASE IF EXISTS vet_clinic;
DROP DATABASE vet_clinic;

-- CREATE DATABASE vet_clinic;
CREATE DATABASE vet_clinic
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- CREATE TABLE animals;
CREATE TABLE animals (
    id int,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered BOOLEAN,
    weight_kg decimal(4, 2)
);
