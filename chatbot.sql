use Hospital;
select * from doctor;
ALTER TABLE doctor;
SHOW CREATE TABLE patients;

INSERT INTO doctor (full_name, date_of_birth, gender, email, phone_number, specialization, experience, license_number, area)
VALUES


('Dr. Ankit Desai', '1987-08-20', 'Male', 'ankit.desai@example.com', '9823456789', 'Cardiologist', 12, 'D12456', 'Panvel'),
('Dr. Amit Shah', '1983-02-25', 'Male', 'amit.shah@example.com', '9934567890', 'Orthopedic', 15, 'D34567', 'Kharghar'),
('Dr. Neha Mehta', '1990-09-10', 'Female', 'neha.mehta@example.com', '9876543232', 'Pediatrician', 7, 'D45678', 'Seawoods'),
('Dr. Vikram Joshi', '1985-01-05', 'Male', 'vikram.joshi@example.com', '9812345548', 'Neurologist', 9, 'D56789', 'CBD Belapur');
ALTER TABLE departments DROP FOREIGN KEY departments_ibfk_1;
ALTER TABLE departments DROP COLUMN doctor_id;
ALTER TABLE departments ADD COLUMN doctor_full_name VARCHAR(100);
CREATE UNIQUE INDEX idx_doctor_name ON doctor (full_name);
select * from doctor;

ALTER TABLE departments
ADD CONSTRAINT fk_doctor_name
FOREIGN KEY (doctor_full_name)
REFERENCES doctor (full_name)
ON DELETE CASCADE;

DESC doctor;

ALTER TABLE doctor 
ADD COLUMN hospital_name VARCHAR(255) NOT NULL,
ADD COLUMN location VARCHAR(255) NOT NULL;

ALTER TABLE doctor 
ADD CONSTRAINT fk_hospital FOREIGN KEY (hospital_name, location) 
REFERENCES hospital(name, location) 
ON DELETE CASCADE;

SELECT CONSTRAINT_NAME 
FROM information_schema.TABLE_CONSTRAINTS 
WHERE TABLE_NAME = 'doctor' AND CONSTRAINT_TYPE = 'FOREIGN KEY';

ALTER TABLE doctor ADD COLUMN hospital_name VARCHAR(100), ADD COLUMN location VARCHAR(100);

SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME 
FROM information_schema.KEY_COLUMN_USAGE 
WHERE TABLE_NAME = 'doctor' AND REFERENCED_TABLE_NAME IS NOT NULL;



ALTER TABLE doctor DROP FOREIGN KEY fk_hospital;

ALTER TABLE doctor 
ADD CONSTRAINT fk_hospital FOREIGN KEY (hospital_name, location) 
REFERENCES hospital(name, location) 
ON DELETE CASCADE;




INSERT INTO departments (department_name, department_location, doctor_full_name)
VALUES
('Neurology', 'Navi Mumbai', 'Dr. Vikram Joshi'),
('Pediatrics', 'Kharghar', 'Dr. Neha Mehta'),
('Orthopedics', 'Belapur', 'Dr. Amit Shah'),
('Cardiology', 'Panvel', 'Dr. Ankit Desai');

