BEGIN TRANSACTION ConvertFromClock

BEGIN -- تعاریف پایه 

    DECLARE @FromDate DATE
    DECLARE @EndDate DATE
    DECLARE @OrganID NUMERIC(18, 0)
    DECLARE @GhadirID NUMERIC(18, 0)

    SET @FromDate = '2014/01/01'
    -- تاریخ شروع
    SET @EndDate = '2024/01/01'
     -- تاریخ پایان
    SET @OrganID = 111111
	-- کد سازمان
    SET @GhadirID = 1111111
	-- کد کارشناس غدیر

END

BEGIN -- تنظیم دیتابیس 

    ALTER TABLE ta_person ALTER COLUMN prs_barcode
    NVARCHAR(50) COLLATE Arabic_CI_AS;
    ALTER TABLE clock.dbo.webpass ALTER COLUMN p_barcode
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;
    ALTER TABLE clock.dbo.persons ALTER COLUMN p_parts
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;
    ALTER TABLE clock.dbo.webpasspersons ALTER COLUMN barcode
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;
    ALTER TABLE clock.dbo.webpass ALTER COLUMN p_status
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;
    ALTER TABLE clock.dbo.webpasspersons ALTER COLUMN personbarcode
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;
	--DROP INDEX BCodeIdx ON clock.dbo.persons
	--ALTER TABLE clock.dbo.persons
	--DROP CONSTRAINT PK__persons__3B2BBE9D
    ALTER TABLE clock.dbo.persons ALTER COLUMN P_BarCode
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;

END 

BEGIN -- بخش ها 

    SET IDENTITY_INSERT ta_department ON

    INSERT  INTO ta_department
            ( dep_id ,
              dep_customcode ,
              dep_name ,
              dep_parentid ,
              dep_ParentPath
            )
            SELECT  CONVERT(NUMERIC, p_code) ,
                    p_customcode ,
                    p_name ,
                    CONVERT(NUMERIC, p_father) ,
                    ',' + P_Father
            FROM    [clock].dbo.parts

    SET IDENTITY_INSERT TA_Department OFF

    UPDATE  dbo.TA_Department
    SET     dep_ParentID = 111111
    WHERE   dep_ParentID = -1

    DECLARE @id NUMERIC ,
        @parentId NUMERIC ,
        @path VARCHAR(200)

    DECLARE db_cursor_ CURSOR
    FOR
        SELECT  dep_Id ,
                dep_parentid
        FROM    TA_Department
        WHERE   dep_id <> 111111
        ORDER BY dep_id
    OPEN db_cursor_
    FETCH NEXT FROM db_cursor_ INTO @id, @parentId
    WHILE @@FETCH_STATUS = 0 
        BEGIN   
            SET @path = ''
            SELECT  @path = dep_parentpath
            FROM    ta_department
            WHERE   dep_id = @parentId
            UPDATE  ta_department
            SET     dep_parentpath = ',' + ISNULL(@path, '') + ','
                    + CONVERT(VARCHAR(max), @parentId) + ','
            WHERE   dep_id = @id
            FETCH NEXT FROM db_cursor_ INTO @id, @parentId
        END   
    CLOSE db_cursor_   
    DEALLOCATE db_cursor_

END

BEGIN -- پست های سازمانی 

    SET IDENTITY_INSERT TA_OrganizationUnit ON

    INSERT  TA_OrganizationUnit
            ( organ_ID ,
              organ_Name ,
              organ_CustomCode ,
              organ_PersonID ,
              organ_ParentID ,
              organ_ParentPath
            )
            SELECT  dep_ID ,
                    dep_Name ,
                    dep_CustomCode ,
                    NULL ,
                    dep_ParentID ,
                    dep_ParentPath
            FROM    dbo.TA_Department
            WHERE   dep_ID NOT IN ( 111111, 1111111 )

    SET IDENTITY_INSERT TA_OrganizationUnit OFF

END

BEGIN -- رتبه 

    SET IDENTITY_INSERT dbo.TA_Grade ON

    INSERT  dbo.TA_Grade
            ( Grade_ID ,
              Grade_Name ,
              Grade_Description 
            )
            SELECT  Post_Code ,
                    Post_Name ,
                    Post_Code
            FROM    Clock.dbo.coposts

    SET IDENTITY_INSERT dbo.TA_Grade OFF

END

