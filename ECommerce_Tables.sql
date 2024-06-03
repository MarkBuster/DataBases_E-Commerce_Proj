-- Angela Fujihara
-- Mark Buster
-- AD350
-- 3 June 2024


CREATE DATABASE Off_The_Beaten_Path;
USE Off_The_Beaten_Path;

-- Holds for Product info for products carried
CREATE TABLE Products (
  ProductID 			INTEGER				NOT NULL AUTO_INCREMENT,
  Category 				ENUM 				('Apparel', 'Camp & Hike', 'Climb', 
											 'Run', 	'Snow', 	   'Travel'),
  Brand 				VARCHAR(35)			NOT NULL,
  ProductName 			VARCHAR(60)			NOT NULL,
  Price 				FLOAT				NOT NULL,
  Color 				VARCHAR(15),
  CONSTRAINT			PRODUCTID_PK		PRIMARY KEY (ProductID)
);


-- Captures User info 
CREATE TABLE Users (
  UserID 				INTEGER				NOT NULL AUTO_INCREMENT,
  LastName 				VARCHAR(40)			NOT NULL,
  FirstName 			VARCHAR(40)			NOT NULL,
  StreetAddress 		VARCHAR(125)		NOT NULL,
  StreetAddress_2 		VARCHAR(50),
  City 					VARCHAR(35)			NOT NULL,
  State 				CHAR(2)				NOT NULL,
  ZipCode 				INTEGER				NOT NULL,
  PhoneNumber 			VARCHAR(15),
  EMAIL 				VARCHAR(60)			NOT NULL,
  CONSTRAINT			USERID_PK			PRIMARY	KEY (UserID)
);

-- Holds OrderItem details for each customer order, also allowing for quantities > 1
CREATE TABLE OrderItems (
  OrderItemsID			INTEGER				NOT NULL AUTO_INCREMENT,
  ProductID 			INTEGER				NOT NULL,
  Quantity 				INTEGER				NOT NULL,
  CONSTRAINT 			ORDER_ITEM_PK 		PRIMARY KEY (OrderItemsID),
  CONSTRAINT 			ORDERITEMS_PRODUCTID_FK 		FOREIGN KEY (ProductID)
							REFERENCES  	PRODUCTS 	(ProductID)
  ON DELETE CASCADE
);

-- Captures both customer orders from order being placed to order being delivered.
-- This table also captures the Order History for each User. Once an item has been
-- set to 'delivered' it is now a part of the a users purchase history.
CREATE TABLE CustOrders (
  OrderID 				INTEGER				NOT NULL AUTO_INCREMENT,
  OrderItemsID 			INTEGER				NOT NULL,
  UserID 				INTEGER				NOT NULL,
  TransactionAmount 	FLOAT				NOT NULL,
  PaymentType 			ENUM				('CREDIT CARD', 'DEBIT CARD', 'GIFT CARD'),
  OrderDate 			DATE				NOT NULL,
  FullfillmentStatus	ENUM				('Preparing for Shipment', 'Shipped',
											 'In Transit',             'Delivered'),
  CONSTRAINT			ORDERID_PK			PRIMARY KEY		(OrderID),
  CONSTRAINT			CUSTORDERS_USERID_FK			FOREIGN KEY 	(UserID) 
							REFERENCES Users	(UserID),
  CONSTRAINT			CUSTORDERS_ORDERITEMS_FK		FOREIGN KEY 	(OrderItemsID) 
							REFERENCES OrderItems(OrderItemsID)
);

-- Captures reviews left by Users
CREATE TABLE Reviews (
  ReviewID 				INTEGER				NOT NULL AUTO_INCREMENT,
  ProductID 			INTEGER				NOT NULL,
  UserID 				INTEGER				NOT NULL,
  Stars 				ENUM				('1_STAR', '2_STAR', '3_STAR', '4_STAR'),
  Review 				VARCHAR(500),
  CONSTRAINT			REVIEWID_PK			PRIMARY KEY 	(ReviewID),
  CONSTRAINT			REVIEWS_PRODUCTID_FK		FOREIGN KEY 	(ProductID) 
							REFERENCES Products		(ProductID), 				-- changed Products to Inventory because
  CONSTRAINT			REVIEWS_USERID_FK			FOREIGN KEY 	(UserID) 
							REFERENCES Users		(UserID)
);

-- Captures inventory details for products carried
CREATE TABLE Inventory (
  ProductID 			INTEGER				NOT NULL,
  OnHandQty 			INTEGER				DEFAULT 0 NOT NULL,
  OnOrderQty 			INTEGER				DEFAULT 0 NOT NULL,
  CONSTRAINT 			INVENTORY_PRODUCT_ID_PK		PRIMARY KEY (ProductID),
  CONSTRAINT			INVENTORY_PRODUCTID_FK		FOREIGN KEY	(ProductID)
							REFERENCES	PRODUCTS	(ProductID)
  ON DELETE CASCADE
);

-- Provides shipment details for each order a User places
CREATE TABLE Shipment (
  ShipmentID 			INTEGER				NOT NULL AUTO_INCREMENT,
  CustomerOrdersID 		INTEGER				NOT NULL,
  UserID 				INTEGER				NOT NULL,
  TrackingNumber 		VARCHAR(30),
  ShipmentStatus 		ENUM				('Preparing For Shipment', 'Shipped',
											 'In Transit', 			   'Delivered'),
  CONSTRAINT			SHIPMENTID_PK			PRIMARY KEY 	(ShipmentID),
  CONSTRAINT			SHIPMENT_CUSTOMER_ORDERID_FK		FOREIGN KEY		(CustomerOrdersId) 		
							REFERENCES	CustOrders	(OrderId),				   					
  CONSTRAINT			SHIPMENT_USERID_FK				FOREIGN KEY		(UserID)
							REFERENCES	Users		(UserID)
  ON DELETE CASCADE
);

-- links the Products table to Inventory table, inserts to inventory are updated to products
DELIMITER //
CREATE TRIGGER insert_into_inventory
AFTER INSERT ON Products
FOR EACH ROW
BEGIN
INSERT INTO Inventory (ProductID, OnHandQty, OnOrderQty)
VALUES (NEW.ProductID, 0, 0)
ON DUPLICATE KEY UPDATE
OnHandQty = OnHandQty,
OnOrderQty = OnOrderQty;
END;
//
DELIMITER ;

-- drop database off_the_beaten_path; 