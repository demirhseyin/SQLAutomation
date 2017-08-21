# T-SQL-Backup-Restore Automation Script Repository

The BS Automation scripts, creates a procedure called Backup and LogBackup on databases. When this procedures are executed, log and full backups of all databases in the server is taken to a path defined by DBA. 

Example Usage of Full Backup Procedure

exec dbo.BackupALL '<Your Path Information>'

Example Usage of Log Backup Procedure

exec dbo.LogBackup '<Your Path Information>'
