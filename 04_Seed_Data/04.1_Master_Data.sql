
USE TMS_DB_Test;
GO

/*
LeasingCompanies
Customers
Employees
Vendors
ParkingLots
Terminals
*/

-- =============================================
-- Master Seed Data
-- =============================================

-- =============================================
-- Leasing Companies Seed Data
-- =============================================

INSERT INTO LeasingCompanies
(CompanyName, ContactPerson, Phone, Email, Address, City, State, ZipCode, Website, Status)
VALUES
('Penske Truck Leasing', 'John Miller', '800-526-9900', 'john.miller@penske.com', '2675 Morgantown Rd', 'Reading', 'PA', '19607', 'www.penske.com', 'Active'),
('Ryder System', 'Susan White', '800-793-9335', 'susan.white@ryder.com', '11690 NW 105th St', 'Miami', 'FL', '33178', 'www.ryder.com', 'Active'),
('PacLease', 'David Wilson', '800-759-2235', 'david.wilson@paclease.com', '777 106th Ave NE', 'Bellevue', 'WA', '98004', 'www.paclease.com', 'Active'),
('Ryder Truck Rental', 'Susan Walker', '800-793-9335', 'swalker@ryder.com',
 '11690 NW 105th St', 'Miami', 'FL', '33178', 'www.ryder.com', 'Active'),

('PACCAR Leasing', 'Brian Evans', '800-736-7200', 'bevans@paclease.com',
 '777 106th Ave NE', 'Bellevue', 'WA', '98004', 'www.paclease.com', 'Active'),

('Idealease', 'Karen Brooks', '877-433-2532', 'kbrooks@idealease.com',
 '430 N Rand Rd', 'North Barrington', 'IL', '60010', 'www.idealease.com', 'Active'),

('NationaLease', 'Thomas Green', '800-972-8872', 'tgreen@nationalease.com',
 '2460 Millbrook Rd', 'Raleigh', 'NC', '27604', 'www.nationalease.com', 'Active'),

('MHC Truck Leasing', 'Daniel White', '816-241-4888', 'dwhite@mhc.com',
 '9201 NE Birmingham Rd', 'Kansas City', 'MO', '64161', 'www.mhc.com', 'Active'),

('Fleet Advantage', 'Jessica Adams', '954-615-4400', 'jadams@fleetadvantage.com',
 'A1A Corporate Center', 'Fort Lauderdale', 'FL', '33309', 'www.fleetadvantage.com', 'Active'),

('Element Fleet Management', 'Mark Stevens', '800-665-9744', 'mstevens@elementcorp.com',
 '1001 Fleet St', 'Sparks', 'MD', '21152', 'www.elementfleet.com', 'Active'),

('Enterprise Truck Rental', 'Rachel Lewis', '855-901-3099', 'rlewis@enterprise.com',
 '600 Corporate Park Dr', 'St. Louis', 'MO', '63105', 'www.enterprisetrucks.com', 'Active'),

('Velocity Truck Leasing', 'Kevin Parker', '713-672-0000', 'kparker@velocitytruck.com',
 '2525 McCarty St', 'Houston', 'TX', '77029', 'www.velocitytruckcenters.com', 'Active'),

('Premier Truck Leasing', 'Amanda Scott', '877-973-2678', 'ascott@premierleasing.com',
 '4575 Highway 80', 'Jackson', 'MS', '39209', 'www.premierleasing.com', 'Active');
 GO



-- =============================================
-- Customers Seed Data
-- =============================================

INSERT INTO Customers
(CompanyName, ContactName, Phone, Email, Address, City, State, ZipCode, CustomerType, CreditLimit, PaymentTerms, Status, TaxID)
VALUES

