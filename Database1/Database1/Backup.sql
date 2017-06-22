CREATE PROCEDURE dbo.BackupALL  @path VARCHAR(256) --Backup Path
AS
DECLARE @name VARCHAR(50) -- Database Name 
DECLARE @fileName VARCHAR(256) -- File Name/Data  
DECLARE @fileDate VARCHAR(20) -- DateTime Stamp for File Name


--Time Stamp for Files
SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) 

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
       SET @fileName = @path + @name + '.BAK'  
       BACKUP DATABASE @name TO DISK = @fileName WITH STATS = 1,COMPRESSION,CHECKSUM,INIT

       FETCH NEXT FROM db_cursor INTO @name   
END   
--Backup End
CLOSE db_cursor   
DEALLOCATE db_cursor 
GO