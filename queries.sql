/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*Update animals table*/

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;

/*Queries for the questions*/

SELECT a.name 
FROM animals a 
JOIN owners o 
ON a.owner_id = o.id 
WHERE o.full_name = 'Melody Pond';

SELECT a.name 
FROM animals a 
JOIN species s 
ON a.species_id = s.id 
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name 
FROM owners o 
LEFT JOIN animals a 
ON o.id = a.owner_id;

SELECT s.name, COUNT(a.id) 
FROM species s 
LEFT JOIN animals a 
ON s.id = a.species_id 
GROUP BY s.name;

SELECT a.name 
FROM animals a 
JOIN species s 
ON a.species_id = s.id 
JOIN owners o 
ON a.owner_id = o.id 
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name 
FROM animals a 
JOIN owners o 
ON a.owner_id = o.id 
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(a.id) as animal_count 
FROM owners o 
JOIN animals a 
ON o.id = a.owner_id 
GROUP BY o.full_name 
ORDER BY animal_count DESC LIMIT 1;
