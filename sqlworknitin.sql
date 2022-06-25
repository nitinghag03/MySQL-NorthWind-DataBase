SELECT * FROM mavenmovies.customer;

-- Question about business:
-- 1.	I’m going to send an email letting our customers know there has been a change in management.
-- Could you please pull a list of the first name, last name and email of each of our customers?

-- Solution-
select customer_id,first_name,last_name,email from mavenmovies.customer;

-- SQL 57 problem

-- 1  Which shippers do we have? We have a table called Shippers. Return all the fields from all the shippers 
-- solution
SELECT * FROM northwind_db.shippers;
-- 2. Certain fields from Categories
-- In the Categories table, selecting all the fields using this SQL: Select * from Categories will return 4 columns. We only want to see two columns,CategoryName and Description.
-- solution
SELECT category_name,description FROM northwind_db.categories;

-- 3 Sales Representatives We’d like to see just the FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative. Write a SQL statement that returns only those employees.
-- solution
SELECT first_name,last_name,hire_date FROM northwind_db.employees
where title = 'sales Representative';

-- 4. Sales Representatives in the United States Now we’d like to see the same columns as above, but only for those employees that both have the title of Sales Representative, and also arein the United States.
-- solution-
SELECT first_name,last_name,hire_date FROM northwind_db.employees
where title = 'sales Representative' and country='USA';

-- 5. Orders placed by specific EmployeeID Show all the orders placed by a specific employee. The EmployeeID for this Employee (Steven Buchanan) is 5.
-- solution
SELECT order_id,order_date FROM northwind_db.orders
where employee_id=5;

-- 6. Suppliers and ContactTitles In the Suppliers table, show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not Marketing Manager
-- solution
select supplier_id,contact_name,contact_title from northwind_db.suppliers
where contact_title != 'Marketing Manager';

-- 7. Products with “queso” in ProductName In the products table, we’d like to see the ProductID and ProductName for those products where the ProductName includes the string “queso”
-- solution
SELECT product_id,product_name FROM northwind_db.products
where product_name like 'queso%';

-- 8. Orders shipping to France or Belgium Looking at the Orders table, there’s a field called ShipCountry. Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either France or Belgium.
-- solution
 SELECT order_id,customer_id,ship_country FROM northwind_db.orders
 where ship_country='France' or ship_country='Belgium';
 
 -- 9. Orders shipping to any country in Latin America Now, instead of just wanting to return all the orders from France of Belgium, we want to show all the orders from any Latin American country. But we don’t have a list of Latin American countries in a table in the Northwind database. So, we’re going to just use this list of Latin
-- American countries that happen to be in the Orders table:
-- Brazil
-- Mexico
-- Argentina
-- Venezuela
-- It doesn’t make sense to use multiple Or statements anymore, it would get too convoluted. Use the In statement
-- solution
SELECT order_id,customer_id,ship_country FROM northwind_db.orders
 where ship_country in ('Brazil','Mexico','Argentina','Venezuela');
 
 -- 10. Employees, in order of age For all the employees in the Employees table, show the FirstName, LastName, Title, and BirthDate. Order the results by BirthDate, so we have the oldest employees first.
-- solution
SELECT first_name,last_name,title,birth_date FROM northwind_db.employees
order by birth_date;

-- 11. Showing only the Date with a DateTime field In the output of the query above, showing the Employees in order of BirthDate, we see the time of the BirthDate field, which we don’t want. Show only the date portion of the BirthDate field
-- solution
SELECT first_name,last_name,title,birth_date 
FROM northwind_db.employees
order by birth_date;

-- 12. Employees full name Show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, showing FirstName and LastName joined together in one column, with a space in-between.

SELECT first_name,last_name FROM northwind_db.employees;
alter table northwind_db.employees
add fullname varchar(45);
alter table northwind_db.employees
drop column fullname;
-- solution
select first_name,last_name,concat(first_name,' ',last_name) as fullname from northwind_db.employees;

