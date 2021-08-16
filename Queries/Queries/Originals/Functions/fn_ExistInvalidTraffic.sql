
ALTER FUNCTION fn_ExistInvalidTraffic (@personId int,@barcode varchar(10))
RETURNS bit
AS
BEGIN
	DECLARE @rowCount int,@date datetime,@datetmp datetime
	SET @date= dbo.fn_StartInValidTrafficDateByBarcode(@barcode)
	set @datetmp=CONVERT(datetime, @date,101)
	SELECT @rowCount=Count(*) FROM TA_BaseTraffic
	WHERE BasicTraffic_PersonID=@personId AND BasicTraffic_Date >= @datetmp
	
	IF(@rowCount = 0)
		Return 0;
	ELSE 
		Return 1;
	
	Return 1;

END


