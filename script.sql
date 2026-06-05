CREATE TABLE department (
	department_id INT AUTO_INCREMENT PRIMARY KEY,
	department_name VARCHAR(50) NOT NULL
);
INSERT INTO department 
VALUES	("Executive"),
		("HR"),
		("Finance"),
        ("IT"),
        ("Sales and Marketing"),
        ("Logistics");
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
INSERT INTO position 
VALUES	(1, "Chief Executive Officer", "", 535.71),
		(1, "Chief Operating Officer", "", 357.14),
        (3, "Chief Finance Officer", "", 357.14),
        (5, "Chief Marketing Officer", "", 357.14),
        (4, "IT Operations and Systems", "", 313.51),
        (2, "HR Manager", "", 313.51),
        (2, "HR Team Leader", "", 255.80),
        (2, "HR Rank and File", "", 133.93),
        (2, "HR Rank and File", "", 133.93),
        (3, "Accounting Head", "", 313.51),
        (3, "Payroll Manager", "", 302.53),
        (3, "Payroll Team Leader", "", 229.02),
        (3, "Payroll Rank and File", "", 142.86),
        (3, "Payroll Rank and File", "", 142.86),
        (3, "Account Manager", "", 318.45),
        (3, "Account Team Leader", "", 255.80),
        (3, "Account Team Leader", "", 249.11),
        (3, "Account Rank and File", "", 133.93),
        (3, "Account Rank and File", "", 133.93),
        (3, "Account Rank and File", "", 138.39),
        (3, "Account Rank and File", "", 138.39),
        (3, "Account Rank and File", "", 142.86),
        (3, "Account Rank and File", "", 133.93),
        (3, "Account Rank and File", "", 133.93),
        (3, "Account Rank and File", "", 142.86),
        (3, "Account Rank and File", "", 147.32),
        (3, "Account Rank and File", "", 147.32),
        (3, "Account Rank and File", "", 142.86),
        (3, "Account Rank and File", "", 133.93),
        (3, "Account Rank and File", "", 133.93),
        (3, "Account Rank and File", "", 133.93),
        (5, "Sales & Marketing", "", 313.51),
        (6, "Supply Chain and Logistics", "", 313.51),
        (5, "Customer Service and Relations", "", 313.51);
SELECT * FROM position;

CREATE TABLE role (
	role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL,
    is_admin BIT
);
INSERT INTO role 
VALUES	("Administrator", TRUE),
		("Standard User", FALSE);
SELECT * FROM role;

CREATE TABLE permissions (
<<<<<<< Updated upstream
	permissions_id INT PRIMARY KEY,
    access VARCHAR(50) NOT NULL,
    record_type VARCHAR (50) NOT NULL
    CHECK (record_type IN ('Employee','Payroll','Attendance')),
=======
	permissions_id INT AUTO_INCREMENT PRIMARY KEY,
    access SET ('CREATE', 'READ', 'UPDATE', 'DELETE') NOT NULL,
    record_type SET ('Employee','Payroll','Attendance', 'Department', 'Position') NOT NULL
>>>>>>> Stashed changes
);

CREATE TABLE leave_status (
    leave_status_id INT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

INSERT INTO leave_status
(status_name)
VALUES
('Pending'),
('Approved'),
('Rejected'),
('Cancelled');

CREATE TABLE leave_type (
    leave_type_id INT PRIMARY KEY,
    leave_name VARCHAR(50) NOT NULL
);

INSERT INTO leave_type
(leave_name)
VALUES
('Vacation Leave'),
('Sick Leave'),
('Emergency Leave'),
('Maternity Leave'),
('Paternity Leave');

CREATE TABLE pay_period (
    pay_period_id INT PRIMARY KEY,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    period_label VARCHAR(15)
);

CREATE TABLE benefit_type (
    benefit_type_id INT PRIMARY KEY,
    benefit_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2)
);

