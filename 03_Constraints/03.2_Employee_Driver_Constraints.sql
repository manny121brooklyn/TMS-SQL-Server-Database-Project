
USE TMS_DB_Test;
GO


-- =============================================
-- Employee Driver Constraints
-- =============================================


-- Employees
-----------------------------------------------

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Manager
FOREIGN KEY (ManagerID)
REFERENCES Employees(EmployeeID);
GO


ALTER TABLE Employees
ADD CONSTRAINT CK_Employees_Salary
CHECK (Salary >= 0);
GO



ALTER TABLE Drivers
ADD CONSTRAINT FK_Drivers_Employees
FOREIGN KEY (EmployeeID)
REFERENCES Employees(EmployeeID);
GO


-- Drivers
-----------------------------------------------

ALTER TABLE Drivers
ADD CONSTRAINT UQ_Drivers_CDLNumber
UNIQUE (CDLNumber);
GO



ALTER TABLE Drivers
ADD CONSTRAINT CK_Drivers_Status
CHECK (Status IN ('Active', 'Inactive', 'Suspended', 'On Leave'));
GO



ALTER TABLE Drivers
ADD CONSTRAINT CK_Drivers_LicenseExpiration
CHECK (LicenseExpiration > HireDate);
GO


ALTER TABLE Drivers
ADD CONSTRAINT DF_Drivers_Status
DEFAULT 'Active' FOR Status;
GO



-- DriverSettlements
-----------------------------------------------

ALTER TABLE DriverSettlements
ADD CONSTRAINT FK_DriverSettlements_Driver
FOREIGN KEY (DriverID)
REFERENCES Drivers(DriverID);
GO



ALTER TABLE DriverSettlements
ADD CONSTRAINT CK_DriverSettlements_Status
CHECK (Status IN ('Pending', 'Paid', 'Cancelled'));
GO


ALTER TABLE DriverSettlements
ADD CONSTRAINT CK_DriverSettlements_Bonus
CHECK (Bonus >= 0);
GO


ALTER TABLE DriverSettlements
ADD CONSTRAINT CK_DriverSettlements_Deductions
CHECK (Deductions >= 0);
GO



ALTER TABLE DriverSettlements
ADD CONSTRAINT CK_DriverSettlements_Reimbursements
CHECK (Reimbursements >= 0);
GO



ALTER TABLE DriverSettlements
ADD CONSTRAINT CK_DriverSettlements_GrossPay
CHECK (GrossPay >= 0);
GO



ALTER TABLE DriverSettlements
ADD CONSTRAINT CK_DriverSettlements_NetPay
CHECK (NetPay >= 0);
GO



ALTER TABLE DriverSettlements
ADD CONSTRAINT UQ_DriverSettlements_Period
UNIQUE (DriverID, PayPeriodStart, PayPeriodEnd);
GO


-- DriverDocuments
-----------------------------------------------

ALTER TABLE DriverDocuments
ADD CONSTRAINT FK_DriverDocuments_Drivers
FOREIGN KEY (DriverID)
REFERENCES Drivers(DriverID);
GO



ALTER TABLE DriverDocuments
ADD CONSTRAINT CK_DriverDocuments_Status
CHECK (Status IN ('Valid', 'Expired', 'Suspended'));
GO



ALTER TABLE DriverDocuments
ADD CONSTRAINT CK_DriverDocuments_Dates
CHECK (ExpiryDate IS NULL OR ExpiryDate >= IssueDate);
GO


-- DriverDevices
-----------------------------------------------
ALTER TABLE DriverDevices
ADD CONSTRAINT FK_DriverDevices_Drivers
FOREIGN KEY(DriverID) REFERENCES Drivers(DriverID);
GO
