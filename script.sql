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

CREATE TABLE leave_type (
    leave_type_id INT PRIMARY KEY,
    leave_name VARCHAR(50) NOT NULL
);

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
        REFERENCES position (position_id)
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