CREATE TABLE employee (
    employee_id INT PRIMARY KEY,

    supervisor_id INT NULL,
    department_id INT,
    pay_period_id INT,
    benefit_id INT,
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
    REFERENCES position(position_id)
);

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
INSERT INTO attendance
VALUES	(15, 100015, "2023-12-01", "08:00:00", "17:00:00", 8),
		(15, 100015, "2023-12-04", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-05", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-06", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-07", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-11", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-12", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-13", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-14", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-15", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-18", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-19", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-20", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-21", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-22", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-26", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-27", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-28", "08:00:00", "17:00:00", 8),
        (15, 100015, "2023-12-29", "08:00:00", "17:00:00", 8);
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
INSERT INTO employee_credentials
VALUES	(10001, "admin", "pwhash"),
		(10002, "admin", "pwhash"),
        (10003, "admin", "pwhash"),
        (10004, "admin", "pwhash"),
        (10005, "admin", "pwhash"),
        (10006, "admin", "pwhash"),
        (10007, "admin", "pwhash"),
        (10008, "admin", "pwhash"),
        (10009, "admin", "pwhash"),
        (100010, "admin", "pwhash"),
        (100011, "admin", "pwhash"),
        (100012, "admin", "pwhash"),
        (100013, "admin", "pwhash"),
        (100014, "admin", "pwhash"),
        (100015, "admin", "pwhash"),
        (100016, "admin", "pwhash"),
        (100017, "admin", "pwhash"),
        (100018, "admin", "pwhash"),
        (100019, "admin", "pwhash"),
        (100020, "admin", "pwhash"),
        (100021, "admin", "pwhash"),
        (100022, "admin", "pwhash"),
        (100023, "admin", "pwhash"),
        (100024, "admin", "pwhash"),
        (100025, "admin", "pwhash"),
        (100026, "admin", "pwhash"),
        (100027, "admin", "pwhash"),
        (100028, "admin", "pwhash"),
        (100029, "admin", "pwhash"),
        (100030, "admin", "pwhash"),
        (100031, "admin", "pwhash"),
        (100032, "admin", "pwhash"),
        (100033, "admin", "pwhash"),
        (100034, "admin", "pwhash");
SELECT * FROM employee_credentials;

CREATE TABLE employee_role (
	emp_credential_id_role_id INT PRIMARY KEY,
    emp_credential_id INT,
    role_id INT,
    
    CONSTRAINT fk_employee_role_employee_credentials
    FOREIGN KEY (emp_credential_id)
    REFERENCES employee_credentials (emp_credential_id),
    
    CONSTRAINT fk_employee_role_role
    FOREIGN KEY (role_id)
    REFERENCES role (role_id)
);

CREATE TABLE overtime (
	overtime_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    supervisor_id INT,
    attendance_id INT,
<<<<<<< Updated upstream
    overtime_hours INT NOT NULL,
    approval_status VARCHAR(20)
    CHECK (approval_status IN ('pending', 'approved', 'denied')),
=======
	overtime_hours INT NOT NULL,
    approval_status ENUM ('pending', 'approved', 'denied'),
>>>>>>> Stashed changes
    
    CONSTRAINT fk_employee_overtime
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id),
    
    CONSTRAINT fk_supervisor_overtime
    FOREIGN KEY (supervisor_id)
    REFERENCES employee (supervisor_id),
    
    CONSTRAINT fk_attendance_overtime
    FOREIGN KEY (attendance_id)
    REFERENCES attendance (attendance_id)
);


INSERT INTO overtime (overtime_id, employee_id, supervisor_id, attendance_id, overtime_hours, approval_status)
SELECT 
	employee_id,
    supervisor_id,
    id AS attendance_id,
    GREATEST(0, total_regular_hours - 8) AS overtime_hours,
    "pending" AS approval_status
FROM ATTENDANCE
WHERE id IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19);
	
CREATE TABLE leave_request (
	leave_request_id INT PRIMARY KEY,
    leave_type_id INT,
    employee_id INT,
    leave_status_id INT,
    date_start DATE NOT NULL,
    date_end DATE NOT NULL,
    is_paid BIT NOT NULL,
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
CREATE TABLE benefits ( 
    benefit_id INT PRIMARY KEY, 
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

CREATE TABLE deductions (
    deduction_id INT PRIMARY KEY,
    employee_id INT,
    pay_period_id INT,
    payroll_id INT,
    statutory_deduction_id INT,
    amount DECIMAL(10,2),

    CONSTRAINT fk_deductions_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id),

    CONSTRAINT fk_deductions_pay_period
        FOREIGN KEY (pay_period_id)
        REFERENCES pay_period(pay_period_id)
);

CREATE TABLE payroll (
	payroll_id INT PRIMARY KEY,
    employee_id INT,
    pay_period_id INT,
    deduction_id INT,
    benefit_id INT,
    attendance_id INT,
    position_id INT,
    net_pay DECIMAL(10,2) NOT NULL,
    gross_pay DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT fk_payroll_employee
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id),
    
    CONSTRAINT fk_payroll_pay_period
    FOREIGN KEY (pay_period_id)
    REFERENCES pay_period (pay_period_id),    
    
    CONSTRAINT fk_payroll_deduction
    FOREIGN KEY (deduction_id)
    REFERENCES deductions (deduction_id),    

    CONSTRAINT fk_payroll_benefits
    FOREIGN KEY (benefit_id)
    REFERENCES benefits (benefit_id),    
    
    CONSTRAINT fk_payroll_attendance
    FOREIGN KEY (attendance_id)
    REFERENCES attendance (attendance_id),
    
    CONSTRAINT fk_payroll_position
    FOREIGN KEY (position_id)
    REFERENCES position (position_id)
);

