
USE TMS_DB_Test;
GO


/*
 Drivers
 DriverDocuments
 DriverDrugTests
 DriverIncidents
 DriverTickets
 DriverSettlements
*/

-- =============================================
-- Employee Driver Data
-- =============================================

-- =============================================
-- Drivers Data
-- =============================================


INSERT INTO Drivers
(EmployeeID, CDLNumber, LicenseExpiration, HireDate, Status)
VALUES
(13, 'CDL100001', '2029-06-30', '2021-10-25', 'Active'),
(14, 'CDL100002', '2028-02-11', '2022-07-08', 'Active'),
(15, 'CDL100003', '2027-09-19', '2020-05-30', 'Active'),
(16, 'CDL100004', '2029-05-09', '2023-01-12', 'Inactive'),
(17, 'CDL100005', '2028-12-14', '2021-09-17', 'Inactive'),
(18, 'CDL100006', '2027-07-28', '2022-02-23', 'Inactive'),
(19, 'CDL100007', '2029-10-04', '2020-08-05', 'Inactive'),
(20, 'CDL100008', '2028-04-16', '2023-04-01', 'On Leave'),
(21, 'CDL100009', '2028-01-12', '2022-07-10', 'Active'),
(22, 'CDL100010', '2027-06-20', '2021-05-15', 'Active'),
(23, 'CDL100011', '2029-06-12', '2023-01-05', 'Active'),
(24, 'CDL100012', '2028-08-30', '2020-11-18', 'Inactive'),
(25, 'CDL100013', '2027-12-11', '2022-05-22', 'Active'),
(26, 'CDL100014', '2028-07-25', '2021-08-05', 'Active'),
(27, 'CDL100015', '2029-03-17', '2023-05-01', 'Inactive'),
(28, 'CDL100016', '2027-10-08', '2020-03-20', 'Inactive'),
(29, 'CDL100017', '2028-05-14', '2022-07-11', 'On Leave'),
(30, 'CDL100018', '2029-01-27', '2021-04-17', 'Active'),
(31, 'CDL100019', '2028-08-22', '2020-01-13', 'Active'),
(32, 'CDL100020', '2027-11-05', '2023-03-30', 'Active'),
(33, 'CDL100021', '2029-06-30', '2021-10-25', 'Inactive'),
(34, 'CDL100022', '2028-02-11', '2022-08-08', 'Active'),
(35, 'CDL100023', '2027-09-19', '2020-05-30', 'Active'),
(36, 'CDL100024', '2029-05-09', '2023-11-12', 'Inactive'),
(37, 'CDL100025', '2028-12-14', '2019-12-17', 'Inactive'),
(38, 'CDL100026', '2027-07-28', '2022-02-23', 'Inactive'),
(39, 'CDL100027', '2029-10-04', '2020-04-05', 'Active'),
(40, 'CDL100028', '2028-04-16', '2023-08-21', 'Inactive'),
(41, 'CDL100029', '2029-01-27', '2021-04-17', 'Active'),
(42, 'CDL100030', '2028-08-22', '2020-01-13', 'Active'),
(43, 'CDL100031', '2027-11-05', '2023-03-30', 'Active'),
(44, 'CDL100032', '2029-06-30', '2021-10-25', 'Inactive'),
(45, 'CDL100033', '2028-02-11', '2022-08-08', 'Active'),
(46, 'CDL100034', '2027-09-19', '2020-05-30', 'Active'),
(47, 'CDL100035', '2029-05-09', '2023-01-12', 'Inactive'),
(48, 'CDL100036', '2028-12-14', '2021-09-17', 'Inactive'),
(49, 'CDL100037', '2027-07-28', '2022-02-23', 'Inactive'),
(50, 'CDL100038', '2029-10-04', '2020-08-05', 'Active');
GO


-- =============================================
-- DriverDocuments Data
-- =============================================



INSERT INTO DriverDocuments
(DriverID, DocumentType, DocumentNumber, IssueDate, ExpiryDate, Status, Notes)
SELECT
    DriverID,
    'CDL',
    CONCAT('CDL-', FORMAT(DriverID,'000'), '-2024'),
    DATEADD(DAY, DriverID * 3, '2024-01-01'),
    DATEADD(YEAR,5,DATEADD(DAY, DriverID * 3, '2024-01-01')),
    'Valid',
    'Commercial Driver License'