('Walmart Distribution', 'James Carter', '201-555-1001', 'jcarter@walmart.com', '100 Industrial Ave', 'Newark', 'NJ', '07105', 'Shipper', 500000, 'Net 30', 'Active', '13-1234567'),
('Amazon Logistics', 'Sarah Johnson', '201-555-1002', 'sjohnson@amazon.com', '500 Amazon Way', 'Jersey City', 'NJ', '07310', 'Shipper', 1000000, 'Net 15', 'Active', '91-9876543'),
('Target Supply Chain', 'Michael Brown', '201-555-1003', 'mbrown@target.com', '250 Logistics Blvd', 'Elizabeth', 'NJ', '07201', 'Shipper', 300000, 'Net 30', 'Active', '41-5566778'),
('UPS Freight Brokerage', 'Laura Wilson', '201-555-1004', 'lwilson@ups.com', '75 Shipping Ln', 'New York', 'NY', '10001', 'Broker', 750000, 'Net 15', 'Active', '58-2233445'),
('FedEx Trade Networks', 'David Miller', '201-555-1005', 'dmiller@fedex.com', '900 Cargo Rd', 'Secaucus', 'NJ', '07094', 'Broker', 800000, 'Net 30', 'Active', '62-9988776'),
('Small Retail Store LLC', 'Anna Lee', '201-555-1006', 'alee@smallstore.com', '12 Main St', 'Hoboken', 'NJ', '07030', 'Receiver', 5000, 'COD', 'Active', NULL),
('Global Imports Inc', 'Robert Smith', '201-555-1007', 'rsmith@globalimports.com', '400 Port Ave', 'Newark', 'NJ', '07114', 'Shipper', 200000, 'Net 45', 'Inactive', '22-3344556');

INSERT INTO Customers
(CompanyName, ContactName, Phone, Email, Address, City, State, ZipCode, CustomerType, CreditLimit, PaymentTerms, Status, TaxID)
VALUES

('Costco Wholesale', 'Michael Carter', '(206) 555-1001', 'mcarter@costco.com', '999 Lake Dr', 'Seattle', 'WA', '98101', 'Corporate', 75000, 'Net 30', 'Active', '91-1111111'),

('Home Depot Supply', 'Jennifer Adams', '(770) 555-1002', 'jadams@homedepot.com', '245 Industrial Pkwy', 'Atlanta', 'GA', '30303', 'Corporate', 85000, 'Net 30', 'Active', '58-2222222'),

('Lowe''s Distribution', 'Kevin Brown', '(704) 555-1003', 'kbrown@lowes.com', '150 Commerce Rd', 'Charlotte', 'NC', '28202', 'Corporate', 70000, 'Net 30', 'Active', '56-3333333'),

('Best Buy Logistics', 'Sarah White', '(612) 555-1004', 'swhite@bestbuy.com', '450 Tech Blvd', 'Minneapolis', 'MN', '55401', 'Corporate', 60000, 'Net 30', 'Active', '41-4444444'),

('Cost Plus Imports', 'David Hall', '(305) 555-1005', 'dhall@costplus.com', '77 Harbor Ave', 'Miami', 'FL', '33101', 'Commercial', 25000, 'Net 15', 'Active', '65-5555555'),

('Fresh Foods Market', 'Lisa Green', '(973) 555-1006', 'lgreen@freshfoods.com', '102 Market St', 'Newark', 'NJ', '07102', 'Retail', 15000, 'Net 15', 'Active', '22-6666666'),

('Metro Grocery Chain', 'Brian Lewis', '(718) 555-1007', 'blewis@metrogrocery.com', '81 Fulton St', 'Brooklyn', 'NY', '11201', 'Retail', 20000, 'Net 15', 'Active', '11-7777777'),

('ABC Manufacturing', 'John Davis', '(313) 555-1008', 'jdavis@abcmfg.com', '500 Factory Rd', 'Detroit', 'MI', '48201', 'Industrial', 40000, 'Net 30', 'Active', '38-8888888'),

('XYZ Electronics', 'Nancy Scott', '(512) 555-1009', 'nscott@xyzelec.com', '320 Innovation Dr', 'Austin', 'TX', '73301', 'Commercial', 35000, 'Net 30', 'Active', '74-9999999'),

