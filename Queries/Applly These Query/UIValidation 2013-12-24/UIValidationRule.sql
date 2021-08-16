
--Alter table ta_uivalidationrule add uirle_Order int 

set identity_insert TA_UIValidationRule on
INSERT TA_UIValidationRule(UIRle_ID,UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,UIRle_Order) VALUES('1','تعداد درخواستهاي مرخصي باحقوق روزانه در سال حداکثر ___ عدد باشد','27','1','1',0)
INSERT TA_UIValidationRule(UIRle_ID,UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,UIRle_Order) VALUES('2','سقف مقدار مرخصی باحقوق روزانه در نوبت حداکثر ___ روز باشد','28','1','1',0)
INSERT TA_UIValidationRule(UIRle_ID,UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,UIRle_Order) VALUES('3',' سقف اضافه کار دستوری در ماه ___ ساعت میباشد و تنها توسط مدیران قابل ثبت باشد','29','1','1',0)
INSERT TA_UIValidationRule(UIRle_ID,UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,uirle_Order) VALUES('4','مشخص نمودن محل ماموریت اجباری است','30','1','1','55')
INSERT TA_UIValidationRule(UIRle_ID,UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,uirle_Order) VALUES('5','مشخص نمودن نام پزشک اجباری است','31','1','1','56')
INSERT TA_UIValidationRule(UIRle_ID,UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,uirle_Order) VALUES('6','مشخص نمودن نام بیماری اجباری است','32','1','1','57')
INSERT TA_UIValidationRule(UIRle_ID,UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,uirle_Order) VALUES('7','ثبت مرخصی استحقاقی در صورت داشتن مانده مرخصی مجاز است','33','1','1','58')


set identity_insert TA_UIValidationRule off
INSERT TA_UIValidationRuleTempPatameter(UIValTmpParam_ID,UIValTmpParam_type,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_KeyName) VALUES('3','0','تعداد روز درخواست','1','MaxCount')
INSERT TA_UIValidationRuleTempPatameter(UIValTmpParam_ID,UIValTmpParam_type,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_KeyName) VALUES('4','0','سقف مقدار روز درخواست','2','DayCount')
INSERT TA_UIValidationRuleTempPatameter(UIValTmpParam_ID,UIValTmpParam_type,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_KeyName) VALUES('5','1','تعداد روز درخواست','3','MaxDasturyOverwork')


INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('27','43')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('28','43')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('29','121')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('30','61')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('30','62')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('30','63')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('30','64')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('30','65')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('31','22')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('31','42')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('32','22')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('32','42')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('33','21')
INSERT TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode) VALUES('33','41')

delete from TA_UIValidationRule where (UIRle_ID=1689 and UIRle_CustomCode=23) OR (UIRle_ID=1690 and UIRle_CustomCode=24)

update TA_UIValidationRule set UIRle_Order=1 where UIRle_SubSystemID=1 and UIRle_CustomCode=4
update TA_UIValidationRule set UIRle_Order=2 where UIRle_SubSystemID=1 and UIRle_CustomCode=5
update TA_UIValidationRule set UIRle_Order=3 where UIRle_SubSystemID=1 and UIRle_CustomCode=6

update TA_UIValidationRule set UIRle_Order=10 where UIRle_SubSystemID=1 and UIRle_CustomCode=24
update TA_UIValidationRule set UIRle_Order=11 where UIRle_SubSystemID=1 and UIRle_CustomCode=8
update TA_UIValidationRule set UIRle_Order=12 where UIRle_SubSystemID=1 and UIRle_CustomCode=9
update TA_UIValidationRule set UIRle_Order=13 where UIRle_SubSystemID=1 and UIRle_CustomCode=10
update TA_UIValidationRule set UIRle_Order=14 where UIRle_SubSystemID=1 and UIRle_CustomCode=11
update TA_UIValidationRule set UIRle_Order=15 where UIRle_SubSystemID=1 and UIRle_CustomCode=12
update TA_UIValidationRule set UIRle_Order=16 where UIRle_SubSystemID=1 and UIRle_CustomCode=13
update TA_UIValidationRule set UIRle_Order=17 where UIRle_SubSystemID=1 and UIRle_CustomCode=14
update TA_UIValidationRule set UIRle_Order=18 where UIRle_SubSystemID=1 and UIRle_CustomCode=15

update TA_UIValidationRule set UIRle_Order=30 where UIRle_SubSystemID=1 and UIRle_CustomCode=16
update TA_UIValidationRule set UIRle_Order=31 where UIRle_SubSystemID=1 and UIRle_CustomCode=17
update TA_UIValidationRule set UIRle_Order=32 where UIRle_SubSystemID=1 and UIRle_CustomCode=18
update TA_UIValidationRule set UIRle_Order=33 where UIRle_SubSystemID=1 and UIRle_CustomCode=19
update TA_UIValidationRule set UIRle_Order=34 where UIRle_SubSystemID=1 and UIRle_CustomCode=20
update TA_UIValidationRule set UIRle_Order=35 where UIRle_SubSystemID=1 and UIRle_CustomCode=21
update TA_UIValidationRule set UIRle_Order=36 where UIRle_SubSystemID=1 and UIRle_CustomCode=22
update TA_UIValidationRule set UIRle_Order=37 where UIRle_SubSystemID=1 and UIRle_CustomCode=23
update TA_UIValidationRule set UIRle_Order=38 where UIRle_SubSystemID=1 and UIRle_CustomCode=27
update TA_UIValidationRule set UIRle_Order=39 where UIRle_SubSystemID=1 and UIRle_CustomCode=7

update TA_UIValidationRule set UIRle_Order=51 where UIRle_SubSystemID=1 and UIRle_CustomCode=26
update TA_UIValidationRule set UIRle_Order=52 where UIRle_SubSystemID=1 and UIRle_CustomCode=25
update TA_UIValidationRule set UIRle_Order=53 where UIRle_SubSystemID=1 and UIRle_CustomCode=28
update TA_UIValidationRule set UIRle_Order=54 where UIRle_SubSystemID=1 and UIRle_CustomCode=29