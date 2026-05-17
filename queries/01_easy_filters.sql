use bookstore_db;
-- Easy: WHERE Clause and Operators
-- These queries use various operators (LIKE, IN, BETWEEN, mathematical operations) to filter data in specific ways.

/* 
=============================================================================
QUERY 1: Filter by Email Domain and Specific Cities
Find customers who use Gmail and are located in either Mumbai or Delhi.
=============================================================================
HOW IT WORKS:
- Uses the `LIKE` operator with the `%` wildcard to perform pattern matching, 
  finding any string that ends with '@gmail.com'.
- Uses the `IN` operator as a highly readable alternative to multiple `OR` 
  statements (`city = 'Mumbai' OR city = 'Delhi'`).
*/
SELECT name, email, city 
FROM Customers 
WHERE email LIKE '%@gmail.com' 
  AND city IN ('Mumbai', 'Delhi');
  
/* 
=============================================================================
QUERY 2: Mathematical Operators in the WHERE Clause
Find books where the total potential revenue of the current stock (price × stock quantity) is between ₹10,000 and ₹25,000.
=============================================================================
HOW IT WORKS:
- Calculates a dynamic column `total_inventory_value` on the fly by 
  multiplying two existing columns (`price` and `stock_quantity`).
- Uses the `BETWEEN` operator to filter results inclusively. The database 
  evaluates the math for every row before applying the filter.
*/
SELECT title, (price * stock_quantity) AS total_inventory_value 
FROM Books 
WHERE (price * stock_quantity) BETWEEN 10000 AND 25000;

/* 
=============================================================================
QUERY 3: Combining AND/OR with Inequality
Find books that either cost less than ₹300 or have exactly 60 units in stock, but exclude the book with ID 1.
=============================================================================
HOW IT WORKS:
- Demonstrates operator precedence. The parentheses `()` ensure the `OR` 
  condition is evaluated as a single logical unit before applying the `AND`.
- Uses the inequality operator `!=` to explicitly exclude a specific record, 
  showcasing how to handle exceptions in data retrieval.
*/
SELECT title, price, stock_quantity 
FROM Books 
WHERE (price < 300 OR stock_quantity = 60) 
  AND book_id != 1;

/* 
=============================================================================
QUERY 4: Date Filtering
Find all customers who joined the bookstore after the first quarter of 2023.
=============================================================================
HOW IT WORKS:
- Compares date values using standard mathematical operators (`>`). 
- Because MySQL stores dates in the ISO 8601 format (YYYY-MM-DD), it can 
  lexicographically compare the string '2023-03-31' against the `join_date` 
  column to find later dates.
*/
SELECT name, join_date 
FROM Customers 
WHERE join_date > '2023-03-31';