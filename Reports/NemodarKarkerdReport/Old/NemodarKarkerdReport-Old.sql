--set quoted_identifier on

declare @ReportFile_Name nvarchar(max)
declare @Report_Name nvarchar(max)
declare @ReportFile_File nvarchar(max)
declare @Report_RootName nvarchar(max)=N'RootUpdated'
-------------------------------------------------------------------------------------------------------------
set @ReportFile_Name=N'R4343A670'
set @Report_Name=N'نمودار کارکرد پرسنل'
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
    <DataSources isList="true" count="3">
      <nameOrg Ref="3" type="Stimulsoft.Report.Dictionary.StiSqlSource" isKey="true">
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

join  TA_OrganDefine on DataAccessOrgan_OrgDefID=OrgDef_ID

where DataAccessOrgan_UserID={ReportHelper.Instance().UserId}</SqlCommand>
      </nameOrg>
      <time Ref="4" type="Stimulsoft.Report.Dictionary.StiSqlSource" isKey="true">
        <Alias>time</Alias>
        <Columns isList="true" count="1">
          <value>prs_date,System.String</value>
        </Columns>
        <CommandTimeout>30</CommandTimeout>
        <Dictionary isRef="1" />
        <Name>time</Name>
        <NameInSource>Connection</NameInSource>
        <Parameters isList="true" count="2">
          <value>_x0040_ToDate,,4,0</value>
          <value>_x0040_Order,,16,0</value>
        </Parameters>
        <SqlCommand>declare @TDate nvarchar(10)= SUBSTRING(cast( cast(@ToDate as date) as nvarchar(max)),1,10)
select
	(
	case SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),6,2)
when 1 then ''فروردین ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
when 2 then ''اردیبهشت ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
when 3 then ''خرداد ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
when 4 then ''تیر ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
when 5 then ''مرداد ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
when 6 then ''شهریور ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
when 7 then ''مهر ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
when 8 then ''آبان ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
when 9 then ''آذر ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
when 10 then ''دی ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
when 11 then ''بهمن ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
when 12 then ''اسفند ''+SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),1,4)
end
	) as prs_date</SqlCommand>
      </time>
      <DataSource1 Ref="5" type="Stimulsoft.Report.Dictionary.StiSqlSource" isKey="true">
        <Alias>DataSource1</Alias>
        <Columns isList="true" count="6">
          <value>prs_id,System.Decimal</value>
          <value>prs_name,System.String</value>
          <value>hozor,System.Decimal</value>
          <value>gheybat,System.Decimal</value>
          <value>mamoriat,System.Decimal</value>
          <value>ezafekar,System.Decimal</value>
        </Columns>
        <CommandTimeout>30</CommandTimeout>
        <Dictionary isRef="1" />
        <Name>DataSource1</Name>
        <NameInSource>Connection</NameInSource>
        <Parameters isList="true" count="2">
          <value>_x0040_ToDate,,4,0</value>
          <value>_x0040_Order,,16,0</value>
        </Parameters>
        <SqlCommand>select aaa.prs_id, a.prs_name,
	ISNULL(a.prs_time,0) as hozor,
	ISNULL(b.prs_time,0) as gheybat,
	ISNULL(c.prs_time,0) as mamoriat,
	ISNULL(d.prs_time,0) as ezafekar
	from TA_Person aaa
join

(select

	cast( (scv.ScndCnpValue_Value / 60) as decimal) as prs_time,
p.Prs_FirstName+'' ''+p.prs_lastname as prs_name,p.Prs_ID from TA_SecondaryConceptValue scv
left join TA_Person p on p.Prs_ID=scv.ScndCnpValue_PersonId
where ScndCnpValue_SecondaryConceptId in(105)
and scv.ScndCnpValue_PersonId in({ReportHelper.Instance().ModifiedIds()})
and (@ToDate between scv.ScndCnpValue_FromDate and scv.ScndCnpValue_ToDate) 
--order by scv.ScndCnpValue_Value desc
) a on a.Prs_ID=aaa.Prs_ID

