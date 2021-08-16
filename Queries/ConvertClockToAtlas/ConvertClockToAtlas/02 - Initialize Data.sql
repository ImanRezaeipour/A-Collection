SET NOCOUNT ON

BEGIN TRANSACTION InitializeData

PRINT 'تنظیمات واسط کاربری'
BEGIN 

	SET IDENTITY_INSERT TA_UIValidationGroup ON

	INSERT TA_UIValidationGroup
           ( UIValGrp_ID ,
			 UIValGrp_Name ,
             UIValGrp_CustomCode ,
             UIValGrp_SubSystemID
			)
			SELECT	111111,
					'پیشفرض',
					'111111',
					1

	SET IDENTITY_INSERT TA_UIValidationGroup OFF

END

PRINT 'دکتر'
BEGIN 

	SET IDENTITY_INSERT TA_Doctor ON

    INSERT  TA_Doctor
            ( dr_ID ,
			  dr_FirstName ,
              dr_LastName ,
              dr_Takhasos ,
              dr_Nezampezaeshki ,
              dr_Description
            )
            SELECT  111111 ,
					'پیشفرض' ,
                    '' ,
                    '' ,
                    '111111' ,
                    NULL

	SET IDENTITY_INSERT TA_Doctor OFF

END

PRINT 'رتبه'
BEGIN 

    SET IDENTITY_INSERT TA_Grade ON

    INSERT  TA_Grade
            ( Grade_ID ,
              Grade_Name ,
              Grade_Description 
            )
            SELECT  111111 ,
                    'پیشفرض' ,
                    NULL

    SET IDENTITY_INSERT TA_Grade OFF

END

PRINT 'بخش'
BEGIN 

    SET IDENTITY_INSERT ta_department ON

    INSERT  TA_Department
            ( dep_ID ,
              dep_Name ,
              dep_CustomCode ,
              dep_ParentID ,
              dep_ParentPath
            )
            SELECT  11111 ,
                    'سازمان' ,
                    '0' ,
                    NULL ,
                    NULL
       
    INSERT  TA_Department
            ( dep_ID ,
              dep_Name ,
              dep_CustomCode ,
              dep_ParentID ,
              dep_ParentPath
            )
            SELECT  111111 ,
                    'شرکت غدیر' ,
                    '111111' ,
                    11111 ,
                    ',11111,'
        
    SET IDENTITY_INSERT TA_Department OFF

END

PRINT 'پست سازمانی'
BEGIN 

    SET IDENTITY_INSERT TA_OrganizationUnit ON

    INSERT  dbo.TA_OrganizationUnit
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

    SET IDENTITY_INSERT TA_OrganizationUnit OFF

END

PRINT 'محل ماموریت'
BEGIN 

    SET IDENTITY_INSERT TA_DutyPlace ON

    INSERT  TA_DutyPlace
            ( dutyPlc_ID ,
              dutyPlc_Name ,
              dutyPlc_CustomCode ,
              dutyPlc_ParentID
            )
    VALUES  ( 111111 ,
              'محل ماموريت' ,
              '111111' ,
              NULL
            )

    SET IDENTITY_INSERT TA_DutyPlace OFF

END

