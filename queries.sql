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
-- ======================week 1 day 4==========================
-- Query & Answer the following questions:
-- Who was the last animal seen by William Tatcher?
SELECT vets.name,animals.name,visits.date_of_visit
FROM visits
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN animals ON animals.id = visits.animal_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC LIMIT 1 ;
-- How many different animals did Stephanie Mendez see?
SELECT  COUNT(distinct animals.name) "COUNT_ANIMALS_SEEN_BY_STEPHANIE"
FROM visits
INNER JOIN animals ON animals.id=visits.animal_id
INNER JOIN vets ON vets.id=visits.vet_id
WHERE vets.name = 'Stephanie Mendez';
-- List all vets and their specialties, including vets with no specialties.
SELECT  vets.name ,species.name
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON species.id = specializations.specie_id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT  animals.name ,visits.date_of_visit
FROM visits
INNER JOIN animals ON animals.id=visits.animal_id
INNER JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit > '2020-4-1' AND visits.date_of_visit < '2020-8-30';
-- What animal has the most visits to vets?
SELECT animals.name , COUNT(animals.name) 
FROM visits
LEFT JOIN animals ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY COUNT(animals.name) DESC LIMIT 1;
-- Who was Maisy Smith first visit?
SELECT vets.name, animals.name, visits.date_of_visit
FROM visits
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN animals ON animals.id = visits.animal_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC LIMIT 1 ;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.*, vets.*, visits.*
FROM visits 
LEFT JOIN animals ON animals.id = visits.animal_id
LEFT JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.date_of_visit DESC LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT  COUNT(DISTINCT date_of_visit) "VISITS_COUNT" 
FROM (SELECT a.name, a.species_id, ve.name,sp.specie_id, v.date_of_visit
      FROM visits v
      INNER  JOIN animals a ON a.id = v.animal_id
      INNER  JOIN vets ve  ON ve.id = v.vet_id
      INNER  JOIN species s ON s.id = a.species_id
      INNER  JOIN specializations sp ON sp.specie_id = ve.id
      ORDER BY v.date_of_visit DESC) AS z
WHERE z.species_id <> specie_id;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT x.SPECIE_NAME, COUNT(*)
FROM (SELECT vets.name AS VET_NAME, animals.name AS ANIMAL_NAME, species.name AS SPECIE_NAME 
      FROM visits 
      INNER JOIN animals ON animals.id = visits.animal_id
      INNER JOIN vets ON vets.id = visits.vet_id
      INNER JOIN species ON species.id = animals.species_id
      WHERE vet_id = 2) AS x
GROUP BY x.SPECIE_NAME   
ORDER BY COUNT(*) DESC LIMIT 1;