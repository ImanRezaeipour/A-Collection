RESTORE DATABASE [%AtlasDB%] 
FROM  DISK = N'%Path%\_ATLAS_\Backup\AtlasGTS.bak' WITH  FILE = 1,  
MOVE N'AtlasGTS' TO N'%Path%\_ATLAS_\Database\%AtlasDB%.MDF',  
MOVE N'GhadirGTS_log' TO N'%Path%\_ATLAS_\Database\%AtlasDB%.LDF',  
NOUNLOAD,  
REPLACE,  
STATS = 5