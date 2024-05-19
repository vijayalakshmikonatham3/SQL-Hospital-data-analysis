create  database Hospital
Use Hospital
----Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
-- Create Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Address VARCHAR(255),
    DateOfBirth DATE,
    Insurance VARCHAR(100),
    Email VARCHAR(100),
    TelephoneNumber VARCHAR(20),
    Username VARCHAR(50),
    Password VARCHAR(50),
    DateLeft DATE
);
-- Create Doctors Table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    FullName VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
-- Create MedicalRecords Table
CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Diagnosis VARCHAR(255),
    Medicine VARCHAR(100),
    MedicinePrescribedDate DATE,
    Allergies VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    DepartmentID INT,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Insert data into Departments table
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'Cardiology'),
       (2, 'Neurology'),
       (3, 'Pediatrics'),
	   (4, 'Orthopedics'),
       (5, 'Oncology'),
	   (6, 'General Practice'),
	   (7, 'Oncology');
select * from Departments 

-- Insert data into Patients table
INSERT INTO Patients (PatientID, FullName, Address, DateOfBirth, Insurance, Email, TelephoneNumber, Username, Password)
VALUES (1, 'John Doe', '123 Main St', '1990-05-15', 'ABC Insurance', 'john.doe@example.com', '123-456-7890', 'johndoe', 'password123'),
       (2, 'Jane Smith', '456 Oak St', '1985-10-20', 'XYZ Insurance', NULL, NULL, 'janesmith', 'p@ssw0rd'),
       (3, 'Michael Johnson', '789 Elm St', '1978-08-03', 'DEF Insurance', 'mike@example.com', NULL, 'michaelj', 'securepass'),
	   (4, 'Emily Johnson', '456 Maple St', '1982-09-28', 'GHI Insurance', 'emily@example.com', '456-789-0123', 'emilyj', 'pass123'),
       (5, 'David Brown', '789 Pine St', '1975-03-10', 'JKL Insurance', 'david@example.com', NULL, 'davidb', 'secure123'),
       (6, 'Sophia Wilson', '101 Cherry St', '1995-11-12', 'MNO Insurance', 'sophia@example.com', '789-012-3456', 'sophiaw', 'p@ssw0rd'),
       (7, 'Ethan Miller', '121 Elm St', '1989-07-18', 'PQR Insurance', NULL, '901-234-5678', 'ethanm', 'password456');
select * from Patients


-- Insert data into Doctors table
INSERT INTO Doctors (DoctorID, FullName, DepartmentID)
VALUES (1, 'Dr. Smith', 1),
       (2, 'Dr. Lee', 2),
       (3, 'Dr. Patel', 3),
	   (4, 'Dr. Johnson', 4),
       (5, 'Dr. Brown', 5),
       (6, 'Dr. Wilson', 4),
       (7, 'Dr. Miller', 5);
select * from Doctors

-- Insert data into Appointments table
INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, DepartmentID, Status)
VALUES (1, 1, 1, '2024-04-03', '09:00', 1, 'Pending'),
       (2, 2, 2, '2024-04-05', '10:30', 2, 'Completed'),
       (3, 3, 3, '2024-04-07', '11:15', 3, 'Cancelled'),
	   (4, 4, 4, '2024-04-10', '08:45', 4, 'Pending'),
       (5, 5, 5, '2024-04-12', '13:00', 5, 'Pending'),
       (6, 6, 6, '2024-04-15', '10:00', 4, 'Completed'),
       (7, 7, 7, '2024-04-18', '11:30', 5, 'Pending');
select * from Appointments

-- Insert data into Medical Records table
INSERT INTO MedicalRecords (RecordID, PatientID, DoctorID, Diagnosis, Medicine, MedicinePrescribedDate, Allergies)
VALUES
    (1, 1, 1, 'Common cold', 'Paracetamol', '2024-03-15', 'None'),
    (2, 2, 2, 'Headache', 'Ibuprofen', '2024-03-20', 'None'),
    (3, 3, 3, 'Influenza', 'Tamiflu', '2024-03-25', 'None'),
    (4, 4, 4, 'Fractured arm', 'Cast', '2024-03-30', 'None'),
    (5, 5, 5, 'Hypertension', 'Lisinopril', '2024-04-05', 'None'),
    (6, 6, 6, 'Type 2 Diabetes', 'Metformin', '2024-04-10', 'None'),
    (7, 7, 7, 'Allergic rhinitis', 'Antihistamines', '2024-04-15', 'Pollen');
