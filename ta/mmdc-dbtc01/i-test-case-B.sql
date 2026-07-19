-- THIS IS THE INITIAL EMPLOYEE INFO BEFORE MODIFYING THE DATA
SELECT
    e.employee_number AS 'Employee Number',
    e.last_name AS 'Last Name',
    e.first_name AS 'First Name',
    DATE_FORMAT(e.birthdate, '%M %d, %Y') AS 'Birth Date',

    CONCAT_WS(', ',
        a.building,
        a.street,
        a.barangay,
        a.city,
        a.province,
        a.zip_code
    ) AS 'Address',

    e.phone_number AS 'Phone Number',

    p.position_name AS 'Position',
    es.status_name AS 'Status',

    CONCAT(s.first_name, ' ', s.last_name) AS 'Supervisor',

    CONCAT('₱ ', REPLACE(FORMAT(e.basic_salary, 2), ',', ' ')) AS 'Monthly Salary',
    CONCAT('₱ ', REPLACE(FORMAT(e.semi_monthly_rate, 2), ',', ' ')) AS 'Semi-Monthly Rate',
    CONCAT('₱ ', REPLACE(FORMAT(e.hourly_rate, 2), ',', ' ')) AS 'Hourly Rate',

    CONCAT('₱ ', REPLACE(FORMAT(e.clothing_allowance, 2), ',', ' ')) AS 'Clothing Allowance',
    CONCAT('₱ ', REPLACE(FORMAT(e.rice_allowance, 2), ',', ' ')) AS 'Rice Allowance',
    CONCAT('₱ ', REPLACE(FORMAT(e.phone_allowance, 2), ',', ' ')) AS 'Phone Allowance',

    g.tin_number AS 'TIN',
    g.sss_number AS 'SSS',
    g.philhealth_number AS 'PhilHealth',
    g.pag_ibig_number AS 'Pag-IBIG'

FROM employee e

LEFT JOIN employee s
    ON e.supervisor_id = s.employee_id

JOIN position p
    ON e.position_id = p.position_id

JOIN employee_status es
    ON e.employee_status_id = es.status_id

JOIN address a
    ON e.address_id = a.address_id

JOIN government_info g
    ON e.government_info_id = g.government_info_id
WHERE e.employee_number IN (10032,10033,10034,10037)
ORDER BY e.employee_number;

-- TEST CASE B REQUIREMENTS
-- UPDATE FOR CARLOS
UPDATE employee
SET
    basic_salary = 23000.00,
    semi_monthly_rate = 11500.00,
    hourly_rate = 136.90
WHERE employee_number = 10033;

-- UPDATE FOR BEATRIZ
UPDATE employee
SET
    basic_salary = 25000.00,
    semi_monthly_rate = 12500.00,
    hourly_rate = 148.81
WHERE employee_number = 10034;

-- UPDATE FOR JOHN RAFAEL
UPDATE employee
SET
    basic_salary = 23000.00,
    semi_monthly_rate = 11500.00,
    hourly_rate = 136.90
WHERE employee_number = 10032;

-- UPDATE FOR SHELLA MAE
UPDATE employee
SET
    basic_salary = 25000.00,
    semi_monthly_rate = 12500.00,
    hourly_rate = 148.81
WHERE employee_number = 10037;