FROM (
    SELECT TOP (28)
        ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) DriverID
    FROM sys.objects
) D;
GO

-----------------------------------------------------
-- Medical Card (2024)
-----------------------------------------------------
INSERT INTO DriverDocuments
(DriverID, DocumentType, DocumentNumber, IssueDate, ExpiryDate, Status, Notes)
SELECT
    DriverID,
    'Medical Card',
    CONCAT('MED-', FORMAT(DriverID,'000'), '-2024'),
    DATEADD(DAY, DriverID * 4, '2024-02-01'),
    DATEADD(YEAR,2,DATEADD(DAY, DriverID * 4, '2024-02-01')),
    'Expired',
    'DOT Medical Certificate'
FROM (
    SELECT TOP (28)
        ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) DriverID
    FROM sys.objects
) D;
GO

-----------------------------------------------------
-- Medical Card Renewal (2026)
-----------------------------------------------------
INSERT INTO DriverDocuments
(DriverID, DocumentType, DocumentNumber, IssueDate, ExpiryDate, Status, Notes)
SELECT
    DriverID,
    'Medical Card',
    CONCAT('MED-', FORMAT(DriverID,'000'), '-2026'),
    DATEADD(DAY, DriverID * 5, '2026-02-01'),
    DATEADD(YEAR,2,DATEADD(DAY, DriverID * 5, '2026-02-01')),
    'Valid',
    'Medical Card Renewal'
FROM (
    SELECT TOP (14)
        ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) DriverID
    FROM sys.objects
) D;
GO

-----------------------------------------------------
-- Background Check (2024)
-----------------------------------------------------
INSERT INTO DriverDocuments
(DriverID, DocumentType, DocumentNumber, IssueDate, ExpiryDate, Status, Notes)
SELECT
    DriverID,
    'Background Check',
    CONCAT('BG-', FORMAT(DriverID,'000'), '-2024'),
    DATEADD(DAY, DriverID * 2, '2024-01-15'),
    DATEADD(YEAR,2,DATEADD(DAY, DriverID * 2, '2024-01-15')),
    'Expired',
    'Pre-employment background check'
FROM (
    SELECT TOP (28)
        ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) DriverID
    FROM sys.objects
) D;
GO

-----------------------------------------------------
-- Background Check Renewal (2026)
-----------------------------------------------------
INSERT INTO DriverDocuments
(DriverID, DocumentType, DocumentNumber, IssueDate, ExpiryDate, Status, Notes)
SELECT
    DriverID,
    'Background Check',
    CONCAT('BG-', FORMAT(DriverID,'000'), '-2026'),
    DATEADD(DAY, DriverID * 3, '2026-01-15'),
    DATEADD(YEAR,2,DATEADD(DAY, DriverID * 3, '2026-01-15')),
    'Valid',
    'Background Check Renewal'
FROM (
    SELECT TOP (14)
        ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) DriverID
    FROM sys.objects
) D;
GO

-----------------------------------------------------
-- Passport (20 drivers)
-----------------------------------------------------
INSERT INTO DriverDocuments
(DriverID, DocumentType, DocumentNumber, IssueDate, ExpiryDate, Status, Notes)
SELECT
    DriverID,
    'Passport',
    CONCAT('PP-', FORMAT(DriverID,'000')),
    DATEADD(DAY, DriverID * 10, '2025-01-01'),
    DATEADD(YEAR,10,DATEADD(DAY, DriverID * 10, '2025-01-01')),
    'Valid',
    'Passport for international travel'
FROM (
    SELECT TOP (20)
        ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) DriverID
    FROM sys.objects
) D;
GO



-- =============================================
-- DriverDrugTests Data
-- =============================================


WITH N AS
(
    SELECT TOP (68)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
),
Base AS
(
    SELECT
        n,
        ((n - 1) % 28) + 1 AS DriverID,

        CASE
            WHEN n <= 28 THEN DATEADD(DAY, n * 9, '2024-01-01')
            WHEN n <= 48 THEN DATEADD(DAY, (n - 28) * 12, '2025-01-01')
            ELSE DATEADD(DAY, (n - 48) * 10, '2026-01-01')
        END AS TestDate
    FROM N
)

