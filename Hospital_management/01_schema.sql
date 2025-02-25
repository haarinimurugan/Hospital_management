-- CREATE DATABASE HospitalPatientDB;
 -- USE HospitalPatientDB;
 
CREATE TABLE Patients (
    patient_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    dob DATE,
    contact_number VARCHAR(15),
    address VARCHAR(255),
    medical_history TEXT
);


-- Create the Doctors table
CREATE TABLE Doctors (
    doctor_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    specialization VARCHAR(100),
    contact_number VARCHAR(15),
    email VARCHAR(100)
);

-- Create the Appointments table
CREATE TABLE Appointments (
    appointment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_time TIME,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);


-- Create the Billing table
CREATE TABLE Billing (
    bill_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    bill_date DATE,
    amount DECIMAL(10, 2),
    status ENUM('Paid', 'Pending', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

INSERT INTO Patients (name, gender, dob, contact_number, address, medical_history) 
VALUES 
('John Doe', 'Male', '1985-07-12', '1234567890', '123 Elm St', 'Diabetes, Hypertension'),
('Jane Smith', 'Female', '1990-09-25', '0987654321', '456 Oak St', 'Asthma'),
 ('Michael Scott', 'Male', '1964-03-15', '2223334444', '789 Birch St', 'Hypertension'),
('Pam Beesly', 'Female', '1980-09-25', '9876543210', '456 Cedar St', 'None'),
('Dwight Schrute', 'Male', '1978-01-20', '5556667777', '123 Farm Ln', 'None'),
('Jim Halpert', 'Male', '1979-10-01', '1112223333', '321 Maple St', 'Back Pain');

INSERT INTO Doctors (name, specialization, contact_number, email) 
VALUES 
('Dr. Alice Johnson', 'Cardiologist', '5551234567', 'alice.j@hospital.com'),
('Dr. Robert Brown', 'Dermatologist', '5559876543', 'robert.b@hospital.com'),
('Dr. Meredith Palmer', 'Psychiatrist', '5553334444', 'meredith.p@hospital.com'),
('Dr. Stanley Hudson', 'Endocrinologist', '5557778888', 'stanley.h@hospital.com');

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status) 
VALUES 
(1, 1, '2024-10-20', '10:00:00', 'Scheduled'),
(2, 2, '2024-10-21', '11:30:00', 'Scheduled'),
(3, 1, '2024-10-22', '09:00:00', 'Completed'),
(4, 3, '2024-10-23', '12:00:00', 'Scheduled'),
(5, 4, '2024-10-24', '14:00:00', 'Cancelled');

INSERT INTO Billing (patient_id, doctor_id, bill_date, amount, status) 
VALUES 
(1, 1, '2024-10-20', 200.00, 'Paid'),
(2, 2, '2024-10-21', 150.00, 'Pending'),
(3, 1, '2024-10-22', 300.00, 'Paid'),
(4, 3, '2024-10-23', 250.00, 'Pending'),
(5, 4, '2024-10-24', 400.00, 'Cancelled');

