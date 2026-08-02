
USE TMS_DB_Test;
GO


/*
 Trucks
 Trailers
*/

-- =============================================
-- Fleet Seed Data
-- =============================================

-- =============================================
-- Trucks Seed Data
-- =============================================


INSERT INTO Trucks
(TruckNumber, 
VIN, 
Make, 
Model, 
ModelYear, 
LicensePlate, 
Status, 
Mileage, 
LeasingCompanyID,
OwnershipType
)
VALUES
-- ======================
-- COMPANY OWNED (12)
-- ======================
('TRK-1001','1HGBH41JXMN109186','Volvo','VNL',2021,'NJX1001','Active',245000,NULL,'Company'),
('TRK-1002','1HGBH41JXMN109187','Freightliner','Cascadia',2020,'NJX1002','Active',310000,NULL,'Company'),
('TRK-1003','1HGBH41JXMN109188','Kenworth','T680',2022,'NJX1003','Active',180000,NULL,'Company'),
('TRK-1004','1HGBH41JXMN109189','Volvo','VNL',2019,'NJX1004','Maintenance',420000,NULL,'Company'),
('TRK-1005','1HGBH41JXMN109190','Peterbilt','579',2021,'NJX1005','Active',260000,NULL,'Company'),
('TRK-1006','1HGBH41JXMN109191','Freightliner','Cascadia',2023,'NJX1006','Active',120000,NULL,'Company'),
('TRK-1007','1HGBH41JXMN109192','Volvo','VNL',2022,'NJX1007','Active',150000,NULL,'Company'),
('TRK-1008','1HGBH41JXMN109193','Kenworth','T680',2020,'NJX1008','Active',330000,NULL,'Company'),
('TRK-1009','1HGBH41JXMN109194','Peterbilt','579',2018,'NJX1009','Active',510000,NULL,'Company'),
('TRK-1010','1HGBH41JXMN109195','Freightliner','Cascadia',2021,'NJX1010','Active',240000,NULL,'Company'),
('TRK-1011','1HGBH41JXMN109196','Volvo','VNL',2019,'NJX1011','Inactive',390000,NULL,'Company'),
('TRK-1012','1HGBH41JXMN109197','Kenworth','T680',2022,'NJX1012','Active',160000,NULL,'Company'),

-- ======================
-- LEASED (15)
-- ======================
('TRK-2001','2HGBH41JXMN209201','Freightliner','Cascadia',2024,'NJX2001','Active',90000,1,'Leased'),
('TRK-2002','2HGBH41JXMN209202','Volvo','VNL',2025,'NJX2002','Active',60000,2,'Leased'),
('TRK-2003','2HGBH41JXMN209203','Kenworth','T680',2024,'NJX2003','Active',75000,1,'Leased'),
('TRK-2004','2HGBH41JXMN209204','Peterbilt','579',2025,'NJX2004','Active',50000,3,'Leased'),
('TRK-2005','2HGBH41JXMN209205','Freightliner','Cascadia',2023,'NJX2005','Active',110000,2,'Leased'),
('TRK-2006','2HGBH41JXMN209206','Volvo','VNL',2024,'NJX2006','Maintenance',95000,1,'Leased'),
('TRK-2007','2HGBH41JXMN209207','Kenworth','T680',2025,'NJX2007','Active',45000,3,'Leased'),
('TRK-2008','2HGBH41JXMN209208','Peterbilt','579',2024,'NJX2008','Active',80000,2,'Leased'),
('TRK-2009','2HGBH41JXMN209209','Freightliner','Cascadia',2025,'NJX2009','Active',42000,1,'Leased'),
('TRK-2010','2HGBH41JXMN209210','Volvo','VNL',2024,'NJX2010','Active',68000,2,'Leased'),
('TRK-2011','2HGBH41JXMN209211','Kenworth','T680',2025,'NJX2011','Active',35000,1,'Leased'),
('TRK-2012','2HGBH41JXMN209212','Peterbilt','579',2024,'NJX2012','Active',79000,3,'Leased'),
('TRK-2013','2HGBH41JXMN209213','Freightliner','Cascadia',2023,'NJX2013','Maintenance',102000,2,'Leased'),
('TRK-2014','2HGBH41JXMN209214','Volvo','VNL',2025,'NJX2014','Active',28000,1,'Leased'),
('TRK-2015','2HGBH41JXMN209215','Kenworth','T680',2024,'NJX2015','Active',56000,3,'Leased'),

