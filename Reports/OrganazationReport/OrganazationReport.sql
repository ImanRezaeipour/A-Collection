--set quoted_identifier on

declare @ReportFile_Name nvarchar(max)
declare @Report_Name nvarchar(max)
declare @ReportFile_File nvarchar(max)
declare @Report_RootName nvarchar(max)=N'درخواستها'
-------------------------------------------------------------------------------------------------------------
set @ReportFile_Name=N'R4343A420'
set @Report_Name=N'گزارش پستهای سازمانی'
set @ReportFile_File=N'<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<StiSerializer version="1.02" type="Net" application="StiReport">
  <Dictionary Ref="1" type="Dictionary" isKey="true">
    <BusinessObjects isList="true" count="0" />
    <Databases isList="true" count="1">
      <Connection Ref="2" type="Stimulsoft.Report.Dictionary.StiSqlDatabase" isKey="true">
        <Alias>Connection</Alias>
        <ConnectionString>User ID=sa;Integrated Security=False;Password=123;Data Source=iman-pc;Initial Catalog=falatSlow</ConnectionString>
        <Name>Connection</Name>
      </Connection>
    </Databases>
    <DataSources isList="true" count="2">
      <TA_OrganizationUnit Ref="3" type="Stimulsoft.Report.Dictionary.StiSqlSource" isKey="true">
        <Alias>TA_OrganizationUnit</Alias>
        <Columns isList="true" count="5">
          <value>orgId,System.Decimal</value>
          <value>orgName,System.String</value>
          <value>org_ParenId,System.Decimal</value>
          <value>prsBarcode,System.String</value>
          <value>prsName,System.String</value>
        </Columns>
        <CommandTimeout>30</CommandTimeout>
        <Dictionary isRef="1" />
        <Name>TA_OrganizationUnit</Name>
        <NameInSource>Connection</NameInSource>
        <Parameters isList="true" count="0" />
        <SqlCommand>select	organ_id orgId,
		organ_Name orgName,
		organ_parentid org_ParenId,
(select Prs_Barcode from ta_person where prs_id=organ_personid) prsBarcode, 
(select Prs_FirstName+'' ''+Prs_LastName from ta_person where prs_id=organ_personid) as prsName
from TA_OrganizationUnit OrganizationUnit
</SqlCommand>
      </TA_OrganizationUnit>
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
      <Components isList="true" count="3">
        <phbMain Ref="6" type="PageHeaderBand" isKey="true">
          <Brush>Transparent</Brush>
          <ClientRectangle>0,0.2,7.72,0.71</ClientRectangle>
          <Components isList="true" count="5">
            <txtOrgDefName Ref="7" type="Text" isKey="true">
              <Brush>Transparent</Brush>
              <ClientRectangle>2.12,0,3.79,0.65</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Arial,24,Bold,Point,False,0</Font>
              <Guid>873c26c94e314fdd9b5d1e93fda43f22</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>txtOrgDefName</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{nameOrg.OrgDef_Name}
