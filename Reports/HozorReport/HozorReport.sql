--set quoted_identifier on

declare @ReportFile_Name nvarchar(max)
declare @Report_Name nvarchar(max)
declare @ReportFile_File nvarchar(max)
declare @Report_RootName nvarchar(max)=N'درخواستها'
-------------------------------------------------------------------------------------------------------------
set @ReportFile_Name=N'R4343A500'
set @Report_Name=N'حضور پرسنل'
set @ReportFile_File=N'<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<StiSerializer version="1.02" type="Net" application="StiReport">
  <Dictionary Ref="1" type="Dictionary" isKey="true">
    <BusinessObjects isList="true" count="0" />
    <Databases isList="true" count="1">
      <Connection Ref="2" type="Stimulsoft.Report.Dictionary.StiSqlDatabase" isKey="true">
        <Alias>Connection</Alias>
        <ConnectionString>Integrated Security=False;Password=123@tlas;Initial Catalog=Atlas;User ID=sa;Data Source=TRDSRV2\MSSQLSERVER2012</ConnectionString>
        <Name>Connection</Name>
      </Connection>
    </Databases>
    <DataSources isList="true" count="2">
      <DataSource1 Ref="3" type="Stimulsoft.Report.Dictionary.StiSqlSource" isKey="true">
        <Alias>DataSource1</Alias>
        <Columns isList="true" count="26">
          <value>Prs_ID,System.Decimal</value>
          <value>Prs_Barcode,System.String</value>
          <value>Prs__Param,System.Int32</value>
          <value>Prs_Active,System.Boolean</value>
          <value>Prs_CardNum,System.String</value>
          <value>Prs_DepartmentId,System.Decimal</value>
          <value>Prs_EmploymentNum,System.String</value>
          <value>Prs_EmploymentDate,System.DateTime</value>
          <value>Prs_ControlStationId,System.Decimal</value>
          <value>Prs_EndEmploymentDate,System.DateTime</value>
          <value>Prs_EmployId,System.Decimal</value>
          <value>Prs_Sex,System.Boolean</value>
          <value>Prs_Education,System.String</value>
          <value>Prs_FirstName,System.String</value>
          <value>Prs_MaritalStatus,System.Int32</value>
          <value>Prs_LastName,System.String</value>
          <value>Prs_PrsDtlID,System.Decimal</value>
          <value>Prs_UIValidationGroupID,System.Decimal</value>
          <value>prs_IsDeleted,System.Boolean</value>
          <value>dep_ID,System.Decimal</value>
          <value>dep_Name,System.String</value>
          <value>dep_CustomCode,System.String</value>
          <value>dep_ParentID,System.Decimal</value>
          <value>dep_ParentPath,System.String</value>
          <value>dep_ChildPath,System.String</value>
          <value>TODT,System.String</value>
        </Columns>
        <CommandTimeout>30</CommandTimeout>
        <Dictionary isRef="1" />
        <Name>DataSource1</Name>
        <NameInSource>Connection</NameInSource>
        <Parameters isList="true" count="2">
          <value>toDate,,4,0</value>
          <value>fromDate,,4,0</value>
        </Parameters>
        <SqlCommand>select p.*,d.* 
,dbo.GTS_ASM_MiladiToShamsi(CONVERT(VARCHAR(10),(@toDate),101)) as TODT
from TA_Person p
join TA_Department d on p.Prs_DepartmentId=d.dep_ID
where Prs_ID in(
select distinct BasicTraffic_PersonID from TA_BaseTraffic
	where BasicTraffic_PersonID in({ReportHelper.Instance().ModifiedIds()})
	and 
	(BasicTraffic_Date = @toDate)
)
and
Prs_Active=1
order by dep_Name</SqlCommand>
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

join  TA_OrganDefine on DataAccessOrgan_OrgDefID=OrgDef_ID

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
      <Components isList="true" count="4">
        <PageHeaderBand2 Ref="6" type="PageHeaderBand" isKey="true">
          <Brush>Transparent</Brush>
          <ClientRectangle>0,0.2,7.49,0.9</ClientRectangle>
          <Components isList="true" count="7">
            <Text6 Ref="7" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;DimGray</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0.9,0.1,1.2,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>44a6d1445ad648ff9236cff5ea1fed78</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <MinSize>1,0</MinSize>
              <Name>Text6</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>: تاریخ تهیه گزارش</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </Text6>
            <Text4 Ref="8" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0.9,0.4,1.2,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>9a0e60e11fab424d8b205fc99bcb3717</Guid>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text4</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>: تهیه کننده</Text>
              <TextBrush>[89:89:89]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </Text4>
            <Text3 Ref="9" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0.1,0.1,1.14,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>a525e42db54d4295bf0e4c88174a091f</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>Text3</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{ReportHelper.Instance().ShamsiGetNow()}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text3>
            <Text5 Ref="10" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>0.1,0.4,1.18,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>ec1b6f6522574dc0a40ed2a282abdbb9</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>Text5</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{ReportHelper.Instance().UserName}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text5>
            <txtOrgDefName Ref="11" type="Text" isKey="true">
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>2.2,0.1,3.37,0.67</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,18,Bold,Point,False,0</Font>
              <Guid>e3c7a070e29841679af4ad49fecebdb5</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtOrgDefName</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{nameOrg.OrgDef_Name}