PRINT 'شیفت'
BEGIN 

    SET IDENTITY_INSERT TA_Shift ON

    INSERT  TA_Shift
            ( Shift_ID ,
              Shift_Name ,
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
    VALUES  ( 111111 ,
              'پیشفرض' ,
              0 ,
              NULL ,
              NULL ,
              0 ,
              0 ,
              0 ,
              0 ,
              'rgb(0,250,0)' ,
              '111111'
            )

    SET IDENTITY_INSERT TA_Shift OFF

    SET IDENTITY_INSERT TA_ShiftPair ON

    INSERT  TA_ShiftPair
            ( ShiftPair_ID ,
              ShiftPair_ShiftId ,
              ShiftPair_From ,
              ShiftPair_To ,
              ShiftPair_AfterTolerance ,
              ShiftPair_BeforeTolerance ,
              Shiftpair_ShiftPairTypeId
            )
    VALUES  ( 111111 ,
              111111 , -- پیشفرض
              '480' ,
              '960' ,
              0 ,
              0 ,
              1 -- عادی
            )

    SET IDENTITY_INSERT TA_ShiftPair OFF

END

PRINT 'گروه کاری'
BEGIN 

    SET IDENTITY_INSERT TA_WorkGroup ON

    INSERT  TA_WorkGroup
            ( WorkGroup_ID ,
              WorkGroup_Name ,
              WorkGroup_CustomCode ,
              WorkGroup__grpsCode
            )
    VALUES  ( 111111 ,
              'پیشفرض' ,
              '111111' ,
              0
            )

    SET IDENTITY_INSERT TA_WorkGroup OFF

END

PRINT 'نوع استخدام'
BEGIN 

    SET IDENTITY_INSERT TA_EmploymentType ON

    INSERT  TA_EmploymentType
            ( emply_id ,
              emply_name ,
              emply_customcode
            )
    VALUES  ( 111111 ,
              'پیشفرض' ,
              '111111'
            )

    SET IDENTITY_INSERT TA_EmploymentType OFF

END

PRINT 'ایستگاه کنترل'
BEGIN 

    SET IDENTITY_INSERT TA_ControlStation ON

    INSERT  TA_ControlStation
            ( station_id ,
              station_name ,
              station_customcode
            )
    VALUES  ( 111111 ,
              'پیشفرض' ,
              '111111'
            )

    SET IDENTITY_INSERT TA_ControlStation OFF

END

PRINT 'دسته قوانین'
BEGIN 

    SET IDENTITY_INSERT TA_RuleCategory ON

    INSERT  TA_RuleCategory
            ( RuleCat_ID ,
              RuleCat_Name ,
              RuleCat_Discription ,
              RuleCat_IsRoot ,
              RuleCat_CustomCode
            )
    VALUES  ( 11111 ,
              'دسته قوانين' ,
              NULL ,
              1 ,
              '0'
            )

    INSERT  TA_RuleCategory
            ( rulecat_id ,
              RuleCat_Name ,
              RuleCat_Discription ,
              RuleCat_IsRoot ,
              RuleCat_CustomCode
            )
    VALUES  ( 111111 ,
              'پیشفرض' ,
              NULL ,
              0 ,
              '111111'
            )

    SET IDENTITY_INSERT TA_RuleCategory OFF

    SET IDENTITY_INSERT TA_RuleCategoryPart ON

    INSERT  TA_RuleCategoryPart
            ( rulecatpart_id ,
              RuleCatPart_ParentCatId ,
              RuleCatPart_ChildCatId ,
              RuleCatPart_IsContain
            )
    VALUES  ( 111111 ,
              11111 , -- دسته قوانین
              111111 , -- پیشفرض
              NULL
            )

    SET IDENTITY_INSERT TA_RuleCategoryPart OFF

END

PRINT 'پرسنل'
BEGIN 

    SET IDENTITY_INSERT TA_Person ON

    INSERT  TA_Person
            ( prs_id ,
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
		SELECT	111111 ,
              '111111' ,
              NULL ,
              1 ,
              '111111' ,
              111111 , -- شرکت غدیر
              '111111' ,
              NULL ,
              NULL ,
              111111 , -- پیشفرض
              0 , -- مرد
              NULL ,
              'کارشناس' ,
              1 , -- مجرد
              'غدیر' ,
              NULL ,
              0 ,
              GETDATE()

    SET IDENTITY_INSERT TA_Person OFF

    --SET IDENTITY_INSERT TA_PersonDetail ON

    INSERT  TA_PersonDetail
            (	PrsDtl_ID ,
				PrsDtl_Image )
            SELECT  111111 ,
					'111111' + '.jpg'


    --SET IDENTITY_INSERT TA_PersonDetail OFF

    UPDATE  TA_Person
    SET     Prs_PrsDtlID = 111111 -- کارشناس غدیر

    --SET IDENTITY_INSERT TA_PersonTASpec ON

    INSERT  TA_PersonTASpec
            ( prsta_id ,
              prsTA_ControlStationId ,
              prsTA_UIValidationGroupID ,
              prsTA_Active
            )
            SELECT  111111 ,
                    111111 , -- پیشفرض
                    111111 , -- پیشفرض
                    Prs_Active
            FROM    ta_person

    --SET IDENTITY_INSERT TA_PersonTASpec OFF

END

PRINT 'انتسابات پرسنل'
BEGIN 

    SET IDENTITY_INSERT TA_PersonRangeAssignment ON
    
    INSERT  TA_PersonRangeAssignment
            ( PrsRangeAsg_ID ,
              PrsRangeAsg_PersonId ,
              PrsRangeAsg_CalcRangeGrpId ,
              PrsRangeAsg_FromDate
            )
            SELECT  111111 ,
                    111111 , -- کارشناس غدیر
                    1 , -- پیشفرض
                    '2015-03-21 00:00:00.000'

    SET IDENTITY_INSERT TA_PersonRangeAssignment OFF
  
    SET IDENTITY_INSERT TA_PersonRuleCategoryAssignment ON  

    INSERT  TA_PersonRuleCategoryAssignment
            ( PrsRulCatAsg_ID ,
              PrsRulCatAsg_PersonId ,
              PrsRulCatAsg_RuleCategoryId ,
              PrsRulCatAsg_FromDate ,
              PrsRulCatAsg_ToDate ,
              PrsRulCatAsg_IssuanceDate
            )
            SELECT  111111 ,
                    111111 , -- کارشناس غدیر 
                    111111 , -- پیشفرض
                    '2015/03/21' ,
                    '2025/03/21' ,
                    NULL
  
    SET IDENTITY_INSERT TA_PersonRuleCategoryAssignment OFF   
	
    SET IDENTITY_INSERT TA_AssignWorkGroup ON              

    INSERT  TA_AssignWorkGroup
            ( AsgWorkGroup_ID ,
              AsgWorkGroup_WorkGroupId ,
              AsgWorkGroup_PersonId ,
              AsgWorkGroup_FromDate
            )
            SELECT  111111 ,
                    111111 , -- پیشفرض
                    111111 , -- کارشناس غدیر
                    '2015-03-21 00:00:00.000'

    SET IDENTITY_INSERT TA_AssignWorkGroup OFF

END

PRINT 'کاربر'
BEGIN 

    SET IDENTITY_INSERT TA_SecurityUser ON

    INSERT  TA_SecurityUser
            ( [user_id] ,
              user_PersonID ,
              user_RoleID ,
              user_DomainID ,
              user_UserName ,
              user_Password ,
              user_Active ,
              user_LastActivityDate ,
              user_IsADAuthenticateActive
            )
    VALUES  ( 111111 ,
              111111 , -- کارشناس غدیر
              ( SELECT TOP 1
                        role_ID
                FROM    dbo.TA_SecurityRole
                WHERE   role_Customcode = 1
              ) , -- مدیر سیستم
              NULL ,
              'admin' ,
              'tJrSqlyZTeVXriPaoUmQ486g1FUR9ms=' , -- 123
              1 ,
              NULL ,
              0
            )

    SET IDENTITY_INSERT TA_SecurityUser OFF

    SET IDENTITY_INSERT TA_UserSettings ON
    
    INSERT  TA_UserSettings
            ( userSet_ID ,
              userSet_UserID ,
              userSet_LangID ,
              userSet_SkinID
            )
            SELECT  111111 ,
                    111111 , -- کارشناس غدیر
                    2 , -- فارسی
                    4 -- نقره ای

    SET IDENTITY_INSERT TA_UserSettings OFF

END

PRINT 'گروه قانون'
BEGIN 

    DECLARE @catid INT
    DECLARE CursorTemp_0 CURSOR
    FOR
        SELECT  RuleCat_ID
        FROM    TA_RuleCategory
		WHERE	RuleCat_ID !=  11111 -- سازمان
    OPEN CursorTemp_0
    FETCH NEXT FROM CursorTemp_0 INTO @catid
    WHILE @@FETCH_STATUS = 0 
        BEGIN  
            INSERT  TA_Rule
                    SELECT  RuleTmp_IdentifierCode ,
                            RuleTmp_Script ,
                            RuleTmp_Name ,
                            RuleTmp_CustomCode ,
                            RuleTmp_ID ,
                            RuleTmp_IsPeriodic ,
                            @catid ,
                            RuleTmp_RuleTypeId ,
                            RuleTmp_Order ,
                            RuleTmp_IsForcible ,
							RuleTmp_CustomOrder
                    FROM    TA_RuleTemplate
                    WHERE   RuleTmp_IdentifierCode IN ( 1016, 1017, 1018,
														2003, 2004, 2012,
														3008, 3009, 3012, 3013, 3017,
														4001, 4003, 4008,
														5009, 5012, 5021, 5022, 5023 )
            FETCH NEXT FROM CursorTemp_0 INTO @catid
        END
    CLOSE CursorTemp_0
    DEALLOCATE CursorTemp_0

    DECLARE @ruleid INT
    DECLARE @ruleident INT
    DECLARE CursorTemp_0 CURSOR
    FOR
        SELECT  Rule_ID ,
                Rule_IdentifierCode
        FROM    TA_Rule
    OPEN CursorTemp_0
    FETCH NEXT FROM CursorTemp_0 INTO @ruleid, @ruleident
    WHILE @@FETCH_STATUS = 0 
        BEGIN  
            INSERT  TA_AssignRuleParameter
                    SELECT  '2015-03-21 00:00:00.000' ,
                            '2025-03-21 00:00:00.000' ,
                            @ruleid
            INSERT  TA_RuleParameter
                    SELECT  ( SELECT    top 1 AsgRuleParam_ID
                              FROM      TA_AssignRuleParameter
                              WHERE     AsgRuleParam_RuleId = @ruleid
                            ) ,
                            RuleTmpParam_Name ,
                            0 ,
                            RuleTmpParam_Type ,
                            RuleTmpParam_Title ,
                            0
                    FROM    TA_RuleTemplateParameter
                    WHERE   RuleTmpParam_RuleTemplateId = ( SELECT top 1
                                                              RuleTmp_ID
                                                            FROM
                                                              TA_RuleTemplate
                                                            WHERE
                                                              RuleTmp_IdentifierCode = @ruleident
                                                          )
            FETCH NEXT FROM CursorTemp_0 INTO @ruleid, @ruleident
        END
    CLOSE CursorTemp_0
    DEALLOCATE CursorTemp_0

END

PRINT 'انتساب مدیر'
BEGIN 

    UPDATE  TA_OrganizationUnit
    SET     organ_PersonID = 111111 -- کارشناس غدیر
    WHERE   organ_ID = 111111 -- شرکت غدیر

END

PRINT 'جریان کاری'
BEGIN 

    SET IDENTITY_INSERT dbo.TA_FlowGroup ON

    INSERT  dbo.TA_FlowGroup
            ( FlowGroup_ID ,
              FlowGroup_Name ,
              FlowGroup_Description
            )
            SELECT  111111 ,
                    'پیشفرض' ,
                    NULL

    SET IDENTITY_INSERT dbo.TA_FlowGroup OFF

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
            SELECT  111111 ,
                    1 , -- پیشفرض
                    111111 , -- پیشفرض
                    1 ,
                    'کارشناس غدیر' ,
                    0 ,
                    0 ,
                    111111 -- پیشفرض

    SET IDENTITY_INSERT dbo.TA_Flow OFF

    SET IDENTITY_INSERT dbo.TA_UnderManagment ON

    INSERT  dbo.TA_UnderManagment
            ( underMng_ID ,
              underMng_FlowID ,
              underMng_PersonID ,
              underMng_DepartmentID ,
              underMng_ContainInnerChilds ,
              underMng_Contains
            )
            SELECT  111111 ,
                    111111 , -- پیشفرض
                    NULL ,
                    11111 , -- سازمان
                    1 ,
                    1

    SET IDENTITY_INSERT dbo.TA_UnderManagment OFF

    SET IDENTITY_INSERT dbo.TA_Manager ON

    INSERT  dbo.TA_Manager
            ( MasterMng_ID ,
              MasterMng_PersonID ,
              MasterMng_OrganizationUnitID ,
              MasterMng_Active
            )
            SELECT  111111 ,
                    NULL ,
                    111111 , -- شرکت غدیر
                    1

    SET IDENTITY_INSERT dbo.TA_Manager OFF

    SET IDENTITY_INSERT dbo.TA_ManagerFlow ON

    INSERT  dbo.TA_ManagerFlow
            ( mngrFlow_ID ,
              mngrFlow_ManagerID ,
              mngrFlow_Level ,
              mngrFlow_FlowID ,
              mngrFlow_Active
            )
            SELECT  111111 ,
                    111111 , -- کارشناس غدیر
                    1 ,
                    111111 , -- کارشناس غدیر
                    1

    SET IDENTITY_INSERT dbo.TA_ManagerFlow OFF
  
END

PRINT 'بودجه بندی مرخصی'
BEGIN 

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
            SELECT  111111 ,
                    '2015-03-21 00:00:00.000' ,
                    30 ,
                    0 ,
                    111111 , -- پیشفرض
                    1 ,
                    NULL ,
                    0

    SET IDENTITY_INSERT dbo.TA_Budget OFF
  
END
  
PRINT 'CFP تخصیص'
BEGIN 

    SET IDENTITY_INSERT dbo.TA_Calculation_Flag_Persons ON

    INSERT  dbo.TA_Calculation_Flag_Persons
            ( CFP_ID ,
              CFP_PrsId ,
              CFP_Date ,
              CFP_MidNightCalculate ,
              CFP_CalculationIsValid
            )
            SELECT  111111 ,
                    111111 , -- کارشناس غدیر
                    '2015-03-21 00:00:00.000' ,
                    0 ,
                    0

    SET IDENTITY_INSERT dbo.TA_Calculation_Flag_Persons OFF 

END

PRINT 'شرکت'
BEGIN 

    SET IDENTITY_INSERT TA_OrganDefine ON

    INSERT  dbo.TA_OrganDefine
            ( OrgDef_ID ,
              OrgDef_Code ,
              OrgDef_Name ,
              OrgDef_Address ,
              OrgDef_Fax ,
              OrgDef_EconomicCode ,
              OrgDef_Description ,
              OrgDef_Phone
            )
            SELECT  111111 ,
                    '111111' ,
                    'پیشفرض' ,
                    NULL ,
                    NULL ,
                    NULL ,
                    NULL ,
                    NULL

    SET IDENTITY_INSERT TA_OrganDefine OFF

END

PRINT 'سطوح دسترسی'
BEGIN 

    INSERT  TA_DataAccessCtrlStation
            SELECT  111111 ,
                    NULL ,
                    1 -- همه
    INSERT  TA_DataAccessDepartment
            SELECT  111111 ,
                    NULL ,
                    1 -- همه
    INSERT  TA_DataAccessDoctor
            SELECT  111111 ,
                    NULL ,
                    1 -- همه
    INSERT  TA_DataAccessFlow
            SELECT  111111 ,
                    NULL ,
                    1 -- همه
    INSERT  TA_DataAccessManager
            SELECT  111111 ,
                    NULL ,
                    1 -- همه
    INSERT  TA_DataAccessOrgan
            SELECT  111111 ,
                    111111 -- همه
    INSERT  TA_DataAccessOrganizationUnit
            SELECT  111111 ,
                    NULL ,
                    1 -- همه
    INSERT  TA_DataAccessPrecard
            SELECT  111111 ,
                    NULL ,
                    1 -- همه
    INSERT  TA_DataAccessReport
            SELECT  111111 ,
                    NULL ,
                    1 -- همه
    INSERT  TA_DataAccessRuleGroup
            SELECT  111111 ,
                    NULL ,
                    1 -- همه
    INSERT  TA_DataAccessShift
            SELECT  111111 ,
                    NULL ,
                    1 -- همه
    INSERT  TA_DataAccessWorkGroup
            SELECT  111111 ,
                    NULL ,
                    1 -- همه

    INSERT  TA_SecurityAuthorize
            ( Athorize_RoleID ,
              Athorize_ResourceID ,
              Athorize_Allow
            )
            SELECT  ( SELECT TOP 1
                                role_ID
                      FROM      dbo.TA_SecurityRole
                      WHERE     role_Customcode = 1
                    ) , -- مدیر سیستم
                    resource_ID ,
                    1
            FROM    TA_SecurityResource

END

COMMIT TRANSACTION InitializeData