
USE TMS_DB_Test;
GO


-- =============================================
-- Operations Constraints
-- =============================================


-- Customers
-----------------------------------------------

ALTER TABLE Customers
ADD CONSTRAINT CK_Customers_Status
CHECK (Status IN ('Active', 'Inactive'));
GO


ALTER TABLE Customers 
ADD CONSTRAINT CK_Customers_CreditLimit
CHECK (CreditLimit >= 0)
GO


ALTER TABLE Customers
ADD CONSTRAINT UQ_Customers_CompanyPhone
UNIQUE (CompanyName, Phone);
GO


-- Shipments
-----------------------------------------------
/*
ALTER TABLE Shipments
ADD CONSTRAINT FK_Shipments_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
GO
*/


ALTER TABLE Shipments
ADD CONSTRAINT CK_Shipments_Weight
CHECK (Weight > 0)
GO


ALTER TABLE Shipments
ADD CONSTRAINT CK_Shipments_Status
CHECK (Status IN 
('Scheduled',
 'Pending',
 'Picked Up',
 'In Transit',
 'Delivered',
 'Delayed',
 'Cancelled'));
 GO


ALTER TABLE Shipments
ADD CONSTRAINT CK_Shipments_DateOrder
CHECK (DeliveryDate >= PickupDate);
GO


-- Dispatches
-----------------------------------------------

ALTER TABLE Dispatches
ADD CONSTRAINT FK_Dispatches_Shipments
FOREIGN KEY (ShipmentID) 
REFERENCES Shipments(ShipmentID);
GO



ALTER TABLE Dispatches 
ADD CONSTRAINT FK_Dispatches_Drivers
FOREIGN KEY (DriverID) 
REFERENCES Drivers(DriverID);
GO



ALTER TABLE Dispatches
ADD CONSTRAINT FK_Dispatches_Trucks
FOREIGN KEY (TruckID) 
REFERENCES Trucks(TruckID);
GO



ALTER TABLE Dispatches
ADD CONSTRAINT FK_Dispatches_Trailers
FOREIGN KEY (TrailerID) 
REFERENCES Trailers(TrailerID);
GO



ALTER TABLE Dispatches
ADD CONSTRAINT DF_Dispatches_CreatedDate
DEFAULT GETDATE() FOR CreatedDate;
GO



ALTER TABLE Dispatches
ADD CONSTRAINT UQ_Dispatches_Truck_Active
UNIQUE (TruckID, ShipmentID);
GO



ALTER TABLE Dispatches
ADD CONSTRAINT CK_Dispatches_Status
CHECK (Status IN ('Assigned', 'Picked Up', 'In Transit', 'Delivered', 'Cancelled'));
GO


-- Rates
-----------------------------------------------

ALTER TABLE Rates
ADD CONSTRAINT FK_Rates_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);
GO



ALTER TABLE Rates
ADD CONSTRAINT CK_Rates_RateType
CHECK (RateType IN ('PerMile', 'FlatRate', 'PerLoad', 'PerStop'));
GO


ALTER TABLE Rates
ADD CONSTRAINT CK_Rates_Dates
CHECK (ExpiryDate IS NULL OR ExpiryDate >= EffectiveDate);
GO



ALTER TABLE Rates
ADD CONSTRAINT CK_Rates_Fuel
CHECK (FuelSurchargePercent >= 0);
GO


-- MileageByState
-----------------------------------------------

ALTER TABLE MileageByState
ADD CONSTRAINT FK_MileageByState_Trucks
FOREIGN KEY (TruckID)
REFERENCES Trucks(TruckID);
GO



ALTER TABLE MileageByState
ADD CONSTRAINT FK_MileageByState_Drivers
FOREIGN KEY (DriverID)
REFERENCES Drivers(DriverID);
GO



ALTER TABLE MileageByState
ADD CONSTRAINT FK_MileageByState_Dispatches
FOREIGN KEY (DispatchID)
REFERENCES Dispatches(DispatchID);
GO