('Blue Ocean Seafood', 'Daniel Young', '(617) 555-1010', 'dyoung@blueocean.com', '18 Harbor Way', 'Boston', 'MA', '02108', 'Retail', 18000, 'Net 15', 'Active', '04-1010101'),

('Green Valley Farms', 'Rachel King', '(717) 555-1011', 'rking@greenvalley.com', '12 Country Rd', 'Lancaster', 'PA', '17601', 'Agriculture', 22000, 'Net 30', 'Active', '23-1111112'),

('Prime Auto Parts', 'Steven Moore', '(419) 555-1012', 'smoore@primeauto.com', '65 Auto Park', 'Toledo', 'OH', '43604', 'Industrial', 45000, 'Net 30', 'Active', '34-1212121'),

('National Furniture Co.', 'Emily Clark', '(336) 555-1013', 'eclark@natfurniture.com', '44 Wood St', 'High Point', 'NC', '27260', 'Commercial', 32000, 'Net 30', 'Active', '56-1313131'),

('Sunrise Medical Supplies', 'Mark Allen', '(407) 555-1014', 'mallen@sunrisemed.com', '900 Health Blvd', 'Orlando', 'FL', '32801', 'Healthcare', 30000, 'Net 30', 'Active', '59-1414141'),

('Rapid Construction Supply', 'Paul Walker', '(602) 555-1015', 'pwalker@rapidbuild.com', '77 Builder Ave', 'Phoenix', 'AZ', '85001', 'Construction', 50000, 'Net 30', 'Active', '86-1515151');
GO

-- Add missing customers required by Shipments FK relationship

INSERT INTO Customers
(
    CompanyName,
    ContactName,
    Phone,
    Email,
    Address,
    City,
    State,
    ZipCode,
    CustomerType,
    CreditLimit,
    PaymentTerms,
    Status,
    TaxID
)
VALUES
('Blue Horizon Logistics', 'Michael Carter', '555-0101', 'michael@bluehorizon.com', '125 Market Street', 'Dallas', 'TX', '75201', 'Broker', 50000.00, 'Net 30', 'Active', 'TX-100023'),
('Evergreen Distribution', 'Sarah Wilson', '555-0102', 'sarah@evergreen.com', '340 Oak Avenue', 'Seattle', 'WA', '98101', 'Direct', 75000.00, 'Net 45', 'Active', 'WA-100024'),
('North Star Freight', 'David Miller', '555-0103', 'david@northstar.com', '890 Lake Road', 'Chicago', 'IL', '60601', 'Broker', 60000.00, 'Net 30', 'Active', 'IL-100025'),
('Golden Route Supply', 'Emma Johnson', '555-0104', 'emma@goldenroute.com', '45 Industrial Blvd', 'Atlanta', 'GA', '30301', 'Direct', 40000.00, 'Net 30', 'Active', 'GA-100026'),
('Pacific Cargo Solutions', 'James Brown', '555-0105', 'james@pacificcargo.com', '700 Harbor Drive', 'Los Angeles', 'CA', '90001', 'Broker', 90000.00, 'Net 45', 'Active', 'CA-100027'),
('Summit Wholesale', 'Robert Davis', '555-0106', 'robert@summit.com', '230 Summit Ave', 'Denver', 'CO', '80202', 'Direct', 35000.00, 'Net 30', 'Active', 'CO-100028'),
('Metro Retail Partners', 'Linda Smith', '555-0107', 'linda@metroretail.com', '100 Main Street', 'New York', 'NY', '10001', 'Direct', 80000.00, 'Net 30', 'Active', 'NY-100029'),
('Rapid Transit Group', 'William Taylor', '555-0108', 'william@rapidtransit.com', '550 Transit Road', 'Phoenix', 'AZ', '85001', 'Broker', 45000.00, 'Net 30', 'Active', 'AZ-100030'),
('East Coast Imports', 'Patricia Anderson', '555-0109', 'patricia@eastcoast.com', '90 Port Avenue', 'Boston', 'MA', '02108', 'Direct', 70000.00, 'Net 45', 'Active', 'MA-100031'),
('Midwest Cargo Inc', 'Thomas Thomas', '555-0110', 'thomas@midwestcargo.com', '300 River Road', 'St Louis', 'MO', '63101', 'Broker', 55000.00, 'Net 30', 'Active', 'MO-100032');