BEGIN -- محل های ماموریت 
    
    INSERT  TA_DutyPlace
            ( dutyPlc_Name ,
              dutyPlc_CustomCode ,
              dutyPlc_ParentID
            )
            SELECT  M1_Name ,
                    M1_Code ,
                    111111
            FROM    clock.dbo.mission1

    INSERT  TA_DutyPlace
            ( dutyPlc_Name ,
              dutyPlc_CustomCode ,
              dutyPlc_ParentID
            )
            SELECT  M2_Name ,
                    M2_Code ,
                    ( SELECT    dutyPlc_ID
                      FROM      TA_DutyPlace
                      WHERE     dutyPlc_CustomCode = M2_M1Code
                    )
            FROM    clock.dbo.mission2

END

BEGIN -- شیفت ها 

    INSERT  TA_Shift
            ( Shift_Name ,
              Shift_Type ,
              Shift__shiftID ,
              Shift_NobatKari ,
              Shift_MinNobatKari ,
              Shift_Breakfast ,
              Shift_Lunch ,
              Shift_Dinner ,
              Shift_Color ,
              Shift_CustomCode
            )
            SELECT  SH_Name ,
                    0 ,
                    NULL ,
                    NULL ,
                    0 ,
                    0 ,
                    0 ,
                    0 ,
                    'rgb('
                    + CAST(FLOOR(250 * RAND(CONVERT(VARBINARY, NEWID()))) AS NVARCHAR(MAX))
                    + ','
                    + CAST(FLOOR(250 * RAND(CONVERT(VARBINARY, NEWID()))) AS NVARCHAR(MAX))
                    + ','
                    + CAST(FLOOR(250 * RAND(CONVERT(VARBINARY, NEWID()))) AS NVARCHAR(MAX))
                    + ')' ,
                    SH_Code
            FROM    [clock].dbo.shifts

    INSERT  TA_ShiftPair
            ( ShiftPair_ShiftId ,
              ShiftPair_From ,
              ShiftPair_To ,
              ShiftPair_AfterTolerance ,
              ShiftPair_BeforeTolerance ,
              Shiftpair_ShiftPairTypeId
            )
            SELECT  Shift_ID ,
                    ISNULL(( SELECT SH_From1
                             FROM   clock.dbo.shifts
                             WHERE  SH_code = Shift_CustomCode
                           ), 0) ,
                    ISNULL(( SELECT SH_To1
                             FROM   clock.dbo.shifts
                             WHERE  SH_code = Shift_CustomCode
                           ), 0) ,
                    0 ,
                    0 ,
                    1
            FROM    TA_Shift

END

BEGIN -- گروه های کاری 

    INSERT  TA_WorkGroup
            ( WorkGroup_Name ,
              WorkGroup_CustomCode ,
              WorkGroup__grpsCode
            )
            SELECT  Grp_Name ,
                    Grp_Code ,
                    0
            FROM    clock.dbo.groups

END

BEGIN -- انواع استخدام 

    INSERT  TA_EmploymentType
            ( emply_Name ,
              emply_CustomCode
            )
            SELECT  Job_Name ,
                    Job_Code
            FROM    clock.dbo.jobtype

END

BEGIN -- دکتر 

    INSERT  TA_Doctor
            ( dr_FirstName ,
              dr_LastName ,
              dr_Takhasos ,
              dr_Nezampezaeshki ,
              dr_Description
            )
            SELECT  Name ,
                    NULL ,
                    NULL ,
                    NULL ,
                    NULL
            FROM    [clock].[dbo].[doctors]

END

BEGIN -- ایستگاه های کنترل 

    INSERT  TA_ControlStation
            ( station_name ,
              station_customcode
            )
            SELECT  R_Name ,
                    R_Code
            FROM    clock.dbo.readers

END

BEGIN -- دسته قوانین 

    SET IDENTITY_INSERT TA_RuleCategory ON

    INSERT  TA_RuleCategory
            ( RuleCat_ID ,
              RuleCat_Name ,
              RuleCat_Discription ,
              RuleCat_IsRoot ,
              RuleCat_CustomCode
            )
            SELECT  Rule_Code ,
                    Rule_Name ,
                    Rule_Code ,
                    0 ,
                    Rule_Code
            FROM    clock.dbo.rules
			WHERE	Rule_Code IS NOT NULL

    SET IDENTITY_INSERT TA_RuleCategory OFF

    INSERT  TA_RuleCategoryPart
            ( RuleCatPart_ParentCatId ,
              RuleCatPart_ChildCatId ,
              RuleCatPart_IsContain
            )
            SELECT  111111 ,
                    RuleCat_ID ,
                    NULL
            FROM    TA_RuleCategory
            WHERE   RuleCat_ID NOT IN ( 111111, 1111111 )

