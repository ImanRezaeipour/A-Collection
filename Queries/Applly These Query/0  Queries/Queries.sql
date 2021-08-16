ALTER DATABASE [vok_gts2] SET ALLOW_SNAPSHOT_ISOLATION ON

update TA_RuleTemplate set RuleTmp_CSharpCode='',RuleTmp_Script=''
update TA_Rule set Rule_Script=''

if not exists(select * from sys.columns 
            where Name = N'ScndCnpValue_CalcDateRangeId' and Object_ID = Object_ID(N'TA_SecondaryConceptValue'))
begin

alter table TA_SecondaryConceptValue
add  ScndCnpValue_CalcDateRangeId numeric

end

if not exists(select * from sys.columns 
            where Name = N'userSet_SubSystemId' and Object_ID = Object_ID(N'ta_usersettings'))
begin
	alter table ta_usersettings
	add  userSet_SubSystemId int not null default(1)
end

if not exists(select * from sys.columns 
            where Name = N'BasicTraffic_Transferred' and Object_ID = Object_ID(N'ta_basetraffic'))
begin
	alter table ta_basetraffic
	add  BasicTraffic_Transferred bit 
end

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=3003))
begin
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible])
	VALUES ( N'حضور در مرخصی روزانه , اضافه کار شود', N'موجود نیست', N'موجود نیست', N'موجود نیست', N'2', 10505, 3003, 0, CAST(556 AS Numeric(18, 0)), NULL)
end

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=6003))
begin
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible])
	VALUES ( N'اضافه کار در تعطیلات غیر مجاز است', N'موجود نیست', N'موجود نیست', N'موجود نیست', N'5', 1167, 6003, 0, CAST(552 AS Numeric(18, 0)), NULL)

	
	insert into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	select 'first',[RuleTmp_ID] ,'تعطیلات رسمی ',0,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=6003

	insert into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	select 'second',[RuleTmp_ID] ,'تعطیلات غیر رسمی ',0,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=6003
end


update TA_RuleTemplate set ruletmp_order=402 where RuleTmp_IdentifierCode =5021
update TA_RuleTemplate set ruletmp_order=401 where RuleTmp_IdentifierCode =5022
update TA_RuleTemplate set ruletmp_order=403 where RuleTmp_IdentifierCode =5023
update TA_Rule set rule_order=402 where Rule_IdentifierCode =5021
update TA_Rule set rule_order=401 where Rule_IdentifierCode =5022
update TA_Rule set rule_order=403 where Rule_IdentifierCode =5023

--انتقال مانده مرخصی
if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=3009))
begin
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible])
	VALUES ( N'میزان انتقال مانده مرخصی', N'', N'', N'', N'2', 0, 3009, 0, CAST(556 AS Numeric(18, 0)), NULL)

	
	insert into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	select 'first',[RuleTmp_ID] ,'سقف تعداد روز انتقال مانده مرخصی  ',0,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=3009

	
end
--ایاب و ذهاب
if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=5019))
begin
		
	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'ایاب ذهاب ماهانه', N'', N'', 5019, 1, 0, 0, 1, N'', N'', 0, N'', 0)

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=5019 and c2.ConceptTmp_IdentifierCode=5001
end

---shiftPairType
if(not exists(select * from TA_SHIFTPAIRTYPE where shiftPairType_CustomCode='0'))
begin
	INSERT TA_SHIFTPAIRTYPE(shiftPairType_Title,shiftPairType_Active,shiftPairType_CustomCode,shiftPairType_Description) VALUES('عادی','1','0','')
end
if(not exists(select * from TA_SHIFTPAIRTYPE where shiftPairType_CustomCode='1'))
begin
	INSERT TA_SHIFTPAIRTYPE(shiftPairType_Title,shiftPairType_Active,shiftPairType_CustomCode,shiftPairType_Description) VALUES('اضافه کار اجباری','1','1','')
end
if(not exists(select * from TA_SHIFTPAIRTYPE where shiftPairType_CustomCode='EndOfDay'))
begin
	INSERT TA_SHIFTPAIRTYPE(shiftPairType_Title,shiftPairType_Active,shiftPairType_CustomCode,shiftPairType_Description) VALUES('پایان شبانه روز','1','EndOfDay','')
end

