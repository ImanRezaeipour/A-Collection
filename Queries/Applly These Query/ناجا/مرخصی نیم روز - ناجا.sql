INSERT ta_ruletemplate
(RuleTmp_Name,RuleTmp_Script,RuleTmp_CSharpCode,RuleTmp_CustomCode,RuleTmp_CustomCategoryCode,RuleTmp_Order,RuleTmp_IdentifierCode,RuleTmp_IsPeriodic,RuleTmp_RuleTypeId,RuleTmp_IsForcible,RuleTmp_JsonObject,RuleTmp_UserDefined) 
VALUES('مرخصی ساعتی چنانچه از ... تا ... بود به میزان ... ساعت لحاظ گردد ','موجود نیست','موجود نیست','','2','10506','71','0','556',NULL,NULL,'0')

declare @ruleId numeric
select @ruleId=RuleTmp_ID from ta_ruletemplate where RuleTmp_IdentifierCode=71

insert into TA_RuleTemplateParameter (RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName) 
values('first',@ruleId,'مدت شروع ',1,'',''),
	  ('second',@ruleId,'مدت پایان ',1,'',''),
	  ('third',@ruleId,'میزان مرخصی که لحاظ گردد ',1,'','')