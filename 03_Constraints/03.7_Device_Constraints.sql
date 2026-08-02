
USE TMS_DB_Test;
GO


-- =============================================
-- Device Constraints
-- =============================================


-- FuelCards
-----------------------------------------------

ALTER TABLE FuelCards
ADD CONSTRAINT FK_FuelCards_Trucks
FOREIGN KEY (AssignedTruckID)
REFERENCES Trucks(TruckID);
GO



ALTER TABLE FuelCards
ADD CONSTRAINT CK_FuelCards_Status
CHECK (Status IN ('Active', 'Blocked', 'Lost', 'Expired'));
GO



ALTER TABLE FuelCards
ADD CONSTRAINT CK_FuelCards_Dates
CHECK (ExpiryDate IS NULL OR ExpiryDate >= IssueDate);
GO



-- TollDevices
-----------------------------------------------

ALTER TABLE TollDevices
ADD CONSTRAINT FK_TollDevices_Trucks
FOREIGN KEY (AssignedTruckID)
REFERENCES Trucks(TruckID);
GO



ALTER TABLE TollDevices
ADD CONSTRAINT CK_TollDevices_Status
CHECK (Status IN ('Active', 'Inactive', 'Lost', 'Blocked'));
GO



ALTER TABLE TollDevices
ADD CONSTRAINT CK_TollDevices_Dates
CHECK (ExpiryDate IS NULL OR ExpiryDate >= IssueDate);
GO


-- TollTransactions
-----------------------------------------------

ALTER TABLE TollTransactions
ADD CONSTRAINT FK_TollTransactions_Device
FOREIGN KEY (DeviceID)
REFERENCES TollDevices(DeviceID);
GO



ALTER TABLE TollTransactions
ADD CONSTRAINT FK_TollTransactions_Truck
FOREIGN KEY (TruckID)
REFERENCES Trucks(TruckID);
GO


ALTER TABLE TollTransactions
ADD CONSTRAINT CK_TollTransactions_Amount
CHECK (Amount >= 0);
GO

-- TruckDevices
-----------------------------------------------

ALTER TABLE TruckDevices
ADD CONSTRAINT FK_TruckDevices_Trucks
FOREIGN KEY (TruckID)
REFERENCES Trucks(TruckID);
GO


ALTER TABLE TruckDevices
ADD CONSTRAINT CK_TruckDevices_Status
CHECK (Status IN 
(
    'Active',
    'Lost',
    'Needs Repair',
    'Offline',
    'Operational',
    'Replaced',
    'Under Repair'
));
GO


ALTER TABLE TruckDevices
ADD CONSTRAINT CK_TruckDevices_DeviceType
CHECK (DeviceType IN 
(
    'GPS',
    'Dash Camera',
    'EZPass',
    'ELD',
    'Other'
));
GO