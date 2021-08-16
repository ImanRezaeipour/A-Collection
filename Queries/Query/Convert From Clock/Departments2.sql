declare @id numeric,@parentId numeric,@path varchar(200)
DECLARE db_cursor_ CURSOR FOR  
	SELECT dep_Id,dep_parentid
	FROM TA_Department
	where dep_id<>162
	order by dep_id

OPEN db_cursor_
FETCH NEXT FROM db_cursor_ INTO @id,@parentId
------------------------
WHILE @@FETCH_STATUS = 0   
BEGIN   
	set @path=''
       select @path=dep_parentpath from ta_department where dep_id=@parentId
       update ta_department
       set dep_parentpath=','+convert(varchar(10),@parentId)+','+@path
       where dep_id=@id
       FETCH NEXT FROM db_cursor_ INTO @id,@parentId
END   
-----------------------
CLOSE db_cursor_   
DEALLOCATE db_cursor_ 
print 'Delete Finished'
