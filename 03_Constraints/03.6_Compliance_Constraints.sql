
USE TMS_DB_Test;
GO


-- =============================================
-- Compliance Constraints
-- =============================================


-- IFTAReports
-----------------------------------------------
ALTER TABLE IFTAReports
ADD CONSTRAINT CK_IFTAReports_Quarter
CHECK (Quarter BETWEEN 1 AND 4);
GO



ALTER TABLE IFTAReports
ADD CONSTRAINT CK_IFTAReports_Year
CHECK (ReportYear >= 2020);
GO



ALTER TABLE IFTAReports
ADD CONSTRAINT CK_IFTAReports_TotalMiles
CHECK (TotalMiles >= 0);
GO



ALTER TABLE IFTAReports
ADD CONSTRAINT CK_IFTAReports_TotalGallons
CHECK (TotalGallons >= 0);
GO



ALTER TABLE IFTAReports
ADD CONSTRAINT CK_IFTAReports_TaxDue
CHECK (TaxDue >= 0);
GO



ALTER TABLE IFTAReports
ADD CONSTRAINT CK_IFTAReports_Status
CHECK (Status IN ('Draft', 'Filed', 'Amended'));



-- IFTAReportDetails
-----------------------------------------------
--n/a


-- DriverDrugTests
-----------------------------------------------

ALTER TABLE DriverDrugTests
ADD CONSTRAINT FK_DriverDrugTests_Drivers
FOREIGN KEY (DriverID)
REFERENCES Drivers(DriverID);
GO



ALTER TABLE DriverDrugTests
ADD CONSTRAINT CK_DriverDrugTests_Result
CHECK (Result IN ('Pass', 'Fail', 'Pending'));
GO


ALTER TABLE DriverDrugTests
ADD CONSTRAINT CK_DriverDrugTests_Type
CHECK (TestType IN ('Pre-employment', 'Annual', 'Random'));



-- DriverIncidents
-----------------------------------------------

ALTER TABLE DriverIncidents
ADD CONSTRAINT FK_DriverIncidents_Drivers
FOREIGN KEY (DriverID)
REFERENCES Drivers(DriverID);
GO



ALTER TABLE DriverIncidents
ADD CONSTRAINT CK_DriverIncidents_Severity
CHECK (Severity IN ('Minor', 'Major', 'Critical'));
GO



ALTER TABLE DriverIncidents
ADD CONSTRAINT CK_DriverIncidents_Type
CHECK (IncidentType IN ('Accident', 'Ticket', 'Violation', 'Inspection'));



-- =============================================
-- Driver Tickets Constraints
-- =============================================


-- DriverTickets
-----------------------------------------------
-- Foreign Key
ALTER TABLE DriverTickets
ADD CONSTRAINT FK_DriverTickets_Drivers
FOREIGN KEY (DriverID)
REFERENCES Drivers(DriverID);
GO

-- Check Constraints

ALTER TABLE DriverTickets
ADD CONSTRAINT CK_DriverTickets_FineAmount
CHECK (FineAmount IS NULL OR FineAmount >= 0);
GO



ALTER TABLE DriverTickets
ADD CONSTRAINT CK_DriverTickets_Points
CHECK (Points IS NULL OR Points >= 0);
GO



ALTER TABLE DriverTickets
ADD CONSTRAINT CK_DriverTickets_Status
CHECK (Status IN ('Open', 'Paid', 'Dismissed', 'Contested', 'Resolved'));
GO