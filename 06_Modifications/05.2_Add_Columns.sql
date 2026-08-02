
USE TMS_DB_TEST;
GO

-- =============================================
-- Add missing columns to Drivers table
-- =============================================

ALTER TABLE Drivers
ADD CDLClass VARCHAR(1) NULL;
GO


ALTER TABLE Drivers
ADD LicenseState VARCHAR(2) NULL;
GO

