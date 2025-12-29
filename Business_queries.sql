/* ===========================================================================
PROJECT: CHINOOK DIGITAL MUSIC STORE - BUSINESS INTELLIGENCE ANALYSIS
AUTHOR: [Your Name]
TOOLS: PostgreSQL, pgAdmin 4
OBJECTIVE: Extract actionable insights from sales, customer, and 
           employee data to drive marketing and operational decisions.
===========================================================================
*/

-- -------------------------------------------------------------------------
-- TASK 1: CUSTOMER LOYALTY ANALYSIS (VIP PROGRAM)
-- Business Problem: The marketing team wants to launch a VIP loyalty program.
-- Goal: Identify the top 5 customers who have spent the most money overall.
-- -------------------------------------------------------------------------
SELECT 
    c.first_name, 
    c.last_name, 
    SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;

-- -------------------------------------------------------------------------
-- TASK 2: MARKET TRENDS (GENRE POPULARITY IN THE USA)
-- Business Problem: The procurement team needs to know which music genres 
-- are most popular in the USA to optimize inventory.
-- Goal: Calculate total tracks sold per genre specifically for US customers.
-- -------------------------------------------------------------------------
SELECT 
    g.name AS genre, 
    COUNT(il.invoice_line_id) AS tracks_sold
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
JOIN invoice_line il ON t.track_id = il.track_id
JOIN invoice i ON il.invoice_id = i.invoice_id
WHERE i.billing_country = 'USA'
GROUP BY g.genre_id, g.name
ORDER BY tracks_sold DESC;

-- -------------------------------------------------------------------------
-- TASK 3: EMPLOYEE SALES PERFORMANCE
-- Business Problem: Management is conducting quarterly performance reviews.
-- Goal: Rank Sales Support Agents by the total revenue generated through 
-- their assigned customers.
-- -------------------------------------------------------------------------
SELECT 
    e.first_name, 
    e.last_name, 
    SUM(i.total) AS total_sales
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_sales DESC;