-- 13. OrderDetails amount per line item In the OrderDetails table, we have the fields UnitPrice and Quantity. Create a new field, TotalPrice, that multiplies these two together. We’ll ignore the Discount field for now. In addition, show the OrderID, ProductID, UnitPrice, and Quantity. Order by OrderID and ProductID.
-- solution 
 SELECT order_id,product_id,unit_price,quantity,product_id*quantity as Total_Price FROM northwind_db.order_details;
 
 -- 14. How many customers? How many customers do we have in the Customers table? Show one value only, and don’t rely on getting the recordcount at the end of aresultset.
-- solution
SELECT count(customer_id) as total FROM northwind_db.customers;

-- 15. When was the first order? Show the date of the first order ever made in the Orders table
-- solution
SELECT max(order_date) FROM northwind_db.orders;

-- 16. Countries where there are customers Show a list of countries where the Northwind company has customers.

SELECT * FROM northwind_db.customers;
-- solution
select distinct country FROM northwind_db.customers
order by country;


-- 17. Contact titles for customers Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle.This is similar in concept to the previous question “Countries wherethere are customers”, except we now want a count for each Contact Title
use northwind_db;
-- solution
SELECT 
     contact_title,
     count(customer_id)
     from customers
     group by
     contact_title;


-- 18. Products with associated supplier names We’d like to show, for each product, the associated Supplier. Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID. This question will introduce what may be a new concept, the Join clause in SQL. The Join clause is used to join two or more relational database
-- tables together in a logical way. Here’s a data model of the relationship between Products and Suppliers
use northwind_db;
-- solution
select product_id,product_name,company_name
from products
join suppliers
on products.supplier_id=suppliers.supplier_id;


-- 19 Orders and the Shipper that was used We’d like to show a list of the Orders that were made, including the Shipper that was used. Show the OrderID, OrderDate (date only), and CompanyName of the Shipper, and sort by OrderID.
-- In order to not show all the orders (there’s more than 800), show only those rows with an OrderID of less than 10300
-- solution
select order_id, order_date,company_name from orders
join shippers
on orders.ship_via=shippers.shipper_id
where order_id < 10300
order by order_id;


-- 20. Categories, and the total products in each category For this problem, we’d like to see the total number of products in each category. Sort the results by the total number of products, in descending order
-- solution
SELECT category_name,
count(product_id) as Total
 FROM categories
 join products
 on categories.category_id=products.category_id
 group by category_name
 order by Total desc;
 

-- 21. Total customers per country/city In the Customers table, show the total number of customers per Country and City
-- solution
select
     country,
     city,
     count(customer_id) as Total
     from customers
     group by
     country,city
     order by Total desc;
     
-- 22. Products that need reordering What products do we have in our inventory that should be reordered? For now, just use the fields UnitsInStock and ReorderLevel, where UnitsInStock is less than the ReorderLevel, ignoring the fields
-- UnitsOnOrder and Discontinued. Order the results by ProductID
-- solution
select
product_id,
product_name,
units_in_stock,
reorder_level
from products
where units_in_stock < reorder_level;

-- 23. Products that need reordering, continued Now we need to incorporate these fields—UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued—into our calculation. We’ll define “products that need reordering” with the following:
-- UnitsInStock plus UnitsOnOrder are less than or equal to ReorderLevel The Discontinued flag is false (0).

select
product_id,
units_in_stock,
units_on_order,
reorder_level,
discontinued
from products
where (units_in_stock + units_on_order) <= reorder_level and discontinued=0;

-- ??24. Customer list by region A salesperson for Northwind is going on a business trip to visit customers, and would like to see a list of all customers, sorted by region, alphabetically.
-- However, he wants the customers with no region (null in the Region field) to be at the end, instead of at the top, where you’d normally find the null values. Within the same region, companies should be sorted by CustomerID

SELECT customer_id,company_name,region FROM northwind_db.customers
order by region desc ;

SELECT customer_id,
company_name,
region ,
case 
when region is null then 1
else 0
end as  orders

FROM northwind_db.customers
order by region desc ;


-- 25. High freight charges Some of the countries we ship to have very high freight charges. We'd like to investigate some more shipping options for our customers, to be able to offer them lower freight charges. Return the three ship countries
-- with the highest average freight overall, in descending order by average freight.

