RESTORE DATABASE [%LogDB%] 
FROM  DISK = N'%Path%\_ATLAS_\Backup\LogGTS.bak' WITH  FILE = 1,  
MOVE N'LogDB' TO N'%Path%\_ATLAS_\Database\%LogDB%.MDF',  
MOVE N'LogDB_log' TO N'%Path%\_ATLAS_\Database\%LogDB%.LDF',  
NOUNLOAD,  
REPLACE,  
STATS = 5
