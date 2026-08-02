
USE TMS_DB_Test;
GO

-- =============================================
-- Transportation Operations
-- =============================================


CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(20),
	CustomerType VARCHAR(20) NOT NULL,
    CreditLimit DECIMAL(10,2) DEFAULT 0,
    PaymentTerms VARCHAR(50),
	Status VARCHAR(20) NOT NULL,
	TaxID VARCHAR(50)
);


CREATE TABLE Shipments
(
    ShipmentID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    PickupLocation VARCHAR(200) NOT NULL,
    DeliveryLocation VARCHAR(200) NOT NULL,
    PickupDate DATE NOT NULL,
    DeliveryDate DATE NULL,
    Weight INT NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Revenue DECIMAL(10,2)
);


CREATE TABLE Dispatches
(
    DispatchID INT IDENTITY(1,1) PRIMARY KEY,
    ShipmentID INT NOT NULL,
    DriverID INT NOT NULL,
    TruckID INT NOT NULL,
    TrailerID INT NULL,
    LoadDate DATE NOT NULL,
	CreatedDate DATETIME NULL,
    Status VARCHAR(20) NOT NULL
    
);


CREATE TABLE Rates
(
    RateID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NULL,
    OriginState VARCHAR(50),
    DestinationState VARCHAR(50),
    RateType VARCHAR(30) NOT NULL,
    -- PerMile, FlatRate, PerLoad, PerStop
    RateAmount DECIMAL(10,2) NOT NULL,
    FuelSurchargePercent DECIMAL(5,2) DEFAULT 0,
    EffectiveDate DATE NOT NULL,
    ExpiryDate DATE NULL,
    Notes VARCHAR(255)
);



CREATE TABLE MileageByState
(
    MileageByStateID  INT IDENTITY(1,1) PRIMARY KEY,
    TruckID INT NOT NULL,
    DriverID INT NOT NULL,
	DispatchID INT NULL,
    TripDate DATE NOT NULL,
    State CHAR(2) NOT NULL,
    MilesDriven DECIMAL(8,2) NOT NULL
);