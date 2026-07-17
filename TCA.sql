-- TEST CASE A
-- Insert Employees 10035-10037


-- Billy Lloyd Calasang (10035)

INSERT INTO address
(building, street, barangay, city, province, zip_code)
VALUES
('2nd Floor, Gaisano Mactan Mall','','Pajo','Lapu-Lapu City','Cebu',0);

SET @BillyAddressID = LAST_INSERT_ID();

INSERT INTO government_info
(sss_number, phil_health_number, tin_number, pag_ibig_number)
VALUES
(3733798411,632361534812,824311682000,374357402374);

SET @BillyGovID = LAST_INSERT_ID();

INSERT INTO employee
(
employee_id,
supervisor_id,
department_id,
pay_period_id,
benefit_type_id,
role_id,
position_id,
address_id,
government_info_id,
status_id,
first_name,
last_name,
birthdate,
hire_date,
phone_number,
basic_salary,
gross_semi_monthly,
clothing_allowance,
rice_allowance,
phone_allowance
)
VALUES
(
10035,
10006,
2,
1,
1,
3,
7,
@BillyAddressID,
@BillyGovID,
1,
'Billy Lloyd',
'Calasang',
'1996-01-22',
'2026-01-02',
'361-299-029',
42975.00,
21488.00,
800.00,
1500.00,
800.00
);

-- Jonathan Brosas (10036)

INSERT INTO address
(building, street, barangay, city, province, zip_code)
VALUES
('A Fernando 1400','','','Valenzuela','Valenzuela',0);

SET @JonathanAddressID = LAST_INSERT_ID();

INSERT INTO government_info
(sss_number, phil_health_number, tin_number, pag_ibig_number)
VALUES
(9248006029,735270773421,632531054000,632722676967);

SET @JonathanGovID = LAST_INSERT_ID();

INSERT INTO employee
(
employee_id,
supervisor_id,
department_id,
pay_period_id,
benefit_type_id,
role_id,
position_id,
address_id,
government_info_id,
status_id,
first_name,
last_name,
birthdate,
hire_date,
phone_number,
basic_salary,
gross_semi_monthly,
clothing_allowance,
rice_allowance,
phone_allowance
)
VALUES
(
10036,
10005,
4,
1,
1,
3,
22,
@JonathanAddressID,
@JonathanGovID,
21,
'Jonathan',
'Brosas',
'1994-11-26',
'2026-01-02',
'032-340-2015',
42975.00,
21487.50,
800.00,
1500.00,
800.00
);

-- Shella Mae Tejor (10037)

INSERT INTO address
(building, street, barangay, city, province, zip_code)
VALUES
('Ayala Avenue 1200','','','Makati City','Metro Manila',0);

SET @ShellaAddressID = LAST_INSERT_ID();

INSERT INTO government_info
(sss_number, phil_health_number, tin_number, pag_ibig_number)
VALUES
(3252138386,675893056701,327367815000,133337008927);

SET @ShellaGovID = LAST_INSERT_ID();

INSERT INTO employee
(
employee_id,
supervisor_id,
department_id,
pay_period_id,
benefit_type_id,
role_id,
position_id,
address_id,
government_info_id,
status_id,
first_name,
last_name,
birthdate,
hire_date,
phone_number,
basic_salary,
gross_semi_monthly,
clothing_allowance,
rice_allowance,
phone_allowance
)
VALUES
(
10037,
10004,
5,
1,
3,
3,
21,
@ShellaAddressID,
@ShellaGovID,
21,
'Shella Mae',
'Tejor',
'1994-03-01',
'2026-01-02',
'894-385-011',
52670.00,
26335.00,
1000.00,
1500.00,
1000.00
);

-- VALIDATION

SELECT
e.employee_id AS Employee_ID,
CONCAT(e.first_name,' ',e.last_name) AS Employee_Name,
e.hire_date,
CONCAT_WS(', ',
a.building,
a.street,
a.barangay,
a.city,
a.province) AS Employee_Address,
e.phone_number,
p.position_name,
s.status_name,
CONCAT(sp.first_name,' ',sp.last_name) AS Immediate_Supervisor,
e.basic_salary,
e.gross_semi_monthly,
p.hourly_rate,
e.clothing_allowance,
e.rice_allowance
FROM employee e

LEFT JOIN employee sp
ON e.supervisor_id=sp.employee_id

JOIN position p
ON e.position_id=p.position_id

JOIN status s
ON e.status_id=s.status_id

JOIN address a
ON e.address_id=a.address_id

WHERE e.employee_id IN (10035,10036,10037)

ORDER BY e.employee_id;