-- Add missing customers required by Shipments FK relationship

INSERT INTO Customers
(
    CompanyName,
    ContactName,
    Phone,
    Email,
    Address,
    City,
    State,
    ZipCode,
    CustomerType,
    CreditLimit,
    PaymentTerms,
    Status,
    TaxID
)
VALUES
('Red Horizon Logistics', 'Michael Carter', '555-2573', 'mike@bluehorizon.com', '125 High Street', 'Houston', 'TX', '75201', 'Broker', 60000.00, 'Net 30', 'Active', 'TX-100053'),
('Everhigh Marketing', 'Sarah Wilson', '555-1973', 'jonah@evergreen.com', '124 Oak Avenue', 'Seattle', 'WA', '98100', 'Direct', 45000.00, 'Net 45', 'Active', 'WA-100023'),
('Polar Star Distribution', 'David Miller', '555-7568', 'cohen@northstar.com', '569 Lake Road', 'Chicago', 'IL', '60600', 'Broker', 80000.00, 'Net 30', 'Active', 'IL-100029'),
('Golden Ox Supply', 'Emma Johnson', '555-1596', 'andy@goldenroute.com', '45 Industrial Blvd', 'Atlanta', 'GA', '11214', 'Direct', 30000.00, 'Net 30', 'Active', 'GA-102026'),
('Atlantic Cargo Solutions', 'James Brown', '555-78336', 'john@pacificcargo.com', '471 Lincoln Drive', 'Los Angeles', 'CA', '90001', 'Broker', 95000.00, 'Net 30', 'Active', 'CA-108027'),
('Summit Retail and Wholesale Group', 'Robert Davis', '555-8914', 'richard@summit.com', '230 18th Ave', 'Denver', 'CO', '80202', 'Direct', 45000.00, 'Net 45', 'Active', 'CO-100628'),
('Conrad Retail Partners', 'Linda Smith', '555-2356', 'michael@metroretail.com', '120 Main Street', 'New York', 'NY', '10001', 'Direct', 75000.00, 'Net 30', 'Active', 'NY-100029'),
('Rapid Transit Distribution', 'William Taylor', '555-9514', 'bill@rapidtransit.com', '236 Transit Road', 'Phoenix', 'AZ', '85001', 'Broker', 50000.00, 'Net 45', 'Active', 'AZ-100031'),
('EastWest Coast Imports-Exports', 'Patricia Anderson', '555-0147', 'patricia@eastcoast.com', '50 Pacific Avenue', 'Boston', 'MA', '02108', 'Direct', 65000.00, 'Net 45', 'Active', 'MA-100032'),
('Arizona Cargo Inc', 'Thomas Thomas', '555-4589', 'tiger@midwestcargo.com', '301 River Road', 'St Louis', 'MO', '63101', 'Broker', 60000.00, 'Net 30', 'Active', 'MO-100032'), 
('Pacific Coast Imports', 'Patricia Anderson', '555-3698', 'briana@eastcoast.com', '91 Central Avenue', 'Boston', 'MA', '02108', 'Direct', 75000.00, 'Net 45', 'Active', 'MA-100051'),
('Summit Cargo Inc', 'Thomas Thomas', '555-1245', 'latifa@midwestcargo.com', '321 Stream Road', 'St Louis', 'MO', '63101', 'Broker', 60000.00, 'Net 30', 'Active', 'MO-100092');









-- =============================================
-- Employees Seed Data
-- =============================================


