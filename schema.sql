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

/*Add owners, and alter animals*/

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name TEXT,
  age INTEGER
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name TEXT
);

ALTER TABLE animals
ADD COLUMN species_id INTEGER,
ADD COLUMN owner_id INTEGER;

ALTER TABLE animals
ADD FOREIGN KEY (species_id) REFERENCES species (id),
ADD FOREIGN KEY (owner_id) REFERENCES owners (id);


/*Add vets, specialization and visits*/

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  date_of_graduation DATE
);

CREATE TABLE specializations (
  vet_id INTEGER,
  species_id INTEGER,
  PRIMARY KEY (vet_id, species_id),
  FOREIGN KEY (vet_id) REFERENCES vets (id),
  FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  animal_id INTEGER,
  vet_id INTEGER,
  visit_date DATE,
  FOREIGN KEY (animal_id) REFERENCES animals (id),
  FOREIGN KEY (vet_id) REFERENCES vets (id)
);

/*Performance audit*/

--Add index visits table on animal_id
CREATE INDEX idx_visits_animal_id ON visits(animal_id);
--Add index visits table on vet_id
CREATE INDEX idx_visits_vet_id ON visits(vet_id);
--Add index owners email table on species_id
CREATE INDEX idx_owners_email ON owners(email);
