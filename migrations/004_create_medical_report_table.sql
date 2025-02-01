CREATE TABLE IF NOT EXISTS MedicalRecords (
    record_id SERIAL PRIMARY KEY,
    appointment_id INT NOT NULL,
    record_date DATE NOT NULL,
    diagnosis TEXT,
    prescription TEXT,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);