left join
(
select

	cast( (scv.ScndCnpValue_Value / 60) as decimal) as prs_time,
p.Prs_FirstName+'' ''+p.prs_lastname as prs_name,p.Prs_ID from TA_SecondaryConceptValue scv
left join TA_Person p on p.Prs_ID=scv.ScndCnpValue_PersonId
where ScndCnpValue_SecondaryConceptId in(68)
and scv.ScndCnpValue_PersonId in({ReportHelper.Instance().ModifiedIds()})
and (@ToDate between scv.ScndCnpValue_FromDate and scv.ScndCnpValue_ToDate) 
--order by scv.ScndCnpValue_Value desc
) b on b.Prs_ID=aaa.Prs_ID

left join
(
select

	cast( (scv.ScndCnpValue_Value / 60) as decimal) as prs_time,
p.Prs_FirstName+'' ''+p.prs_lastname as prs_name,p.Prs_ID from TA_SecondaryConceptValue scv
left join TA_Person p on p.Prs_ID=scv.ScndCnpValue_PersonId
where ScndCnpValue_SecondaryConceptId in(78)
and scv.ScndCnpValue_PersonId in({ReportHelper.Instance().ModifiedIds()})
and (@ToDate between scv.ScndCnpValue_FromDate and scv.ScndCnpValue_ToDate) 
--order by scv.ScndCnpValue_Value desc
) c on c.Prs_ID=aaa.Prs_ID

left join
(
select

	cast( (scv.ScndCnpValue_Value / 60) as decimal) as prs_time,
p.Prs_FirstName+'' ''+p.prs_lastname as prs_name,p.Prs_ID from TA_SecondaryConceptValue scv
left join TA_Person p on p.Prs_ID=scv.ScndCnpValue_PersonId
where ScndCnpValue_SecondaryConceptId in(7)
and scv.ScndCnpValue_PersonId in({ReportHelper.Instance().ModifiedIds()})
and (@ToDate between scv.ScndCnpValue_FromDate and scv.ScndCnpValue_ToDate) 
--order by scv.ScndCnpValue_Value desc
) d on d.Prs_ID=aaa.Prs_ID
</SqlCommand>
      </DataSource1>
    </DataSources>
    <Relations isList="true" count="0" />
    <Report isRef="0" />
    <Variables isList="true" count="0" />
  </Dictionary>
  <EngineVersion>EngineV2</EngineVersion>
  <GlobalizationStrings isList="true" count="0" />
  <MetaTags isList="true" count="0" />
  <Pages isList="true" count="2">
    <Page1 Ref="6" type="Page" isKey="true">
      <Border>None;Black;2;Solid;False;4;Black</Border>
      <Brush>Transparent</Brush>
      <Components isList="true" count="2">
        <phbMain Ref="7" type="PageHeaderBand" isKey="true">
          <Brush>Transparent</Brush>
          <ClientRectangle>0,0.2,10.91,0.63</ClientRectangle>
          <Components isList="true" count="7">
            <txtOrgDefName Ref="8" type="Text" isKey="true">
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>2.99,0,4.17,0.57</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,18,Bold</Font>
              <Guid>8afadfed0f43404c80e784f7172bf2a4</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtOrgDefName</Name>
              <Page isRef="6" />
              <Parent isRef="7" />
              <Text>{nameOrg.OrgDef_Name}
