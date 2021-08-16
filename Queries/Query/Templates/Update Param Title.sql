update  ra
set ra.RuleParam_Title =
(
select top(1)RuleTmpParam_Title from TA_RuleParameter as tmp
join TA_AssignRuleParameter on AsgRuleParam_ID=RuleParam_AsgRuleParamId
join TA_Rule on Rule_ID=AsgRuleParam_RuleId
join TA_RuleTemplate  on RuleTmp_IdentifierCode=Rule_IdentifierCode
join TA_RuleTemplateParameter on RuleTmp_ID=RuleTmpParam_RuleTemplateId 
where tmp.RuleParam_ID= ra.RuleParam_ID
)
FROM TA_RuleParameter  ra


