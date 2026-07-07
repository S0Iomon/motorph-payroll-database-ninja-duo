SELECT 
	employee_id,
    first_name,
    last_name, 
    status_name,
    ROUND(CAST(hourly_rate AS DECIMAL(15,6)) * 8 * 21, 0) AS gross_salary
    
    FROM employee
    INNER JOIN status ON employee.status_id = status.status_id
    INNER JOIN position ON employee.position_id = position.position_id
WHERE employee_id IN (10032, 10033, 10034, 10037);
    
/*10032*/
UPDATE position
	SET hourly_rate = 136.904762
WHERE position_id = 16;

/*10033*/
UPDATE position
	SET hourly_rate = 148.81
WHERE position_id = 10;

/*10034*/
UPDATE position
	SET hourly_rate = 136.904762
WHERE position_id = 17;

/*10037*/
UPDATE position
	SET hourly_rate = 148.81
WHERE position_id = 18;

SELECT 
	employee_id,
    first_name,
    last_name, 
    status_name,
	ROUND(CAST(hourly_rate AS DECIMAL(15,6)) * 8 * 21, 0) AS gross_salary
    
    FROM employee
    INNER JOIN status ON employee.status_id = status.status_id
    INNER JOIN position ON employee.position_id = position.position_id
    
WHERE employee_id IN (10032, 10033, 10034, 10037);
    