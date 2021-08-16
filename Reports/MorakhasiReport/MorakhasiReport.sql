--set quoted_identifier on

declare @ReportFile_Name nvarchar(max)
declare @Report_Name nvarchar(max)
declare @ReportFile_File nvarchar(max)
declare @Report_RootName nvarchar(max)=N'درخواستها'
-------------------------------------------------------------------------------------------------------------
set @ReportFile_Name=N'R4343A955'
set @Report_Name=N'مرخصی های استفاده شده'
set @ReportFile_File=N'<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<StiSerializer version="1.02" type="Net" application="StiReport">
  <Dictionary Ref="1" type="Dictionary" isKey="true">
    <BusinessObjects isList="true" count="0" />
    <Databases isList="true" count="1">
      <Connection Ref="2" type="Stimulsoft.Report.Dictionary.StiSqlDatabase" isKey="true">
        <Alias>Connection</Alias>
        <ConnectionString>Integrated Security=False;Data Source=localhost;Initial Catalog=GhadirGTS;Password=123;User ID=sa</ConnectionString>
        <Name>Connection</Name>
      </Connection>
    </Databases>
    <DataSources isList="true" count="2">
      <DataSource1 Ref="3" type="Stimulsoft.Report.Dictionary.StiSqlSource" isKey="true">
        <Alias>DataSource1</Alias>
        <Columns isList="true" count="14">
          <value>Prs_ID,System.Decimal</value>
          <value>Prs_Barcode,System.String</value>
          <value>prs_name,System.String</value>
          <value>estehghaghiRozane,System.Int32</value>
          <value>estehghaghiSaati,System.Int32</value>
          <value>estehghaghiMinute,System.Int32</value>
          <value>estelajiRozane,System.Decimal</value>
          <value>estelajiSaati,System.Int32</value>
          <value>estelajiMinute,System.Int32</value>
          <value>beghimandeRooz,System.Int32</value>
          <value>baghimandeSaat,System.Int32</value>
          <value>baghimandeMinute,System.Int32</value>
          <value>fDate,System.String</value>
          <value>tDate,System.String</value>
        </Columns>
        <CommandTimeout>30</CommandTimeout>
        <Dictionary isRef="1" />
        <Name>DataSource1</Name>
        <NameInSource>Connection</NameInSource>
        <Parameters isList="true" count="2">
          <value>fromDate,,4,0</value>
          <value>toDate,,4,0</value>
        </Parameters>
        <SqlCommand>select edn.Prs_ID,edn.Prs_Barcode,edn.Prs_FirstName+'' ''+edn.Prs_LastName as prs_name,
	edn.SR+(edn.SM/edn.ROOZ) as estehghaghiRozane,
	(edn.SM%edn.ROOZ)/60 as estehghaghiSaati,
