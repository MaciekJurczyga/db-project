CREATE OR REPLACE FUNCTION update_appointment_status()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Appointments
    SET status = 'Completed'
    WHERE appointment_id = NEW.appointment_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_appointment_completed
AFTER INSERT ON Invoices
FOR EACH ROW
EXECUTE FUNCTION update_appointment_status();

CREATE OR REPLACE FUNCTION check_overdue_invoice()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.due_date < CURRENT_DATE AND NEW.status = 'Pending' THEN
    NEW.status := 'Overdue';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_overdue_invoice_trigger
BEFORE UPDATE ON Invoices
FOR EACH ROW
EXECUTE FUNCTION check_overdue_invoice();

CREATE OR REPLACE FUNCTION check_appointment_time()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.appointment_time < '08:00' OR NEW.appointment_time > '16:00' THEN
    RAISE EXCEPTION 'Appointments can only be scheduled between 8:00 and 16:00.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_appointment_time_trigger
BEFORE INSERT OR UPDATE ON Appointments
FOR EACH ROW
EXECUTE FUNCTION check_appointment_time();


CREATE OR REPLACE FUNCTION calculate_invoice_total()
RETURNS TRIGGER AS $$
BEGIN
    SELECT SUM(s.price) 
    INTO NEW.total_amount
    FROM Appointment_Services aps
    JOIN Services s ON aps.service_id = s.service_id
    WHERE aps.appointment_id = NEW.appointment_id;
        
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER calculate_invoice_total_trigger
BEFORE INSERT ON Invoices
FOR EACH ROW
EXECUTE FUNCTION calculate_invoice_total();
