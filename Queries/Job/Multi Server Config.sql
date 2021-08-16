exec sp_addlinkedserver 'appsrv'
exec sp_addlinkedsrvlogin 'appsrv', 'FALSE', NULL, 'username', 'password';
select * from [appsrv].[GhadirGTS].dbo.TA_Precard
select * from sys.servers

