
USE TMS_DB_Test;
GO

/*
Maintenance
TruckMaintenanceRepairs
*/

-- =============================================
-- Maintenance Data
-- =============================================

-- =============================================
-- Maintenance Seed Data
-- =============================================

WITH N AS (
    SELECT TOP (1000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
),
Base AS (
    SELECT
        n,
        (n % 37) + 1 AS TruckID,

        CASE 
            WHEN n <= 300 THEN DATEADD(DAY, n * 2, '2024-01-01')
            WHEN n <= 700 THEN DATEADD(DAY, n * 2, '2025-01-01')
            ELSE DATEADD(DAY, n * 2, '2026-01-01')
        END AS ServiceDate
    FROM N
)
INSERT INTO Maintenance
(
    TruckID,
    ServiceDate,
    ServiceType,
    Cost,
    Vendor,
    Notes
)
SELECT
    TruckID,
    ServiceDate,

    CASE 
        WHEN n % 6 = 0 THEN 'Oil Change'
        WHEN n % 6 = 1 THEN 'Tire Replacement'
        WHEN n % 6 = 2 THEN 'Brake Service'
        WHEN n % 6 = 3 THEN 'Engine Repair'
        WHEN n % 6 = 4 THEN 'Transmission Check'
        ELSE 'DOT Inspection'
    END AS ServiceType,

    CASE 
        WHEN n % 6 = 0 THEN 250 + (n % 100)
        WHEN n % 6 = 1 THEN 800 + (n % 300)
        WHEN n % 6 = 2 THEN 600 + (n % 250)
        WHEN n % 6 = 3 THEN 1500 + (n % 2000)
        WHEN n % 6 = 4 THEN 400 + (n % 500)
        ELSE 150 + (n % 200)
    END AS Cost,

    CASE 
        WHEN n % 5 = 0 THEN 'Penske Truck Service'
        WHEN n % 5 = 1 THEN 'TA Truck Service'
        WHEN n % 5 = 2 THEN 'Love’s Repair Center'
        WHEN n % 5 = 3 THEN 'Local Garage NJ'
        ELSE 'Fleet Maintenance LLC'
    END AS Vendor,

    CASE 
        WHEN n % 9 = 0 THEN 'Preventive maintenance'
        WHEN n % 11 = 0 THEN 'Emergency repair'
        ELSE 'Scheduled service'
    END AS Notes
FROM Base;
GO


-- =============================================
-- TruckMaintenanceRepairs Seed Data
-- =============================================


WITH N AS (
    SELECT TOP (190)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
),
Base AS (
    SELECT
        n,

        -- weighted truck failure (some trucks break more often)
        CASE 
            WHEN n % 11 = 0 THEN 5
            WHEN n % 13 = 0 THEN 12
            WHEN n % 17 = 0 THEN 22
            WHEN n % 19 = 0 THEN 8
            ELSE (ABS(CHECKSUM(NEWID())) % 37) + 1
        END AS TruckID,

        CASE 
            WHEN n <= 60 THEN DATEADD(DAY, (n * 3), '2024-01-10')
            WHEN n <= 140 THEN DATEADD(DAY, (n * 3), '2025-01-10')
            ELSE DATEADD(DAY, (n * 3), '2026-01-10')
        END AS StartDate
    FROM N
)
INSERT INTO TruckMaintenanceRepairs
(
    TruckID,
    IncidentID,
    StartDate,
    EndDate,
    Status,
    ShopName,
    ShopCity,
    RepairDescription,
    Cost
)
SELECT
    TruckID,

    NULL,

    StartDate,

    CASE 
        WHEN n % 6 = 0 THEN DATEADD(DAY, 1 + (n % 3), StartDate)
        WHEN n % 7 = 0 THEN DATEADD(DAY, 3 + (n % 5), StartDate)
        WHEN n % 9 = 0 THEN NULL
        ELSE DATEADD(DAY, 2 + (n % 4), StartDate)
    END AS EndDate,

    CASE 
        WHEN n % 10 = 0 THEN 'Waiting Parts'
        WHEN n % 9 = 0 THEN 'In Shop'
        WHEN n % 8 = 0 THEN 'In Repair'
        ELSE 'Completed'
    END AS Status,

    CASE 
        WHEN n % 5 = 0 THEN 'Penske Truck Service'
        WHEN n % 5 = 1 THEN 'TA Truck Service'
        WHEN n % 5 = 2 THEN 'Love’s Repair Center'
        WHEN n % 5 = 3 THEN 'Local Garage NJ'
        ELSE 'Fleet Maintenance LLC'
    END AS ShopName,

    CASE 
        WHEN n % 4 = 0 THEN 'New Jersey'
        WHEN n % 4 = 1 THEN 'New York'
        WHEN n % 4 = 2 THEN 'Pennsylvania'
        ELSE 'Delaware'
    END AS ShopCity,

    CASE 
        WHEN n % 6 = 0 THEN 'Engine repair'
        WHEN n % 6 = 1 THEN 'Transmission issue'
        WHEN n % 6 = 2 THEN 'Brake system failure'
        WHEN n % 6 = 3 THEN 'Electrical issue'
        WHEN n % 6 = 4 THEN 'Accident damage'
        ELSE 'General repair'
    END AS RepairDescription,

    CASE 
        WHEN n % 6 = 0 THEN 2500 + (n % 3000)
        WHEN n % 6 = 1 THEN 1800 + (n % 2000)
        WHEN n % 6 = 2 THEN 900 + (n % 1200)
        WHEN n % 6 = 3 THEN 1200 + (n % 1500)
        WHEN n % 6 = 4 THEN 3000 + (n % 4000)
        ELSE 500 + (n % 800)
    END AS Cost
FROM Base;
GO