--TA_PersonParamFields
if(not exists(select * from TA_PersonParamFields where paramField_Key='kasre_mahd'))
begin
	INSERT TA_PersonParamFields(paramField_Key,paramField_fnTitle,paramField_enTitle,paramField_Active,paramField_SubSystemId) VALUES('kasre_mahd','کسر مهد - دقیقه','','1','1')
end
if(not exists(select * from TA_PersonParamFields where paramField_Key='kasre_shirdehi'))
begin
	INSERT TA_PersonParamFields(paramField_Key,paramField_fnTitle,paramField_enTitle,paramField_Active,paramField_SubSystemId) VALUES('kasre_shirdehi','کسر شيردهي - دقيقه','','1','1')
end
if(not exists(select * from TA_PersonParamFields where paramField_Key='kasre_taghlil'))
begin
	INSERT TA_PersonParamFields(paramField_Key,paramField_fnTitle,paramField_enTitle,paramField_Active,paramField_SubSystemId) VALUES('kasre_taghlil','کسر تقلیل - دقیقه','','1','1')
end
if(not exists(select * from TA_PersonParamFields where paramField_Key='kasre_takhir'))
begin
	INSERT TA_PersonParamFields(paramField_Key,paramField_fnTitle,paramField_enTitle,paramField_Active,paramField_SubSystemId) VALUES('kasre_takhir','تاخیر مجاز - دقیقه','','1','1')
end
if(not exists(select * from TA_PersonParamFields where paramField_Key='kasre_tajil'))
begin
	INSERT TA_PersonParamFields(paramField_Key,paramField_fnTitle,paramField_enTitle,paramField_Active,paramField_SubSystemId) VALUES('kasre_tajil','تعجیل مجاز - دقیقه','','1','1')
end

if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=4030))
begin
	
	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_CustomCode], [ConceptTmp_CustomCategoryCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_PColumn], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_EngName], [ConceptTmp_FnName], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'اضافه کارساعتی غیر تعطیل', N'', N'', 4030, NULL, NULL, 1, 1, NULL, 0, 1, NULL, NULL, N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_CustomCode], [ConceptTmp_CustomCategoryCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_PColumn], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_EngName], [ConceptTmp_FnName], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'مفهوم اضافه کارساعتی غیر تعطیل ماهانه', N'', N'', 4031, NULL, NULL, 1, 1, NULL, 0, 1, NULL, NULL, N'', N'', 0, N'', 0)

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=4031 and c2.ConceptTmp_IdentifierCode=4030
end
--شیردهی
if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=3040))
begin
	
	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'غیبت مجاز شیردهی', N'', N'', 3040, 0, 0, 0, 1, N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'ماهانه غیبت مجاز شیردهی', N'', N'', 3041, 1, 0, 0, 1, N'', N'', 0, N'', 0)

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=3041 and c2.ConceptTmp_IdentifierCode=3040
end

--مهد
if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=3042))
begin
	
	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'غیبت مجاز مهد', N'', N'', 3042, 0, 1, 0, 1, N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'ماهانه غیبت مجاز مهد', N'', N'', 3043, 1, 1, 0, 1, N'', N'', 0, N'', 0)

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=3043 and c2.ConceptTmp_IdentifierCode=3042
end

--تقلیل
if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=3044))
begin
	
	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'تقلیل رفاه', N'', N'', 3044, 0, 1, 0, 1, N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'ماهانه تقلیل رفاه', N'', N'', 3045, 1, 1, 0, 1, N'', N'', 0, N'', 0)

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=3045 and c2.ConceptTmp_IdentifierCode=3044
end

--خالص شب 
if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=15))
begin
	
	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'کارکرد خالص شب', N'', N'', 15, 0, 1, 0, 1, N'', N'', 0, N'', 0)	
end


--خالص شب ماهانه
if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=26))
begin
	
	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'کارکرد خالص شب ماهانه', N'', N'', 26, 1, 1, 0, 1, N'', N'', 0, N'', 0)

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=26 and c2.ConceptTmp_IdentifierCode=15
end

--قانون تاخیر و تعجیل مجاز
if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=5020))
begin
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible])
	VALUES ( N'اعمال تاخیر و تعجیل مجاز شخصی', N'موجود نیست', N'موجود نیست', N'موجود نیست', N'3',2078,5020,0,CAST(564 AS Numeric(18, 0)),null)
end

