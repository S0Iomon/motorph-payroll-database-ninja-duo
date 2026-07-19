use motorph_payroll;

-- DEPARTMENT--------------------------------------------------------
-- DROP TABLE IF EXISTS department;
CREATE TABLE IF NOT EXISTS department (
department_id INT AUTO_INCREMENT PRIMARY KEY,
department_name VARCHAR(50) NOT NULL
);
INSERT INTO department (department_name)
VALUES	('Executive'),
		('HR'),
		('Finance'),
        ('IT'),
        ('Sales and Marketing'),
        ('Supply Chains and Logistics'),
        ('Customer Service and Relations');
        
-- TO TEST: SELECT * FROM department;

-- POSITION--------------------------------------------
-- DROP TABLE IF EXISTS position;
CREATE TABLE IF NOT EXISTS position (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT,
    position_name VARCHAR(50) NOT NULL,
    hourly_rate DECIMAL(8, 2) NOT NULL,
    
    CONSTRAINT fk_position_department
    FOREIGN KEY (department_id)
REFERENCES department (department_id)
);
INSERT INTO position (department_id, position_name, hourly_rate)
VALUES	(1, 'Chief Executive Officer', 535.71),
		(1, 'Chief Operating Officer', 357.14),
        (3, 'Chief Finance Officer',357.14),
        (5, 'Chief Marketing Officer', 357.14),
        (4, 'IT Operations and Systems', 313.51),
        (2, 'HR Manager', 313.51),
        (2, 'HR Team Leader', 255.80),
        (2, 'HR Rank and File', 133.93),
        (3, 'Accounting Head', 313.51),
        (3, 'Payroll Manager', 302.53),
        (3, 'Payroll Team Leader', 229.02),
        (3, 'Payroll Rank and File', 142.86),
        (3, 'Account Manager', 318.45),
        (3, 'Account Team Leader', 255.80),
        (3, 'Account Rank and File (1)', 133.93),
        (3, 'Account Rank and File (2)', 138.39),
        (3, 'Account Rank and File (3)', 142.86),
        (3, 'Account Rank and File (4)', 147.32),
        (5, 'Sales & Marketing', 313.51),
        (6, 'Supply Chain and Logistics', 313.51),
        (5, 'Customer Service and Relations', 313.51),
        (4, 'IT Technical Support', 255.80);
-- TO TEST: SELECT position_id, department_id, position_name, CONCAT('₱', hourly_rate) AS hourly_rate FROM position; 

-- EMPLOYEE_ROLE --------------------------------------------------
-- DROP TABLE IF EXISTS employee_role;
CREATE TABLE IF NOT EXISTS employee_role (
role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL,
    is_admin BOOLEAN
);
INSERT INTO employee_role (role_name, is_admin)
VALUES	('Admin', TRUE),
		('Manager', TRUE),
		('Employee', FALSE);
        
-- TO TEST: SELECT * FROM employee_role;

-- PERMISSION----------------------------------------------------------------
-- DROP TABLE IF EXISTS permissions;
CREATE TABLE IF NOT EXISTS permissions (
permissions_id INT AUTO_INCREMENT PRIMARY KEY,
    access SET ('CREATE', 'READ', 'UPDATE', 'DELETE') NOT NULL,
    record_type SET ('Employee','Payroll','Attendance', 'Department', 'Position') NOT NULL
);
INSERT INTO permissions (access, record_type)
VALUES	('CREATE,READ,UPDATE,DELETE', 'Employee,Payroll,Attendance,Department,Position'),
		('READ,UPDATE', 'Employee,Payroll,Attendance,Department,Position'),
		('READ', 'Employee,Payroll,Attendance,Department,Position');
-- TO TEST: SELECT * FROM permissions;

-- LEAVE STATUS----------------------------------
-- DROP TABLE IF EXISTS leave_status;
CREATE TABLE IF NOT EXISTS leave_status (
    leave_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(10) NOT NULL
    
    CONSTRAINT chk_status_name CHECK (status_name NOT REGEXP '^-?[0-9.]+$')
);
INSERT INTO leave_status (status_name)
VALUES
('Pending'),
('Approved'),
('Rejected'),
('Cancelled');
-- TO TEST: SELECT * FROM leave_status;

-- LEAVE TYPE----------------------------------------
-- DROP TABLE IF EXISTS leave_type;
CREATE TABLE IF NOT EXISTS leave_type (
    leave_type_id INT AUTO_INCREMENT PRIMARY KEY,
    leave_name VARCHAR(50) NOT NULL
);
INSERT INTO leave_type (leave_name)
VALUES
('Vacation Leave'),
('Sick Leave'),
('Emergency Leave'),
('Maternity Leave'),
('Paternity Leave');
-- TO TEST: SELECT * FROM leave_type;

