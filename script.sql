CREATE TABLE department (
department_id INT AUTO_INCREMENT PRIMARY KEY,
department_name VARCHAR(50) NOT NULL
);
INSERT INTO department (department_name)
VALUES	('Executive'),
		('HR'),
		('Finance'),
        ('IT'),
        ('Sales and Marketing'),
        ('Logistics');
SELECT * FROM department;

CREATE TABLE position (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT,
    position_name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NULL,
    hourly_rate DECIMAL(10, 6) NOT NULL,
    
    CONSTRAINT fk_position_department
    FOREIGN KEY (department_id)
REFERENCES department (department_id)
);
INSERT INTO position (department_id, position_name, description, hourly_rate)
VALUES	(1, 'Chief Executive Officer', '', 535.71),
		(1, 'Chief Operating Officer', '', 357.14),
        (3, 'Chief Finance Officer', '', 357.14),
        (5, 'Chief Marketing Officer', '', 357.14),
        (4, 'IT Operations and Systems', '', 313.51),
        (2, 'HR Manager', '', 313.51),
        (2, 'HR Team Leader', '', 255.80),
        (2, 'HR Rank and File', '', 133.93),
        (3, 'Accounting Head', '', 313.51),
        (3, 'Payroll Manager', '', 302.53),
        (3, 'Payroll Team Leader', '', 229.02),
        (3, 'Payroll Rank and File', '', 142.86),
        (3, 'Account Manager', '', 318.45),
        (3, 'Account Team Leader', '', 255.80),
        (3, 'Account Rank and File (1)', '', 133.93),
        (3, 'Account Rank and File (2)', '', 138.39),
        (3, 'Account Rank and File (3)', '', 142.86),
        (3, 'Account Rank and File (4)', '', 147.32),
        (5, 'Sales & Marketing', '', 313.51),
        (6, 'Supply Chain and Logistics', '', 313.51),
        (5, 'Customer Service and Relations', '', 313.51),
        (4, 'IT Technical Support', '', 255.80);
SELECT * FROM position;

CREATE TABLE role (
role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL,
    is_admin BOOLEAN
);
INSERT INTO role (role_name, is_admin)
VALUES	('Administrator', TRUE),
		('Supervisor', TRUE),
		('Standard User', FALSE);
SELECT * FROM role;

CREATE TABLE permissions (
permissions_id INT AUTO_INCREMENT PRIMARY KEY,
    access SET ('CREATE', 'READ', 'UPDATE', 'DELETE') NOT NULL,
    record_type SET ('Employee','Payroll','Attendance', 'Department', 'Position') NOT NULL
);
INSERT INTO permissions (access, record_type)
VALUES	('CREATE,READ,UPDATE,DELETE', 'Employee,Payroll,Attendance,Department,Position'),
		('READ,UPDATE', 'Employee,Payroll,Attendance,Department,Position'),
		('READ', 'Employee,Payroll,Attendance,Department,Position');
SELECT * FROM permissions;

CREATE TABLE leave_status (
    leave_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);
INSERT INTO leave_status (status_name)
VALUES
('Pending'),
('Approved'),
('Rejected'),
('Cancelled');
SELECT * FROM leave_status;