--قانون شیردهی
if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=5021))
begin
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible])
	VALUES ( N'اعمال شیردهی برای برخی از پرسنل سازمان', N'موجود نیست', N'موجود نیست', N'موجود نیست', N'3', 402, 5021, 0, CAST(555 AS Numeric(18, 0)), NULL)
end

--قانون مهد
if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=5022))
begin
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible])
	VALUES ( N'اعمال کسر مهد برای برخی از پرسنل', N'موجود نیست', N'موجود نیست', N'موجود نیست', N'3', 401, 5022, 0, CAST(555 AS Numeric(18, 0)), NULL)
end

--قانون تقلیل
if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=5023))
begin
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible]) 
	VALUES ( N'اعمال کسر تقلیل برای برخی از پرسنل', N'موجود نیست', N'موجود نیست', N'موجود نیست', N'3', 403, 5023, 0, CAST(555 AS Numeric(18, 0)), NULL)

	insert into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	select 'first',[RuleTmp_ID] ,'اعمال روی غیبت ',0,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=5023
	
	insert into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	select 'second',[RuleTmp_ID] ,'اعمال روی اضافه کار ',0,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=5023
end


if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=3014))
begin
	INSERT ta_ruletemplate
	(RuleTmp_Name,RuleTmp_Script,RuleTmp_CSharpCode,RuleTmp_CustomCode,RuleTmp_CustomCategoryCode,RuleTmp_Order,RuleTmp_IdentifierCode,RuleTmp_IsPeriodic,RuleTmp_RuleTypeId,RuleTmp_IsForcible,RuleTmp_JsonObject,RuleTmp_UserDefined) 
	VALUES('مانده مرخصی استحقاقی میتواند منفی شود ','موجود نیست','موجود نیست','','2','0','3014','0','556',NULL,NULL,'0')
end 

if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=1098))
begin
	INSERT ta_concepttemplate(ConceptTmp_Name,ConceptTmp_Script,ConceptTmp_CSharpCode,ConceptTmp_IdentifierCode,ConceptTmp_CustomCode,ConceptTmp_CustomCategoryCode,ConceptTmp_IsPeriodic,ConceptTmp_Type,ConceptTmp_PColumn,ConceptTmp_CalcSituationType,ConceptTmp_PersistSituationType,ConceptTmp_EngName,ConceptTmp_FnName,ConceptTmp_KeyColumnName,ConceptTmp_Color,ConceptTmp_UserDefined,ConceptTmp_JsonObject,concepttmp_datatype,ConceptTmp_ShowInReport,ConceptTmp_IsHourly) 
	VALUES('مانده مرخصی میتواند منفی شود','','','1098',NULL,'2','0','1',NULL,'0','2','','','','',NULL,NULL,'0','0','0')
end

--R64
update TA_RuleTemplateParameter set RuleTmpParam_Name='1th',RuleTmpParam_Type=1 where RuleTmpParam_ID=195
update TA_RuleTemplateParameter set RuleTmpParam_Name='2th' where RuleTmpParam_ID=196
update TA_RuleTemplateParameter set RuleTmpParam_Name='3th',RuleTmpParam_Type=1 where RuleTmpParam_ID=197
update TA_RuleTemplateParameter set RuleTmpParam_Name='4th',RuleTmpParam_Type=1 where RuleTmpParam_ID=198
update TA_RuleTemplateParameter set RuleTmpParam_Name='5th' ,RuleTmpParam_Title='ضريب سطح دوم غيبت' where RuleTmpParam_ID=199

if(not exists(select *  from TA_RuleTemplateParameter where RuleTmpParam_RuleTemplateId=190 and RuleTmpParam_Name='6th'))
begin
insert into TA_RuleTemplateParameter (RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName) values('6th',190,'شروع سطح سوم غيبت ',1,'','')
insert into TA_RuleTemplateParameter (RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName) values('7th',190,'پایان سطح سوم غيبت ',1,'','')
insert into TA_RuleTemplateParameter (RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName) values('8th',190,'ضريب سطح سوم غيبت ',0,'','')
end



if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=6020))
begin
	INSERT [dbo].[TA_RuleTemplate]
	   ([RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined])
	VALUES ( N'اعمال سقف اضافه کار بصورت مجزا برای هر شخص', N'', N'', N'', N'3', 14230, 6020, 1, CAST(552 AS Numeric(18, 0)), NULL, NULL, 0)

