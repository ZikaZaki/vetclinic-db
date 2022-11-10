-- ======================week 2 day 2==========================
-- DROP DATABASE IF EXISTS clinic;
DROP DATABASE vet_clinic;
-- CREATE DATABASE clinic;
CREATE DATABASE clinic WITH OWNER = postgres ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252' TABLESPACE = pg_default CONNECTION
LIMIT
  = -1 IS_TEMPLATE = False;
-- CREATE TABLE patients;
  CREATE TABLE patients (
    id int,
    name varchar(200),
    date_of_birth date
  );