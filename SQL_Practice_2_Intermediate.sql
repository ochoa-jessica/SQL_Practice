SELECT *
FROM EmployeeDemographics;

SELECT *
FROM EmployeeSalary;

INSERT INTO EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

CREATE TABLE WareHouseEmployeeDemographics 
(
    EmployeeID int, 
    FirstName varchar(50), 
    LastName varchar(50), 
    Age int, 
    Gender varchar(50)
)

INSERT INTO WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

-- inner join
SELECT *
FROM EmployeeDemographics 
INNER JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, 
    FirstName, 
    LastName, 
    Jobtitle,
    Salary
FROM EmployeeDemographics 
INNER JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT JobTitle,
    AVG(Salary)
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

-- outer join
SELECT *
FROM EmployeeDemographics 
LEFT OUTER JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM EmployeeDemographics 
RIGHT OUTER JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, 
    FirstName,
    LastName,
    Salary
FROM EmployeeDemographics
FULL OUTER JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Micheal'
ORDER BY Salary DESC

-- Unions
SELECT *
FROM EmployeeDemographics 
FULL OUTER JOIN WareHouseEmployeeDemographics
    ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID

SELECT *
FROM EmployeeDemographics 
UNION  -- avoids duplicates
SELECT *
FROM WareHouseEmployeeDemographics

SELECT *
FROM EmployeeDemographics 
UNION ALL
SELECT *
FROM WareHouseEmployeeDemographics
ORDER BY EmployeeID

SELECT EmployeeID, FirstName, Age
FROM EmployeeDemographics 
UNION
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
ORDER BY EmployeeID

-- case 
SELECT FirstName, LastName, Age
CASE 
    WHEN Age > 30 THEN 'old'
    WHEN Age BETWEEN 27 AND 30 THEN 'young'
    ELSE 'baby'
END
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age

SELECT FirstName, LastName, JobTitle, Salary
CASE
    WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
    WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
    WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
    ELSE Salary + (Salary * .03)
END
FROM EmployeeDemographics
JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT FirstName, LastName, JobTitle, Salary
CASE
    WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
    WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
    WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
    ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- having clause
SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics
JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle

SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics
JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1

SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
ORDER BY AVG(Salary)

SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)

-- update, delete table row
SELECT *
FROM EmployeeDemographics

UPDATE EmployeeDemographics
SET EmployeeID = 1012, Age = 31, Gender = 'Female'
WHERE FirstName = 'Holy' AND LastName = 'Flax'

SELECT *
FROM EmployeeDemographics
WHERE EmployeeID = 1012

DELETE 
FROM EmployeeDemographics
WHERE EmployeeID = 1012

-- aliasing
SELECT *
FROM EmployeeDemographics

SELECT FirstName AS FName
FROM EmployeeDemographics

SELECT FirstName + ' ' + LastName AS FullName
FROM EmployeeDemographics

SELECT AVG(Age) AS AvgAge
FROM EmployeeDemographics

SELECT Demo.EmployeeID, Sal.Salary
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
    ON Demo.EmployeeID = Sal.EmployeeID

SELECT Demo.EmployeeID,
 Demo.FirstName,
 Demo.LastName,
 Sal.JobTitle,
 Ware.Age,
FROM EmployeeDemographics AS Demo
LEFT JOIN EmployeeSalary AS Sal
    ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN WareHouseEmployeeDemographics AS Ware
    ON Demo.EmployeeID = Ware.EmployeeID

-- partition 
SELECT FirstName, 
LastName, 
Gender, 
Salary, 
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
    ON Demo.EmployeeID = Sal.EmployeeID

SELECT Gender,  COUNT(Gender) AS TotalGender
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
    ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY Gender