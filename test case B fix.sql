INSERT INTO payroll
(employee_id, pay_period_id, net_pay, gross_pay)
VALUES
(10032, 1, 23000.00, 23000.00),
(10033, 1, 23000.00, 23000.00),
(10034, 1, 25000.00, 25000.00),
(10037, 1, 25000.00, 25000.00);

-- this is the validation code
SELECT
e.employee_id,
e.first_name,
e.last_name,
p.payroll_id,
p.gross_pay,
p.net_pay
FROM employee e
JOIN payroll p
ON e.employee_id = p.employee_id
WHERE e.employee_id IN (10032,10033,10034,10037)
ORDER BY e.employee_id;