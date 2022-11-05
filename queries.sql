/*Queries that provide answers to the questions from all projects.*/
-- ======================week 1 day 1==========================
-- Get all animals which their names ends with "mon"
SELECT * FROM animals 
WHERE name LIKE '%mon';
-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals 
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals
WHERE neutered = TRUE AND escape_attempts < 3;
-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals
WHERE name = 'Agumon' OR name = 'Pikachu';
-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT * FROM animals
WHERE neutered = TRUE;
-- Find all animals not named Gabumon.
SELECT * FROM animals
WHERE name <> 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals
WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
-- ======================week 1 day 2==========================
-- Query 1
BEGIN;
  UPDATE animals SET species = 'unspecified';
  SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
-- Query 2
BEGIN;
  UPDATE animals SET species = 'digimon'
  WHERE name LIKE '%mon';
  UPDATE animals SET species = 'pokemon'
  WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;
-- Query 3
BEGIN;
  DELETE FROM animals;
  SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
-- Query 4
BEGIN;
  DELETE FROM animals
  WHERE date_of_birth > '2022-01-01';
  SAVEPOINT SP1;
  UPDATE animals SET weight_kg = weight_kg * -1;
  SELECT * FROM animals;
  ROLLBACK TO SP1;
  UPDATE animals SET weight_kg = weight_kg * -1
  WHERE weight_kg < 0;
  SELECT * FROM animals;
COMMIT;
-- Query 5 Questions Anwsers
SELECT COUNT(*) "ANIMALS_COUNT" FROM animals;
-- 
SELECT COUNT(*) "NO_ESCAPE_ANIMALS_COUNT" FROM animals 
WHERE escape_attempts = 0; 
-- 
SELECT AVG(weight_kg) "WEIGHT_AVERAGE" FROM animals;
-- 
SELECT neutered "IS_NEUTERED", SUM(escape_attempts) "ESCAPE_ATTEMPTS" FROM animals 
GROUP BY neutered 
ORDER BY "ESCAPE_ATTEMPTS" DESC;
-- 
SELECT neutered "IS_NEUTERED", MAX(weight_kg) "MAXIMUM_WEIGHT", MIN(weight_kg) "MINIMUM_WEIGHT" 
FROM animals GROUP BY neutered;
-- 
SELECT neutered "IS_NEUTERED", AVG(escape_attempts) "ESCAPE_ATTEMTPS_AVERAGE" FROM animals
WHERE date_of_birth BETWEEN '1990-12-31' AND '2000-01-01'
GROUP BY neutered;
-- ======================week 1 day 3==========================
-- Query & Answer the following questions:
-- What animals belong to Melody Pond?
SELECT animals.name "ANIMAL_NAME", owners.full_name "OWNER_NAME"
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name='Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals
WHERE species_id = (
  SELECT id FROM species
  WHERE name = 'Pokemon'
);
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name "OWNER_NAME", animals.name "ANIMAL_NAME"
FROM owners
LEFT JOIN animals ON animals.owner_id=owners.id;
-- How many animals are there per species?
SELECT species.name "SPECIE_NAME", COUNT(*) "ANIMALS_COUNT"
FROM animals
INNER JOIN species ON animals.species_id = species.id
GROUP BY species.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name "JENNIFER_ANIMALS"
FROM species
INNER JOIN animals ON animals.species_id = (SELECT species.id FROM species WHERE species.name = 'Digimon') 
WHERE animals.owner_id = (SELECT owners.id FROM owners WHERE owners.full_name = 'Jennifer Orwell');
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name "WINCHESTER_ANIMALS_NO-ESCAPE"
FROM owners
INNER JOIN animals ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
-- Who owns the most animals?
SELECT  MAX(owners.full_name) "OWNER (Owns most animals)", COUNT(animals.owner_id) "ANIMALS_COUNT"
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY animals.owner_id
ORDER BY COUNT(*) DESC 
LIMIT    1;
