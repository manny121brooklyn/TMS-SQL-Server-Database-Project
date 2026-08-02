
USE TMS_DB_Test;
GO


/*
FuelPurchases
Expenses
Rates
Invoices
InvoiceDetails
Payments
*/

-- =============================================
-- Financial Data
-- =============================================

-- =============================================
-- FuelPurchases Data
-- =============================================

WITH N AS (
    SELECT TOP (11000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
),
Base AS (
    SELECT
        n,
        (n % 37) + 1 AS TruckID,
        (n % 28) + 1 AS DriverID,

        CASE 
            WHEN n <= 3500 THEN DATEADD(DAY, n % 365, '2024-01-01')
            WHEN n <= 8000 THEN DATEADD(DAY, n % 365, '2025-01-01')
            ELSE DATEADD(DAY, n % 365, '2026-01-01')
        END AS FuelDate
    FROM N
)
INSERT INTO FuelPurchases
(
    TruckID,
    DriverID,
    FuelDate,
    FuelType,
    Gallons,
    PricePerGallon,
    Amount,
    StationName,
    City,
    State
)
SELECT
    TruckID,
    DriverID,
    FuelDate,

    'Diesel',

    60 + (n % 100) AS Gallons,

    ROUND(3.20 + (n % 150) / 100.0, 2) AS PricePerGallon,

    ROUND((60 + (n % 100)) * (3.20 + (n % 150) / 100.0), 2) AS Amount,

    CASE 
        WHEN n % 5 = 0 THEN 'Shell'
        WHEN n % 5 = 1 THEN 'BP'
        WHEN n % 5 = 2 THEN 'Exxon'
        WHEN n % 5 = 3 THEN 'Chevron'
        ELSE 'Pilot Flying J'
    END AS StationName,

   CASE 
        WHEN n % 6 = 0 THEN 'Newark'
        WHEN n % 6 = 1 THEN 'New York'
        WHEN n % 6 = 2 THEN 'Philadelphia'
        WHEN n % 6 = 3 THEN 'Columbus'
        WHEN n % 6 = 4 THEN 'Houston'
        ELSE 'Chicago'
    END AS City,

    CASE 
        WHEN n % 6 = 0 THEN 'NJ'
        WHEN n % 6 = 1 THEN 'NY'
        WHEN n % 6 = 2 THEN 'PA'
        WHEN n % 6 = 3 THEN 'OH'
        WHEN n % 6 = 4 THEN 'TX'
        ELSE 'IL'
    END AS State
FROM Base;
GO


-- =============================================
-- Expenses Data
-- =============================================


WITH N AS
(
    SELECT TOP (1000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)

INSERT INTO Expenses
(
    TruckID,
    VendorName,
    ExpenseType,
    Amount,
    ExpenseDate,
    Reference
)
SELECT

    -- Office expenses are not tied to a truck
    CASE
        WHEN n % 12 IN (8,9,10,11) THEN NULL
        ELSE (n % 37) + 1
    END,

    CASE
        WHEN n % 12 = 0 THEN 'Pilot Flying J'
        WHEN n % 12 = 1 THEN 'Love''s Travel Stops'
        WHEN n % 12 = 2 THEN 'TA Petro'
        WHEN n % 12 = 3 THEN 'Rush Truck Centers'
        WHEN n % 12 = 4 THEN 'Goodyear Commercial Tire'
        WHEN n % 12 = 5 THEN 'EZPass'
        WHEN n % 12 = 6 THEN 'Brooklyn Office Landlord'
        WHEN n % 12 = 7 THEN 'Ohio Office Landlord'
        WHEN n % 12 = 8 THEN 'Verizon Business'
        WHEN n % 12 = 9 THEN 'Comcast Business'
        WHEN n % 12 = 10 THEN 'State Farm Commercial'
        ELSE 'Office Depot'
    END,

    CASE
        WHEN n % 12 = 0 THEN 'Fuel'
        WHEN n % 12 = 1 THEN 'Fuel'
        WHEN n % 12 = 2 THEN 'Fuel'
        WHEN n % 12 = 3 THEN 'Maintenance'
        WHEN n % 12 = 4 THEN 'Tires'
        WHEN n % 12 = 5 THEN 'Toll'
        WHEN n % 12 = 6 THEN 'Office Rent'
        WHEN n % 12 = 7 THEN 'Office Rent'
        WHEN n % 12 = 8 THEN 'Phone'
        WHEN n % 12 = 9 THEN 'Internet'
        WHEN n % 12 = 10 THEN 'Insurance'
        ELSE 'Office Supplies'
    END,

    CASE
        WHEN n % 12 IN (0,1,2)
            THEN ROUND(250 + RAND(CHECKSUM(NEWID())) * 700,2)

        WHEN n % 12 = 3
            THEN ROUND(300 + RAND(CHECKSUM(NEWID())) * 2700,2)

        WHEN n % 12 = 4
            THEN ROUND(400 + RAND(CHECKSUM(NEWID())) * 2200,2)

        WHEN n % 12 = 5
            THEN ROUND(15 + RAND(CHECKSUM(NEWID())) * 120,2)

        WHEN n % 12 IN (6,7)
            THEN 3500.00

        WHEN n % 12 = 8
            THEN 250.00

        WHEN n % 12 = 9
            THEN 180.00

        WHEN n % 12 = 10
            THEN 900.00

        ELSE
            ROUND(25 + RAND(CHECKSUM(NEWID())) * 175,2)
    END,

    CASE
        WHEN n <= 300
            THEN DATEADD(DAY, n % 365, '2024-01-01')

        WHEN n <= 700
            THEN DATEADD(DAY, n % 365, '2025-01-01')

        ELSE
            DATEADD(DAY, n % 365, '2026-01-01')
    END,

    CONCAT('EXP-', RIGHT('000000' + CAST(n AS VARCHAR(6)),6))

FROM N;
GO


-- =============================================
-- Rates Data
-- =============================================

WITH States AS
(
    SELECT 'NJ' AS S
    UNION ALL SELECT 'NY'
    UNION ALL SELECT 'PA'
    UNION ALL SELECT 'TX'
    UNION ALL SELECT 'IL'
    UNION ALL SELECT 'FL'
    UNION ALL SELECT 'GA'
    UNION ALL SELECT 'OH'
    UNION ALL SELECT 'CA'
),
RateTypes AS
(
    SELECT 'PerMile' AS RT
    UNION ALL SELECT 'FlatRate'
    UNION ALL SELECT 'PerLoad'
    UNION ALL SELECT 'PerStop'
),
Numbers AS
(
    SELECT TOP (120)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)

INSERT INTO Rates
(
    CustomerID,
    OriginState,
    DestinationState,
    RateType,
    RateAmount,
    FuelSurchargePercent,
    EffectiveDate,
    ExpiryDate,
    Notes
)
SELECT
    CASE 
        WHEN n % 4 = 0 THEN (n % 30) + 1
        ELSE NULL
    END AS CustomerID,

    s1.S AS OriginState,
    s2.S AS DestinationState,

    rt.RT AS RateType,

    CAST(
        CASE rt.RT
            WHEN 'PerMile' THEN 2.10 + (n % 90) * 0.01
            WHEN 'FlatRate' THEN 350 + (n % 1200)
            WHEN 'PerLoad' THEN 800 + (n % 2500)
            ELSE 50 + (n % 200)
        END
    AS DECIMAL(10,2)) AS RateAmount,

    CAST(
        CASE 
            WHEN n % 5 = 0 THEN 12.5
            WHEN n % 5 = 1 THEN 8.0
            WHEN n % 5 = 2 THEN 15.0
            ELSE 5.5
        END
    AS DECIMAL(5,2)) AS FuelSurchargePercent,

    DATEADD(DAY, n * 3, '2024-01-01') AS EffectiveDate,

    CASE 
        WHEN n % 6 = 0 THEN DATEADD(DAY, n * 3 + 180, '2024-01-01')
        ELSE NULL
    END AS ExpiryDate,

    CASE 
        WHEN rt.RT = 'PerMile' THEN 'Standard mileage-based rate'
        WHEN rt.RT = 'FlatRate' THEN 'Fixed lane pricing'
        WHEN rt.RT = 'PerLoad' THEN 'Full truckload rate'
        ELSE 'Stop charge rate'
    END AS Notes

FROM Numbers n
CROSS APPLY (SELECT TOP 1 S FROM States ORDER BY NEWID()) s1
CROSS APPLY (SELECT TOP 1 S FROM States ORDER BY NEWID()) s2
CROSS APPLY (SELECT TOP 1 RT FROM RateTypes ORDER BY NEWID()) rt;
GO


-- =============================================
-- Invoices Data
-- =============================================


WITH Numbers AS (
    SELECT TOP (300)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)
INSERT INTO Invoices
(
    CustomerID,
    InvoiceDate,
    DueDate,
    Status,
    TotalAmount,
    Notes
)
SELECT
    (n % 30) + 1 AS CustomerID,

    CASE 
        WHEN n <= 60 THEN DATEADD(DAY, n, '2024-01-01')
        WHEN n <= 210 THEN DATEADD(DAY, n - 60, '2025-01-01')
        ELSE DATEADD(DAY, n - 210, '2026-01-01')
    END AS InvoiceDate,

    CASE 
        WHEN n <= 60 THEN DATEADD(DAY, n + 30, '2024-01-01')
        WHEN n <= 210 THEN DATEADD(DAY, n - 60 + 30, '2025-01-01')
        ELSE DATEADD(DAY, n - 210 + 30, '2026-01-01')
    END AS DueDate,

    CASE 
        WHEN n % 10 < 6 THEN 'Paid'
        WHEN n % 10 < 8 THEN 'Pending'
        WHEN n % 10 = 8 THEN 'Overdue'
        ELSE 'Cancelled'
    END AS Status,

    ROUND(
        300 + (ABS(CHECKSUM(NEWID())) % 2200),
        2
    ) AS TotalAmount,

    CASE 
        WHEN n % 5 = 0 THEN 'Linehaul delivery invoice'
        WHEN n % 5 = 1 THEN 'Regional freight billing'
        WHEN n % 5 = 2 THEN 'Fuel surcharge included'
        WHEN n % 5 = 3 THEN 'Toll and accessorial charges'
        ELSE 'Standard shipment invoice'
    END AS Notes
FROM Numbers;
GO


-- =============================================
-- InvoiceDetails Data
-- =============================================

WITH N AS
(
    SELECT TOP (3000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)
INSERT INTO InvoiceDetails
(
    InvoiceID,
    ShipmentID,
    Description,
    Quantity,
    Rate
)
SELECT
    (n % 300) + 1,

    s.ShipmentID,

    CASE 
        WHEN n % 4 = 0 THEN 'Linehaul Freight Charge'
        WHEN n % 4 = 1 THEN 'Fuel Surcharge'
        WHEN n % 4 = 2 THEN 'Accessorial Fee'
        ELSE 'Detention Charge'
    END,

    (n % 5) + 1,

    CASE 
        WHEN n % 4 = 0 THEN 500 + (n % 1500)
        WHEN n % 4 = 1 THEN 50 + (n % 200)
        WHEN n % 4 = 2 THEN 25 + (n % 100)
        ELSE 100 + (n % 300)
    END

FROM N
CROSS APPLY
(
    SELECT TOP (1) ShipmentID
    FROM Shipments
    ORDER BY CHECKSUM(NEWID(), n)
) s;
GO


-- =============================================
-- Payments Data
-- =============================================

WITH N AS
(
    SELECT TOP (200)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
),
I AS
(
    SELECT InvoiceID,
           ROW_NUMBER() OVER (ORDER BY InvoiceID) AS rn
    FROM Invoices
)
INSERT INTO Payments
(
    InvoiceID,
    PaymentDate,
    Amount,
    PaymentMethod,
    ReferenceNumber,
    Notes
)
SELECT
    i.InvoiceID,
    DATEADD(DAY, n % 30, '2024-01-01'),
    500 + (n % 2000),

    CASE n % 4
        WHEN 0 THEN 'Wire'
        WHEN 1 THEN 'ACH'
        WHEN 2 THEN 'Check'
        ELSE 'Bank Transfer'
    END,

    CONCAT('REF-', 100000 + n),

    CASE n % 3
        WHEN 0 THEN 'Paid in full'
        WHEN 1 THEN 'Standard payment'
        ELSE 'Late payment'
    END
FROM N
JOIN I
    ON I.rn = (n % (SELECT COUNT(*) FROM Invoices)) + 1;
GO
