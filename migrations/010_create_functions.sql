CREATE OR REPLACE FUNCTION calculate_patient_total_due(patient_id_input INT)
RETURNS DECIMAL(10, 2) AS $$
DECLARE
    total_due DECIMAL(10, 2);
BEGIN
    SELECT SUM(total_amount) INTO total_due
    FROM Invoices
    WHERE patient_id = patient_id_input AND status IN ('Pending', 'Overdue');
    RETURN total_due;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_doctor_appointments(doctor_id_input INT)
RETURNS TABLE (
    appointment_id INT,
    appointment_date DATE,
    appointment_time TIME,
    patient_name VARCHAR(50),
    patient_surname VARCHAR(50)
) AS $$
BEGIN
    RETURN QUERY SELECT
        a.appointment_id,
        a.appointment_date,
        a.appointment_time,
        p.name,
        p.surname
    FROM Appointments a
    JOIN Patients p ON a.patient_id = p.patient_id
    WHERE a.doctor_id = doctor_id_input;
END;
$$ LANGUAGE plpgsql;