END

BEGIN -- پرسنل 

    SET IDENTITY_INSERT TA_Person ON

    INSERT  TA_Person
            ( Prs_ID ,
              Prs_Barcode ,
              Prs__Param ,
              Prs_Active ,
              Prs_CardNum ,
              Prs_DepartmentId ,
              Prs_EmploymentNum ,
              Prs_EmploymentDate ,
              Prs_EndEmploymentDate ,
              Prs_EmployId ,
              Prs_Sex ,
              Prs_Education ,
              Prs_FirstName ,
              Prs_MaritalStatus ,
              Prs_LastName ,
              Prs_PrsDtlID ,
              prs_IsDeleted ,
              prs_CreationDate
            )
            SELECT  CAST(P_BarCode AS NUMERIC(18, 0)) ,
                    CAST(P_BarCode AS INT) P_BarCode ,
                    NULL ,
                    P_IsValid ,
                    P_BarCode ,
                    ISNULL(( SELECT dep_ID
                             FROM   TA_Department
                             WHERE  dep_CustomCode = CAST(P_Parts AS NVARCHAR(MAX))
                           ), 1111111) ,
                    P_BarCode ,
                    NULL ,
                    NULL ,
                    ISNULL(( SELECT emply_ID
                             FROM   TA_EmploymentType
                             WHERE  emply_CustomCode = CAST(p_jobcode AS NVARCHAR(MAX))
                           ), 1111111) ,
                    p_sex ,
                    p_madrak ,
                    P_Name ,
                    P_Marry ,
                    P_Family ,
                    NULL ,
                    0 ,
                    GETDATE()
            FROM    [clock].[dbo].persons

    SET IDENTITY_INSERT TA_Person OFF
  
	SET IDENTITY_INSERT TA_PersonDetail ON  

    INSERT  TA_PersonDetail
            ( PrsDtl_ID 
            )
            SELECT  Prs_ID
            FROM    TA_Person
            WHERE   Prs_ID != 1111111

	SET IDENTITY_INSERT TA_PersonDetail OFF

    UPDATE  TA_Person
    SET     Prs_PrsDtlID = Prs_ID
    WHERE   Prs_ID != 1111111

    UPDATE  TA_PersonDetail
    SET     PrsDtl_FatherName = P_Father ,
            PrsDtl_MeliCode = P_MeliCode ,
            PrsDtl_PlaceIssued = P_FromPlace ,
            PrsDtl_BirthPlace = P_BirthPlace
    FROM    clock.dbo.persons
    WHERE   PrsDtl_ID = ( SELECT    prs_id
                          FROM      ta_person
                          WHERE     Prs_Barcode = P_BarCode
                        )
            AND PrsDtl_ID != 1111111

	SET IDENTITY_INSERT TA_PersonTASpec ON 

    INSERT  TA_PersonTASpec
            ( prsta_id ,
              prsTA_ControlStationId ,
              prsTA_UIValidationGroupID ,
              prsTA_Active
            )
            SELECT  prs_id ,
                    1111111 ,
                    ( SELECT TOP 1
                                UIValGrp_ID
                      FROM      dbo.TA_UIValidationGroup
                      WHERE     UIValGrp_CustomCode = 0
                    ) , -- پیشفرض
                    Prs_Active
            FROM    ta_person
            WHERE   Prs_ID != 1111111

	SET IDENTITY_INSERT TA_PersonTASpec OFF
  
END

