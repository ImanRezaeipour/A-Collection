if ((select count(*) from ta_report where Report_Name=N'داشبورد')<>1)
	insert into TA_Report values(N'داشبورد',1612,NULL,0,NULL,110)
	
--set quoted_identifier on

declare @ReportFile_Name nvarchar(max)
declare @Report_Name nvarchar(max)
declare @ReportFile_File nvarchar(max)
declare @Report_RootName nvarchar(max)=N'داشبورد'
-------------------------------------------------------------------------------------------------------------
set @ReportFile_Name=N'R4343A610'
set @Report_Name=N'مقایسه حضور افراد'
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
        <Columns isList="true" count="3">
          <value>prs_time,System.String</value>
          <value>prs_name,System.String</value>
          <value>prs_date,System.String</value>
        </Columns>
        <CommandTimeout>30</CommandTimeout>
        <Dictionary isRef="1" />
        <Name>DataSource1</Name>
        <NameInSource>Connection</NameInSource>
        <Parameters isList="true" count="2">
          <value>_x0040_ToDate,,4,0</value>
          <value>_x0040_Order,,16,0</value>
        </Parameters>
        <SqlCommand>declare @TDate nvarchar(10)= SUBSTRING(cast( cast(@ToDate as date) as nvarchar(max)),1,10)
select
(	case SUBSTRING(dbo.GTS_ASM_MiladiToShamsi(@TDate),6,2)
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
	end) as prs_date,	
cast( (scv.ScndCnpValue_Value / 60) as decimal) as prs_time,
p.Prs_FirstName+'' ''+p.prs_lastname as prs_name from TA_SecondaryConceptValue scv
left join TA_Person p on p.Prs_ID=scv.ScndCnpValue_PersonId
where ScndCnpValue_SecondaryConceptId=105
and scv.ScndCnpValue_PersonId in({ReportHelper.Instance().ModifiedIds()})
and (@ToDate between scv.ScndCnpValue_FromDate and scv.ScndCnpValue_ToDate) 
order by scv.ScndCnpValue_Value desc</SqlCommand>
      </DataSource1>
      <orgName Ref="4" type="Stimulsoft.Report.Dictionary.StiSqlSource" isKey="true">
        <Alias>orgName</Alias>
        <Columns isList="true" count="1">
          <value>OrgDef_Name,System.String</value>
        </Columns>
        <CommandTimeout>30</CommandTimeout>
        <Dictionary isRef="1" />
        <Name>orgName</Name>
        <NameInSource>Connection</NameInSource>
        <Parameters isList="true" count="0" />
        <SqlCommand>select  OrgDef_Name from TA_DataAccessOrgan

join  TA_OrganDefine on DataAccessOrgan_OrgDefID=OrgDef_ID

where DataAccessOrgan_UserID={ReportHelper.Instance().UserId}</SqlCommand>
      </orgName>
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
      <Components isList="true" count="2">
        <PageHeaderBand1 Ref="6" type="PageHeaderBand" isKey="true">
          <Brush>Transparent</Brush>
          <ClientRectangle>0,0.2,10.91,0.88</ClientRectangle>
          <Components isList="true" count="9">
            <Text5 Ref="7" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>1.1,0,1.02,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>cb416e86f1894a75bad030e83bdfa6f7</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text5</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>: تاریخ تهیه گزارش</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </Text5>
            <Text6 Ref="8" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0.2,0,0.94,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>25e1b3dfe87a4e60b937f77bccae50e6</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>Text6</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text6>
            <txtReporter Ref="9" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>1.3,0.4,0.79,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>c4e0e93d5ef14ab4881695793e6cbc9a</Guid>
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
            <Text3 Ref="10" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0.2,0.4,1.18,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>82a213a84272475aafeb75ed4c923890</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>Text3</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text3>
            <Text2 Ref="11" type="Text" isKey="true">
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>3.7,0.04,3.07,0.84</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,18,Bold</Font>
              <Guid>88eb46c6489b46639d42ddf955caf1ad</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text2</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{orgName.OrgDef_Name}
