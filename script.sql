CREATE TABLE position (
    position_id INT PRIMARY KEY,
    department_id INT,
    position_name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NULL,
    hourly_rate DECIMAL(10 , 2) NOT NULL,
    
    CONSTRAINT fk_position_department
    FOREIGN KEY (department_id)
	REFERENCES department (department_id)
);

CREATE TABLE department (
	department_id INT PRIMARY KEY,
	department_name VARCHAR(50) NOT NULL
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
    REFERENCES deduction (deduction_id),    

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
