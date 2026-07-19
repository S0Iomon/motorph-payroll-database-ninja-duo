-- FIRST VERIFY THAT THE EMPLOYEES EXIST BEFORE DELETION
SELECT
    IFNULL(e.employee_id, 0) AS 'Employee ID',
    IFNULL(CONCAT(e.first_name, ' ', e.last_name), 'NULL') AS 'Employee Name',
    IFNULL(ec.emp_credential_id, 0) AS 'Credential ID',
    IFNULL(ec.username, 'NULL') AS 'Username',
    IFNULL(era.emp_credential_id_role_id, 0) AS 'Role Assignment ID',
    IFNULL(er.role_name, 'NULL') AS 'Role'
FROM employee e
LEFT JOIN employee_credentials ec
    ON e.employee_id = ec.employee_id
LEFT JOIN employee_role_assignment era
    ON ec.emp_credential_id = era.emp_credential_id
LEFT JOIN employee_role er
    ON era.role_id = er.role_id
WHERE e.employee_id IN (10029,10030,10031);

-- DELETE ROLE ASSIGNMENTS FIRST
DELETE FROM employee_role_assignment
WHERE emp_credential_id IN (29,30,31);

-- DELETE EMPLOYEE CREDENTIALS
DELETE FROM employee_credentials
WHERE employee_id IN (10029,10030,10031);

-- DELETE EMPLOYEE RECORDS
DELETE FROM employee
WHERE employee_id IN (10029,10030,10031);

-- VERIFY DELETION
SELECT
    ids.employee_id AS 'Employee ID',
    IFNULL(CONCAT(e.first_name, ' ', e.last_name), 'NULL') AS 'Employee Name',
    IFNULL(ec.emp_credential_id, 0) AS 'Credential ID',
    IFNULL(ec.username, 'NULL') AS 'Username',
    IFNULL(era.emp_credential_id_role_id, 0) AS 'Role Assignment ID',
    IFNULL(er.role_name, 'NULL') AS 'Role'
FROM (
    SELECT 10029 AS employee_id
    UNION ALL
    SELECT 10030
    UNION ALL
    SELECT 10031
) ids
LEFT JOIN employee e
    ON ids.employee_id = e.employee_id
LEFT JOIN employee_credentials ec
    ON e.employee_id = ec.employee_id
LEFT JOIN employee_role_assignment era
    ON ec.emp_credential_id = era.emp_credential_id
LEFT JOIN employee_role er
    ON era.role_id = er.role_id;
    
    -- JUST IN CASE
    
SELECT employee_id, first_name, last_name
FROM employee
WHERE employee_id IN (10029,10030,10031);

SELECT *
FROM employee_role_assignment
WHERE emp_credential_id IN (
    SELECT emp_credential_id
    FROM employee_credentials
    WHERE employee_id IN (10029,10030,10031)
);