(edn.SM%edn.ROOZ)%60 as estehghaghiMinute,
edn.JR+(edn.JS/edn.ROOZ) as estelajiRozane,
(cast(edn.JS as int)%edn.ROOZ)/60 as estelajiSaati,
(cast(edn.JS as int)%edn.ROOZ)%60 as estelajiMinute,
BR as beghimandeRooz,
BM/60 as baghimandeSaat,
BM%60 as baghimandeMinute,
dbo.GTS_ASM_MiladiToShamsi(cast(@fromDate as date)) as fDate,
dbo.GTS_ASM_MiladiToShamsi(cast(@toDate as date)) as tDate

 from (

select a.Prs_ID,a.Prs_Barcode,a.Prs_FirstName,a.Prs_LastName,
	ISNULL(b.dayValue,0) as SR,
	ISNULL(b.minuteValue,0) as SM,
	ISNULL(c.morakhasiEtelajiSaati,0) as JS,
	ISNULL(d.morakhasiEstelajiRozane,0) as JR,
	ISNULL(e.LeaveCalcResult_DayRemain,0) as BR,
	ISNULL(e.LeaveCalcResult_MinuteRemain,0) BM,
ISNULL( (  SELECT distinct
	minuesInDayParamParam.RuleParam_Value				AS LeaveInDay												   		
FROM (SELECT * 
	FROM TA_PersonRuleCategoryAssignment 
	WHERE PrsRulCatAsg_PersonId =a.Prs_ID) AS PrsRulCatAsg
 INNER JOIN TA_RuleCategory
 ON PrsRulCatAsg.PrsRulCatAsg_RuleCategoryId = RuleCat_ID

INNER JOIN TA_Rule AS minuesInDayRule
ON minuesInDayRule.Rule_RuleCategoryId=RuleCat_ID
INNER JOIN TA_AssignRuleParameter AS  minuesInDayParamAssgn
ON minuesInDayRule.Rule_ID=minuesInDayParamAssgn.AsgRuleParam_RuleId
INNER JOIN TA_RuleParameter AS minuesInDayParamParam
ON minuesInDayParamAssgn.AsgRuleParam_ID=minuesInDayParamParam.RuleParam_AsgRuleParamId

WHERE minuesInDayRule.Rule_IdentifierCode=223),1) as ROOZ

 from TA_Person a

left join
(select LeaveCalcResult_PersonId,sum(dayValue) as dayValue,sum(minuteValue) as minuteValue from ta_leavecalcresult
join (select UsedLeaveDetail_ID,(UsedLeaveDetail_Day) as dayValue,(UsedLeaveDetail_Minute) as minuteValue  from ta_usedleavedetail 
	where UsedLeaveDetail_Date&gt;=@fromDate and UsedLeaveDetail_Date&lt;=@toDate and UsedLeaveDetail_PersonId IN ({ReportHelper.Instance().ModifiedIds()})) UsedDetail
on LeaveCalcResult_ReferenceId=UsedDetail.UsedLeaveDetail_ID and LeaveCalcResult_Type=''ULD''
group by LeaveCalcResult_PersonId) b on Prs_ID=b.LeaveCalcResult_PersonId

left join
(select ScndCnpValue_PersonId,
	sum(ScndCnpValue_Value) as morakhasiEtelajiSaati 
	from TA_SecondaryConceptValue
	where ScndCnpValue_SecondaryConceptId=27 --مرخصی استعلاجی ساعتی 
	and ScndCnpValue_FromDate&gt;=@fromDate
and ScndCnpValue_ToDate&lt;=@toDate
and ScndCnpValue_PersonId in({ReportHelper.Instance().ModifiedIds()})
group by ScndCnpValue_PersonId) c on Prs_ID=c.ScndCnpValue_PersonId

left join
(select ScndCnpValue_PersonId,
	sum(ScndCnpValue_Value) as morakhasiEstelajiRozane 
	from TA_SecondaryConceptValue
	where ScndCnpValue_SecondaryConceptId=28 -- مرخصی استعلاجی روزانه 
	and ScndCnpValue_FromDate&gt;=@fromDate
and ScndCnpValue_ToDate&lt;=@toDate
and ScndCnpValue_PersonId in({ReportHelper.Instance().ModifiedIds()})
group by ScndCnpValue_PersonId) d on Prs_ID=d.ScndCnpValue_PersonId

left join
(select * from(
select  ROW_NUMBER() OVER(PARTITION BY LeaveCalcResult_PersonId ORDER BY LeaveCalcResult_Date DESC) rn,
LeaveCalcResult_PersonId,
LeaveCalcResult_DayRemain,LeaveCalcResult_MinuteRemain,LeaveCalcResult_Date from ta_leavecalcresult 
where LeaveCalcResult_Date&gt;=@fromDate and LeaveCalcResult_Date&lt;=@toDate  and LeaveCalcResult_PersonId IN ({ReportHelper.Instance().ModifiedIds()})
			) a
			where rn=1) e on Prs_ID=e.LeaveCalcResult_PersonId

where Prs_ID in({ReportHelper.Instance().ModifiedIds()})

)edn</SqlCommand>
      </DataSource1>
      <nameOrg Ref="4" type="Stimulsoft.Report.Dictionary.StiSqlSource" isKey="true">
        <Alias>nameOrg</Alias>
        <Columns isList="true" count="1">
          <value>OrgDef_Name,System.String</value>
        </Columns>
        <CommandTimeout>30</CommandTimeout>
        <Dictionary isRef="1" />
        <Name>nameOrg</Name>
        <NameInSource>Connection</NameInSource>
        <Parameters isList="true" count="0" />
        <SqlCommand>select  OrgDef_Name from TA_DataAccessOrgan