گزارش نمودار کارکرد پرسنل</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=True, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
            </txtOrgDefName>
            <txteportDate Ref="9" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0.94,0,1.02,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>c6a40f8ce68d4e55892773d673962ee3</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txteportDate</Name>
              <Page isRef="6" />
              <Parent isRef="7" />
              <Text>: تاریخ تهیه گزارش</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txteportDate>
            <txtReporter Ref="10" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>1.18,0.24,0.79,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>a166b62a79d044b8b19a05a2c1fe197b</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtReporter</Name>
              <Page isRef="6" />
              <Parent isRef="7" />
              <Text>: تهیه کننده</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txtReporter>
            <txtShamsiGetNow Ref="11" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0,0,0.94,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>91ba14badadb4b5b84987882e7b84175</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>txtShamsiGetNow</Name>
              <Page isRef="6" />
              <Parent isRef="7" />
              <Text>{ReportHelper.Instance().ShamsiGetNow()}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txtShamsiGetNow>
            <txtUserName Ref="12" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0,0.24,1.18,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>53b1c9bf34f443a7b67e0c755b658772</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>txtUserName</Name>
              <Page isRef="6" />
              <Parent isRef="7" />
              <Text>{ReportHelper.Instance().UserName}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txtUserName>
            <Text1 Ref="13" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>10.4,0.1,0.42,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>3c6fda1c35384140a3f6ca47ae065a56</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text1</Name>
              <Page isRef="6" />
              <Parent isRef="7" />
              <Text>: تاریخ</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text1>
            <Text2 Ref="14" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>9.4,0.1,0.94,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>49aba28406b34a0aaa3039f1ae93bb2d</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text2</Name>
              <Page isRef="6" />
              <Parent isRef="7" />
              <Text>{time.prs_date}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text2>
          </Components>
          <Conditions isList="true" count="0" />
          <Guid>8b85525ba0204079a3517964ea94dc91</Guid>
          <Name>phbMain</Name>
          <Page isRef="6" />
          <Parent isRef="6" />
        </phbMain>
        <Chart1 Ref="15" type="Stimulsoft.Report.Chart.StiChart" isKey="true">
          <AllowApplyStyle>False</AllowApplyStyle>
          <Area Ref="16" type="Stimulsoft.Report.Chart.StiStackedColumnArea" isKey="true">
            <BorderColor>95, 95, 95</BorderColor>
            <Brush>GradientBrush,[255:255:255],[255:255:255],90</Brush>
            <Chart isRef="15" />
            <GridLinesHor Ref="17" type="Stimulsoft.Report.Chart.StiGridLinesHor" isKey="true">
              <Area isRef="16" />
              <Color>100, 95, 95, 95</Color>
              <MinorColor>100, 95, 95, 95</MinorColor>
              <MinorVisible>True</MinorVisible>
            </GridLinesHor>
            <GridLinesHorRight Ref="18" type="Stimulsoft.Report.Chart.StiGridLinesHor" isKey="true">
              <Area isRef="16" />
              <Color>Silver</Color>
              <MinorColor>Gainsboro</MinorColor>
              <Visible>False</Visible>
            </GridLinesHorRight>
            <GridLinesVert Ref="19" type="Stimulsoft.Report.Chart.StiGridLinesVert" isKey="true">
              <Area isRef="16" />
              <Color>100, 95, 95, 95</Color>
              <MinorColor>100, 95, 95, 95</MinorColor>
            </GridLinesVert>
            <InterlacingHor Ref="20" type="Stimulsoft.Report.Chart.StiInterlacingHor" isKey="true">
              <Area isRef="16" />
              <InterlacedBrush>[10:145:145:145]</InterlacedBrush>
            </InterlacingHor>
            <InterlacingVert Ref="21" type="Stimulsoft.Report.Chart.StiInterlacingVert" isKey="true">
              <Area isRef="16" />
              <InterlacedBrush>[10:145:145:145]</InterlacedBrush>
            </InterlacingVert>
            <XAxis Ref="22" type="Stimulsoft.Report.Chart.StiXBottomAxis" isKey="true">
              <Area isRef="16" />
              <Interaction Ref="23" type="Stimulsoft.Report.Chart.StiAxisInteraction" isKey="true" />
              <Labels Ref="24" type="Stimulsoft.Report.Chart.StiAxisLabels" isKey="true">
                <Angle>90</Angle>
                <Color>95, 95, 95</Color>
                <Font>Tahoma,8</Font>
              </Labels>
              <LineColor>95, 95, 95</LineColor>
              <Range Ref="25" type="Stimulsoft.Report.Chart.StiAxisRange" isKey="true" />
              <Ticks Ref="26" type="Stimulsoft.Report.Chart.StiAxisTicks" isKey="true" />
              <Title Ref="27" type="Stimulsoft.Report.Chart.StiAxisTitle" isKey="true">
                <Color>95, 95, 95</Color>
                <Direction>LeftToRight</Direction>
                <Font>Tahoma,12,Bold</Font>
              </Title>
            </XAxis>
            <XTopAxis Ref="28" type="Stimulsoft.Report.Chart.StiXTopAxis" isKey="true">
              <Area isRef="16" />
              <Interaction Ref="29" type="Stimulsoft.Report.Chart.StiAxisInteraction" isKey="true" />
              <Labels Ref="30" type="Stimulsoft.Report.Chart.StiAxisLabels" isKey="true">
                <Color>95, 95, 95</Color>
                <Font>Tahoma,8</Font>
              </Labels>
              <LineColor>95, 95, 95</LineColor>
              <Ticks Ref="31" type="Stimulsoft.Report.Chart.StiAxisTicks" isKey="true" />
              <Title Ref="32" type="Stimulsoft.Report.Chart.StiAxisTitle" isKey="true">
                <Color>95, 95, 95</Color>
                <Direction>LeftToRight</Direction>
                <Font>Tahoma,12,Bold</Font>
              </Title>
            </XTopAxis>
            <YAxis Ref="33" type="Stimulsoft.Report.Chart.StiYLeftAxis" isKey="true">
              <Area isRef="16" />
              <Interaction Ref="34" type="Stimulsoft.Report.Chart.StiAxisInteraction" isKey="true" />
              <Labels Ref="35" type="Stimulsoft.Report.Chart.StiAxisLabels" isKey="true">
                <Color>95, 95, 95</Color>
                <Font>Tahoma,8</Font>
              </Labels>
              <LineColor>95, 95, 95</LineColor>
              <Range Ref="36" type="Stimulsoft.Report.Chart.StiAxisRange" isKey="true" />
              <Ticks Ref="37" type="Stimulsoft.Report.Chart.StiAxisTicks" isKey="true">
                <MinorVisible>True</MinorVisible>
              </Ticks>
              <Title Ref="38" type="Stimulsoft.Report.Chart.StiAxisTitle" isKey="true">
                <Color>95, 95, 95</Color>
                <Direction>BottomToTop</Direction>
                <Font>Tahoma,12,Bold</Font>
              </Title>
            </YAxis>
            <YRightAxis Ref="39" type="Stimulsoft.Report.Chart.StiYRightAxis" isKey="true">
              <Area isRef="16" />
              <Interaction Ref="40" type="Stimulsoft.Report.Chart.StiAxisInteraction" isKey="true" />
              <Labels Ref="41" type="Stimulsoft.Report.Chart.StiAxisLabels" isKey="true">
                <Color>95, 95, 95</Color>
                <Font>Tahoma,8</Font>
                <TextAlignment>Left</TextAlignment>
              </Labels>
              <LineColor>95, 95, 95</LineColor>
              <Range Ref="42" type="Stimulsoft.Report.Chart.StiAxisRange" isKey="true" />
              <Ticks Ref="43" type="Stimulsoft.Report.Chart.StiAxisTicks" isKey="true" />
              <Title Ref="44" type="Stimulsoft.Report.Chart.StiAxisTitle" isKey="true">
                <Color>95, 95, 95</Color>
                <Direction>TopToBottom</Direction>
                <Font>Tahoma,12,Bold</Font>
              </Title>
            </YRightAxis>
          </Area>
          <Brush>[255:255:255]</Brush>
          <ClientRectangle>0,0.9,10.9,6.6</ClientRectangle>
          <Conditions isList="true" count="0" />
          <ConstantLines isList="true" count="0" />
          <CustomStyleName />
          <Filters isList="true" count="0" />
          <Legend Ref="45" type="Stimulsoft.Report.Chart.StiLegend" isKey="true">
            <BorderColor>95, 95, 95</BorderColor>
            <Brush>GradientBrush,[255:255:255],[255:255:255],90</Brush>
            <Chart isRef="15" />
            <Font>Arial,9.75,Regular,Point,False,0</Font>
            <HorAlignment>Right</HorAlignment>
            <LabelsColor>95, 95, 95</LabelsColor>
            <MarkerAlignment>Right</MarkerAlignment>
            <MarkerSize>10, 10</MarkerSize>
            <TitleColor>95, 95, 95</TitleColor>
            <TitleFont>Arial,14,Bold</TitleFont>
          </Legend>
          <Name>Chart1</Name>
          <Page isRef="6" />
          <Parent isRef="6" />
          <Series isList="true" count="4">
            <Item15 Ref="46" type="Stimulsoft.Report.Chart.StiStackedColumnSeries" isKey="true">
              <ArgumentDataColumn>DataSource1.prs_name</ArgumentDataColumn>
              <BorderColor>28, 45, 65</BorderColor>
              <Brush>GlareBrush,[128:145:165],[178:195:215],0,0.5,1</Brush>
              <Chart isRef="15" />
              <Conditions isList="true" count="0" />
              <Filters isList="true" count="0" />
              <SeriesLabels Ref="47" type="Stimulsoft.Report.Chart.StiCenterAxisLabels" isKey="true">
                <BorderColor>95, 95, 95</BorderColor>
                <Brush>WhiteSmoke</Brush>
                <Font>Arial,7</Font>
                <LabelColor>95, 95, 95</LabelColor>
                <MarkerSize>8, 6</MarkerSize>
                <ValueTypeSeparator>-</ValueTypeSeparator>
              </SeriesLabels>
              <Title>حضور</Title>
              <ValueDataColumn>DataSource1.hozor</ValueDataColumn>
            </Item15>
            <Item16 Ref="48" type="Stimulsoft.Report.Chart.StiStackedColumnSeries" isKey="true">
              <ArgumentDataColumn>DataSource1.prs_name</ArgumentDataColumn>
              <BorderColor>71, 23, 22</BorderColor>
              <Brush>GlareBrush,[171:123:122],[221:173:172],0,0.5,1</Brush>
              <Chart isRef="15" />
              <Conditions isList="true" count="0" />
              <Filters isList="true" count="0" />
              <SeriesLabels Ref="49" type="Stimulsoft.Report.Chart.StiCenterAxisLabels" isKey="true">
                <BorderColor>95, 95, 95</BorderColor>
                <Brush>WhiteSmoke</Brush>
                <Font>Arial,7</Font>
                <LabelColor>95, 95, 95</LabelColor>
                <MarkerSize>8, 6</MarkerSize>
                <ValueTypeSeparator>-</ValueTypeSeparator>
              </SeriesLabels>
              <Title>غیبت</Title>
              <ValueDataColumn>DataSource1.gheybat</ValueDataColumn>
            </Item16>
            <Item17 Ref="50" type="Stimulsoft.Report.Chart.StiStackedColumnSeries" isKey="true">
              <ArgumentDataColumn>DataSource1.prs_name</ArgumentDataColumn>
              <BorderColor>55, 67, 29</BorderColor>
              <Brush>GlareBrush,[155:167:129],[205:217:179],0,0.5,1</Brush>
              <Chart isRef="15" />
              <Conditions isList="true" count="0" />
              <Filters isList="true" count="0" />
              <SeriesLabels Ref="51" type="Stimulsoft.Report.Chart.StiCenterAxisLabels" isKey="true">
                <BorderColor>95, 95, 95</BorderColor>
                <Brush>WhiteSmoke</Brush>
                <Font>Arial,7</Font>
                <LabelColor>95, 95, 95</LabelColor>
                <MarkerSize>8, 6</MarkerSize>
                <ValueTypeSeparator>-</ValueTypeSeparator>
              </SeriesLabels>
              <Title>ماموریت</Title>
              <ValueDataColumn>DataSource1.mamoriat</ValueDataColumn>
            </Item17>
            <Item18 Ref="52" type="Stimulsoft.Report.Chart.StiStackedColumnSeries" isKey="true">
              <ArgumentDataColumn>DataSource1.prs_name</ArgumentDataColumn>
              <BorderColor>44, 33, 57</BorderColor>
              <Brush>GlareBrush,[144:133:157],[194:183:207],0,0.5,1</Brush>
              <Chart isRef="15" />
              <Conditions isList="true" count="0" />
              <Filters isList="true" count="0" />
              <SeriesLabels Ref="53" type="Stimulsoft.Report.Chart.StiCenterAxisLabels" isKey="true">
                <BorderColor>95, 95, 95</BorderColor>
                <Brush>WhiteSmoke</Brush>
                <Font>Arial,7</Font>
                <LabelColor>95, 95, 95</LabelColor>
                <MarkerSize>8, 6</MarkerSize>
                <ValueTypeSeparator>-</ValueTypeSeparator>
              </SeriesLabels>
              <Title>اضافه کار</Title>
              <ValueDataColumn>DataSource1.ezafekar</ValueDataColumn>
            </Item18>
          </Series>
          <SeriesLabels Ref="54" type="Stimulsoft.Report.Chart.StiNoneLabels" isKey="true">
            <Chart isRef="15" />
            <MarkerSize>8, 6</MarkerSize>
            <ValueTypeSeparator>-</ValueTypeSeparator>
          </SeriesLabels>
          <SeriesLabelsConditions isList="true" count="0" />
          <Sort isList="true" count="0" />
          <Strips isList="true" count="0" />
          <Style Ref="55" type="Stimulsoft.Report.Chart.StiStyle02" isKey="true" />
          <Title Ref="56" type="Stimulsoft.Report.Chart.StiChartTitle" isKey="true">
            <Brush>[95:95:95]</Brush>
            <Font>Tahoma,12,Bold</Font>
          </Title>
        </Chart1>
      </Components>
      <Conditions isList="true" count="0" />
      <Guid>9e9f9cb5ca0b410ca53438a742e8661f</Guid>
      <Margins>0.39,0.39,0.39,0.39</Margins>
      <Name>Page1</Name>
      <Orientation>Landscape</Orientation>
      <PageHeight>8.27</PageHeight>
      <PageWidth>11.69</PageWidth>
      <PaperSize>A4</PaperSize>
      <Report isRef="0" />
      <Watermark Ref="57" type="Stimulsoft.Report.Components.StiWatermark" isKey="true">
        <Font>Arial,100</Font>
        <TextBrush>[50:0:0:0]</TextBrush>
      </Watermark>
    </Page1>
    <Form1 Ref="58" type="Stimulsoft.Report.Dialogs.StiForm" isKey="true">
      <BackColor>Control</BackColor>
      <Components isList="true" count="8">
        <ButtonControl1 Ref="59" type="Stimulsoft.Report.Dialogs.StiButtonControl" isKey="true">
          <ClickEvent>if(!chkHozor.Checked &amp;&amp; !chkGheybat.Checked &amp;&amp; !chkMamoriat.Checked &amp;&amp; !chkEzafekar.Checked)
	chkHozor.Checked=true;



