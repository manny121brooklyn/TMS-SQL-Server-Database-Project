
USE TMS_DB_Test;
GO

-- =============================================
-- Financial Management
-- =============================================



CREATE TABLE Vendors
(
    VendorID INT IDENTITY(1,1) PRIMARY KEY,
    VendorName VARCHAR(100) NOT NULL,
    VendorType VARCHAR(50) NOT NULL,
    -- Fuel, Maintenance, Toll, Parking, Insurance, Other
    ContactPerson VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(150),
    City VARCHAR(50),
    State VARCHAR(50),
    Notes VARCHAR(255)
);


CREATE TABLE Expenses
(
    ExpenseID INT IDENTITY(1,1) PRIMARY KEY,
    TruckID INT NULL,
    VendorName VARCHAR(100),
    ExpenseType VARCHAR(50),  -- Maintenance, Fuel, Toll, etc.
    Amount DECIMAL(10,2) NOT NULL,
    ExpenseDate DATE NOT NULL,
    Reference VARCHAR(100)  -- invoice number
);


CREATE TABLE Invoices
(
    InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    InvoiceDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    -- Pending, Paid, Overdue, Cancelled
    TotalAmount DECIMAL(10,2) NOT NULL DEFAULT 0,
    Notes VARCHAR(255)
);


CREATE TABLE InvoiceDetails
(
    InvoiceDetailID INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceID INT NOT NULL,
    ShipmentID INT NULL,
    Description VARCHAR(255) NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    Rate DECIMAL(10,2) NOT NULL,
    Amount AS (Quantity * Rate)
);


CREATE TABLE Payments
(
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(30) NOT NULL,
    -- Cash, Bank Transfer, ACH, Check, Wire, etc.
    ReferenceNumber VARCHAR(50),
    Notes VARCHAR(255)
);


CREATE TABLE FuelPurchases
(
    FuelID INT IDENTITY(1,1) PRIMARY KEY,
    TruckID INT NOT NULL,
    DriverID INT NOT NULL,
    FuelDate DATE NOT NULL,
    FuelType VARCHAR(20) DEFAULT 'Diesel',
    Gallons DECIMAL(10,2) NOT NULL,
    PricePerGallon DECIMAL(10,2),
    Amount DECIMAL(10,2) NOT NULL,
    StationName VARCHAR(100),
    City VARCHAR(50),
    State CHAR(2)

);