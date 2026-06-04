CREATE TABLE department (
	department_id INT PRIMARY KEY,
	department_name VARCHAR(50) NOT NULL
);

CREATE TABLE position (
    position_id INT PRIMARY KEY,
    department_id INT,
    position_name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NULL,
    hourly_rate DECIMAL(10, 2) NOT NULL,
    
    CONSTRAINT fk_position_department
    FOREIGN KEY (department_id)
	REFERENCES department (department_id)
);

CREATE TABLE role (
	role_id INT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL,
    is_admin BOOLEAN
);

CREATE TABLE permissions (
	permissions_id INT PRIMARY KEY,
    access VARCHAR(50) NOT NULL,
    record_type VARCHAR (50) NOT NULL,
    CHECK (record_type IN ('Employee','Payroll','Attendance'))
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
    amount DECIMAL(10, 2)
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
        REFERENCES employee (employee_id),

    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES department (department_id),

    CONSTRAINT fk_employee_pay_period
        FOREIGN KEY (pay_period_id)
        REFERENCES pay_period (pay_period_id),
        
    CONSTRAINT fk_employee_benefits
        FOREIGN KEY (benefit_id)
        REFERENCES benefits (benefit_id),

    CONSTRAINT fk_employee_role
        FOREIGN KEY (role_id)
        REFERENCES role(role_id),

    CONSTRAINT fk_employee_position
        FOREIGN KEY (position_id)
        REFERENCES position (position_id)
);
CREATE TABLE attendance (
	attendance_id INT PRIMARY KEY,
    employee_id INT,
    date DATE NOT NULL,
    time_in TIME NOT NULL,
    time_out TIME NOT NULL,
    total_regular_hours INT,
    
    CONSTRAINT fk_employee_attendance
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id)
);

CREATE TABLE employee_credentials (
	emp_credential_id INT PRIMARY KEY,
    employee_id INT,
    username VARCHAR(50) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    
    CONSTRAINT fk_employee_employee_credentials
    FOREIGN KEY (employee_id)
	REFERENCES employee (employee_id)
);

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
	overtime_id INT PRIMARY KEY,
    employee_id INT,
    supervisor_id INT,
    attendance_id INT,
    overtime_hours INT NOT NULL,
    approval_status VARCHAR(20)
    CHECK (approval_status IN ('pending', 'approved', 'denied')),
    
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
    amount DECIMAL(10, 2), 
    
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
    benefits_id INT,

    CONSTRAINT fk_payroll_benefits_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee (employee_id),

    CONSTRAINT fk_payroll_benefits_benefits_id
        FOREIGN KEY (benefit_type_id)
        REFERENCES benefits (benefits_id)
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
    bracket_id INT, 
    payroll_id INT,
    deduction_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2),

	CONSTRAINT fk_statutory_bracket
		FOREIGN KEY (bracket_id)
		REFERENCES bracket (bracket_id), 
        
    CONSTRAINT fk_statutory_payroll
        FOREIGN KEY (payroll_id)
        REFERENCES payroll (payroll_id)
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

CREATE TABLE statutory_deductions (
    statutory_id_deduction_id INT PRIMARY KEY,
    deduction_id INT,
    statutory_id INT,

    CONSTRAINT fk_statutory_deductions_deduction
        FOREIGN KEY (deduction_id)
        REFERENCES deductions (deduction_id),

    CONSTRAINT fk_statutory_deductions_statutory
        FOREIGN KEY (statutory_id)
        REFERENCES statutory (statutory_id)
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