end 

/*
UPDATE [TA_PersonReserveField] SET[ReserveField_Lable] = N'فیلد رزرو 1' WHERE [ReserveField_OrginalName] = N'R1'
GO
UPDATE [TA_PersonReserveField] SET[ReserveField_Lable] = N'فیلد رزرو 2' WHERE [ReserveField_OrginalName] = N'R2'
GO
UPDATE [TA_PersonReserveField] SET[ReserveField_Lable] = N'فیلد رزرو 3' WHERE [ReserveField_OrginalName] = N'R3'
GO
UPDATE [TA_PersonReserveField] SET[ReserveField_Lable] = N'فیلد رزرو 4' WHERE [ReserveField_OrginalName] = N'R4'
GO
UPDATE [TA_PersonReserveField] SET[ReserveField_Lable] = N'فیلد رزرو 5' WHERE [ReserveField_OrginalName] = N'R5'
GO
UPDATE [TA_PersonReserveField] SET[ReserveField_Lable] = N'فیلد رزرو 6' WHERE [ReserveField_OrginalName] = N'R6'
GO
UPDATE [TA_PersonReserveField] SET[ReserveField_Lable] = N'فیلد رزرو 7' WHERE [ReserveField_OrginalName] = N'R7'
GO
UPDATE [TA_PersonReserveField] SET[ReserveField_Lable] = N'فیلد رزرو 8' WHERE [ReserveField_OrginalName] = N'R8'
GO
UPDATE [TA_PersonReserveField] SET[ReserveField_Lable] = N'فیلد رزرو 9' WHERE [ReserveField_OrginalName] = N'R9'
GO
*/

  UPDATE [TA_RuleTemplateParameter] SET [RuleTmpParam_Name] = N'First' WHERE RuleTmpParam_RuleTemplateId in (select RuleTmp_ID  from TA_RuleTemplate where RuleTmp_IdentifierCode=6004) 

if(exists(select *  from TA_RuleTemplate where RuleTmp_IdentifierCode=5014))
begin
	if(not exists(select *  from TA_RuleTemplateParameter where RuleTmpParam_Name='first'
					and RuleTmpParam_RuleTemplateId in (select ruletmp_id  from TA_RuleTemplate where RuleTmp_IdentifierCode=5014)
	))
	begin
			insert into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
			select 'first',[RuleTmp_ID] ,'ضریب تعداد روز  ',0,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=5014
	end
end

--- R173 Order
 UPDATE [dbo].[TA_Rule] SET [Rule_Order] = 10507 	WHERE [Rule_IdentifierCode] = 6023
 UPDATE [dbo].[TA_RuleTemplate] SET [RuleTmp_Order] = 10507  WHERE [RuleTmp_IdentifierCode] = 6023

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=6031))
begin
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible])
	VALUES ( N'اضافه کار اجباری اعمال شود است', N'موجود نیست', N'موجود نیست', N'موجود نیست', N'1', 25001, 6031, 0, 552, null)
end


if(exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=3002))
begin
-- ==================== Update R70 Title (Rule)
   Update [dbo].[TA_RuleTemplate]
   Set [RuleTmp_Name] = N'حداکثر مرخصی ساعتی در روز ... میباشد و جریمه اعمال شود'
   Where RuleTmp_IdentifierCode = 3002
-- ==================== /Update R70 Title (Rule)

-- ==================== Delete Old R70 parameters (RuleTemplateParameter)
  DELETE FROM [TA_RuleTemplateParameter]
  WHERE  RuleTmpParam_RuleTemplateId in (select ruletmp_id  from TA_RuleTemplate where RuleTmp_IdentifierCode=3002)
-- ==================== /Delete Old R70 parameters (RuleTemplateParameter)

-- ==================== Insert New R70 parameters (RuleTemplateParameter)
INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
     select [RuleTmp_ID],N'First',N'',N'',1,N'حداكثر مرخصی ساعتی در روز'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=3002

INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
     select [RuleTmp_ID],N'Second',N'',N'',0,N'تبدیل به مرخصی0|غیبت1'		from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=3002

INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
     select [RuleTmp_ID],N'Third',N'',N'',0,N'تبدیل حضور به اضافه کار خیر0|بله1 '	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=3002

