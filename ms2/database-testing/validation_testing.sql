USE payrolldb_motorph;

-- NULLABILITY
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Testing 'department' Table
INSERT INTO department (department_id, department_name) 
VALUES (NULL, NULL);

-- 2. Testing 'position' Table
INSERT INTO position (position_id, department_id, position_name, description, hourly_rate) 
VALUES (NULL, NULL, NULL, NULL, NULL);

-- 3. Testing 'role' Table
INSERT INTO role (role_id, role_name, is_admin) 
VALUES (NULL, NULL, NULL);

-- 4. Testing 'permissions' Table
INSERT INTO permissions (permissions_id, access, record_type) 
VALUES (NULL, NULL, NULL);

-- 5. Testing 'leave_status' Table
INSERT INTO leave_status (leave_status_id, status_name) 
VALUES (NULL, NULL);

-- 6. Testing 'leave_type' Table
INSERT INTO leave_type (leave_type_id, leave_name) 
VALUES (NULL, NULL);

-- 7. Testing 'pay_period' Table
INSERT INTO pay_period (pay_period_id, period_start, period_end, period_label) 
VALUES (NULL, NULL, NULL, NULL);

-- 8. Testing 'benefit_type' Table
INSERT INTO benefit_type (benefit_type_id, benefit_type, amount) 
VALUES (NULL, NULL, NULL);

-- 9. Testing 'address' Table
INSERT INTO address (address_id, building, street, barangay, city, province, zip_code) 
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- 10. Testing 'government_info' Table
INSERT INTO government_info (government_info_id, sss_number, phil_health_number, tin_number, pag_ibig_number) 
VALUES (NULL, NULL, NULL, NULL, NULL);

-- 11. Testing 'employee' Table
INSERT INTO employee (employee_id, supervisor_id, department_id, pay_period_id, benefit_type_id, role_id, position_id, address_id, government_info_id, first_name, last_name) 
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- 12. Testing 'attendance' Table
INSERT INTO attendance (attendance_id, employee_id, date, time_in, time_out, total_regular_hours) 
VALUES (NULL, NULL, NULL, NULL, NULL, NULL);

-- 13. Testing 'employee_credentials' Table
INSERT INTO employee_credentials (emp_credential_id, employee_id, username, password_hash) 
VALUES (NULL, NULL, NULL, NULL);

-- 14. Testing 'employee_role' Table
INSERT INTO employee_role (emp_credential_id_role_id, emp_credential_id, role_id) 
VALUES (NULL, NULL, NULL);

-- 15. Testing 'overtime' Table
INSERT INTO overtime (overtime_id, employee_id, supervisor_id, attendance_id, overtime_hours, approval_status) 
VALUES (NULL, NULL, NULL, NULL, NULL, NULL);

-- 16. Testing 'leave_request' Table
INSERT INTO leave_request (leave_request_id, leave_type_id, employee_id, leave_status_id, date_start, date_end, is_paid, approver_name, leave_message) 
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- 17. Testing 'benefits' Table
INSERT INTO benefits (benefit_id, employee_id, benefit_type_id) 
VALUES (NULL, NULL, NULL);

-- 18. Testing 'deductions' Table
INSERT INTO deductions (deduction_id, employee_id, pay_period_id, amount) 
VALUES (NULL, NULL, NULL, NULL);

-- 19. Testing 'payroll' Table
INSERT INTO payroll (payroll_id, employee_id, pay_period_id, net_pay, gross_pay) 
VALUES (NULL, NULL, NULL, NULL, NULL);

-- 20. Testing 'status' Table
INSERT INTO status (status_id, employee_id, status_name) 
VALUES (NULL, NULL, NULL);

-- 21. Testing 'statutory' Table
INSERT INTO statutory (statutory_id, payroll_id, deduction_type, amount) 
VALUES (NULL, NULL, NULL, NULL);

-- 22. Testing 'bracket' Table
INSERT INTO bracket (bracket_id, statutory_id, minimum, maximum, rate) 
VALUES (NULL, NULL, NULL, NULL, NULL);

