
USE TMS_DB_Test;
GO

-- =============================================
-- Employee and Driver Management
-- =============================================



CREATE TABLE Employees
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    JobTitle VARCHAR(100),
    HireDate DATE,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Salary DECIMAL(10,2),
    ManagerID INT NULL
);


CREATE TABLE Drivers
(
    DriverID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    CDLNumber VARCHAR(50) NOT NULL,
    LicenseExpiration DATE NOT NULL,
    HireDate DATE NOT NULL,
    Status VARCHAR(20) NOT NULL
);


CREATE TABLE DriverSettlements
(
    SettlementID INT IDENTITY(1,1) PRIMARY KEY,
    DriverID INT NOT NULL,
    PayPeriodStart DATE NOT NULL,
    PayPeriodEnd DATE NOT NULL,
    GrossPay DECIMAL(10,2) NOT NULL,
    Bonus DECIMAL(10,2) NOT NULL DEFAULT 0,
    Deductions DECIMAL(10,2) NOT NULL DEFAULT 0,
    Reimbursements DECIMAL(10,2) NOT NULL DEFAULT 0,
    NetPay DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    Notes VARCHAR(255)
);


CREATE TABLE DriverDocuments
(
    DocumentID INT IDENTITY(1,1) PRIMARY KEY,
    DriverID INT NOT NULL,
    DocumentType VARCHAR(50) NOT NULL,
    -- CDL, Medical Card, Passport, Background Check, etc.
    DocumentNumber VARCHAR(50),
    IssueDate DATE,
    ExpiryDate DATE,
    Status VARCHAR(20) NOT NULL DEFAULT 'Valid',
    -- Valid, Expired, Suspended
    Notes VARCHAR(255)
);
   

CREATE TABLE DriverDevices
(
    DeviceID INT IDENTITY(1,1) PRIMARY KEY,
    DriverID INT NOT NULL,
    DeviceType VARCHAR(50) NOT NULL,      -- Tablet, ELD, Fuel cards, Toll transponders (EZPass), Dash cameras, GPS devices
    Brand VARCHAR(50),
    Model VARCHAR(50),
    SerialNumber VARCHAR(100) UNIQUE,
    AssignedDate DATE NOT NULL,
    ReturnDate DATE NULL,
    Status VARCHAR(20) NOT NULL,          -- Assigned, Returned, Lost, Damaged
    Notes VARCHAR(255)

 );