-- PAY PERIOD ---------------------------------------------------------
-- DROP TABLE IF EXISTS pay_period;
CREATE TABLE IF NOT EXISTS pay_period (
    pay_period_id INT AUTO_INCREMENT PRIMARY KEY,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    period_label VARCHAR(15)
);
INSERT INTO pay_period (period_start, period_end, period_label)
VALUES 
('2026-01-02', '2026-01-15', 'Period 1'),
('2026-01-02', '2026-01-30', 'Period 2');
-- TO TEST: SELECT * FROM pay_period;

-- BENEFIT TYPE ---------------------------------------------------
-- DROP TABLE IF EXISTS benefit_type;
CREATE TABLE IF NOT EXISTS benefit_type (
    benefit_type_id INT AUTO_INCREMENT PRIMARY KEY,
    benefit_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);
INSERT INTO benefit_type (benefit_type, amount)
VALUES
('Rice Allowance', 1500.00),
('Phone Allowance', 2000.00),
('Clothing Allowance', 1000.00);
-- TO TEST:  SELECT benefit_type_id, benefit_type, CONCAT('₱', amount) AS amount FROM benefit_type;

-- ADDRESS ------------------------------------------------------------------
-- DROP TABLE IF EXISTS address;
CREATE TABLE IF NOT EXISTS address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    building VARCHAR(255),
    street VARCHAR(50),
    barangay VARCHAR(50),
    city VARCHAR(50), 
    province VARCHAR(50), 
    zip_code INT,
    
    CONSTRAINT chk_one_address CHECK (building IS NOT NULL OR 
									  street IS NOT NULL OR
                                      barangay IS NOT NULL OR
                                      city IS NOT NULL OR
                                      province IS NOT NULL OR
                                      zip_code IS NOT NULL)
);
INSERT INTO address (building, street, barangay, city, province, zip_code)
VALUES
('Valero Carpark Building','Valero Street',NULL,'Makati City','Metro Manila',1227),
('San Antonio De Padua 2, Block 1 Lot 8 and 2', NULL, NULL,'Dasmariñas','Cavite',NULL),
('Rm. 402 4/F Jiao Building','Timog Avenue cor. Quezon Avenue',NULL,'Quezon City','Metro Manila',1100),
(NULL,'460 Solanda Street','Intramuros','Manila','Metro Manila',1000),
(NULL,'National Highway',NULL,'Gingoog','Misamis Occidental',NULL),
('17/85 Stracke Via Suite 042',NULL,'Poblacion','Las Piñas','Dinagat Islands',4783),
(NULL,'99 Strosin Hills','Poblacion','Bislig','Tawi-Tawi',5340),
('12A/33 Upton Isle Apt. 420',NULL,NULL,'Roxas City','Surigao del Norte',1814),
('90A Dibbert Terrace Apt. 190',NULL,'San Lorenzo',NULL,'Davao del Norte',6056),
(NULL,'#284 T. Morato corner Scout Rallos Street',NULL,'Quezon City','Metro Manila',NULL),
('93/54 Shanahan Alley Apt. 183',NULL,'Santo Tomas',NULL,'Masbate',1572),
('49 Springs Apt. 266',NULL,'Poblacion','Taguig','Occidental Mindoro',3200),
(NULL,'42/25 Sawayn Stream',NULL,'Ubay','Zamboanga del Norte',1208),
(NULL,'37/46 Kulas Roads',NULL,'Maragondon','Quirino',0962),
(NULL,'22A/52 Lubowitz Meadows',NULL,'Pililla','Zambales',4895),
('90 O''Keefe Spur Apt. 379',NULL,NULL,'Catigbian','Sulu',2772),
(NULL,'89A Armstrong Trace',NULL,'Compostela','Maguindanao',7874),
('Suite 406','08 Grant Drive','Poblacion','Iloilo City','La Union',9186),
(NULL,'93A/21 Berge Points',NULL,'Tapaz','Quezon',2180),
('Suite 094','65 Murphy Center','Poblacion','Palayan','Quirino',5636),
('47A/94 Larkin Plaza Apt. 179',NULL,'Poblacion','Caloocan','Quirino',2751),
(NULL,'06A Gulgowski Extensions',NULL,'Bongabon','Zamboanga del Sur',6085),
(NULL,'99A Padberg Spring','Poblacion','Mabalacat','Lanao del Sur',3959),
(NULL,'80A/48 Ledner Ridges','Poblacion','Kabankalan','Marinduque',8870),
('Suite 734','96/48 Watsica Flats','Poblacion','Malolos','Ifugao',1844),
(NULL,'58A Wilderman Walks','Poblacion','Digos','Davao del Sur',5822),
('Suite 219','60 Goyette Valley','Poblacion','Tabuk','Lanao del Sur',3159),
(NULL,'66/77 Mann Views',NULL,'Luisiana','Dinagat Islands',1263),
(NULL,'72/70 Stamm Spurs',NULL,'Bustos','Iloilo',4550),
('Suite 145','50A/83 Bahringer Oval',NULL,'Kiamba','Nueva Ecija',7688),
(NULL,'95 Cremin Junction',NULL,'Surallah','Cotabato',2809),
(NULL,'Hi-way','Yati','Liloan','Cebu',NULL),
(NULL,NULL,'Bulala','Camalaniugan',NULL,NULL),
('Agapita Building',NULL,NULL,'Metro Manila','Metro Manila',NULL),
('Unit 2802', 'One San Miguel Bldg', 'Shaw Blvd Cor San Miguel Ave', 'Ortigas Ctr', 'Pasig City', 1605),
('Unit 8435', 'West Service Road', 'Marcelo Green Village South Superhighway', NULL, 'Paranaque City', NULL);

