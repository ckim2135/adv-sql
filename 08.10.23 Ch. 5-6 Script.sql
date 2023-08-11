--Book 2, Chapter 5: Complex Joins
--Question 1
--What is the most popular vehicle make in terms of number of sales?
--There were 280 Ford Transit-150 Cargos [vid 15] sold, making it the most popular vehicle in terms of sales.
SELECT DISTINCT v.vehicle_type_id, make, model, COUNT(sales.vehicle_id) sales
FROM sales 	LEFT JOIN vehicles v USING (vehicle_id)
			LEFT JOIN vehicletypes vt USING (vehicle_type_id)
GROUP BY v.vehicle_type_id, make, model
ORDER BY sales DESC
LIMIT 1



--Question 2
--Which employee type sold the most of that make?
--47 Ford Transit-150 Cargos were sold by Customer Service employees, and 47 were sold by Finance Managers.
SELECT employee_type_id, employee_type_name, COUNT(vehicle_id) sales
FROM sales	LEFT JOIN vehicles USING (vehicle_id)
			LEFT JOIN employees USING (employee_id)
			LEFT JOIN employeetypes USING (employee_type_id)
WHERE vehicle_type_id = 15			
GROUP BY employee_type_id, employee_type_name
ORDER BY sales DESC

--Book 2, Chapter 6: Subqueries
--No practice questions