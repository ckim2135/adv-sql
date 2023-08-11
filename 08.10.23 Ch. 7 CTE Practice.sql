--Book 2, Chapter 7: CTEs
--Practice 1
--For the top 5 dealerships, which employees made the most sales?
WITH top_dealerships AS
(
SELECT DISTINCT dealership_id, COUNT(sale_id) dlr_sales
FROM sales
GROUP BY dealership_id
ORDER BY COUNT(sale_id) DESC
LIMIT 5
),

employee_sales AS
(
SELECT DISTINCT employee_id, first_name, last_name, COUNT(sale_id) emp_sales, dealership_id
FROM sales LEFT JOIN employees USING (employee_id)
GROUP BY employee_id, dealership_id, first_name, last_name
ORDER BY COUNT(sale_id) DESC
)


SELECT *
FROM top_dealerships td LEFT JOIN employee_sales es USING (dealership_id)
WHERE emp_sales > 1
ORDER BY emp_sales DESC


--Practice 2
--For the top 5 dealerships, which vehicle models were the most popular in sales?
--Ford Fusion (45), Ford F-250 (32), Ford Transit-150 Cargo (32), Nissan Altima (30), Nissan Titan (30)
WITH top_dealerships AS
(
SELECT DISTINCT dealership_id, COUNT(sale_id) dlr_sales
FROM sales
GROUP BY dealership_id
ORDER BY COUNT(sale_id) DESC
LIMIT 5
)

SELECT DISTINCT vehicle_type_id, make, model, COUNT(sale_id) sales
FROM top_dealerships td LEFT JOIN sales USING (dealership_id)
						LEFT JOIN vehicles USING (vehicle_id)
						LEFT JOIN vehicletypes USING (vehicle_type_id)
GROUP BY vehicle_type_id, make, model
ORDER BY sales DESC
LIMIT 5

						
--Practice 3
--For the top 5 dealerships, were there more sales or leases?
--The top 5 dealerships had 302 purchases and 285 leases.
WITH top_dealerships AS
(
SELECT DISTINCT dealership_id, COUNT(sale_id) dlr_sales
FROM sales
GROUP BY dealership_id
ORDER BY COUNT(sale_id) DESC
LIMIT 5
)

SELECT DISTINCT sales_type_name, COUNT(sale_id)
FROM top_dealerships td LEFT JOIN sales USING (dealership_id)
						LEFT JOIN salestypes USING (sales_type_id)
GROUP BY sales_type_name


--Practice 4
--For all used cars, which states sold the most? The least?
--California had the most used car sales (40) and Iowa and Missouri had the least (3)
SELECT DISTINCT state, COUNT(sale_id) used_car_sales
FROM
	(SELECT *
	FROM sales 	LEFT JOIN vehicles USING (vehicle_id)
				LEFT JOIN dealerships USING (dealership_id)
	WHERE is_new IS FALSE AND is_sold IS TRUE) usedcars
GROUP BY state
ORDER BY used_car_sales DESC


--Practice 5
--For all used cars, which model is greatest in the inventory? Which make is greatest inventory?
-- Nissan is the most common make (17), Titan is the most common model (7)
SELECT make, COUNT(vin) inventory
FROM	(SELECT * FROM vehicles WHERE is_new IS FALSE AND is_sold IS FALSE) usedcars
		LEFT JOIN vehicletypes USING (vehicle_type_id)
GROUP BY make
ORDER BY inventory DESC

SELECT model, COUNT(vin) inventory
FROM	(SELECT * FROM vehicles WHERE is_new IS FALSE AND is_sold IS FALSE) usedcars
		LEFT JOIN vehicletypes USING (vehicle_type_id)
GROUP BY model
ORDER BY inventory DESC