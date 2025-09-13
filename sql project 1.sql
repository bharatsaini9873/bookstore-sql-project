create database  onlinebookstore ;
use onlinebookstore ;


select * from customers ;
select * from orders ;
select * from books;

-- 1) Retrieve all books in the "Fiction" genre:
 select * from books where Genre ="Fiction";
 
 
 -- 2) Find books published after the year 1950:
select* from books where Published_Year > 1950 ;


-- 3) List all customers from the Canada:
select * from customers where Country ="canada";


-- 4) Show orders placed in November 2023:
select * from orders where Order_Date between '2023-11-01' and  '2023-11-30' ;


-- 5) Retrieve the total stock of books available:
select sum(stock) as Total_stock from books ;


-- 6) Find the details of the most expensive book:
SELECT * FROM Books ORDER BY Price DESC LIMIT 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
select O.Customer_ID ,C.Cust_Name, O.book_id,O.Quantity from orders as O join customers as C on O.Customer_ID = C.Customer_ID where Quantity >1;


-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders where Total_Amount > 20;


-- 9) List all genres available in the Books table:
select  genre ,count(stock)  from books where stock >0 group by genre;


-- 10) Find the book with the lowest stock:
select title, stock from books   order by stock asc  limit 1;


-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) from orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select B.genre ,count(O.Quantity) from orders as O join books as B on O.Book_ID = B.Book_ID group by B.genre;


-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) from books where genre = "Fantasy";


-- 3) List customers who have placed at least 2 orders:
select o.Customer_ID ,c.Cust_Name , count(o.order_id) from customers as c join orders as o  on c.Customer_ID = o.Customer_ID group by o.customer_id , c.cust_name
 having count(order_id)>=2;


-- 4) Find the most frequently ordered book:

SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT FROM orders o JOIN books b ON o.book_id=b.book_id GROUP BY o.book_id, b.title ORDER BY ORDER_COUNT DESC LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select Title , price from books where genre = "Fantasy" order by price desc limit 3 ;


-- 6) Retrieve the total quantity of books sold by each author:
select b.Author , sum(o.Quantity) from books b join orders o on b.Book_ID = o.Book_ID group by b.Author;


-- 7) List the cities where customers who spent over $30 are located:
select c.city , sum(o.total_amount) from customers c  join orders o on c.Customer_ID = o.Customer_ID where o.Total_Amount > 30 group by c.city;



-- 8) Find the customer who spent the most on orders:
select c.Customer_ID,c.Cust_Name , sum(o.total_amount) from customers c join orders o on  c.Customer_ID = o.Customer_ID group by c.Customer_ID,c.cust_name 
order by sum(o.Total_Amount) desc  limit 1;




-- 9) Calculate the stock remaining after fulfilling all orders:


SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ,b.title,b.stock ORDER BY b.book_id;