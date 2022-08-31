-- create a table 
CREATE TABLE EmployeeDemographics (
    EmployeeID int,
    FirstName varchar(50),
    LastName varchar(50),
    Age int,
    Gender varchar(50)
);

CREATE TABLE EmployeeSalary (
    EmployeeID int,
    JobTitle varchar(50),
    Salary int
);

-- insert data
INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male');

SELECT *
FROM EmployeeDemographics;

INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

SELECT *
FROM EmployeeSalary

-- distinct
SELECT DISTINCT(Gender)
FROM EmployeeDemographics

SELECT DISTINCT(Gender)
FROM EmployeeDemographics

-- count
SELECT COUNT(LastName) AS LastNameCount
FROM EmployeeDemographics

-- min
SELECT MIN(Salary)
FROM EmployeeSalary

-- max
SELECT MAX(Salary)
FROM EmployeeSalary

-- avg
SELECT AVG(Salary)
FROM EmployeeSalary

-- where
SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'JIM'

SELECT *
FROM EmployeeDemographics
WHERE Age >= 30

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 AND Gender = 'Male'

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 OR Gender = 'Male'

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%' -- 's' as first letter in lastname

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE '%S%' -- 's' anywhere in the lastname

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%ott%' 

SELECT *
FROM EmployeeDemographics
WHERE FirstName IS NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName IS NOT NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Micheal')

-- group by, order by
SELECT Gender, COUNT(Gender) 
FROM EmployeeDemographics
GROUP BY Gender

SELECT Gender, Age, COUNT(Gender) -- derived OR fictional column
FROM EmployeeDemographics
GROUP BY Gender, Age -- distinct values

SELECT Gender, COUNT(Gender) 
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender

SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY CountGender DESC

SELECT *
FROM EmployeeDemographics
ORDER BY Age, Gender 

SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC, Gender DESC








