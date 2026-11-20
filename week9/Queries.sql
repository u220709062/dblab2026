use company;
DELIMITER $$
CREATE procedure SelectCustomerByCountry(IN c VARCHAR(45))
BEGIN
    SELECT*FROM customers
    WHERE Country = c;
    
END $$
DELIMITER ;

SET @country = "Spain";
SELECT @country;
CALL SelectCustomerByCountry(@country);
SELECT @country;

DELIMITER $$
CREATE PROCEDURE  GetOrderCountByShipper(IN shipper VARCHAR(45), OUT count INT)
BEGIN
     SELECT COUNT(OrderID) INTO count
     FROM Orders 
     JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
     WHERE ShipperName = shipper;
     
END $$ 
DELIMITER ;


SET @order_cnt = 0;
SELECT @order_cnt;
CALL GetOrderCountByShipper("United Package", @order_cnt);
SELECT @order_cnt;

DELIMITER $$
CREATE PROCEDURE  GetCustomerSalesOut(
  IN inCustomerID INT ,
  out outName VARCHAR(255),
  OUT outSales FLOAT )
  
  
BEGIN 

    SELECT CustomerName into outName  
    from Customers 
    where CustomerID = inCustomerID;
    SELECT IFNULL(SUM(p.Price*od.Quantity),0) INTO outSales
    from Orders o
    join OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON p.ProductID= od.ProductID
    where o.CustomerID = inCustomerID;

END $$
DELIMITER ;

CALL GetCustomerSalesOut(5, @name, @sales);
SELECT @name, @sales;
