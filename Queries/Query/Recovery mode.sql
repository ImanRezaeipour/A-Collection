USE master ;
SELECT name, recovery_model_desc
   FROM sys.databases
      WHERE recovery_model_desc='FULL'
ALTER DATABASE PezeshkiGhanooniDB SET RECOVERY SIMPLE ;