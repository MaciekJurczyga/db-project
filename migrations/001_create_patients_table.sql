CREATE TABLE IF NOT EXISTS Patients (
    patient_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10),
    country VARCHAR(50)
);