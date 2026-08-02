
USE TMS_DB_Test;
GO


/*
Shipments
Dispatches
TruckTrailerAssignments
DriverTruckAssignments
TruckParkingHistory
MileageByState
IFTAReports
IFTAReportDetails
*/

-- =============================================
-- Operations Data
-- =============================================

-- =============================================
-- Shipments Data
-- =============================================

WITH N AS (
    SELECT TOP (3000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)
INSERT INTO Shipments
(
    CustomerID,
    PickupLocation,
    DeliveryLocation,
    PickupDate,
    DeliveryDate,
    Weight,
    Status,
    Revenue
)
SELECT
    (n % 44) + 1 AS CustomerID,

    CASE 
        WHEN n % 6 = 0 THEN 'New York, NY'
        WHEN n % 6 = 1 THEN 'New Jersey, NJ'
        WHEN n % 6 = 2 THEN 'Chicago, IL'
        WHEN n % 6 = 3 THEN 'Dallas, TX'
        WHEN n % 6 = 4 THEN 'Atlanta, GA'
        ELSE 'Houston, TX'
    END AS PickupLocation,

    CASE 
        WHEN n % 6 = 0 THEN 'Miami, FL'
        WHEN n % 6 = 1 THEN 'Los Angeles, CA'
        WHEN n % 6 = 2 THEN 'Seattle, WA'
        WHEN n % 6 = 3 THEN 'Boston, MA'
        WHEN n % 6 = 4 THEN 'Phoenix, AZ'
        ELSE 'Denver, CO'
    END AS DeliveryLocation,

    CASE
        WHEN n <= 700 THEN DATEADD(DAY, n, '2024-01-01')
        WHEN n <= 2200 THEN DATEADD(DAY, n, '2025-01-01')
        ELSE DATEADD(DAY, n, '2026-01-01')
    END AS PickupDate,

    CASE
        WHEN n <= 700 THEN DATEADD(DAY, n + 2, '2024-01-01')
        WHEN n <= 2200 THEN DATEADD(DAY, n + 2, '2025-01-01')
        ELSE DATEADD(DAY, n + 2, '2026-01-01')
    END AS DeliveryDate,

    -- realistic freight weight (LTL / FTL mix)
    5000 + (n % 35000) AS Weight,

    CASE 
        WHEN n % 10 < 8 THEN 'Delivered'
        WHEN n % 10 = 8 THEN 'In Transit'
        ELSE 'Cancelled'
    END AS Status,

    -- realistic revenue per load
    ROUND(800 + (n % 4200), 2) AS Revenue
FROM N;
GO


-- =============================================
-- Dispatches Data
-- =============================================


WITH N AS (
    SELECT TOP (5000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)
INSERT INTO Dispatches
(
    ShipmentID,
    DriverID,
    TruckID,
    TrailerID,
    LoadDate,
    Status
)
SELECT
    -- Match ShipmentID range 1–3000
    (n % 3000) + 1 AS ShipmentID,

    (n % 38) + 1 AS DriverID,

    (n % 37) + 1 AS TruckID,

    CASE 
        WHEN n % 4 = 0 THEN NULL
        ELSE (n % 10) + 1
    END AS TrailerID,

    DATEADD(DAY, n % 365, '2024-01-01'),

    CASE 
        WHEN n % 5 = 0 THEN 'Assigned'
        WHEN n % 5 = 1 THEN 'Picked Up'
        WHEN n % 5 = 2 THEN 'In Transit'
        WHEN n % 5 = 3 THEN 'Delivered'
        ELSE 'Cancelled'
    END AS Status
FROM N;
GO


-- =============================================
-- TruckTrailerAssignments Data
-- =============================================

WITH N AS (
    SELECT TOP (3800)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
),
Base AS (
    SELECT
        n,
        (n % 37) + 1 AS TruckID,
        (n % 10) + 1 AS TrailerID,
        DATEADD(DAY, n, '2024-01-01') AS StartDate
    FROM N
)
INSERT INTO TruckTrailerAssignments
(
    TruckID,
    TrailerID,
    AssignedDate,
    UnassignedDate,
    AssignedByEmployeeID,
    Notes
)
SELECT
    TruckID,
    TrailerID,

    StartDate AS AssignedDate,

    DATEADD(DAY, 3 + (n % 7), StartDate) AS UnassignedDate,

    (n % 5) + 1 AS AssignedByEmployeeID,

    CASE 
        WHEN n % 7 = 0 THEN 'Yard swap'
        WHEN n % 9 = 0 THEN 'Maintenance change'
        ELSE 'Regular assignment'
    END AS Notes
FROM Base;
GO



-- =============================================
-- DriverTruckAssignments Data
-- =============================================


WITH N AS (
    SELECT TOP (2100)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
),
Base AS (
    SELECT
        n,
        (n % 38) + 1 AS DriverID,
        (n % 37) + 1 AS TruckID,
        DATEADD(DAY, n, '2024-01-01') AS StartDate
    FROM N
)
INSERT INTO DriverTruckAssignments
(
    DriverID,
    TruckID,
    AssignedDate,
    UnassignedDate,
    AssignmentType,
    AssignedByEmployeeID,
    Notes
)
SELECT
    DriverID,
    TruckID,

    StartDate AS AssignedDate,

    DATEADD(DAY, 7 + (n % 14), StartDate) AS UnassignedDate,

    CASE 
        WHEN n % 10 < 6 THEN 'Solo'
        WHEN n % 10 = 6 THEN 'Relief'
        WHEN n % 10 = 7 THEN 'Training'
        WHEN n % 10 = 8 THEN 'TeamDriver1'
        ELSE 'TeamDriver2'
    END AS AssignmentType,

    (n % 5) + 1 AS AssignedByEmployeeID,

    CASE 
        WHEN n % 9 = 0 THEN 'Driver reassigned due to route optimization'
        WHEN n % 13 = 0 THEN 'Truck maintenance swap'
        ELSE 'Regular rotation'
    END AS Notes
FROM Base;
GO


-- =============================================
-- TruckParkingHistory Data
-- =============================================
 
WITH Trucks AS (
    SELECT TOP (37)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS TruckID
    FROM sys.objects
),
Numbers AS (
    SELECT TOP (80)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
),
Base AS (
    SELECT
        t.TruckID,
        n.n,

        -- FORCE LIMIT inside 2024–2026 window
        DATEADD(
            DAY,
            ABS(CHECKSUM(NEWID())) % 1095,  -- 3 years ≈ 1095 days
            '2024-01-01'
        ) AS ParkedDate
    FROM Trucks t
    CROSS JOIN Numbers n
)
INSERT INTO TruckParkingHistory
(
    TruckID,
    ParkingLotID,
    ParkedDate,
    LeftDate,
    Notes
)
SELECT
    TruckID,

    (TruckID % 5) + 1 AS ParkingLotID,

    ParkedDate,

    DATEADD(DAY, 1 + (n % 5), ParkedDate) AS LeftDate,

    CASE 
        WHEN n % 11 = 0 THEN 'Maintenance parking'
        WHEN n % 9 = 0 THEN 'Waiting for dispatch'
        WHEN n % 13 = 0 THEN 'Weekend yard storage'
        ELSE 'Regular parking rotation'
    END AS Notes
FROM Base;
GO


-- =============================================
-- MileageByState Data
-- =============================================


WITH N AS (
    SELECT TOP (10500)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
),
Base AS (
    SELECT
        n,
        (n % 37) + 1 AS TruckID,
        (n % 28) + 1 AS DriverID,
        (n % 5000) + 1 AS DispatchID,

        CASE 
            WHEN n <= 3000 THEN DATEADD(DAY, n % 365, '2024-01-01')
            WHEN n <= 7500 THEN DATEADD(DAY, n % 365, '2025-01-01')
            ELSE DATEADD(DAY, n % 365, '2026-01-01')
        END AS TripDate
    FROM N
)
INSERT INTO MileageByState
(
    TruckID,
    DriverID,
    DispatchID,
    TripDate,
    State,
    MilesDriven
)
SELECT
    TruckID,
    DriverID,
    DispatchID,
    TripDate,

    CASE 
        WHEN n % 6 = 0 THEN 'NJ'
        WHEN n % 6 = 1 THEN 'NY'
        WHEN n % 6 = 2 THEN 'PA'
        WHEN n % 6 = 3 THEN 'OH'
        WHEN n % 6 = 4 THEN 'IL'
        ELSE 'TX'
    END AS State,

    50 + (n % 450) AS MilesDriven
FROM Base;
GO


-- =============================================
-- IFTAReports Data
-- =============================================


INSERT INTO IFTAReports
(
    Quarter,
    ReportYear,
    DateSubmitted,
    TotalMiles,
    TotalGallons,
    TaxDue,
    Status
)
VALUES
-- 2024 (full year)
(1, 2024, '2024-04-10', 120000, 18000, 3500, 'Filed'),
(2, 2024, '2024-07-10', 135000, 20000, 4200, 'Filed'),
(3, 2024, '2024-10-10', 128000, 19500, 3900, 'Filed'),
(4, 2024, '2025-01-10', 140000, 21000, 4500, 'Filed'),

-- 2025 (full year)
(1, 2025, '2025-04-10', 150000, 22000, 4800, 'Filed'),
(2, 2025, '2025-07-10', 155000, 23000, 5000, 'Filed'),
(3, 2025, '2025-10-10', 148000, 22500, 4700, 'Filed'),
(4, 2025, '2026-01-10', 160000, 24000, 5200, 'Filed'),

-- 2026 (partial year - realistic current year)
(1, 2026, '2026-04-10', 165000, 24500, 5300, 'Filed'),
(2, 2026, '2026-07-10', 170000, 25000, 5500, 'Filed');


-- =============================================
-- IFTAReportDetails Data
-- =============================================


WITH MileageAgg AS
(
    SELECT
        YEAR(TripDate) AS ReportYear,
        DATEPART(QUARTER, TripDate) AS Quarter,
        State,
        SUM(MilesDriven) AS TotalMiles
    FROM MileageByState
    GROUP BY
        YEAR(TripDate),
        DATEPART(QUARTER, TripDate),
        State
),
FuelAgg AS
(
    SELECT
        YEAR(FuelDate) AS ReportYear,
        DATEPART(QUARTER, FuelDate) AS Quarter,
        State,
        SUM(Gallons) AS TotalGallons
    FROM FuelPurchases
    GROUP BY
        YEAR(FuelDate),
        DATEPART(QUARTER, FuelDate),
        State
)

INSERT INTO IFTAReportDetails
(
    ReportID,
    State,
    TotalMiles,
    TaxableMiles,
    GallonsPurchased,
    TaxRate,
    TaxDue
)
SELECT
    r.ReportID,
    m.State,
    m.TotalMiles,
    m.TotalMiles,
    ISNULL(f.TotalGallons, 0),

    CASE m.State
        WHEN 'NJ' THEN 0.185
        WHEN 'NY' THEN 0.487
        WHEN 'PA' THEN 0.747
        WHEN 'OH' THEN 0.470
        ELSE 0.300
    END,

    0
FROM IFTAReports r
JOIN MileageAgg m
    ON m.ReportYear = r.ReportYear
    AND m.Quarter = r.Quarter
LEFT JOIN FuelAgg f
    ON f.ReportYear = r.ReportYear
    AND f.Quarter = r.Quarter
    AND f.State = m.State;
GO