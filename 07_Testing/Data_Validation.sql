
USE TMS_DB_TEST;
GO

-- Check missing customers before adding FK

SELECT DISTINCT CustomerID
FROM Shipments
WHERE CustomerID NOT IN
(
    SELECT CustomerID
    FROM Customers
);
GO


USE TMS_DB_TEST;
GO

SELECT TrailerID, TrailerNumber, CustomerID
FROM Trailers
WHERE CustomerID IS NOT NULL;


USE TMS_DB_TEST;
GO

SELECT LeasingCompanyID, CompanyName
FROM LeasingCompanies
ORDER BY LeasingCompanyID;
GO

SELECT LeasingCompanyID, CompanyName
FROM LeasingCompanies
ORDER BY LeasingCompanyID;


SELECT 
    t.TruckID,
    t.TruckNumber,
    t.LeasingCompanyID
FROM Trucks t
LEFT JOIN LeasingCompanies l
ON t.LeasingCompanyID = l.LeasingCompanyID
WHERE t.LeasingCompanyID IS NOT NULL
AND l.LeasingCompanyID IS NULL;
GO


--Find the bad Trailer records


USE TMS_DB_TEST;
GO

SELECT 
    TrailerID,
    TrailerNumber,
    CustomerID
FROM Trailers
WHERE CustomerID IS NOT NULL
AND CustomerID NOT IN
(
    SELECT CustomerID
    FROM Customers
);
GO

--Check Customers IDs
SELECT CustomerID, CompanyName
FROM Customers
ORDER BY CustomerID;
GO

SELECT 
    t.TrailerID,
    t.TrailerNumber,
    t.CustomerID
FROM Trailers t
LEFT JOIN Customers c
ON t.CustomerID = c.CustomerID
WHERE t.CustomerID IS NOT NULL
AND c.CustomerID IS NULL;
GO


SELECT CustomerID, CompanyName
FROM Customers
ORDER BY CustomerID;

select * from Shipments


--Find all duplicate payments
SELECT
    InvoiceID,
    PaymentDate,
    Amount,
    PaymentMethod,
    ReferenceNumber,
    COUNT(*) AS DuplicateCount
FROM Payments
GROUP BY
    InvoiceID,
    PaymentDate,
    Amount,
    PaymentMethod,
    ReferenceNumber
HAVING COUNT(*) > 1;


--delete duplicates from Payments

WITH DuplicatePayments AS
(
    SELECT
        *,
        ROW_NUMBER() OVER
        (
            PARTITION BY 
                InvoiceID,
                PaymentDate,
                Amount,
                PaymentMethod,
                ReferenceNumber
            ORDER BY PaymentID
        ) AS rn
    FROM Payments
)
DELETE FROM DuplicatePayments
WHERE rn > 1;

--Find bad data

SELECT
    p.PaymentID,
    p.InvoiceID,
    i.InvoiceDate,
    p.PaymentDate
FROM Payments p
JOIN Invoices i
ON p.InvoiceID = i.InvoiceID
WHERE p.PaymentDate < i.InvoiceDate;

--Check all payment problems
SELECT
    p.PaymentID,
    p.InvoiceID,
    i.InvoiceDate,
    i.DueDate,
    p.PaymentDate,
    p.Amount,
    i.TotalAmount
FROM Payments p
JOIN Invoices i
ON p.InvoiceID = i.InvoiceID
WHERE 
    p.PaymentDate < i.InvoiceDate
    OR p.Amount > i.TotalAmount;

--Verify if set payment amount equal to invoice total

SELECT
    p.PaymentID,
    p.Amount,
    i.TotalAmount
FROM Payments p
JOIN Invoices i
ON p.InvoiceID=i.InvoiceID
WHERE p.Amount > i.TotalAmount;

--Verify customers
SELECT CustomerID, CompanyName
FROM Customers
ORDER BY CustomerID;