CREATE TABLE leave_type (
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
SELECT * FROM leave_type;

CREATE TABLE pay_period (
    pay_period_id INT AUTO_INCREMENT PRIMARY KEY,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    period_label VARCHAR(15)
);
INSERT INTO pay_period (period_start, period_end, period_label)
VALUES 
('2026-01-02', '2026-01-15', 'Period 1'),
('2026-01-02', '2026-01-30', 'Period 2');
SELECT * FROM pay_period;

CREATE TABLE benefit_type (
    benefit_type_id INT AUTO_INCREMENT PRIMARY KEY,
    benefit_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);
INSERT INTO benefit_type (benefit_type, amount)
VALUES
('Rice Subsidy', 1500.00),
('Phone Allowance', 2000.00),
('Clothing Allowance', 1000.00);
SELECT * FROM benefit_type;

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    building VARCHAR(255) NOT NULL,
    street VARCHAR(50) NOT NULL,
    barangay VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL, 
    province VARCHAR(50) NOT NULL, 
    zip_code INT NOT NULL
);
INSERT INTO address (building, street, barangay, city, province, zip_code)
VALUES
('Valero Carpark Building', 'Valero Street', '', 'Makati City', '', 1227),
('', 'San Antonio De Padua 2, Block 1 Lot 8 and 2', '', 'Dasmarinas', 'Cavite', 0),
('Rm. 402 4/F Jiao Building', 'Timog Avenue Cor. Quezon Avenue', '', 'Quezon City', '', 1100),
('', '460 Solanda Street', 'Intramuros', 'Manila', '', 1000),
('', 'National Highway', '', 'Gingoog', 'Misamis Occidental', 0),
('17/85 Stracke Via Suite 042', '', 'Poblacion', 'Las Piñas', 'Dinagat Islands', 4783),
('99 Strosin Hills', '', 'Poblacion', 'Bislig', 'Tawi-Tawi', 5340),
('12A/33 Upton Isle Apt. 420', '', '', 'Roxas City', 'Surigao del Norte', 1814),
('90A Dibbert Terrace Apt. 190', '', '', 'San Lorenzo', 'Davao del Norte', 6056),
('', '#284 T. Morato corner, Scout Rallos Street', '', 'Quezon City', '', 0),
('93/54 Shanahan Alley Apt. 183', '', '', 'Santo Tomas', 'Masbate', 1572),
('49 Springs Apt. 266', '', 'Poblacion', 'Taguig', 'Occidental Mindoro', 3200),
('42/25 Sawayn Stream', '', '', 'Ubay', 'Zamboanga del Norte', 1208),
('37/46 Kulas Roads', '', '', 'Maragondon', 'Quirino', 0962),
('22A/52 Lubowitz Meadows', '', '', 'Pililla', 'Zambales', 4895),
('90 O\'Keefe Spur Apt. 379', '', '', 'Catigbian', 'Sulu', 2772),
('89A Armstrong Trace', '', '', 'Compostela', 'Maguindanao', 7874),
('08 Grant Drive Suite 406', '', 'Poblacion', 'Iloilo City', 'La Union', 9186),
('93A/21 Berge Points', '', '', 'Tapaz', 'Quezon', 2180),
('65 Murphy Center Suite 094', '', 'Poblacion', 'Palayan', 'Quirino', 5636),
('47A/94 Larkin Plaza Apt. 179', '', 'Poblacion', 'Caloocan', 'Quirino', 2751),
('06A Gulgowski Extensions', '', '', 'Bongabon', 'Zamboanga del Sur', 6085),
('99A Padberg Spring', '', 'Poblacion', 'Mabalacat', 'Lanao del Sur', 3959),
('80A/48 Ledner Ridges', '', 'Poblacion', 'Kabankalan', 'Marinduque', 8870),
('96/48 Watsica Flats Suite 734', '', 'Poblacion', 'Malolos', 'Ifugao', 1844),
('58A Wilderman Walks', '', 'Poblacion', 'Digos', 'Davao del Sur', 5822),
('60 Goyette Valley Suite 219', '', 'Poblacion', 'Tabuk', 'Lanao del Sur', 3159),
('66/77 Mann Views', '', '', 'Luisiana', 'Dinagat Islands', 1263),
('72/70 Stamm Spurs', '', '', 'Bustos', 'Iloilo', 4550),
('50A/83 Bahringer Oval Suite 145', '', '', 'Kiamba', 'Nueva Ecija', 7688),
('95 Cremin Junction', '', '', 'Surallah', 'Cotabato', 2809),
('', 'Hi-way', 'Yati', 'Liloan', 'Cebu', 0),
('', '', 'Bulala', 'Camalaniugan', '', 0),
('Agapita Building', '', '', 'Metro Manila', '', 0),
('', '', '', '', '', 0),
('', '', '', '', '', 0),
('Ayala Avenue 1200', '', 'Makati City', 'Metro Manila', '', 0),
('', '', '', '', '', 0),
('', '', '', '', '', 0),
('Unit 2802 One San Miguel Bldg', 'Shaw Blvd Cor San Miguel Ave', 'Ortigas Ctr 1605', 'Pasig City','', 0),
('8435 West Service Road', 'Marcelo Green Village South Superhighway', 'Paranaque City', '', '',0);


