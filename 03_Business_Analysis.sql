-- Total Revenue
select sum(quantity * price ) as Total_Revenue
from orders 
inner join products
on orders.product_id = products.product_id ;

-- Top 5 Highest Spending Customers
select customer_name , sum(price * quantity) as Total_Amount
from orders
inner join customers
on orders.customer_id = customers.customer_id
inner join products
on orders.product_id = products.product_id
group by customer_name
order by Total_Amount desc
limit 5 ;

-- Highest Revenue Product
select product_name , sum(price * quantity) as Revenue
from orders 
inner join products
on orders.product_id = products.product_id
group by product_name 
order by Revenue desc
limit 1 ;

-- Category-wise Revenue
select category, sum(price * quantity) as Revenue
from orders
inner join products
on orders.product_id = products.product_id
group by category ;

-- City-wise Revenue
select city , sum(price * quantity) as Revenue
from orders
inner join customers
on orders.customer_id = customers.customer_id
inner join products
on orders.product_id = products.product_id
group by city ;

-- Monthly Revenue
select monthname(order_date) as month_ , sum(price * quantity) as Revenue
from orders
inner join products
on orders.product_id = products.product_id
group by monthname(order_date)
order by monthname(order_date) ;

-- Average Order Value
select  avg(quantity * price ) as avg_order_value
from orders
inner join products
on orders.product_id = products.product_id ;

-- Most Ordered Product
select product_name , sum(quantity) as most_order
from orders 
inner join products
on orders.product_id = products.product_id
group by product_name
order by most_order desc 
limit 1 ;

-- Top Brand by Revenue
select brand , sum(quantity * price ) as Revenue
from orders 
inner join products
on orders.product_id = products.product_id
group by brand
order by Revenue desc 
limit 1 ;

-- Payment Status
select payment_status , count(*)
from payments 
group by payment_status ;

-- Most Used Payment Method
select payment_method , count(*) as most_used
from payments
group by payment_method 
order by most_used desc
limit 1 ;

-- Customer Purchase Frequency
select customer_name , count(order_id) as Orders
from orders
inner join customers
on orders.customer_id = customers.customer_id 
group by customer_name ;

-- Highest Quantity Ordered Product
select product_name , sum(quantity) as High_Quantity
from orders 
inner join products
on orders.product_id = products.product_id
group by product_name
order by High_Quantity desc
limit 1 ;

-- Least Selling Product
select product_name , sum(quantity) as Least_Quantity
from orders 
inner join products
on orders.product_id = products.product_id
group by product_name
order by Least_Quantity asc
limit 1 ;

-- Average Product Price
select  avg(price) as avg_product_price
from products ;

-- Top 3 customers by revenue
select customer_name , sum(quantity * price) as Revenue
from orders
inner join customers 
on orders.customer_id = customers.customer_id 
inner join products
on orders.product_id = products.product_id 
group by customer_name 
order by Revenue desc
limit 3 ;

-- Top 3 cities by revenue
select city , sum(quantity * price) as Revenue
from orders
inner join customers 
on orders.customer_id = customers.customer_id 
inner join products
on orders.product_id = products.product_id 
group by city
order by Revenue desc
limit 3 ;

-- Revenue by payment method
select payment_method , sum( price * quantity) as Revenue
from orders
inner join products
on orders.product_id = products.product_id 
inner join payments
on orders.order_id = payments.order_id
group by payment_method ;

-- Completed payment revenue
select * from
 (select payment_status ,sum( price * quantity) as Revenue
from orders
inner join products
on orders.product_id = products.product_id 
inner join payments
on orders.order_id = payments.order_id 
group by payment_status ) as ord
where payment_status = 'Completed' ;

-- Pending payment revenue
select * from
 (select payment_status ,sum( price * quantity) as Revenue
from orders
inner join products
on orders.product_id = products.product_id 
inner join payments
on orders.order_id = payments.order_id 
group by payment_status ) as ord
where payment_status = 'Pending' ;

