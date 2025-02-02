# Medical Clinic Database Project

# Running the System in Docker

This project uses Docker to simplify setup and deployment. Follow these steps to get the database running:

1. **Prerequisites:** Make sure you have Docker and Docker Compose installed on your system.

2. **Clone the Repository (If applicable):** If you're using a Git repository, clone the project to your local machine.

3. **Navigate to Project Directory:** Open your terminal and navigate to the `medical_clinic_db` directory (the directory containing the `docker-compose.yml` file).

4. **Start Docker Compose:** Execute the following command to build and start the database in detached mode:

   ```bash
   docker-compose up -d
   ```
5. **Verify Container Status:** Execute the following command to make sure container started succesffully:
   ```bash
   docker ps
   ```
6. **Access the database:** Execute the following command to connect to medical_clinic database:
   - through CMD
       ```bash
      docker exec -it db-project-db-1 psql -U admin -d medical_clinic
      ```
   - through Docker Deskoopt (Containers -> db-project-db-1 -> Exec)
      ```bash
      psql -h localhost -p 5432  -U admin -d medical_clinic
      ```
8. **Stopping the container:** After ending work on database, stop the container with following command:
    ```bash
   docker-compose down
   ```
# Database Documentation

## Tables

### 1. Patients

| Column Name    | Data Type    | Description                                 |
|----------------|--------------|---------------------------------------------|
| patient_id     | SERIAL       | Unique identifier for each patient.        |
| name           | VARCHAR(50)  | Patient's first name.                       |
| surname        | VARCHAR(50)  | Patient's last name.                        |
| date_of_birth  | DATE         | Patient's date of birth.                    |
| gender         | VARCHAR(10)  | Patient's gender (Male, Female, Other).     |
| phone_number   | VARCHAR(15)  | Patient's phone number.                     |
| email          | VARCHAR(100) | Patient's email address.                    |
| street         | VARCHAR(100) | Patient's street address.                   |
| city           | VARCHAR(50)  | Patient's city.                             |
| postal_code    | VARCHAR(10)  | Patient's postal code.                      |
| country        | VARCHAR(50)  | Patient's country.                          |

### 2. Doctors

| Column Name    | Data Type    | Description                                 |
|----------------|--------------|---------------------------------------------|
| doctor_id      | SERIAL       | Unique identifier for each doctor.         |
| name           | VARCHAR(50)  | Doctor's first name.                        |
| surname        | VARCHAR(50)  | Doctor's last name.                         |
| specialization | VARCHAR(100) | Doctor's specialization.                    |
| phone_number   | VARCHAR(15)  | Doctor's phone number.                      |
| email          | VARCHAR(100) | Doctor's email address.                     |

### 3. Appointments

| Column Name    | Data Type    | Description                                 |
|----------------|--------------|---------------------------------------------|
| appointment_id | SERIAL       | Unique identifier for each appointment.    |
| patient_id     | INT          | Foreign key referencing Patients.          |
| doctor_id      | INT          | Foreign key referencing Doctors.           |
| appointment_date | DATE       | Date of the appointment.                    |
| appointment_time | TIME       | Time of the appointment.                    |
| status         | VARCHAR(20)  | Appointment status (Scheduled, Completed, Cancelled). |

### 4. MedicalRecords

| Column Name    | Data Type    | Description                                 |
|----------------|--------------|---------------------------------------------|
| record_id      | SERIAL       | Unique identifier for each medical record. |
| appointment_id | INT          | Foreign key referencing Appointments.      |
| record_date    | DATE         | Date of the medical record.                |
| diagnosis      | TEXT         | Medical diagnosis.                          |
| prescription   | TEXT         | Prescribed medication or treatment.         |
| notes          | TEXT         | Additional notes.                           |

### 5. Services

| Column Name    | Data Type    | Description                                 |
|----------------|--------------|---------------------------------------------|
| service_id     | SERIAL       | Unique identifier for service              |
| name           | VARCHAR(100) | Name of service                            |
| description    | TEXT         | Description of service                     |
| price          | DECIMAL(10,2)| Price of service                           |

### 6. Appointment_Services

| Column Name    | Data Type    | Description                                 |
|----------------|--------------|---------------------------------------------|
| appointment_id | INT          | Foreign key to appointment                 |
| service_id     | INT          | Foreign key to service                     |

### 7. Staff

| Column Name    | Data Type    | Description                                 |
|----------------|--------------|---------------------------------------------|
| staff_id       | SERIAL       | Unique identifier for each staff member.   |
| name           | VARCHAR(50)  | Staff member's first name.                  |
| surname        | VARCHAR(50)  | Staff member's last name.                   |
| role           | VARCHAR(100) | Staff member's role.                        |
| phone_number   | VARCHAR(15)  | Staff member's phone number                 |
| email          | VARCHAR(100) | Staff member's email                        |

### 8. Invoices

| Column Name    | Data Type    | Description                                 |
|----------------|--------------|---------------------------------------------|
| invoice_id     | SERIAL       | Unique identifier for invoice              |
| patient_id     | INT          | Foreign key to Patient                      |
| appointment_id | INT          | Foreign key to Appointment                  |
| invoice_date   | DATE         | Invoice generation date                    |
| due_date       | DATE         | Invoice due date                            |
| total_amount   | DECIMAL(10,2)| Total amount of the invoice                 |
| status         | VARCHAR(20)  | Invoice status (Pending, Paid, Overdue, Cancelled) |

# Triggers