SELECT * FROM address;

CREATE TABLE government_info (
	government_info_id INT AUTO_INCREMENT PRIMARY KEY,
    sss_number BIGINT NOT NULL,
    phil_health_number BIGINT NOT NULL,
    tin_number BIGINT NOT NULL,
    pag_ibig_number BIGINT NOT NULL
);
INSERT INTO government_info (sss_number, phil_health_number, tin_number, pag_ibig_number)
VALUES
(4445060573, 820126853951, 442605657000, 691295330870),
(5220612749, 331735646338, 683102776000, 663904995411),
(3088704062, 177451189665, 971711280000, 171519773969),
(4025118150, 341911411254, 876809437000, 416946776041),
(5055776381, 957436191812, 31702374000, 952347222457),
(4916320208, 382189453145, 317674022000, 441093369646),
(4024007141, 239192926939, 672474690000, 210850209964),
(5544765272, 545652640232, 888572294000, 211385556888),
(4106446923, 708988234853, 604997793000, 260107732354),
(6476050544, 578114853194, 525420419000, 799254095212),
(2696476083, 126445315651, 210805911000, 218002473454),
(4485634483, 431709011012, 218489737000, 113071293354),
(4556563750, 233693897247, 210835851000, 631130283546),
(2720909964, 515741057496, 275792513000, 101205445886),
(2687683741, 308366860059, 598065761000, 223057707853),
(49-2959312-6, 824187961962, 103100522000, 631052853464),
(2720902088, 587272469938, 482259498000, 719007608464),
(4532513830, 745148459521, 121203336000, 114901859343),
(4916299002, 579253435499, 122244511000, 265104358643),
(4916473425, 399665157135, 273970941000, 260054585575),
(4556171682, 606386917510, 354650951000, 104907708845),
(5201095706, 357451271274, 187500345000, 113017988667),
(5298835243, 548670482885, 101558994000, 360028104576),
(4558663316, 953901539995, 560735732000, 913108649964),
(4716927930, 753800654114, 841177857000, 210546661243),
(4095046578, 797639382265, 502995671000, 210897095686),
(4532981664, 810909286264, 336676445000, 211274476563),
(4024007194, 934389652994, 210395397000, 122238077997),
(6011522064, 351830469744, 395032717000, 212141893454),
(5413310050, 465087894112, 215973013000, 515012579765),
(5218592531, 136451303068, 599312588000, 110018813465),
(2671451334, 601644902402, 404768309000, 697764069311),
(1150629727, 380685387212, 256436296000, 993372963726),
(2029875015, 918460050077, 911529713000, 874042259378),
(3641605364, 862055202862, 936540856000, 521301652682);
SELECT * FROM government_info;

CREATE TABLE status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name ENUM (
        'Regular',
        'Probationary',
        'Contractual',
        'Resigned',
        'Terminated'
    ) NOT NULL
);

INSERT INTO status (status_name)
VALUES
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Probationary'),
('Probationary'),
('Probationary'),
('Probationary'),
('Probationary'),
('Probationary'),
('Probationary'),
('Probationary'),
('Probationary'),
('Probationary'),
('Probationary'),
('Regular'),
('Regular'),
('Regular'),
('Regular'),
('Probationary'),
('Probationary'),
('Probationary'),
('Probationary'),
('Probationary'),
('Probationary');
SELECT * FROM status;