if(cmbType.SelectedIndex==0 &amp;&amp; chkHozor.Checked==true)
{
	Chart1.Series[0].SortBy=Stimulsoft.Report.Chart.StiSeriesSortType.Value;

	if(cmbDir.SelectedIndex==0)
		Chart1.Series[0].SortDirection=Stimulsoft.Report.Chart.StiSeriesSortDirection.Ascending;
	if(cmbDir.SelectedIndex==1)
		Chart1.Series[0].SortDirection=Stimulsoft.Report.Chart.StiSeriesSortDirection.Descending;
}
if(cmbType.SelectedIndex==1 &amp;&amp; chkGheybat.Checked==true)
{
	Chart1.Series[1].SortBy=Stimulsoft.Report.Chart.StiSeriesSortType.Value;
	
	if(cmbDir.SelectedIndex==0)
		Chart1.Series[1].SortDirection=Stimulsoft.Report.Chart.StiSeriesSortDirection.Ascending;
	if(cmbDir.SelectedIndex==1)
		Chart1.Series[1].SortDirection=Stimulsoft.Report.Chart.StiSeriesSortDirection.Descending;
}
if(cmbType.SelectedIndex==2 &amp;&amp; chkMamoriat.Checked==true)
{
	Chart1.Series[2].SortBy=Stimulsoft.Report.Chart.StiSeriesSortType.Value;
	
	if(cmbDir.SelectedIndex==0)
		Chart1.Series[2].SortDirection=Stimulsoft.Report.Chart.StiSeriesSortDirection.Ascending;
	if(cmbDir.SelectedIndex==1)
		Chart1.Series[2].SortDirection=Stimulsoft.Report.Chart.StiSeriesSortDirection.Descending;
}
if(cmbType.SelectedIndex==3 &amp;&amp; chkEzafekar.Checked==true)
{
	Chart1.Series[3].SortBy=Stimulsoft.Report.Chart.StiSeriesSortType.Value;
	
	if(cmbDir.SelectedIndex==0)
		Chart1.Series[3].SortDirection=Stimulsoft.Report.Chart.StiSeriesSortDirection.Ascending;
	if(cmbDir.SelectedIndex==1)
		Chart1.Series[3].SortDirection=Stimulsoft.Report.Chart.StiSeriesSortDirection.Descending;
}


