
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
    hourly_rate DECIMAL(10 , 2) NOT NULL,
    
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
        (3, 'Account Rank and File', '', 133.93),
        (5, 'Sales & Marketing', '', 313.51),
        (6, 'Supply Chain and Logistics', '', 313.51),
        (5, 'Customer Service and Relations', '', 313.51);
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
('2026-06-01', '2026-06-15', 'Period 1'),
('2026-06-16', '2026-06-30', 'Period 2');
SELECT * FROM pay_period;

CREATE TABLE benefit_type (
    benefit_type_id INT AUTO_INCREMENT PRIMARY KEY,
    benefit_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);
INSERT INTO benefit_type (benefit_type, amount)
VALUES
('Rice Subsidy', 1500.00),
('Phone Allowance', 1000.00),
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
VALUES	('Makati Corporate Center', 'Makati Avenue', 'Bel-Air', 'Makati City', 'Metro Manila', 1200),
		('BGC Central', 'Third Avenue', 'Bonifacio Global City', 'Taguig City', 'Metro Manila', 1634);
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
(11111111110, 12345678901, 12345678901, 12345678901),
(11111111111, 12345678902, 12345678902, 12345678902);
SELECT * FROM government_info;

CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    supervisor_id INT NULL,
    department_id INT,
    pay_period_id INT,
    benefit_type_id INT,
    role_id INT,
    position_id INT,
    address_id INT,
    government_info_id INT,
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
    REFERENCES government_info(government_info_id)
);

INSERT INTO employee (employee_id, supervisor_id, department_id, pay_period_id, benefit_type_id, role_id, position_id, address_id, government_info_id, first_name, last_name)
VALUES	(10001, NULL, 1, 1, 1, 1, 1, 1, 1, 'John', 'Doe'),
		(10002, 10001, 2, 1, 1, 2, 6, 1, 1, 'Jane', 'Smith'),
		(10003, 10001, 3, 1, 1, 2, 9, 1, 1, 'Robert', 'Johnson'),
		(10004, 10002, 2, 1, 2, 3, 7, 1, 1, 'Maria', 'Garcia'),
		(10005, 10001, 4, 1, 2, 3, 5, 1, 1, 'Michael', 'Brown'),
		(10006, 10002, 2, 1, 3, 3, 8, 1, 2, 'Jennifer', 'Davis'),
		(10007, 10003, 3, 1, 1, 3, 11, 2, 2, 'David', 'Miller'),
		(10008, 10001, 5, 1, 2, 3, 16, 2, 2, 'Sarah', 'Wilson'),
		(10009, 10008, 5, 1, 1, 3, 18, 2, 1, 'James', 'Moore'),
		(10010, 10003, 3, 1, 3, 3, 12, 1, 1, 'Patricia', 'Taylor'),
		(10011, 10001, 6, 1, 2, 3, 17, 1, 2, 'Christopher', 'Anderson'),
		(10012, 10002, 2, 1, 1, 3, 7, 2, 1, 'Lisa', 'Thomas'),
		(10013, 10003, 3, 1, 2, 3, 13, 1, 1, 'Daniel', 'Jackson'),
		(10014, 10001, 1, 1, 3, 2, 2, 1, 2, 'Carol', 'White'),
		(10015, 10002, 2, 1, 1, 2, 7, 2, 1, 'Matthew', 'Harris'),
		(10016, 10001, 3, 1, 2, 3, 10, 1, 1, 'Mary', 'Martin'),
		(10017, 10008, 5, 1, 1, 3, 16, 1, 2, 'Mark', 'Lee'),
		(10018, 10003, 3, 1, 3, 3, 14, 2, 1, 'Sandra', 'Perez'),
		(10019, 10001, 4, 1, 1, 3, 5, 1, 2, 'Donald', 'Thompson'),
		(10020, 10001, 3, 1, 2, 3, 15, 2, 1, 'Ashley', 'Garcia'),
		(10021, 10002, 2, 1, 1, 3, 8, 1, 1, 'Kenneth', 'Martinez'),
		(10022, 10003, 3, 1, 3, 3, 11, 1, 2, 'Donna', 'Robinson'),
		(10023, 10001, 1, 1, 2, 2, 1, 2, 1, 'Paul', 'Clark'),
		(10024, 10008, 5, 1, 1, 3, 18, 1, 1, 'Jessica', 'Rodriguez'),
		(10025, 10002, 2, 1, 2, 3, 6, 2, 2, 'Stephen', 'Lewis'),
		(10026, 10003, 3, 1, 1, 3, 12, 1, 1, 'Shirley', 'Lee'),
		(10027, 10001, 4, 1, 3, 3, 5, 1, 1, 'Larry', 'Walker'),
		(10028, 10001, 5, 1, 1, 3, 17, 2, 2, 'Cynthia', 'Hall'),
		(10029, 10003, 3, 1, 2, 3, 13, 1, 1, 'Jeffrey', 'Allen'),
		(10030, 10002, 2, 1, 1, 3, 7, 1, 2, 'Kathleen', 'Young'),
		(10031, 10001, 1, 1, 3, 2, 2, 2, 1, 'Ryan', 'Hernandez'),
		(10032, 10008, 
5, 1, 2, 3, 16, 1, 1, 'Brenda', 'King'),
		(10033, 10003, 3, 1, 1, 3, 10, 2, 2, 'Jacob', 'Wright'),
		(10034, 10001, 6, 1, 2, 3, 17, 1, 1, 'Karen', 'Lopez');
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
VALUES	(10015, '2023-12-01', '08:00:00', '17:00:00', 8),
		(10015, '2023-12-04', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-05', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-06', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-07', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-11', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-12', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-13', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-14', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-15', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-18', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-19', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-20', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-21', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-22', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-26', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-27', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-28', '08:00:00', '17:00:00', 8),
        (10015, '2023-12-29', '08:00:00', '17:00:00', 8);
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
VALUES	(10001, 'admin', 'pwhash'),
		(10002, 'admin', 'pwhash'),
        (10003, 'admin', 'pwhash'),
        (10004, 'admin', 'pwhash'),
        (10005, 'admin', 'pwhash'),
        (10006, 'admin', 'pwhash'),
        (10007, 'admin', 'pwhash'),
        (10008, 'admin', 'pwhash'),
        (10009, 'admin', 'pwhash'),
        (10010, 'admin', 'pwhash'),
        (10011, 'admin', 'pwhash'),
        (10012, 'admin', 'pwhash'),
        (10013, 'admin', 'pwhash'),
        (10014, 'admin', 'pwhash'),
        (10015, 'admin', 'pwhash'),
        (10016, 'admin', 'pwhash'),
        (10017, 'admin', 'pwhash'),
        (10018, 'admin', 'pwhash'),
        (10019, 'admin', 'pwhash'),
        (10020, 'admin', 'pwhash'),
        (10021, 'admin', 'pwhash'),
        (10022, 'admin', 'pwhash'),
        (10023, 'admin', 'pwhash'),
        (10024, 'admin', 'pwhash'),
        (10025, 'admin', 'pwhash'),
        (10026, 'admin', 'pwhash'),
        (10027, 'admin', 'pwhash'),
        (10028, 'admin', 'pwhash'),
        (10029, 'admin', 'pwhash'),
        (10030, 'admin', 'pwhash'),
        (10031, 'admin', 'pwhash'),
        (10032, 'admin', 'pwhash'),
        (10033, 'admin', 'pwhash'),
        (10034, 'admin', 'pwhash');
