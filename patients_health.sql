

CREATE TABLE Patients (
    patient_id INT Primary Key,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    DOB DATE,
    gender VARCHAR(10),
    contact_number VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,  
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    specialty VARCHAR(100)
);


CREATE TABLE Medical_History (
    history_id INT PRIMARY KEY,  
    patient_id INT,                           
    disease_condition VARCHAR(255),
    surgery_procedure VARCHAR(255),
    diagnosis_date DATE,
    treatment VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) 
);

CREATE TABLE Appointments (
    patient_id INT,                                  
    doctor_id INT,                                  
    appointment_date DATE,
    appointment_time TIME,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),  
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)     
);


CREATE TABLE Lab_Results (
    lab_result_id INT  PRIMARY KEY,  
    patient_id INT,                              
    test_name VARCHAR(255),
    test_date DATE,
    result VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) 
);


CREATE TABLE Analytics (
    analytics_id INT PRIMARY KEY Auto_increment,  
    disease_condition VARCHAR(255),
    patient_count INT,
    average_age INT,
    analysis_date DATE
);



INSERT INTO Patients (patient_id,first_name, last_name, DOB, gender, contact_number, email)
VALUES (1,'John', 'Rimal', '1980-05-15', 'Male', '947856214', 'john@gmail.com'),
        (2,'Ram', 'Shrestha', '1990-08-22', 'Male', '945612378', 'ram@gmail.com'),
        (3,'Sita', 'Khanal', '1985-12-05', 'Female', '948563214', 'sita@gmail.com'),
        (4,'Gita', 'Thapa', '1992-03-18', 'Female', '947123856', 'gita@gmail,com'),
        (5,'Maya', 'Sharma', '1988-11-30', 'Female', '946215378', 'maya@gmail.com'),
        (6,'Hari', 'Adhikari', '1975-07-09', 'male', '945678123', 'hari@gmail.com');


INSERT INTO Doctors (doctor_id, first_name, last_name, specialty)
VALUES (1,'Dr. Anil', 'Shrestha', 'Cardiology'),    
        (2,'Dr. Suman', 'Koirala', 'Neurology'),
        (3,'Dr. Rina', 'Gurung', 'Pediatrics'),
        (4,'Dr. Bikash', 'Thapa', 'Orthopedics'),
        (5,'Dr. Sunita', 'Rai', 'Dermatology');
        
        
INSERT INTO Medical_History (history_id,patient_id, disease_condition, surgery_procedure, diagnosis_date, treatment)
VALUES (101,1, 'Hypertension', 'None', '2020-01-15', 'Medication A'),
       (102,2, 'Diabetes', 'None', '2019-03-22', 'Medication B'),
       (103,3, 'Asthma', 'None', '2021-07-10', 'Inhaler C'),
       (104,4, 'Fracture', 'Bone Surgery', '2022-05-18', 'Physical Therapy'),
       (105,5, 'Eczema', 'None', '2020-11-30', 'Topical Cream D');
       
       
INSERT INTO Appointments (patient_id,doctor_id, appointment_date, appointment_time, notes)
VALUES (1, 1, '2023-09-15', '10:00:00', 'Routine check-up'),
       (2, 2, '2023-09-16', '11:30:00', 'Follow-up on diabetes management'),
       (3, 3, '2023-09-17', '09:00:00', 'Asthma symptoms evaluation'),
       (4, 4,'2023-09-18', '14:00:00', 'Post-surgery consultation'),
       (5,5 ,'2023-09-19', '13:15:00', 'Skin rash assessment');        
       

INSERT INTO Lab_Results (lab_result_id,patient_id, test_name, test_date, result)
VALUES (1001,1, 'Blood Pressure Test', '2023-09-15', '130    /85 mmHg'),
       (1002,2, 'Blood Sugar Test', '2023-09-16', '150 mg/dL'),
       (1003,3, 'Lung Function Test', '2023-09-17', 'Normal'),
       (1004,4, 'X-Ray', '2023-09-18', 'Healing well'),
       (1005,5, 'Skin Biopsy', '2023-09-19', 'Benign');      
       
INSERT INTO Analytics ( analytics_id ,disease_condition, patient_count, average_age, analysis_date)
VALUES (1,'Hypertension', 150, 55, '2023-09-01'),         
       (2,'Diabetes', 200, 50, '2023-09-01'),         
       (3,'Asthma', 100, 30, '2023-09-01'),         
       (4,'Fracture', 80, 40, '2023-09-01'),         
       (5,'Eczema', 120, 25, '2023-09-01');
       
       select* from Analytics;
       
       select * from patients as p
       inner join appointments as a
       on p.patient_id=a.patient_id;
     
     select * from  patients as p
     left join appoinment as a
     on p.patient_id=a.patient_id;
     
     select first_name ,last_name,contact_number,disease_condition,surgery_procedure from patients as p
     inner join medical_history as m
     on p.patient_id=m.patient_id;
     
     
     select first_name,last_name,appointment_date from patients as p
     left join appointments as a
     on p.patient_id=a.patient_id;
     
     
    select p.first_name,p.last_name,surgery_procedure,diagnosis_date 
    from patients as p
    inner join medical_history as m
    on p.patient_id=m.patient_id;
       
       
       select p.first_name,p.last_name, test_name,test_date, result
       from patients as p
       inner join lab_results AS l
       on p.patient_id=l.patient_id;
        
        select p.first_name,p.last_name,d.first_name,d.last_name,d.specialty,a.appointment_date
        from patients as p
		join  appointments as a on p.patient_id=a.patient_id
        join doctors as d on d.doctor_id=a.doctor_id;
        
        select p.first_name,p.last_name,disease_condition,surgery_procedure,test_name,test_date,result
        from patients as p
        join medical_history as m on p.patient_id=m.patient_id
        join Lab_Results as l on m.patient_id=l.patient_id;
        
        select p.patient_id, p.first_name,p.last_name
        from patients as p
       inner join appointments as a on p.patient_id=a.patient_id
       left join medical_history as mh
       on p.patient_id=mh.patient_id
       where mh.patient_id is null;
       
       
       select * from doctors;
       
       select * from appointments;
       
       select 
    d.doctor_id,
    d.first_name,
    d.last_name,
    COUNT(a.patient_id) AS total_patients
FROM Doctors d
left join Appointments a 
    ON d.doctor_id = a.doctor_id
group by d.doctor_id, d.first_name, d.last_name;

select 

       
       
	

     

       
       
       


        
        
        
        
        
      