-- ==================== Delete R71 parameters (RuleTemplateParameter)

  DELETE FROM [TA_RuleTemplateParameter]
  WHERE RuleTmpParam_RuleTemplateId in (select ruletmp_id  from TA_RuleTemplate where RuleTmp_IdentifierCode=3003)

  DELETE FROM [TA_RuleTemplate]
  WHERE RuleTmp_IdentifierCode = 3003
END

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=3015))
begin
	
	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_CustomCode], [ConceptTmp_CustomCategoryCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_PColumn], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_EngName], [ConceptTmp_FnName], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'اعمال مرخصی در زمان حضور', N'', N'', 1099, NULL, N'2', 0, 1, NULL, 0, 2, NULL, NULL, N'', N'rgb(0, 255, 255)', 0, N'', 0)
	
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined])
	VALUES ( N'اعمال مرخصی در زمان حضور', N'', N'', NULL, N'2', 0, 3015, NULL, CAST(556 AS Numeric(18, 0)), 0, N'', 1)
end

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=4007))
begin
		
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined])
	VALUES ( N'به ازای هر روز ماموریت روزانه ..... اضافه کار لحاظ گردد', N'', N'', NULL, N'3', 100, 4007, NULL, CAST(553 AS Numeric(18, 0)), 0, N'', 1)

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
     select [RuleTmp_ID],N'First',N'',N'',0,N'میزان ضافه کار به ازای ماموریت روزانه'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=4007
end

if(not exists(select * from TA_UIValidationRule where UIRle_CustomCode=26))
begin
	INSERT TA_UIValidationRule(UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,uirle_Order) 
	VALUES('سقف تعداد درخواست اول وقت در ماه ___ عدد می باشد','26','1','1','51')

	insert into TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode)
	values(26,21)

	INSERT TA_UIValidationRuleTempPatameter(UIValTmpParam_type,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_KeyName)
	select top(1) 0,'تعداد درخواست اول وقت در ماه',UIRle_ID,'MaxCount'
	from TA_UIValidationRule where UIRle_CustomCode=26
	
	INSERT TA_UIValidationRuleTempPatameter(UIValTmpParam_type,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_KeyName)
	select top(1) 0,'روز شروع ماه',UIRle_ID,'startDay'
	from TA_UIValidationRule where UIRle_CustomCode=26
	
	INSERT TA_UIValidationRuleTempPatameter(UIValTmpParam_type,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_KeyName)
	select top(1) 0,'روز پایان ماه',UIRle_ID,'endDay'
	from TA_UIValidationRule where UIRle_CustomCode=26

	insert into TA_UIValidationGrouping(UIGrp_GroupID,UIGrp_RuleID,UIGrp_OperatorRestriction,UIGrp_Active)
	select UIValGrp_ID,(select top(1) UIRle_ID	from TA_UIValidationRule where UIRle_CustomCode=26 ) as rle,0,1 from TA_UIValidationGroup

	insert into TA_UIValidationRuleParameter(UIRleParam_GroupingID,UIRleParam_Value,UIRleParam_Type,UIRleParam_Name,UIRleParam_KeyName,UIRleParam_ContinueInNextDay)
	select UIGrp_ID,0,0,'تعداد درخواست اول وقت در ماه','MaxCount',0 from TA_UIValidationGrouping
	where UIGrp_RuleID in (select top(1) UIRle_ID	from TA_UIValidationRule where UIRle_CustomCode=26 )

	insert into TA_UIValidationRuleParameter(UIRleParam_GroupingID,UIRleParam_Value,UIRleParam_Type,UIRleParam_Name,UIRleParam_KeyName,UIRleParam_ContinueInNextDay)
	select UIGrp_ID,0,0,'روز شروع ماه','startDay',0 from TA_UIValidationGrouping
	where UIGrp_RuleID in (select top(1) UIRle_ID	from TA_UIValidationRule where UIRle_CustomCode=26 )

	insert into TA_UIValidationRuleParameter(UIRleParam_GroupingID,UIRleParam_Value,UIRleParam_Type,UIRleParam_Name,UIRleParam_KeyName,UIRleParam_ContinueInNextDay)
	select UIGrp_ID,0,0,'روز پایان ماه','endDay',0 from TA_UIValidationGrouping
	where UIGrp_RuleID in (select top(1) UIRle_ID	from TA_UIValidationRule where UIRle_CustomCode=26 )

end

