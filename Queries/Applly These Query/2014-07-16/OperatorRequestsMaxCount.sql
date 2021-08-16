if(not exists(select * from TA_UIValidationRule where UIRle_CustomCode=37))
begin
	INSERT TA_UIValidationRule(UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,uirle_Order) 
	VALUES(N'تعداد درخواستهاي پرسنل توسط اپراتور در ماه حداكثر ___ عدد باشد','37','1','1','53')

	insert into TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode)
	values(37,0)

	INSERT TA_UIValidationRuleTempPatameter(UIValTmpParam_type,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_KeyName)
	select top(1) 0,N'تعداد درخواست مجاز پرسنل بوسیله اپراتور',UIRle_ID,'OperatorRequestMaxCount'
	from TA_UIValidationRule where UIRle_CustomCode=37
	
	insert into TA_UIValidationGrouping(UIGrp_GroupID,UIGrp_RuleID,UIGrp_OperatorRestriction,UIGrp_Active)
	select UIValGrp_ID,(select top(1) UIRle_ID	from TA_UIValidationRule where UIRle_CustomCode=37 ) as rle,0,1 from TA_UIValidationGroup

	insert into TA_UIValidationRuleParameter(UIRleParam_GroupingID,UIRleParam_Value,UIRleParam_Type,UIRleParam_Name,UIRleParam_KeyName,UIRleParam_ContinueInNextDay)
	select UIGrp_ID,0,0,N'تعداد درخواست مجاز پرسنل بوسیله اپراتور','OperatorRequestMaxCount',0 from TA_UIValidationGrouping
	where UIGrp_RuleID in (select top(1) UIRle_ID	from TA_UIValidationRule where UIRle_CustomCode=37 )
end
