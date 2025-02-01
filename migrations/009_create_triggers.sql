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