-- 23. Testing 'statutory_deductions' Table
INSERT INTO statutory_deductions (statutory_deduction_id, deduction_id, statutory_id) 
VALUES (NULL, NULL, NULL);

-- 24. Testing 'role_permissions' Table
INSERT INTO role_permissions (role_id_permissions_id, role_id, permissions_id) 
VALUES (NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;

-- 2. Testing 'position' Table
INSERT INTO position (position_id, department_id, position_name, description, hourly_rate) 
VALUES (NULL, NULL, NULL, NULL, NULL);

-- 3. Testing 'role' Table
INSERT INTO role (role_id, role_name, is_admin) 
VALUES (NULL, NULL, NULL);

-- 4. Testing 'permissions' Table
INSERT INTO permissions (permissions_id, access, record_type) 
VALUES (NULL, NULL, NULL);

-- 5. Testing 'leave_status' Table
INSERT INTO leave_status (leave_status_id, status_name) 
VALUES (NULL, NULL);

-- 6. Testing 'leave_type' Table
INSERT INTO leave_type (leave_type_id, leave_name) 
VALUES (NULL, NULL);

-- 7. Testing 'pay_period' Table
INSERT INTO pay_period (pay_period_id, period_start, period_end, period_label) 
VALUES (NULL, NULL, NULL, NULL);

-- 8. Testing 'benefit_type' Table
INSERT INTO benefit_type (benefit_type_id, benefit_type, amount) 
VALUES (NULL, NULL, NULL);

-- 9. Testing 'address' Table
INSERT INTO address (address_id, building, street, barangay, city, province, zip_code) 
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- 10. Testing 'government_info' Table
INSERT INTO government_info (government_info_id, sss_number, phil_health_number, tin_number, pag_ibig_number) 
VALUES (NULL, NULL, NULL, NULL, NULL);

-- 11. Testing 'employee' Table
INSERT INTO employee (employee_id, supervisor_id, department_id, pay_period_id, benefit_type_id, role_id, position_id, address_id, government_info_id, first_name, last_name) 
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- 12. Testing 'attendance' Table
INSERT INTO attendance (attendance_id, employee_id, date, time_in, time_out, total_regular_hours) 
VALUES (NULL, NULL, NULL, NULL, NULL, NULL);

-- 13. Testing 'employee_credentials' Table
INSERT INTO employee_credentials (emp_credential_id, employee_id, username, password_hash) 
VALUES (NULL, NULL, NULL, NULL);

-- 14. Testing 'employee_role' Table
INSERT INTO employee_role (emp_credential_id_role_id, emp_credential_id, role_id) 
VALUES (NULL, NULL, NULL);

-- 15. Testing 'overtime' Table
INSERT INTO overtime (overtime_id, employee_id, supervisor_id, attendance_id, overtime_hours, approval_status) 
VALUES (NULL, NULL, NULL, NULL, NULL, NULL);

-- 16. Testing 'leave_request' Table
INSERT INTO leave_request (leave_request_id, leave_type_id, employee_id, leave_status_id, date_start, date_end, is_paid, approver_name, leave_message) 
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- 17. Testing 'benefits' Table
INSERT INTO benefits (benefit_id, employee_id, benefit_type_id) 
VALUES (NULL, NULL, NULL);

-- 18. Testing 'deductions' Table
INSERT INTO deductions (deduction_id, employee_id, pay_period_id, amount) 
VALUES (NULL, NULL, NULL, NULL);

-- 19. Testing 'payroll' Table
INSERT INTO payroll (payroll_id, employee_id, pay_period_id, net_pay, gross_pay) 
VALUES (NULL, NULL, NULL, NULL, NULL);

-- 20. Testing 'status' Table
INSERT INTO status (status_id, employee_id, status_name) 
VALUES (NULL, NULL, NULL);

-- 21. Testing 'statutory' Table
INSERT INTO statutory (statutory_id, payroll_id, deduction_type, amount) 
VALUES (NULL, NULL, NULL, NULL);

-- 22. Testing 'bracket' Table
INSERT INTO bracket (bracket_id, statutory_id, minimum, maximum, rate) 
VALUES (NULL, NULL, NULL, NULL, NULL);

-- 23. Testing 'statutory_deductions' Table
INSERT INTO statutory_deductions (statutory_deduction_id, deduction_id, statutory_id) 
VALUES (NULL, NULL, NULL);

-- 24. Testing 'role_permissions' Table
INSERT INTO role_permissions (role_id_permissions_id, role_id, permissions_id) 
VALUES (NULL, NULL, NULL);

-- DATA TYPE MISMATCH

-- 1. Testing 'department' Table (Text into AUTO_INCREMENT INT)
INSERT INTO department (department_id, department_name) 
VALUES ('NotAnInteger', 'Executive');

-- 2. Testing 'position' Table (Text into DECIMAL)
INSERT INTO position (department_id, position_name, description, hourly_rate) 
VALUES (1, 'Manager', 'Description Text', 'FiveHundredDollars');

-- 3. Testing 'role' Table (Malformed String into BOOLEAN)
INSERT INTO role (role_name, is_admin) 
VALUES ('Administrator', 'MaybeTrue');

-- 4. Testing 'permissions' Table (Invalid Set Elements into SET)
INSERT INTO permissions (access, record_type) 
VALUES ('EXECUTE,DROP', 'InvalidTableType');

-- 5. Testing 'leave_status' Table (Large Array into VARCHAR)
INSERT INTO leave_status (status_name) 
VALUES (123456789.99);

-- 6. Testing 'pay_period' Table (Invalid String/Format into DATE)
INSERT INTO pay_period (period_start, period_end, period_label) 
VALUES ('January Second 2026', '2026-13-45', 'Period 1');

-- 7. Testing 'benefit_type' Table (Object Literal Representation into DECIMAL)
INSERT INTO benefit_type (benefit_type, amount) 
VALUES ('Rice Subsidy', '[Amount: 1500]');

-- 8. Testing 'address' Table (INT Zip Code into INT Zip Code)
INSERT INTO address (building, street, barangay, city, province, zip_code) 
VALUES ('Building A', 'Main St', 'Poblacion', 'Manila', 'Metro Manila', 'A1B 2C3');

-- 9. Testing 'government_info' Table (Text Strings into BIGINT)
INSERT INTO government_info (sss_number, phil_health_number, tin_number, pag_ibig_number) 
VALUES ('SSS-NUMBER-STR', 'PHILHEALTH-STR', 'TIN-NUMBER-STR', 'PAGIBIG-STR');

-- 10. Testing 'employee' Table (Text Hash into Numerical Foreign Key IDs)
INSERT INTO employee (employee_id, supervisor_id, department_id, first_name, last_name) 
VALUES ('EMP10001', 'SUPERVISOR_ID', 'DEPT_ID', 'Manuel', 'Garcia');

-- 11. Testing 'attendance' Table (Invalid String Text into TIME)
INSERT INTO attendance (employee_id, date, time_in, time_out, total_regular_hours) 
VALUES (10015, '2026-01-02', 'Eight O Clock AM', 'Five PM', 'Eight Hours');

-- 12. Testing 'overtime' Table (Invalid Custom String into ENUM)
INSERT INTO overtime (employee_id, overtime_hours, approval_status) 
VALUES (10015, 2, 'HighlyApproved');

-- 13. Testing 'leave_request' Table (Text String representation into BOOLEAN)
INSERT INTO leave_request (leave_type_id, employee_id, leave_status_id, date_start, date_end, is_paid, approver_name) 
VALUES (1, 10022, 3, '2026-06-03', '2026-06-06', 'Not Paid Status', 'Mata Christian');

-- 14. Testing 'deductions' Table (Special Characters/Currency Signs into DECIMAL)
INSERT INTO deductions (employee_id, pay_period_id, amount) 
VALUES (10001, 1, '₱1,000.00!!');

-- 15. Testing 'status' Table (Out-of-Bounds Unmapped Value into ENUM)
INSERT INTO status (employee_id, status_name) 
VALUES (10001, 'Freelancer');

-- 16. Testing 'statutory' Table (Unmapped Category Value into ENUM)
INSERT INTO statutory (payroll_id, deduction_type, amount) 
VALUES (1, 'Health Insurance Deductible', 2500.00);

-- 17. Testing 'bracket' Table (Nested Array Text Layout into DECIMAL Rates)
INSERT INTO bracket (statutory_id, minimum, maximum, rate) 
VALUES (1, '0.00 to 3250.00', '3250.00+', '3%');


-- REFERENTIAL INTEGRITY
-- 1. Testing 'position' Table (Non-existent department_id)
INSERT INTO position (department_id, position_name, description, hourly_rate) 
VALUES (999999, 'Phantom Executive Role', 'Should break FK constraint', 150.00);

-- 2. Testing 'employee' Table (Non-existent department, pay_period, benefit, role, position, address, government_info, supervisor)
INSERT INTO employee (employee_id, supervisor_id, department_id, pay_period_id, benefit_type_id, role_id, position_id, address_id, government_info_id, first_name, last_name) 
VALUES (20001, 999999, 999999, 999999, 999999, 999999, 999999, 999999, 999999, 'Test', 'User');

-- 3. Testing 'attendance' Table (Non-existent employee_id)
INSERT INTO attendance (employee_id, date, time_in, time_out, total_regular_hours) 
VALUES (999999, '2026-01-02', '08:00:00', '17:00:00', 8);

-- 4. Testing 'employee_credentials' Table (Non-existent employee_id)
INSERT INTO employee_credentials (employee_id, username, password_hash) 
VALUES (999999, 'invalid_user', 'hash_string');

-- 5. Testing 'employee_role' Table (Non-existent credential_id or role_id)
INSERT INTO employee_role (emp_credential_id, role_id) 
VALUES (999999, 999999);

-- 6. Testing 'overtime' Table (Non-existent employee, supervisor, or attendance context)
INSERT INTO overtime (employee_id, supervisor_id, attendance_id, overtime_hours, approval_status) 
VALUES (999999, 999999, 999999, 2, 'Pending');

-- 7. Testing 'leave_request' Table (Non-existent leave_type, employee, or leave_status)
INSERT INTO leave_request (leave_type_id, employee_id, leave_status_id, date_start, date_end, is_paid, approver_name, leave_message) 
VALUES (999999, 999999, 999999, '2026-07-01', '2026-07-05', FALSE, 'System Testing', 'Fails');

-- 8. Testing 'benefits' Table (Non-existent employee or benefit_type)
INSERT INTO benefits (employee_id, benefit_type_id) 
VALUES (999999, 999999);

-- 9. Testing 'deductions' Table (Non-existent employee or pay_period)
INSERT INTO deductions (employee_id, pay_period_id, amount) 
VALUES (999999, 999999, 500.00);

-- 10. Testing 'payroll' Table (Non-existent employee or pay_period)
INSERT INTO payroll (employee_id, pay_period_id, net_pay, gross_pay) 
VALUES (999999, 999999, 1000.00, 1200.00);

-- 11. Testing 'status' Table (Non-existent employee)
INSERT INTO status (employee_id, status_name) 
VALUES (999999, 'Regular');

-- 12. Testing 'statutory' Table (Non-existent payroll record)
INSERT INTO statutory (payroll_id, deduction_type, amount) 
VALUES (999999, 'SSS', 150.00);

-- 13. Testing 'bracket' Table (Non-existent statutory reference)
INSERT INTO bracket (statutory_id, minimum, maximum, rate) 
VALUES (999999, 0.00, 5000.00, 0.0400);

-- 14. Testing 'statutory_deductions' Table (Non-existent deduction_id or statutory_id)
INSERT INTO statutory_deductions (deduction_id, statutory_id) 
VALUES (999999, 999999);

-- 15. Testing 'role_permissions' Table (Non-existent role_id or permissions_id)
INSERT INTO role_permissions (role_id, permissions_id) 
VALUES (999999, 999999);

SET FOREIGN_KEY_CHECKS = 1;