SELECT 
	employee_id AS EmployeeID,
    last_name AS LastName, 
    first_name AS FirstName,
    status_name AS Status,
    CONCAT_WS(', ', NULLIF(city, ''), NULLIF(province, '')) AS Address,
    position_name AS Position,
    supervisor_id AS SupervisorID,
	ROUND(CAST(hourly_rate AS DECIMAL(15,6)) * 8 * 21, 0) AS GrossSalary,
    ROUND(ROUND(CAST(hourly_rate AS DECIMAL(15,6)) * 8 * 21, 0) / 2) AS NetSalary,
    ROUND(hourly_rate, 2) AS HourlyRate,
    tin_number AS TIN,
    sss_number AS SSS,
    phil_health_number AS PhilHealth, 
    pag_ibig_number AS PagIbig
    
    FROM employee
    INNER JOIN status ON employee.status_id = status.status_id
    INNER JOIN position ON employee.position_id = position.position_id
    INNER JOIN address ON employee.address_id = address.address_id
    INNER JOIN government_info ON employee.government_info_id = government_info.government_info_id
    
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
	employee_id AS EmployeeID,
    last_name AS LastName, 
    first_name AS FirstName,
    status_name AS Status,
    CONCAT_WS(', ', NULLIF(city, ''), NULLIF(province, '')) AS Address,
    position_name AS Position,
    supervisor_id AS SupervisorID,
	ROUND(CAST(hourly_rate AS DECIMAL(15,6)) * 8 * 21, 0) AS GrossSalary,
    ROUND(ROUND(CAST(hourly_rate AS DECIMAL(15,6)) * 8 * 21, 0) / 2) AS NetSalary,
    ROUND(hourly_rate, 2) AS HourlyRate,
    tin_number AS TIN,
    sss_number AS SSS,
    phil_health_number AS PhilHealth, 
    pag_ibig_number AS PagIbig
    
    FROM employee
    INNER JOIN status ON employee.status_id = status.status_id
    INNER JOIN position ON employee.position_id = position.position_id
    INNER JOIN address ON employee.address_id = address.address_id
    INNER JOIN government_info ON employee.government_info_id = government_info.government_info_id
    
WHERE employee_id IN (10032, 10033, 10034, 10037);
    