
USE TMS_DB_Test;
GO

-- =============================================
-- Compliance Management
-- =============================================

CREATE TABLE IFTAReports
(
    ReportID INT IDENTITY PRIMARY KEY,
    Quarter TINYINT,
    ReportYear INT,
    DateSubmitted DATE,
    TotalMiles DECIMAL(10,2),
    TotalGallons DECIMAL(10,2),
    TaxDue DECIMAL(10,2),
	Status VARCHAR(20) NOT NULL DEFAULT 'Filed'
);


CREATE TABLE IFTAReportDetails
(
    DetailID INT IDENTITY(1,1) PRIMARY KEY,
    ReportID INT NOT NULL,
    State CHAR(2) NOT NULL,
    TotalMiles DECIMAL(10,2) NOT NULL,
    TaxableMiles DECIMAL(10,2) NOT NULL,
    GallonsPurchased DECIMAL(10,2) NOT NULL,
    TaxRate DECIMAL(6,4) NOT NULL,
    TaxDue DECIMAL(10,2) NOT NULL
);


CREATE TABLE DriverDrugTests
(
    TestID INT IDENTITY(1,1) PRIMARY KEY,
    DriverID INT NOT NULL,
    TestDate DATE NOT NULL,
    TestType VARCHAR(30) NOT NULL,   -- 'Pre-employment', 'Annual', 'Random'
    Result VARCHAR(20) NOT NULL,     -- 'Pass', 'Fail', 'Pending'
    FacilityName VARCHAR(100),
    Notes VARCHAR(255)
);


CREATE TABLE DriverIncidents
(
    IncidentID INT IDENTITY(1,1) PRIMARY KEY,
    DriverID INT NOT NULL,
    IncidentDate DATE NOT NULL,
    IncidentType VARCHAR(30) NOT NULL,
    -- Accident, Ticket, Violation, Inspection, etc.
    Severity VARCHAR(20) NOT NULL,
    -- Minor, Major, Critical
    Description VARCHAR(255),
    Location VARCHAR(100),
    IsAtFault BIT NOT NULL DEFAULT 0,
    InsuranceClaim BIT NOT NULL DEFAULT 0
);



CREATE TABLE DriverTickets
(
    TicketID INT IDENTITY(1,1) PRIMARY KEY,
    DriverID INT NOT NULL,
    TicketDate DATE NOT NULL,
    ViolationType VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    FineAmount DECIMAL(10,2),
    Points INT,
    Status VARCHAR(20)
);