USE [GhadirGTS]
GO
ALTER TABLE [dbo].[CL_PersonOffish] DROP CONSTRAINT [FK_CL_PersonOffish_CL_Offish]
GO
ALTER TABLE [dbo].[CL_PersonOffish] DROP CONSTRAINT [FK_CL_PersonOffish_CL_ClientelePerson]
GO
ALTER TABLE [dbo].[CL_PersonCLSpec] DROP CONSTRAINT [FK_CL_PersonCLSpec_TA_UIValidationGroup]
GO
ALTER TABLE [dbo].[CL_PersonCLSpec] DROP CONSTRAINT [FK_CL_PersonCLSpec_TA_ControlStation]
GO
ALTER TABLE [dbo].[CL_PersonCLSpec] DROP CONSTRAINT [FK_CL_PersonCLSpec_CL_DepartmentPosition]
GO
ALTER TABLE [dbo].[CL_Offish] DROP CONSTRAINT [FK_CL_Offish_TA_SubstituePerson]
GO
ALTER TABLE [dbo].[CL_Offish] DROP CONSTRAINT [FK_CL_Offish_TA_Person]
GO
ALTER TABLE [dbo].[CL_Offish] DROP CONSTRAINT [FK_CL_Offish_TA_ControlStation]
GO
ALTER TABLE [dbo].[CL_Offish] DROP CONSTRAINT [FK_CL_Offish_CL_OffishType]
GO
ALTER TABLE [dbo].[CL_EquipmentBlackListDepartments] DROP CONSTRAINT [FK_CL_EquipmentBlackListDepartments_TA_Department]
GO
ALTER TABLE [dbo].[CL_EquipmentBlackListDepartments] DROP CONSTRAINT [FK_CL_EquipmentBlackListDepartments_CL_EquipmentBlackList]
GO
ALTER TABLE [dbo].[CL_Equipment] DROP CONSTRAINT [FK_CL_Equipment_CL_Offish]
GO
ALTER TABLE [dbo].[CL_Equipment] DROP CONSTRAINT [FK_CL_Equipment_CL_EquipmentType]
GO
ALTER TABLE [dbo].[CL_Equipment] DROP CONSTRAINT [FK_CL_Equipment_CL_Contractor]
GO
ALTER TABLE [dbo].[CL_DynamicInformationSettingValue] DROP CONSTRAINT [FK_CL_DynamicInformationSettingValue_CL_DynamicInformationSettingValue]
GO
ALTER TABLE [dbo].[CL_DynamicInformationSettingTypeValue] DROP CONSTRAINT [FK_CL_DynamicInformationSettingTypeValue_CL_DynamicInformationSetting]
GO
ALTER TABLE [dbo].[CL_Contractor] DROP CONSTRAINT [FK_CL_Contractor_TA_Person]
GO
ALTER TABLE [dbo].[CL_ClientelePerson] DROP CONSTRAINT [FK_CL_ClientelePerson_CL_Contractor]
GO
ALTER TABLE [dbo].[CL_ClienteleBlackList] DROP CONSTRAINT [FK_CL_ClienteleBlackList_CL_ClientelePerson]
GO
ALTER TABLE [dbo].[CL_Car] DROP CONSTRAINT [FK_CL_Car_CL_Offish]
GO
ALTER TABLE [dbo].[CL_Car] DROP CONSTRAINT [FK_CL_Car_CL_Contractor]
GO
ALTER TABLE [dbo].[CL_Offish] DROP CONSTRAINT [DF__CL_Offish__offis__7D2797DF]
GO
ALTER TABLE [dbo].[CL_Contractor] DROP CONSTRAINT [DF_CL_Contractor_contractor_CreationDate]
GO
/****** Object:  Table [dbo].[CL_PersonOffish]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_PersonOffish]
GO
/****** Object:  Table [dbo].[CL_PersonCLSpec]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_PersonCLSpec]
GO
/****** Object:  Table [dbo].[CL_OffishType]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_OffishType]
GO
/****** Object:  Table [dbo].[CL_Offish]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_Offish]
GO
/****** Object:  Table [dbo].[CL_EquipmentType]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_EquipmentType]
GO
/****** Object:  Table [dbo].[CL_EquipmentBlackListDepartments]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_EquipmentBlackListDepartments]
GO
/****** Object:  Table [dbo].[CL_EquipmentBlackList]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_EquipmentBlackList]
GO
/****** Object:  Table [dbo].[CL_Equipment]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_Equipment]
GO
/****** Object:  Table [dbo].[CL_DynamicInformationSettingValue]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_DynamicInformationSettingValue]
GO
/****** Object:  Table [dbo].[CL_DynamicInformationSettingTypeValue]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_DynamicInformationSettingTypeValue]
GO
/****** Object:  Table [dbo].[CL_DynamicInformationSetting]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_DynamicInformationSetting]
GO
/****** Object:  Table [dbo].[CL_DepartmentPosition]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_DepartmentPosition]
GO
/****** Object:  Table [dbo].[CL_Contractor]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_Contractor]
GO
/****** Object:  Table [dbo].[CL_ClientelePerson]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_ClientelePerson]
GO
/****** Object:  Table [dbo].[CL_ClienteleBlackList]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_ClienteleBlackList]
GO
/****** Object:  Table [dbo].[CL_Car]    Script Date: 12/4/2013 4:32:13 PM ******/
DROP TABLE [dbo].[CL_Car]
GO
/****** Object:  Table [dbo].[CL_Car]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_Car](
	[car_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[car_Deleted] [bit] NOT NULL,
	[Car_Name] [nvarchar](200) NULL,
	[Car_CustomCode] [nvarchar](50) NULL,
	[Car_Driver] [nvarchar](200) NULL,
	[Car_Color] [nvarchar](100) NULL,
	[Car_Description] [nvarchar](max) NULL,
	[Car_ContractorId] [numeric](18, 0) NOT NULL,
	[Car_OffishId] [numeric](18, 0) NULL,
 CONSTRAINT [PK_CL_Car] PRIMARY KEY CLUSTERED 
(
	[car_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_ClienteleBlackList]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_ClienteleBlackList](
	[cbl_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[cbl_Deleted] [bit] NOT NULL,
	[cbl_ClientelePersonId] [numeric](18, 0) NOT NULL,
	[cbl_Description] [nvarchar](max) NULL,
	[cbl_TemporarilyOutOfList] [bit] NOT NULL,
	[cbl_AddDate] [datetime] NOT NULL,
	[cbl_FromDate] [datetime] NULL,
	[cbl_ToDate] [datetime] NULL,
 CONSTRAINT [PK_CL_ClienteleBlackList] PRIMARY KEY CLUSTERED 
(
	[cbl_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_ClientelePerson]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_ClientelePerson](
	[clientelePrs_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[clientelePrs_ContractorId] [numeric](18, 0) NULL,
	[clientelePrs_Deleted] [bit] NOT NULL,
	[clientelePrs_Name] [nvarchar](200) NULL,
	[clientelePrs_MeliCode] [nvarchar](50) NULL,
	[clientelePrs_Post] [nvarchar](200) NULL,
	[clientelePrs_TrafficCode] [nvarchar](200) NULL,
	[clientelePrs_Description] [nvarchar](max) NULL,
	[clientelePrs_Image] [nvarchar](max) NULL,
	[clientelePrs_Tel1] [nvarchar](200) NULL,
	[clientelePrs_Tel2] [nvarchar](200) NULL,
	[clientelePrs_Tel3] [nvarchar](200) NULL,
	[clientelePrs_Email] [nvarchar](200) NULL,
	[clientelePrs_Address] [nvarchar](max) NULL,
	[clientelePrs_OffishID] [numeric](18, 0) NULL,
	[clientelePrs_Sex] [int] NULL,
 CONSTRAINT [PK_CL_ClientelePerson] PRIMARY KEY CLUSTERED 
(
	[clientelePrs_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_Contractor]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CL_Contractor](
	[contractor_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[contractor_Deleted] [bit] NOT NULL,
	[contractor_CustomCode] [nvarchar](200) NULL,
	[contractor_Name] [nvarchar](200) NULL,
	[contractor_WorkField] [nvarchar](200) NULL,
	[contractor_ContactNumber] [nvarchar](200) NULL,
	[contractor_WorkerCount] [int] NULL,
	[contractor_InternetAccess] [bit] NULL,
	[contractor_Description] [nvarchar](max) NULL,
	[contractor_FromDate] [datetime] NULL,
	[contractor_ToDate] [datetime] NULL,
	[contractor_FromTime] [int] NULL,
	[contractor_ToTime] [int] NULL,
	[contractor_DaysOfWeek] [varchar](200) NULL,
	[contractor_Image] [nvarchar](max) NULL,
	[contractor_Position] [nvarchar](200) NULL,
	[contractor_CreationDate] [datetime] NOT NULL,
	[contractor_MeetingPersonId] [numeric](18, 0) NULL,
 CONSTRAINT [PK_CL_Clientele] PRIMARY KEY CLUSTERED 
(
	[contractor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CL_DepartmentPosition]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_DepartmentPosition](
	[pos_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[pos_UnitName] [nvarchar](max) NULL,
	[pos_Location] [nvarchar](max) NULL,
	[pos_DepartmentId] [numeric](18, 0) NULL,
 CONSTRAINT [PK_TA_DepartmentPosition] PRIMARY KEY CLUSTERED 
(
	[pos_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_DynamicInformationSetting]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_DynamicInformationSetting](
	[DynInfoSetting_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DynInfoSetting_ControlType] [int] NOT NULL,
	[DynInfoSetting_ControlCaption] [nvarchar](100) NOT NULL,
	[DynInfoSetting_ReferredType] [int] NOT NULL,
	[DynInfoSetting_Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_CL_DynamicInformationSetting] PRIMARY KEY CLUSTERED 
(
	[DynInfoSetting_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_DynamicInformationSettingTypeValue]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_DynamicInformationSettingTypeValue](
	[DynInfoSettingTypeValue_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DynInfoSettingTypeValue_DynInfoSettingID] [numeric](18, 0) NOT NULL,
	[DynInfoSettingTypeValue_TypeID] [numeric](18, 0) NOT NULL,
	[DynInfoSettingTypeValue_Value] [nvarchar](100) NOT NULL,
	[DynInfoSettingTypeValue_Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_CL_DynamicInformationSettingTypeValue] PRIMARY KEY CLUSTERED 
(
	[DynInfoSettingTypeValue_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_DynamicInformationSettingValue]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_DynamicInformationSettingValue](
	[DynInfoSettingValue_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DynInfoSettingValue_DynInfoSettingID] [numeric](18, 0) NOT NULL,
	[DynInfoSettingValue_Value] [nvarchar](100) NOT NULL,
	[DynInfoSettingValue_Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_CL_DynamicInformationSettingValue] PRIMARY KEY CLUSTERED 
(
	[DynInfoSettingValue_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_Equipment]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_Equipment](
	[Eqp_EquipmentTypeId] [numeric](18, 0) NULL,
	[Eqp_ContractorId] [numeric](18, 0) NOT NULL,
	[Eqp_Deleted] [bit] NOT NULL,
	[Eqp_Name] [nvarchar](200) NULL,
	[Eqp_CustomCode] [nvarchar](50) NULL,
	[Eqp_Carrier] [nvarchar](200) NULL,
	[Eqp_Count] [int] NULL,
	[Eqp_Description] [nvarchar](max) NULL,
	[Eqp_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Eqp_OffishId] [numeric](18, 0) NULL,
 CONSTRAINT [PK_CL_Equipment] PRIMARY KEY CLUSTERED 
(
	[Eqp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_EquipmentBlackList]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_EquipmentBlackList](
	[EqpBl_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[EqpBl_Deleted] [bit] NOT NULL,
	[EqpBl_Name] [nvarchar](200) NOT NULL,
	[EqpBl_Description] [nvarchar](max) NULL,
	[EqpBl_CustomCode] [nvarchar](50) NULL,
	[EqpBl_FromDate] [datetime] NULL,
	[EqpBl_ToDate] [datetime] NULL,
 CONSTRAINT [PK_CL_EquipmentBlackList] PRIMARY KEY CLUSTERED 
(
	[EqpBl_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_EquipmentBlackListDepartments]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_EquipmentBlackListDepartments](
	[blDep_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[blDep_DepId] [numeric](18, 0) NOT NULL,
	[blDep_EquipmentBlackListId] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_CL_EquipmentBlackListDepartments] PRIMARY KEY CLUSTERED 
(
	[blDep_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_EquipmentType]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CL_EquipmentType](
	[EqpType_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[EqpType_Deleted] [bit] NULL,
	[EqpType_Name] [nvarchar](200) NULL,
	[EqpType_CustomCode] [varchar](50) NULL,
 CONSTRAINT [PK_CL_EquipmentType] PRIMARY KEY CLUSTERED 
(
	[EqpType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CL_Offish]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_Offish](
	[offish_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[offish_departmentId] [numeric](18, 0) NULL,
	[offish_FromDate] [datetime] NULL,
	[offish_ToDate] [datetime] NULL,
	[offish_FromTime] [int] NULL,
	[offish_ToTime] [int] NULL,
	[offish_ActiveDirectory] [bit] NULL,
	[offish_InternetAccess] [bit] NULL,
	[offish_Description] [nvarchar](max) NULL,
	[offish_Active] [bit] NULL,
	[offish_Deleted] [bit] NULL,
	[offish_Sex] [bit] NULL,
	[offish_MeetingLocation] [nvarchar](max) NULL,
	[offish_FoodRecieve] [bit] NULL,
	[offish_Attachment] [nvarchar](max) NULL,
	[offish_ActiveDirectoryUserName] [bit] NULL,
	[offish_ControlStationId] [numeric](18, 0) NULL,
	[offish_SubstituteMeetingPersonId] [numeric](18, 0) NULL,
	[offish_CreationDate] [datetime] NOT NULL,
	[offish_CustomCode] [nvarchar](200) NULL,
	[offish_offishTypeId] [numeric](18, 0) NULL,
	[offish_MeetingPersonId] [numeric](18, 0) NULL,
 CONSTRAINT [PK_CL_Offish] PRIMARY KEY CLUSTERED 
(
	[offish_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_OffishType]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_OffishType](
	[offishType_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[offishType_Title] [nvarchar](200) NOT NULL,
	[offishType_CustomCode] [nvarchar](200) NOT NULL,
	[offishType_Active] [bit] NOT NULL,
	[offishType_Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_CL_OffishType] PRIMARY KEY CLUSTERED 
(
	[offishType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_PersonCLSpec]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_PersonCLSpec](
	[prsCL_ID] [numeric](18, 0) NOT NULL,
	[prsCL_ControlStationId] [numeric](18, 0) NULL,
	[prsCL_Active] [bit] NULL,
	[prsCL_UIValidationGroupID] [numeric](18, 0) NULL,
	[PrsCL_DepartmentPositionId] [numeric](18, 0) NULL,
	[prsCL_R1] [nvarchar](50) NULL,
	[prsCL_R2] [nvarchar](50) NULL,
	[prsCL_R3] [nvarchar](50) NULL,
	[prsCL_R4] [nvarchar](50) NULL,
	[prsCL_R5] [nvarchar](50) NULL,
	[prsCL_R6] [nvarchar](50) NULL,
	[prsCL_R7] [nvarchar](50) NULL,
	[prsCL_R8] [nvarchar](50) NULL,
	[prsCL_R9] [nvarchar](50) NULL,
	[prsCL_R10] [nvarchar](50) NULL,
	[prsCL_R11] [nvarchar](50) NULL,
	[prsCL_R12] [nvarchar](50) NULL,
	[prsCL_R13] [nvarchar](50) NULL,
	[prsCL_R14] [nvarchar](50) NULL,
	[prsCL_R15] [nvarchar](50) NULL,
	[prsCL_R16] [numeric](18, 0) NULL,
	[prsCL_R17] [numeric](18, 0) NULL,
	[prsCL_R18] [numeric](18, 0) NULL,
	[prsCL_R19] [numeric](18, 0) NULL,
	[prsCL_R20] [numeric](18, 0) NULL,
 CONSTRAINT [PK_TA_PersonCLSpec] PRIMARY KEY CLUSTERED 
(
	[prsCL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CL_PersonOffish]    Script Date: 12/4/2013 4:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CL_PersonOffish](
	[prsOffish_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[prsOffish_PersonId] [numeric](18, 0) NOT NULL,
	[prsOffish_OffishId] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_CL_PersonOffish] PRIMARY KEY CLUSTERED 
(
	[prsOffish_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[CL_Car] ON 

INSERT [dbo].[CL_Car] ([car_ID], [car_Deleted], [Car_Name], [Car_CustomCode], [Car_Driver], [Car_Color], [Car_Description], [Car_ContractorId], [Car_OffishId]) VALUES (CAST(1 AS Numeric(18, 0)), 0, N'cont1auto1', N'9879768865', N'', N'', N'', CAST(15 AS Numeric(18, 0)), NULL)
INSERT [dbo].[CL_Car] ([car_ID], [car_Deleted], [Car_Name], [Car_CustomCode], [Car_Driver], [Car_Color], [Car_Description], [Car_ContractorId], [Car_OffishId]) VALUES (CAST(2 AS Numeric(18, 0)), 0, N'cont1auto2', N'098786756435', N'', N'', N'', CAST(15 AS Numeric(18, 0)), NULL)
SET IDENTITY_INSERT [dbo].[CL_Car] OFF
SET IDENTITY_INSERT [dbo].[CL_ClienteleBlackList] ON 

INSERT [dbo].[CL_ClienteleBlackList] ([cbl_ID], [cbl_Deleted], [cbl_ClientelePersonId], [cbl_Description], [cbl_TemporarilyOutOfList], [cbl_AddDate], [cbl_FromDate], [cbl_ToDate]) VALUES (CAST(1 AS Numeric(18, 0)), 0, CAST(6 AS Numeric(18, 0)), N'', 0, CAST(0x0000A27F0103482C AS DateTime), CAST(0x0000A27F00000000 AS DateTime), CAST(0x0000A29B00000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[CL_ClienteleBlackList] OFF
SET IDENTITY_INSERT [dbo].[CL_ClientelePerson] ON 

INSERT [dbo].[CL_ClientelePerson] ([clientelePrs_ID], [clientelePrs_ContractorId], [clientelePrs_Deleted], [clientelePrs_Name], [clientelePrs_MeliCode], [clientelePrs_Post], [clientelePrs_TrafficCode], [clientelePrs_Description], [clientelePrs_Image], [clientelePrs_Tel1], [clientelePrs_Tel2], [clientelePrs_Tel3], [clientelePrs_Email], [clientelePrs_Address], [clientelePrs_OffishID], [clientelePrs_Sex]) VALUES (CAST(4 AS Numeric(18, 0)), CAST(15 AS Numeric(18, 0)), 0, N'cont1p1', N'9879876876', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', NULL, NULL)
INSERT [dbo].[CL_ClientelePerson] ([clientelePrs_ID], [clientelePrs_ContractorId], [clientelePrs_Deleted], [clientelePrs_Name], [clientelePrs_MeliCode], [clientelePrs_Post], [clientelePrs_TrafficCode], [clientelePrs_Description], [clientelePrs_Image], [clientelePrs_Tel1], [clientelePrs_Tel2], [clientelePrs_Tel3], [clientelePrs_Email], [clientelePrs_Address], [clientelePrs_OffishID], [clientelePrs_Sex]) VALUES (CAST(5 AS Numeric(18, 0)), CAST(15 AS Numeric(18, 0)), 0, N'cont1p2', N'', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', NULL, NULL)
INSERT [dbo].[CL_ClientelePerson] ([clientelePrs_ID], [clientelePrs_ContractorId], [clientelePrs_Deleted], [clientelePrs_Name], [clientelePrs_MeliCode], [clientelePrs_Post], [clientelePrs_TrafficCode], [clientelePrs_Description], [clientelePrs_Image], [clientelePrs_Tel1], [clientelePrs_Tel2], [clientelePrs_Tel3], [clientelePrs_Email], [clientelePrs_Address], [clientelePrs_OffishID], [clientelePrs_Sex]) VALUES (CAST(6 AS Numeric(18, 0)), NULL, 0, N'p1', N'099878', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', NULL, NULL)
INSERT [dbo].[CL_ClientelePerson] ([clientelePrs_ID], [clientelePrs_ContractorId], [clientelePrs_Deleted], [clientelePrs_Name], [clientelePrs_MeliCode], [clientelePrs_Post], [clientelePrs_TrafficCode], [clientelePrs_Description], [clientelePrs_Image], [clientelePrs_Tel1], [clientelePrs_Tel2], [clientelePrs_Tel3], [clientelePrs_Email], [clientelePrs_Address], [clientelePrs_OffishID], [clientelePrs_Sex]) VALUES (CAST(7 AS Numeric(18, 0)), NULL, 0, N'p2', N'0786576545678', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', NULL, NULL)
SET IDENTITY_INSERT [dbo].[CL_ClientelePerson] OFF
SET IDENTITY_INSERT [dbo].[CL_Contractor] ON 

INSERT [dbo].[CL_Contractor] ([contractor_ID], [contractor_Deleted], [contractor_CustomCode], [contractor_Name], [contractor_WorkField], [contractor_ContactNumber], [contractor_WorkerCount], [contractor_InternetAccess], [contractor_Description], [contractor_FromDate], [contractor_ToDate], [contractor_FromTime], [contractor_ToTime], [contractor_DaysOfWeek], [contractor_Image], [contractor_Position], [contractor_CreationDate], [contractor_MeetingPersonId]) VALUES (CAST(15 AS Numeric(18, 0)), 0, NULL, N'cont1', N'f1', N'987987', 0, 0, N'desc1', CAST(0x0000A27F00000000 AS DateTime), CAST(0x0000A28100000000 AS DateTime), 240, 480, N'{"Day1":"true","Day2":"false","Day3":"true","Day4":"false","Day5":"false","Day6":"false","Day7":"false"}', N'30483640-0115-45a4-a4ab-05e34aa19806_32682_exit.png', N'loc1', CAST(0x0000A27F00F24BCA AS DateTime), CAST(354 AS Numeric(18, 0)))
SET IDENTITY_INSERT [dbo].[CL_Contractor] OFF
SET IDENTITY_INSERT [dbo].[CL_Equipment] ON 

INSERT [dbo].[CL_Equipment] ([Eqp_EquipmentTypeId], [Eqp_ContractorId], [Eqp_Deleted], [Eqp_Name], [Eqp_CustomCode], [Eqp_Carrier], [Eqp_Count], [Eqp_Description], [Eqp_ID], [Eqp_OffishId]) VALUES (CAST(1 AS Numeric(18, 0)), CAST(15 AS Numeric(18, 0)), 0, N'cont1eq1', N'', N'', 0, N'', CAST(1 AS Numeric(18, 0)), NULL)
INSERT [dbo].[CL_Equipment] ([Eqp_EquipmentTypeId], [Eqp_ContractorId], [Eqp_Deleted], [Eqp_Name], [Eqp_CustomCode], [Eqp_Carrier], [Eqp_Count], [Eqp_Description], [Eqp_ID], [Eqp_OffishId]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(15 AS Numeric(18, 0)), 0, N'cont1eq2', N'', N'', 0, N'', CAST(2 AS Numeric(18, 0)), NULL)
SET IDENTITY_INSERT [dbo].[CL_Equipment] OFF
SET IDENTITY_INSERT [dbo].[CL_EquipmentBlackList] ON 

INSERT [dbo].[CL_EquipmentBlackList] ([EqpBl_ID], [EqpBl_Deleted], [EqpBl_Name], [EqpBl_Description], [EqpBl_CustomCode], [EqpBl_FromDate], [EqpBl_ToDate]) VALUES (CAST(1 AS Numeric(18, 0)), 0, N'eq1', N'desc1', N'vhhg8867', CAST(0x0000A27F00000000 AS DateTime), CAST(0x0000A28900000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[CL_EquipmentBlackList] OFF
SET IDENTITY_INSERT [dbo].[CL_EquipmentBlackListDepartments] ON 

INSERT [dbo].[CL_EquipmentBlackListDepartments] ([blDep_ID], [blDep_DepId], [blDep_EquipmentBlackListId]) VALUES (CAST(1 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)))
INSERT [dbo].[CL_EquipmentBlackListDepartments] ([blDep_ID], [blDep_DepId], [blDep_EquipmentBlackListId]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(13 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)))
SET IDENTITY_INSERT [dbo].[CL_EquipmentBlackListDepartments] OFF
SET IDENTITY_INSERT [dbo].[CL_EquipmentType] ON 

INSERT [dbo].[CL_EquipmentType] ([EqpType_ID], [EqpType_Deleted], [EqpType_Name], [EqpType_CustomCode]) VALUES (CAST(1 AS Numeric(18, 0)), 0, N'نوع 1', N'001')
INSERT [dbo].[CL_EquipmentType] ([EqpType_ID], [EqpType_Deleted], [EqpType_Name], [EqpType_CustomCode]) VALUES (CAST(2 AS Numeric(18, 0)), 0, N'نوع 2', N'002')
INSERT [dbo].[CL_EquipmentType] ([EqpType_ID], [EqpType_Deleted], [EqpType_Name], [EqpType_CustomCode]) VALUES (CAST(3 AS Numeric(18, 0)), 0, N'نوع 3', N'003')
SET IDENTITY_INSERT [dbo].[CL_EquipmentType] OFF
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(347 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(348 AS Numeric(18, 0)), NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(349 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(350 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(351 AS Numeric(18, 0)), NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(352 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(353 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(354 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(355 AS Numeric(18, 0)), NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(356 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(357 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(358 AS Numeric(18, 0)), NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(359 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(360 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(361 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(362 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(363 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(364 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(365 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(366 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(367 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(368 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(369 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(370 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(371 AS Numeric(18, 0)), NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(372 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(373 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(374 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(375 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(376 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(377 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(378 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(379 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(380 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(381 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(382 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(383 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(384 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(385 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(386 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(387 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(388 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(389 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(390 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(391 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(392 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(393 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(394 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(395 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(396 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(397 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(398 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(399 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(400 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(401 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(402 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(403 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(404 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(405 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(406 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(407 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(408 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(409 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(410 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(411 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(412 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(413 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(414 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(415 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(416 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(417 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(418 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(419 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(420 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(421 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(422 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(423 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(424 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(425 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(426 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(427 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(428 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(429 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(430 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(431 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(432 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(433 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(434 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(435 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(436 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(437 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(438 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(439 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(440 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(441 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(442 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(443 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(444 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(445 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(446 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(447 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(448 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(449 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(450 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(451 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(452 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(453 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(454 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(455 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(456 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(457 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(458 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(459 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(460 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(461 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(462 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(463 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(464 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(465 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(466 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(467 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(468 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(469 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(470 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(471 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(472 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(473 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(474 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(475 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(476 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(477 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(478 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(479 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(480 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(481 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(482 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(483 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(484 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(485 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(486 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(487 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(488 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(489 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(490 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(491 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(492 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(493 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(494 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(495 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(496 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(497 AS Numeric(18, 0)), NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(498 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(499 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(500 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(501 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(502 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(503 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(504 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(505 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(506 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(507 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(508 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(509 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(510 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(511 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(512 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(513 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(514 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(515 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(516 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CL_PersonCLSpec] ([prsCL_ID], [prsCL_ControlStationId], [prsCL_Active], [prsCL_UIValidationGroupID], [PrsCL_DepartmentPositionId], [prsCL_R1], [prsCL_R2], [prsCL_R3], [prsCL_R4], [prsCL_R5], [prsCL_R6], [prsCL_R7], [prsCL_R8], [prsCL_R9], [prsCL_R10], [prsCL_R11], [prsCL_R12], [prsCL_R13], [prsCL_R14], [prsCL_R15], [prsCL_R16], [prsCL_R17], [prsCL_R18], [prsCL_R19], [prsCL_R20]) VALUES (CAST(32682 AS Numeric(18, 0)), CAST(32549 AS Numeric(18, 0)), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
ALTER TABLE [dbo].[CL_Contractor] ADD  CONSTRAINT [DF_CL_Contractor_contractor_CreationDate]  DEFAULT (getdate()) FOR [contractor_CreationDate]
GO
ALTER TABLE [dbo].[CL_Offish] ADD  DEFAULT (getdate()) FOR [offish_CreationDate]
GO
ALTER TABLE [dbo].[CL_Car]  WITH CHECK ADD  CONSTRAINT [FK_CL_Car_CL_Contractor] FOREIGN KEY([Car_ContractorId])
REFERENCES [dbo].[CL_Contractor] ([contractor_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CL_Car] CHECK CONSTRAINT [FK_CL_Car_CL_Contractor]
GO
ALTER TABLE [dbo].[CL_Car]  WITH CHECK ADD  CONSTRAINT [FK_CL_Car_CL_Offish] FOREIGN KEY([Car_OffishId])
REFERENCES [dbo].[CL_Offish] ([offish_ID])
GO
ALTER TABLE [dbo].[CL_Car] CHECK CONSTRAINT [FK_CL_Car_CL_Offish]
GO
ALTER TABLE [dbo].[CL_ClienteleBlackList]  WITH CHECK ADD  CONSTRAINT [FK_CL_ClienteleBlackList_CL_ClientelePerson] FOREIGN KEY([cbl_ClientelePersonId])
REFERENCES [dbo].[CL_ClientelePerson] ([clientelePrs_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CL_ClienteleBlackList] CHECK CONSTRAINT [FK_CL_ClienteleBlackList_CL_ClientelePerson]
GO
ALTER TABLE [dbo].[CL_ClientelePerson]  WITH CHECK ADD  CONSTRAINT [FK_CL_ClientelePerson_CL_Contractor] FOREIGN KEY([clientelePrs_ContractorId])
REFERENCES [dbo].[CL_Contractor] ([contractor_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CL_ClientelePerson] CHECK CONSTRAINT [FK_CL_ClientelePerson_CL_Contractor]
GO
ALTER TABLE [dbo].[CL_Contractor]  WITH CHECK ADD  CONSTRAINT [FK_CL_Contractor_TA_Person] FOREIGN KEY([contractor_MeetingPersonId])
REFERENCES [dbo].[TA_Person] ([Prs_ID])
GO
ALTER TABLE [dbo].[CL_Contractor] CHECK CONSTRAINT [FK_CL_Contractor_TA_Person]
GO
ALTER TABLE [dbo].[CL_DynamicInformationSettingTypeValue]  WITH CHECK ADD  CONSTRAINT [FK_CL_DynamicInformationSettingTypeValue_CL_DynamicInformationSetting] FOREIGN KEY([DynInfoSettingTypeValue_DynInfoSettingID])
REFERENCES [dbo].[CL_DynamicInformationSetting] ([DynInfoSetting_ID])
GO
ALTER TABLE [dbo].[CL_DynamicInformationSettingTypeValue] CHECK CONSTRAINT [FK_CL_DynamicInformationSettingTypeValue_CL_DynamicInformationSetting]
GO
ALTER TABLE [dbo].[CL_DynamicInformationSettingValue]  WITH CHECK ADD  CONSTRAINT [FK_CL_DynamicInformationSettingValue_CL_DynamicInformationSettingValue] FOREIGN KEY([DynInfoSettingValue_DynInfoSettingID])
REFERENCES [dbo].[CL_DynamicInformationSetting] ([DynInfoSetting_ID])
GO
ALTER TABLE [dbo].[CL_DynamicInformationSettingValue] CHECK CONSTRAINT [FK_CL_DynamicInformationSettingValue_CL_DynamicInformationSettingValue]
GO
ALTER TABLE [dbo].[CL_Equipment]  WITH CHECK ADD  CONSTRAINT [FK_CL_Equipment_CL_Contractor] FOREIGN KEY([Eqp_ContractorId])
REFERENCES [dbo].[CL_Contractor] ([contractor_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CL_Equipment] CHECK CONSTRAINT [FK_CL_Equipment_CL_Contractor]
GO
ALTER TABLE [dbo].[CL_Equipment]  WITH CHECK ADD  CONSTRAINT [FK_CL_Equipment_CL_EquipmentType] FOREIGN KEY([Eqp_EquipmentTypeId])
REFERENCES [dbo].[CL_EquipmentType] ([EqpType_ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[CL_Equipment] CHECK CONSTRAINT [FK_CL_Equipment_CL_EquipmentType]
GO
ALTER TABLE [dbo].[CL_Equipment]  WITH CHECK ADD  CONSTRAINT [FK_CL_Equipment_CL_Offish] FOREIGN KEY([Eqp_OffishId])
REFERENCES [dbo].[CL_Offish] ([offish_ID])
GO
ALTER TABLE [dbo].[CL_Equipment] CHECK CONSTRAINT [FK_CL_Equipment_CL_Offish]
GO
ALTER TABLE [dbo].[CL_EquipmentBlackListDepartments]  WITH CHECK ADD  CONSTRAINT [FK_CL_EquipmentBlackListDepartments_CL_EquipmentBlackList] FOREIGN KEY([blDep_EquipmentBlackListId])
REFERENCES [dbo].[CL_EquipmentBlackList] ([EqpBl_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CL_EquipmentBlackListDepartments] CHECK CONSTRAINT [FK_CL_EquipmentBlackListDepartments_CL_EquipmentBlackList]
GO
ALTER TABLE [dbo].[CL_EquipmentBlackListDepartments]  WITH CHECK ADD  CONSTRAINT [FK_CL_EquipmentBlackListDepartments_TA_Department] FOREIGN KEY([blDep_DepId])
REFERENCES [dbo].[TA_Department] ([dep_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CL_EquipmentBlackListDepartments] CHECK CONSTRAINT [FK_CL_EquipmentBlackListDepartments_TA_Department]
GO
ALTER TABLE [dbo].[CL_Offish]  WITH CHECK ADD  CONSTRAINT [FK_CL_Offish_CL_OffishType] FOREIGN KEY([offish_offishTypeId])
REFERENCES [dbo].[CL_OffishType] ([offishType_ID])
GO
ALTER TABLE [dbo].[CL_Offish] CHECK CONSTRAINT [FK_CL_Offish_CL_OffishType]
GO
ALTER TABLE [dbo].[CL_Offish]  WITH CHECK ADD  CONSTRAINT [FK_CL_Offish_TA_ControlStation] FOREIGN KEY([offish_ControlStationId])
REFERENCES [dbo].[TA_ControlStation] ([Station_ID])
GO
ALTER TABLE [dbo].[CL_Offish] CHECK CONSTRAINT [FK_CL_Offish_TA_ControlStation]
GO
ALTER TABLE [dbo].[CL_Offish]  WITH CHECK ADD  CONSTRAINT [FK_CL_Offish_TA_Person] FOREIGN KEY([offish_MeetingPersonId])
REFERENCES [dbo].[TA_Person] ([Prs_ID])
GO
ALTER TABLE [dbo].[CL_Offish] CHECK CONSTRAINT [FK_CL_Offish_TA_Person]
GO
ALTER TABLE [dbo].[CL_Offish]  WITH CHECK ADD  CONSTRAINT [FK_CL_Offish_TA_SubstituePerson] FOREIGN KEY([offish_SubstituteMeetingPersonId])
REFERENCES [dbo].[TA_Person] ([Prs_ID])
GO
ALTER TABLE [dbo].[CL_Offish] CHECK CONSTRAINT [FK_CL_Offish_TA_SubstituePerson]
GO
ALTER TABLE [dbo].[CL_PersonCLSpec]  WITH CHECK ADD  CONSTRAINT [FK_CL_PersonCLSpec_CL_DepartmentPosition] FOREIGN KEY([PrsCL_DepartmentPositionId])
REFERENCES [dbo].[CL_DepartmentPosition] ([pos_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CL_PersonCLSpec] CHECK CONSTRAINT [FK_CL_PersonCLSpec_CL_DepartmentPosition]
GO
ALTER TABLE [dbo].[CL_PersonCLSpec]  WITH CHECK ADD  CONSTRAINT [FK_CL_PersonCLSpec_TA_ControlStation] FOREIGN KEY([prsCL_ControlStationId])
REFERENCES [dbo].[TA_ControlStation] ([Station_ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[CL_PersonCLSpec] CHECK CONSTRAINT [FK_CL_PersonCLSpec_TA_ControlStation]
GO
ALTER TABLE [dbo].[CL_PersonCLSpec]  WITH CHECK ADD  CONSTRAINT [FK_CL_PersonCLSpec_TA_UIValidationGroup] FOREIGN KEY([prsCL_UIValidationGroupID])
REFERENCES [dbo].[TA_UIValidationGroup] ([UIValGrp_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CL_PersonCLSpec] CHECK CONSTRAINT [FK_CL_PersonCLSpec_TA_UIValidationGroup]
GO
ALTER TABLE [dbo].[CL_PersonOffish]  WITH CHECK ADD  CONSTRAINT [FK_CL_PersonOffish_CL_ClientelePerson] FOREIGN KEY([prsOffish_PersonId])
REFERENCES [dbo].[CL_ClientelePerson] ([clientelePrs_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CL_PersonOffish] CHECK CONSTRAINT [FK_CL_PersonOffish_CL_ClientelePerson]
GO
ALTER TABLE [dbo].[CL_PersonOffish]  WITH CHECK ADD  CONSTRAINT [FK_CL_PersonOffish_CL_Offish] FOREIGN KEY([prsOffish_OffishId])
REFERENCES [dbo].[CL_Offish] ([offish_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CL_PersonOffish] CHECK CONSTRAINT [FK_CL_PersonOffish_CL_Offish]
GO
