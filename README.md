Prerequisites:
---------------
- MySQL Workbench 8.0 CE
Version 8.0.44 (MySQL Community Server - GPL)
- Create a Schema (preferably name it as **motorph_payroll**)

Execution Order:
---------------
1. script.sql (in the Ninja Duo Folder, it is named as:  NinjaDuo_Payroll System Database.sql)
2. employee_payslip.sql / employee_payroll_summary.sql, order doesn't matter - by preference and/or need.
3. views.sql to show the output of employee_payslip.sql and employee_payroll_summary.sql.
4. i-test-case-A.sql which ADDS new employees to the database.
5. i-test-case-B.sql which UPDATES employees' information.
6. i-test-case-C.sql which DELETES employees from the database.
7. (A) employee_id_uniqueness.sql, (B) check_null_values.sql, and validation_testing.sql are all optional since these are for testing purposes.
