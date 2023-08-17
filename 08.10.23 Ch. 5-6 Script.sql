--Book 2, Chapter 5: Complex Joins
--Question 1
--What is the most popular vehicle make in terms of number of sales?
--There were 705 Nissans sold, making it the most popular make in terms of sales.
SELECT DISTINCT make, COUNT(sales.vehicle_id) sales
FROM sales 	LEFT JOIN vehicles v USING (vehicle_id)
			LEFT JOIN vehicletypes vt USING (vehicle_type_id)
WHERE is_sold IS true			
GROUP BY make
ORDER BY sales DESC
LIMIT 1



--Question 2
--Which employee type sold the most of that make?
--Customer Service employees sold 242 Nissans.
SELECT employee_type_id, employee_type_name, COUNT(vehicle_id) sales
FROM sales	LEFT JOIN vehicles USING (vehicle_id)
			LEFT JOIN vehicletypes vt USING (vehicle_type_id)
			LEFT JOIN employees USING (employee_id)
			LEFT JOIN employeetypes USING (employee_type_id)
WHERE make LIKE 'Nissan'	
GROUP BY employee_type_id, employee_type_name
ORDER BY sales DESC



--Book 2, Chapter 6: Subqueries
--No practice questions