CREATE TABLE employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    supervisor_id INT NULL,
    department_id INT NOT NULL,
    pay_period_id INT NOT NULL,
    benefit_type_id INT NOT NULL,
    role_id INT NOT NULL,
    position_id INT NOT NULL,
    address_id INT NOT NULL,
    government_info_id INT NOT NULL,
    status_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    
    CONSTRAINT fk_employee_supervisor
    FOREIGN KEY (supervisor_id)
    REFERENCES employee(employee_id),

    CONSTRAINT fk_employee_department
    FOREIGN KEY (department_id)
    REFERENCES department(department_id),

    CONSTRAINT fk_employee_pay_period
    FOREIGN KEY (pay_period_id)
    REFERENCES pay_period(pay_period_id),

    CONSTRAINT fk_employee_role
    FOREIGN KEY (role_id)
    REFERENCES role(role_id),

    CONSTRAINT fk_employee_position
    FOREIGN KEY (position_id)
    REFERENCES position (position_id),
    
    CONSTRAINT fk_employee_benefit
    FOREIGN KEY (benefit_type_id)
    REFERENCES benefit_type(benefit_type_id),
    
    CONSTRAINT fk_employee_address
    FOREIGN KEY (address_id)
    REFERENCES address(address_id),
    
    CONSTRAINT fk_employee_government_info
    FOREIGN KEY (government_info_id)
    REFERENCES government_info(government_info_id),
    
    CONSTRAINT fk_employee_status
    FOREIGN KEY (status_id)
    REFERENCES status(status_id)
) AUTO_INCREMENT = 10001;

INSERT INTO employee (supervisor_id, department_id, pay_period_id, benefit_type_id, role_id, position_id, address_id, government_info_id, status_id, first_name, last_name)
VALUES	
		-- CEO
        (NULL, 1, 1, 1, 1, 1, 1, 1, 1, 'Manuel III', 'Garcia'), 
		-- COO
		(10001, 2, 1, 1, 2, 2, 2, 2, 2, 'Antonio', 'Lim'),
        -- CFO
		(10001, 3, 1, 1, 2, 3, 3, 3, 3, 'Bianca Sofia', 'Aquino'),
        -- CMO
		(10002, 2, 1, 2, 3, 4, 4, 4, 4, 'Isabella', 'Reyes'),
        -- IT OP & SYS
		(10001, 4, 1, 2, 3, 5, 5, 5, 5, 'Eduard', 'Hernandez'),
        -- HR MNGR
		(10002, 2, 1, 3, 3, 6, 6, 6, 6, 'Andrea Mae', 'Villanueva'),
        -- HR LEAD
		(10003, 3, 1, 1, 3, 7, 7, 7, 7, 'Brad', 'San Jose'),
		-- HR R&F
        (10001, 5, 1, 2, 3, 8, 8, 8, 8, 'Alice', 'Romualdez'),
		(10008, 5, 1, 1, 3, 8, 9, 9, 9, 'Rosie', 'Atienza'),
        -- ACC HEAD
		(10003, 3, 1, 3, 3, 9, 10, 10, 10, 'Roderick', 'Alvaro'),
        -- PR MNGR
		(10001, 6, 1, 2, 3, 10, 11, 11, 11, 'Anthony', 'Salcedo'),
        -- PR LEAD
		(10002, 2, 1, 1, 3, 11, 12, 12, 12, 'Josie', 'Lopez'),
        -- PR R&F
		(10003, 3, 1, 2, 3, 12, 13, 13, 13, 'Martha', 'Farala'),
		(10001, 1, 1, 3, 2, 12, 14, 14, 14, 'Leila', 'Martinez'),
        -- ACC MNGR
		(10002, 3, 1, 1, 2, 13, 15, 15, 15, 'Fredrick', 'Romualdez'),
        -- ACC LEAD
		(10001, 3, 1, 2, 3, 14, 16, 16, 16, 'Christian', 'Mata'),
        (10008, 5, 1, 1, 3, 14, 17, 17, 17, 'Selena', 'De Leon'),
        -- ACC R&F
        -- (1)
		(10003, 3, 1, 3, 3, 15, 18, 18, 18, 'Allison', 'San Jose'),
		(10001, 4, 1, 1, 3, 15, 19, 19, 19, 'Cydney', 'Rosario'),
        -- (2)
		(10001, 3, 1, 2, 3, 16, 20, 20, 20, 'Mark', 'Bautista'),
		(10002, 2, 1, 1, 3, 16, 21, 21, 21, 'Darlene', 'Lazaro'),
        -- (3)
		(10003, 3, 1, 3, 3, 17, 22, 22, 22, 'Kolby', 'Delos Santos'),
        -- (1)
		(10001, 1, 1, 2, 2, 15, 23, 23, 23, 'Vella', 'Santos'),
		(10008, 5, 1, 1, 3, 15, 24, 24, 24, 'Tomas', 'Del Rosario'),
        -- (3)
		(10002, 2, 1, 2, 3, 17, 25, 25, 25, 'Jacklyn', 'Tolentino'),
        -- (4)
		(10003, 3, 1, 1, 3, 18, 26, 26, 26, 'Percival', 'Gutierrez'),
		(10001, 4, 1, 3, 3, 18, 27, 27, 27, 'Garfield', 'Manalaysay'),
        -- (3)
		(10001, 5, 1, 1, 3, 17, 28, 28, 28, 'Lizeth', 'Villegas'),
        -- (1)
		(10003, 3, 1, 2, 3, 15, 29, 29, 29, 'Carol', 'Ramos'),
		(10002, 2, 1, 1, 3, 15, 30, 30, 30, 'Emelia', 'Maceda'),
        (10001, 1, 1, 3, 2, 15, 31, 31, 31, 'Delia', 'Aguilar'),
        
        -- S&M
		(10008, 5, 1, 2, 3, 19, 32, 32, 32, 'John Rafael', 'Castro'),
        -- SC&L
		(10003, 3, 1, 1, 3, 20, 33, 33, 33, 'Carlos Ian', 'Martinez'),
        -- CS&R
		(10001, 6, 1, 2, 3, 21, 34, 34, 34, 'Beatriz', 'Santos');