if(not exists(select * from TA_UIValidationRule where UIRle_CustomCode=34))
begin
	INSERT TA_UIValidationRule(UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,uirle_Order) VALUES('توضیح درخواست اجباری است','34','1','1','1')

	insert into TA_UIValidationRulePrecard
	values(34,51)
end

if(not exists(select * from TA_UIValidationRule where UIRle_CustomCode=35))
begin
	INSERT TA_UIValidationRule(UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,uirle_Order)
	VALUES('حداکثر تعداد درخواست در روز','35','1','1','1')

	insert into TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode)
	values(35,21)

	INSERT TA_UIValidationRuleTempPatameter(UIValTmpParam_type,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_KeyName)
	select top(1) 0,'حداکثر تعداد',UIRle_ID,'MaxCount'
	from TA_UIValidationRule where UIRle_CustomCode=35

	insert into TA_UIValidationGrouping(UIGrp_GroupID,UIGrp_RuleID,UIGrp_OperatorRestriction,UIGrp_Active)
	select UIValGrp_ID,(select top(1) UIRle_ID	from TA_UIValidationRule where UIRle_CustomCode=35 ) as rle,0,1 from TA_UIValidationGroup

	insert into TA_UIValidationRuleParameter(UIRleParam_GroupingID,UIRleParam_Value,UIRleParam_Type,UIRleParam_Name,UIRleParam_KeyName,UIRleParam_ContinueInNextDay)
	select UIGrp_ID,0,0,'حداکثر تعداد','MaxCount',0 from TA_UIValidationGrouping
	where UIGrp_RuleID in (select top(1) UIRle_ID	from TA_UIValidationRule where UIRle_CustomCode=35 )

end

if(not exists(select * from TA_UIValidationRule where UIRle_CustomCode=36))
begin
	INSERT TA_UIValidationRule(UIRle_Name,UIRle_CustomCode,UIRle_Active,UIRle_SubSystemID,uirle_Order)
	VALUES(' حداقل مدت زمان بازه درخواست ساعتی','36','1','1','1')

	insert into TA_UIValidationRulePrecard(UIRlePrecard_RuleCustomCode,UIRlePrecard_PrecardCustomCode)
	values(36,51)

	INSERT TA_UIValidationRuleTempPatameter(UIValTmpParam_type,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_KeyName)
	select top(1) 0,'اول وقت',UIRle_ID,'avalVaght'
	from TA_UIValidationRule where UIRle_CustomCode=36

	INSERT TA_UIValidationRuleTempPatameter(UIValTmpParam_type,UIValTmpParam_Name,UIValTmpParam_RuleID,UIValTmpParam_KeyName)
	select top(1) 0,'حداقل مدت درخواست',UIRle_ID,'MinLength'
	from TA_UIValidationRule where UIRle_CustomCode=36

	insert into TA_UIValidationGrouping(UIGrp_GroupID,UIGrp_RuleID,UIGrp_OperatorRestriction,UIGrp_Active)
	select UIValGrp_ID,(select top(1) UIRle_ID	from TA_UIValidationRule where UIRle_CustomCode=36 ) as rle,0,1 from TA_UIValidationGroup

	insert into TA_UIValidationRuleParameter(UIRleParam_GroupingID,UIRleParam_Value,UIRleParam_Type,UIRleParam_Name,UIRleParam_KeyName,UIRleParam_ContinueInNextDay)
	select UIGrp_ID,0,0,'اول وقت','avalVaght',0 from TA_UIValidationGrouping
	where UIGrp_RuleID in (select top(1) UIRle_ID	from TA_UIValidationRule where UIRle_CustomCode=36 )

		insert into TA_UIValidationRuleParameter(UIRleParam_GroupingID,UIRleParam_Value,UIRleParam_Type,UIRleParam_Name,UIRleParam_KeyName,UIRleParam_ContinueInNextDay)
	select UIGrp_ID,0,0,'حداقل مدت درخواست','MinLength',0 from TA_UIValidationGrouping
	where UIGrp_RuleID in (select top(1) UIRle_ID	from TA_UIValidationRule where UIRle_CustomCode=36 )

end


