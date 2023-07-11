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
-- Verify that change was made
SELECT * FROM animals;
ROLLBACK;
-- Verify that the species columns went back to the state before the transaction
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
-- Verify that changes were made
SELECT * FROM animals;
COMMIT;
-- Verify that changes persist after commit
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
-- Verify that all records were deleted
SELECT * FROM animals;
ROLLBACK;
-- Verify that all records still exist after rollback
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
-- Verify that changes were made
SELECT * FROM animals;
ROLLBACK TO my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
-- Verify that changes were made
SELECT * FROM animals;
COMMIT;