-- TO TEST: SELECT * FROM address;

-- GOVERNMENT INFO------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS government_info;
CREATE TABLE IF NOT EXISTS government_info (
	government_info_id INT AUTO_INCREMENT PRIMARY KEY,
	sss_number CHAR(20),
	philhealth_number CHAR(20),
	tin_number CHAR(20),
	pag_ibig_number CHAR(20)
);
INSERT INTO government_info (sss_number, philhealth_number, tin_number, pag_ibig_number)
VALUES
('44-4506057-3','820126853951','442-605-657-000','6912-9533-0870'),
('52-2061274-9','331735646338','683-102-776-000','6639-0499-5411'),
('30-8870406-2','177451189665','971-711-280-000','1715-1977-3969'),
('40-2511815-0','341911411254','876-809-437-000','4169-4677-6041'),
('50-5577638-1','957436191812','031-702-374-000','9523-4722-2457'),
('49-1632020-8','382189453145','317-674-022-000','4410-9336-9646'),
('40-2400714-1','239192926939','672-474-690-000','2108-5020-9964'),
('55-4476527-2','545652640232','888-572-294-000','2113-8555-6888'),
('41-0644692-3','708988234853','604-997-793-000','2601-0773-2354'),
('64-7605054-4','578114853194','525-420-419-000','7992-5409-5212'),
('26-9647608-3','126445315651','210-805-911-000','2180-0247-3454'),
('44-8563448-3','431709011012','218-489-737-000','1130-7129-3354'),
('45-5656375-0','233693897247','210-835-851-000','6311-3028-3546'),
('27-2090996-4','515741057496','275-792-513-000','1012-0544-5886'),
('26-8768374-1','308366860059','598-065-761-000','2230-5770-7853'),
('49-2959312-6','824187961962','103-100-522-000','6310-5285-3464'),
('27-2090208-8','587272469938','482-259-498-000','7190-0760-8464'),
('45-3251383-0','745148459521','121-203-336-000','1149-0185-9343'),
('49-1629900-2','579253435499','122-244-511-000','2651-0435-8643'),
('49-1647342-5','399665157135','273-970-941-000','2600-5458-5575'),
('45-5617168-2','606386917510','354-650-951-000','1049-0770-8845'),
('52-0109570-6','357451271274','187-500-345-000','1130-1798-8667'),
('52-9883524-3','548670482885','101-558-994-000','3600-2810-4576'),
('45-5866331-6','953901539995','560-735-732-000','9131-0864-9964'),
('47-1692793-0','753800654114','841-177-857-000','2105-4666-1243'),
('40-9504657-8','797639382265','502-995-671-000','2108-9709-5686'),
('45-3298166-4','810909286264','336-676-445-000','2112-7447-6563'),
('40-2400719-4','934389652994','210-395-397-000','1222-3807-7997'),
('60-1152206-4','351830469744','395-032-717-000','2121-4189-3454'),
('54-1331005-0','465087894112','215-973-013-000','5150-1257-9765'),
('52-1859253-1','136451303068','599-312-588-000','1100-1881-3465'),
('26-7145133-4','601644902402','404-768-309-000','6977-6406-9311'),
('11-5062972-7','380685387212','256-436-296-000','9933-7296-3726'),
('20-2987501-5','918460050077','911-529-713-000','8740-4225-9378'),
('36-4160536-4','862055202862','936-540-856-000','5213-0165-2682');
-- TO TEST: SELECT * FROM government_info;

-- STATUS ------------------------------------------------------------
-- DROP TABLE IF EXISTS employee_status;
CREATE TABLE IF NOT EXISTS employee_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name ENUM (
        'Regular',
        'Probationary'
    ) NOT NULL
);
INSERT INTO employee_status (status_name )
VALUES
('Regular'),
('Probationary');