-- Failed payment revenue
select * from
 (select payment_status ,sum( price * quantity) as Revenue
from orders
inner join products
on orders.product_id = products.product_id 
inner join payments
on orders.order_id = payments.order_id 
group by payment_status ) as ord
where payment_status = 'Failed' ;

-- Highest priced product
select product_name , price
from products
order by price desc
limit 1 ;

-- Lowest priced product
select product_name , price
from products
order by price asc
limit 1 ;

-- Customers who purchased more than 3 products
select customer_name , sum(quantity) as products
from orders
inner join customers 
on orders.customer_id = customers.customer_id 
group by customer_name 
having sum(quantity) > 3 ;

-- Products that were never ordered
select product_name , order_id
from products
left join orders
on orders.product_id = products.product_id 
where order_id is null ;

-- Category-wise average product price
select category , avg(price)
from products
group by category ;

-- Brand-wise product count kaatu.
select brand , count(product_id) as product_count
from products
group by brand ;

-- Endha city-la adhigama orders vandhurukku?
select city , count(order_id) as high_order
from orders
inner join customers 
on orders.customer_id = customers.customer_id 
group by city
order by high_order desc 
limit 1 ;

-- Average quantity ordered per product
select product_name ,avg(quantity)as avg_quantity
from orders
inner join products
on orders.product_id = products.product_id 
group by product_name ;

-- Revenue greater than ₹50,000 generate pannura brands
select brand , sum(quantity * price) as Revenue
from orders
inner join products
on orders.product_id = products.product_id 
group by brand
having Revenue > 50000 ;

-- Completed payments-la mattum Top 5 customers by revenue kaatu.
select * from 
( select payment_status , customer_name , sum(quantity * price ) as Revenue
from orders
inner join payments
on orders.order_id = payments.order_id
inner join customers 
on orders.customer_id = customers.customer_id 
inner join products
on orders.product_id = products.product_id 
group by payment_status , customer_name 
order by Revenue desc
limit 5 ) as ord
where payment_status = 'Completed' ;

-- -- Pending payment irukkura customers list kaatu.
select * from 
        ( select payment_status , customer_name , sum(price * quantity) as status_
        from orders
        inner join payments
        on orders.order_id = payments.order_id
        inner join customers
        on orders.customer_id = customers.customer_id
        inner join products 
        on orders.product_id = products.product_id
        group by payment_status , customer_name ) as ord
        where payment_status = 'Pending' ;
        
-- Oru customer ethana different products purchase pannirukkaaru?
select customer_name , count(distinct product_id) as products
from orders
inner join customers
on  orders.customer_id = customers.customer_id
group by customer_name ;

-- Endha category-la adhigama products irukku?
select category , count(distinct product_id) as product_count
from products
group by category 
order by product_count desc
limit 1 ;

-- Average product price vida adhigama price irukkura products kaatu.
select * from products  where price > 
   ( select avg(price) from products ) ;
   
-- Top 3 brands by total quantity sold kaatu
 select brand , sum(quantity) as total_quantity
 from orders
 inner join products
 on orders.product_id = products.product_id 
 group by brand
 order by total_quantity desc
 limit 3 ;
 
 -- Month-wise total orders kaatu.
 select month(order_date) as Month_wise , count(order_id) , monthname(order_date)as month_name
 from orders
 group by month(order_date) , monthname(order_date)
 order by month(order_date) ;
 
 -- Customers who never placed an order kaatu.
 select customer_name , order_id
 from customers
 left join orders
 on customers.customer_id = orders.customer_id
 where order_id is null ;
 
 -- Products revenue-ku RANK() kudu.
 select product_name as products , sum(quantity * price) as Revenue , 
 rank() over(order by sum(quantity * price) desc) as Rank_
 from orders
 inner join products
 on orders.product_id = products.product_id
 group by product_name ;
 
 -- Ovvoru category-la highest revenue generate pannura product kaatu.
 select * from
           ( select category , product_name , sum(quantity * price) as revenue,
           row_number() over(partition by category order
           by sum(quantity * price) desc) as row_num
           from  orders
	        inner join products
            on orders.product_id = products.product_id
            group by category, product_name) as product_revenue
            where row_num =1 ;