describe departments;
CREATE TABLE patients (
    patient_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    doctor_id INT,
    department_name VARCHAR(100),
    PRIMARY KEY (patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (department_name) REFERENCES departments(department_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE patients ADD COLUMN hospital_name VARCHAR(100) NOT NULL;
ALTER TABLE patients ADD COLUMN location VARCHAR(100) NOT NULL;
ALTER TABLE patients ADD FOREIGN KEY (hospital_name, location) REFERENCES hospital(name, location);


desc doctor;
ALTER TABLE patients DROP FOREIGN KEY patients_ibfk_2;
ALTER TABLE patients DROP COLUMN department_name;
SELECT * FROM patients;

DESC patients;

ALTER TABLE hospital 
ADD CONSTRAINT pk_hospital PRIMARY KEY (name, location);

ALTER TABLE hospital 
DROP INDEX name;

ALTER TABLE hospital 
ADD UNIQUE KEY hospital_unique (name, location);


ALTER TABLE doctor 
ADD CONSTRAINT fk_hospital 
FOREIGN KEY (hospital_name, location) 
REFERENCES hospital(name, location) 
ON DELETE CASCADE ON UPDATE CASCADE;




ALTER TABLE doctor 
ADD CONSTRAINT fk_hospital 
FOREIGN KEY (hospital_name, location) 
REFERENCES hospital(name, location) 
ON DELETE CASCADE ON UPDATE CASCADE;





ALTER TABLE patients 
ADD COLUMN hospital_name VARCHAR(150) NOT NULL,
ADD COLUMN location VARCHAR(150) NOT NULL;

ALTER TABLE hospital ADD CONSTRAINT unique_hospital UNIQUE (name, location);

ALTER TABLE patients 
ADD CONSTRAINT fk_hospital
FOREIGN KEY (hospital_name, location) 
REFERENCES hospital(name, location);

SELECT p.hospital_name, p.location 
FROM patients p
LEFT JOIN hospital h 
ON p.hospital_name = h.name AND p.location = h.location
WHERE h.name IS NULL;

INSERT INTO hospital (name, location) 
SELECT DISTINCT hospital_name, location FROM patients
WHERE (hospital_name, location) NOT IN (SELECT name, location FROM hospital);

DELETE FROM patients 
WHERE (hospital_name, location) NOT IN (SELECT name, location FROM hospital);

ALTER TABLE patients 
ADD CONSTRAINT fk_hospital
FOREIGN KEY (hospital_name, location) 
REFERENCES hospital(name, location);


select * from doctor;

ALTER TABLE patients
ADD COLUMN time VARCHAR(20);


CREATE TABLE hospital (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    type ENUM('Private', 'Government') NOT NULL
);
select * from patients;
INSERT INTO hospital (name, location, type) VALUES
('NMMC General Hospital', 'Vashi', 'Government'),
('MGM Hospital', 'Belapur', 'Government'),
('Meenatai Thakre Hospital', 'Nerul', 'Government'),
('NMMC Hospital', 'Sector-48, Nerul', 'Government'),
('Acharyashri Nanesh Hospital', 'CBD Belapur', 'Government'),
('Indira Gandhi Memorial Hospital', 'Kopar Khairane', 'Government'),
('ESIC Hospital', 'Vashi', 'Government'),
('NMMC Urban Health Center', 'Turbhe', 'Government'),
('Civil Hospital', 'Thane', 'Government'),
('Lokmanya Tilak Municipal General Hospital', 'Sion', 'Government'),

('Apollo Hospitals', 'CBD Belapur', 'Private'),
('Rajgobind Maternity and General Hospital', 'CBD Belapur', 'Private'),
('Dr. Jairaj\'s Hospital', 'CBD Belapur', 'Private'),
('Mitr Hospital', 'Kharghar', 'Private'),
('Kharghar Medicity Hospital', 'Kharghar', 'Private'),
('Niramaya Hospital', 'Kharghar', 'Private'),
('Seawoods Hospital', 'Seawoods', 'Private'),
('Suyash Hospital', 'Belapur', 'Private'),
('MPCT Hospital', 'Sanpada', 'Private'),
('Medicover Hospital', 'Kharghar', 'Private'),
('Sanjeevan Hospital', 'Kharghar', 'Private'),
('Galaxy Multispeciality Hospital', 'Kharghar', 'Private'),
('Om Sai Baba Hospital', 'Kharghar', 'Private'),
('Colours Multispeciality Hospital', 'Kharghar', 'Private'),
('Dr. Ajayan\'s Multispeciality Hospital', 'Kharghar', 'Private'),
('Amar Hospital', 'Kharghar', 'Private'),
('Reliance Hospital', 'CBD Belapur', 'Private'),
('Harish Hospital', 'CBD Belapur', 'Private'),
('Golden Care Hospital', 'Panvel', 'Private'),
('Advanced Multispeciality Hospital', 'Seawoods', 'Private'),
('Elite Health Care Hospital', 'Kharghar', 'Private'),
('Metro Hospital', 'Sanpada', 'Private'),
('Vishwas Hospital', 'Ulwe', 'Private'),
('Global Multispeciality Hospital', 'Taloja', 'Private'),
('Noble Hospital', 'Kalamboli', 'Private'),
('Ayushman Hospital', 'Kamothe', 'Private');

INSERT INTO hospital (name, location, type) VALUES 
('Civil Hospital (V.S. General)', 'Thane', 'Government'),
('MGM Hospital', 'Belapur, Navi Mumbai', 'Government'),
('Sterling Hospital', 'Vashi, Navi Mumbai', 'Government'),
('Jijamata Hospital', 'Vashi, Navi Mumbai', 'Government'),
('Dr. Mahajan Hospital', 'Rabale, Navi Mumbai', 'Government'),
('Shri Sadguru Seva Mandal Hospital', 'Thane-Belapur Road, Navi Mumbai', 'Government'),
('NMMC General Hospital', 'Vashi, Navi Mumbai', 'Government'),
('NMMC General Hospital', 'Nerul, Navi Mumbai', 'Government'); 

describe doctor;
describe departments;

select * from patients;





