create database project;
use project;



create table customers (
customer_id int primary key,
customer_name varchar(50),
email varchar(50),
city varchar (50),
Join_Date date
);

select * from customers;
insert into customers values (1001,"Salman Khan","salman@gmail.com","Mumbai","2026-01-01");

insert into customers values (1002,"Shahrukh Khan","shahrukh@gmail.com","Delhi","2026-01-05"),
(1003,"Aamir Khan","aamir@gmail.com","Chennai","2026-01-15"),
(1004,"Ranveer Singh","ranveer@gmail.com","Kolkata","2026-02-01"),
(1005,"Sanjay Dutt","dutt@gmail.com","Delhi","2026-02-10");

create table Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Brand VARCHAR(50),
    Price DECIMAL(10,2),
    StockQuantity INT
);

insert into Products values
(101, 'iPhone 15', 'Electronics', 'Apple', 79999.00, 25),
(102, 'Running Shoes', 'Fashion', 'Nike', 4999.00, 40),
(103, 'Bluetooth Speaker', 'Electronics', 'JBL', 2999.00, 30),
(104, 'Air Fryer', 'Home Appliances', 'Philips', 8999.00, 15),
(105, 'Face Wash', 'Beauty', 'Nivea', 299.00, 100);

select * from Products;

create table Sellers (
    SellerID INT PRIMARY KEY,
    SellerName VARCHAR(100),
    City VARCHAR(50),
    Rating DECIMAL(2,1),
    JoinDate DATE
);

insert into Sellers values
(201, 'TechWorld', 'Mumbai', 4.5, '2023-01-15'),
(202, 'FashionHub', 'Delhi', 4.2, '2022-11-20'),
(203, 'HomeNeeds', 'Bangalore', 3.8, '2023-03-10'),
(204, 'BeautyStore', 'Pune', 4.7, '2021-09-05'),
(205, 'GadgetZone', 'Hyderabad', 3.9, '2022-06-18');

select * from Sellers;

create table Orders (
    OrderID INT primary key,
    CustomerID INT,
    ProductID INT,
    SellerID INT,
    OrderDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10,2),
    OrderStatus VARCHAR(20),

    FOREIGN KEY (CustomerID) REFERENCES customers(customer_id),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID)
);

select * from Orders;

insert into Orders values
(301, 1001, 101, 201, '2025-05-01', 1, 79999.00, 'Completed'),
(302, 1002, 102, 202, '2025-05-03', 2, 9998.00, 'Completed'),
(303, 1003, 103, 205, '2025-05-05', 1, 2999.00, 'Cancelled'),
(304, 1004, 104, 203, '2025-05-06', 1, 8999.00, 'Pending'),
(305, 1005, 105, 204, '2025-05-07', 3, 897.00, 'Completed');

create table Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentMethod VARCHAR(30),
    PaymentStatus VARCHAR(20),
    PaymentDate DATE,

    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Payments VALUES
(401, 301, 'UPI', 'Success', '2025-05-01'),
(402, 302, 'Credit Card', 'Success', '2025-05-03'),
(403, 303, 'COD', 'Failed', '2025-05-05'),
(404, 304, 'Debit Card', 'Pending', '2025-05-06'),
(405, 305, 'UPI', 'Success', '2025-05-07');

select * from Payments;

create table Returns (
    ReturnID INT PRIMARY KEY,
    OrderID INT,
    ReturnReason VARCHAR(100),
    ReturnDate DATE,
    RefundAmount DECIMAL(10,2),

    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Returns VALUES
(501, 303, 'Damaged Product', '2025-05-08', 2999.00),
(502, 305, 'Wrong Item Delivered', '2025-05-10', 897.00);

select * from Returns;