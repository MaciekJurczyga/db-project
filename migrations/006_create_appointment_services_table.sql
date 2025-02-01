CREATE TABLE IF NOT EXISTS Appointment_Services (
    appointment_id INT NOT NULL,
    service_id INT NOT NULL,
        PRIMARY KEY (appointment_id, service_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);