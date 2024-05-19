# SQL-Hospital-data-analysis
This repo is for hospital patient data analysis done in sql

Advanced Databases: Database Design & SQL for Data Analysis
Project Overview
This project involves designing and normalizing a relational database system using Microsoft SQL Server Management Studio. The database manages information related to patients, doctors, medical records, appointments, and departments in a healthcare setting. The design follows principles of normalization up to the third normal form (3NF) to ensure efficient data storage and integrity.

Table of Contents
1. Introduction
2. Part 1: Database Design and Normalization
      a) Database Design Process
      b) Creating Databases/Tables
      c)Inserting Values
      d)Explanation of Designing and Normalizing Database into 3NF
      e)ER Diagram
- Part 2: SQL Queries and Procedures
      a) Constraint Query
      b)Conditional Query
      c) Stored Procedure/UDF
      d)Join Query
      e)Update Query
      f) Delete Query
      g) Creating Views
      h) Create Trigger
      i) Conditional Join Query
      j) Database Management
         - Data Integrity and Concurrency
         - Database Security
         - Database Backup and Recovery
Introduction
In response to the given scenario, I have designed and normalized a relational database system aimed at managing information related to patients, doctors, medical records, appointments, and departments in a healthcare setting. The design process followed principles of normalization up to the third normal form (3NF) to ensure efficient data storage and integrity.

Part 1: Database Design and Normalization
Database Design Process
- Understanding the Requirements: Identified entities like Patients, Doctors, Medical Records, Appointments, and Departments. Established relationships among these entities and considered constraints such as primary keys, foreign keys, data types, and integrity constraints.
- Entity-Relationship Diagram (ERD): Created an ERD to visualize the relationships between entities and their attributes. Ensured each entity had a primary key and utilized foreign keys to establish relationships.
- Normalization: Ensured the database design adhered to the principles of normalization to minimize redundancy and improve data integrity, aiming for 3NF to eliminate transitive dependencies and achieve a well-structured schema.
Creating Databases/Tables
- Departments Table: Stores information about hospital departments.
- Patients Table: Stores patient details.
- Doctors Table: Stores doctor details.
- MedicalRecords Table: Stores medical records associated with patients and doctors.
- Appointments Table: Stores appointment details, including patient and doctor IDs.
Inserting Values
Populated the tables with sample data to facilitate database operations and testing.

Explanation of Designing and Normalizing Database into 3NF
- Patients Table: Contains columns such as PatientID, FirstName, LastName, DateOfBirth, etc.
- Doctors Table: Includes DoctorID, FirstName, LastName, Specialization, DepartmentID, etc.
- Departments Table: Features DepartmentID, DepartmentName, DepartmentHead, etc.
- Appointments Table: Encompasses AppointmentID, PatientID, DoctorID, AppointmentDate, etc.
- MedicalRecords Table: Comprises RecordID, PatientID, DoctorID, DateOfVisit, Diagnosis, etc.
ER Diagram
Visual representation of the relationships between tables, showcasing primary and foreign key constraints.

Part 2: SQL Queries and Procedures
- Constraint Query
Added constraints to ensure the integrity of the data, such as checking that the appointment date is not in the past.

- Conditional Query
Listed patients older than 40 with a diagnosis of cancer by joining the Patients and MedicalRecords tables.

- Stored Procedure/UDF
Created stored procedures and user-defined functions for various operations, such as searching for prescribed medicines by name and returning results sorted by the most recent prescription date.

- Join Query
Returned a full list of diagnosis and allergies for a specific patient with an appointment today.

- Update Query
Updated details for an existing doctor, such as their full name and department.

- Delete Query
Deleted appointments with a status of 'Completed' to maintain data integrity and optimize storage.

- Creating Views
Created a view to show appointment details, including department and doctor information, along with any associated reviews or feedback.

- Create Trigger
Implemented a trigger to automatically update the appointment status to 'Available' when it is canceled.

- Conditional Join Query
Identified the number of completed appointments with doctors specializing in Gastroenterology.

Database Management
Data Integrity and Concurrency
- Normalization and Entity Design: Ensured the database is normalized to at least 3NF to avoid redundancy and maintain data integrity.
- Concurrency Handling: Implemented transaction management and SQL Server’s locking mechanisms to manage concurrent access.
Database Security
- Authentication and Authorization: Implemented role-based access control (RBAC) and encrypted sensitive data.
- SQL Injection Prevention: Used parameterized queries and stored procedures to prevent SQL injection attacks.
Database Backup and Recovery
- Backup Strategy: Established a comprehensive backup strategy including full, differential, and transaction log backups.
- Recovery Planning: Developed a disaster recovery plan and tested recovery processes regularly to ensure quick restoration in case of data loss or corruption.
