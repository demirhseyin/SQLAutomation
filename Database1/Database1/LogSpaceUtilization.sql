If(OBJECT_ID('tempdb..#logspace_utilization') IS NOT NULL)
DROP TABLE #logspace_utilization
CREATE TABLE #logspace_utilization (
   Database_Name VARCHAR(50),
   Log_Size DECIMAL(20,5),
   Log_Space_Used DECIMAL(20,5),
   [Status] INT)
INSERT #logspace_utilization
EXEC('DBCC SQLPERF(LOGSPACE)')
GO
SELECT * FROM #logspace_utilization

If(OBJECT_ID('tempdb..#logspace_utilization') IS NOT NULL)
DROP TABLE #logspace_utilization