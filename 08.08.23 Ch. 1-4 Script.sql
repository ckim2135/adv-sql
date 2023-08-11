-- Book 2, Chapter 1: Basic Query Review
-- Question 1
-- Write a query that returns the business name, city, state, and website for each dealership.
-- Use an alias for the Dealerships table.
SELECT *
FROM dealerships AS d

SELECT DISTINCT business_name, city, state, website
FROM dealerships AS d
ORDER BY business_name

--Question 2
--Write a query that returns the first name, last name, and email address of every customer.
--Use an alias for the Customers table.
SELECT first_name, last_name, email
FROM customers AS c
GROUP BY first_name, last_name, email



--Book 2, Chapter 2: Filtering Data
--Question 1
--Get a list of sales records where the sale was a lease.
SELECT *
FROM sales LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name LIKE 'Lease'

--Question 2
--Get a list of sales where the purchase date is within the last five years.
SELECT *
FROM sales
WHERE purchase_date > (CURRENT_DATE - INTERVAL '5 years')
ORDER BY purchase_date DESC

--Question 3
--Get a list of sales where the deposit was above 5000 or the customer payed with American Express.
SELECT *
FROM sales
WHERE deposit > 5000 OR payment_method LIKE 'americanexpress'
ORDER BY deposit

--Question 4
--Get a list of employees whose first names start with "M" or ends with "d".
SELECT *
FROM employees
WHERE first_name LIKE 'M%' OR last_name LIKE '%d'

--Question 5
--Get a list of employees whose phone numbers have the 604 area code.
SELECT first_name, last_name, phone
FROM employees
WHERE phone LIKE '604%'


--Book 2, Chapter 3: Joining Data
--Question 1
--Get a list of the sales that were made for each sales type.
SELECT *
FROM sales LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name LIKE 'Lease'

SELECT *
FROM sales LEFT JOIN salestypes USING (sales_type_id)
WHERE sales_type_name LIKE 'Purchase'

--Question 2
--Get a list of sales with the VIN of the vehicle, the first name and last name of the customer,
--first name and last name of the employee who made the sale and the name, city and state of the dealership.
SELECT c.first_name cust_first, c.last_name cust_last, vin, e.first_name emp_first, e.last_name emp_last,
		d.city dealer_city, d.state dealer_state
FROM sales 	LEFT JOIN vehicles v USING (vehicle_id)
			LEFT JOIN customers c USING (customer_id)
			LEFT JOIN employees e USING (employee_id)
			LEFT JOIN dealerships d USING (dealership_id)

--Question 3
--Get a list of all the dealerships and the employees, if any, working at each one.
SELECT d.business_name, e.first_name, e.last_name
FROM dealershipemployees de LEFT JOIN dealerships d USING (dealership_id)
							LEFT JOIN employees e USING (employee_id)
ORDER BY d.business_name
			
--Question 4
--Get a list of vehicles with the names of the body type, make, model and color.
SELECT v.vin, body_type, make, model, exterior_color
FROM vehicles v LEFT JOIN vehicletypes vt USING (vehicle_type_id)


--Book 2, Chapter 4: Aggregation and Grouping
--No practice questions