join  TA_OrganDefine on DataAccessOrgan_ID=OrgDef_ID

where DataAccessOrgan_UserID={ReportHelper.Instance().UserId}</SqlCommand>
      </nameOrg>
    </DataSources>
    <Relations isList="true" count="0" />
    <Report isRef="0" />
    <Variables isList="true" count="0" />
  </Dictionary>
  <EngineVersion>EngineV2</EngineVersion>
  <GlobalizationStrings isList="true" count="0" />
  <MetaTags isList="true" count="0" />
  <Pages isList="true" count="1">
    <Page1 Ref="5" type="Page" isKey="true">
      <Border>None;Black;2;Solid;False;4;Black</Border>
      <Brush>Transparent</Brush>
      <Components isList="true" count="3">
        <phbMain Ref="6" type="PageHeaderBand" isKey="true">
          <Brush>Transparent</Brush>
          <ClientRectangle>0,0.2,7.72,0.73</ClientRectangle>
          <Components isList="true" count="13">
            <txtOrgDefName Ref="7" type="Text" isKey="true">
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>1.79,0,2.97,0.67</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,18,Bold</Font>
              <Guid>d18f9db0b6c242bb825a34ec3f474524</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtOrgDefName</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{nameOrg.OrgDef_Name}
گزارش مرخصی های استفاده شده</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=True, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
            </txtOrgDefName>
            <txteportDate Ref="8" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0.74,0,1.02,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>2f654bc899264a6c9aaf0b3c1f932002</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txteportDate</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>: تاریخ تهیه گزارش</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txteportDate>
            <txtReporter Ref="9" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0.98,0.34,0.79,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>7e0a5b89553849f8a3401d70a4090c11</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtReporter</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>: تهیه کننده</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txtReporter>
            <txtShamsiGetNow Ref="10" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0,0,0.74,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>6fb7f3c8562c4a85827ef82b5aada70d</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>txtShamsiGetNow</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{ReportHelper.Instance().ShamsiGetNow()}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txtShamsiGetNow>
            <txtUserName Ref="11" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0,0.34,0.98,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>c994a56bc2e64ce1a70501c2d771dbb5</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>txtUserName</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{ReportHelper.Instance().UserName}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txtUserName>
            <txtMr Ref="12" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>6.37,0.24,1.34,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>43252a1ba95f4b029cb4b81bc16a49f7</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtMr</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>گزارش مرخصی خانم/آقای</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </txtMr>
            <txtName Ref="13" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>4.8,0.24,1.47,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>111733a4dbdc4b3b9dcc94e8646607c9</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtName</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{DataSource1.prs_name}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </txtName>
            <txtFrom Ref="14" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>7.56,0,0.16,0.2</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>535625eb69154b2cac79173b47708808</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtFrom</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>از</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txtFrom>
            <txtPeriodicFromDate Ref="15" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>6.61,0,0.94,0.2</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>c0eaf924ddb94a2bb257fb939d1ed5b6</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtPeriodicFromDate</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{DataSource1.fDate}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </txtPeriodicFromDate>
            <txtTo Ref="16" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>6.37,0,0.16,0.2</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>ad6bf099720f43deb20d6fdf121658db</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtTo</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>تا</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txtTo>
            <txtPeriodicToDate Ref="17" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>5.43,0,0.94,0.2</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>fdce25ce268645879725e011776d6888</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtPeriodicToDate</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{DataSource1.tDate}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </txtPeriodicToDate>
            <txtPersonId Ref="18" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>6.85,0.5,0.87,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>1e8d75776c57446ea774d54f49c58263</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtPersonId</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>شماره پرسنلی</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txtPersonId>
            <txtPrsBarCode Ref="19" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>5.35,0.5,1.02,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>f736833d565643d284d4a2ea9d11afd8</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtPrsBarCode</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{DataSource1.Prs_Barcode}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </txtPrsBarCode>
          </Components>
          <Conditions isList="true" count="0" />
          <Guid>d63055b1855a40daa51bf57bdfc55aa3</Guid>
          <Name>phbMain</Name>
          <Page isRef="5" />
          <Parent isRef="5" />
        </phbMain>
        <GroupHeaderBand1 Ref="20" type="GroupHeaderBand" isKey="true">
          <Brush>Transparent</Brush>
          <ClientRectangle>0,1.33,7.72,0.5</ClientRectangle>
          <Components isList="true" count="0" />
          <Condition>{DataSource1.Prs_ID}</Condition>
          <Conditions isList="true" count="0" />
          <Name>GroupHeaderBand1</Name>
          <NewPageBefore>True</NewPageBefore>
          <Page isRef="5" />
          <Parent isRef="5" />
        </GroupHeaderBand1>
        <DataDataSource1 Ref="21" type="DataBand" isKey="true">
          <Brush>Transparent</Brush>
          <BusinessObjectGuid isNull="true" />
          <ClientRectangle>0,2.23,7.72,1.3</ClientRectangle>
          <Components isList="true" count="24">
            <DataDataSource1_morakhasiEtelajiSaati2 Ref="22" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <CanGrow>True</CanGrow>
              <ClientRectangle>3.3,0.5,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>DataDataSource1_morakhasiEtelajiSaati2</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>{DataSource1.estelajiSaati}</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </DataDataSource1_morakhasiEtelajiSaati2>
            <DataDataSource1_morakhasiEstelajiRozane2 Ref="23" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <CanGrow>True</CanGrow>
              <ClientRectangle>4.5,0.5,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>DataDataSource1_morakhasiEstelajiRozane2</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>{DataSource1.estelajiRozane}</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </DataDataSource1_morakhasiEstelajiRozane2>
            <DataDataSource1_morakhasiEstehghaghiSaati2 Ref="24" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <CanGrow>True</CanGrow>
              <ClientRectangle>3.3,0,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>DataDataSource1_morakhasiEstehghaghiSaati2</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>{DataSource1.estehghaghiSaati}</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </DataDataSource1_morakhasiEstehghaghiSaati2>
            <DataDataSource1_morakhasiEstehghaghiRozane2 Ref="25" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <CanGrow>True</CanGrow>
              <ClientRectangle>2.1,0,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>DataDataSource1_morakhasiEstehghaghiRozane2</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>{DataSource1.estehghaghiMinute}</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </DataDataSource1_morakhasiEstehghaghiRozane2>
            <HeaderDataSource1_morakhasiEstehghaghiSaati Ref="26" type="Text" isKey="true">
              <Border>Top, Right, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>5.1,0,2.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Bold,Point,False,0</Font>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>HeaderDataSource1_morakhasiEstehghaghiSaati</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>مرخصی استحقاقی استفاده شده</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </HeaderDataSource1_morakhasiEstehghaghiSaati>
            <HeaderDataSource1_morakhasiEstehghaghiRozane Ref="27" type="Text" isKey="true">
              <Border>Top, Right, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>5.1,0.5,2.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Bold,Point,False,0</Font>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>HeaderDataSource1_morakhasiEstehghaghiRozane</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>مرخصی استعلاجی استفاده شده</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </HeaderDataSource1_morakhasiEstehghaghiRozane>
            <Text5 Ref="28" type="Text" isKey="true">
              <Border>Top, Right, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>5.1,1,2.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Bold,Point,False,0</Font>
              <Guid>d57d8bb8814645c8a1d5b38bc91bfa9f</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text5</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>مانده مرخصی استحقاقی</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text5>
            <Text7 Ref="29" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <CanGrow>True</CanGrow>
              <ClientRectangle>4.5,0,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>86874e8976544a609220fccaf2e37a84</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text7</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>{DataSource1.estehghaghiRozane}</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text7>
            <Text8 Ref="30" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>3.9,0,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>a5d8dd3bb4644929b4b7ac0dce5a55b5</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text8</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>روز و</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text8>
            <Text9 Ref="31" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>1.5,0,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>fa79d4cd008c4c67841b70a075e7c60b</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text9</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>دقیقه</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text9>
            <Text10 Ref="32" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>2.7,0,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>2c2b0f05a1044e17a5c05ac2f9504399</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text10</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>ساعت و</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text10>
            <Text11 Ref="33" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>3.9,0.5,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>fec51a65554b494c9f34f30b954cc354</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text11</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>روز و</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text11>
            <Text12 Ref="34" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>2.7,0.5,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>ec7601ffb8f943ac9af852f4eec3884b</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text12</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>ساعت و</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text12>
            <Text13 Ref="35" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>1.5,0.5,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>93a65a312dd54db0b75b29e44423aff5</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text13</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>دقیقه</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text13>
            <Text14 Ref="36" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <CanGrow>True</CanGrow>
              <ClientRectangle>2.1,0.5,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>c2a7bab8c78642e8a935dd45b6b0afa8</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text14</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>{DataSource1.estelajiMinute}</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text14>
            <Text1 Ref="37" type="Text" isKey="true">
              <Border>Top, Left, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>0,0,1.5,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>7edb28eda8714ceb892dfc101891ecf1</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text1</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text1>
            <Text2 Ref="38" type="Text" isKey="true">
              <Border>Top, Left, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>0,0.5,1.5,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>9b4f9691e0c54f1887e6f9bb0f93f68b</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text2</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text2>
            <Text4 Ref="39" type="Text" isKey="true">
              <Border>Top, Left, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>0,1,1.5,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>950550c78bc5442d9d4e600eaae4547e</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text4</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text4>
            <Text3 Ref="40" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <CanGrow>True</CanGrow>
              <ClientRectangle>3.3,1,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>3f252d2ce23e4a8fac352d084e64614f</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text3</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>{DataSource1.baghimandeSaat}</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text3>
            <Text6 Ref="41" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <CanGrow>True</CanGrow>
              <ClientRectangle>4.5,1,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>7b582dd7c4d74739ae4d40db2d6136c0</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text6</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>{DataSource1.beghimandeRooz}</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text6>
            <Text15 Ref="42" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>3.9,1,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>cbdd425915ed4bdab1a8df3eda28db1f</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text15</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>روز و</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text15>
            <Text16 Ref="43" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>2.7,1,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>b4a1c1ff235848f9be821dea65490fd3</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text16</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>ساعت و</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text16>
            <Text17 Ref="44" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>1.5,1,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>7bf3e88540f04fee81a532c3ce1f9b64</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text17</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>دقیقه</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </Text17>
            <Text18 Ref="45" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <CanGrow>True</CanGrow>
              <ClientRectangle>2.1,1,0.6,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <Guid>c929f3d580b54d56af62a84570b769b3</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text18</Name>
              <Page isRef="5" />
              <Parent isRef="21" />
              <Text>{DataSource1.baghimandeMinute}</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text18>
          </Components>
          <Conditions isList="true" count="0" />
          <DataSourceName>DataSource1</DataSourceName>
          <Filters isList="true" count="0" />
          <Name>DataDataSource1</Name>
          <Page isRef="5" />
          <Parent isRef="5" />
          <Sort isList="true" count="0" />
        </DataDataSource1>
      </Components>
      <Conditions isList="true" count="0" />
      <Guid>1b84b26de9274ebd9ea237b71177efbf</Guid>
      <Margins>0.39,0.39,0.39,0.39</Margins>
      <Name>Page1</Name>
      <PageHeight>11</PageHeight>
      <PageWidth>8.5</PageWidth>
      <PaperSize>Letter</PaperSize>
      <Report isRef="0" />
      <Watermark Ref="46" type="Stimulsoft.Report.Components.StiWatermark" isKey="true">
        <Font>Arial,100</Font>
        <TextBrush>[50:0:0:0]</TextBrush>
      </Watermark>
    </Page1>
  </Pages>
  <PrinterSettings Ref="47" type="Stimulsoft.Report.Print.StiPrinterSettings" isKey="true" />
  <ReferencedAssemblies isList="true" count="8">
    <value>System.Dll</value>
    <value>System.Drawing.Dll</value>
    <value>System.Windows.Forms.Dll</value>
    <value>System.Data.Dll</value>
    <value>System.Xml.Dll</value>
    <value>Stimulsoft.Controls.Dll</value>
    <value>Stimulsoft.Base.Dll</value>
    <value>Stimulsoft.Report.Dll</value>
  </ReferencedAssemblies>
  <ReportAlias>Report</ReportAlias>
  <ReportChanged>4/17/2013 12:35:24 PM</ReportChanged>
  <ReportCreated>4/16/2013 1:18:11 PM</ReportCreated>
  <ReportFile>D:\MorakhasiReport.mrt</ReportFile>
  <ReportGuid>7e7f22d9c8b54afa929789cf516b46fb</ReportGuid>
  <ReportName>Report</ReportName>
  <ReportUnit>Inches</ReportUnit>
  <ReportVersion>2011.3.1200</ReportVersion>
  <Script>using System;