-- TO TEST: SELECT * FROM employee_status;

-- EMPLOYEE INFO ----------------------------------------------------
-- DROP TABLE IF EXISTS employee;
CREATE TABLE IF NOT EXISTS employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_number INT NOT NULL UNIQUE,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
	phone_number VARCHAR(15) NOT NULL,
    supervisor_id INT NULL,
    department_id INT NOT NULL,
	position_id INT NOT NULL,
	role_id INT NOT NULL,
    pay_period_id INT NOT NULL,
    address_id INT NOT NULL,
    government_info_id INT NOT NULL,
    employee_status_id INT NOT NULL,
	basic_salary DECIMAL(10,2) NOT NULL,
    semi_monthly_rate DECIMAL(10,2) NOT NULL,
    hourly_rate DECIMAL(10,2) NOT NULL,
	rice_allowance DECIMAL(10,2) NOT NULL,
    phone_allowance DECIMAL(10,2) NOT NULL,
	clothing_allowance DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT fk_employee_supervisor
    FOREIGN KEY (supervisor_id)
    REFERENCES employee(employee_id),

    CONSTRAINT fk_employee_department
    FOREIGN KEY (department_id)
    REFERENCES department(department_id),
    
	CONSTRAINT fk_employee_position
    FOREIGN KEY (position_id)
    REFERENCES position (position_id),
    
	CONSTRAINT fk_employee_role
    FOREIGN KEY (role_id)
    REFERENCES employee_role(role_id),

    CONSTRAINT fk_employee_pay_period
    FOREIGN KEY (pay_period_id)
    REFERENCES pay_period(pay_period_id),
    
    CONSTRAINT fk_employee_address
    FOREIGN KEY (address_id)
    REFERENCES address(address_id),
    
    CONSTRAINT fk_employee_government_info
    FOREIGN KEY (government_info_id)
    REFERENCES government_info(government_info_id),
    
    CONSTRAINT fk_employee_status
    FOREIGN KEY (employee_status_id)
    REFERENCES employee_status(status_id)
    
); 

DELIMITER $$

CREATE TRIGGER trg_employee_number
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF NEW.employee_number IS NULL THEN
        SET NEW.employee_number = (
            SELECT AUTO_INCREMENT
            FROM information_schema.TABLES
            WHERE TABLE_SCHEMA = DATABASE()
            AND TABLE_NAME = 'employee'
        );
    END IF;
END$$