if(not exists(select * from [TA_ConceptTemplate]  where [ConceptTmp_IdentifierCode]=1100))
begin
	UPDATE [TA_ConceptTemplate]
	set [ConceptTmp_KeyColumnName]=''
	where [ConceptTmp_KeyColumnName]='gridFields_HourlyWithPayLeave'
	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'مجموع انواع مرخصی ساعتی با حقوق', N'', N'', 1100, 0, 1, 0, 1, N'gridFields_HourlyWithPayLeave', N'#dee2df', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'مجموع انواع مرخصی ساعتی با حقوق ماهانه', N'', N'', 1101, 1, 1, 0, 1, N'gridFields_HourlyWithPayLeave', N'#dee2df', 0, N'', 0)

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=1101 and c2.ConceptTmp_IdentifierCode=1100
end


update TA_RuleTemplateParameter
set ruletmpparam_Title='اضافه کار بی نیاز به مجوز در روز تعطیل'
 where RuleTmpParam_RuleTemplateId
in (select ruletmp_id from ta_ruletemplate where ruletmp_identifiercode=6032)
and ruletmpparam_name='mojaztatil'

update TA_RuleTemplateParameter
set ruletmpparam_Title='اضافه کار بی نیاز به مجوز در روز عادی'
 where RuleTmpParam_RuleTemplateId
in (select ruletmp_id from ta_ruletemplate where ruletmp_identifiercode=6032)
and ruletmpparam_name='mojazaadi'

update TA_Ruleparameter
set ruleparam_Title='اضافه کار بی نیاز به مجوز در روز تعطیل'
 where  ruleparam_name='mojaztatil'

update TA_Ruleparameter
set ruleparam_Title='اضافه کار بی نیاز به مجوز در روز عادی'
 where ruleparam_name='mojazaadi'



if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=1002))
begin	
	
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined])
	VALUES ( N'ترددها یک در میان ورود و خروج در نظر گرفته شود', N'', N'', NULL, N'6', 0, 1002, NULL, CAST(564 AS Numeric(18, 0)), 0, N'', 0)

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'First',N'',N'',0,N'مدت تردد بعدی'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=1002
end

if(not exists(select *  from TA_RuleTemplateParameter where RuleTmpParam_RuleTemplateId=(select RuleTmp_ID from TA_RuleTemplate where RuleTmp_IdentifierCode=4003) and RuleTmpParam_Name='first'))
begin
insert into TA_RuleTemplateParameter (RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
select 'first',RuleTmp_ID,'لزوم تردد در انتهای ماموریت ',0,'','' from TA_RuleTemplate where RuleTmp_IdentifierCode=4003
end

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=6024))
begin	
	
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined],[RuleTmp_CSharpCode],[RuleTmp_Script])
	VALUES ( N'سقف اضافه کار در ایام هفته', '', N'5', 1612, 6024, NULL, CAST(552 AS Numeric(18, 0)), 0, N'', 0,'','')

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'1th',N'',N'',0,N'شنبه - منفی یک درصورت عدم استفاده'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=6024

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'2th',N'',N'',0,N'یک شنبه - منفی یک درصورت عدم استفاده'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=6024

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'3th',N'',N'',0,N'دو شنبه - منفی یک درصورت عدم استفاده'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=6024

		INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'4th',N'',N'',0,N'سه شنبه - منفی یک درصورت عدم استفاده'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=6024

		INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'5th',N'',N'',0,N'چهار شنبه - منفی یک درصورت عدم استفاده'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=6024

		INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'6th',N'',N'',0,N'پنج شنبه - منفی یک درصورت عدم استفاده'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=6024

		INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'7th',N'',N'',0,N'جمعه - منفی یک درصورت عدم استفاده'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=6024


end


