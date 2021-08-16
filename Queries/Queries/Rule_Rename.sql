select * from ta_ruletemplate
select * from ta_rule

-- حذف کدهای قدیمی قوانین

update ta_ruletemplate
set ruletmp_name=
SUBSTRING(ruletmp_name,CHARINDEX(':',ruletmp_name,1)+1,LEN(ruletmp_name)) from ta_ruletemplate
----------------------------
update ta_rule
set rule_name=
SUBSTRING(rule_name,CHARINDEX(':',rule_name,1)+1,LEN(rule_name)) from ta_rule


-- اضافه کردن کد به نام قوانین

update ta_ruletemplate
set ruletmp_name='کد '+cast(RuleTmp_IdentifierCode as nvarchar(10))+' : '+RuleTmp_Name
----------------------------
update ta_rule
set rule_name='کد '+cast(Rule_IdentifierCode as nvarchar(10))+' : '+rule_name