INSERT INTO Employees
(FirstName, LastName, JobTitle, HireDate, Phone, Email, Salary, ManagerID)
VALUES
-- =====================
-- MANAGEMENT (Top Level)
-- =====================
('Frank', 'Jones', 'Operations Manager', '2020-03-15', '201-555-1001', 'frank.jones11@gmail.com', 95000, NULL),
-- =====================
-- SUPERVISORS
-- =====================
('Sarah', 'Johnson', 'Dispatch Supervisor', '2021-06-10', '201-555-1002', 'sarah.johnson1986@gmail.com', 75000, 1),
('David', 'Martinez', 'Fleet Manager', '2020-08-22', '201-555-1003', 'david.martinez@gmail.com', 82000, 1),
-- =====================
-- DISPATCHERS
-- =====================
('John', 'Taylor', 'Dispatcher', '2022-04-15', '201-555-1006', 'john.taylor@yahoo.com', 55000, 2),
('Lisa', 'Garcia', 'Dispatcher', '2022-07-20', '201-555-1007', 'lisa.garcia@gmail.com', 54000, 2),
-- =====================
-- SUPPORT STAFF
-- =====================
('Jennifer', 'Brown', 'HR Specialist', '2022-01-12', '201-555-1004', 'jennifer.brown@gmail.com', 62000, 1),
('Robert', 'Wilson', 'Accountant', '2021-11-01', '201-555-1005', 'robert.wilson@gmail.com', 68000, 1),
('Kevin', 'Moore', 'Safety Coordinator', '2021-09-18', '201-555-1008', 'kevin.moore@gmail.com', 65000, 3),
('Clear', 'Waters', 'Data Analyst', '2020-10-01', '347-555-1010', 'clear.waters123@yahoo.com', 56000, 1),
('Anthony', 'Young', 'Maintenance Coordinator', '2021-04-08', '201-555-1014', 'anthony.young@gmail.com', 67000, 3),
('Nicole', 'King', 'Administrative Assistant', '2023-08-01', '201-555-1015', 'nicole.king@gmail.com', 48000, 1),
('Sanjar', 'Usmanov', 'Web Developer', '2023-08-01', '347-816-1015', 'sanjar.webdev@gmail.com', 63000, 1),
-- =====================
-- DRIVERS (Company Drivers)
-- =====================

('Carlos', 'Ramirez', 'Driver', '2018-07-22', '201-555-2003', 'carlos.ramirez@truckmail.com', 75000, 3),
('Daniel', 'Scott', 'Driver', '2019-01-10', '201-555-2004', 'daniel.scott@truckmail.com', 82000, 3),
('Ethan', 'Walker', 'Driver', '2020-11-05', '201-555-2005', 'ethan.walker@truckmail.com', 66000, 2),

('Frank', 'Harris', 'Driver', '2021-02-14', '201-555-2006', 'frank.harris@truckmail.com', 70000, 2),
('George', 'Martin', 'Driver', '2021-09-30', '201-555-2007', 'george.martin@truckmail.com', 71000, 2),
('Henry', 'Thompson', 'Driver', '2022-06-11', '201-555-2008', 'henry.thompson@truckmail.com', 69000, 2),
('Ivan', 'Clark', 'Driver', '2022-12-01', '201-555-2009', 'ivan.clark@truckmail.com', 88000, 2),
('Jack', 'Rodriguez', 'Driver', '2023-03-15', '201-555-2010', 'jack.rodriguez@truckmail.com', 92000, 2),

('Kevin', 'Lewis', 'Driver', '2015-08-20', '201-555-2011', 'kevin.lewis@truckmail.com', 95000, 3),
('Liam', 'Walker', 'Driver', '2016-04-17', '201-555-2012', 'liam.walker@truckmail.com', 64000, 3),
('Mike', 'Allen', 'Driver', '2017-09-25', '201-555-2013', 'mike.allen@truckmail.com', 73000, 3),
('Nathan', 'Young', 'Driver', '2018-11-19', '201-555-2014', 'nathan.young@truckmail.com', 78000, 3),
('Oscar', 'King', 'Driver', '2019-05-21', '201-555-2015', 'oscar.king@truckmail.com', 81000, 3),

