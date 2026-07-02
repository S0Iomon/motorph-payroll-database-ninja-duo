USE payrolldb_motorph;

DROP VIEW IF EXISTS Payslip_Employee_Details;
CREATE VIEW Payslip_Employee_Details AS
SELECT CONCAT(EMPLOYEE.employee_id, '-', PAY_PERIOD.period_end) AS payslipID, 
EMPLOYEE.employee_id AS employeeID, EMPLOYEE.last_name AS lastName, EMPLOYEE.first_name AS firstName, 
PAY_PERIOD.period_start AS periodStart, PAY_PERIOD.period_end AS periodEnd, 
POSITION.position_name AS employeePosition, 
DEPARTMENT.department_name AS department
FROM EMPLOYEE

INNER JOIN PAY_PERIOD ON EMPLOYEE.pay_period_id = PAY_PERIOD.pay_period_id
INNER JOIN POSITION ON EMPLOYEE.position_id = POSITION.position_id
INNER JOIN DEPARTMENT ON EMPLOYEE.department_id = DEPARTMENT.department_id

WHERE EMPLOYEE.employee_id = 10015;

DROP VIEW IF EXISTS Payslip_Earnings;
CREATE VIEW Payslip_Earnings AS
SELECT CEIL(POSITION.hourly_rate * 8 * 21) AS monthlySalary, 
(CEIL(POSITION.hourly_rate * 8 * 21) / 20) AS dailyRate,
COUNT(ATTENDANCE.date) AS daysWorked,
SUM(8 - ATTENDANCE.total_regular_hours) AS overtime,
(CEIL(POSITION.hourly_rate * 8 * 21) / 20) * COUNT(ATTENDANCE.date) AS grossIncome
FROM EMPLOYEE

INNER JOIN POSITION ON EMPLOYEE.position_id = POSITION.position_id
INNER JOIN ATTENDANCE ON EMPLOYEE.employee_id = ATTENDANCE.employee_id
INNER JOIN PAY_PERIOD ON EMPLOYEE.pay_period_id = PAY_PERIOD.pay_period_id

WHERE ATTENDANCE.date BETWEEN PAY_PERIOD.period_start AND PAY_PERIOD.period_end

GROUP BY EMPLOYEE.employee_id;

DROP VIEW IF EXISTS Payslip_Benefits;
CREATE VIEW Payslip_Benefits AS
SELECT 
    IFNULL(BENEFIT_TYPE.benefit_type, 'GRAND TOTAL') AS benefits, 
    SUM(BENEFIT_TYPE.amount) AS amount
FROM BENEFITS

    INNER JOIN BENEFIT_TYPE ON BENEFITS.benefit_type_id = BENEFIT_TYPE.benefit_type_id  
    WHERE BENEFITS.employee_id = 10015
    
GROUP BY BENEFIT_TYPE.benefit_type WITH ROLLUP;

DROP VIEW IF EXISTS Payslip_Deductions;
CREATE VIEW Payslip_Deductions AS
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
    WHERE EMPLOYEE.employee_id = 10015
    GROUP BY EMPLOYEE.employee_id
),

Deductions AS (
	SELECT 
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
)

SELECT 
	SSS, 
	PhilHealth, 
	PagIbig, 
	WithholdingTax, 
	(SSS + PhilHealth + PagIbig + WithholdingTax) AS TotalDeductions 
FROM Deductions;

DROP VIEW IF EXISTS Payslip_Summary;
CREATE VIEW Payslip_Summary AS
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
    WHERE EMPLOYEE.employee_id = 10015
    GROUP BY EMPLOYEE.employee_id
),

Deductions AS (
	SELECT 
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

BenefitsSummary AS (
	SELECT 
		IFNULL(BENEFIT_TYPE.benefit_type, 'GRAND TOTAL') AS benefitsLabel, 
		SUM(BENEFIT_TYPE.amount) AS totalBenefits
	FROM BENEFITS
	INNER JOIN BENEFIT_TYPE ON BENEFITS.benefit_type_id = BENEFIT_TYPE.benefit_type_id  
	WHERE BENEFITS.employee_id = 10015
	GROUP BY BENEFIT_TYPE.benefit_type WITH ROLLUP
),

Summary AS (
	SELECT 
		EMPLOYEE.employee_id,
		(CEIL(POSITION.hourly_rate * 8 * 21) / 20) * COUNT(ATTENDANCE.date) AS grossIncome
	FROM EMPLOYEE
	INNER JOIN POSITION ON EMPLOYEE.position_id = POSITION.position_id
	INNER JOIN ATTENDANCE ON EMPLOYEE.employee_id = ATTENDANCE.employee_id
	INNER JOIN PAY_PERIOD ON EMPLOYEE.pay_period_id = PAY_PERIOD.pay_period_id
	WHERE ATTENDANCE.date BETWEEN PAY_PERIOD.period_start AND PAY_PERIOD.period_end
	  AND EMPLOYEE.employee_id = 10015
	GROUP BY EMPLOYEE.employee_id, POSITION.hourly_rate
)



-- Unified Final Execution Statement
SELECT 
	s.grossIncome,
	b.totalBenefits,
	(d.TotalDeductions + d.WithholdingTax) AS aggregateDeductions,
	(s.grossIncome + b.totalBenefits - (d.TotalDeductions + d.WithholdingTax)) AS netTakeHome
FROM Summary s
CROSS JOIN Deductions d
INNER JOIN BenefitsSummary b ON b.benefitsLabel = 'GRAND TOTAL';