using System.Drawing;
using System.Windows.Forms;
using System.Data;
using Stimulsoft.Controls;
using Stimulsoft.Base.Drawing;
using Stimulsoft.Report;
using Stimulsoft.Report.Dialogs;
using Stimulsoft.Report.Components;

namespace Reports
{
    public class Report : Stimulsoft.Report.StiReport
    {
        public Report()        {
            this.InitializeComponent();
        }

        #region StiReport Designer generated code - do not modify
        #endregion StiReport Designer generated code - do not modify
    }
}
</Script>
  <ScriptLanguage>CSharp</ScriptLanguage>
  <Styles isList="true" count="0" />
</StiSerializer>'
-------------------------------------------------------------------------------------------------------------
DELETE FROM TA_ReportParameter WHERE ReportParameter_RptFileId = (SELECT ReportFile_ID FROM TA_ReportFile WHERE ReportFile_Name = @ReportFile_Name)
DELETE FROM TA_Report WHERE Report_Name = @Report_Name
DELETE FROM TA_ReportFile WHERE ReportFile_Name = @ReportFile_Name
-------------------------------------------------------------------------------------------------------------
INSERT INTO [TA_ReportFile]([ReportFile_Name],[ReportFile_File],[ReportFile_Description])
VALUES(@ReportFile_Name,@ReportFile_File,@Report_Name)
-------------------------------------------------------------------------------------------------------------
INSERT INTO [TA_Report]
           (
            [Report_Name]
           ,[Report_ParentId]
           --,[Report_Path]
           ,[Report_ReportFileId]
           ,[Report_IsReport]
           ,[Report_ParentPath]
           ,[Report_Order]
           )
     VALUES
           (
            @Report_Name
           ,(SELECT Report_ID FROM TA_Report WHERE Report_Name = @Report_RootName)
           --,','+cast((SELECT Report_ID FROM TA_Report WHERE Report_Name = @Report_RootName) as nvarchar(max))+','
           ,(SELECT ReportFile_ID FROM TA_ReportFile WHERE ReportFile_Name = @ReportFile_Name)
           ,1
           ,','+cast((SELECT Report_ID FROM TA_Report WHERE Report_Name = @Report_RootName) as nvarchar(max))+','
           ,(SELECT MAX(Report_Order)+1 FROM TA_Report)
           )
--------------------------------------------------------------------------------------------------------------
INSERT INTO [TA_ReportParameter]
           (
            [ReportParameter_RptUIParamId]
           ,[ReportParameter_Name]
           ,[ReportParameter_RptFileId]
           )
     VALUES
           (
            (SELECT RptUIParameter_ID FROM TA_ReportUIParameter WHERE RptUIParameter_ActionId like N'PersonfromtoDateRange')
           ,'@fromDate'
           ,(SELECT ReportFile_ID FROM TA_ReportFile WHERE ReportFile_Name = @ReportFile_Name)
           )
           
           INSERT INTO [TA_ReportParameter]
           (
            [ReportParameter_RptUIParamId]
           ,[ReportParameter_Name]
           ,[ReportParameter_RptFileId]
           )
     VALUES
           (
            (SELECT RptUIParameter_ID FROM TA_ReportUIParameter WHERE RptUIParameter_ActionId like N'PersonfromtoDateRange')
           ,'@toDate'
           ,(SELECT ReportFile_ID FROM TA_ReportFile WHERE ReportFile_Name = @ReportFile_Name)
           )
           
         
