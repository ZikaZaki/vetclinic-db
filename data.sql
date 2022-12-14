/* Populate database with sample data. */
-- ======================week 1 day 1==========================
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
             VALUES (1, 'Agumon', '2020-02-03', 0, FALSE, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
             VALUES (2, 'Gabumon', '2018-15-11', 2, TRUE, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
             VALUES (3, 'Pikachu', '2021-07-01', 1, FALSE, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
             VALUES (4, 'Devimon', '2017-12-05', 5, TRUE, 11);
-- ======================week 1 day 2==========================
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
             VALUES (5, 'Charmander', '2020-02-08', 0, FALSE, -11);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
             VALUES (6, 'Plantmon', '2021-11-15', 2, TRUE, -5.7);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
             VALUES (7, 'Squirtle', '1993-04-02', 3, FALSE, -12.13);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
             VALUES (8, 'Angemon', '2005-06-12', 1, TRUE, -45);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
             VALUES (9, 'Boarmon', '2005-06-07', 7, TRUE, 20.4);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
             VALUES (10, 'Blossom', '1998-10-13', 3, TRUE, 17);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
             VALUES (11, 'Ditto', '2022-05-14', 4, TRUE, 22);
-- ======================week 1 day 3==========================
INSERT INTO owners (full_name, age)
            VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age)
            VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age)
            VALUES ('Bob', 45);
INSERT INTO owners (full_name, age)
            VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age)
            VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age)
            VALUES ('Jodie Whittaker', 38);
INSERT INTO species (name)
             VALUES ('Pokemon');
INSERT INTO species (name)
             VALUES ('Digimon');
-- UPDATE 1
BEGIN;
  UPDATE animals SET species_id = 2
  WHERE name LIKE '%mon';
  UPDATE animals SET species_id = 1
  WHERE species_id IS NULL;
COMMIT;
SELECT * FROM animals;
-- UPDATE 2
BEGIN;
  UPDATE animals SET owner_id = 1
  WHERE name = 'Agumon';
  UPDATE animals SET owner_id = 2
  WHERE name = 'Gabumon' OR name = 'Pikachu';
  UPDATE animals SET owner_id = 3
  WHERE name = 'Devimon' OR name = 'Plantmon';
  UPDATE animals SET owner_id = 4
  WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
  UPDATE animals SET owner_id = 5
  WHERE name = 'Angemon' OR name = 'Boarmon';
COMMIT;
SELECT * FROM animals;
-- ======================week 1 day 4==========================
INSERT INTO vets (name, age, date_of_graduation)
            VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation)
            VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation)
            VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation)
            VALUES ('Jack Harkness', 38, '2008-06-08');
-- specializations table
INSERT INTO specializations (specie_id, vet_id)
                     VALUES (1, 1);
INSERT INTO specializations (specie_id, vet_id)
                     VALUES (1, 3);
INSERT INTO specializations (specie_id, vet_id)
                     VALUES (2, 3);
INSERT INTO specializations (specie_id, vet_id)
                     VALUES (2, 4);
-- visits table
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (1, 1, '2020-05-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (1, 3, '2020-06-22');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (3, 2, '2020-01-05');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (3, 2, '2020-03-08');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (3, 2, '2020-05-14');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (4, 3, '2021-05-04');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (5, 4, '2021-02-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (6, 2, '2019-12-21');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (6, 1, '2020-08-10');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (6, 2, '2021-04-07');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (7, 3, '2019-09-29');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (8, 4, '2020-10-03');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (8, 4, '2020-11-04');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (9, 2, '2019-01-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (9, 2, '2019-05-15');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (9, 2, '2020-02-27');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (9, 2, '2020-08-03');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (10, 3, '2020-05-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
                     VALUES (10, 1, '2021-01-11');
-- ======================week 2 day 1==========================
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';