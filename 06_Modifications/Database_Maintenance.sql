
USE TMS_DB_TEST;
GO

-- =============================================
-- Enable all constraints after data loading
-- Database maintenance script
-- =============================================

EXEC sp_MSforeachtable 
'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';
GO

