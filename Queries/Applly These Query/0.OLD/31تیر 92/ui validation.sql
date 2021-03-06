select * from TA_UIValidationRule

select * from TA_UIValidationRuleTempPatameter where UIValTmpParam_RuleID=1665
select * from TA_UIValidationRuleParameter where UIRleParam_KeyName='AllowedTrafficRequestAfterTime'

update TA_UIValidationRule
set UIRle_Name=N'درخواست ترددهاي عادي از___ روز قبل تا ___ روز بعد از روز درخواست قابل ثبت باشد'
where UIRle_CustomCode=8

update TA_UIValidationRule
set UIRle_Name=N'درخواستهاي مرخصي استحقاقي ساعتی از___ روز قبل تا ___ روز بعد از روز درخواست قابل ثبت باشد '
where UIRle_CustomCode=9

update TA_UIValidationRule
set UIRle_Name=N'درخواستهاي مرخصي استحقاقي روزانه از___ روز قبل تا ___ روز بعد از روز درخواست قابل ثبت باشد '
where UIRle_CustomCode=10


update TA_UIValidationRuleTempPatameter
set UIValTmpParam_Name=N'تعداد روز بعد از درخواست'
where UIValTmpParam_ID=1471

update TA_UIValidationRuleTempPatameter
set UIValTmpParam_Name=N'تعداد روز قبل از درخواست'
where UIValTmpParam_ID=1510

update TA_UIValidationRuleParameter
set UIRleParam_Name=N'تعداد روز بعد از درخواست'
where UIRleParam_KeyName='AllowedTrafficRequestAfterTime'

update TA_UIValidationRuleParameter
set UIRleParam_Name=N'تعداد روز قبل از درخواست'
where UIRleParam_KeyName='AllowedTrafficRequestBeforeTime'

--کلیه درخواست ها از___ روز قبل تا ___ روز بعد از روز درخواست قابل ثبت باشد
--SET IDENTITY_INSERT dbo.TA_UIValidationRule ON
insert into TA_UIValidationRule(UIRle_ID,UIRle_Name,UIRle_CustomCode,UIRle_Active)
values(1670,N'کلیه درخواست ها از___ روز قبل تا ___ روز بعد از روز درخواست قابل ثبت باشد','24',1)
--SET IDENTITY_INSERT dbo.TA_UIValidationRule off

insert into TA_UIValidationGrouping(UIGrp_Active,UIGrp_GroupID,UIGrp_OperatorRestriction,UIGrp_RuleID)
select 0,UIValGrp_ID,0,1670 from TA_UIValidationGroup

insert into TA_UIValidationRuleTempPatameter(UIValTmpParam_ID,UIValTmpParam_KeyName,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_type)
values(1,'BeforeDayCount','تعداد روز قبل از درخواست',1670,0)


insert into TA_UIValidationRuleTempPatameter(UIValTmpParam_ID,UIValTmpParam_KeyName,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_type)
values(2,'AfterDayCount','تعداد روز بعد از درخواست',1670,0)

select * from TA_UIValidationRuleTempPatameter