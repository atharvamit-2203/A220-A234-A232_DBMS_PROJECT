CREATE TABLE new_doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(15),
    specialization VARCHAR(255),
    experience INT,
    license_number VARCHAR(50) UNIQUE,
    hospital_name VARCHAR(255),
    location VARCHAR(255),
    FOREIGN KEY (hospital_name, location) REFERENCES hospital(name, location)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO new_doctor (doctor_id, full_name, date_of_birth, gender, email, phone_number, specialization, experience, license_number)
SELECT doctor_id, full_name, date_of_birth, gender, email, phone_number, specialization, experience, license_number FROM doctor;

ALTER TABLE departments DROP FOREIGN KEY fk_doctor_name;
ALTER TABLE patients DROP FOREIGN KEY patients_ibfk_1;

DROP TABLE doctor;

RENAME TABLE new_doctor TO doctor;
ALTER TABLE patients ADD CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id);

select * from doctor;

SELECT TABLE_NAME, CONSTRAINT_NAME
FROM information_schema.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'FOREIGN KEY'
AND CONSTRAINT_NAME = 'fk_hospital';

ALTER TABLE doctor 
ADD CONSTRAINT fk_hospital
FOREIGN KEY (hospital_name, location) 
REFERENCES hospital(name, location)
ON DELETE CASCADE;

ALTER TABLE doctor DROP FOREIGN KEY fk_hospital;

ALTER TABLE doctor  
ADD COLUMN hospital_name VARCHAR(255),  
ADD COLUMN location VARCHAR(255);


SET SQL_SAFE_UPDATES = 0;
UPDATE doctor  
SET hospital_name = CASE  
    WHEN id % 9 = 0 THEN 'Fortis Hospital'  
    WHEN id % 9 = 1 THEN 'Apollo Hospital'  
    WHEN id % 9 = 2 THEN 'Jupiter Hospital'  
    WHEN id % 9 = 3 THEN 'Hiranandani Hospital'  
    WHEN id % 9 = 4 THEN 'Nanavati Super Specialty Hospital'  
    WHEN id % 9 = 5 THEN 'Bethany Hospital'  
    WHEN id % 9 = 6 THEN 'MGM Hospital'  
    WHEN id % 9 = 7 THEN 'Bombay Hospital'  
    ELSE 'Kaushalya Medical Foundation'  
END,  
location = CASE  
    WHEN id % 9 = 0 THEN 'Navi Mumbai'  
    WHEN id % 9 = 1 THEN 'Mumbai'  
    WHEN id % 9 = 2 THEN 'Thane'  
    WHEN id % 9 = 3 THEN 'Navi Mumbai'  
    WHEN id % 9 = 4 THEN 'Mumbai'  
    WHEN id % 9 = 5 THEN 'Thane'  
    WHEN id % 9 = 6 THEN 'Navi Mumbai'  
    WHEN id % 9 = 7 THEN 'Mumbai'  
    ELSE 'Thane'  
END;

update doctor
SET hospital_name = CASE 
    WHEN full_name = 'John Doe' THEN 'MGM Hospital'
    WHEN full_name = 'Emily Smith' THEN 'Sterling Hospital'
    WHEN full_name = 'Raj Patel' THEN 'Jijamata Hospital'
    WHEN full_name = 'Priya Sharma' THEN 'Dr. Mahajan Hospital'
    WHEN full_name = 'Dr. Ankit Desai' THEN 'Shri Sadguru Seva Mandal Hospital'
    WHEN full_name = 'Dr. Amit Shah' THEN 'NMMC General Hospital'
    WHEN full_name = 'Dr. Neha Mehta' THEN 'NMMC General Hospital'
    ELSE 'Civil Hospital (V.S. General)'
END,
location = CASE 
    WHEN full_name = 'John Doe' THEN 'Belapur, Navi Mumbai'
    WHEN full_name = 'Emily Smith' THEN 'Vashi, Navi Mumbai'
    WHEN full_name = 'Raj Patel' THEN 'Vashi, Navi Mumbai'
    WHEN full_name = 'Priya Sharma' THEN 'Rabale, Navi Mumbai'
    WHEN full_name = 'Dr. Ankit Desai' THEN 'Thane-Belapur Road, Navi Mumbai'
    WHEN full_name = 'Dr. Amit Shah' THEN 'Vashi, Navi Mumbai'
    WHEN full_name = 'Dr. Neha Mehta' THEN 'Nerul, Navi Mumbai'
    ELSE 'Thane'
END;

select * from doctor;
describe patients;




ALTER TABLE patients DROP FOREIGN KEY fk_hospital;




