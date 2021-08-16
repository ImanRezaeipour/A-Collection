BEGIN TRANSACTION InitializeData

BEGIN -- تنظیمات واسط کاربری 

	SET IDENTITY_INSERT TA_UIValidationGroup ON

	INSERT TA_UIValidationGroup
           ( UIValGrp_ID ,
			 UIValGrp_Name ,
             UIValGrp_CustomCode ,
             UIValGrp_SubSystemID
			)
			SELECT	1111111,
					'پیشفرض',
					'0',
					1

	SET IDENTITY_INSERT TA_UIValidationGroup OFF

END

BEGIN -- دکتر 

	SET IDENTITY_INSERT TA_Doctor ON

    INSERT  TA_Doctor
            ( dr_ID ,
			  dr_FirstName ,
              dr_LastName ,
              dr_Takhasos ,
              dr_Nezampezaeshki ,
              dr_Description
            )
            SELECT  1111111 ,
					'پیشفرض' ,
                    '' ,
                    '' ,
                    '0' ,
                    '0'

	SET IDENTITY_INSERT TA_Doctor OFF

END

BEGIN -- رتبه 

    SET IDENTITY_INSERT TA_Grade ON

    INSERT  TA_Grade
            ( Grade_ID ,
              Grade_Name ,
              Grade_Description 
            )
            SELECT  1111111 ,
                    'پیشفرض' ,
                    '0'

    SET IDENTITY_INSERT TA_Grade OFF

END

BEGIN -- بخش 

    SET IDENTITY_INSERT ta_department ON

    INSERT  TA_Department
            ( dep_ID ,
              dep_Name ,
              dep_CustomCode ,
              dep_ParentID ,
              dep_ParentPath
            )
            SELECT  111111 ,
                    'سازمان' ,
                    NULL ,
                    NULL ,
                    NULL
       
    INSERT  TA_Department
            ( dep_ID ,
              dep_Name ,
              dep_CustomCode ,
              dep_ParentID ,
              dep_ParentPath
            )
            SELECT  1111111 ,
                    'شرکت غدیر' ,
                    '0' ,
                    111111 ,
                    ',111111,'
        
    SET IDENTITY_INSERT TA_Department OFF

END

BEGIN -- پست سازمانی 

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

BEGIN -- محل ماموریت 

    SET IDENTITY_INSERT TA_DutyPlace ON

    INSERT  TA_DutyPlace
            ( dutyPlc_ID ,
              dutyPlc_Name ,
              dutyPlc_CustomCode ,
              dutyPlc_ParentID
            )
    VALUES  ( 111111 ,
              'محل ماموريت' ,
              NULL ,
              NULL
            )

    SET IDENTITY_INSERT TA_DutyPlace OFF

END

