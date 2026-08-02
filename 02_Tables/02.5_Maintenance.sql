
USE TMS_DB_Test;
GO

-- =============================================
-- Maintenance Management
-- =============================================

CREATE TABLE Maintenance
(
    MaintenanceID INT IDENTITY(1,1) PRIMARY KEY,
    TruckID INT NOT NULL,
    ServiceDate DATE NOT NULL,
    ServiceType VARCHAR(50) NOT NULL,
    -- Oil Change, Tire Replacement, Engine Repair, etc.
    Cost DECIMAL(10,2) NOT NULL,
    Vendor VARCHAR(100) NOT NULL,
    Notes VARCHAR(255)
);



CREATE TABLE TruckMaintenanceRepairs
(
    RepairID INT IDENTITY(1,1) PRIMARY KEY,
    TruckID INT NOT NULL,
    IncidentID INT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    Status VARCHAR(20) NOT NULL,
    -- 'In Shop', 'In Repair', 'Waiting Parts', 'Completed'
    ShopName VARCHAR(100),
    ShopCity VARCHAR(50),
    RepairDescription VARCHAR(255),
    Cost DECIMAL(10,2) DEFAULT 0,
    DowntimeDays AS 
        CASE 
            WHEN EndDate IS NULL THEN NULL
            ELSE DATEDIFF(DAY, StartDate, EndDate)
        END
);