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

CREATE OR REPLACE FUNCTION get_upcoming_appointments(days_ahead INT)
RETURNS TABLE (
    patient_name VARCHAR(50),
    patient_surname VARCHAR(50),
    appointment_date DATE,
    appointment_time TIME
) AS $$
BEGIN
  RETURN QUERY
  SELECT p.name, p.surname, a.appointment_date, a.appointment_time
  FROM Patients p
  JOIN Appointments a ON p.patient_id = a.patient_id
  WHERE a.appointment_date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '1 day' * days_ahead
  ORDER BY a.appointment_date, a.appointment_time;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION count_doctor_appointments(doctor_id_input INT, start_date DATE, end_date DATE)
RETURNS INT AS $$
DECLARE
  appointment_count INT;
BEGIN
  SELECT COUNT(*) INTO appointment_count
  FROM Appointments
  WHERE doctor_id = doctor_id_input
    AND appointment_date BETWEEN start_date AND end_date;

  RETURN appointment_count;
END;
$$ LANGUAGE plpgsql;