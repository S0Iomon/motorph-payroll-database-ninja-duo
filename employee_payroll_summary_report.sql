USE motorph_payroll;
DROP VIEW IF EXISTS employee_payroll_summary;
CREATE VIEW employee_payroll_summary AS

WITH PayrollCalculations AS (
    SELECT 
        EMPLOYEE.employee_id,
        (CEIL(POSITION.hourly_rate * 8 * 21)) AS MonthlySalary,
        -- SSS Bracket Calculation
        CASE 
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)) >= 19750 AND (CEIL(POSITION.hourly_rate * 8 * 21)) < 20250 THEN 1000
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)) >= 20250 AND (CEIL(POSITION.hourly_rate * 8 * 21)) < 20750 THEN 1025
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)) >= 24750 AND (CEIL(POSITION.hourly_rate * 8 * 21)) < 25250 THEN 1250
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)) >= 29750 AND (CEIL(POSITION.hourly_rate * 8 * 21)) < 30250 THEN 1500
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)) >= 34750 THEN 1750
            ELSE 0
        END AS SSS,
        
        -- PhilHealth Calculation
        CASE 
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)) <= 8000 THEN 500
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)) > 8000 THEN (CEIL(POSITION.hourly_rate * 8 * 21)) * 0.05 / 2
            ELSE 0
        END AS PhilHealth,
        
        -- PagIbig Calculation
        CASE 
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)) <= 1500 THEN (CEIL(POSITION.hourly_rate * 8 * 21)) * 0.01
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)) > 1500 AND (CEIL(POSITION.hourly_rate * 8 * 21)) < 10000 THEN (CEIL(POSITION.hourly_rate * 8 * 21)) * 0.02
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)) >= 10000 THEN 200
            ELSE 0
        END AS PagIbig
        
    FROM EMPLOYEE
    INNER JOIN POSITION ON EMPLOYEE.position_id = POSITION.position_id
    GROUP BY EMPLOYEE.employee_id, POSITION.hourly_rate
),

Deductions AS (
	SELECT 
		employee_id,
		MonthlySalary,
		-- Safely force 0 if any value comes back null, avoiding math breaks
		(COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) AS TotalDeductions,
		SSS,
		PhilHealth,
		PagIbig,
		
		-- Using the raw addition directly in the tax calculation to bypass alias issues
		CASE
			WHEN (MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= 20833.34 
			 AND (MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) <= 33333.33 
				 THEN ((MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - 20833.33) * 0.15)
				 
			WHEN (MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= 33333.34 
			 AND (MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) <= 66666.67 
				 THEN (((MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - 33333.33) * 0.2) + 1875)
				 
			WHEN (MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= 66666.68 
			 AND (MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) <= 166666.67 
				 THEN (((MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - 66666.67) * 0.25) + 8541.67)
				 
			WHEN (MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= 166666.68 
			 AND (MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) <= 666666.67 
				 THEN (((MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - 166666.67) * 0.3) + 33541.67)
				 
			WHEN (MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= 666666.68 
				 THEN (((MonthlySalary - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - 666666.68) * 0.35) + 183541.67)
			ELSE 0
		END AS WithholdingTax
	FROM PayrollCalculations
),

Summary AS (

SELECT
	employee.employee_id,
	CEIL(position.hourly_rate * 8 * 21) AS GrossIncome

	FROM employee

	JOIN position
	ON employee.position_id=position.position_id
	)

SELECT
	pay_period.period_start,
	pay_period.period_end,
    CURDATE() AS ReportDate,
	employee.employee_id AS EmployeeNumber,
	CONCAT(employee.last_name, ', ', employee.first_name) AS EmployeeName,
	position.position_name AS Position,
	department.department_name AS Department,
	summary.GrossIncome,
	government_info.sss_number,
	deductions.SSS,
	government_info.phil_health_number,
	deductions.PhilHealth,
	government_info.pag_ibig_number,
    deductions.PagIbig,
    government_info.tin_number,
	deductions.WithholdingTax,
	deductions.TotalDeductions
		+
		deductions.WithholdingTax AS TotalDeductions,

			summary.GrossIncome
			-
			(
			deductions.TotalDeductions
			+
			deductions.WithholdingTax
			) AS NetPay

FROM EMPLOYEE employee
INNER JOIN GOVERNMENT_INFO government_info
ON employee.government_info_id = government_info.government_info_id

INNER JOIN PAY_PERIOD pay_period
ON employee.pay_period_id = pay_period.pay_period_id

INNER JOIN POSITION position
ON employee.position_id = position.position_id

INNER JOIN DEPARTMENT department
ON employee.department_id = department.department_id

INNER JOIN Summary summary
ON employee.employee_id = summary.employee_id

INNER JOIN Deductions deductions
ON employee.employee_id = deductions.employee_id;