if (!chkEzafekar.Checked)
	Chart1.Series.RemoveAt(3);
if (!chkMamoriat.Checked)
	Chart1.Series.RemoveAt(2);
if (!chkGheybat.Checked)
	Chart1.Series.RemoveAt(1);
if (!chkHozor.Checked)
	Chart1.Series.RemoveAt(0);


	</ClickEvent>
          <ClientRectangle>8,240,464,72</ClientRectangle>
          <Components isList="true" count="0" />
          <DialogResult>OK</DialogResult>
          <Font>Arial,12,Bold,Point,False,0</Font>
          <ForeColor>Black</ForeColor>
          <Guid>c544088586264d619b74b78322548854</Guid>
          <Location>8, 240</Location>
          <Name>ButtonControl1</Name>
          <Page isRef="58" />
          <Parent isRef="58" />
          <Size>464, 72</Size>
          <Text>نمایش گزارش</Text>
        </ButtonControl1>
        <chkMamoriat Ref="60" type="Stimulsoft.Report.Dialogs.StiCheckBoxControl" isKey="true">
          <BackColor>Control</BackColor>
          <Checked>True</Checked>
          <ClientRectangle>264,72,200,40</ClientRectangle>
          <Components isList="true" count="0" />
          <Font>Arial,12,Bold,Point,False,0</Font>
          <ForeColor>Black</ForeColor>
          <Guid>d811f65d6b4445ad8b82d323e9c3e43e</Guid>
          <Location>264, 72</Location>
          <Name>chkMamoriat</Name>
          <Page isRef="58" />
          <Parent isRef="58" />
          <RightToLeft>Yes</RightToLeft>
          <Size>200, 40</Size>
          <Text>ماموریت</Text>
        </chkMamoriat>
        <chkHozor Ref="61" type="Stimulsoft.Report.Dialogs.StiCheckBoxControl" isKey="true">
          <BackColor>Control</BackColor>
          <Checked>True</Checked>
          <ClientRectangle>264,16,200,40</ClientRectangle>
          <Components isList="true" count="0" />
          <Font>Arial,12,Bold,Point,False,0</Font>
          <ForeColor>Black</ForeColor>
          <Guid>f7997e7b2e824c8f85e7489a7a42eda3</Guid>
          <Location>264, 16</Location>
          <Name>chkHozor</Name>
          <Page isRef="58" />
          <Parent isRef="58" />
          <RightToLeft>Yes</RightToLeft>
          <Size>200, 40</Size>
          <Text>حضور</Text>
        </chkHozor>
        <chkEzafekar Ref="62" type="Stimulsoft.Report.Dialogs.StiCheckBoxControl" isKey="true">
          <BackColor>Control</BackColor>
          <Checked>True</Checked>
          <ClientRectangle>16,72,200,40</ClientRectangle>
          <Components isList="true" count="0" />
          <Font>Arial,12,Bold,Point,False,0</Font>
          <ForeColor>Black</ForeColor>
          <Guid>87ba12789ba9415788a7a8bbd50d8fa4</Guid>
          <Location>16, 72</Location>
          <Name>chkEzafekar</Name>
          <Page isRef="58" />
          <Parent isRef="58" />
          <RightToLeft>Yes</RightToLeft>
          <Size>200, 40</Size>
          <Text>اضافه کار</Text>
        </chkEzafekar>
        <chkGheybat Ref="63" type="Stimulsoft.Report.Dialogs.StiCheckBoxControl" isKey="true">
          <BackColor>Control</BackColor>
          <Checked>True</Checked>
          <ClientRectangle>16,16,200,40</ClientRectangle>
          <Components isList="true" count="0" />
          <Font>Arial,12,Bold,Point,False,0</Font>
          <ForeColor>Black</ForeColor>
          <Guid>69b49f9afa3045f98c32535cfb511070</Guid>
          <Location>16, 16</Location>
          <Name>chkGheybat</Name>
          <Page isRef="58" />
          <Parent isRef="58" />
          <RightToLeft>Yes</RightToLeft>
          <Size>200, 40</Size>
          <Text>غیبت</Text>
        </chkGheybat>
        <cmbDir Ref="64" type="Stimulsoft.Report.Dialogs.StiComboBoxControl" isKey="true">
          <BackColor>Window</BackColor>
          <ClientRectangle>40,184,176,20</ClientRectangle>
          <Components isList="true" count="0" />
          <Font>Arial,12,Bold,Point,False,0</Font>
          <ForeColor>Black</ForeColor>
          <Guid>5be1cdc51687466a925efb58c496c33f</Guid>
          <Items isList="true" count="2">
            <value>صعودی</value>
            <value>نزولی</value>
          </Items>
          <Location>40, 184</Location>
          <Name>cmbDir</Name>
          <Page isRef="58" />
          <Parent isRef="58" />
          <RightToLeft>Yes</RightToLeft>
          <Size>176, 20</Size>
          <Text>Combo Box</Text>
        </cmbDir>
        <cmbType Ref="65" type="Stimulsoft.Report.Dialogs.StiComboBoxControl" isKey="true">
          <BackColor>Window</BackColor>
          <ClientRectangle>304,184,160,20</ClientRectangle>
          <Components isList="true" count="0" />
          <Font>Arial,12,Bold,Point,False,0</Font>
          <ForeColor>Black</ForeColor>
          <Guid>f17cb89800da407ea427b11ea40436b7</Guid>
          <Items isList="true" count="4">
            <value>حضور</value>
            <value>غیبت</value>
            <value>ماموریت</value>
            <value>اضافه کار</value>
          </Items>
          <Location>304, 184</Location>
          <Name>cmbType</Name>
          <Page isRef="58" />
          <Parent isRef="58" />
          <RightToLeft>Yes</RightToLeft>
          <Size>160, 20</Size>
          <Text>Combo Box</Text>
        </cmbType>
        <LabelControl1 Ref="66" type="Stimulsoft.Report.Dialogs.StiLabelControl" isKey="true">
          <BackColor>Control</BackColor>
          <ClientRectangle>320,152,144,24</ClientRectangle>
          <Components isList="true" count="0" />
          <Font>Arial,12,Bold,Point,False,0</Font>
          <ForeColor>Black</ForeColor>
          <Location>320, 152</Location>
          <Name>LabelControl1</Name>
          <Page isRef="58" />
          <Parent isRef="58" />
          <RightToLeft>Inherit</RightToLeft>
          <Size>144, 24</Size>
          <Text>مرتب سازی براساس</Text>
          <TextAlign>MiddleRight</TextAlign>
        </LabelControl1>
      </Components>
      <Font>Microsoft Sans Serif,8</Font>
      <Guid>c0cf7cb2b6574f6fa3cd9f0e6ac2b186</Guid>
      <Location>0, 0</Location>
      <Name>Form1</Name>
      <Report isRef="0" />
      <Size>488, 352</Size>
      <Text>فیلتر</Text>
    </Form1>
  </Pages>
  <PrinterSettings Ref="67" type="Stimulsoft.Report.Print.StiPrinterSettings" isKey="true" />
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
  <ReportChanged>4/17/2013 1:45:17 PM</ReportChanged>
  <ReportCreated>4/15/2013 11:04:05 AM</ReportCreated>
  <ReportFile>D:\Iman Report\NemodarKarkerdReport\NemodarKarkerdReport.mrt</ReportFile>
  <ReportGuid>d9f668bee6a24d4bac783aa82b5f071e</ReportGuid>
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
           ,[Report_Path]
           ,[Report_ReportFileId]
           ,[Report_IsReport]
           ,[Report_ParentPath]
           ,[Report_Order]
           )
     VALUES
           (
            @Report_Name
           ,(SELECT Report_ID FROM TA_Report WHERE Report_Name = @Report_RootName)
           ,','+cast((SELECT Report_ID FROM TA_Report WHERE Report_Name = @Report_RootName) as nvarchar(max))+','
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
            (SELECT RptUIParameter_ID FROM TA_ReportUIParameter WHERE RptUIParameter_ActionId like N'PersonDateRange')
           ,'@Order'
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
            (SELECT RptUIParameter_ID FROM TA_ReportUIParameter WHERE RptUIParameter_ActionId like N'PersonDateRange')
           ,'@ToDate'
           ,(SELECT ReportFile_ID FROM TA_ReportFile WHERE ReportFile_Name = @ReportFile_Name)
           )
           
           
           
