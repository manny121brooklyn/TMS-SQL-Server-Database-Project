
USE TMS_DB_Test;
GO

-- =============================================
-- Fleet Management Tables
-- =============================================

CREATE TABLE Trucks
(
    TruckID INT IDENTITY(1,1) PRIMARY KEY,
    TruckNumber VARCHAR(20) NOT NULL UNIQUE,
    VIN VARCHAR(17) NOT NULL UNIQUE,
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    ModelYear INT NOT NULL,
    LicensePlate VARCHAR(20) NOT NULL UNIQUE,
    Status VARCHAR(20) NOT NULL,
    Mileage INT NOT NULL,
    LeasingCompanyID INT NULL,
    OwnershipType VARCHAR(30) NOT NULL
);



CREATE TABLE Trailers
(
    TrailerID INT IDENTITY(1,1) PRIMARY KEY,
    TrailerNumber VARCHAR(20) NOT NULL UNIQUE,
    VIN VARCHAR(17) NOT NULL UNIQUE,
    TrailerType VARCHAR(50) NOT NULL,
    Make VARCHAR(50),
    Model VARCHAR(50),
    ModelYear INT,
    Status VARCHAR(20) NOT NULL,
    LicensePlate VARCHAR(20),
    OwnershipType VARCHAR(20) NOT NULL,
    LeasingCompanyID INT NULL,
    CustomerID INT NULL
);



CREATE TABLE TruckTrailerAssignments
(
    AssignmentID INT IDENTITY(1,1) PRIMARY KEY,
    TruckID INT NOT NULL,
    TrailerID INT NOT NULL,
    AssignedDate DATETIME NOT NULL,
    UnassignedDate DATETIME NULL,
    AssignedByEmployeeID INT NULL,
    Notes VARCHAR(255)
);



CREATE TABLE DriverTruckAssignments
(
    AssignmentID INT IDENTITY(1,1) PRIMARY KEY,
    DriverID INT NOT NULL,
    TruckID INT NOT NULL,
    AssignedDate DATETIME NOT NULL,
    UnassignedDate DATETIME NULL,
    AssignmentType VARCHAR(20) NOT NULL,
    AssignedByEmployeeID INT NULL,
    Notes VARCHAR(255)
);



CREATE TABLE ParkingLots
(
    ParkingLotID INT IDENTITY(1,1) PRIMARY KEY,
    ParkingLotName VARCHAR(100) NOT NULL,
    Address VARCHAR(150) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State CHAR(2) NOT NULL,
    ZipCode VARCHAR(10),
    Capacity INT NOT NULL,
    MonthlyRent DECIMAL(10,2),
    LeaseStartDate DATE,
    LeaseEndDate DATE,
    ContactPerson VARCHAR(100),
    ContactPhone VARCHAR(20),
    Notes VARCHAR(255)
);



CREATE TABLE TruckParkingHistory
(
    ParkingHistoryID INT IDENTITY(1,1) PRIMARY KEY,
    TruckID INT NOT NULL,
    ParkingLotID INT NOT NULL,
    ParkedDate DATETIME NOT NULL,
    LeftDate DATETIME NULL,
    Notes VARCHAR(255)
);



CREATE TABLE Terminals
(
    TerminalID INT IDENTITY(1,1) PRIMARY KEY,
    TerminalName VARCHAR(100) NOT NULL,
    Address VARCHAR(150),
    City VARCHAR(50),
    State CHAR(2),
    ZipCode VARCHAR(10),
    Phone VARCHAR(20),
    ManagerName VARCHAR(100),
    Capacity INT,
    Notes VARCHAR(255)
);



CREATE TABLE LeasingCompanies
(
    LeasingCompanyID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    ContactPerson VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Website VARCHAR(100),
    Status VARCHAR(20) NOT NULL
);