('Paul', 'Wright', 'Driver', '2020-07-13', '201-555-2016', 'paul.wright@truckmail.com', 69000, 2),
('Quentin', 'Lopez', 'Driver', '2021-10-02', '201-555-2017', 'quentin.lopez@truckmail.com', 86000, 2),
('Ryan', 'Hill', 'Driver', '2022-01-28', '201-555-2018', 'ryan.hill@truckmail.com', 74000, 2),
('Sam', 'Green', 'Driver', '2023-06-14', '201-555-2019', 'sam.green@truckmail.com', 67000, 2),
('Tom', 'Adams', 'Driver', '2024-02-09', '201-555-2020', 'tom.adams@truckmail.com', 88000, 2),

('Victor', 'Bennett', 'Driver', '2015-06-11', '201-555-2021', 'victor.bennett@truckmail.com', 91000, 3),
('Walter', 'Coleman', 'Driver', '2015-09-25', '201-555-2022', 'walter.coleman@truckmail.com', 87000, 3),
('Xavier', 'Diaz', 'Driver', '2016-02-14', '201-555-2023', 'xavier.diaz@truckmail.com', 76000, 3),
('Yusuf', 'Evans', 'Driver', '2016-10-08', '201-555-2024', 'yusuf.evans@truckmail.com', 69000, 3),
('Zachary', 'Foster', 'Driver', '2017-01-19', '201-555-2025', 'zachary.foster@truckmail.com', 83000, 3),

('Aaron', 'Gray', 'Driver', '2017-07-03', '201-555-2026', 'aaron.gray@truckmail.com', 72000, 2),
('Brandon', 'Howard', 'Driver', '2018-03-27', '201-555-2027', 'brandon.howard@truckmail.com', 88000, 2),
('Cameron', 'Ibrahim', 'Driver', '2018-08-15', '201-555-2028', 'cameron.ibrahim@truckmail.com', 65000, 2),
('Derek', 'James', 'Driver', '2019-04-11', '201-555-2029', 'derek.james@truckmail.com', 79000, 2),
('Elliot', 'Khan', 'Driver', '2019-09-09', '201-555-2030', 'elliot.khan@truckmail.com', 84000, 2),

('Frederick', 'Lopez', 'Driver', '2020-01-21', '201-555-2031', 'frederick.lopez@truckmail.com', 67000, 3),
('Gavin', 'Mitchell', 'Driver', '2020-06-18', '201-555-2032', 'gavin.mitchell@truckmail.com', 72000, 3),
('Harold', 'Nelson', 'Driver', '2020-12-05', '201-555-2033', 'harold.nelson@truckmail.com', 81000, 3),
('Isaac', 'Owens', 'Driver', '2021-03-16', '201-555-2034', 'isaac.owens@truckmail.com', 86000, 3),
('Jordan', 'Perry', 'Driver', '2021-08-28', '201-555-2035', 'jordan.perry@truckmail.com', 93000, 3),

('Khalid', 'Quinn', 'Driver', '2022-02-10', '201-555-2036', 'khalid.quinn@truckmail.com', 74000, 2),
('Leon', 'Reed', 'Driver', '2022-07-19', '201-555-2037', 'leon.reed@truckmail.com', 88000, 2),
('Marcus', 'Stewart', 'Driver', '2023-01-25', '201-555-2038', 'marcus.stewart@truckmail.com', 69000, 2),
('Noah', 'Turner', 'Driver', '2023-06-30', '201-555-2039', 'noah.turner@truckmail.com', 77000, 2),
('Omar', 'Valdez', 'Driver', '2024-03-12', '201-555-2040', 'omar.valdez@truckmail.com', 82000, 2);
GO

-- =============================================
-- Vendors Seed Data
-- =============================================


INSERT INTO Vendors
(
	VendorName, 
	VendorType, 
	ContactPerson, 
	Phone, 
	Email, 
	Address, 
	City, 
	State, 
	Notes
)
VALUES

-- 1. Fuel vendor
('Pilot Flying J', 'Fuel', 'Mark Stevens', '800-555-1010', 'contact@pilotflyingj.com',
 '123 Highway Plaza', 'Knoxville', 'TN',
 'Major fuel network for long-haul trucks'),

