
DECLARE @resCount INT ,
    @resCounter INT ,
    @resID NUMERIC(18, 0) ,
    @roleID NUMERIC(18, 0) ,
    @subSystemID INT
SET @subSystemID = 2 -- This is System Id [Change this Id for every System ID {1 ,2}]
SET @resCount = ( SELECT    COUNT(resource_ID)
                  FROM      TA_SecurityResource res
                  WHERE     resource_SubSystemID = @subSystemID
                )
SET @resCounter = 1
SET @roleID = 1     -- This is Admin Role Id [change if is required to apply on another roles]
DELETE  FROM TA_SecurityAuthorize
WHERE   Athorize_ID IN (
        SELECT  auth.Athorize_ID
        FROM    TA_SecurityResource res
                INNER JOIN TA_SecurityAuthorize auth ON res.resource_ID = auth.Athorize_ResourceID
        WHERE   res.resource_SubSystemID = @subSystemID
                AND auth.Athorize_RoleID = @roleID )
WHILE ( @resCounter <= @resCount ) 
    BEGIN
        SET @resID = ( SELECT   Res.Resource_ID
                       FROM     ( SELECT    res.Resource_ID ,
                                            ROW_NUMBER() OVER ( ORDER BY resource_ID ASC ) intRow
                                  FROM      TA_SecurityResource res
                                  WHERE     resource_SubSystemID = @subSystemID
                                ) Res
                       WHERE    Res.intRow = @resCounter
                     )
        INSERT  INTO TA_SecurityAuthorize
        VALUES  ( @roleID, @resID, 1 )
        SET @resCounter = @resCounter + 1
    END









