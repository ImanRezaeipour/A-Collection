exec sp_addlinkedserver 'appsrv';
--on local
exec sp_addlinkedsrvlogin 'appsrv'
    , 'FALSE', NULL, 'atlas', 'salta123';
    
-- on server    
    
exec sp_addlinkedsrvlogin 'appsrv'
    , 'FALSE', NULL, 'farhad', '123';