/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INTEGER NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

/*Update animals table to add species column*/

ALTER TABLE animals ADD COLUMN species TEXT;

