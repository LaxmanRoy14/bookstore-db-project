-- Easy: WHERE Clause and Operators
-- These queries use various operators (LIKE, IN, BETWEEN, mathematical operations) to filter data in specific ways.

-- 1. Filter by Email Domain and Specific Cities
-- Find customers who use Gmail and are located in either Mumbai or Delhi.
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