مقایسه حضور افراد</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
            </Text2>
            <Text1 Ref="12" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0.2,0,0.94,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>3e89420f879e4476be64d4a995870cb7</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>Text1</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{ReportHelper.Instance().ShamsiGetNow()}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </Text1>
            <Text4 Ref="13" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0.2,0.4,1.18,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>20afaf03f4a34cc49f599a733746c778</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>Text4</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{ReportHelper.Instance().UserName}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text4>
            <Text7 Ref="14" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>10.39,0.16,0.39,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>767c21a8e905468293ce4d547384bb0b</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text7</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>تاریخ</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </Text7>
            <Text9 Ref="15" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>9.21,0.16,1.18,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>0f549ea515f74c87bbfc163741cf948d</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>Text9</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{DataSource1.prs_date}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>DataColumn</Type>
              <VertAlignment>Center</VertAlignment>
            </Text9>
          </Components>
          <Conditions isList="true" count="0" />
          <Guid>fedd37e38cdf44eea92e537880cb2aa7</Guid>
          <Name>PageHeaderBand1</Name>
          <Page isRef="5" />
          <Parent isRef="5" />
        </PageHeaderBand1>
        <Chart1 Ref="16" type="Stimulsoft.Report.Chart.StiChart" isKey="true">
          <Area Ref="17" type="Stimulsoft.Report.Chart.StiClusteredColumnArea" isKey="true">
            <BorderColor>95, 72, 29</BorderColor>
            <Brush>GradientBrush,[255:255:255],[255:255:219],90</Brush>
            <Chart isRef="16" />
            <GridLinesHor Ref="18" type="Stimulsoft.Report.Chart.StiGridLinesHor" isKey="true">
              <Area isRef="17" />
              <Color>100, 95, 72, 29</Color>
              <MinorColor>100, 95, 72, 29</MinorColor>
            </GridLinesHor>
            <GridLinesHorRight Ref="19" type="Stimulsoft.Report.Chart.StiGridLinesHor" isKey="true">
              <Area isRef="17" />
              <Color>Silver</Color>
              <MinorColor>Gainsboro</MinorColor>
              <Visible>False</Visible>
            </GridLinesHorRight>
            <GridLinesVert Ref="20" type="Stimulsoft.Report.Chart.StiGridLinesVert" isKey="true">
              <Area isRef="17" />
              <Color>100, 95, 72, 29</Color>
              <MinorColor>100, 95, 72, 29</MinorColor>
            </GridLinesVert>
            <InterlacingHor Ref="21" type="Stimulsoft.Report.Chart.StiInterlacingHor" isKey="true">
              <Area isRef="17" />
              <InterlacedBrush>[10:145:122:79]</InterlacedBrush>
            </InterlacingHor>
            <InterlacingVert Ref="22" type="Stimulsoft.Report.Chart.StiInterlacingVert" isKey="true">
              <Area isRef="17" />
              <InterlacedBrush>[10:145:122:79]</InterlacedBrush>
            </InterlacingVert>
            <XAxis Ref="23" type="Stimulsoft.Report.Chart.StiXBottomAxis" isKey="true">
              <Area isRef="17" />
              <Interaction Ref="24" type="Stimulsoft.Report.Chart.StiAxisInteraction" isKey="true" />
              <Labels Ref="25" type="Stimulsoft.Report.Chart.StiAxisLabels" isKey="true">
                <Angle>90</Angle>
                <Color>95, 72, 29</Color>
                <Font>Tahoma,8</Font>
              </Labels>
              <LineColor>95, 72, 29</LineColor>
              <Range Ref="26" type="Stimulsoft.Report.Chart.StiAxisRange" isKey="true" />
              <Ticks Ref="27" type="Stimulsoft.Report.Chart.StiAxisTicks" isKey="true" />
              <Title Ref="28" type="Stimulsoft.Report.Chart.StiAxisTitle" isKey="true">
                <Color>95, 72, 29</Color>
                <Direction>LeftToRight</Direction>
                <Font>Tahoma,12,Bold</Font>
              </Title>
            </XAxis>
            <XTopAxis Ref="29" type="Stimulsoft.Report.Chart.StiXTopAxis" isKey="true">
              <Area isRef="17" />
              <Interaction Ref="30" type="Stimulsoft.Report.Chart.StiAxisInteraction" isKey="true" />
              <Labels Ref="31" type="Stimulsoft.Report.Chart.StiAxisLabels" isKey="true">
                <Color>95, 72, 29</Color>
                <Font>Tahoma,8</Font>
              </Labels>
              <LineColor>95, 72, 29</LineColor>
              <Ticks Ref="32" type="Stimulsoft.Report.Chart.StiAxisTicks" isKey="true" />
              <Title Ref="33" type="Stimulsoft.Report.Chart.StiAxisTitle" isKey="true">
                <Color>95, 72, 29</Color>
                <Direction>LeftToRight</Direction>
                <Font>Tahoma,12,Bold</Font>
              </Title>
            </XTopAxis>
            <YAxis Ref="34" type="Stimulsoft.Report.Chart.StiYLeftAxis" isKey="true">
              <Area isRef="17" />
              <Interaction Ref="35" type="Stimulsoft.Report.Chart.StiAxisInteraction" isKey="true" />
              <Labels Ref="36" type="Stimulsoft.Report.Chart.StiAxisLabels" isKey="true">
                <Color>95, 72, 29</Color>
                <Font>Tahoma,8</Font>
              </Labels>
              <LineColor>95, 72, 29</LineColor>
              <Range Ref="37" type="Stimulsoft.Report.Chart.StiAxisRange" isKey="true" />
              <Ticks Ref="38" type="Stimulsoft.Report.Chart.StiAxisTicks" isKey="true" />
              <Title Ref="39" type="Stimulsoft.Report.Chart.StiAxisTitle" isKey="true">
                <Color>95, 72, 29</Color>
                <Direction>BottomToTop</Direction>
                <Font>Tahoma,12,Bold</Font>
              </Title>
            </YAxis>
            <YRightAxis Ref="40" type="Stimulsoft.Report.Chart.StiYRightAxis" isKey="true">
              <Area isRef="17" />
              <Interaction Ref="41" type="Stimulsoft.Report.Chart.StiAxisInteraction" isKey="true" />
              <Labels Ref="42" type="Stimulsoft.Report.Chart.StiAxisLabels" isKey="true">
                <Color>95, 72, 29</Color>
                <Font>Tahoma,8</Font>
                <TextAlignment>Left</TextAlignment>
              </Labels>
              <LineColor>95, 72, 29</LineColor>
              <Range Ref="43" type="Stimulsoft.Report.Chart.StiAxisRange" isKey="true" />
              <Ticks Ref="44" type="Stimulsoft.Report.Chart.StiAxisTicks" isKey="true" />
              <Title Ref="45" type="Stimulsoft.Report.Chart.StiAxisTitle" isKey="true">
                <Color>95, 72, 29</Color>
                <Direction>TopToBottom</Direction>
                <Font>Tahoma,12,Bold</Font>
              </Title>
            </YRightAxis>
          </Area>
          <Brush>[255:255:255]</Brush>
          <ClientRectangle>0,1.1,10.9,6.4</ClientRectangle>
          <Conditions isList="true" count="0" />
          <ConstantLines isList="true" count="0" />
          <CustomStyleName />
          <Filters isList="true" count="0" />
          <Legend Ref="46" type="Stimulsoft.Report.Chart.StiLegend" isKey="true">
            <BorderColor>95, 72, 29</BorderColor>
            <Brush>GradientBrush,[255:255:255],[255:242:199],90</Brush>
            <Chart isRef="16" />
            <Font>Arial,12,Regular,Point,False,0</Font>
            <HorAlignment>Right</HorAlignment>
            <LabelsColor>95, 72, 29</LabelsColor>
            <MarkerAlignment>Right</MarkerAlignment>
            <MarkerSize>10, 10</MarkerSize>
            <TitleColor>95, 72, 29</TitleColor>
            <TitleFont>Arial,14,Bold</TitleFont>
          </Legend>
          <Name>Chart1</Name>
          <Page isRef="5" />
          <Parent isRef="5" />
          <Series isList="true" count="1">
            <Item16 Ref="47" type="Stimulsoft.Report.Chart.StiClusteredColumnSeries" isKey="true">
              <ArgumentDataColumn>DataSource1.prs_name</ArgumentDataColumn>
              <BorderColor>94, 17, 0</BorderColor>
              <Brush>GlareBrush,[144:67:3],[194:117:53],0,0.5,1</Brush>
              <Chart isRef="16" />
              <Conditions isList="true" count="0" />
              <Filters isList="true" count="0" />
              <SeriesLabels Ref="48" type="Stimulsoft.Report.Chart.StiCenterAxisLabels" isKey="true">
                <BorderColor>95, 72, 29</BorderColor>
                <Brush>Wheat</Brush>
                <Font>Arial,7</Font>
                <LabelColor>95, 72, 29</LabelColor>
                <MarkerSize>8, 6</MarkerSize>
                <ValueTypeSeparator>-</ValueTypeSeparator>
              </SeriesLabels>
              <Title>ساعت</Title>
              <ValueDataColumn>DataSource1.prs_time</ValueDataColumn>
            </Item16>
          </Series>
          <SeriesLabels Ref="49" type="Stimulsoft.Report.Chart.StiCenterAxisLabels" isKey="true">
            <BorderColor>95, 72, 29</BorderColor>
            <Brush>Wheat</Brush>
            <Chart isRef="16" />
            <Font>Arial,7</Font>
            <LabelColor>95, 72, 29</LabelColor>
            <MarkerSize>8, 6</MarkerSize>
            <ValueTypeSeparator>-</ValueTypeSeparator>
          </SeriesLabels>
          <SeriesLabelsConditions isList="true" count="0" />
          <Sort isList="true" count="0" />
          <Strips isList="true" count="0" />
          <Style Ref="50" type="Stimulsoft.Report.Chart.StiStyle01" isKey="true" />
          <Title Ref="51" type="Stimulsoft.Report.Chart.StiChartTitle" isKey="true">
            <Brush>[95:72:29]</Brush>
            <Font>Tahoma,12,Bold</Font>
          </Title>
        </Chart1>
      </Components>
      <Conditions isList="true" count="0" />
      <Guid>cec854c9a8234f558ac308b5af72504f</Guid>
      <Margins>0.39,0.39,0.39,0.39</Margins>
      <Name>Page1</Name>
      <Orientation>Landscape</Orientation>
      <PageHeight>8.27</PageHeight>
      <PageWidth>11.69</PageWidth>
      <PaperSize>A4</PaperSize>
      <Report isRef="0" />
      <Watermark Ref="52" type="Stimulsoft.Report.Components.StiWatermark" isKey="true">
        <Font>Arial,100</Font>
        <TextBrush>[50:0:0:0]</TextBrush>
      </Watermark>
    </Page1>
  </Pages>
  <PrinterSettings Ref="53" type="Stimulsoft.Report.Print.StiPrinterSettings" isKey="true" />
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
  <ReportChanged>4/15/2013 10:20:50 AM</ReportChanged>
  <ReportCreated>4/15/2013 8:30:01 AM</ReportCreated>
  <ReportFile>D:\Report.mrt</ReportFile>
  <ReportGuid>2b3d8858c638420ebd1c13d76acd233d</ReportGuid>
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
           
