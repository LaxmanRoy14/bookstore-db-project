/* 
=============================================================================
Medium: Clauses and Aggregate Functions
These queries utilize GROUP BY, HAVING, ORDER BY, and aggregation functions (SUM, MAX, MIN, COUNT, AVG).
=============================================================================
*/

/* 
=============================================================================
QUERY 5: Aggregation with a HAVING Clause
Calculate the total quantity of each book sold, but only display books that have sold more than 1 unit in total across all orders.
=============================================================================
HOW IT WORKS:
- Groups all order details by `book_id`, rolling up multiple sales of the 
  same book into a single row.
- Uses `HAVING` instead of `WHERE`. While `WHERE` filters rows *before* 
  they are grouped, `HAVING` filters the result set *after* the `SUM()` 
  aggregation is calculated.
*/
SELECT book_id, SUM(quantity_ordered) AS total_sold 
FROM Order_Details 
GROUP BY book_id 
HAVING SUM(quantity_ordered) > 1;

/* 
=============================================================================
QUERY 6: Multiple Aggregations and Ordering
Find the highest and lowest priced books for each author, and sort the results so the author with the most expensive book appears first.
=============================================================================
HOW IT WORKS:
- Groups the dataset by `author_id`.
- Simultaneously extracts multiple insights (`MAX` and `MIN` prices) for each 
  group without needing separate queries.
- Orders the final grouped result set in descending (`DESC`) order based on 
  the calculated alias `highest_price`.
*/
SELECT author_id, MAX(price) AS highest_price, MIN(price) AS lowest_price 
FROM Books 
GROUP BY author_id 
ORDER BY highest_price DESC;

/* 
=============================================================================
QUERY 7: Counting Distinct Dates
Count the number of unique days each customer placed an order, allowing you to see who buys on multiple different dates versus all at once.
=============================================================================
HOW IT WORKS:
- Uses `COUNT(DISTINCT column_name)` to eliminate duplicates before counting.
- If a customer placed 3 orders on '2023-05-01', a standard `COUNT()` would 
  return 3. `COUNT(DISTINCT)` ensures it only returns 1, accurately measuring 
  unique shopping days rather than total transactions.
*/
SELECT customer_id, COUNT(DISTINCT order_date) AS unique_order_days 
FROM Orders 
GROUP BY customer_id 
ORDER BY unique_order_days DESC;

/* 
=============================================================================
QUERY 8: Average Calculation
Count the number of unique days each customer placed an order, allowing you to see who buys on multiple different dates versus all at once.
=============================================================================
HOW IT WORKS:
- Groups books by `genre_id`.
- Applies the `AVG()` function, which mathematically calculates the sum of 
  all prices in that genre divided by the total count of books in that genre, 
  handling the underlying division automatically.
*/
SELECT genre_id, AVG(price) AS average_book_price 
FROM Books 
GROUP BY genre_id 
ORDER BY average_book_price DESC;