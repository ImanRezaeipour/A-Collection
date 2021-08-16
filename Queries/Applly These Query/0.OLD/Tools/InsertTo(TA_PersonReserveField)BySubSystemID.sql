DECLARE @reserveCount INT ,
    @reserveCounter INT ,
    @reserveType INT ,
    @subSystemID INT 
SET @subSystemID = 2
SET @reserveCount = 20
SET @reserveCounter = 1
WHILE ( @reserveCounter <= @reserveCount ) 
    BEGIN
        IF @reserveCounter < 15 
            BEGIN
                SET @reserveType = 1
            END
        ELSE 
            BEGIN
                SET @reserveType = 2
            END
        INSERT  INTO TA_PersonReserveField
        VALUES  ( N'R' + CAST(@reserveCounter AS NCHAR(10)),
                  N'فیلد رزرو ' + CAST(@reserveCounter AS NVARCHAR(50)),
                  @reserveType, NULL, NULL, @subSystemID )
        SET @reserveCounter = @reserveCounter + 1
    END



