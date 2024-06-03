-- Angela Fujihara
-- Mark Buster
-- AD350
-- 3 June 2024


INSERT INTO Products (Category, Brand, ProductName, Price, Color) 
VALUES 	('Camp & Hike', 'Surely', 'Hiking boots', 69.99, 'Brown'),
		('Camp & Hike', 'High Trail', 'Ultra-Light Tent', 199.99, 'Green'),
		('Climb', 'Mountain Grip', 'Pro Climbing Shoes', 89.99, 'Red'),
		('Run', 'Rapid Pace', "Men's Running Shoes", 49.99, 'Black'),
		('Snow', 'Frozen Paths', 'Insulated Snow Boots', 129.99, 'Brown'),
		('Travel', 'Globe Trotter', 'Durable Backpack', 79.99, 'Blue'),
		('Apparel', 'Outdoor Attire', 'Heavy-Duty Jacket', 89.99, 'Navy'),
		('Camp & Hike', "Nature's Sleep", 'Comfort Sleeping Bag', 69.99, 'Orange'),
		('Climb', 'Reach High', 'Climbing Helmet', 59.99, 'White'),
		('Snow', 'Frozen Paths', 'Unisex Ski Goggles', 29.99, 'Black');




INSERT INTO Users (LastName, FirstName, StreetAddress, City, State, ZipCode, PhoneNumber, EMAIL)
VALUES 	('Dorian', 'John', '123 Main St', 'Springfield', 'IL', 62704, 1234567890, 'john.dorian@example.com'),
		('Smith', 'Jane', '789 Second Street', 'Omaha', 'NE', 68102, 2025550127, 'jane.smith@example.com'),
		('Johnson', 'Robert', '456 Third Avenue', 'Austin', 'TX', 78704, 5125550139, 'robert.johnson@example.com'),
		('Williams', 'Patricia', '321 Fourth Blvd', 'Denver', 'CO', 80202, 3035550130, 'patricia.williams@example.com'),
		('Jones', 'Michael', '654 Fifth Lane', 'Seattle', 'WA', 98101, 2065550186, 'michael.jones@example.com'),
		('Brown', 'Linda', '987 Sixth Drive', 'Boston', 'MA', 02108, 6175550172, 'linda.brown@example.com'),
		('Davis', 'Elizabeth', '234 Seventh Street', 'Atlanta', 'GA', 30303, 4705550135, 'elizabeth.davis@example.com'),
		('Miller', 'James', '890 Eighth Avenue', 'Phoenix', 'AZ', 85003, 6025550193, 'james.miller@example.com'),
		('Wilson', 'Jennifer', '567 Ninth Blvd', 'San Francisco', 'CA', 94102, 4155550112, 'jennifer.wilson@example.com'),
		('Moore', 'Richard', '1230 Tenth Lane', 'Miami', 'FL', 33130, 7865550149, 'richard.moore@example.com');

INSERT INTO OrderItems (ProductID, Quantity)
VALUES 	(1, 3),
		(2, 7),
		(3, 12),
		(4, 1),
		(5, 6),
		(6, 2),
		(7, 4),
		(8, 23),
		(9, 1),
		(10, 6);


-- Assuming transaction amount is a total of product price and quantity
INSERT INTO CustOrders (OrderItemsID, UserID, TransactionAmount, PaymentType, OrderDate, FullfillmentStatus)
VALUES 	(1, 1, 209.75, 'CREDIT CARD', CURDATE(), 'Preparing for Shipment'),
		(2, 2, 91.55, 'DEBIT CARD', '2023-06-15', 'Shipped'),
		(3, 3, 120.30, 'CREDIT CARD', '2021-12-20', 'Preparing for Shipment'),
		(4, 4, 200.90, 'GIFT CARD', '2023-09-18', 'Shipped'),
		(5, 5, 170.65, 'DEBIT CARD', '2023-01-25', 'In Transit'),
		(6, 6, 74.95, 'GIFT CARD', '2024-02-27', 'Delivered'),
		(7, 7, 155.50, 'CREDIT CARD', '2022-06-30', 'Preparing for Shipment'),
		(8, 8, 49.45, 'DEBIT CARD', '2023-07-02', 'In Transit'),
		(9, 1, 60.10, 'GIFT CARD', '2024-01-03', 'Delivered'),
		(10, 2, 250.20, 'CREDIT CARD', CURDATE(), 'Preparing for Shipment');


INSERT INTO Reviews (ProductID, UserID, Stars, Review)
VALUES 	(1, 1, '4_STAR', 'Amazing product, would buy again!'),
		(2, 2, '4_STAR', 'Ultra-Light Tent made camping so much more enjoyable. Easy to pack and set up.'),
		(3, 3, '3_STAR', 'Pro Climbing Shoes are decent but I felt I needed more toe support.'),
		(4, 1, '4_STAR', "Men's Running Shoes are very comfortable. Did a marathon in them and they felt great."),
		(5, 4, '2_STAR', 'Insulated Snow Boots are nice and warm. Would like a bit more ankle support.'),
		(6, 5, '4_STAR', 'Durable Backpack is perfect for travel. Lots of compartments made organization easy.'),
		(7, 6, '3_STAR', 'Heavy-Duty Jacket is great for cold weather. Wish it had more pockets.'),
		(8, 7, '4_STAR', "Comfort Sleeping Bag is very cozy. It's lightweight and easy to pack for camping."),
		(9, 2, '2_STAR', 'Climbing Helmet is safe but a bit heavy. Could be more comfortable.'),
		(10, 8, '4_STAR', 'Unisex Ski Goggles have good visual clarity, but fog up occasionally.');

-- Because of the trigger set up between Products and Inventory this is how to insert data for ProductIDs that exist
UPDATE Inventory SET OnHandQty = 50, OnOrderQty = 5 WHERE ProductID = 1;
UPDATE Inventory SET OnHandQty = 60, OnOrderQty = 10 WHERE ProductID = 2;
UPDATE Inventory SET OnHandQty = 30, OnOrderQty = 7 WHERE ProductID = 3;
UPDATE Inventory SET OnHandQty = 40, OnOrderQty = 8 WHERE ProductID = 4;
UPDATE Inventory SET OnHandQty = 20, OnOrderQty = 4 WHERE ProductID = 5;
UPDATE Inventory SET OnHandQty = 35, OnOrderQty = 6 WHERE ProductID = 6;
UPDATE Inventory SET OnHandQty = 50, OnOrderQty = 9 WHERE ProductID = 7;
UPDATE Inventory SET OnHandQty = 45, OnOrderQty = 5 WHERE ProductID = 8;
UPDATE Inventory SET OnHandQty = 55, OnOrderQty = 3 WHERE ProductID = 9;
UPDATE Inventory SET OnHandQty = 60, OnOrderQty = 2 WHERE ProductID = 10;


INSERT INTO Shipment (CustomerOrdersID, UserID, TrackingNumber, ShipmentStatus)
VALUES 	(1, 1, 'ABC123', 'Preparing For Shipment'),
		(2, 2, 'DEF456', 'In Transit'),
		(3, 3, 'GHI789', 'Delivered'),
		(4, 4, 'JKL012', 'Preparing For Shipment'),
		(5, 5, 'MNO345', 'In Transit'),
		(6, 6, 'PQR678', 'Delivered'),
		(7, 7, 'STU901', 'Preparing For Shipment'),
		(8, 8, 'VWX234', 'In Transit'),
		(9, 1, 'YZA567', 'Delivered'),
		(10, 2, 'BCD890', 'Preparing For Shipment');