CREATE TABLE payroll_benefits (
    payroll_id_benefits_id INT PRIMARY KEY,
    employee_id INT,
    benefit_type_id INT,

    CONSTRAINT fk_payroll_benefits_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id),

    CONSTRAINT fk_payroll_benefits_benefit_type
        FOREIGN KEY (benefit_type_id)
        REFERENCES benefit_type(benefit_type_id)
);

CREATE TABLE payroll_deductions (
    payroll_id_deductions_id INT PRIMARY KEY,
    payroll_id INT,
    deduction_id INT,

    CONSTRAINT fk_payroll_deductions_payroll
        FOREIGN KEY (payroll_id)
        REFERENCES payroll(payroll_id),

    CONSTRAINT fk_payroll_deductions_deduction
        FOREIGN KEY (deduction_id)
        REFERENCES deductions(deduction_id)
);

CREATE TABLE statutory (
    statutory_id INT PRIMARY KEY,
    payroll_id INT,
    deduction_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2),

    CONSTRAINT fk_statutory_payroll
        FOREIGN KEY (payroll_id)
        REFERENCES payroll(payroll_id)
);

CREATE TABLE bracket (
	bracket_id INT PRIMARY KEY,
    statutory_id INT,
    minimum DECIMAL(10,2) NOT NULL,
    maximum DECIMAL(10,2) NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT fk_statutory_bracket
    FOREIGN KEY (statutory_id)
    REFERENCES statutory (statutory_id)
);
INSERT INTO bracket
(statutory_id, minimum, maximum, rate)
VALUES
(1,0.00,3249.99,135.00),
(1,3250.00,3749.99,157.50),
(1,3750.00,4249.99,180.00),
(1,4250.00,4749.99,202.50),
(1,4750.00,5249.99,225.00),
(1,5250.00,5749.99,247.50),
(1,5750.00,6249.99,270.00),
(1,6250.00,6749.99,292.50),
(1,6750.00,7249.99,315.00),
(1,7250.00,7749.99,337.50),
(1,7750.00,8249.99,360.00),
(1,8250.00,8749.99,382.50),
(1,8750.00,9249.99,405.00),
(1,9250.00,9749.99,427.50),
(1,9750.00,10249.99,450.00),
(1,10250.00,10749.99,472.50),
(1,10750.00,11249.99,495.00),
(1,11250.00,11749.99,517.50),
(1,11750.00,12249.99,540.00),
(1,12250.00,12749.99,562.50),
(1,12750.00,13249.99,585.00),
(1,13250.00,13749.99,607.50),
(1,13750.00,14249.99,630.00),
(1,14250.00,14749.99,652.50),
(1,14750.00,15249.99,675.00),
(1,15250.00,15749.99,697.50),
(1,15750.00,16249.99,720.00),
(1,16250.00,16749.99,742.50),
(1,16750.00,17249.99,765.00),
(1,17250.00,17749.99,787.50),
(1,17750.00,18249.99,810.00),
(1,18250.00,18749.99,832.50),
(1,18750.00,19249.99,855.00),
(1,19250.00,19749.99,877.50),
(1,19750.00,20249.99,900.00),
(1,20250.00,20749.99,922.50),
(1,20750.00,21249.99,945.00),
(1,21250.00,21749.99,967.50),
(1,21750.00,22249.99,990.00),
(1,22250.00,22749.99,1012.50),
(1,22750.00,23249.99,1035.00),
(1,23250.00,23749.99,1057.50),
(1,23750.00,24249.99,1080.00),
(1,24250.00,24749.99,1102.50),
(1,24750.00,999999.99,1125.00);

INSERT INTO bracket
(statutory_id, minimum, maximum, rate)
VALUES
(2,10000.00,10000.00,300.00),
(2,10000.01,59999.99,0.03),
(2,60000.00,999999.99,1800.00);

