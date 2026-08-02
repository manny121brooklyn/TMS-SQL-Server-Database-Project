
USE TMS_DB_Test;
GO

/*
FuelCards
TollDevices
TollTransactions
DriverDevices
TruckDevices
*/

-- =============================================
-- Device Data
-- =============================================

-- =============================================
-- FuelCards Seed Data
-- =============================================

WITH Trucks AS
(
    SELECT TOP (37)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS TruckID
    FROM sys.objects
)

-------------------------------------------------
-- 1. INITIAL CARDS (2024)
-------------------------------------------------
INSERT INTO FuelCards
(
    CardNumber,
    CardProvider,
    AssignedTruckID,
    IssueDate,
    ExpiryDate,
    Status,
    DailyLimit
)
SELECT
    CONCAT('WEX-2024-', RIGHT('000' + CAST(TruckID AS VARCHAR), 3)),

    CASE WHEN TruckID % 5 = 0 THEN 'Comdata' ELSE 'WEX' END,

    TruckID,

    DATEADD(DAY, TruckID * 2, '2024-01-01'),

    DATEADD(YEAR, 4, DATEADD(DAY, TruckID * 2, '2024-01-01')),

    CASE
        WHEN TruckID = 9 THEN 'Expired'
        WHEN TruckID = 15 THEN 'Lost'
        WHEN TruckID = 22 THEN 'Blocked'
        ELSE 'Active'
    END,

    CASE
        WHEN TruckID % 3 = 0 THEN 1200
        WHEN TruckID % 3 = 1 THEN 1000
        ELSE 1500
    END
FROM Trucks;


-------------------------------------------------
-- 2. REPLACEMENT CARD (LOST - Truck 15)
-------------------------------------------------
INSERT INTO FuelCards
VALUES
(
    'WEX-2025-015-R1',
    'WEX',
    15,
    '2025-05-10',
    '2029-05-10',
    'Active',
    1200
);


-------------------------------------------------
-- 3. REPLACEMENT CARD (BLOCKED - Truck 22)
-------------------------------------------------
INSERT INTO FuelCards
VALUES
(
    'WEX-2025-022-R1',
    'WEX',
    22,
    '2025-09-15',
    '2029-09-15',
    'Active',
    1200
);


-------------------------------------------------
-- 4. NEW SPARE / EXTRA CARDS (2026)
-------------------------------------------------
INSERT INTO FuelCards
(CardNumber, CardProvider, AssignedTruckID, IssueDate, ExpiryDate, Status, DailyLimit)
VALUES
('WEX-2026-101', 'WEX', 5,  '2026-02-01', '2030-02-01', 'Active', 1000),
('CMD-2026-102', 'Comdata', 12, '2026-04-01', '2030-04-01', 'Active', 1200),
('WEX-2026-103', 'WEX', 27, '2026-06-01', '2030-06-01', 'Active', 1500);
GO


-- =============================================
-- TollDevices Seed Data
-- =============================================


WITH T AS
(
    SELECT TOP (37)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS TruckID
    FROM sys.objects
)

-------------------------------------------------
-- 1. INITIAL INSTALLATION (2024)
-------------------------------------------------
INSERT INTO TollDevices
(
    Provider,
    DeviceNumber,
    AssignedTruckID,
    IssueDate,
    ExpiryDate,
    Status
)
SELECT
    CASE WHEN TruckID % 2 = 0 THEN 'EZPass' ELSE 'PrePass' END,

    CONCAT('TOLL-2024-', RIGHT('000' + CAST(TruckID AS VARCHAR), 3)),

    TruckID,

    DATEADD(DAY, TruckID * 2, '2024-01-01'),

    DATEADD(YEAR, 5, DATEADD(DAY, TruckID * 2, '2024-01-01')),

    CASE
        WHEN TruckID = 8 THEN 'Inactive'
        WHEN TruckID = 14 THEN 'Lost'
        ELSE 'Active'
    END
FROM T;
GO

-------------------------------------------------
-- 2. REPLACEMENTS (2025)
-------------------------------------------------
INSERT INTO TollDevices
VALUES
('EZPass', 'TOLL-2025-014-R1', 14, '2025-06-10', '2030-06-10', 'Active');

INSERT INTO TollDevices
VALUES
('PrePass', 'TOLL-2025-008-R1', 8, '2025-09-01', '2030-09-01', 'Active');
GO

-------------------------------------------------
-- 3. NEW / SPARE DEVICES (2026)
-------------------------------------------------
INSERT INTO TollDevices
(Provider, DeviceNumber, AssignedTruckID, IssueDate, ExpiryDate, Status)
VALUES
('EZPass', 'TOLL-2026-101', 5,  '2026-02-01', '2031-02-01', 'Active'),
('PrePass', 'TOLL-2026-102', 12, '2026-04-01', '2031-04-01', 'Active'),
('EZPass', 'TOLL-2026-103', 27, '2026-07-01', '2031-07-01', 'Active');
GO


-- =============================================
-- TollTransactions Seed Data
-- =============================================


