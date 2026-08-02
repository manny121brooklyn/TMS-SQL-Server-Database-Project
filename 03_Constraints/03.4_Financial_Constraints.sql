
USE TMS_DB_Test;
GO


-- =============================================
-- Financial Constraints
-- =============================================

-- =============================================
-- Vendor Management
-- =============================================


-- Vendors
-----------------------------------------------

ALTER TABLE Vendors
ADD CONSTRAINT CK_Vendors_Type
CHECK (VendorType IN 
(
'Fuel',
'Maintenance',
'Toll',
'Parking',
'Insurance',
'Office',
'Technology',
'Other'
));
GO


ALTER TABLE Vendors
ADD CONSTRAINT UQ_Vendors_Name UNIQUE (VendorName);
GO



ALTER TABLE Vendors
ADD CONSTRAINT UQ_Vendors_Email UNIQUE (Email);
GO

-- =============================================
-- Expense Management
-- =============================================

-- Expenses
-----------------------------------------------

ALTER TABLE Expenses
ADD CONSTRAINT FK_Expenses_Trucks
FOREIGN KEY (TruckID)
REFERENCES Trucks(TruckID);
GO


ALTER TABLE Expenses
ADD CONSTRAINT CK_Expenses_Amount
CHECK (Amount >= 0);
GO



ALTER TABLE Expenses
ADD CONSTRAINT CK_Expenses_Type
CHECK (ExpenseType IN ('Fuel', 'Maintenance', 'Toll', 'Repair', 'Insurance', 'Tires', 'Phone',
'Office Rent', 'Office Supplies', 'Internet', 'Other'));
GO



/*ALTER TABLE Expenses
ADD CONSTRAINT FK_Expenses_Vendors
FOREIGN KEY (VendorID)
REFERENCES Vendors(VendorID);
GO*/


-- =============================================
-- Billing Management
-- =============================================

-- Invoices
-----------------------------------------------

ALTER TABLE Invoices
ADD CONSTRAINT FK_Invoices_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);
GO



ALTER TABLE Invoices
ADD CONSTRAINT CK_Invoices_Status
CHECK (Status IN ('Pending', 'Paid', 'Overdue', 'Cancelled'));
GO



ALTER TABLE Invoices
ADD CONSTRAINT CK_Invoices_Dates
CHECK (DueDate >= InvoiceDate);
GO



-- InvoiceDetails
-----------------------------------------------

ALTER TABLE InvoiceDetails
ADD CONSTRAINT FK_InvoiceDetails_Invoices
FOREIGN KEY (InvoiceID)
REFERENCES Invoices(InvoiceID);
GO



ALTER TABLE InvoiceDetails
ADD CONSTRAINT FK_InvoiceDetails_Shipments
FOREIGN KEY (ShipmentID)
REFERENCES Shipments(ShipmentID);
GO



ALTER TABLE InvoiceDetails
ADD CONSTRAINT CK_InvoiceDetails_Quantity
CHECK (Quantity > 0);
GO


-- Payments
-----------------------------------------------

ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Invoices
FOREIGN KEY (InvoiceID)
REFERENCES Invoices(InvoiceID);
GO



ALTER TABLE Payments
ADD CONSTRAINT CK_Payments_Amount
CHECK (Amount > 0);
GO



ALTER TABLE Payments
ADD CONSTRAINT CK_Payments_Method
CHECK (PaymentMethod IN 
('Cash', 'Bank Transfer', 'ACH', 'Check', 'Wire', 'Credit Card'));
GO


-- =============================================
-- Fuel Management
-- =============================================

-- FuelPurchases
-----------------------------------------------

ALTER TABLE FuelPurchases
ADD CONSTRAINT FK_FuelPurchases_Trucks
FOREIGN KEY (TruckID)
REFERENCES Trucks(TruckID);
GO



ALTER TABLE FuelPurchases
ADD CONSTRAINT FK_FuelPurchases_Drivers
FOREIGN KEY (DriverID)
REFERENCES Drivers(DriverID);
GO



ALTER TABLE FuelPurchases
ADD CONSTRAINT CK_FuelPurchases_Gallons
CHECK (Gallons > 0);
GO



ALTER TABLE FuelPurchases
ADD CONSTRAINT CK_FuelPurchases_Amount
CHECK (Amount >= 0);
GO



ALTER TABLE FuelPurchases
ADD CONSTRAINT CK_FuelPurchases_Price
CHECK (PricePerGallon IS NULL OR PricePerGallon > 0);
GO



ALTER TABLE FuelPurchases
ADD CONSTRAINT CK_FuelPurchases_Type
CHECK (FuelType IN ('Diesel', 'Gasoline', 'DEF'));
GO