-- 2. Fuel vendor
('Love''s Travel Stops', 'Fuel', 'Sarah Johnson', '800-555-2020', 'support@loves.com',
 '450 Interstate Blvd', 'Oklahoma City', 'OK',
 'Truck stops and fuel services nationwide'),

-- 3. Maintenance vendor
('Rush Truck Centers', 'Maintenance', 'David Miller', '800-555-3030', 'service@rushtrucks.com',
 '88 Diesel Way', 'Dallas', 'TX',
 'Truck repair and fleet maintenance services'),

-- 4. Toll vendor
('E-ZPass NJ', 'Toll', 'NJ Support Desk', '888-555-4040', 'help@ezpassnj.com',
 '200 Toll Authority Dr', 'Newark', 'NJ',
 'Electronic toll collection system'),

-- 5. Parking vendor
('Interstate Truck Parking', 'Parking', 'Robert Lee', '800-555-5050', 'info@truckparking.com',
 '55 Rest Stop Ave', 'Jersey City', 'NJ',
 'Secure overnight truck parking facilities'),

-- 6. Insurance vendor
('Progressive Commercial Fleet', 'Insurance', 'Linda Carter', '800-555-6060', 'fleet@progressive.com',
 '300 Insurance Plaza', 'Cleveland', 'OH',
 'Commercial truck insurance provider');
 GO


 -- =============================================
-- ParkingLots Seed Data
-- =============================================


INSERT INTO ParkingLots
(ParkingLotName, Address, City, State, ZipCode, Capacity, MonthlyRent,
 LeaseStartDate, LeaseEndDate, ContactPerson, ContactPhone, Notes)
VALUES
('Newark Truck Yard',
 '125 Industrial Ave',
 'Newark',
 'NJ',
 '07105',
 40,
 12000.00,
 '2025-01-01',
 '2027-12-31',
 'John Martinez',
 '(973) 555-1101',
 'Main company truck parking lot'),

('Elizabeth Fleet Parking',
 '850 Port St',
 'Elizabeth',
 'NJ',
 '07201',
 25,
 8500.00,
 '2025-03-01',
 '2028-02-28',
 'Sarah Williams',
 '(908) 555-2234',
 'Overflow parking near Port Newark'),

('Secaucus Logistics Yard',
 '400 Meadowlands Pkwy',
 'Secaucus',
 'NJ',
 '07094',
 30,
 9800.00,
 '2024-07-01',
 '2027-06-30',
 'Michael Brown',
 '(201) 555-3365',
 'Used for trailers and spare tractors'),

('Jersey City Storage Lot',
 '95 Caven Point Rd',
 'Jersey City',
 'NJ',
 '07305',
 18,
 6200.00,
 '2025-06-01',
 '2026-05-31',
 'David Clark',
 '(201) 555-4478',
 'Temporary leased parking area'),

('Allentown Fleet Yard',
 '780 Industrial Blvd',
 'Allentown',
 'PA',
 '18103',
 35,
 9100.00,
 '2025-02-15',
 '2028-02-14',
 'Karen Johnson',
 '(610) 555-5589',
 'Parking for trucks operating in Pennsylvania');
GO


-- =============================================
-- ParkingLots Seed Data
-- =============================================


INSERT INTO Terminals
(TerminalName, Address, City, State, ZipCode, Phone, ManagerName, Capacity, Notes)
VALUES

('Newark Main Terminal',
'125 Industrial Ave',
'Newark',
'NJ',
'07105',
'(973) 555-1000',
'John Smith',
50,
'Main dispatch and parking yard'),

('Elizabeth Terminal',
'600 Port Road',
'Elizabeth',
'NJ',
'07201',
'(908) 555-2000',
'Lisa Carter',
35,
'Port operations'),

('Philadelphia Terminal',
'300 Logistics Blvd',
'Philadelphia',
'PA',
'19148',
'(215) 555-3000',
'Michael Brown',
40,
'Regional terminal');
GO