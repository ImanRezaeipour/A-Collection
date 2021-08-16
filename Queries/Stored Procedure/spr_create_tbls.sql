
ALTER PROCEDURE spr_create_tbls
AS
BEGIN
declare @ystr varchar(6)
declare @str varchar(500)

set @ystr='137901'
while @ystr<'139412'
begin
----------------
  if not exists(select name from sys.objects where type='u' and name='C'+@ystr) 
  begin
    set @str='select * into C'+@ystr+' from CTEMP'
    exec(@str)    
  end  
	set @str='C'+@ystr
	execute spr_trg_IDU_tbl @str  
-----------------
  if not exists(select name from sys.objects where type='u' and name='T'+@ystr) 
  begin
    set @str='select * into T'+@ystr+' from TTEMP'
    exec(@str)
  end
  	set @str='t'+@ystr
	execute spr_trg_IDU_tbl @str    

-----------------
  if not exists(select name from sys.objects where type='u' and name='A'+@ystr) 
  begin
    set @str='select * into A'+@ystr+' from ATEMP'
    exec(@str)
  end  
  	set @str='a'+@ystr
	execute spr_trg_IDU_tbl @str    

-----------------
  if not exists(select name from sys.objects where type='u' and name='E'+@ystr) 
  begin
    set @str='select * into E'+@ystr+' from ETEMP'
    exec(@str)
  end  
  	set @str='e'+@ystr
	execute spr_trg_IDU_tbl @str    

-----------------
  set @ystr=dbo.AfterMonthDate(@ystr)
end
END
