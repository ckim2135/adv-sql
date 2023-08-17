--Book 2, Chapter 8: Window Functions
--No practice questions

-- Book 2, Chapter 9: Filters and Joins Practice
--Section 1: Purchase Income by Dealership
--Question 1
--Write a query that shows the total purchase sales income per dealership.
SELECT dealership_id, SUM(price) purchase_income
FROM sales LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name LIKE 'Purchase'
GROUP BY dealership_id
ORDER BY dealership_id


--Question 2
--Write a query that shows the purchase sales income per dealership for July of 2020.
SELECT dealership_id, SUM(price) purchase_income
FROM sales LEFT JOIN salestypes USING (sales_type_id)
WHERE 	TEXT(purchase_date) LIKE '2020-07%' 
		AND sales_type_name LIKE 'Purchase'
GROUP BY dealership_id
ORDER BY dealership_id

--Question 3
--Write a query that shows the purchase sales income per dealership for all of 2020.
SELECT dealership_id, SUM(price) purchase_income
FROM sales LEFT JOIN salestypes USING (sales_type_id)
WHERE 	TEXT(purchase_date) LIKE '2020%'
		AND sales_type_name LIKE 'Purchase'
GROUP BY dealership_id
ORDER BY dealership_id

--Section 2: Lease Income by Dealership
--Question 1
--Write a query that shows the total lease income per dealership.
SELECT dealership_id, SUM(price) lease_income
FROM sales LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name LIKE 'Lease'
GROUP BY dealership_id, sales_type_name
ORDER BY dealership_id

--Question 2
--Write a query that shows the lease income per dealership for Jan of 2020.
SELECT dealership_id, SUM(price) lease_income
FROM sales LEFT JOIN salestypes USING (sales_type_id)
WHERE 	sales_type_name LIKE 'Lease' AND
		text(purchase_date) LIKE '2020-01%'
GROUP BY dealership_id, sales_type_name
ORDER BY dealership_id

--Question 3
--Write a query that shows the lease income per dealership for all of 2019.
SELECT dealership_id, SUM(price) lease_income
FROM sales LEFT JOIN salestypes USING (sales_type_id)
WHERE 	sales_type_name LIKE 'Lease' AND
		text(purchase_date) LIKE '2019%'
GROUP BY dealership_id, sales_type_name
ORDER BY dealership_id

--Section 3: Total Income by Employee
--Question 1
--Write a query that shows the total income (purchase and lease) per employee.
SELECT employee_id, first_name, last_name, SUM(price) total_income
FROM sales LEFT JOIN employees USING (employee_id)
GROUP BY employee_id, first_name, last_name
ORDER BY SUM(price) DESC


--Book 2, Chapter 10: Inventory Reports
--Section 1: Available Models
--Question 1
--Which model of vehicle has the lowest current inventory? This will help dealerships know which models the purchase from manufacturers.
--There are only 203 Volkswagen Atlases in stock.
SELECT DISTINCT model, make, COUNT(vehicle_id) inventory
FROM vehicles LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold IS FALSE
GROUP BY model, make
ORDER BY inventory
LIMIT 1

--Question 2
--Which model of vehicle has the highest current inventory? This will help dealerships know which models are, perhaps, not selling.
--There are 606 Nissan Maximas in stock.
SELECT DISTINCT model, make, COUNT(vehicle_id) inventory
FROM vehicles LEFT JOIN vehicletypes USING (vehicle_type_id)
WHERE is_sold IS FALSE
GROUP BY model, make
ORDER BY inventory DESC
LIMIT 1

--Section 2: Diverse Dealerships
--Question 1
--Which dealerships are currently selling the least number of vehicle models? This will let dealerships market vehicle models more effectively per region.
--By dealership
SELECT DISTINCT dealership_id, COUNT(DISTINCT model) model_diversity
FROM sales 	LEFT JOIN vehicles USING (vehicle_id)
			LEFT JOIN vehicletypes USING (vehicle_type_id)
			LEFT JOIN dealerships USING (dealership_id)
WHERE is_sold IS TRUE
GROUP BY dealership_id
ORDER BY model_diversity
--By state
SELECT DISTINCT state, COUNT(DISTINCT model) model_diversity
FROM sales 	LEFT JOIN vehicles USING (vehicle_id)
			LEFT JOIN vehicletypes USING (vehicle_type_id)
			LEFT JOIN dealerships USING (dealership_id)
WHERE is_sold IS TRUE
GROUP BY state
ORDER BY model_diversity

--Question 2
--Which dealerships are currently selling the highest number of vehicle models? This will let dealerships know which regions have either a high population, or less brand loyalty.
SELECT DISTINCT dealership_id, COUNT(DISTINCT model) model_diversity
FROM sales 	LEFT JOIN vehicles USING (vehicle_id)
			LEFT JOIN vehicletypes USING (vehicle_type_id)
			LEFT JOIN dealerships USING (dealership_id)
WHERE is_sold IS TRUE
GROUP BY dealership_id
ORDER BY model_diversity DESC
--By state
SELECT DISTINCT state, COUNT(DISTINCT model) model_diversity
FROM sales 	LEFT JOIN vehicles USING (vehicle_id)
			LEFT JOIN vehicletypes USING (vehicle_type_id)
			LEFT JOIN dealerships USING (dealership_id)
WHERE is_sold IS TRUE
GROUP BY state
ORDER BY model_diversity DESC


--Book 2, Chapter 11: Additional Reporting Practice
--Question 1
--How many emloyees are there for each role?
SELECT employee_type_name, COUNT(DISTINCT employee_id) employee_count
FROM employeetypes LEFT JOIN employees USING (employee_type_id)
GROUP BY employee_type_name

--Question 2
--How many finance managers work at each dealership?
SELECT dealership_id, employee_type_name, COUNT(DISTINCT employee_id) employee_count
FROM employeetypes 	LEFT JOIN employees USING (employee_type_id)
					LEFT JOIN dealershipemployees USING(employee_id)
WHERE employee_type_name LIKE 'Finance Manager'
GROUP BY dealership_id, employee_type_name

--Question 3
--Get the names of the top 3 employees who work shifts at the most dealerships?
--
--Sub-query: employees at >1 dealership
SELECT employee_id
FROM dealershipemployees
GROUP BY employee_id
HAVING COUNT(DISTINCT dealership_id) > 1
--
-- Full query
SELECT DISTINCT employee_id, SUM(price) sales
FROM sales
WHERE employee_id IN (SELECT employee_id
FROM dealershipemployees
GROUP BY employee_id
HAVING COUNT(DISTINCT dealership_id) > 1)
GROUP BY employee_id
ORDER BY sales DESC
LIMIT 3


--Question 4
--Get a report on the top two employees who has made the most sales through leasing vehicles.
SELECT employee_id, first_name, last_name, COUNT(DISTINCT sale_id) lease_sales
FROM sales 	LEFT JOIN salestypes USING (sales_type_id)
			LEFT JOIN employees USING (employee_id)
WHERE sales_type_name LIKE 'Lease'
GROUP BY employee_id, first_name, last_name
ORDER BY lease_sales DESC
LIMIT 5