گزارش پست های سازمانی</Text>
              <TextBrush>Black</TextBrush>
              <TextOptions>HotkeyPrefix=None, LineLimit=False, RightToLeft=True, Trimming=None, WordWrap=False, Angle=0, FirstTabOffset=40, DistanceBetweenTabs=20,</TextOptions>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </txtOrgDefName>
            <txteportDate Ref="8" type="Text" isKey="true">
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
              <Guid>fa141fda805b4601b055046a2833262f</Guid>
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
              <ClientRectangle>1.18,0.24,0.79,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>5c983d2a25824905b02b4bd285b24034</Guid>
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
              <ClientRectangle>0,0,0.94,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>cca22a61419b4712a93a0e945711b435</Guid>
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
              <ClientRectangle>0,0.24,1.18,0.24</ClientRectangle>
              <Conditions isList="true" count="0" />
              <Font>Tahoma,8,Bold</Font>
              <Guid>f90eec04a24349e086b6caaa8a889741</Guid>
              <Margins>0,0,0,0</Margins>
              <Name>txtUserName</Name>
              <Page isRef="5" />
              <Parent isRef="6" />
              <Text>{ReportHelper.Instance().UserName}</Text>
              <TextBrush>[183:117:64]</TextBrush>
              <TextQuality>Wysiwyg</TextQuality>
              <VertAlignment>Center</VertAlignment>
            </txtUserName>
          </Components>
          <Conditions isList="true" count="0" />
          <Guid>446b90f4044246bdbd9eb10027e9648d</Guid>
          <Name>phbMain</Name>
          <Page isRef="5" />
          <Parent isRef="5" />
        </phbMain>
        <HeaderBand1 Ref="12" type="HeaderBand" isKey="true">
          <Brush>Transparent</Brush>
          <ClientRectangle>0,1.31,7.72,0.24</ClientRectangle>
          <Components isList="true" count="3">
            <Text10 Ref="13" type="Text" isKey="true">
              <Border>Top, Right, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Gainsboro</Brush>
              <ClientRectangle>5.75,0,1.97,0.24</ClientRectangle>
              <ComponentStyle>Header3</ComponentStyle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Bold,Point,False,0</Font>
              <Guid>825a6371bf41485d9907e75b856437b9</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text10</Name>
              <Page isRef="5" />
              <Parent isRef="12" />
              <Text>سمت</Text>
              <TextBrush>Black</TextBrush>
              <VertAlignment>Center</VertAlignment>
            </Text10>
            <Text12 Ref="14" type="Text" isKey="true">
              <Border>Top, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Gainsboro</Brush>
              <ClientRectangle>4.38,0,1.37,0.24</ClientRectangle>
              <ComponentStyle>Header3</ComponentStyle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Bold,Point,False,0</Font>
              <Guid>ced4462acf474c97a021c19269e48e69</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text12</Name>
              <Page isRef="5" />
              <Parent isRef="12" />
              <ShiftMode>DecreasingSize, OnlyInWidthOfComponent</ShiftMode>
              <Text>کد پرسنلی</Text>
              <TextBrush>Black</TextBrush>
              <VertAlignment>Center</VertAlignment>
            </Text12>
            <Text13 Ref="15" type="Text" isKey="true">
              <Border>Top, Left, Bottom;Black;1;Solid;False;4;Black</Border>
              <Brush>Gainsboro</Brush>
              <ClientRectangle>1.81,0,2.57,0.24</ClientRectangle>
              <ComponentStyle>Header3</ComponentStyle>
              <Conditions isList="true" count="0" />
              <Font>Arial,12,Bold,Point,False,0</Font>
              <Guid>03048862f6de4101b11a3d6da1cdea56</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text13</Name>
              <Page isRef="5" />
              <Parent isRef="12" />
              <Text>نام شخص</Text>
              <TextBrush>Black</TextBrush>
              <VertAlignment>Center</VertAlignment>
            </Text13>
          </Components>
          <Conditions isList="true" count="0" />
          <Guid>8415ea72a048422584922ec0d1b938ce</Guid>
          <Name>HeaderBand1</Name>
          <Page isRef="5" />
          <Parent isRef="5" />
          <PrintIfEmpty>True</PrintIfEmpty>
        </HeaderBand1>
        <HierarchicalBand1 Ref="16" type="Stimulsoft.Report.Components.StiHierarchicalBand" isKey="true">
          <Brush>Transparent</Brush>
          <BusinessObjectGuid isNull="true" />
          <ClientRectangle>0,1.95,7.72,0.24</ClientRectangle>
          <Components isList="true" count="3">
            <Text3 Ref="17" type="Text" isKey="true">
              <Border>All;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>5.75,0,1.97,0.24</ClientRectangle>
              <ComponentStyle>Data1</ComponentStyle>
              <Conditions isList="true" count="2">
                <value>_x007B__x0028_Line_x0020__x0026__x0020_1_x0029__x0020__x003D__x003D__x0020_1_x007D_,Red,White,Microsoft_x0020_Sans_x0020_Serif_x002C_8,True,False,,,None,BackColor</value>
                <value>_x007B__x0028_Line_x0020__x0026__x0020_1_x0029__x0020__x003D__x003D__x0020_0_x007D_,Red,Transparent,Microsoft_x0020_Sans_x0020_Serif_x002C_8,True,False,,Data2,None</value>
              </Conditions>
              <Font>Tahoma,8.25,Bold,Point,False,0</Font>
              <Guid>5aa4d513700f448ea381981eda9cd8cf</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text3</Name>
              <Page isRef="5" />
              <Parent isRef="16" />
              <Text>{TA_OrganizationUnit.orgName}</Text>
              <TextBrush>Black</TextBrush>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text3>
            <Text2 Ref="18" type="Text" isKey="true">
              <Border>All;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>4.38,0,1.37,0.24</ClientRectangle>
              <ComponentStyle>Data1</ComponentStyle>
              <Conditions isList="true" count="2">
                <value>_x007B__x0028_Line_x0020__x0026__x0020_1_x0029__x0020__x003D__x003D__x0020_1_x007D_,Red,White,Microsoft_x0020_Sans_x0020_Serif_x002C_8,True,False,,,None,BackColor</value>
                <value>_x007B__x0028_Line_x0020__x0026__x0020_1_x0029__x0020__x003D__x003D__x0020_0_x007D_,Red,Transparent,Microsoft_x0020_Sans_x0020_Serif_x002C_8,True,False,,Data2,None</value>
              </Conditions>
              <Font>Tahoma,8.25,Bold,Point,False,0</Font>
              <Guid>19a7dc3370614075b5021c49c1f2f2bc</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text2</Name>
              <Page isRef="5" />
              <Parent isRef="16" />
              <Text>{TA_OrganizationUnit.prsBarcode}</Text>
              <TextBrush>Black</TextBrush>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text2>
            <Text1 Ref="19" type="Text" isKey="true">
              <Border>All;Black;1;Solid;False;4;Black</Border>
              <Brush>Transparent</Brush>
              <ClientRectangle>1.81,0,2.57,0.24</ClientRectangle>
              <ComponentStyle>Data1</ComponentStyle>
              <Conditions isList="true" count="2">
                <value>_x007B__x0028_Line_x0020__x0026__x0020_1_x0029__x0020__x003D__x003D__x0020_1_x007D_,Red,White,Microsoft_x0020_Sans_x0020_Serif_x002C_8,True,False,,,None,BackColor</value>
                <value>_x007B__x0028_Line_x0020__x0026__x0020_1_x0029__x0020__x003D__x003D__x0020_0_x007D_,Red,Transparent,Microsoft_x0020_Sans_x0020_Serif_x002C_8,True,False,,Data2,None</value>
              </Conditions>
              <Font>Tahoma,8.25,Bold,Point,False,0</Font>
              <Guid>98d0ea07218e442aad3a04924f31a0a6</Guid>
              <HorAlignment>Center</HorAlignment>
              <Margins>0,0,0,0</Margins>
              <Name>Text1</Name>
              <Page isRef="5" />
              <Parent isRef="16" />
              <Text>{TA_OrganizationUnit.prsName}</Text>
              <TextBrush>Black</TextBrush>
              <Type>Expression</Type>
              <VertAlignment>Center</VertAlignment>
            </Text1>
          </Components>
          <Conditions isList="true" count="0" />
          <DataRelationName isNull="true" />
          <DataSourceName>TA_OrganizationUnit</DataSourceName>
          <Filters isList="true" count="0" />
          <Guid>1b74db192f1249b881ad6b4de40a8fa7</Guid>
          <Indent>-20</Indent>
          <KeyDataColumn>orgId</KeyDataColumn>
          <MasterKeyDataColumn>org_ParenId</MasterKeyDataColumn>
          <Name>HierarchicalBand1</Name>
          <Page isRef="5" />
          <Parent isRef="5" />
          <Sort isList="true" count="0" />
        </HierarchicalBand1>
      </Components>
      <Conditions isList="true" count="0" />
      <Guid>610aa0e5d905462992405e4511aa550a</Guid>
      <Margins>0.39,0.39,0.39,0.39</Margins>
      <Name>Page1</Name>
      <PageHeight>11</PageHeight>
      <PageWidth>8.5</PageWidth>
      <PaperSize>Letter</PaperSize>
      <Report isRef="0" />
      <Watermark Ref="20" type="Stimulsoft.Report.Components.StiWatermark" isKey="true">
        <Font>Arial,100</Font>
        <TextBrush>[50:0:0:0]</TextBrush>
      </Watermark>
    </Page1>
  </Pages>
  <PrinterSettings Ref="21" type="Stimulsoft.Report.Print.StiPrinterSettings" isKey="true" />
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
  <ReportChanged>4/10/2013 3:04:51 PM</ReportChanged>
  <ReportCreated>3/3/2013 6:19:11 PM</ReportCreated>
  <ReportFile>\\SALAVATI1\Farhad Public\Naghibi\Report\OrganazationReport\OrganazationReport.mrt</ReportFile>
  <ReportGuid>d269a9cddb5f49f3b298728d16ebd331</ReportGuid>
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