if(not exists(select * from [TA_ConceptTemplate]  where [ConceptTmp_IdentifierCode]=2052))
begin

	
	UPDATE [TA_ConceptTemplate]
	set [ConceptTmp_KeyColumnName]='ماموریت روزانه - 65'
	where [ConceptTmp_IdentifierCode]=2035

	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N' ماموریت ماهانه_62', N'', N'', 2052, 1, 1, 0, 1, N'', N'', 0, N'', 0)
	
	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N' ماموریت ماهانه_63', N'', N'', 2053, 1, 1, 0, 1, N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N' ماموریت ماهانه_64', N'', N'', 2054, 1, 1, 0, 1, N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N' ماموریت ماهانه_65', N'', N'', 2055, 1, 1, 0, 1, N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'ماموریت روزانه تعطیل ', N'', N'', 2056, 0, 1, 0, 1, N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'ماموریت روزانه تعطیل ماهانه', N'', N'', 2057, 1, 1, 0, 1, N'', N'', 0, N'', 0)
	
	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=2052 and c2.ConceptTmp_IdentifierCode=2032

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=2053 and c2.ConceptTmp_IdentifierCode=2033

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=2054 and c2.ConceptTmp_IdentifierCode=2034

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=2055 and c2.ConceptTmp_IdentifierCode=2035

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=2057 and c2.ConceptTmp_IdentifierCode=2056
	
	UPDATE [TA_ConceptTemplate]
	set ConceptTmp_CalcSituationType=0
	where [ConceptTmp_IdentifierCode]=2035


	UPDATE [TA_ConceptTemplate]
	set ConceptTmp_IsPeriodic=0
	where [ConceptTmp_IdentifierCode]=2035
	
end

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=4013))
begin
	
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined])
	VALUES ( N'حداقل مدت ماموریت ساعتی قبل از وقت .... و حداکثر آن ... میباشد', N'', N'', NULL, N'3', 1820, 4013, NULL, CAST(553 AS Numeric(18, 0)), 0, N'', 0)

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'First',N'',N'',1,N'حداقل مدت'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=4013

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'Second',N'',N'',1,N'حداکثر مدت'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=4013
end

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=4014))
begin
	
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined])
	VALUES ( N'حداقل مدت ماموریت ساعتی اول وقت .... و حداکثر آن ... میباشد', N'', N'', NULL, N'3', 1821, 4014, NULL, CAST(553 AS Numeric(18, 0)), 0, N'', 0)

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'First',N'',N'',1,N'حداقل مدت'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=4014

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'Second',N'',N'',1,N'حداکثر مدت'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=4014
end

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=4015))
begin
	
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined])
	VALUES ( N'حداقل مدت ماموریت ساعتی داخل شیفت .... و حداکثر آن ... میباشد', N'', N'', NULL, N'3', 1822, 4015, NULL, CAST(553 AS Numeric(18, 0)), 0, N'', 0)

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'First',N'',N'',1,N'حداقل مدت'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=4015

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
    select [RuleTmp_ID],N'Second',N'',N'',1,N'حداکثر مدت'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=4015
end

if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=4032))
begin
	
	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'اضافه کار ویژه', N'', N'', 4032, 0, 1, 0, 1, N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'اضافه کار ویژه ماهانه', N'', N'', 4033, 1, 1, 0, 1, N'', N'', 0, N'', 0)

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=4033 and c2.ConceptTmp_IdentifierCode=4032
end

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=5028))
begin
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_Name], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible],[RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode])
	VALUES ( N'تبدیل اتوماتیک تاخیر به مرخصی تا سقف ... ساعت', N'4',405,5028,0,CAST(555 AS Numeric(18, 0)),null, N'', N'', N'')
	
	INSERT into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	SELECT 'first',[RuleTmp_ID] ,'سقف تبدیل به مرخصی در ماه ',1,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=5028

	INSERT into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	SELECT 'second',[RuleTmp_ID] ,'میزان تبدیل تاخیر به مرخصی ',1,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=5028

	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_EngName], [ConceptTmp_FnName], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype], [ConceptTmp_Script], [ConceptTmp_CSharpCode])
	VALUES ( N'تاخیر تبدیل شده به مرخصی'        , 3046, 0, 0, 0, 1, N'', N'', N'', N'', 0, N'', 0, N'', N'')

	INSERT [dbo].[TA_ConceptTemplate] (  [ConceptTmp_Name], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_EngName], [ConceptTmp_FnName], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype], [ConceptTmp_Script], [ConceptTmp_CSharpCode])
	VALUES ( N'تاخیر تبدیل شده به مرخصی ماهانه', 3047, 1, 1, 0, 1, N'', N'', N'', N'', 0, N'', 0, N'', N'')

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=3047 and c2.ConceptTmp_IdentifierCode=3046
end

if(not exists (select * from TA_RuleTemplateParameter where RuleTmpParam_RuleTemplateId in (select ruletmp_id from TA_RuleTemplate where RuleTmp_IdentifierCode=5020)))
begin
	INSERT into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	SELECT 'first',[RuleTmp_ID] ,'در صورت حضور اضافه کار شود ',0,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=5020

end