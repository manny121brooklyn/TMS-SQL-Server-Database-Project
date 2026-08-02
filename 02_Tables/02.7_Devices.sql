
USE TMS_DB_Test;
GO

-- =============================================
-- Device Management
-- =============================================


CREATE TABLE FuelCards
(
    CardID INT IDENTITY(1,1) PRIMARY KEY,
    CardNumber VARCHAR(20) NOT NULL UNIQUE,
    CardProvider VARCHAR(30) NOT NULL DEFAULT 'WEX',
    AssignedTruckID INT NULL,
    IssueDate DATE NOT NULL,
    ExpiryDate DATE NULL,
    Status VARCHAR(20) NOT NULL,
    -- Active, Blocked, Lost, Expired
    DailyLimit DECIMAL(10,2) NULL
);



CREATE TABLE TollDevices
(
    DeviceID INT IDENTITY(1,1) PRIMARY KEY,
    Provider VARCHAR(20) NOT NULL,
    -- 'EZPass', 'PrePass'
    DeviceNumber VARCHAR(30) NOT NULL UNIQUE,
    AssignedTruckID INT NULL,
    IssueDate DATE NOT NULL,
    ExpiryDate DATE NULL,
    Status VARCHAR(20) NOT NULL,
    -- Active, Inactive, Lost, Blocked
);



CREATE TABLE TollTransactions
(
    TollID INT IDENTITY(1,1) PRIMARY KEY,
    DeviceID INT NOT NULL,
    TruckID INT NOT NULL,
    TollDate DATETIME NOT NULL,
    Location VARCHAR(100),
    Amount DECIMAL(10,2) NOT NULL
);


CREATE TABLE TruckDevices
(
    TruckDeviceID INT IDENTITY(1,1) PRIMARY KEY,
    TruckID INT NOT NULL,
    DeviceType VARCHAR(50) NOT NULL,   -- GPS, Dash Camera, EZPass
    Brand VARCHAR(50),
    Model VARCHAR(50),
    SerialNumber VARCHAR(100) UNIQUE,
    InstallDate DATE NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Notes VARCHAR(255)
);