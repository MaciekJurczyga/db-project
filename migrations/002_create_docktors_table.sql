CREATE TABLE IF NOT EXISTS Doctors (
    doctor_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100)
);