WITH N AS
(
    SELECT TOP (3000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)

INSERT INTO TollTransactions
(
    DeviceID,
    TruckID,
    TollDate,
    Location,
    Amount
)
SELECT

    -- 37 EZPass devices (one per truck)
    (n % 37) + 1,

    -- TruckID 1-37
    (n % 37) + 1,

    DATEADD
    (
        MINUTE,
        ABS(CHECKSUM(NEWID())) % 1440,

        CASE
            WHEN n <= 800
                THEN DATEADD(DAY,n % 365,'2024-01-01')

            WHEN n <= 2000
                THEN DATEADD(DAY,n % 365,'2025-01-01')

            ELSE
                DATEADD(DAY,n % 365,'2026-01-01')
        END
    ),

    CASE n % 20
        WHEN 0 THEN 'NJ Turnpike Exit 8A'
        WHEN 1 THEN 'NJ Turnpike Exit 13A'
        WHEN 2 THEN 'NJ Turnpike Exit 14'
        WHEN 3 THEN 'Garden State Parkway'
        WHEN 4 THEN 'George Washington Bridge'
        WHEN 5 THEN 'Lincoln Tunnel'
        WHEN 6 THEN 'Holland Tunnel'
        WHEN 7 THEN 'Verrazzano-Narrows Bridge'
        WHEN 8 THEN 'Goethals Bridge'
        WHEN 9 THEN 'Outerbridge Crossing'
        WHEN 10 THEN 'Delaware Memorial Bridge'
        WHEN 11 THEN 'Pennsylvania Turnpike'
        WHEN 12 THEN 'Ohio Turnpike'
        WHEN 13 THEN 'Indiana Toll Road'
        WHEN 14 THEN 'Illinois Tollway'
        WHEN 15 THEN 'Massachusetts Turnpike'
        WHEN 16 THEN 'New York State Thruway'
        WHEN 17 THEN 'I-95 Express Lanes'
        WHEN 18 THEN 'Florida Turnpike'
        ELSE 'Chesapeake Expressway'
    END,

    CAST
    (
        CASE
            WHEN n % 10 < 4
                THEN 8 + RAND(CHECKSUM(NEWID())) * 12

            WHEN n % 10 < 8
                THEN 20 + RAND(CHECKSUM(NEWID())) * 35

            ELSE
                55 + RAND(CHECKSUM(NEWID())) * 45
        END
    AS DECIMAL(10,2))

FROM N;
GO


-- =============================================
-- DriverDevices Seed Data
-- =============================================


INSERT INTO DriverDevices
(DriverID, DeviceType, Brand, Model, SerialNumber, AssignedDate, ReturnDate, Status, Notes)
VALUES
(1,'Tablet/ELD','Samsara','VG55','SM1001','2024-01-10',NULL,'Assigned','Primary driver'),
(2,'Tablet/ELD','Samsara','VG55','SM1002','2024-01-12',NULL,'Assigned','Primary driver'),
(3,'Tablet/ELD','Samsara','VG55','SM1003','2024-01-15',NULL,'Assigned',''),
(4,'Tablet/ELD','Geotab','GO9','GT1004','2024-02-01',NULL,'Assigned',''),
(5,'Tablet/ELD','Geotab','GO9','GT1005','2024-02-05',NULL,'Assigned',''),
(6,'Tablet/ELD','Motive','AI Dashcam','MV1006','2024-02-10',NULL,'Assigned',''),
(7,'Tablet/ELD','Samsara','VG55','SM1007','2024-03-01',NULL,'Assigned',''),
(8,'Tablet/ELD','Samsara','VG55','SM1008','2024-03-05',NULL,'Assigned',''),
(9,'Tablet/ELD','Geotab','GO9','GT1009','2024-03-08',NULL,'Assigned',''),
(10,'Tablet/ELD','Samsara','VG55','SM1010','2024-03-10',NULL,'Assigned','');
GO


INSERT INTO DriverDevices
(DriverID, DeviceType, Brand, Model, SerialNumber, AssignedDate, ReturnDate, Status, Notes)
VALUES

(11,'Tablet/ELD','Samsara','VG55','SM1011','2024-03-15',NULL,'Assigned',''),
(12,'Tablet/ELD','Geotab','GO9','GT1012','2024-03-18',NULL,'Assigned',''),
(13,'Tablet/ELD','Samsara','VG55','SM1013','2024-04-01',NULL,'Assigned',''),
(14,'Tablet/ELD','Motive','ELD Pro','MV1014','2024-04-05',NULL,'Assigned',''),
(15,'Tablet/ELD','Geotab','GO9','GT1015','2024-04-10',NULL,'Assigned',''),
(16,'Tablet/ELD','Samsara','VG55','SM1016','2024-04-15',NULL,'Assigned',''),
(17,'Tablet/ELD','Motive','ELD Pro','MV1017','2024-05-01',NULL,'Assigned',''),
(18,'Tablet/ELD','Geotab','GO9','GT1018','2024-05-05',NULL,'Assigned',''),
(19,'Tablet/ELD','Samsara','VG55','SM1019','2024-05-10',NULL,'Assigned',''),
(20,'Tablet/ELD','Motive','ELD Pro','MV1020','2024-05-15',NULL,'Assigned',''),

(21,'Tablet/ELD','Samsara','VG55','SM1021','2024-06-01',NULL,'Assigned',''),
(22,'Tablet/ELD','Geotab','GO9','GT1022','2024-06-05',NULL,'Assigned',''),
(23,'Tablet/ELD','Motive','ELD Pro','MV1023','2024-06-10',NULL,'Assigned',''),
(24,'Tablet/ELD','Samsara','VG55','SM1024','2024-06-15',NULL,'Assigned',''),
(25,'Tablet/ELD','Geotab','GO9','GT1025','2024-07-01',NULL,'Damaged','Screen replacement needed'),
(26,'Tablet/ELD','Samsara','VG55','SM1026','2024-07-05',NULL,'Lost','Driver reported lost device'),
(27,'Tablet/ELD','Motive','ELD Pro','MV1027','2024-07-10',NULL,'Under Repair','Battery and charging issue');
GO


-- =============================================
-- TruckDevices Seed Data
-- =============================================

INSERT INTO TruckDevices
(TruckID, DeviceType, Brand, Model, SerialNumber, InstallDate, Status, Notes)
VALUES

-- GPS DEVICES
(1,'GPS','Garmin','Fleet 790','GPS10001','2024-01-05','Active','Fleet tracking enabled'),
(2,'GPS','Garmin','Fleet 790','GPS10002','2024-01-05','Active','Fleet tracking enabled'),
(3,'GPS','Rand McNally','TND750','GPS10003','2024-01-10','Active',''),
(4,'GPS','Garmin','Fleet 790','GPS10004','2024-01-12','Active',''),
(5,'GPS','Samsara','VG55','GPS10005','2024-01-15','Active','Integrated with ELD'),
(6,'GPS','Garmin','Fleet 790','GPS10006','2024-02-01','Active',''),
(7,'GPS','Rand McNally','TND750','GPS10007','2024-02-05','Active',''),
(8,'GPS','Garmin','Fleet 790','GPS10008','2024-02-10','Active',''),
(9,'GPS','Samsara','VG55','GPS10009','2024-02-15','Offline','Signal issue'),
(10,'GPS','Garmin','Fleet 790','GPS10010','2024-03-01','Active',''),

(11,'GPS','Garmin','Fleet 790','GPS10011','2024-03-05','Active',''),
(12,'GPS','Rand McNally','TND750','GPS10012','2024-03-10','Active',''),
(13,'GPS','Samsara','VG55','GPS10013','2024-03-15','Under Repair','Hardware replacement'),
(14,'GPS','Garmin','Fleet 790','GPS10014','2024-03-20','Active',''),
(15,'GPS','Garmin','Fleet 790','GPS10015','2024-04-01','Active',''),

-- DASH CAMERAS
(1,'Dash Camera','Samsara','CM32','CAM10001','2024-01-05','Operational','Front and cabin camera'),
(2,'Dash Camera','Samsara','CM32','CAM10002','2024-01-05','Operational',''),
(3,'Dash Camera','Lytx','DriveCam','CAM10003','2024-01-10','Operational',''),
(4,'Dash Camera','Lytx','DriveCam','CAM10004','2024-01-12','Needs Repair','Camera malfunction'),
(5,'Dash Camera','Samsara','CM32','CAM10005','2024-01-15','Operational',''),
(6,'Dash Camera','Motive','AI Dashcam','CAM10006','2024-02-01','Operational','AI safety monitoring'),
(7,'Dash Camera','Samsara','CM32','CAM10007','2024-02-05','Operational',''),
(8,'Dash Camera','Lytx','DriveCam','CAM10008','2024-02-10','Replaced','Old camera replaced'),
(9,'Dash Camera','Motive','AI Dashcam','CAM10009','2024-02-15','Operational',''),
(10,'Dash Camera','Samsara','CM32','CAM10010','2024-03-01','Operational',''),

-- EZPASS
(1,'EZPass','EZPass','Commercial Tag','EZ10001','2024-01-05','Active',''),
(2,'EZPass','EZPass','Commercial Tag','EZ10002','2024-01-05','Active',''),
(3,'EZPass','EZPass','Commercial Tag','EZ10003','2024-01-10','Active',''),
(4,'EZPass','EZPass','Commercial Tag','EZ10004','2024-01-12','Lost','Replacement requested'),
(5,'EZPass','EZPass','Commercial Tag','EZ10005','2024-01-15','Active',''),
(6,'EZPass','EZPass','Commercial Tag','EZ10006','2024-02-01','Active',''),
(7,'EZPass','EZPass','Commercial Tag','EZ10007','2024-02-05','Active',''),
(8,'EZPass','EZPass','Commercial Tag','EZ10008','2024-02-10','Replaced','Previous tag expired'),
(9,'EZPass','EZPass','Commercial Tag','EZ10009','2024-02-15','Active',''),
(10,'EZPass','EZPass','Commercial Tag','EZ10010','2024-03-01','Active','');
GO