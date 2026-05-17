-- Insert Authors
INSERT INTO Authors (author_name, bio) VALUES
('Chetan Bhagat', 'Indian author known for 5 Point Someone.'),
('Arundhati Roy', 'Winner of the Man Booker Prize.'),
('R.K. Narayan', 'Creator of Malgudi Days.'),
('Amish Tripathi', 'Known for the Shiva Trilogy.');

-- Insert Genres
INSERT INTO Genres (genre_name) VALUES
('Fiction'),
('Mythology'),
('History'),
('Romance');

-- Insert Books
INSERT INTO Books
(title, price, stock_quantity, author_id, genre_id)
VALUES
('Five Point Someone', 250.00, 50, 1, 1),
('2 States', 300.00, 40, 1, 4),
('The God of Small Things', 450.00, 20, 2, 1),
('Malgudi Days', 200.00, 100, 3, 1),
('The Immortals of Meluha', 399.00, 60, 4, 2);

-- Insert Customers
INSERT INTO Customers
(name, email, city, join_date)
VALUES
('Aarav Sharma', 'aarav@gmail.com', 'Mumbai', '2023-01-10'),
('Diya Patel', 'diya.p@yahoo.com', 'Ahmedabad', '2023-02-15'),
('Vihaan Reddy', 'vihaan.r@outlook.com', 'Hyderabad', '2023-03-20'),
('Ananya Gupta', 'ananya.g@gmail.com', 'Delhi', '2023-04-05');

-- Insert Orders
INSERT INTO Orders
(order_date, customer_id)
VALUES
('2023-05-01', 1),
('2023-05-03', 2),
('2023-05-05', 1),
('2023-06-01', 3);

-- Insert Order_Details
INSERT INTO Order_Details
(order_id, book_id, quantity_ordered, price_at_time_of_order)
VALUES
(1, 1, 1, 250.00),
(1, 4, 2, 200.00),
(2, 5, 1, 399.00),
(3, 2, 1, 300.00),
(4, 3, 1, 450.00);

-- Verify Data
SELECT * FROM Authors;
SELECT * FROM Genres;
SELECT * FROM Customers;
SELECT * FROM Books;
SELECT * FROM Orders;
SELECT * FROM Order_Details;