DELIMITER ;
ALTER TABLE employee
AUTO_INCREMENT = 10001;

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
	(10001,'Manuel III','Garcia','1983-10-11','966-860-270',NULL,1,1,1,1,1,1,1,90000.00,45000.00,535.71,1500.00,2000.00,1000.00),
    (10002,'Antonio','Lim','1988-06-19','171-867-411',10001,1,2,1,1,2,2,1,60000.00,30000.00,357.14,1500.00,2000.00,1000.00),
    (10003,'Bianca Sofia','Aquino','1989-08-04','966-889-370',10001,3,3,1,1,3,3,1,60000.00,30000.00,357.14,1500.00,2000.00,1000.00),
    (10004,'Isabella','Reyes','1994-06-16','786-868-477',10001,5,4,1,1,4,4,1,60000.00,30000.00,357.14,1500.00,2000.00,1000.00),
    (10005,'Eduard','Hernandez','1989-09-23','088-861-012',10002,4,5,2,1,5,5,1,52670.00,26335.00,313.51,1500.00,1000.00,1000.00),
    (10006,'Andrea Mae','Villanueva','1988-02-14','918-621-603',10002,2,6,2,1,6,6,1,52670.00,26335.00,313.51,1500.00,1000.00,1000.00),
    (10007,'Brad','San Jose','1996-03-15','797-009-261',10006,2,7,2,1,7,7,1,42975.00,21488.00,255.80,1500.00,800.00,800.00),
    (10008,'Alice','Romualdez','1992-05-14','983-606-799',10007,2,8,3,1,8,8,1,22500.00,11250.00,133.93,1500.00,500.00,500.00),
    (10009,'Rosie','Atienza','1948-09-24','266-036-427',10007,2,8,3,1,9,9,1,22500.00,11250.00,133.93,1500.00,500.00,500.00),
    (10010,'Roderick','Alvaro','1988-03-30','053-381-386',10003,3,9,2,1,10,10,1,52670.00,26335.00,313.51,1500.00,1000.00,1000.00),
    (10011,'Anthony','Salcedo','1993-09-14','070-766-300',10010,3,10,2,1,11,11,1,50825.00,25413.00,302.53,1500.00,1000.00,1000.00),
    (10012,'Josie','Lopez','1987-01-14','478-355-427',10011,3,11,2,1,12,12,1,38475.00,19238.00,229.02,1500.00,800.00,800.00),
    (10013,'Martha','Farala','1942-01-11','329-034-366',10011,3,12,3,1,13,13,1,24000.00,12000.00,142.86,1500.00,500.00,500.00),
    (10014,'Leila','Martinez','1970-07-11','877-110-749',10011,3,12,3,1,14,14,1,24000.00,12000.00,142.86,1500.00,500.00,500.00),
    (10015,'Fredrick','Romualdez','1985-03-10','023-079-009',10002,3,13,2,1,15,15,1,53500.00,26750.00,318.45,1500.00,1000.00,1000.00),
    (10016,'Christian','Mata','1987-10-21','783-776-744',10015,3,14,2,1,16,16,1,42975.00,21488.00,255.80,1500.00,800.00,800.00),
    (10017,'Selena','De Leon','1975-02-20','975-432-139',10015,3,14,2,1,17,17,1,41850.00,20925.00,249.11,1500.00,800.00,800.00),
    (10018,'Allison','San Jose','1986-06-24','179-075-129',10016,3,15,3,1,18,18,1,22500.00,11250.00,133.93,1500.00,500.00,500.00),
    (10019,'Cydney','Rosario','1996-10-06','868-819-912',10016,3,15,3,1,19,19,1,22500.00,11250.00,133.93,1500.00,500.00,500.00),
    (10020,'Mark','Bautista','1991-02-12','683-725-348',10016,3,16,3,1,20,20,1,23250.00,11625.00,138.39,1500.00,500.00,500.00),
    (10021,'Darlene','Lazaro','1985-11-25','740-721-558',10016,3,16,3,1,21,21,2,23250.00,11625.00,138.39,1500.00,500.00,500.00),
    (10022,'Kolby','Delos Santos','1980-02-26','739-443-033',10016,3,17,3,1,22,22,2,24000.00,12000.00,142.86,1500.00,500.00,500.00),
    (10023,'Vella','Santos','1983-12-31','955-879-269',10016,3,15,3,1,23,23,2,22500.00,11250.00,133.93,1500.00,500.00,500.00),
    (10024,'Tomas','Del Rosario','1978-12-18','882-550-989',10016,3,15,3,1,24,24,2,22500.00,11250.00,133.93,1500.00,500.00,500.00),
    (10025,'Jacklyn','Tolentino','1984-05-19','675-757-366',10017,3,17,3,1,25,25,2,24000.00,12000.00,142.86,1500.00,500.00,500.00),
    (10026,'Percival','Gutierrez','1970-12-18','512-899-876',10017,3,18,3,1,26,26,2,24750.00,12375.00,147.32,1500.00,500.00,500.00),
    (10027,'Garfield','Manalaysay','1986-08-28','948-628-136',10017,3,18,3,1,27,27,2,24750.00,12375.00,147.32,1500.00,500.00,500.00),
    (10028,'Lizeth','Villegas','1981-12-12','332-372-215',10017,3,17,3,1,28,28,2,24000.00,12000.00,142.86,1500.00,500.00,500.00),
    (10029,'Carol','Ramos','1978-08-20','250-700-389',10017,3,15,3,1,29,29,2,22500.00,11250.00,133.93,1500.00,500.00,500.00),
    (10030,'Emelia','Maceda','1973-04-14','973-358-041',10017,3,15,3,1,30,30,2,22500.00,11250.00,133.93,1500.00,500.00,500.00),
    (10031,'Delia','Aguilar','1989-01-27','529-705-439',10017,3,15,3,1,31,31,2,22500.00,11250.00,133.93,1500.00,500.00,500.00),
    (10032,'John Rafael','Castro','1992-02-09','332-424-955',10004,5,19,2,1,32,32,1,52670.00,26335.00,313.51,1500.00,1000.00,1000.00),
    (10033,'Carlos Ian','Martinez','1990-11-16','078-854-208',10004,6,20,2,1,33,33,1,52670.00,26335.00,313.51,1500.00,1000.00,1000.00),
    (10034,'Beatriz','Santos','1990-08-07','526-639-511',10004,7,21,2,1,34,34,1,52670.00,26335.00,313.51,1500.00,1000.00,1000.00);
-- ===========================
-- TO TEST: SELECT * FROM employee;

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

-- ATTENDANCE  ----------------------------------------------------------------
-- DROP TABLE IF EXISTS attendance;
CREATE TABLE IF NOT EXISTS attendance (
attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    date DATE NOT NULL,
    time_in TIME NOT NULL,
    time_out TIME NOT NULL,
    total_regular_hours INT,
    
    CONSTRAINT fk_employee_attendance
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id)
);

