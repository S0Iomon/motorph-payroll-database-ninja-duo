SELECT employee_id, first_name, last_name
FROM employee
WHERE employee_id IN (10029,10030,10031);

SELECT emp_credential_id, employee_id, username
FROM employee_credentials
WHERE employee_id IN (10029,10030,10031);

DELETE FROM employee_role
WHERE emp_credential_id IN (29,30,31);

DELETE FROM employee_credentials
WHERE employee_id IN (10029,10030,10031);

DELETE FROM employee
WHERE employee_id IN (10029,10030,10031);

SELECT employee_id, first_name, last_name
FROM employee
WHERE employee_id IN (10029,10030,10031);

SELECT emp_credential_id, employee_id, username
FROM employee_credentials
WHERE employee_id IN (10029,10030,10031);