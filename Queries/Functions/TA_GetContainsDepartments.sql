
CREATE function [dbo].[TA_GetContainsDepartments] (@prsId numeric)
RETURNS @department table
(
[dep_ID] [numeric](18, 0)
)
AS
BEGIN
INSERT INTO @department
SELECT dep.dep_ID FROM TA_UnderManagment 
join TA_Department dep on dep_ParentPath like('%,'+CONVERT(varchar(250),underMng_DepartmentID) +',%')
WHERE underMng_FlowID in (SELECT mngrFlow_FlowID 
						  FROM TA_ManagerFlow 
						  WHERE mngrFlow_Active=1 
								AND mngrFlow_ManagerID in (SELECT * FROM [dbo].[fn_GetManagers](@prsId))) 
	AND underMng_Contains=1 AND underMng_PersonID is null
	AND underMng_ContainInnerChilds =1
	AND dep_ID not in (
			SELECT underMng_DepartmentID FROM TA_UnderManagment 
			WHERE underMng_FlowID in (SELECT mngrFlow_FlowID FROM TA_ManagerFlow 
									  WHERE mngrFlow_Active=1 
											AND mngrFlow_ManagerID in (SELECT * FROM [dbo].[fn_GetManagers](@prsId))) 
				  AND underMng_Contains=0 AND underMng_PersonID is null)
				  AND dep_ID not in (
								SELECT dep_ID FROM TA_UnderManagment 
								join TA_Department dep on dep_ParentPath like('%,'+CONVERT(varchar(250),underMng_DepartmentID) +',%')
								WHERE underMng_FlowID in (SELECT mngrFlow_FlowID 
														  FROM TA_ManagerFlow 
														  WHERE mngrFlow_Active=1 
																AND mngrFlow_ManagerID in (SELECT * FROM [dbo].[fn_GetManagers](@prsId))) 
									  AND underMng_Contains=0 AND underMng_PersonID is null
									  AND underMng_ContainInnerChilds =1)

UNION

SELECT dep_ID FROM TA_Department 
WHERE dep_ID in 
		(
			SELECT underMng_DepartmentID FROM TA_UnderManagment 
			WHERE underMng_FlowID in (SELECT mngrFlow_FlowID FROM TA_ManagerFlow 
									  WHERE mngrFlow_Active=1 AND 
									  mngrFlow_ManagerID in (SELECT * FROM [dbo].[fn_GetManagers](@prsId)))  
				  AND ((underMng_PersonID is not null) OR (underMng_PersonID is null AND underMng_Contains=1))
		)
RETURN
END

GO


