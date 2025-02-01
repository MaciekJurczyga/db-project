-- View:  Appointments with Patient and Doctor Information
CREATE OR REPLACE VIEW view_appointments_details AS
SELECT
    a.appointment_id,
    a.appointment_date,
    a.appointment_time,
    a.status,
    p.name AS patient_name,
    p.surname AS patient_surname,
    d.name AS doctor_name,
    d.surname AS doctor_surname
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- View: Medical Records with Patient Information
CREATE OR REPLACE VIEW view_medical_records_details AS
SELECT
    mr.record_id,
    mr.record_date,
    mr.diagnosis,
    mr.prescription,
    mr.notes,
    p.name AS patient_name,
    p.surname AS patient_surname
FROM MedicalRecords mr
JOIN Appointments a ON mr.appointment_id = a.appointment_id
JOIN Patients p ON a.patient_id = p.patient_id;

--View: Services used in appointment with appointment details
CREATE OR REPLACE VIEW view_appointment_services_details AS
SELECT
    a.appointment_id,
    a.appointment_date,
    a.appointment_time,
    s.name as service_name,
    s.price
FROM Appointments a
JOIN Appointment_Services aps ON a.appointment_id = aps.appointment_id
JOIN Services s ON aps.service_id = s.service_id;

-- View: Invoices with patient details
CREATE OR REPLACE VIEW view_invoices_details AS
SELECT
    i.invoice_id,
    i.invoice_date,
    i.due_date,
    i.total_amount,
    i.status as invoice_status,
    p.name as patient_name,
        p.surname as patient_surname
FROM Invoices i
JOIN Patients p ON i.patient_id = p.patient_id;
