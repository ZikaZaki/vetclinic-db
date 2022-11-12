-- ======================week 2 day 2==========================
-- DROP DATABASE IF EXISTS clinic;
DROP DATABASE clinic;
-- CREATE DATABASE clinic;
CREATE DATABASE clinic WITH OWNER = postgres ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252' TABLESPACE = pg_default CONNECTION
LIMIT
  = -1 IS_TEMPLATE = False;
-- CREATE TABLE patients;
  CREATE TABLE patients (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(200),
    date_of_birth date
  );
-- CREATE TABLE medical_histories;
  CREATE TABLE medical_histories (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    admitted_at timestamp,
    patient_id int REFERENCES patients(id),
    status VARCHAR(20),
  );
-- CREATE TABLE treatments;
  CREATE TABLE treatments (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(50),
    name VARCHAR(200)
  );
-- CREATE TABLE history_treatments;
  CREATE TABLE history_treatments (
    medical_history_id int REFERENCES medical_histories(id),
    treatment_id int REFERENCES treatments(id),
    PRIMARY KEY (medical_history_id, treatment_id)
  );
--  CREATE TABLE invoices;
  CREATE TABLE invoices (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL(10, 2),
    generated_at timestamp,
    paid_at timestamp,
    medical_history_id int REFERENCES medical_histories(id)
  );