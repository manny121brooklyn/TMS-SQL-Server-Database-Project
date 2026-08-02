
USE TMS_DB_TEST;
GO

-- =============================================
-- Driver Additional Constraints
-- =============================================

ALTER TABLE Drivers
ADD CONSTRAINT CK_Drivers_CDLClass
CHECK (CDLClass IN ('A','B','C'));
GO

ALTER TABLE Drivers
ADD CONSTRAINT CK_Drivers_LicenseState
CHECK (LEN(LicenseState) = 2);
GO


-- =============================================
-- Customer Constraints
-- =============================================

ALTER TABLE Customers
ADD CONSTRAINT CK_Customers_Type
CHECK (CustomerType IN 
(
'Agriculture',
'Broker',
'Commercial',
'Construction',
'Corporate',
'Healthcare',
'Industrial',
'Receiver',
'Retail',
'Shipper'
));
GO

ALTER TABLE Payments
ADD CONSTRAINT CK_PaymentDate
CHECK (PaymentDate >= '2020-01-01');