BEGIN -- انتسابات پرسنل 

    INSERT  TA_PersonRangeAssignment
            ( PrsRangeAsg_PersonId ,
              PrsRangeAsg_CalcRangeGrpId ,
              PrsRangeAsg_FromDate
            )
            SELECT  prs_id ,
                    37353 ,
                    '2014-03-21 00:00:00.000'
            FROM    ta_person
            WHERE   prs_id != 1111111

    INSERT  TA_PersonRuleCategoryAssignment
            ( PrsRulCatAsg_PersonId ,
              PrsRulCatAsg_RuleCategoryId ,
              PrsRulCatAsg_FromDate ,
              PrsRulCatAsg_ToDate ,
              PrsRulCatAsg_IssuanceDate
            )
            SELECT  prs_id ,
                    ISNULL(( SELECT RuleCat_ID
                             FROM   TA_RuleCategory
                             WHERE  RuleCat_CustomCode = CAST(( SELECT
                                                              P_RuleGroup
                                                              FROM
                                                              clock.dbo.persons
                                                              WHERE
                                                              CAST(P_BarCode AS INT) = Prs_Barcode
                                                              ) AS NVARCHAR(MAX))
                           ), 1111111) ,
                    '2014/03/21' ,
                    '2024/03/21' ,
                    NULL
            FROM    ta_person
            WHERE   prs_id != 1111111

    INSERT  TA_AssignWorkGroup
            ( AsgWorkGroup_WorkGroupId ,
              AsgWorkGroup_PersonId ,
              AsgWorkGroup_FromDate
            )
            SELECT  ISNULL(( SELECT WorkGroup_ID
                             FROM   TA_WorkGroup
                             WHERE  WorkGroup_CustomCode = CAST(( SELECT
                                                              P_ShiftGroup
                                                              FROM
                                                              clock.dbo.persons
                                                              WHERE
                                                              CAST(P_BarCode AS INT) = Prs_Barcode
                                                              ) AS NVARCHAR(MAX))
                           ), 1111111) ,
                    prs_id ,
                    '2014-03-21 00:00:00.000'
            FROM    ta_person
            WHERE   prs_id != 1111111

END

BEGIN -- کاربران 

    SET IDENTITY_INSERT TA_SecurityUser ON

    INSERT  TA_SecurityUser
            ( [user_ID] ,
              user_PersonID ,
              user_RoleID ,
              user_DomainID ,
              user_UserName ,
              user_Password ,
              user_Active ,
              user_LastActivityDate ,
              user_IsADAuthenticateActive
            )
            SELECT  prs_id ,
                    prs_id ,
                    ( SELECT TOP 1
                                role_ID
                      FROM      dbo.TA_SecurityRole
                      WHERE     role_Customcode = 6
                    ) , -- کاربر
                    NULL ,
                    Prs_Barcode ,
                    'tJrSqlyZTeVXriPaoUmQ486g1FUR9ms=' , -- 123
                    Prs_Active ,
                    NULL ,
                    0
            FROM    ta_person
            WHERE   Prs_ID != 1111111

    SET IDENTITY_INSERT TA_SecurityUser OFF
  
    SET IDENTITY_INSERT TA_UserSettings ON

    INSERT  TA_UserSettings
            ( userSet_ID ,
              userSet_UserID ,
              userSet_LangID ,
              userSet_SkinID
            )
            SELECT  [user_id] ,
                    [user_id] ,
                    2 ,
                    4
            FROM    TA_SecurityUser
            WHERE   [user_ID] != 1111111

    SET IDENTITY_INSERT TA_UserSettings OFF  
			
END

BEGIN -- انتساب مدیران 

    UPDATE  TA_OrganizationUnit
    SET     organ_PersonID = ( SELECT TOP 1
                                        prs_id
                               FROM     dbo.TA_Person
                               WHERE    Prs_Barcode = ( CAST(BarCode AS INT) )
                             )
    FROM    Clock.dbo.webpass
            JOIN Clock.dbo.webpasspersons ON p_barcode = BarCode
    WHERE   p_status = 3
            AND isPart = 1
            AND organ_ID NOT IN ( 111111, 1111111 )
            AND organ_ID = ( CAST(PersonBarCode AS BIGINT) )

END

