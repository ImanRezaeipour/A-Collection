
DECLARE @PersonID DECIMAL(18, 0) ,
    @PersonActive BIT
DECLARE @GetPersonList CURSOR
SET 
@GetPersonList = cursor for
select prs.Prs_ID, prs.Prs_Active from TA_Person prs
OPEN @GetPersonList
FETCH NEXT
FROM @GetPersonList INTO @PersonID, @PersonActive
WHILE @@fetch_status = 0
    BEGIN
        INSERT  INTO CL_PersonCLSpec
        VALUES  ( @PersonID, NULL, @PersonActive, NULL, NULL, NULL, NULL, NULL,
                  NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                  NULL, NULL, NULL, NULL, NULL, NULL, NULL )
        FETCH NEXT
	FROM @GetPersonList INTO @PersonID, @PersonActive
    END
CLOSE @GetPersonList
DEALLOCATE @GetPersonList




