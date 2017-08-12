CREATE PROCEDURE dbo.LogBackup  @path VARCHAR(256) --Backup Path
AS
DECLARE @name VARCHAR(50) -- Database Name 
DECLARE @fileName VARCHAR(256) -- File Name/Data  
DECLARE @fileDate VARCHAR(20) -- DateTime Stamp for File Name
DECLARE @time DATETIME
DECLARE @year VARCHAR(4)
DECLARE @month VARCHAR(2)
DECLARE @day VARCHAR(2)
DECLARE @hour VARCHAR(2)
DECLARE @minute VARCHAR(2)
DECLARE @second VARCHAR(2)
--test
--Time Stamp for Files
SELECT @time = (GETDATE())
SELECT @month  = (SELECT CONVERT(VARCHAR(2), FORMAT(DATEPART(mm,@time),'00')))
SELECT @day    = (SELECT CONVERT(VARCHAR(2), FORMAT(DATEPART(dd,@time),'00')))
SELECT @hour   = (SELECT CONVERT(VARCHAR(2), FORMAT(DATEPART(hh,@time),'00')))
SELECT @minute = (SELECT CONVERT(VARCHAR(2), FORMAT(DATEPART(mi,@time),'00')))
SELECT @second = (SELECT CONVERT(VARCHAR(2), FORMAT(DATEPART(ss,@time),'00')))

DECLARE db_cursor CURSOR FOR  

--All Databases Except System Databases
SELECT name 
FROM master.dbo.sysdatabases 
WHERE name NOT IN ('master','model','msdb','tempdb','ReportServer','ReportServerTempDB')  


OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   
--Backup Starts
WHILE @@FETCH_STATUS = 0   
BEGIN   
       SET @fileName = @path + @name +'_'+@month+'_'+@day+'_'+@hour+'_'+@minute  + '.TRN'  

       BACKUP LOG @name TO DISK = @fileName WITH STATS = 1,COMPRESSION,CHECKSUM,INIT

       FETCH NEXT FROM db_cursor INTO @name   
END   
--Backup End
CLOSE db_cursor   
DEALLOCATE db_cursor 
GO