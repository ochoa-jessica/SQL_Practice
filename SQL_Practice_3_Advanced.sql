-- CTE(Common Table Expression)
WITH CTE_Employee AS (
    SELECT FirstName, LastName, Gender, Salary,
    COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
    AVG(Salary) OVER (PARTITION BY Salary) AS AvgSalary
    FROM EmployeeDemographics AS Demo
    JOIN EmployeeSalary Sal
        ON Demo.EmployeeID = Sal.EmployeeID
    WHERE Salary > '45000'
)
SELECT *
FROM CTE_Employee

WITH CTE_Employee AS (
    SELECT FirstName, LastName, Gender, Salary,
    COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
    AVG(Salary) OVER (PARTITION BY Salary) AS AvgSalary
    FROM EmployeeDemographics AS Demo
    JOIN EmployeeSalary Sal
        ON Demo.EmployeeID = Sal.EmployeeID
    WHERE Salary > '45000'
)
SELECT FirstName, AvgSalary
FROM CTE_Employee

-- Temp Tables
CREATE TABLE #temp_Employee (
    EmployeeID int,
    JobTitle varchar(100),
    Salary int
)

INSERT INTO #temp_Employee VALUES
('1001', 'HR', '45000')

INSERT INTO #temp_Employee
SELECT *
FROM EmployeeSalary

SELECT *
FROM #temp_Employee

DROP TABLE IF EXISTS #temp_Employee2
CREATE TABLE #temp_Employee2 (
    JobTitle varchar(50),
    EmployeesPerJob int,
    AvgAge int,
    AvgSalary int
)

INSERT INTO #temp_Employee2
SELECT JobTitle, 
    COUNT(JobTitle), 
    AVG(Age), 
    AVG(Salary)
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary Sal
    ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_Employee2

-- string funcs
CREATE TABLE EmployeeErrors (
    EmployeeID varchar(50),
    FirstName varchar(50),
    LastName varchar(50)
)

INSERT INTO EmployeeErrors VALUES
('1001 ', 'Jimbo', 'Halbert'),
('  1002', 'Pamela', 'Beasely'),
('1005', 'TOby', 'Flenderson - Fired')

SELECT *
FROM EmployeeErrors

-- TRIM, LTRIM, RTRIM
SELECT EmployeeID, TRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

-- replace
SELECT LastName, REPLACE(LastName, '- Fired', '') AS LastNameFixed
FROM EmployeeErrors

-- substring
SELECT SUBSTRING(FirstName, 1, 3)
FROM EmployeeErrors

SELECT Err.FirstName, Demo.FirstName
FROM EmployeeErrors AS Err
JOIN EmployeeDemographics AS Demo
    ON Err.FirstName = Demo.FirstName

SELECT Err.FirstName, SUBSTRING(Err.FirstName, 1, 3), Demo.FirstName, SUBSTRING(Demo.FirstName, 1, 3)
FROM EmployeeErrors AS Err
JOIN EmployeeDemographics AS Demo
    ON SUBSTRING(Err.FirstName, 1, 3) = SUBSTRING(Demo.FirstName, 1, 3)

-- upper, lower
SELECT UPPER(FirstName)
FROM EmployeeErrors

SELECT LOWER(FirstName)
FROM EmployeeErrors

-- stored procedures 
CREATE PROCEDURE TEST
AS 
SELECT *
FROM EmployeeDemographics

EXEC TEST

CREATE PROCEDURE Temp
AS
CREATE TABLE #temp_Employee2 (
    JobTitle varchar(50),
    EmployeesPerJob int,
    AvgAge int,
    AvgSalary int
)

INSERT INTO #temp_Employee2
SELECT JobTitle, 
    COUNT(JobTitle), 
    AVG(Age), 
    AVG(Salary)
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary Sal
    ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_Employee2

EXEC temp

-- subqueries
SELECT 
    EmployeeID, 
    Salary, 
    (
        SELECT AVG(Salary) AS AllAvgSalary
        FROM EmployeeSalary
    )
FROM EmployeeSalary

SELECT a.EmployeeID, AllAvgSalary
FROM (
    SELECT 
        EmployeeID, 
        Salary, 
        AVG(Salary) OVER () AS AllAvgSalary
    FROM EmployeeSalary) a

SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary 
WHERE EmployeeID IN (
    SELECT EmployeeID
    FROM EmployeeDemographics
    WHERE Age > 30
)

-- partition, gorup by won't work
SELECT 
    EmployeeID, 
    Salary, 
    AVG(Salary) OVER () AS AllAvgSalary
FROM EmployeeSalary

SELECT 
    EmployeeID, 
    Salary, 
    AVG(Salary) AS AllAvgSalary
FROM EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY EmployeeID, Salary