- ### set_appointment_completed
   This trigger automatically updates the status of an appointment to 'Completed' when an invoice is created for that appointment.
    
    **Usage:**

    `INSERT INTO Invoices (patient_id, appointment_id, invoice_date, due_date, total_amount, status)
        VALUES (1, 7, '2024-10-01', '2024-10-15', 200.00, 'Pending');`
  
    `SELECT status from Appointments WHERE appointment_id = 7;` 
    Appoitment status should be completed now.

- ### check_overdue_invoice_trigger
    Automatically changes the status of Invoice to Overdue when the due_date is before current_date.
    
    **Usage:**
  
    `UPDATE Invoices SET due_date = '2023-01-01' WHERE invoice_id = 1;`
  
    `SELECT status FROM Invoices WHERE invoice_id = 1;` 
    Invoice status should be "Overdue" now
- ### check_appointment_time_trigger
     Checks if the new appointment is shceduled in working hours (8:00 - 16:00), if not, raises an exception
  
     **Usage:**
  
     `INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time) VALUES (1, 1, '2024-10-26', '07:00');`

     This should raise an exception as appointment is planned for 7am

- ### calculate_invoice_total_trigger
     Calucalted total_amount (cost of appointment) based on prices of all services permored during this appointment.
  
     **Usage:**
  
     `INSERT INTO Invoices (patient_id, appointment_id, invoice_date, due_date) VALUES (2, 2, '2024-10-27', '2024-11-10');`

     If you look into invoices table now, total_amount was calucalted automatically.

# Functions

- ### calculate_patient_total_due(patient_id_input INT)
    This function calculates the total amount due for a given patient by summing up the total_amount of all their pending and overdue invoices.
    
    **Usage:**  
    `SELECT calculate_patient_total_due(1);`  
    (Replace `1` with the desired patient_id)

- ### get_doctor_appointments(doctor_id_input INT)
    This function retrieves all appointments for a specific doctor, including the appointment date, time, and patient's name.

    **Usage:**  
    `SELECT * FROM get_doctor_appointments(1);`  
    (Replace `1` with the desired doctor_id)
  
- ### count_doctor_appointments(doctor_id_input INT, start_date DATE, end_date DATE)
   Counts appointments of particular doctor (with doctor_id_input) in given period (from start to end date)

   **Usage:**  
    `SELECT count_doctor_appointments(1, '2024-09-01', '2024-09-30');`

- ### get_upcoming_appointments(days_ahead INT)
  Shows all upcoming appointments in the next [days_ahead] days

  **Usage:**  
    `SELECT * FROM get_upcoming_appointments(7); `
    
# Views

- ### view_appointments_details
    This view combines data from the Appointments, Patients, and Doctors tables to provide a comprehensive view of appointment details, including patient and doctor information.
    
    **Usage:**  
    `SELECT * FROM view_appointments_details;`

- ### view_medical_records_details
    This view joins the MedicalRecords, Appointments, and Patients tables to provide detailed medical record information along with patient details.
    
    **Usage:**  
    `SELECT * from view_medical_records_details;`
    
- ### view_appointment_services_details
    Combines data from Appointments and Services to show which services have been used in a given appointment.
    
    **Usage:**  
    `SELECT * from view_appointment_services_details;`

- ### view_invoices_details
    Joins Invoices and Patients table to show details about invoice along with patient data.
    
    **Usage:**  
    `SELECT * from view_invoices_details;`

   # Example Queries
- Query 1: Find patients who have had at least two appointments with the same doctor in the last six months. Useful to find loyal patients.
  ```
      SELECT p.name AS patient_name, p.surname AS patient_surname, d.name AS doctor_name, d.surname AS doctor_surname,
            COUNT(*) AS appointment_count
      FROM Patients p
      JOIN Appointments a ON p.patient_id = a.patient_id
      JOIN Doctors d ON a.doctor_id = d.doctor_id
      WHERE a.appointment_date >= CURRENT_DATE - INTERVAL '6 months'
      GROUP BY p.patient_id, d.doctor_id
      HAVING COUNT(*) > 1;```

- Query 2: Find average monthly revenue per doctor. Useful for financial analysis and doctor's engagement.
  ```
  WITH MonthlyRevenue AS (
    SELECT d.doctor_id, d.name AS doctor_name, d.surname AS doctor_surname, DATE_TRUNC('month', i.invoice_date) AS month, SUM(i.total_amount) AS monthly_revenue
    FROM Doctors d
    JOIN Appointments a ON d.doctor_id = a.doctor_id
    JOIN Invoices i ON a.appointment_id = i.appointment_id
    GROUP BY d.doctor_id, month
   )
   SELECT doctor_name, doctor_surname, AVG(monthly_revenue) AS average_monthly_revenue
   FROM MonthlyRevenue
   GROUP BY doctor_id, doctor_name, doctor_surname;
  ```
- Query 3: Find patients, who had appointments for all servieces in the clinic, useful to give some discounts to loyal patients;
   ```
   SELECT p.name AS patient_name, p.surname AS patient_surname
   FROM Patients p
   WHERE NOT EXISTS (
       SELECT 1
       FROM Services s
       EXCEPT
       SELECT s2.service_id
       FROM Appointment_Services aps2
       JOIN Appointments a2 ON aps2.appointment_id = a2.appointment_id
       JOIN Services s2 ON aps2.service_id = s2.service_id
       WHERE a2.patient_id = p.patient_id
   );
   
   ```


  
