## Patient Health Record and Analytics System
Project Overview

This project implements a comprehensive Patient Health Record and Analytics System using MySQL and SQLite. It manages patient demographics, medical history, appointments, lab results, Doctor information and health analytics in a well-structured relational database.

The system demonstrates how healthcare data can be managed across multiple entities, providing a real-world learning experience in SQL CRUD operations, joins, and constraints. It also includes the ability to generate analytics for healthcare trends and patient insights.

## Key Features

- Patient Demographic Information: Stores patient personal details such as name, age, gender, and contact information.

- Medical History Management: Tracks diseases, treatments, surgeries, and diagnoses associated with each patient.

- Appointment Tracking: Allows patients to schedule and view appointments with doctors.

- Lab Results: Stores lab test results for patients and provides easy access for healthcare providers.

- Health Analytics: Provides health trend analysis, such as the most common diseases or conditions among patients.

- Foreign Key Relationships: Ensures data integrity by linking related tables (patients, doctors, appointments, etc.).

## Database Tables

The system consists of six relational tables:

- Patients-> Personal details of patients.

- Medical_History-> Diseases, conditions, surgeries, and treatment details.

- Doctors-> Doctor details, including specialties.

- Appointments-> Appointment tracking with date, time, and doctor-patient relationship.

- Lab_Results-> Lab test results linked to patients.

- Analytics-> Health trend analytics like common diseases, patient demographics, etc.

### Setup & Installation
Prerequisites

Ensure these installed:

Python 3.7 or higher

Jupyter Notebook or VS Code with notebook support

MySQL or SQLite (SQLite is used for local development)

pip (Python package manager)

Install Dependencies

To install the required dependencies, you can use the requirements.txt file. It includes the necessary Python packages to run the project.

Run the following command to install dependencies:

pip install -r requirements.txt


This will install all the required Python packages, including libraries for interacting with MySQL, performing data analysis, and generating analytics.


### Database Schema

The Patient Health Record and Analytics System database includes the following tables:

- Patients

patient_id: Unique identifier for each patient (Primary Key).

first_name: Patient's first name.

last_name: Patient's last name.

DOB: Date of birth.

gender: Gender of the patient.

contact_number: Patient's contact number.

email: Patient's email address.

- Doctors

doctor_id: Unique identifier for each doctor (Primary Key).

first_name: Doctor's first name.

last_name: Doctor's last name.

specialty: Doctor's medical specialty.

- Medical_History

history_id: Unique identifier for each medical history entry (Primary Key).

patient_id: Foreign key linked to the Patients table.

disease_condition: Medical condition diagnosed.

surgery_procedure: Surgery performed, if applicable.

diagnosis_date: Date of diagnosis.

treatment: Treatment prescribed.

- Appointments

appointment_id: Unique identifier for each appointment (Primary Key).

patient_id: Foreign key linked to the Patients table.

doctor_id: Foreign key linked to the Doctors table.

appointment_date: Date of the appointment.

appointment_time: Time of the appointment.

notes: Notes about the appointment.

- Lab_Results

lab_result_id: Unique identifier for each lab result (Primary Key).

patient_id: Foreign key linked to the Patients table.

test_name: Name of the lab test.

test_date: Date when the test was performed.

result: Result of the lab test.

- Analytics

analytics_id: Unique identifier for each analytics entry (Primary Key).

disease_condition: Disease or condition being tracked.

patient_count: Number of patients with the given condition.

average_age: Average age of patients with the condition.

analysis_date: Date when the analysis was performed.

### Conclusion

The Patient Health Record and Analytics System provides a comprehensive way to manage patient health data, appointments, medical history, and lab results. By using relational database principles like foreign keys and joins, the system ensures data integrity and allows healthcare providers to gain insights through analytics. This project is a great way to practice SQL and database management for real-world applications in healthcare