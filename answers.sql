--question 1
SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM
    ProductDetail
CROSS JOIN
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS numbers -- Adjust the number of UNION ALL based on the maximum number of products in a single row
WHERE
    LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
ORDER BY
    OrderID;

    --question 2
CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL
);
INSERT INTO Customers (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(255) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product), 
    FOREIGN KEY (OrderID) REFERENCES Customers(OrderID)
);

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

SELECT * FROM Customers;
SELECT * FROM OrderItems;

SELECT
    c.OrderID,
    c.CustomerName,
    oi.Product,
    oi.Quantity
FROM
    Customers c
JOIN
    OrderItems oi ON c.OrderID = oi.OrderID;