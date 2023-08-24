--Adv_SQL Project 1
--C. Kim


--Employee Reports
--Best Sellers

--Question 1
--Who are the top 5 employees for generating sales income?
SELECT employee_id, first_name, last_name, SUM(price) total_sales
FROM sales LEFT JOIN employees USING (employee_id)
GROUP BY employee_id, first_name, last_name
ORDER BY total_sales DESC
LIMIT 5;

--Question 2
--Who are the top 5 dealership for generating sales income?
SELECT dealership_id, business_name, SUM(price) total_sales
FROM sales LEFT JOIN dealerships USING (dealership_id)
GROUP BY dealership_id, business_name
ORDER BY total_sales DESC
LIMIT 5;

--Question 3
--Which vehicle model generated the most sales income?
SELECT model, make, SUM(price) total_sales
FROM sales 	LEFT JOIN vehicles USING (vehicle_id)
			LEFT JOIN vehicletypes USING (vehicle_type_id)
GROUP BY model, make
ORDER BY total_sales DESC
LIMIT 1;


--Top Performance
--Question 4

--Which employees generate the most income per dealership?
--dlr_max
WITH dlr_max AS 
(
SELECT DISTINCT dealership_id, MAX(SUM(price)) OVER (PARTITION BY dealership_id) dlr_max
FROM sales
GROUP BY dealership_id, employee_id
ORDER BY dealership_id
),

emp_sales AS
(
SELECT dealership_id, employee_id, SUM(price) emp_sales
FROM sales
GROUP BY dealership_id, employee_id
)

SELECT dm.dealership_id, first_name, last_name, employee_id, emp_sales
FROM dlr_max dm LEFT JOIN emp_sales es
		ON dm.dealership_id = es.dealership_id
		AND dm.dlr_max = es.emp_sales
	LEFT JOIN employees USING (employee_id)
ORDER BY dealership_id


--Vehicle Reports
--Inventory

--Question 5
--In our Vehicle inventory, show the count of each Model that is in stock.
SELECT model, make, COUNT(DISTINCT vin) in_stock
FROM vehicles LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold IS FALSE
GROUP BY model, make;

--Question 6
--In our Vehicle inventory, show the count of each Make that is in stock.
SELECT make, COUNT (DISTINCT vin)
FROM vehicles LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold IS FALSE
GROUP BY make;

--Question 7
--In our Vehicle inventory, show the count of each BodyType that is in stock.
SELECT body_type, COUNT (DISTINCT vin)
FROM vehicles LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold IS FALSE
GROUP BY body_type;


--Purchasing Power
--Question 8
--Which US state's customers have the highest average purchase price for a vehicle?
SELECT DISTINCT state, ROUND(AVG(price) OVER(PARTITION BY state)) avg_price
FROM sales LEFT JOIN customers USING (customer_id)
GROUP BY state, price
ORDER BY avg_price DESC
LIMIT 1;

--Question 9
--Now using the data determined above, which 5 states have the customers with the highest average purchase price for a vehicle?
SELECT DISTINCT state, ROUND(AVG(price) OVER(PARTITION BY state)) avg_price
FROM sales LEFT JOIN customers USING (customer_id)
GROUP BY state, price
ORDER BY avg_price DESC
LIMIT 5;