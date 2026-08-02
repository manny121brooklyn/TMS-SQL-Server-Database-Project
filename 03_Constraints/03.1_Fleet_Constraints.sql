
USE TMS_DB_Test;
GO

-- =============================================
-- Fleet Management Constraints
-- =============================================


-- Trucks
-----------------------------------------------


ALTER TABLE Trucks 
ADD CONSTRAINT CK_Trucks_Status
CHECK (Status IN ('Active', 'Inactive', 'Maintenance', 'Out of Service'));
GO



ALTER TABLE Trucks
ADD CONSTRAINT CK_Trucks_Mileage
CHECK (Mileage >= 0);
GO



ALTER TABLE Trucks 
ADD CONSTRAINT CK_Trucks_ModelYear
CHECK (ModelYear >= 1980 AND ModelYear <= YEAR(GETDATE()) + 1);
GO



ALTER TABLE Trucks 
ADD CONSTRAINT CK_VIN
CHECK (LEN(VIN) = 17);
GO


	
ALTER TABLE Trucks 
ADD CONSTRAINT CK_Trucks_OwnershipType
CHECK (OwnershipType IN ('Company', 'Leased', 'OwnerOperator'));
GO



ALTER TABLE Trucks
ADD CONSTRAINT FK_Trucks_LeasingCompanies
FOREIGN KEY (LeasingCompanyID)
REFERENCES LeasingCompanies(LeasingCompanyID);
GO



ALTER TABLE Trucks
ADD CONSTRAINT CK_Trucks_Mileage_NotFuture
CHECK (Mileage <= 2000000);
GO


-- Trailers
-----------------------------------------------

ALTER TABLE Trailers 
ADD CONSTRAINT FK_Trailers_LeasingCompanies
FOREIGN KEY (LeasingCompanyID)
REFERENCES LeasingCompanies(LeasingCompanyID);
GO



ALTER TABLE Trailers 
ADD CONSTRAINT FK_Trailers_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);
GO


ALTER TABLE Trailers
ADD CONSTRAINT CK_Trailers_OwnershipLogic
CHECK (
    (OwnershipType = 'Leased' AND LeasingCompanyID IS NOT NULL)
    OR
    (OwnershipType = 'Customer' AND CustomerID IS NOT NULL)
    OR
    (OwnershipType = 'Company' AND LeasingCompanyID IS NULL AND CustomerID IS NULL)
);
GO


ALTER TABLE Trailers
ADD CONSTRAINT CK_Trailers_Status
CHECK (Status IN ('Active', 'Inactive', 'Maintenance', 'Out of Service'));
GO



ALTER TABLE Trailers
ADD CONSTRAINT CK_Trailers_VIN
CHECK (LEN(VIN) = 17);
GO

-- Assignments
-----------------------------------------------

ALTER TABLE TruckTrailerAssignments
ADD CONSTRAINT FK_TTA_Truck
FOREIGN KEY (TruckID) REFERENCES Trucks(TruckID);
GO



ALTER TABLE TruckTrailerAssignments
ADD CONSTRAINT FK_TTA_Trailer
FOREIGN KEY (TrailerID) REFERENCES Trailers(TrailerID);
GO



ALTER TABLE TruckTrailerAssignments
ADD CONSTRAINT FK_TTA_AssignedBy
FOREIGN KEY (AssignedByEmployeeID) REFERENCES Employees(EmployeeID);
GO



ALTER TABLE TruckTrailerAssignments
ADD CONSTRAINT CK_TTA_DateLogic
CHECK (UnassignedDate IS NULL OR UnassignedDate >= AssignedDate);
GO



ALTER TABLE DriverTruckAssignments
ADD CONSTRAINT FK_DTA_Driver
FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID);
GO



ALTER TABLE DriverTruckAssignments
ADD CONSTRAINT FK_DTA_Truck
FOREIGN KEY (TruckID) REFERENCES Trucks(TruckID);
GO



ALTER TABLE DriverTruckAssignments
ADD CONSTRAINT FK_DTA_AssignedBy
FOREIGN KEY (AssignedByEmployeeID) REFERENCES Employees(EmployeeID);
GO


ALTER TABLE DriverTruckAssignments
ADD CONSTRAINT CK_DTA_DateLogic
CHECK (UnassignedDate IS NULL OR UnassignedDate >= AssignedDate);
GO



ALTER TABLE DriverTruckAssignments
ADD CONSTRAINT CK_DTA_Type
CHECK (AssignmentType IN ('Solo', 'TeamDriver1', 'TeamDriver2', 'Training', 'Relief'));
GO


-- Parking
-----------------------------------------------

ALTER TABLE TruckParkingHistory
ADD CONSTRAINT FK_TPH_Trucks
FOREIGN KEY (TruckID)
REFERENCES Trucks(TruckID);
GO



ALTER TABLE TruckParkingHistory
ADD CONSTRAINT FK_TPH_ParkingLots
FOREIGN KEY (ParkingLotID)
REFERENCES ParkingLots(ParkingLotID);
GO



ALTER TABLE TruckParkingHistory
ADD CONSTRAINT CK_TPH_Dates
CHECK (LeftDate IS NULL OR LeftDate >= ParkedDate);
GO


ALTER TABLE ParkingLots
ADD CONSTRAINT CK_ParkingLots_Capacity
CHECK (Capacity > 0);
GO



ALTER TABLE ParkingLots
ADD CONSTRAINT CK_ParkingLots_MonthlyRent
CHECK (MonthlyRent IS NULL OR MonthlyRent >= 0);
GO



ALTER TABLE ParkingLots
ADD CONSTRAINT CK_ParkingLots_LeaseDates
CHECK (
    LeaseEndDate IS NULL
    OR LeaseStartDate IS NULL
    OR LeaseEndDate >= LeaseStartDate
);
GO

-- Terminals
-----------------------------------------------
ALTER TABLE Terminals
ADD CONSTRAINT CK_Terminals_Capacity
CHECK (Capacity IS NULL OR Capacity > 0);
GO


ALTER TABLE Terminals
ADD CONSTRAINT UQ_Terminals_Name
UNIQUE (TerminalName);
GO