select * from MedicalRecords

------Add the constraint to check that the appointment date is not in the past.----
ALTER TABLE Appointments
ADD CONSTRAINT CHK_AppointmentDate CHECK (AppointmentDate >= CAST(GETDATE() AS DATE));

------List all the patients with older than 40 and have Cancer in diagnosis.-----
SELECT P.PatientID, P.FullName, P.DateOfBirth, MR.Diagnosis
FROM Patients P
JOIN MedicalRecords MR ON P.PatientID = MR.PatientID
WHERE P.DateOfBirth < DATEADD(YEAR, -40, GETDATE())         -- Older than 40
AND MR.Diagnosis = 'Cancer';


-------The hospital also requires stored procedures or user-defined functions to do the following things:
------a)Search the database of the hospital for matching character strings by name of medicine. Results should be sorted with most recent medicine prescribed date first.
CREATE PROCEDURE SearchMedicineByName
    @MedicineName VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT MR.PatientID, P.FullName AS PatientFullName, MR.Diagnosis, MR.Medicine, MR.MedicinePrescribedDate
    FROM MedicalRecords MR
    JOIN Patients P ON MR.PatientID = P.PatientID
    WHERE MR.Medicine LIKE '%' + @MedicineName + '%'
    ORDER BY MR.MedicinePrescribedDate DESC;
END;

EXEC SearchMedicineByName @MedicineName = 'Paracetamol';


-------Return a full list of diagnosis and allergies for a specific patient who has an appointment today (i.e., the system date when the query is run)
CREATE PROCEDURE GetDiagnosisAndAllergiesForPatient
    @PatientID INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Today DATE = CAST(GETDATE() AS DATE);

    SELECT MR.Diagnosis, MR.Allergies
    FROM MedicalRecords MR
    JOIN Appointments A ON MR.PatientID = A.PatientID
    WHERE MR.PatientID = @PatientID
    AND A.AppointmentDate = @Today;
END;
EXEC GetDiagnosisAndAllergiesForPatient @PatientID = 7;

-------Update the details for an existing doctor:
CREATE PROCEDURE UpdateDoctorDetails
    @DoctorID INT,
    @NewFullName VARCHAR(100),
    @NewDepartmentID INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Doctors
    SET FullName = @NewFullName,
        DepartmentID = @NewDepartmentID
    WHERE DoctorID = @DoctorID;
END;
EXEC UpdateDoctorDetails 
    @DoctorID = 1, 
    @NewFullName = 'AndrewJohnsons', 
    @NewDepartmentID = 4; 


----d)Delete the appointment who status is already completed.
CREATE PROCEDURE DeleteCompletedAppointments
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Appointments
    WHERE Status = 'Completed';
END;
EXEC DeleteCompletedAppointments;
----The hospitals wants to view the appointment date and time, showing all previous and current appointments for all doctors, and including details of the department (the doctor is associated with), doctor’s specialty and any associate review/feedback given for a doctor. You should create a view containing all the required information.
CREATE VIEW DoctorAppointmentsView
AS
SELECT A.AppointmentID,
       A.AppointmentDate,
       A.AppointmentTime,
       D.FullName AS DoctorFullName,
       D.DepartmentID,
       DP.DepartmentName
FROM Appointments A
JOIN Doctors D ON A.DoctorID = D.DoctorID
JOIN Departments DP ON D.DepartmentID = DP.DepartmentID;
SELECT * FROM DoctorAppointmentsView;

-------Create a trigger so that the current state of an appointment can be changed to available when it is cancelled.
CREATE TRIGGER trg_CancelledAppointment
ON Appointments
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Status)  
    BEGIN
        UPDATE Appointments
        SET Status = 'Available'
        WHERE Status = 'Cancelled';
    END
END;
------Write a select query which allows the hospital to identify the number of completed appointments with the specialty of doctors as ‘Gastroenterologists
SELECT COUNT(*) AS CompletedAppointments
FROM Appointments A
JOIN Doctors D ON A.DoctorID = D.DoctorID
JOIN Departments DP ON D.DepartmentID = DP.DepartmentID
WHERE A.Status = 'Completed'
AND DP.DepartmentName = 'Gastroenterologist';

 