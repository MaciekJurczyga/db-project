-- Inserting data into Patients table
INSERT INTO Patients (name, surname, date_of_birth, gender, phone_number, email, street, city, postal_code, country)
VALUES
    ('John', 'Doe', '1990-05-15', 'Male', '555-1234', 'john.doe@example.com', '123 Main St', 'New York', '10001', 'USA'),
    ('Jane', 'Smith', '1985-10-20', 'Female', '555-5678', 'jane.smith@example.com', '456 Park Ave', 'Los Angeles', '90001', 'USA'),
    ('Alice', 'Brown', '1995-03-10', 'Female', '555-9012', 'alice.brown@example.com', '789 Oak Ln', 'Chicago', '60601', 'USA'),
    ('Bob', 'Jones', '1988-08-25', 'Male', '555-3456', 'bob.jones@example.com', '101 Pine Rd', 'Houston', '77001', 'USA'),
    ('Adam', 'Kowalski', '1988-08-25', 'Male', '555-3456', 'adam.kowalski@example.com', '101 Nowa', 'Warszawa', '00-001', 'Poland'),
    ('Katarzyna', 'Nowak', '1988-08-25', 'Female', '555-3456', 'katarzyna.nowak@example.com', '101 Stara', 'Krakow', '30-001', 'Poland');

-- Inserting data into Doctors table
INSERT INTO Doctors (name, surname, specialization, phone_number, email)
VALUES
    ('Michael', 'Johnson', 'Cardiologist', '555-7890', 'michael.johnson@example.com'),
    ('Sarah', 'Williams', 'Dermatologist', '555-2345', 'sarah.williams@example.com'),
    ('David', 'Brown', 'Pediatrician', '555-6789', 'david.brown@example.com'),
    ('Anna', 'Nowak', 'General practitioner', '555-6789', 'anna.nowak@example.com');

-- Inserting data into Appointments table
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status)
VALUES
    (1, 1, '2025-02-05', '10:00', 'Scheduled'),
    (2, 2, '2025-02-07', '14:30', 'Scheduled'),
    (3, 3, '2024-09-15', '09:00', 'Scheduled'),
    (4, 1, '2024-09-16', '11:00', 'Scheduled'),
    (5, 4, '2024-09-17', '12:00', 'Scheduled'),
    (1, 1, '2024-09-17', '15:00', 'Scheduled'),
    (2, 2, '2024-09-18', '13:30', 'Scheduled');

-- Inserting data into MedicalRecords table
INSERT INTO MedicalRecords (appointment_id, record_date, diagnosis, prescription, notes)
VALUES
    (1, '2024-09-10', 'High cholesterol', 'Statins', 'Follow up in 3 months'),
    (2, '2024-09-12', 'Acne', 'Topical creams', 'Avoid greasy foods'),
    (3, '2024-09-15', 'Common cold', 'Rest and fluids', 'No antibiotics required'),
    (4, '2024-09-16', 'Chest pain', 'ECG done', 'Consultation with cardiologist'),
    (5, '2024-09-17', 'General checkup', 'Healthy', 'See you next year'),
    (6, '2024-09-17', 'High cholesterol', 'Statins', 'Follow up in 3 months'),
    (7, '2024-09-18', 'Acne', 'Topical creams', 'Avoid greasy foods');


-- Inserting data into Services table
INSERT INTO Services (name, description, price)
VALUES
    ('Consultation', 'General consultation with a doctor', 100.00),
    ('Blood Test', 'Comprehensive blood analysis', 80.00),
    ('ECG', 'Electrocardiogram', 150.00),
    ('Physical Therapy', 'One-hour physical therapy session', 120.00),
    ('General checkup', 'General checkup with a doctor', 200.00);

-- Inserting data into Appointment_Services table
INSERT INTO Appointment_Services (appointment_id, service_id)
VALUES
    (1, 1),  
    (2, 2),  
    (3, 1), 
    (4, 3), 
    (5, 5),
    (6, 1),
    (7, 2),
    (1, 3);  



INSERT INTO Staff (name, surname, role, phone_number, email)
VALUES
    ('Emily', 'Clark', 'Receptionist', '555-4567', 'emily.clark@example.com'),
    ('Peter', 'Lee', 'Nurse', '555-8901', 'peter.lee@example.com'),
    ('Monika', 'Kowal', 'Cleaner', '555-8901', 'monika.kowal@example.com');

INSERT INTO Invoices (patient_id, appointment_id, invoice_date, due_date, total_amount, status)
VALUES
    (1, 1, '2024-09-10', '2024-09-24', 100.00, 'Pending'),
    (2, 2, '2024-09-12', '2024-09-26', 80.00, 'Pending'), 
    (3, 3, '2024-09-15', '2024-09-29', 100.00, 'Pending'),
    (4, 4, '2024-09-16', '2024-09-30', 150.00, 'Pending'),
    (1, 6, '2024-09-17', '2024-10-01', 250.00, 'Pending');