INSERT INTO attendance (employee_id, date, time_in, time_out, total_regular_hours)
VALUES	(10015, '2026-01-02', '08:00:00', '17:00:00', 8),
		(10015, '2026-01-05', '08:00:00', '17:00:00', 8),
        (10015, '2026-01-06', '08:00:00', '17:00:00', 8),
        (10015, '2026-01-07', '08:00:00', '17:00:00', 8),
        (10015, '2026-01-08', '08:00:00', '17:00:00', 8),
        (10015, '2026-01-09', '08:00:00', '17:00:00', 8),
        (10015, '2026-01-12', '08:00:00', '17:00:00', 8),
        (10015, '2026-01-13', '08:00:00', '17:00:00', 8),
        (10015, '2026-01-14', '08:00:00', '17:00:00', 8),
        (10015, '2026-01-15', '08:00:00', '17:00:00', 8),
        (10015, '2026-12-18', '08:00:00', '17:00:00', 8),
        (10015, '2026-12-19', '08:00:00', '17:00:00', 8),
        (10015, '2026-12-20', '08:00:00', '17:00:00', 8),
        (10015, '2026-12-21', '08:00:00', '17:00:00', 8),
        (10015, '2026-12-22', '08:00:00', '17:00:00', 8),
        (10015, '2026-12-26', '08:00:00', '17:00:00', 8),
        (10015, '2026-12-27', '08:00:00', '17:00:00', 8),
        (10015, '2026-12-28', '08:00:00', '17:00:00', 8),
        (10015, '2026-12-29', '08:00:00', '17:00:00', 8);
-- TO TEST: SELECT * FROM attendance;

-- EMPLOYEE CREDENTIALS ---------------------------------------------------------------
-- DROP TABLE IF EXISTS employee_credentials;
CREATE TABLE IF NOT EXISTS employee_credentials (
emp_credential_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    username VARCHAR(50) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    
    CONSTRAINT fk_employee_employee_credentials
    FOREIGN KEY (employee_id)
REFERENCES employee (employee_id)
);
INSERT INTO employee_credentials (employee_id, username, password_hash)
VALUES	(10001, 'manuel_garcia', 'pwhash'),
		(10002, 'antonio_lim', 'pwhash'),
        (10003, 'bianca_aquino', 'pwhash'),
        (10004, 'isabella_reyes', 'pwhash'),
        (10005, 'eduard_hernandez', 'pwhash'),
        (10006, 'andrea_villanueva', 'pwhash'),
        (10007, 'brad_sanjose', 'pwhash'),
        (10008, 'alice_romualdez', 'pwhash'),
        (10009, 'rosie_atienza', 'pwhash'),
        (10010, 'roderick_alvaro', 'pwhash'),
        (10011, 'anthony_salcedo', 'pwhash'),
        (10012, 'josie_lopez', 'pwhash'),
        (10013, 'martha_farala', 'pwhash'),
        (10014, 'leila_martinez', 'pwhash'),
        (10015, 'fredrick_romualdez', 'pwhash'),
        (10016, 'christian_mata', 'pwhash'),
        (10017, 'selena_deleon', 'pwhash'),
        (10018, 'allison_sanjose', 'pwhash'),
        (10019, 'cydney_rosario', 'pwhash'),
        (10020, 'mark_bautista', 'pwhash'),
        (10021, 'darlene_lazaro', 'pwhash'),
        (10022, 'kolby_delossantos', 'pwhash'),
        (10023, 'vella_santos', 'pwhash'),
        (10024, 'tomas_delrosario', 'pwhash'),
        (10025, 'jacklyn_tolentino', 'pwhash'),
        (10026, 'percival_gutierrez', 'pwhash'),
        (10027, 'garfield_manalaysay', 'pwhash'),
        (10028, 'lizeth_villegas', 'pwhash'),
        (10029, 'carol_ramos', 'pwhash'),
        (10030, 'emelia_maceda', 'pwhash'),
        (10031, 'delia_aguilar', 'pwhash'),
        (10032, 'john_castro', 'pwhash'),
        (10033, 'carlos_martinez', 'pwhash'),
        (10034, 'beatriz_santos', 'pwhash');
        
-- TO TEST: SELECT * FROM employee_credentials;

-- EMPLOYEE_ROLE_ASSIGNMENT --------------------------------------------------------------------
-- DROP TABLE IF EXISTS employee_role_assignment;
CREATE TABLE IF NOT EXISTS employee_role_assignment (
	emp_credential_id_role_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_credential_id INT NOT NULL,
    role_id INT NOT NULL,
    
    CONSTRAINT fk_employee_role_employee_credentials
    FOREIGN KEY (emp_credential_id)
    REFERENCES employee_credentials (emp_credential_id),
    
    CONSTRAINT fk_employee_role_role
    FOREIGN KEY (role_id)
    REFERENCES employee_role (role_id)
);
INSERT INTO employee_role_assignment (emp_credential_id, role_id)
VALUES(1,1), (2,1), (3,2), (4,2), (5,1), (6,2), (7,2), (8,3), (9,3), (10,2),
(11,2), (12,2), (13,3), (14,3), (15,2), (16,2), (17,2), (18,3), (19,3), (20,3),
(21,3), (22,3), (23,3), (24,3), (25,3), (26,3), (27,3), (28,3), (29,3), (30,3),
(31,3), (32,3), (33,3), (34,3);

