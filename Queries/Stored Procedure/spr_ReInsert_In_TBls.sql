declare @name_ varchar(50)
declare @str_  varchar(200)
DECLARE db_cursor_ CURSOR FOR  
SELECT name from sysobjects where type='U' and left(name,3)='ta_' and right(name,8)<>'template'

OPEN db_cursor_
FETCH NEXT FROM db_cursor_ INTO @name_   
WHILE @@FETCH_STATUS = 0   
BEGIN   
       set @str_='delete '+@name_
       execute(@str_)
----------------------
       FETCH NEXT FROM db_cursor_ INTO @name_
END   
CLOSE db_cursor_   
DEALLOCATE db_cursor_ 

------------------------------
------------------------------
------------------------------
declare @name varchar(50)
declare @str  varchar(200)
DECLARE db_cursor CURSOR FOR  
SELECT name from sysobjects where type='U' and left(name,3)<>'ta_'

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   
WHILE @@FETCH_STATUS = 0   
BEGIN   
       set @str='select * into '+@name+'_tmp from '+@name+' truncate table '+@name+' insert into '+@name+' select * from '+@name+'_tmp  drop table '+@name+'_tmp'
       execute(@str)
----------------------
       FETCH NEXT FROM db_cursor INTO @name   
END   
CLOSE db_cursor   
DEALLOCATE db_cursor 