SELECT * FROM employee_credentials;

CREATE TABLE employee_role (
emp_credential_id_role_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_credential_id INT,
    role_id INT,
    
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
    employee_id INT, 
    benefit_type_id INT, 
    amount DECIMAL(10,2), 
    
    CONSTRAINT fk_benefits_employee 
    FOREIGN KEY (employee_id) 
    REFERENCES employee(employee_id),
    
    CONSTRAINT fk_benefits_benefit_type 
    FOREIGN KEY (benefit_type_id)
    REFERENCES benefit_type(benefit_type_id) 
);
INSERT INTO benefits (employee_id, benefit_type_id, amount)
VALUES
(10001, 1, 1500.00),
(10002, 1, 1500.00),
(10015, 2, 1000.00);
SELECT * FROM benefits;

CREATE TABLE deductions (
    deduction_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    pay_period_id INT,
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
(10001, 1, 44285.60, 50000.00),
(10002, 1, 28560.00, 32000.00),
(10015, 1, 20430.40, 23000.00);
SELECT * FROM payroll;

CREATE TABLE status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    status_name ENUM (
        'Regular',
        'Probationary',
        'Contractual',
        'Resigned',
        'Terminated'
    ) NOT NULL,

    CONSTRAINT fk_status_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id)
);
INSERT INTO status (employee_id, status_name)
VALUES
(10001, 'Regular'),
(10002, 'Regular'),
(10015, 'Probationary');
SELECT * FROM status;

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
    deduction_id INT,
    statutory_id INT,

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
    role_id INT,
    permissions_id INT,
    
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