BEGIN -- جریان های کاری 

    SET IDENTITY_INSERT dbo.TA_Flow ON

    INSERT  dbo.TA_Flow
            ( Flow_ID ,
              Flow_AccessGroupID ,
              Flow_WorkFlow ,
              Flow_ActiveFlow ,
              Flow_FlowName ,
              Flow_MainFlow ,
              flow_Deleted ,
              flow_GroupID
            )
            SELECT  dep_ID ,
                    1 ,
                    1 ,
                    1 ,
                    dep_Name ,
                    1 ,
                    0 ,
                    1111111
            FROM    dbo.TA_Department
            WHERE   dep_ID NOT IN ( 111111, 1111111 )

    SET IDENTITY_INSERT dbo.TA_Flow OFF

    SET IDENTITY_INSERT dbo.TA_Manager ON

    INSERT  dbo.TA_Manager
            ( MasterMng_ID ,
              MasterMng_PersonID ,
              MasterMng_OrganizationUnitID ,
              MasterMng_Active
            )
            SELECT  dep_ID ,
                    NULL ,
                    dep_ID ,
                    1
            FROM    dbo.TA_Department
            WHERE   dep_ID NOT IN ( 111111, 1111111 )

    SET IDENTITY_INSERT dbo.TA_Manager OFF

    SET IDENTITY_INSERT dbo.TA_ManagerFlow ON

    INSERT  dbo.TA_ManagerFlow
            ( mngrFlow_ID ,
              mngrFlow_ManagerID ,
              mngrFlow_Level ,
              mngrFlow_FlowID ,
              mngrFlow_Active
            )
            SELECT  dep_ID ,
                    dep_ID ,
                    1 ,
                    dep_ID ,
                    1
            FROM    dbo.TA_Department
            WHERE   dep_ID NOT IN ( 111111, 1111111 )

    SET IDENTITY_INSERT dbo.TA_ManagerFlow OFF
  
    SET IDENTITY_INSERT dbo.TA_UnderManagment ON

    INSERT  dbo.TA_UnderManagment
            ( underMng_ID ,
              underMng_FlowID ,
              underMng_PersonID ,
              underMng_DepartmentID ,
              underMng_ContainInnerChilds ,
              underMng_Contains
            )
            SELECT  dep_ID ,
                    dep_ID ,
                    NULL ,
                    dep_ID ,
                    0 ,
                    1
            FROM    dbo.TA_Department
            WHERE   dep_ID NOT IN ( 111111, 1111111 )

    SET IDENTITY_INSERT dbo.TA_UnderManagment OFF  
  
    INSERT  dbo.TA_UnderManagment
            ( underMng_FlowID ,
              underMng_PersonID ,
              underMng_DepartmentID ,
              underMng_ContainInnerChilds ,
              underMng_Contains
            )
            SELECT  organ_ID ,
                    organ_PersonID ,
                    organ_ID ,
                    0 ,
                    0 -- حذف کردن مدیران
            FROM    dbo.TA_OrganizationUnit
            WHERE   organ_PersonID IS NOT NULL
                    AND organ_ID NOT IN ( 111111, 1111111 )  

    INSERT  dbo.TA_UnderManagment
            ( underMng_FlowID ,
              underMng_PersonID ,
              underMng_DepartmentID ,
              underMng_ContainInnerChilds ,
              underMng_Contains
            )
            SELECT  organ_ParentID ,
                    organ_PersonID ,
                    organ_ID ,
                    0 ,
                    1 -- اضافه کردن مدیران
            FROM    dbo.TA_OrganizationUnit
            WHERE   organ_PersonID IS NOT NULL
                    AND organ_ID NOT IN ( 111111, 1111111 )
                    AND organ_ParentID NOT IN ( 111111, 1111111 )

END

BEGIN -- بودجه بندی مرخصی 

    SET IDENTITY_INSERT dbo.TA_Budget ON

    INSERT  dbo.TA_Budget
            ( Budget_ID ,
              Budget_Date ,
              Budget_Day ,
              Budget_Minute ,
              Budget_RuleCatId ,
              Budget_Type ,
              Budget_Description ,
              Budget_Applyed
            )
            SELECT  RuleCat_ID ,
                    '2014-03-21 00:00:00.000' ,
                    30 ,
                    0 ,
                    RuleCat_ID ,
                    1 ,
                    RuleCat_Discription ,
                    0
            FROM    dbo.TA_RuleCategory
            WHERE   RuleCat_ID NOT IN ( 111111, 1111111 )

    SET IDENTITY_INSERT dbo.TA_Budget OFF
  
END
  
BEGIN -- CFP تخصیص 

    SET IDENTITY_INSERT dbo.TA_Calculation_Flag_Persons ON

    INSERT  dbo.TA_Calculation_Flag_Persons
            ( CFP_ID ,
              CFP_PrsId ,
              CFP_Date ,
              CFP_MidNightCalculate ,
              CFP_CalculationIsValid
            )
            SELECT  prs_id ,
                    Prs_ID ,
                    '2014-03-21 00:00:00.000' ,
                    0 ,
                    0
            FROM    dbo.TA_Person
            WHERE   Prs_ID != 1111111

    SET IDENTITY_INSERT dbo.TA_Calculation_Flag_Persons OFF 

END

COMMIT TRANSACTION ConvertFromClock