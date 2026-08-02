
USE TMS_DB_TEST;
GO


-- =============================================
-- Update missing driver CDL information
-- =============================================

UPDATE Drivers
SET CDLClass = 'A',
    LicenseState = 'NY'
WHERE CDLClass IS NULL
   OR LicenseState IS NULL;
GO


-- =============================================
-- Fix Customer IDs after migrating seed data
-- Preserve original CustomerID values
-- =============================================

USE TMS_DB_TEST;
GO

DELETE FROM Trailers;
GO

DELETE FROM Customers;
GO

EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
GO

DELETE FROM Trailers;
DELETE FROM Shipments;
DELETE FROM Rates;
DELETE FROM Invoices;
DELETE FROM Customers;
GO

-------Disable constraints
USE TMS_DB_TEST;
GO

EXEC sp_MSforeachtable 
'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
GO

----remove all data from every table
EXEC sp_MSforeachtable 'DELETE FROM ?';
GO

--Delete child data 

DELETE FROM Trucks;
DELETE FROM LeasingCompanies;
GO

--Reset identity
DBCC CHECKIDENT ('LeasingCompanies', RESEED, 0);
GO

-----Delete child table
DELETE FROM Trailers;
DELETE FROM Customers;
GO

--Reset Customers identity
DBCC CHECKIDENT ('Customers', RESEED, 0);
GO

--Make payment happen 5 days after invoice
UPDATE p
SET PaymentDate = DATEADD(DAY, 5, i.InvoiceDate)
FROM Payments p
JOIN Invoices i
ON p.InvoiceID = i.InvoiceID;
GO

--Fix payment dates
UPDATE p
SET PaymentDate = i.InvoiceDate
FROM Payments p
JOIN Invoices i
ON p.InvoiceID = i.InvoiceID
WHERE p.PaymentDate < i.InvoiceDate;
GO