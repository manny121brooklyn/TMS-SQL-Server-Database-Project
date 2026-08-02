
USE TMS_DB_TEST;
GO


--Find the bad Truck records
SELECT 
    TruckID,
    TruckNumber,
    LeasingCompanyID
FROM Trucks
WHERE LeasingCompanyID IS NOT NULL
AND LeasingCompanyID NOT IN
(
    SELECT LeasingCompanyID
    FROM LeasingCompanies
);
GO

--Check your LeasingCompanies IDs

SELECT LeasingCompanyID, CompanyName
FROM LeasingCompanies
ORDER BY LeasingCompanyID;
GO

-- Find all orphan foreign keys
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


--Check if Payments were made after Invoice date
SELECT
    p.PaymentID,
    p.InvoiceID,
    i.InvoiceDate,
    p.PaymentDate
FROM Payments p
JOIN Invoices i
ON p.InvoiceID = i.InvoiceID
WHERE p.PaymentDate < i.InvoiceDate;
GO



--check overpaid invoices
SELECT
    p.InvoiceID,
    SUM(p.Amount) AS TotalPaid,
    i.TotalAmount
FROM Payments p
JOIN Invoices i
ON p.InvoiceID = i.InvoiceID
GROUP BY 
    p.InvoiceID,
    i.TotalAmount
HAVING SUM(p.Amount) > i.TotalAmount;
GO