SELECT ship_country ,
avg(freight) as average
 FROM orders 
 group by ship_country 
order by average desc
limit 3;

-- 26. High freight charges - 2015 We're continuing on the question above on high freight charges. Now, instead of using all the orders we have, we only want to see orders from the year 2015

Select ship_country,
avg(freight) as average
 FROM orders 
 group by ship_country 
order by average desc ;

-- 27. High freight charges with between Another (incorrect) answer to the problem above is this:
-- Select Top 3
 -- ShipCountry
-- ,AverageFreight = avg(freight)
-- From Orders
-- Where
-- OrderDate between '1/1/2015' and '12/31/2015'
-- Group By ShipCountry
-- Order By AverageFreight desc;
-- Notice when you run this, it gives Sweden as the ShipCountry with the third highest freight charges. However, this is wrong - it should be France. What is the OrderID of the order that the (incorrect) answer above is missing?

-- 28. High freight charges - last year We're continuing to work on high freight charges. We now want to get the three ship countries with the highest average freight charges. But instead of filtering for a particular year, we want to use the last 12 months of order data, using as the end date the last OrderDate in Orders
Select ship_country,
avg(freight) as average
 FROM orders 
group by ship_country 
order by order_date ;


where order_date <='1998-05-06' and >= '1997-05-06';


-- 29. Inventory list We're doing inventory, and need to show information like the below, for all orders. Sort by OrderID and Product ID.

-- 30. Customers with no orders There are some customers who have never actually placed an order. Show these customers

Select
customers_customer_ID = Customers.CustomerID
,orders_customer_ID = Orders.CustomerID
From customers;
left join Orders
on Orders.CustomerID = Customers.CustomerID;

Select
customer_id,
order_id 
From orders
left join customers
on orders.customer_id=customers.customer_id;

-- 31. Customers with no orders for EmployeeID 4 One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. However, there are some customers who've never placed an order with her. Show only those customers who have never placed an order with her.



-- Assignment Big 6 Statements

-- 1

use mavenmoies;
SELECT first_name,last_name,email,store_id FROM staff;

-- 2
SELECT store_id, 
count(inventory_id) 
FROM inventory
group by store_id;

-- 3
SELECT store_id,active,count(customer_id)

FROM customer
group by store_id,active;

-- 4
SELECT count(email) FROM customer;

-- 5
SELECT store_id,
name as category_name,
count(title)
FROM inventory
join film
on inventory.film_id=film.film_id
join film_category
on film.film_id=film_category.film_id
join category
on film_category.category_id=category.category_id
group by store_id,category_name;

-- 6 



-- 7
SELECT staff_id,
avg(amount),
max(amount) FROM payment
group by staff_id;


-- 8
SELECT customer_id,
count(rental_id),
sum(amount) as highest_volume FROM payment
group by customer_id 
order by highest_volume ;

-- Assignment Joins


-- 1

SELECT store_id, address , district, district, city ,country 
FROM store
join address
on store.address_id=address.address_id
join city
on address.city_id=city.city_id
join country
on city.country_id=country.country_id;

-- 2
SELECT inventory_id,store_id,title,rating,rental_rate,replacement_cost
 FROM inventory
 join film
 on inventory.inventory_id=film.film_id;
 
 -- 3
 SELECT store_id,rating,count(inventory_id) 
 FROM inventory
 join film
 on inventory.film_id=film.film_id
 group by store_id,rating;
 
 -- ??4
 
 SELECT name,store_id,
 count(film_id)
 FROM category
 join film_category
 on category.category_id=film_category.category_id
 join film
 on film_category.film_id=film.film_id
 join inventory
 on film.film_id=inventory.film_id
 group by name,store_id ;
 
 
 
 -- 5
 
 SELECT customer_id,first_name as customer_name,
 active,
 address,city,country
 FROM customer
 join address
 on customer.address_id=address.address_id
 join city
on address.city_id=city.city_id
join country
on city.country_id=country.country_id
order by customer_id;








