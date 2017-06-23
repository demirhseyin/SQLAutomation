--Restore an Existing Database(Overwrite)

USE [master]
RESTORE DATABASE [NameGenerator] FROM  DISK = N'Location of Backup' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5
GO

--Restore a Database with Different Name(Clone)

USE [master]
--Get The Logical Names of Database Files
RESTORE FILELISTONLY FROM DISK='Location of Backup'
--Restore The Database
RESTORE DATABASE [Database_Name] FROM  DISK = N'Location of Backup' WITH  FILE = 1,  
MOVE N'NameGenerator' TO N'Location of The New .MDF File',  
MOVE N'NameGenerator_log' TO N'Location of The New .LDF File',  NOUNLOAD,  STATS = 5
GO