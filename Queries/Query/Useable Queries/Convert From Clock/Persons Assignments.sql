/*
INSERT INTO TA_PersonRangeAssignment
(PrsRangeAsg_PersonId,PrsRangeAsg_CalcRangeGrpId,PrsRangeAsg_FromDate)
SELECT prs_ID,26017,'2012-03-21' FROM TA_Person tp
*/
/*
INSERT INTO TA_AssignWorkGroup
(
	-- AsgWorkGroup_ID -- this column value is auto-generated,
	AsgWorkGroup_WorkGroupId,
	AsgWorkGroup_PersonId,
	AsgWorkGroup_FromDate
)
SELECT 
	/* AsgWorkGroup_WorkGroupId	*/1047,
	/* AsgWorkGroup_PersonId	*/prs_ID,
	/* AsgWorkGroup_FromDate	*/'2012-03-21'
FROM TA_Person tp
*/
/*
INSERT INTO TA_PersonRuleCategoryAssignment
(
	-- PrsRulCatAsg_ID -- this column value is auto-generated,
	PrsRulCatAsg_PersonId,
	PrsRulCatAsg_RuleCategoryId,
	PrsRulCatAsg_FromDate,
	PrsRulCatAsg_ToDate,
	PrsRulCatAsg_IssuanceDate
)
SELECT  

	/* PrsRulCatAsg_PersonId	*/prs_ID,
	/* PrsRulCatAsg_RuleCategoryId	*/210,
	/* PrsRulCatAsg_FromDate	*/'2012/03/21',
	/* PrsRulCatAsg_ToDate	*/'2022/03/21',
	/* PrsRulCatAsg_IssuanceDate	*/null
FROM TA_Person tp
*/