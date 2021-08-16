
CREATE FUNCTION [dbo].[fn_GetManagers](@prsId numeric)
RETURNS @AccessiblePersons table
(
[Manager_ID] [numeric](18, 0)
)
as
BEGIN

	INSERT INTO @AccessiblePersons
	SELECT MasterMng_ID FROM TA_Manager
	WHERE MasterMng_Active=1 and 
	(isnull(MasterMng_PersonID,0)=@prsId OR isnull(MasterMng_OrganizationUnitID,0) in (SELECT organ_ID FROM TA_OrganizationUnit WHERE organ_PersonID=@prsId))
	UNION 
	SELECT sub_ManagerId FROM TA_Substitute WHERE sub_Active=1 and sub_PersonId=@prsId

RETURN
END

GO


