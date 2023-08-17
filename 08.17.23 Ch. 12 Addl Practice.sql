--Book 2, Chapter 12: Additional Practice
--Question 1
--What are the top 5 US states with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform?
--The five states with most customers who purchased a vehicle are Texas (131); California (128); Florida (86); New York (59); Ohio (45).
SELECT DISTINCT state, COUNT(DISTINCT customer_id) customers
FROM sales LEFT JOIN customers USING (customer_id)
GROUP BY state 
ORDER BY customers DESC

--Question 2
--What are the top 5 US zipcodes with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform?
--The five zipcodes with the most customers who purchased a vehicle are 32825 (4); 65211 (4); 80015 (4); 91797 (4); 33 zipcodes tied for fifth (3).
SELECT DISTINCT zipcode, COUNT(DISTINCT customer_id) customers
FROM sales LEFT JOIN customers USING (customer_id)
GROUP BY zipcode 
ORDER BY customers DESC

--Question 3
--What are the top 5 dealerships with the most customers?
--The five dealerships with the most customers are Dealership 34 (115); 50 (114); 49 (113); 44 (110); 18 (109)
SELECT DISTINCT dealership_id, COUNT(DISTINCT customer_id) customers
FROM sales LEFT JOIN dealerships USING (dealership_id)
GROUP BY dealership_id
ORDER BY customers DESC