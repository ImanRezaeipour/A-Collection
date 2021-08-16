DECLARE @ColumnID INT
DECLARE @Columns_Chg VARCHAR(8000)
DECLARE @Columns_Chg_tbl table (Columns_Chg_Name varchar(100))
SET @Columns_Chg = SPACE(0)
SET @ColumnID = 1
WHILE @ColumnID <= (SELECT COUNT(*)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Persons')
BEGIN
IF (SUBSTRING(COLUMNS_UPDATED(),(@ColumnID - 1) / 8 + 1, 1)) &
POWER(2, (@ColumnID - 1) % 8)>0 
begin
  set @Columns_Chg=(SELECT  COLUMN_NAME  FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'Persons' and ORDINAL_POSITION=@ColumnID)
  insert into @Columns_Chg_tbl values(@Columns_Chg)
end
SET @ColumnID = @ColumnID + 1
END
select * from @Columns_Chg_tbl
END
