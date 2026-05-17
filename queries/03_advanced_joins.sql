/* 
=============================================================================
Hard: JOINS and Subqueries
These queries involve multi-table JOINs, nested subqueries, and advanced business logic.
=============================================================================
/* 
=============================================================================
QUERY 9: Multi-table JOIN with NOT IN Subquery (Anti-Join)
Find the names of authors who have never had any of their books ordered.
=============================================================================
HOW IT WORKS:
- This is an "Anti-Join" pattern. The inner subquery joins `Books` and 
  `Order_Details` to create a list of all `author_id`s who have made a sale.
- The outer query selects authors from the `Authors` table whose IDs do 
  *not* appear in that inner list, effectively isolating zero-sales authors.
*/
SELECT author_name 
FROM Authors 
WHERE author_id NOT IN (
    SELECT DISTINCT b.author_id 
    FROM Books b 
    JOIN Order_Details od ON b.book_id = od.book_id
);

/* 
=============================================================================
QUERY 10: Subquery inside a HAVING Clause (Dynamic Baselining)
Find genres that have generated more total revenue than the average revenue across all genres.
=============================================================================
HOW IT WORKS:
- The outer query calculates total historical revenue per genre using a 
  3-table JOIN (`Genres` -> `Books` -> `Order_Details`).
- Instead of hardcoding a target revenue number, the `HAVING` clause runs a 
  nested subquery to calculate the overall average revenue across *all* genres. 
- It then filters to only show genres outperforming that dynamic average.
*/
SELECT g.genre_name, SUM(od.quantity_ordered * od.price_at_time_of_order) AS genre_revenue
FROM Genres g
JOIN Books b ON g.genre_id = b.genre_id
JOIN Order_Details od ON b.book_id = od.book_id
GROUP BY g.genre_name
HAVING SUM(od.quantity_ordered * od.price_at_time_of_order) > (
    SELECT AVG(total_rev) FROM (
        SELECT SUM(od2.quantity_ordered * od2.price_at_time_of_order) AS total_rev
        FROM Books b2
        JOIN Order_Details od2 ON b2.book_id = od2.book_id
        GROUP BY b2.genre_id
    ) AS avg_revenue
);

/* 
=============================================================================
QUERY 11: Complex Filtering via Subqueries (Cohort Analysis)
Find the names of customers who placed an order in May 2023 but did NOT return to place any orders in June 2023.
=============================================================================
HOW IT WORKS:
- Isolates a specific cohort of users (people who bought in May 2023) using 
  the `MONTH()` and `YEAR()` date extraction functions.
- Applies a `NOT IN` subquery to filter out any users from that cohort who 
  also have records in June 2023. 
- Useful for identifying churned customers who didn't return the next month.
*/
SELECT DISTINCT c.name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE MONTH(o.order_date) = 5 AND YEAR(o.order_date) = 2023
  AND c.customer_id NOT IN (
      SELECT customer_id
      FROM Orders
      WHERE MONTH(order_date) = 6 AND YEAR(order_date) = 2023
  );

/* 
=============================================================================
QUERY 12: Multi-table JOIN driven by a LIMIT Subquery
Retrieve the detailed line items (Order ID, Book Title, and Quantity) specifically for the single order that contained the highest total volume of books.
=============================================================================
HOW IT WORKS:
- The inner subquery groups order details by `order_id`, sums their total 
  quantities, sorts them highest to lowest, and uses `LIMIT 1` to grab only 
  the single biggest order ID.
- The outer query takes that single `order_id` and performs a JOIN with 
  the `Books` table to retrieve human-readable line-item details (like titles) 
  specifically for that top order.
*/
SELECT od.order_id, b.title, od.quantity_ordered
FROM Order_Details od
JOIN Books b ON od.book_id = b.book_id
WHERE od.order_id = (
    SELECT order_id
    FROM Order_Details
    GROUP BY order_id
    ORDER BY SUM(quantity_ordered) DESC
    LIMIT 1
);