-- ======================
-- OWNER-OPERATOR (10)
-- ======================
('TRK-3001','3HGBH41JXMN309301','Freightliner','Cascadia',2019,'NJX3001','Active',620000,NULL,'OwnerOperator'),
('TRK-3002','3HGBH41JXMN309302','Volvo','VNL',2018,'NJX3002','Active',700000,NULL,'OwnerOperator'),
('TRK-3003','3HGBH41JXMN309303','Kenworth','T680',2020,'NJX3003','Active',480000,NULL,'OwnerOperator'),
('TRK-3004','3HGBH41JXMN309304','Peterbilt','579',2021,'NJX3004','Active',350000,NULL,'OwnerOperator'),
('TRK-3005','3HGBH41JXMN309305','Freightliner','Cascadia',2019,'NJX3005','Active',590000,NULL,'OwnerOperator'),
('TRK-3006','3HGBH41JXMN309306','Volvo','VNL',2022,'NJX3006','Active',300000,NULL,'OwnerOperator'),
('TRK-3007','3HGBH41JXMN309307','Kenworth','T680',2018,'NJX3007','Active',750000,NULL,'OwnerOperator'),
('TRK-3008','3HGBH41JXMN309308','Peterbilt','579',2019,'NJX3008','Active',680000,NULL,'OwnerOperator'),
('TRK-3009','3HGBH41JXMN309309','Freightliner','Cascadia',2021,'NJX3009','Active',410000,NULL,'OwnerOperator'),
('TRK-3010','3HGBH41JXMN309310','Volvo','VNL',2023,'NJX3010','Active',220000,NULL,'OwnerOperator');
GO


-- =============================================
-- Trailers Seed Data
-- =============================================

INSERT INTO Trailers
(TrailerNumber, VIN, TrailerType, Make, Model, ModelYear,
 LicensePlate, Status, OwnershipType, LeasingCompanyID, CustomerID)
VALUES
('TRL-001', '1UYVS2537DU123001', 'Dry Van', 'Great Dane', 'Champion', 2022,
 'NJT1001', 'Active', 'Company', NULL, NULL),

('TRL-002', '1UYVS2537DU123002', 'Reefer', 'Utility', '3000R', 2021,
 'NJT1002', 'Active', 'Company', NULL, NULL),

('TRL-003', '1UYVS2537DU123003', 'Flatbed', 'Fontaine', 'Infinity', 2020,
 'NJT1003', 'Maintenance', 'Company', NULL, NULL),

('TRL-004', '1UYVS2537DU123004', 'Dry Van', 'Hyundai', 'HT Dry Van', 2023,
 'NJT1004', 'Active', 'Leased', 1, NULL),

('TRL-005', '1UYVS2537DU123005', 'Reefer', 'Utility', '3000R', 2022,
 'NJT1005', 'Active', 'Leased', 2, NULL),

('TRL-006', '1UYVS2537DU123006', 'Dry Van', 'Wabash', 'DuraPlate', 2024,
 'AMZ1001', 'Active', 'Customer', NULL, 1),

('TRL-007', '1UYVS2537DU123007', 'Dry Van', 'Great Dane', 'Champion', 2023,
 'WMT2001', 'Active', 'Customer', NULL, 2),

('TRL-008', '1UYVS2537DU123008', 'Flatbed', 'Fontaine', 'Velocity', 2021,
 'NJT1008', 'Out of Service', 'Company', NULL, NULL),

('TRL-009', '1UYVS2537DU123009', 'Dry Van', 'Hyundai', 'HT Dry Van', 2020,
 'NJT1009', 'Inactive', 'Company', NULL, NULL),

('TRL-010', '1UYVS2537DU123010', 'Reefer', 'Great Dane', 'Everest', 2024,
 'NJT1010', 'Active', 'Company', NULL, NULL);
 GO