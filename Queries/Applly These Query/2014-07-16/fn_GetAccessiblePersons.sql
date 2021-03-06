
/****** Object:  UserDefinedFunction [dbo].[fn_GetAccessiblePersons]    Script Date: 7/16/2014 11:36:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[fn_GetAccessiblePersons](@managerId numeric ,@userId numeric ,@personCategory int)
RETURNS @AccessiblePersons table
(
[prs_ID] [numeric](18, 0)
)
as
BEGIN
--@personCategory 1 : public , 2:UnderManagment(manager), 3:UnderManagment(operator) , 4:manager , 5:Sentry UnderManagment 
IF @personCategory is null OR @personCategory=1 --بر اساس بخش
BEGIN
	IF Exists(select DataAccessDep_ID from TA_DataAccessDepartment where DataAccessDep_All=1 and DataAccessDep_UserID=@userId)
	BEGIN
		INSERT INTO @AccessiblePersons
		SELECT prs_ID from TA_Person where  prs_IsDeleted=0
	END
	ELSE
	BEGIN
		INSERT INTO @AccessiblePersons
		SELECT prs_ID from TA_Person 
		WHERE
		prs_IsDeleted=0 AND
		PRS_DepartmentID IN (select dep_ID from TA_DataAccessDepartment
							RIGHT JOIN TA_Department on dep_ID=DataAccessDep_DepID 
							OR dep_ParentPath like '%,' + CONVERT(varchar(10),DataAccessDep_DepID) + ',%'
							 WHERE DataAccessDep_UserID=@userId)
	END
END	
ELSE IF @personCategory = 2 -- استخراج پرسنل تحت مدیریت مدیر 
BEGIN	
	INSERT INTO @AccessiblePersons
	SELECT Prs_Id
		    FROM (SELECT mngrFlow_FlowID 
					FROM TA_ManagerFlow     
					WHERE mngrFlow_ManagerID = @managerId  AND mngrFlow_Active=1
					) Flow			
			CROSS APPLY [dbo].[TA_GetUnderManagmentPersons] (Flow.mngrFlow_FlowID) as UndermanagmentsPersons
END
ELSE IF @personCategory = 3 -- استخراج پرسنل تحت مدیریت اپراتور
BEGIN	
	INSERT INTO @AccessiblePersons
	SELECT Prs_Id FROM
	(SELECT opr_FlowId
      FROM TA_Operator     
      WHERE opr_PersonId = (select user_personid from ta_securityuser where user_ID =@userId AND user_Active=1)  
			AND opr_Active=1
     ) oprFlow
	INNER JOIN (SELECT UndermanagmentsPersons.Prs_Id, Flow.Flow_ID
		    FROM TA_Flow Flow			
			CROSS APPLY [dbo].[TA_GetUnderManagmentPersons] (Flow.Flow_ID) as UndermanagmentsPersons
		   ) AS UnderMgn
	ON oprFlow.opr_FlowId = UnderMgn.Flow_Id	
END
ELSE IF @personCategory = 4 --استخراج شناسه پرسنلی مدیرات بر اساس شخص یا پست سازمانی
BEGIN	
	IF Exists(select DataAccessManager_ID from TA_DataAccessManager where DataAccessManager_All=1 and DataAccessManager_UserID=@userId)
	BEGIN
		INSERT INTO @AccessiblePersons
		SELECT organ_PersonID as prs_id FROM TA_Manager
		JOIN TA_OrganizationUnit on organ_ID=MasterMng_OrganizationUnitID
		UNION 												
		SELECT MasterMng_PersonID as prs_id FROM TA_Manager
		WHERE MasterMng_PersonID is not null
	END
	ELSE
	BEGIN
		INSERT INTO @AccessiblePersons
		SELECT organ_PersonID as prs_id FROM TA_Manager
		JOIN TA_OrganizationUnit on organ_ID=MasterMng_OrganizationUnitID
		JOIN TA_DataAccessManager ON DataAccessManager_ManagerId=MasterMng_ID AND DataAccessManager_UserID=@userID
		UNION 												
		SELECT MasterMng_PersonID as prs_id FROM TA_Manager
		JOIN TA_DataAccessManager ON DataAccessManager_ManagerId=MasterMng_ID AND DataAccessManager_UserID=@userID
		WHERE MasterMng_PersonID is not null
		
		INSERT INTO @AccessiblePersons
		SELECT user_PersonId FROM TA_SecurityUser WHERE [user_id]=@userID
	END
END	
ELSE IF @personCategory = 5 --بر اساس بخش و ایستگاه کنترل
BEGIN	
	IF Exists(select DataAccessDep_ID from TA_DataAccessDepartment where DataAccessDep_All=1 and DataAccessDep_UserID=@userId)
	BEGIN
		INSERT INTO @AccessiblePersons
		SELECT prs_ID from TA_Person WHERE Prs_IsDeleted=0
	END
	ELSE
	BEGIN
		INSERT INTO @AccessiblePersons
		SELECT prs_ID from TA_Person 
		WHERE
		PRS_IsDeleted=0 AND
		PRS_DepartmentID IN (select dep_ID from TA_DataAccessDepartment
							RIGHT JOIN TA_Department on dep_ID=DataAccessDep_DepID 
							OR dep_ParentPath like '%,' + CONVERT(varchar(10),DataAccessDep_DepID) + ',%'
							 WHERE DataAccessDep_UserID=@userId)
	END
	IF Exists(select DataAccessCtrlStation_CtrlStationID from TA_DataAccessCtrlStation WHERE DataAccessCtrlStation_All=1 AND DataAccessCtrlStation_UserID=@userID)
	BEGIN
		INSERT INTO @AccessiblePersons
		SELECT prsTA_ID from TA_PersonTASpec
		JOIN TA_Person on Prs_ID=prsTA_ID
		WHERE  PRS_IsDeleted=0 AND
			PrsTA_ControlStationId in (SELECT Station_ID from TA_ControlStation)
	END
	ELSE
	BEGIN
		INSERT INTO @AccessiblePersons
		SELECT prsTA_ID from TA_PersonTASpec
		JOIN TA_Person on Prs_ID=prsTA_ID
		AND	PrsTA_ControlStationId in (select DataAccessCtrlStation_CtrlStationID from TA_DataAccessCtrlStation 
										WHERE DataAccessCtrlStation_UserID=@userID)
	END
END	
ELSE IF @personCategory = 7 --استخراج شناسه پرسنلی مدیرات بر  اساس جریان  
BEGIN	
	IF Exists(select DataAccessManager_ID from TA_DataAccessManager where DataAccessManager_All=1 and DataAccessManager_UserID=@userId)
	BEGIN
		INSERT INTO @AccessiblePersons
		select distinct * from (SELECT  organ_PersonID as prs_id FROM TA_Manager
		join TA_ManagerFlow on TA_Manager.MasterMng_ID=TA_ManagerFlow.mngrFlow_ManagerID
		join TA_Flow on TA_ManagerFlow.mngrFlow_FlowID=TA_Flow.Flow_ID
		JOIN TA_OrganizationUnit on organ_ID=MasterMng_OrganizationUnitID
		UNION 												
		SELECT   MasterMng_PersonID as prs_id FROM TA_Manager
		join TA_ManagerFlow on TA_Manager.MasterMng_ID=TA_ManagerFlow.mngrFlow_ManagerID
		join TA_Flow on TA_ManagerFlow.mngrFlow_FlowID=TA_Flow.Flow_ID
		WHERE MasterMng_PersonID is not null) manager
	END
	ELSE
	BEGIN
		INSERT INTO @AccessiblePersons
		select distinct * from ( SELECT organ_PersonID as prs_id FROM TA_Manager
		join TA_ManagerFlow on TA_Manager.MasterMng_ID=TA_ManagerFlow.mngrFlow_ManagerID
		join TA_Flow on TA_ManagerFlow.mngrFlow_FlowID=TA_Flow.Flow_ID
		JOIN TA_OrganizationUnit on organ_ID=MasterMng_OrganizationUnitID
		JOIN TA_DataAccessFlow ON TA_DataAccessFlow.DataAccessFlow_FlowID=  TA_ManagerFlow.mngrFlow_FlowID AND TA_DataAccessFlow.DataAccessFlow_UserID =@userID
		UNION 												
		SELECT MasterMng_PersonID as prs_id FROM TA_Manager
		join TA_ManagerFlow on TA_Manager.MasterMng_ID=TA_ManagerFlow.mngrFlow_ManagerID
		join TA_Flow on TA_ManagerFlow.mngrFlow_FlowID=TA_Flow.Flow_ID
		JOIN TA_DataAccessFlow ON TA_DataAccessFlow.DataAccessFlow_FlowID=  TA_ManagerFlow.mngrFlow_FlowID AND TA_DataAccessFlow.DataAccessFlow_UserID =@userID
		WHERE MasterMng_PersonID is not null
		) manager
		INSERT INTO @AccessiblePersons
		SELECT user_PersonId FROM TA_SecurityUser WHERE [user_id]=@userID
	END
END	
RETURN
END