Use project;

-- Top Customers by Spending
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.CustomerID
GROUP BY c.customer_id, c.customer_name
ORDER BY TotalSpent DESC
LIMIT 3;

-- Best-Selling Products
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(o.Quantity) AS TotalSold
FROM Products p
JOIN Orders o
ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSold DESC
LIMIT 5;

-- Top Performing Sellers by Revenue
SELECT 
s.SellerID,
s.SellerName,
SUM(o.TotalAmount) AS TotalRevenue
FROM Sellers s
JOIN Orders o
ON s.SellerID = o.SellerID
WHERE o.OrderStatus = 'Completed'
GROUP BY s.SellerID, s.SellerName
ORDER BY TotalRevenue DESC
LIMIT 3;

-- Monthly Revenue Trend Analysis
SELECT 
MONTH(p.PaymentDate) AS MonthNo,
SUM(o.TotalAmount) AS MonthlyRevenue
FROM Orders o
JOIN Payments p
ON o.OrderID = p.OrderID
WHERE p.PaymentStatus = 'Success'
GROUP BY MONTH(p.PaymentDate)
ORDER BY MonthNo;

-- Most Preferred Payment Method
SELECT 
PaymentMethod,
COUNT(*) AS TotalTransactions,
ROUND(COUNT(*) * 100.0 /(SELECT COUNT(*) FROM Payments), 2) AS UsagePercentage
FROM Payments
GROUP BY PaymentMethod
ORDER BY TotalTransactions DESC;

-- Inactive Customers Analysis
SELECT 
c.customer_id,
c.customer_name
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.CustomerID
AND o.OrderDate >= CURDATE() - INTERVAL 5 DAY
WHERE o.OrderID IS NULL;

-- Category-wise Revenue Analysis
SELECT 
p.Category,
SUM(o.TotalAmount) AS TotalRevenue
FROM Products p
JOIN Orders o
ON p.ProductID = o.ProductID
WHERE o.OrderStatus = 'Completed'
GROUP BY p.Category
ORDER BY TotalRevenue DESC
LIMIT 1;

-- Customers with High Cancellation Rate
SELECT 
c.customer_id,
c.customer_name,    
COUNT(o.OrderID) AS TotalOrders,
SUM(
CASE 
WHEN o.OrderStatus = 'Cancelled' THEN 1
ELSE 0
END
) AS CancelledOrders,
ROUND(
SUM(
CASE 
WHEN o.OrderStatus = 'Cancelled' THEN 1
ELSE 0
END
) * 100.0 / COUNT(o.OrderID), 2
) AS CancellationRate
FROM Customers c
JOIN Orders o
ON c.customer_id = o.CustomerID
GROUP BY c.customer_id, c.customer_name
HAVING CancellationRate > 25;
