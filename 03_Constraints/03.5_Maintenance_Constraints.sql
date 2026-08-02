
USE TMS_DB_Test;
GO


-- =============================================
-- Maintenance Constraints
-- =============================================


-- Maintenance
-----------------------------------------------

ALTER TABLE Maintenance
ADD CONSTRAINT FK_Maintenance_Trucks
FOREIGN KEY (TruckID)
REFERENCES Trucks(TruckID);
GO



ALTER TABLE Maintenance
ADD CONSTRAINT CK_Maintenance_Cost
CHECK (Cost >= 0);
GO



ALTER TABLE Maintenance
ADD CONSTRAINT CK_Maintenance_ServiceType
CHECK (ServiceType IN
(
    'Oil Change',
    'Tire Replacement',
    'Brake Service',
    'Engine Repair',
    'Transmission Check',
    'Preventive Maintenance',
    'DOT Inspection',
    'Other'
));
GO



-- TruckMaintenanceRepairs
-----------------------------------------------

ALTER TABLE TruckMaintenanceRepairs
ADD CONSTRAINT FK_Repair_Trucks
FOREIGN KEY (TruckID)
REFERENCES Trucks(TruckID);
GO



ALTER TABLE TruckMaintenanceRepairs
ADD CONSTRAINT FK_Repair_Incidents
FOREIGN KEY (IncidentID)
REFERENCES DriverIncidents(IncidentID);
GO



ALTER TABLE TruckMaintenanceRepairs
ADD CONSTRAINT CK_Repair_Status
CHECK (Status IN 
(
'In Shop',
'In Repair',
'Waiting Parts',
'Completed',
'Cancelled'
));
GO



ALTER TABLE TruckMaintenanceRepairs
ADD CONSTRAINT CK_Repair_Cost
CHECK (Cost >= 0);
GO