BEGIN -- شیفت 

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
    VALUES  ( 1111111 ,
              'پیشفرض' ,
              0 ,
              NULL ,
              NULL ,
              0 ,
              0 ,
              0 ,
              0 ,
              'rgb(0,250,0)' ,
              '0'
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
    VALUES  ( 1111111 ,
              1111111 ,
              '480' ,
              '960' ,
              0 ,
              0 ,
              1 -- عادی
            )

    SET IDENTITY_INSERT TA_ShiftPair OFF

END

BEGIN -- گروه کاری 

    SET IDENTITY_INSERT TA_WorkGroup ON

    INSERT  TA_WorkGroup
            ( WorkGroup_ID ,
              WorkGroup_Name ,
              WorkGroup_CustomCode ,
              WorkGroup__grpsCode
            )
    VALUES  ( 1111111 ,
              'پیشفرض' ,
              '0' ,
              0
            )

    SET IDENTITY_INSERT TA_WorkGroup OFF

END

BEGIN -- نوع استخدام 

    SET IDENTITY_INSERT TA_EmploymentType ON

    INSERT  TA_EmploymentType
            ( emply_id ,
              emply_name ,
              emply_customcode
            )
    VALUES  ( 1111111 ,
              'پیشفرض' ,
              '0'
            )

    SET IDENTITY_INSERT TA_EmploymentType OFF

END

BEGIN -- ایستگاه کنترل 

    SET IDENTITY_INSERT TA_ControlStation ON

    INSERT  TA_ControlStation
            ( station_id ,
              station_name ,
              station_customcode
            )
    VALUES  ( 1111111 ,
              'پیشفرض' ,
              '0'
            )

    SET IDENTITY_INSERT TA_ControlStation OFF

END

BEGIN -- دسته قانون 

    SET IDENTITY_INSERT TA_RuleCategory ON

    INSERT  TA_RuleCategory
            ( RuleCat_ID ,
              RuleCat_Name ,
              RuleCat_Discription ,
              RuleCat_IsRoot ,
              RuleCat_CustomCode
            )
    VALUES  ( 111111 ,
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
    VALUES  ( 1111111 ,
              'پیشفرض' ,
              NULL ,
              0 ,
              '0'
            )

    SET IDENTITY_INSERT TA_RuleCategory OFF

    SET IDENTITY_INSERT TA_RuleCategoryPart ON

    INSERT  TA_RuleCategoryPart
            ( rulecatpart_id ,
              RuleCatPart_ParentCatId ,
              RuleCatPart_ChildCatId ,
              RuleCatPart_IsContain
            )
    VALUES  ( 1111111 ,
              111111 ,
              1111111 ,
              NULL
            )

    SET IDENTITY_INSERT TA_RuleCategoryPart OFF

END

BEGIN -- پرسنل 

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
		SELECT	1111111 ,
              '1111111' ,
              NULL ,
              1 ,
              '1111111' ,
              1111111 ,
              '1111111' ,
              NULL ,
              NULL ,
              1111111 ,
              0 ,
              NULL ,
              'کارشناس' ,
              1 ,
              'غدیر' ,
              NULL ,
              0 ,
              GETDATE()

    SET IDENTITY_INSERT TA_Person OFF

    --SET IDENTITY_INSERT TA_PersonDetail ON

    INSERT  TA_PersonDetail
            (	PrsDtl_ID ,
				PrsDtl_Image )
            SELECT  1111111 ,
					'1111111' + '.jpg'


    --SET IDENTITY_INSERT TA_PersonDetail OFF

    UPDATE  TA_Person
    SET     Prs_PrsDtlID = 1111111

    --SET IDENTITY_INSERT TA_PersonTASpec ON

    INSERT  TA_PersonTASpec
            ( prsta_id ,
              prsTA_ControlStationId ,
              prsTA_UIValidationGroupID ,
              prsTA_Active
            )
            SELECT  1111111 ,
                    1111111 ,
                    1111111 ,
                    Prs_Active
            FROM    ta_person

    --SET IDENTITY_INSERT TA_PersonTASpec OFF

END

BEGIN -- انتسابات پرسنل 

    SET IDENTITY_INSERT TA_PersonRangeAssignment ON
    
    INSERT  TA_PersonRangeAssignment
            ( PrsRangeAsg_ID ,
              PrsRangeAsg_PersonId ,
              PrsRangeAsg_CalcRangeGrpId ,
              PrsRangeAsg_FromDate
            )
            SELECT  1111111 ,
                    1111111 ,
                    37353 ,
                    '2014-03-21 00:00:00.000'

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
            SELECT  1111111 ,
                    1111111 ,
                    1111111 ,
                    '2014/03/21' ,
                    '2024/03/21' ,
                    NULL
  
    SET IDENTITY_INSERT TA_PersonRuleCategoryAssignment OFF   
	
    SET IDENTITY_INSERT TA_AssignWorkGroup ON              

    INSERT  TA_AssignWorkGroup
            ( AsgWorkGroup_ID ,
              AsgWorkGroup_WorkGroupId ,
              AsgWorkGroup_PersonId ,
              AsgWorkGroup_FromDate
            )
            SELECT  1111111 ,
                    1111111 ,
                    1111111 ,
                    '2014-03-21 00:00:00.000'

    SET IDENTITY_INSERT TA_AssignWorkGroup OFF

END

BEGIN -- کاربر 

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
    VALUES  ( 1111111 ,
              1111111 ,
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
            SELECT  1111111 ,
                    1111111 ,
                    2 ,
                    4

    SET IDENTITY_INSERT TA_UserSettings OFF

END

BEGIN -- گروه قانون 

    DECLARE @catid INT
    DECLARE CursorTemp_0 CURSOR
    FOR
        SELECT  RuleCat_ID
        FROM    TA_RuleCategory
		WHERE	RuleCat_ID !=  111111
    OPEN CursorTemp_0
    FETCH NEXT FROM CursorTemp_0 INTO @catid
    WHILE @@FETCH_STATUS = 0 
        BEGIN  
            PRINT @catid
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
                            RuleTmp_IsForcible
                    FROM    TA_RuleTemplate
                    WHERE   RuleTmp_IdentifierCode IN ( 1016, 1017, 1018,
														2012,
														3013,
														4001, 4003,
														5009, 5012 )
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
            PRINT @ruleid
            PRINT @ruleident
            INSERT  TA_AssignRuleParameter
                    SELECT  '2014-03-21 00:00:00.000' ,
                            '2024-03-21 00:00:00.000' ,
                            @ruleid
            INSERT  TA_RuleParameter
                    SELECT  ( SELECT    AsgRuleParam_ID
                              FROM      TA_AssignRuleParameter
                              WHERE     AsgRuleParam_RuleId = @ruleid
                            ) ,
                            RuleTmpParam_Name ,
                            0 ,
                            RuleTmpParam_Type ,
                            RuleTmpParam_Title ,
                            0
                    FROM    TA_RuleTemplateParameter
                    WHERE   RuleTmpParam_RuleTemplateId = ( SELECT
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

BEGIN -- انتساب مدیر 

    UPDATE  TA_OrganizationUnit
    SET     organ_PersonID = 1111111
    WHERE   organ_ID = 1111111  

END

BEGIN -- جریان کاری 

    SET IDENTITY_INSERT dbo.TA_FlowGroup ON

    INSERT  dbo.TA_FlowGroup
            ( FlowGroup_ID ,
              FlowGroup_Name ,
              FlowGroup_Description
            )
            SELECT  1111111 ,
                    'پیشفرض' ,
                    '0'

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
            SELECT  1111111 ,
                    1 ,
                    1 ,
                    1 ,
                    'غدیر' ,
                    0 ,
                    0 ,
                    1111111

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
            SELECT  1111111 ,
                    1111111 ,
                    NULL ,
                    111111 , -- سازمان
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
            SELECT  1111111 ,
                    NULL ,
                    1111111 ,
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
            SELECT  1111111 ,
                    1111111 ,
                    1 ,
                    1111111 ,
                    1

    SET IDENTITY_INSERT dbo.TA_ManagerFlow OFF
  
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
            SELECT  1111111 ,
                    '2014-03-21 00:00:00.000' ,
                    30 ,
                    0 ,
                    1111111 ,
                    1 ,
                    '0' ,
                    0

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
            SELECT  1111111 ,
                    1111111 ,
                    '2014-03-21 00:00:00.000' ,
                    0 ,
                    0

    SET IDENTITY_INSERT dbo.TA_Calculation_Flag_Persons OFF 

END

BEGIN -- شرکت 

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
            SELECT  1111111 ,
                    '0' ,
                    'پیشفرض' ,
                    NULL ,
                    NULL ,
                    NULL ,
                    '0' ,
                    NULL

    SET IDENTITY_INSERT TA_OrganDefine OFF

END

BEGIN -- سطوح دسترسی 

    INSERT  TA_DataAccessCtrlStation
            SELECT  1111111 ,
                    NULL ,
                    1 
    INSERT  TA_DataAccessDepartment
            SELECT  1111111 ,
                    NULL ,
                    1 
    INSERT  TA_DataAccessDoctor
            SELECT  1111111 ,
                    NULL ,
                    1 
    INSERT  TA_DataAccessFlow
            SELECT  1111111 ,
                    NULL ,
                    1 
    INSERT  TA_DataAccessManager
            SELECT  1111111 ,
                    NULL ,
                    1 
    INSERT  TA_DataAccessOrgan
            SELECT  1111111 ,
                    1111111 
    INSERT  TA_DataAccessOrganizationUnit
            SELECT  1111111 ,
                    NULL ,
                    1 
    INSERT  TA_DataAccessPrecard
            SELECT  1111111 ,
                    NULL ,
                    1 
    INSERT  TA_DataAccessReport
            SELECT  1111111 ,
                    NULL ,
                    1 
    INSERT  TA_DataAccessRuleGroup
            SELECT  1111111 ,
                    NULL ,
                    1 
    INSERT  TA_DataAccessShift
            SELECT  1111111 ,
                    NULL ,
                    1 
    INSERT  TA_DataAccessWorkGroup
            SELECT  1111111 ,
                    NULL ,
                    1 

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