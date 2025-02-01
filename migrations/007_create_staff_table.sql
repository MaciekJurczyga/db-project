CREATE TABLE IF NOT EXISTS Staff (
    staff_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    role VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100)
);