INSERT INTO DriverDrugTests
(
    DriverID,
    TestDate,
    TestType,
    Result,
    FacilityName,
    Notes
)
SELECT

    DriverID,

    TestDate,

    CASE
        WHEN n <= 10 THEN 'Pre-employment'
        WHEN n % 4 = 0 THEN 'Random'
        ELSE 'Annual'
    END,

    CASE
        WHEN n IN (18,52) THEN 'Fail'
        WHEN n IN (67,68) THEN 'Pending'
        ELSE 'Pass'
    END,

    CASE n % 5
        WHEN 0 THEN 'Concentra Medical Center'
        WHEN 1 THEN 'Quest Diagnostics'
        WHEN 2 THEN 'Labcorp'
        WHEN 3 THEN 'City Occupational Health'
        ELSE 'CareNow Occupational Medicine'
    END,

    CASE
        WHEN n IN (18,52) THEN 'Driver removed from safety-sensitive duties pending company policy.'
        WHEN n IN (67,68) THEN 'Awaiting laboratory confirmation.'
        ELSE 'No issues reported.'
    END
FROM Base
ORDER BY TestDate;
GO


-- =============================================
-- DriverIncidents Data
-- =============================================


WITH N AS (
    SELECT TOP (60)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
),
Base AS (
    SELECT
        n,
        (n % 38) + 1 AS DriverID,

        CASE
            WHEN n <= 20 THEN DATEADD(DAY, n * 7, '2024-01-01')
            WHEN n <= 45 THEN DATEADD(DAY, n * 5, '2025-01-01')
            ELSE DATEADD(DAY, n * 6, '2026-01-01')
        END AS IncidentDate
    FROM N
)
INSERT INTO DriverIncidents
(
    DriverID,
    IncidentDate,
    IncidentType,
    Severity,
    Description,
    Location,
    IsAtFault,
    InsuranceClaim
)
SELECT
    DriverID,
    IncidentDate,

    CASE
        WHEN n % 4 = 0 THEN 'Accident'
        WHEN n % 4 = 1 THEN 'Ticket'
        WHEN n % 4 = 2 THEN 'Violation'
        ELSE 'Inspection'
    END AS IncidentType,

    CASE
        WHEN n % 10 < 6 THEN 'Minor'
        WHEN n % 10 < 9 THEN 'Major'
        ELSE 'Critical'
    END AS Severity,

    CASE
        WHEN n % 4 = 0 THEN 'Minor collision during route'
        WHEN n % 4 = 1 THEN 'Speeding violation recorded'
        WHEN n % 4 = 2 THEN 'Logbook or lane violation'
        ELSE 'DOT roadside inspection issue'
    END AS Description,

    CASE
        WHEN n % 5 = 0 THEN 'New Jersey'
        WHEN n % 5 = 1 THEN 'New York'
        WHEN n % 5 = 2 THEN 'Pennsylvania'
        WHEN n % 5 = 3 THEN 'Ohio'
        ELSE 'Texas'
    END AS Location,

    CASE
        WHEN n % 10 < 6 THEN CASE WHEN n % 3 = 0 THEN 1 ELSE 0 END
        WHEN n % 10 < 9 THEN 1
        ELSE 1
    END AS IsAtFault,

    CASE
        WHEN n % 10 < 6 THEN 0
        ELSE 1
    END AS InsuranceClaim
FROM Base;
GO


-- =============================================
-- DriverTickets Data
-- =============================================


WITH N AS
(
    SELECT TOP (40)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
),
Base AS
(
    SELECT
        n,

        -- Drivers are not perfectly sequential
        ((n * 7) % 28) + 1 AS DriverID,

        CASE
            WHEN n <= 12 THEN DATEADD(DAY,(n*24)%365,'2024-01-01')
            WHEN n <= 28 THEN DATEADD(DAY,((n-12)*20)%365,'2025-01-01')
            ELSE DATEADD(DAY,((n-28)*22)%365,'2026-01-01')
        END AS TicketDate
    FROM N
)

INSERT INTO DriverTickets
(
    DriverID,
    TicketDate,
    ViolationType,
    Location,
    FineAmount,
    Points,
    Status
)

