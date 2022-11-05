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
-- ======================week 1 day 2==========================
ALTER TABLE animals ADD species varchar(100);
-- ======================week 1 day 3==========================
CREATE TABLE owners (
    id int GENERATED ALWAYS AS IDENTITY,
    full_name varchar(200),
    age int
);
CREATE TABLE species (
    id int GENERATED ALWAYS AS IDENTITY,
    name varchar(100)
);
BEGIN
  SELECT * FROM animals;
  ALTER TABLE animals MODIFY id int GENERATED ALWAYS AS IDENTITY;
  ALTER TABLE animals DROP COLUMN species;
  ALTER TABLE animals ADD species_id int;
  ALTER TABLE animals ADD CONSTRAINT FK_species_id FOREIGN KEY (species_id) REFERENCES species(id);
  ALTER TABLE animals ADD owner_id int;
  ALTER TABLE animals ADD CONSTRAINT FK_owners_id FOREIGN KEY (owner_id) REFERENCES owners(id);
  SELECT * FROM animals;
COMMIT; 