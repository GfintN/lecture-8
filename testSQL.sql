CREATE DATABASE test_db
    WITH
    ENCODING = 'UTF8';

CREATE TABLE object_storage (
  id BIGSERIAL NOT NULL PRIMARY KEY, 
  object_name VARCHAR(30) NOT NULL,
  serial_number VARCHAR(7) UNIQUE NOT NULL,
  quantity_in_stock SMALLINT DEFAULT 0,
  date_of_create DATE NOT NULL
);

CREATE TABLE object_organization_name ( 
  serial_number VARCHAR(7) PRIMARY KEY,
  name_organization VARCHAR,
  FOREIGN KEY(serial_number) REFERENCES object_storage(serial_number)
);

CREATE TABLE creator_organization ( 
  name_organization VARCHAR NOT NULL PRIMARY KEY,
  firs_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL
);

INSERT INTO object_storage (object_name, serial_number, quantity_in_stock, date_of_create) 
VALUES 
('Popcorn', '102-ddq', 10, '2021-10-18'),
('Cola', '133-6dq', 20, '2021-10-18'),
('Robot-W', 'W111233', 1, '2021-10-10'),
('Robot-S', 'W111234', 1, '2021-10-11'),
('Robot-D', 'W111235', 1, '2021-10-11'),
('Paper-A4', 'p110', 1000, '2021-8-10'),
('Paper-A3', 'p210', 1000, '2021-8-10'),
('Armchair', 'Opp12', 50, '2021-9-10'),
('Chair', 'Paw23', 100, '2021-10-1'),
('Bed', 'Iop94', 20, '2021-10-2');

INSERT INTO object_organization_name (serial_number, name_organization) 
VALUES 
('102-ddq', 'CiPop'),
('133-6dq', 'Cola'),
('W111233', 'R-w'),
('W111234', 'R-s'),
('W111235', 'R-d'),
('p110', 'PapeRa'),
('p210', 'PapeRa'),
('Opp12', 'ModBa'),
('Paw23', 'ModBa'),
('Iop94', 'ModBa');

INSERT INTO creator_organization 
VALUES 
('CiPop','Bob','Bravados'),
('Cola','Pi','Lakoto'),
('R-V','Vitya','Popov'),
('PapeRa','Lily','Kiskoty'),
('ModBa','Yana','Adamova');

SELECT * FROM object_storage 
WHERE date_of_create IN ('2021-10-10', '2021-10-11'); 

SELECT quantity_in_stock, date_of_create FROM object_storage 
WHERE date_of_create = '2021-10-10' OR date_of_create = '2021-10-11'; 

SELECT * FROM object_organization_name 
WHERE name_organization = 'Cola' AND name_organization = 'CiPop';

SELECT * FROM object_organization_name LIMIT 5;

UPDATE object_organization_name
SET name_organization = 'R-V'  
WHERE name_organization LIKE 'R-%';

DELETE FROM object_organization_name 
WHERE serial_number = '102-ddq';

DELETE FROM object_storage 
WHERE quantity_in_stock BETWEEN 9 AND 11;

ALTER TABLE object_organization_name
ADD CONSTRAINT organization_fk FOREIGN KEY(name_organization) REFERENCES creator_organization(name_organization);

SELECT serial.serial_number, creator.firs_name , creator.last_name  
FROM object_organization_name serial
INNER JOIN creator_organization creator ON creator.name_organization = serial.name_organization;
