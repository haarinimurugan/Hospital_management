-- View All Patients

select * from Patients;

-- View Patient's Medical History
select medical_history from Patients where patient_id = 1;

-- List All  Doctors
select doctor_id,name from Doctors;
--  View Scheduled Appointments
select * from Appointments where status = 'Scheduled';

-- Get Appointments for a Specific Patient
select * from Appointments where patient_id = 1;

-- Get Doctor's Appointments
select * from Appointments where doctor_id = 1;

-- Update Appointment Status

update Appointments 
set status = "completed"
where appointment_id = 1;
-- Insert New Billing Record
insert into Billing (patient_id, doctor_id, bill_date, amount, status)
values (1, 1, '2024-10-18', 250.00, 'Pending');

-- View Unpaid Bills
SELECT * FROM Billing WHERE status = 'Pending';

-- Get Total Bills for a Specific Patient

select sum(amount) as Bill from Billing where patient_id = 1 ;

-- Mark Bill as Paid
update Billing set status = "paid" where bill_id = 1 ;

-- Count Total Patients
select count(*) as total from Patients;

-- View All Patients With a Specific Doctor

SELECT Patients.name                           
FROM Patients                                 
INNER JOIN Appointments ON Patients.patient_id = Appointments.patient_id  
WHERE Appointments.doctor_id = 1; 

-- View Billing Report for a Specific Month
SELECT d.name AS doctor_name, COUNT(a.appointment_id) AS total_appointments  -- Selects the doctor's name and counts the total number of appointments
FROM Doctors d                                                                -- From the Doctors table (alias 'd')
JOIN Appointments a ON d.doctor_id = a.doctor_id                               -- Joins the Appointments table on doctor_id to match each doctor with their appointments
WHERE MONTH(a.appointment_date) = 10 AND YEAR(a.appointment_date) = 2024       -- Filters the appointments to only include those from October 2024
GROUP BY d.doctor_id;                                                          -- Groups the results by doctor_id to get the count of appointments per doctor

-- Retrieve Total Income Generated From Appointments for Each Doctor

SELECT d.name AS doctor_name, SUM(b.amount) AS total_income          
FROM Doctors d                                                      
JOIN Billing b ON d.doctor_id = b.doctor_id                         
WHERE b.status = 'Paid'                                             
GROUP BY d.doctor_id;                                               

-- Find Patients Who Have Not Paid Their Bills (Pending Bills)

SELECT p.name, b.amount, b.bill_date                                   -- Selects the patient's name, bill amount, and bill date
FROM Patients p                                                        -- From the Patients table (alias 'p')
JOIN Billing b ON p.patient_id = b.patient_id                           -- Joins the Billing table on patient_id to match patients with their billing records
WHERE b.status = 'Pending';                                             -- Filters the billing records to only include those with a 'Pending' status


-- Get a List of Patients Who Have Missed (Cancelled) Appointments

select p.patient_id,p.name from Patients p
join Appointments a on p.patient_id = a.patient_id
where a.status= "Cancelled";

-- Calculate the Average Bill Amount for All Patients

select avg(amount) as Amount from  Billing;

--  List of Doctors Who Have Had No Appointments in the Last Month

select d.name from Doctors d left join
Appointments a on d.doctor_id = a.doctor_id
and a.appointment_date >= date_sub(curdate(), interval 1 month)
where a.appointment_id is null;

-- Find the Most Frequent Patients (Top 3 Patients Based on Number of Appointments)

select p.name,count(a.appointment_id) as Apponitment from Patients p
join Appointments a on a.patient_id = p.patient_id
group by p.name 
order by count(a.appointment_id) desc limit 3;

-- Retrieve All Patients Who Have Been Assigned to a Specific Doctor

SELECT p.name                                             
FROM Patients p                                          
JOIN Appointments a ON p.patient_id = a.patient_id      
WHERE a.doctor_id = 1;                                   

-- Get Total Appointments Per Day

select appointment_date,count(appointment_id) as Total from Appointments 
group by appointment_date;

-- Find Patients Who Have Not Visited in the Last 6 Months

select p.name from Patients p left join
Appointments a on p.patient_id = a.patient_id
and a.appointment_date >= date_sub(curdate(), interval 6 month)
where a.appointment_id is null;

-- Get All Paid Bills Along With the Responsible Doctor

select p.name as patients , d.name as doctors ,b.amount
from Billing as b join Patients p on p.patient_id = b.patient_id
join Doctors as d on d.doctor_id = b.doctor_id
where b.status = "Paid";

-- Calculate Total Revenue by Month

select month(b.bill_date) as month , year(b.bill_date) as year , sum(b.amount) as total
from Billing b
where b.status = "Paid"
group by year(b.bill_date),month(b.bill_date);

--  Find Doctors Specializing in More Than One Area

SELECT d.name, COUNT(d.specialization) AS specialization_count  
FROM Doctors d                                                 
GROUP BY d.doctor_id                                          
HAVING specialization_count > 1;

--  List All Patients Along With Their Appointment History and Billing Status

select p.name,a.appointment_date,b.status ,a.status as appointment_status from Patients p
join  Appointments a on  p.patient_id = a.patient_id
join  Billing b on p.patient_id= b.patient_id