INSERT INTO bracket
(statutory_id, minimum, maximum, rate)
VALUES
(3,1000.00,1500.00,0.01),
(3,1500.01,999999.99,0.02);

INSERT INTO bracket
(statutory_id, minimum, maximum, rate)
VALUES
(4,0.00,20832.99,0.00),
(4,20833.00,33332.99,0.20),
(4,33333.00,66666.99,0.25),
(4,66667.00,166666.99,0.30),
(4,166667.00,666666.99,0.32),
(4,666667.00,999999999.99,0.35);

CREATE TABLE pag_ibig_contribution LIKE bracket;
INSERT INTO pag_ibig_contribution
VALUES ();
SELECT * FROM pag_ibig_contribution;

CREATE TABLE statutory_deductions (
    statutory_deduction_id INT PRIMARY KEY,
    deduction_id INT,
    statutory_id INT,

    CONSTRAINT fk_statutory_deduction_deduction
        FOREIGN KEY (deduction_id)
        REFERENCES deductions(deduction_id),

    CONSTRAINT fk_statutory_deduction_statutory
        FOREIGN KEY (statutory_id)
        REFERENCES statutory(statutory_id)
);

CREATE TABLE role_permissions (
	role_id_permissions_id INT PRIMARY KEY,
    role_id INT,
    permissions_id INT,
    
    CONSTRAINT fk_role_role_permissions
    FOREIGN KEY (role_id)
    REFERENCES role (role_id),
    
    CONSTRAINT fk_permissions_role_permissions
    FOREIGN KEY (permissions_id)
    REFERENCES permissions (permissions_id)
);

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY
    building VARCHAR(255) NOT NULL,
    street VARCHAR(50) NOT NULL,
    barangay VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL, 
    province VARCHAR(50) NOT NULL, 
    zip_code INT NOT NULL
);

CREATE TABLE status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    status_name ENUM(
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

CREATE TABLE pay_period (
    pay_period_id INT AUTO_INCREMENT PRIMARY KEY,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    period_label VARCHAR(15) NULL
);

CREATE TABLE benefit_type (
    benefit_type_id INT AUTO_INCREMENT PRIMARY KEY,
    benefit_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

INSERT INTO benefit_type
(benefit_type, amount)
VALUES
('Rice Subsidy', 1500.00),
('Phone Allowance', 1000.00),
('Clothing Allowance', 1000.00);

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

CREATE TABLE payroll_benefits (
    payroll_benefit_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    benefit_id INT,

    CONSTRAINT fk_payroll_benefits_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id),

    CONSTRAINT fk_payroll_benefits_benefit
        FOREIGN KEY (benefit_id)
        REFERENCES benefits(benefit_id)
);

CREATE TABLE statutory (
    statutory_id INT AUTO_INCREMENT PRIMARY KEY,
    bracket_id INT,
    payroll_id INT,
    deduction_type ENUM(
        'SSS',
        'PHILHEALTH',
        'PAGIBIG',
        'WITHHOLDING_TAX'
    ) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE deductions (
    deduction_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    pay_period_id INT,
    payroll_id INT,
    statutory_id INT,
    amount DECIMAL(10,2),

    CONSTRAINT fk_deductions_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id),

    CONSTRAINT fk_deductions_pay_period
        FOREIGN KEY (pay_period_id)
        REFERENCES pay_period(pay_period_id),
);

CREATE TABLE payroll_deductions (
    payroll_id_deductions_id INT AUTO_INCREMENT PRIMARY KEY,
    payroll_id INT,
    deduction_id INT,

    CONSTRAINT fk_payroll_deductions_payroll
    FOREIGN KEY (payroll_id)
    REFERENCES payroll(payroll_id),

    CONSTRAINT fk_payroll_deductions_deduction
    FOREIGN KEY (deduction_id)
    REFERENCES deductions(deduction_id)
);

CREATE TABLE statutory_deductions (
    statutory_deduction_id INT AUTO_INCREMENT PRIMARY KEY,
    deduction_id INT,
    statutory_id INT,

    CONSTRAINT fk_statutory_deductions_deduction
        FOREIGN KEY (deduction_id)
        REFERENCES deductions(deduction_id),

    CONSTRAINT fk_statutory_deductions_statutory
        FOREIGN KEY (statutory_id)
        REFERENCES statutory(statutory_id)
);