SELECT

    DriverID,

    TicketDate,

    CASE n % 7
        WHEN 0 THEN 'Speeding'
        WHEN 1 THEN 'Hours of Service Violation'
        WHEN 2 THEN 'Equipment Violation'
        WHEN 3 THEN 'Overweight'
        WHEN 4 THEN 'Lane Restriction'
        WHEN 5 THEN 'Seat Belt Violation'
        ELSE 'Improper Parking'
    END,

    CASE n % 6
        WHEN 0 THEN 'New Jersey'
        WHEN 1 THEN 'Pennsylvania'
        WHEN 2 THEN 'New York'
        WHEN 3 THEN 'Ohio'
        WHEN 4 THEN 'Texas'
        ELSE 'Illinois'
    END,

    CASE n % 7
        WHEN 0 THEN 225.00
        WHEN 1 THEN 450.00
        WHEN 2 THEN 180.00
        WHEN 3 THEN 750.00
        WHEN 4 THEN 275.00
        WHEN 5 THEN 125.00
        ELSE 150.00
    END,

    CASE n % 7
        WHEN 0 THEN 2
        WHEN 1 THEN 3
        WHEN 2 THEN 1
        WHEN 3 THEN 0
        WHEN 4 THEN 2
        WHEN 5 THEN 1
        ELSE 0
    END,

    CASE
        WHEN n % 10 < 7 THEN 'Paid'
        WHEN n % 10 < 9 THEN 'Open'
        ELSE 'Contested'
    END

FROM Base
ORDER BY TicketDate;
GO


-- =============================================
-- DriverSettlements Data
-- =============================================


WITH Weeks AS
(
    SELECT TOP (156)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS WeekNo
    FROM sys.objects
),
DriversList AS
(
    SELECT DriverID
    FROM Drivers
)

INSERT INTO DriverSettlements
(
    DriverID,
    PayPeriodStart,
    PayPeriodEnd,
    GrossPay,
    Bonus,
    Deductions,
    Reimbursements,
    NetPay,
    PaymentDate,
    Status,
    Notes
)
SELECT

    d.DriverID,

    DATEADD(WEEK, w.WeekNo, '2024-01-01') AS PayPeriodStart,

    DATEADD(DAY, 6, DATEADD(WEEK, w.WeekNo, '2024-01-01')) AS PayPeriodEnd,

    gp.GrossPay,

    b.Bonus,

    ded.Deductions,

    r.Reimbursements,

    CAST
    (
        gp.GrossPay
        + b.Bonus
        + r.Reimbursements
        - ded.Deductions
    AS DECIMAL(10,2)) AS NetPay,

    DATEADD(DAY, 7, DATEADD(WEEK, w.WeekNo, '2024-01-01')),

    CASE
        WHEN w.WeekNo > 150 THEN 'Pending'
        ELSE 'Paid'
    END,

    CASE
        WHEN b.Bonus > 0 THEN 'Safety bonus'
        WHEN ded.Deductions > 0 THEN 'Fuel advance deduction'
        WHEN r.Reimbursements > 0 THEN 'Travel reimbursement'
        ELSE 'Regular weekly settlement'
    END

FROM DriversList d
CROSS JOIN Weeks w

CROSS APPLY
(
    SELECT CAST
    (
        (
            CASE d.DriverID % 5
                WHEN 0 THEN 0.55
                WHEN 1 THEN 0.58
                WHEN 2 THEN 0.60
                WHEN 3 THEN 0.63
                ELSE 0.65
            END
        )
        *
        (1800 + ABS(CHECKSUM(NEWID())) % 1200)
    AS DECIMAL(10,2))
    AS GrossPay
) gp

CROSS APPLY
(
    SELECT
        CAST
        (
            CASE
                WHEN ABS(CHECKSUM(NEWID())) % 10 = 0
                    THEN 100 + ABS(CHECKSUM(NEWID())) % 201
                ELSE 0
            END
        AS DECIMAL(10,2))
        AS Bonus
) b

CROSS APPLY
(
    SELECT
        CAST
        (
            CASE
                WHEN ABS(CHECKSUM(NEWID())) % 5 = 0
                    THEN 25 + ABS(CHECKSUM(NEWID())) % 126
                ELSE 0
            END
        AS DECIMAL(10,2))
        AS Deductions
) ded

CROSS APPLY
(
    SELECT
        CAST
        (
            CASE
                WHEN ABS(CHECKSUM(NEWID())) % 8 = 0
                    THEN 20 + ABS(CHECKSUM(NEWID())) % 81
                ELSE 0
            END
        AS DECIMAL(10,2))
        AS Reimbursements
) r

ORDER BY
    d.DriverID,
    PayPeriodStart;
	GO