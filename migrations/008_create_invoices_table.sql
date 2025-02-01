CREATE TABLE IF NOT EXISTS Invoices (
    invoice_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT NOT NULL,
    invoice_date DATE NOT NULL,
    due_date DATE,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Paid', 'Overdue', 'Cancelled')) DEFAULT 'Pending',
        FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);