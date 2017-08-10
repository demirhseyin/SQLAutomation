--FULL BACKUP RESTORE OPERATION
    --Full Backup Restore Variables
DECLARE @FullBPath VARCHAR(256) ='Directory' --Full Backup Directory
DECLARE @BackupName nvarchar(50)='BackupName' --Full Backup Name
DECLARE @DB nvarchar(10) = 'DatabaseName' --Database Name
DECLARE @FullBackup nvarchar(100) = @FullBPath+'\'+@BackupName
    --Restore Operation
RESTORE DATABASE @DB FROM  DISK = @FullBackup
WITH  FILE = 1, 
NORECOVERY,  NOUNLOAD,  STATS = 10
GO

--LOG BACKUP RESTORE OPERATION
   --Log Backup Variables
DECLARE @LogBPath nvarchar(50)='Directory' --Log Backup Directory
DECLARE @backupFile NVARCHAR(500) --Log Backup Name
DECLARE @DB nvarchar(10) = 'DatabaseName' --Database Name(Duplicate)
   --Read All Log Backup File Names in a Directory
DECLARE @FindFile TABLE
 (FileNames nvarchar(500)
  ,depth int
  ,isFile int)
INSERT INTO @FindFile EXEC xp_DirTree @LogBPath,1,1
   --Log Backup Restore Operation
DECLARE backupFiles CURSOR FOR  
SELECT FileNames from @FindFile where isFile=1 AND FileNames LIKE '%.TRN' ORDER BY FileNames ASC 
OPEN backupFiles 
FETCH NEXT FROM backupFiles INTO @backupFile
WHILE @@FETCH_STATUS = 0  
BEGIN
PRINT @backupFile
DECLARE @FullName nvarchar(100)=@LogBPath+ '\' +@backupFile
RESTORE LOG @DB FROM DISK = @FullName WITH FILE = 1 ,NORECOVERY,NOUNLOAD,STATS=10
FETCH NEXT FROM backupFiles INTO @backupFile
END
CLOSE backupFiles
DEALLOCATE backupFiles
RESTORE DATABASE @DB WITH RECOVERY