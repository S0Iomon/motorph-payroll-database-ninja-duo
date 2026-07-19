INSERT INTO address (
building,
street,
barangay,
city,
province,
zip_code
)
VALUES
	-- BILLY
	('2nd Floor, Gaisano Mactan Mall', NULL, 'Pajo', 'Lapu-Lapu City', 'Cebu', NULL),
    -- 
(NULL, 'A Fernando 1400', NULL, 'Valenzuela', 'Valenzuela', NULL),
(NULL, 'Ayala Avenue', NULL, 'Makati City', 'Metro Manila', '1200');

INSERT INTO government_info (
sss_number,
philhealth_number,
tin_number,
pag_ibig_number
)
VALUES
('37-3379841-1','632361534812','824-311-682-000','374357402374'),
('92-4800602-9','735270773421','632-531-054-000','632722676967'),
('32-5213838-6','675893056701','327-367-815-000','133337008927');

INSERT INTO employee (
employee_number,
first_name,
last_name,
birthdate,
phone_number,
supervisor_id,
department_id,
position_id,
role_id,
pay_period_id,
address_id,
government_info_id,
employee_status_id,
basic_salary,
semi_monthly_rate,
hourly_rate,
rice_allowance,
phone_allowance,
clothing_allowance
)
VALUES
(10035,'Billy Lloyd','Calasang','1996-01-22','361-299-029',
10006,2,7,2,1,35,36,1,
42975.00,21488.00,255.80,
1500.00,800.00,800.00),

(10036,'Jonathan','Brosas','1994-11-26','032-340-2015',
10005,4,22,3,1,36,37,2,
42975.00,21487.50,255.80,
1500.00,800.00,800.00),

(10037,'Shella Mae','Tejor','1994-03-01','894-385-011',
10004,7,21,2,1,37,38,2,
52670.00,26335.00,313.51,
1500.00,1000.00,1000.00);

-- THIS IS THE EMPLOYEE'S DISPLAY ORDER 
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

ORDER BY e.employee_number;