-- TO TEST: SELECT * FROM employee_role;

-- OVERTIME ----------------------------------------------------------------------
-- DROP TABLE IF EXISTS overtime;
CREATE TABLE IF NOT EXISTS overtime (
overtime_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    supervisor_id INT,
    attendance_id INT,
    overtime_hours INT NOT NULL,
    approval_status ENUM ('Pending', 'Approved', 'Denied'),
    
    CONSTRAINT fk_employee_overtime
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id),
    
    CONSTRAINT fk_supervisor_overtime
    FOREIGN KEY (supervisor_id)
    REFERENCES employee (employee_id),
    
    CONSTRAINT fk_attendance_overtime
    FOREIGN KEY (attendance_id)
    REFERENCES attendance (attendance_id)
);
INSERT INTO overtime (employee_id, supervisor_id, attendance_id, overtime_hours, approval_status)
SELECT 
a.employee_id,
    e.supervisor_id,
    a.attendance_id,
    GREATEST(0, a.total_regular_hours - 8) AS overtime_hours,
    'Pending' AS approval_status
FROM attendance a
JOIN employee e ON a.employee_id = e.employee_id
WHERE a.attendance_id IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19);

-- TO TEST: SELECT * FROM overtime;

-- LEAVE_REQUEST ------------------------------------------------------------------------
-- DROP TABLE IF EXISTS leave_request;
CREATE TABLE IF NOT EXISTS leave_request (
leave_request_id INT AUTO_INCREMENT PRIMARY KEY,
    leave_type_id INT,
    employee_id INT,
    leave_status_id INT,
    date_start DATE NOT NULL,
    date_end DATE NOT NULL,
    is_paid BOOLEAN NOT NULL,
    approver_name VARCHAR(50) NOT NULL,
    leave_message VARCHAR(255),
    
    CONSTRAINT fk_leave_request_leave_type
    FOREIGN KEY (leave_type_id)
    REFERENCES leave_type (leave_type_id),
    
    CONSTRAINT fk_leave_request_employee
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id),
    
    CONSTRAINT fk_leave_request_leave_status
    FOREIGN KEY (leave_status_id)
    REFERENCES leave_status (leave_status_id)
);
INSERT INTO leave_request (leave_type_id, employee_id, leave_status_id, date_start, date_end, is_paid, approver_name, leave_message)
VALUES(1, 10022, 3, '2026-06-03', '2026-06-06', FALSE, 'Mata Christian', ''),
(2, 10020, 3, '2026-06-06', '2026-06-21', FALSE, 'Mata Christian', ''),
(3, 10020, 2, '2026-06-04', '2026-06-10', FALSE, 'Mata Christian', 'Leave request is approved');
-- TO TEST: SELECT * FROM leave_request;

-- BENEFITS ------------------------------------------------------
-- DROP TABLE IF EXISTS benefits;
CREATE TABLE IF NOT EXISTS benefits ( 
    benefit_id INT AUTO_INCREMENT PRIMARY KEY, 
    employee_id INT NOT NULL, 
    benefit_type_id INT NOT NULL, 
    
    CONSTRAINT fk_benefits_employee 
    FOREIGN KEY (employee_id) 
    REFERENCES employee(employee_id),
    
    CONSTRAINT fk_benefits_benefit_type 
    FOREIGN KEY (benefit_type_id)
    REFERENCES benefit_type(benefit_type_id) 
);
INSERT INTO benefits (employee_id, benefit_type_id)
VALUES
(10015, 1),
(10015, 2),
(10015, 3);

-- TO TEST: SELECT * FROM benefits;

-- DEDUCTIONS ----------------------------------------------------------------------
-- DROP TABLE IF EXISTS deductions;
CREATE TABLE IF NOT EXISTS deductions (
    deduction_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    pay_period_id INT NOT NULL,
    amount DECIMAL(10,2),

    CONSTRAINT fk_deductions_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id),

    CONSTRAINT fk_deductions_pay_period
        FOREIGN KEY (pay_period_id)
        REFERENCES pay_period(pay_period_id)
);
INSERT INTO deductions (employee_id, pay_period_id, amount)
VALUES
(10001, 1, 1000.00),
(10002, 1, 800.00);

-- TO TEST: SELECT * FROM deductions;

