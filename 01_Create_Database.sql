-- ===========================================
-- Project : E-Commerce Sales Analytics
-- Author  : Karthi
-- Role    : Data Analyst Portfolio Project
-- Database: ecommerce_sales_db
-- SQL Version : MySQL 8.0
-- ===========================================


create database ecommerce_sales_db;
use ecommerce_sales_db;

create table customers
    ( customer_id int primary key ,
    customer_name varchar(20) not null,
    gender varchar(10),
    age int,
    city varchar(50),
    state varchar(50),
    email varchar(50),
    phone varchar(15),
    join_date date ) ;
    
create table  products
    ( product_id int primary key,
    product_name varchar (50),
    category varchar (50),
    brand varchar (50),
    price decimal (10,2),
    stock_quantity int );
    
create table orders
   ( order_id int primary key,
    customer_id int,
    product_id int,
    quantity int,
    order_date date ,
    foreign key (customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id) ) ;
    
create table payments
    ( payment_id int primary key ,
    order_id int ,
    payment_method varchar(30),
    payment_status varchar(20),
    foreign key (order_id) references orders(order_id) );