حضور پرسنل</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=True, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
            </txtOrgDefName>
            <Text7 Ref="12" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>7,0.4,0.4,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>e23afdd3753e4e6690216317bbc1af38</Guid>
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
            <Text8 Ref="13" type="Text" isKey="true">
              <AllowHtmlTags>True</AllowHtmlTags>
              <AutoWidth>True</AutoWidth>
              <Border>None;Black;1;Solid;False;4;[105:105:105]</Border>
              <Brush>Transparent</Brush>
              <CanBreak>True</CanBreak>
              <CanGrow>True</CanGrow>
              <CanShrink>True</CanShrink>
              <ClientRectangle>5.8,0.4,1.18,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>fb04577a5f6f4b9b94d18dd1a88336b4</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>Text8</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{DataSource1.TODT}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <Type>DataColumn</Type>
              <VertAlignment>Center</VertAlignment>
            </Text8>
          </Components>
          <Conditions isList="true" count="0" />
          <Guid>9267dcbf214648ba9c89efb58a829570</Guid>
          <Name>PageHeaderBand2</Name>
          <Page isRef="5" />
          <Parent isRef="5" />
        </PageHeaderBand2>
        <GroupHeaderBand1 Ref="14" type="GroupHeaderBand" isKey="true">
          <Brush>[247:181:128]</Brush>
          <ClientRectangle>0,1.5,7.49,0.4</ClientRectangle>
          <Components isList="true" count="2">
            <Text2 Ref="15" type="Text" isKey="true">
              <Brush>Transparent</Brush>
              <ClientRectangle>6.5,0,0.9,0.4</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Bold,Point,False,0</Font>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text2</Name>
              <Page isRef="5" />
              <Parent isRef="14" />
              <Text>بخش</Text>
              <TextBrush>Black</TextBrush>
              <VertAlignment>Center</VertAlignment>
            </Text2>
            <Text1 Ref="16" type="Text" isKey="true">
              <Brush>Transparent</Brush>
              <ClientRectangle>0.1,0,6.4,0.4</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <HorAlignment>Right</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text1</Name>
              <Page isRef="5" />
              <Parent isRef="14" />
              <Text>{DataSource1.dep_Name}</Text>
              <TextBrush>Black</TextBrush>
              <VertAlignment>Center</VertAlignment>
            </Text1>
          </Components>
          <ComponentStyle>Style3</ComponentStyle>
          <Condition>{DataSource1.dep_Name}</Condition>
          <Conditions isList="true" count="0" />
          <Name>GroupHeaderBand1</Name>
          <Page isRef="5" />
          <Parent isRef="5" />
        </GroupHeaderBand1>
        <HeaderDataSource1 Ref="17" type="HeaderBand" isKey="true">
          <Brush>Silver</Brush>
          <ClientRectangle>0,2.3,7.49,0.3</ClientRectangle>
          <Components isList="true" count="2">
            <HeaderDataSource1_Prs_Barcode Ref="18" type="Text" isKey="true">
              <Border>Top, Right, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>4,0,3.5,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,12,Bold,Point,False,0</Font>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>HeaderDataSource1_Prs_Barcode</Name>
              <Page isRef="5" />
              <Parent isRef="17" />
              <Text>کد پرسنلی</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </HeaderDataSource1_Prs_Barcode>
            <HeaderDataSource1_Prs_FirstName Ref="19" type="Text" isKey="true">
              <Border>Top, Left, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>0,0,4,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Bold,Point,False,0</Font>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>HeaderDataSource1_Prs_FirstName</Name>
              <Page isRef="5" />
              <Parent isRef="17" />
              <Text>نام و نام خانوادگی</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </HeaderDataSource1_Prs_FirstName>
          </Components>
          <ComponentStyle>Style1</ComponentStyle>
          <Conditions isList="true" count="0" />
          <Name>HeaderDataSource1</Name>
          <Page isRef="5" />
          <Parent isRef="5" />
        </HeaderDataSource1>
        <DataDataSource1 Ref="20" type="DataBand" isKey="true">
          <Brush>Transparent</Brush>
          <BusinessObjectGuid isNull="true" />
          <ClientRectangle>0,3,7.49,0.3</ClientRectangle>
          <Components isList="true" count="2">
            <DataDataSource1_Prs_Barcode Ref="21" type="Text" isKey="true">
              <Border>All;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <CanGrow>True</CanGrow>
              <ClientRectangle>4,0,3.5,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>DataDataSource1_Prs_Barcode</Name>
              <Page isRef="5" />
              <Parent isRef="20" />
              <Text>{DataSource1.Prs_Barcode}</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <VertAlignment>Center</VertAlignment>
            </DataDataSource1_Prs_Barcode>
            <DataDataSource1_Prs_FirstName Ref="22" type="Text" isKey="true">
              <Border>All;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <CanGrow>True</CanGrow>
              <ClientRectangle>0,0,4,0.3</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Regular,Point,False,0</Font>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>DataDataSource1_Prs_FirstName</Name>
              <Page isRef="5" />
              <Parent isRef="20" />
              <Text>{DataSource1.Prs_FirstName} {DataSource1.Prs_LastName}</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=False, Trimming=None, WordWrap=True, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </DataDataSource1_Prs_FirstName>
          </Components>
          <Conditions isList="true" count="0" />
          <DataSourceName>DataSource1</DataSourceName>
          <Filters isList="true" count="0" />
          <Name>DataDataSource1</Name>
          <OddStyle>Style2</OddStyle>
          <Page isRef="5" />
          <Parent isRef="5" />
          <Sort isList="true" count="0" />
        </DataDataSource1>
      </Components>
      <Conditions isList="true" count="0" />
      <Guid>b5038a07cf30479186273efd5831a1a0</Guid>
      <Margins>0.39,0.39,0.39,0.39</Margins>
      <Name>Page1</Name>
      <PageHeight>11.69</PageHeight>
      <PageWidth>8.27</PageWidth>
      <PaperSize>A4</PaperSize>
      <Report isRef="0" />
      <Watermark Ref="23" type="Stimulsoft.Report.Components.StiWatermark" isKey="true">
        <Font>Arial,100</Font>
        <TextBrush>[50:0:0:0]</TextBrush>
      </Watermark>
    </Page1>
  </Pages>
  <PrinterSettings Ref="24" type="Stimulsoft.Report.Print.StiPrinterSettings" isKey="true" />
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
  <ReportChanged>6/17/2013 12:28:22 PM</ReportChanged>
  <ReportCreated>4/8/2013 9:34:50 AM</ReportCreated>
  <ReportFile>\\salavati1\Farhad Public\Rezaie\Iman Report\HozorReport\HozorReport.mrt</ReportFile>
  <ReportGuid>931c8e0e413c41bba6635f03e2a202e3</ReportGuid>
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
  <Styles isList="true" count="3">
    <Style1 Ref="25" type="Stimulsoft.Report.StiStyle" isKey="true">
      <Brush>Silver</Brush>
      <Conditions isList="true" count="0" />
      <Description />
      <Font>Arial,12,Bold,Point,False,0</Font>
      <Name>Style1</Name>
      <TextBrush>Black</TextBrush>
    </Style1>
    <Style2 Ref="26" type="Stimulsoft.Report.StiStyle" isKey="true">
      <Brush>[250:206:170]</Brush>
      <Conditions isList="true" count="0" />
      <Description />
      <Font>Arial,12,Regular,Point,False,0</Font>
      <Name>Style2</Name>
      <TextBrush>Black</TextBrush>
    </Style2>
    <Style3 Ref="27" type="Stimulsoft.Report.StiStyle" isKey="true">
      <Brush>[247:181:128]</Brush>
      <Conditions isList="true" count="0" />
      <Description />
      <Font>Arial,12,Bold,Point,False,0</Font>
      <Name>Style3</Name>
      <TextBrush>Black</TextBrush>
    </Style3>
  </Styles>
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
            (SELECT RptUIParameter_ID FROM TA_ReportUIParameter WHERE RptUIParameter_ActionId like N'ToDate_Implicit_StartOfYear_EndOfYear')
           ,'@toDate'
           ,(SELECT ReportFile_ID FROM TA_ReportFile WHERE ReportFile_Name = @ReportFile_Name)
           )