-- PAYROLL --------------------------------------------------------------------
-- DROP TABLE IF EXISTS payroll;
CREATE TABLE IF NOT EXISTS payroll (
payroll_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    pay_period_id INT,
    net_pay DECIMAL(10,2) NOT NULL,
    gross_pay DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT fk_payroll_employee
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id),
    
    CONSTRAINT fk_payroll_pay_period
    FOREIGN KEY (pay_period_id)
    REFERENCES pay_period (pay_period_id)
);
INSERT INTO payroll (employee_id, pay_period_id, net_pay, gross_pay)
VALUES
(10034, 2, 44285.60, 50000.00),
(10022, 2, 28560.00, 32000.00),
(10015, 2, 20430.40, 23000.00),
(10005, 2, 20430.40, 23000.00),
(10003, 2, 20430.40, 23000.00);

-- TO TEST: SELECT * FROM payroll;

-- STATUTORY DEDUCTIONS ----------------------------------------------------------------
-- DROP TABLE IF EXISTS statutory;
CREATE TABLE IF NOT EXISTS statutory (
    statutory_id INT AUTO_INCREMENT PRIMARY KEY,
    payroll_id INT,
    deduction_type ENUM ('SSS', 'Withholding Tax', 'PhilHealth', 'PAG-IBIG') NOT NULL,
    amount DECIMAL(10,2),

    CONSTRAINT fk_statutory_payroll
        FOREIGN KEY (payroll_id)
        REFERENCES payroll (payroll_id)
);
INSERT INTO statutory (payroll_id, deduction_type, amount)
VALUES
(1, 'SSS', 2500.00),
(1, 'Withholding Tax', 2700.00),
(2, 'SSS', 1600.00);

-- TO TEST: SELECT * FROM statutory;

-- TAX BRACKETS ---------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS bracket;
CREATE TABLE IF NOT EXISTS bracket (
	bracket_id INT AUTO_INCREMENT PRIMARY KEY,
    statutory_id INT,
    minimum DECIMAL(10,2) NOT NULL,
    maximum DECIMAL(10,2) NOT NULL,
    rate DECIMAL(5,4) NOT NULL,
    
    CONSTRAINT fk_statutory_bracket
    FOREIGN KEY (statutory_id)
    REFERENCES statutory (statutory_id)
);
INSERT INTO bracket (statutory_id, minimum, maximum, rate)
VALUES
(1, 0.00, 3250.00, 0.0300),
(1, 3250.01, 9750.00, 0.0400);
-- TO TEST: SELECT * FROM bracket;

-- STATUTORY DEDUCTIONS ---------------------------------------------------------
-- DROP TABLE IF EXISTS statutory_deductions;
CREATE TABLE IF NOT EXISTS statutory_deductions (
    statutory_deduction_id INT AUTO_INCREMENT PRIMARY KEY,
    deduction_id INT NOT NULL,
    statutory_id INT NOT NULL,

    CONSTRAINT fk_statutory_deduction_deduction
        FOREIGN KEY (deduction_id)
        REFERENCES deductions(deduction_id),

    CONSTRAINT fk_statutory_deduction_statutory
        FOREIGN KEY (statutory_id)
        REFERENCES statutory(statutory_id)
);
INSERT INTO statutory_deductions (deduction_id, statutory_id)
VALUES
(1, 1),
(1, 2);

-- TO TEST: SELECT * FROM statutory_deductions;

-- ROLE PERMISSIONS ----------------------------------------------------------------------
-- DROP TABLE IF EXISTS role_permissions;
CREATE TABLE IF NOT EXISTS role_permissions (
role_id_permissions_id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    permissions_id INT NOT NULL,
    
    CONSTRAINT fk_role_role_permissions
    FOREIGN KEY (role_id)
    REFERENCES employee_role (role_id),
    
    CONSTRAINT fk_permissions_role_permissions
    FOREIGN KEY (permissions_id)
    REFERENCES permissions (permissions_id)
);
INSERT INTO role_permissions (role_id, permissions_id)
VALUES(1,1), (2,2), (3,3);
-- TO TEST: SELECT * FROM role_permissions;

DELIMITER $$
DROP TRIGGER IF EXISTS `prevent_id_gaps_employee`$$

CREATE TRIGGER `prevent_id_gaps_employee`
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    DECLARE next_expected_id INT;

    SELECT COALESCE(MAX(employee_id), 0) + 1 
    INTO next_expected_id 
    FROM employee;

    -- FIX: Only block if the ID isn't NULL, isn't 0, AND doesn't match the sequence
    IF NEW.employee_id IS NOT NULL AND NEW.employee_id != 0 AND NEW.employee_id != next_expected_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insertion blocked: Manual ID must be exactly the next sequential number (no gaps allowed).';
    END IF;
END$$

DELIMITER ;