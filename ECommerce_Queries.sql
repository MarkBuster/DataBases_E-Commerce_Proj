-- Angela Fujihara
-- Mark Buster
-- AD350
-- 3 June 2024

USE off_the_beaten_path;

-- 1. List which products we currently have in inventory
SELECT 
    p.ProductID,
    p.Category,
    p.Brand,
    p.ProductName,
    p.Price,
    p.Color ,
    i.OnHandQty,
    i.OnOrderQty
FROM 
    Products p
LEFT JOIN 
    Inventory i ON p.ProductID = i.ProductID
WHERE 
    i.OnHandQty >= 0 OR i.OnHandQty IS NULL;
    
-- 2. Create new products
INSERT INTO Products (Category, Brand, ProductName, Price, Color)
VALUES 
    ('Apparel', 'Nike', 'Running Shoes', 79.99, 'Red');
    
-- 3. Modify the amount of a particular product that we have in inventory
-- a. This modifies on hand quantities
UPDATE Inventory
SET OnHandQty = 50
WHERE ProductID = 11;

-- b. Modifies on order quantities
UPDATE Inventory
SET OnOrderQty = 30
WHERE ProductID = 11;

-- 4. Delete a product from inventory
DELETE Inventory
FROM Inventory
JOIN Products ON Inventory.ProductID = Products.ProductID
WHERE Products.ProductID = 12
  AND Products.ProductName = 'test'
  AND Products.Brand = '';
  
  -- 4. Delete a product from inventory
DELETE Products
FROM Products
WHERE ProductID = 12
  AND ProductName = 'test'
  AND Brand = '';

-- 5. Get a list of the most popular products for a given time range
SELECT 
    p.ProductID,
    p.ProductName,
    p.Brand,
    p.Category,
    COUNT(oi.OrderItemsID) AS TotalOrders,
    SUM(oi.Quantity) AS TotalQuantitySold
FROM CustOrders co
JOIN OrderItems oi ON co.OrderItemsID = oi.OrderItemsID
JOIN Products p ON oi.ProductID = p.ProductID
WHERE co.OrderDate BETWEEN '2022-06-01' AND '2023-12-31'  -- Specify your desired date range here
GROUP BY 
    p.ProductID, p.ProductName, p.Brand, p.Category
ORDER BY 
    TotalQuantitySold DESC;

-- 6. Get a list of the least popular products for a given time range
SELECT 
    p.ProductID,
    p.ProductName,
    p.Brand,
    p.Category,
    COUNT(oi.OrderItemsID) AS TotalOrders,
    SUM(oi.Quantity) AS TotalQuantitySold
FROM CustOrders co
JOIN OrderItems oi ON co.OrderItemsID = oi.OrderItemsID
JOIN Products p ON oi.ProductID = p.ProductID
WHERE co.OrderDate 
BETWEEN '2023-01-01' AND '2023-12-31'  -- Specify your desired date range here
GROUP BY 
    p.ProductID, p.ProductName, p.Brand, p.Category
ORDER BY 
    TotalQuantitySold ASC;  -- Order by total quantity sold in ascending order
    
-- 7. Get a list of users who haven't purchased something in a few months to send promotional emails to
--    This should also include products that these users normally purchase

SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    u.EMAIL,
    p.ProductID,
    p.ProductName,
    p.Brand,
    p.Category,
    user_purchases.OrderDate AS LastOrderDate
FROM Users u
JOIN (
        SELECT DISTINCT UserID
        FROM CustOrders
        WHERE OrderDate < DATE_SUB(NOW(), INTERVAL 3 MONTH)
      ) inactive_users ON u.UserID = inactive_users.UserID
LEFT JOIN 
    (
        SELECT co.UserID, oi.ProductID, co.OrderDate
        FROM CustOrders co
        JOIN OrderItems oi ON co.OrderItemsID = oi.OrderItemsID
    ) user_purchases ON u.UserID = user_purchases.UserID
JOIN Products p ON user_purchases.ProductID = p.ProductID
ORDER BY u.UserID, p.ProductID;