SELECT * FROM employee;



CREATE TABLE attendance (
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
SELECT * FROM attendance;

CREATE TABLE employee_credentials (
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
SELECT * FROM employee_credentials;

CREATE TABLE employee_role (
emp_credential_id_role_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_credential_id INT NOT NULL,
    role_id INT NOT NULL,
    
    CONSTRAINT fk_employee_role_employee_credentials
    FOREIGN KEY (emp_credential_id)
    REFERENCES employee_credentials (emp_credential_id),
    
    CONSTRAINT fk_employee_role_role
    FOREIGN KEY (role_id)
    REFERENCES role (role_id)
);
INSERT INTO employee_role (emp_credential_id, role_id)
VALUES(1,1), (2,1), (3,2), (4,2), (5,1), (6,2), (7,2), (8,3), (9,3), (10,2),
(11,2), (12,2), (13,3), (14,3), (15,2), (16,2), (17,2), (18,3), (19,3), (20,3),
(21,3), (22,3), (23,3), (24,3), (25,3), (26,3), (27,3), (28,3), (29,3), (30,3),
(31,3), (32,3), (33,3), (34,3);
SELECT * FROM employee_role;

CREATE TABLE overtime (
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

SELECT * FROM overtime;

CREATE TABLE leave_request (
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
SELECT * FROM leave_request;

CREATE TABLE benefits ( 
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
SELECT * FROM benefits;

CREATE TABLE deductions (
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
SELECT * FROM deductions;

CREATE TABLE payroll (
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

SELECT * FROM payroll;


CREATE TABLE statutory (
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
SELECT * FROM statutory;

CREATE TABLE bracket (
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
SELECT * FROM bracket;

CREATE TABLE statutory_deductions (
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
SELECT * FROM statutory_deductions;

CREATE TABLE role_permissions (
role_id_permissions_id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    permissions_id INT NOT NULL,
    
    CONSTRAINT fk_role_role_permissions
    FOREIGN KEY (role_id)
    REFERENCES role (role_id),
    
    CONSTRAINT fk_permissions_role_permissions
    FOREIGN KEY (permissions_id)
    REFERENCES permissions (permissions_id)
);
INSERT INTO role_permissions (role_id, permissions_id)
VALUES(1,1), (2,2), (3,3);
SELECT * FROM role_permissions;

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