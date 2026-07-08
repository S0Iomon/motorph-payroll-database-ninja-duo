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
    (SUM(BENEFIT_TYPE.amount/2)) AS amount
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
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (19750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (20250 / 2) THEN (1000 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (20250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (20750 / 2) THEN (1025 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (20750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (21250 / 2) THEN (1050 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (21250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (21750 / 2) THEN (1075 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (21750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (22250 / 2) THEN (1100 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (22250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (22750 / 2) THEN (1125 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (22750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (23250 / 2) THEN (1150 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (23250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (23750 / 2) THEN (1175 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (23750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (24250 / 2) THEN (1200 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (24250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (24750 / 2) THEN (1225 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (24750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (25250 / 2) THEN (1250 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (25250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (25750 / 2) THEN (1275 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (25750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (26250 / 2) THEN (1300 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (26250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (26750 / 2) THEN (1325 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (26750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (27250 / 2) THEN (1350 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (27250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (27750 / 2) THEN (1375 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (27750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (28250 / 2) THEN (1400 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (28250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (28750 / 2) THEN (1425 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (28750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (29250 / 2) THEN (1450 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (29250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (29750 / 2) THEN (1475 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (29750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (30250 / 2) THEN (1500 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (30250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (30750 / 2) THEN (1525 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (30750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (31250 / 2) THEN (1550 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (31250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (31750 / 2) THEN (1575 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (31750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (32250 / 2) THEN (1600 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (32250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (32750 / 2) THEN (1625 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (32750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (33250 / 2) THEN (1650 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (33250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (33750 / 2) THEN (1675 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (33750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (34250 / 2) THEN (1700 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (34250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (34750 / 2) THEN (1725 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (34750 / 2) THEN (1750 / 2)
            ELSE 0
        END AS SSS,
        
        -- PhilHealth Calculation
        CASE 
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) <= (10000 / 2) THEN (250 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (10000.01 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) <= (99999.99 / 2) THEN (((CEIL(POSITION.hourly_rate * 8 * 21) / 2) * 0.05) / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (100000 / 2) THEN (2500 / 2)
            ELSE 0
        END AS PhilHealth,
        
        -- PagIbig Calculation
        CASE 
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) <= (1500 / 2) THEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) * 0.01
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) > (1500 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (10000 / 2) THEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) * 0.02
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (10000 / 2) THEN (200 / 2)
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
			WHEN ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= (20833.34/2) 
			 AND ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) <= (33333.33/2)
				 THEN (((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - (20833.33/2)) * 0.15)
				 
			WHEN ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= (33333.34/2) 
			 AND ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) <= (66666.67/2) 
				 THEN ((((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - (33333.33/2)) * 0.2) + (1875/2))
				 
			WHEN ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= (66666.68/2) 
			 AND ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) <= (166666.67/2) 
				 THEN ((((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - (66666.67/2)) * 0.25) + (8541.67/2))
				 
			WHEN ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= (166666.68/2)
			 AND ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) <= (666666.67/2)
				 THEN ((((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - (166666.67/2)) * 0.3) + (33541.67/2))
				 
			WHEN ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= (666666.68/2)
				 THEN ((((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - (666666.68/2)) * 0.35) + (183541.67/2))
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
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (19750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (20250 / 2) THEN (1000 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (20250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (20750 / 2) THEN (1025 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (20750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (21250 / 2) THEN (1050 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (21250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (21750 / 2) THEN (1075 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (21750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (22250 / 2) THEN (1100 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (22250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (22750 / 2) THEN (1125 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (22750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (23250 / 2) THEN (1150 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (23250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (23750 / 2) THEN (1175 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (23750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (24250 / 2) THEN (1200 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (24250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (24750 / 2) THEN (1225 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (24750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (25250 / 2) THEN (1250 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (25250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (25750 / 2) THEN (1275 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (25750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (26250 / 2) THEN (1300 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (26250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (26750 / 2) THEN (1325 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (26750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (27250 / 2) THEN (1350 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (27250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (27750 / 2) THEN (1375 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (27750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (28250 / 2) THEN (1400 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (28250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (28750 / 2) THEN (1425 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (28750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (29250 / 2) THEN (1450 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (29250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (29750 / 2) THEN (1475 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (29750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (30250 / 2) THEN (1500 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (30250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (30750 / 2) THEN (1525 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (30750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (31250 / 2) THEN (1550 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (31250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (31750 / 2) THEN (1575 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (31750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (32250 / 2) THEN (1600 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (32250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (32750 / 2) THEN (1625 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (32750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (33250 / 2) THEN (1650 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (33250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (33750 / 2) THEN (1675 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (33750 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (34250 / 2) THEN (1700 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (34250 / 2) AND (CEIL(POSITION.hourly_rate * 8 * 21) / 2) < (34750 / 2) THEN (1725 / 2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21) / 2) >= (34750 / 2) THEN (1750 / 2)
            ELSE 0
        END AS SSS,
        
        -- PhilHealth Calculation
        CASE 
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)/2) <= (8000/2) THEN (500/2)
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)/2) > (8000/2) THEN (CEIL(POSITION.hourly_rate * 8 * 21)/2) * 0.05 / 2
            ELSE 0
        END AS PhilHealth,
        
        -- PagIbig Calculation
        CASE 
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)/2) <= (1500/2) THEN (CEIL(POSITION.hourly_rate * 8 * 21)/2) * 0.01
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)/2) > (1500/2) AND (CEIL(POSITION.hourly_rate * 8 * 21)) < (10000/2) THEN (CEIL(POSITION.hourly_rate * 8 * 21)/2) * 0.02
            WHEN (CEIL(POSITION.hourly_rate * 8 * 21)/2) >= (10000/2) THEN (200/2)
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
			WHEN ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= (20833.34/2) 
			 AND ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) <= (33333.33/2)
				 THEN (((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - (20833.33/2)) * 0.15)
				 
			WHEN ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= (33333.34/2) 
			 AND ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) <= (66666.67/2) 
				 THEN ((((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - (33333.33/2)) * 0.2) + (1875/2))
				 
			WHEN ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) >= (66666.68/2) 
			 AND ((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0))) <= (166666.67/2) 
				 THEN ((((MonthlySalary/2) - (COALESCE(SSS, 0) + COALESCE(PhilHealth, 0) + COALESCE(PagIbig, 0)) - (66666.67/2)) * 0.25) + (8541.67/2))
				 
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
		SUM(BENEFIT_TYPE.amount/2) AS totalBenefits
	FROM BENEFITS
	INNER JOIN BENEFIT_TYPE ON BENEFITS.benefit_type_id = BENEFIT_TYPE.benefit_type_id  
	WHERE BENEFITS.employee_id = 10015
	GROUP BY BENEFIT_TYPE.benefit_type WITH ROLLUP
),

Summary AS (
	SELECT 
		EMPLOYEE.employee_id,
		(CEIL(POSITION.hourly_rate * 8 * 21) / 2) AS grossIncome
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

