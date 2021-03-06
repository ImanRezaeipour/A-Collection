
/****** Object:  Table [dbo].[CL_Car]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_Car]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[CL_ClienteleBlackList]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_ClienteleBlackList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CL_ClienteleBlackList](
	[cbl_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[cbl_Deleted] [bit] NOT NULL,
	[cbl_ClientelePersonId] [numeric](18, 0) NOT NULL,
	[cbl_Description] [nvarchar](max) NULL,
	[cbl_TemporarilyOutOfList] [bit] NOT NULL,
	[cbl_AddDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CL_ClienteleBlackList] PRIMARY KEY CLUSTERED 
(
	[cbl_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CL_ClientelePerson]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_ClientelePerson]') AND type in (N'U'))
BEGIN
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
 CONSTRAINT [PK_CL_ClientelePerson] PRIMARY KEY CLUSTERED 
(
	[clientelePrs_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CL_Contractor]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_Contractor]') AND type in (N'U'))
BEGIN
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
 CONSTRAINT [PK_CL_Clientele] PRIMARY KEY CLUSTERED 
(
	[contractor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CL_DepartmentPosition]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_DepartmentPosition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CL_DepartmentPosition](
	[pos_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[pos_UnitName] [nvarchar](max) NULL,
	[pos_Location] [nvarchar](max) NULL,
	[pos_DepartmentId] [numeric](18, 0) NULL,
 CONSTRAINT [PK_CL_DepartmentPosition] PRIMARY KEY CLUSTERED 
(
	[pos_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CL_Equipment]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_Equipment]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[CL_EquipmentBlackList]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_EquipmentBlackList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CL_EquipmentBlackList](
	[EqpBl_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[EqpBl_Deleted] [bit] NOT NULL,
	[EqpBl_Name] [nvarchar](200) NOT NULL,
	[EqpBl_Description] [nvarchar](max) NULL,
	[EqpBl_CustomCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_CL_EquipmentBlackList] PRIMARY KEY CLUSTERED 
(
	[EqpBl_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CL_EquipmentBlackListDepartments]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_EquipmentBlackListDepartments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CL_EquipmentBlackListDepartments](
	[blDep_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[blDep_DepId] [numeric](18, 0) NOT NULL,
	[blDep_EquipmentBlackListId] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_CL_EquipmentBlackListDepartments] PRIMARY KEY CLUSTERED 
(
	[blDep_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CL_EquipmentType]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_EquipmentType]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CL_Offish]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_Offish]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CL_Offish](
	[offish_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[offish_departmentId] [numeric](18, 0) NULL,
	[offish_ofishTypeId] [numeric](18, 0) NOT NULL,
	[offish_FromDate] [datetime] NOT NULL,
	[offish_ToDate] [datetime] NOT NULL,
	[offish_FromTime] [int] NULL,
	[offish_ToTime] [int] NULL,
	[offish_ActiveDirectory] [bit] NULL,
	[offish_InternetAccess] [bit] NULL,
	[offish_Description] [nvarchar](max) NULL,
	[offish_Active] [bit] NOT NULL,
	[offish_Deleted] [bit] NULL,
 CONSTRAINT [PK_CL_Offish] PRIMARY KEY CLUSTERED 
(
	[offish_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CL_OffishType]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_OffishType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CL_OffishType](
	[ofishType_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[ofishType_Title] [nvarchar](200) NOT NULL,
	[ofishType_CustomCode] [nvarchar](200) NOT NULL,
	[ofishType_Active] [bit] NOT NULL,
	[ofishType_Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_CL_OffishType] PRIMARY KEY CLUSTERED 
(
	[ofishType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CL_PersonCLSpec]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_PersonCLSpec]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CL_PersonCLSpec](
	[prsCL_ID] [numeric](18, 0) NOT NULL,
	[prsCL_ControlStationId] [numeric](18, 0) NULL,
	[prsCL_Active] [bit] NULL,
	[prsCL_UIValidationGroupID] [numeric](18, 0) NULL,
	[prsCL_DepartmentPosition] [numeric](18, 0) NULL,
	[prsCL_R1] [numeric](18, 0) NULL,
	[prsCL_R2] [numeric](18, 0) NULL,
	[prsCL_R3] [numeric](18, 0) NULL,
	[prsCL_R4] [numeric](18, 0) NULL,
	[prsCL_R5] [numeric](18, 0) NULL,
	[prsCL_R6] [numeric](18, 0) NULL,
	[prsCL_R7] [numeric](18, 0) NULL,
	[prsCL_R8] [numeric](18, 0) NULL,
	[prsCL_R9] [numeric](18, 0) NULL,
	[prsCL_R10] [numeric](18, 0) NULL,
	[prsCL_R11] [numeric](18, 0) NULL,
	[prsCL_R12] [numeric](18, 0) NULL,
	[prsCL_R13] [numeric](18, 0) NULL,
	[prsCL_R14] [numeric](18, 0) NULL,
	[prsCL_R15] [numeric](18, 0) NULL,
	[prsCL_R16] [numeric](18, 0) NULL,
	[prsCL_R17] [numeric](18, 0) NULL,
	[prsCL_R18] [numeric](18, 0) NULL,
	[prsCL_R19] [numeric](18, 0) NULL,
	[prsCL_R20] [numeric](18, 0) NULL,
	[PrsCL_DepartmentPositionId] [numeric](18, 0) NULL,
 CONSTRAINT [PK_TA_PersonCLSpec] PRIMARY KEY CLUSTERED 
(
	[prsCL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CL_PersonOffish]    Script Date: 10/8/2013 10:50:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CL_PersonOffish]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CL_PersonOffish](
	[prsOffish_ID] [numeric](18, 0) NOT NULL,
	[prsOffish_PersonId] [numeric](18, 0) NOT NULL,
	[prsOffish_OffishId] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_CL_PersonOffish] PRIMARY KEY CLUSTERED 
(
	[prsOffish_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Car_CL_Clientele]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Car]'))
ALTER TABLE [dbo].[CL_Car]  WITH CHECK ADD  CONSTRAINT [FK_CL_Car_CL_Clientele] FOREIGN KEY([Car_ContractorId])
REFERENCES [dbo].[CL_Contractor] ([contractor_ID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Car_CL_Clientele]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Car]'))
ALTER TABLE [dbo].[CL_Car] CHECK CONSTRAINT [FK_CL_Car_CL_Clientele]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Car_CL_Offish]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Car]'))
ALTER TABLE [dbo].[CL_Car]  WITH CHECK ADD  CONSTRAINT [FK_CL_Car_CL_Offish] FOREIGN KEY([Car_OffishId])
REFERENCES [dbo].[CL_Offish] ([offish_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Car_CL_Offish]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Car]'))
ALTER TABLE [dbo].[CL_Car] CHECK CONSTRAINT [FK_CL_Car_CL_Offish]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_ClientelePerson_CL_Clientele]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_ClientelePerson]'))
ALTER TABLE [dbo].[CL_ClientelePerson]  WITH CHECK ADD  CONSTRAINT [FK_CL_ClientelePerson_CL_Clientele] FOREIGN KEY([clientelePrs_ContractorId])
REFERENCES [dbo].[CL_Contractor] ([contractor_ID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_ClientelePerson_CL_Clientele]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_ClientelePerson]'))
ALTER TABLE [dbo].[CL_ClientelePerson] CHECK CONSTRAINT [FK_CL_ClientelePerson_CL_Clientele]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Equipment_CL_Clientele]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Equipment]'))
ALTER TABLE [dbo].[CL_Equipment]  WITH CHECK ADD  CONSTRAINT [FK_CL_Equipment_CL_Clientele] FOREIGN KEY([Eqp_ContractorId])
REFERENCES [dbo].[CL_Contractor] ([contractor_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Equipment_CL_Clientele]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Equipment]'))
ALTER TABLE [dbo].[CL_Equipment] CHECK CONSTRAINT [FK_CL_Equipment_CL_Clientele]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Equipment_CL_EquipmentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Equipment]'))
ALTER TABLE [dbo].[CL_Equipment]  WITH CHECK ADD  CONSTRAINT [FK_CL_Equipment_CL_EquipmentType] FOREIGN KEY([Eqp_EquipmentTypeId])
REFERENCES [dbo].[CL_EquipmentType] ([EqpType_ID])
ON DELETE SET NULL
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Equipment_CL_EquipmentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Equipment]'))
ALTER TABLE [dbo].[CL_Equipment] CHECK CONSTRAINT [FK_CL_Equipment_CL_EquipmentType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Equipment_CL_Offish]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Equipment]'))
ALTER TABLE [dbo].[CL_Equipment]  WITH CHECK ADD  CONSTRAINT [FK_CL_Equipment_CL_Offish] FOREIGN KEY([Eqp_OffishId])
REFERENCES [dbo].[CL_Offish] ([offish_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Equipment_CL_Offish]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Equipment]'))
ALTER TABLE [dbo].[CL_Equipment] CHECK CONSTRAINT [FK_CL_Equipment_CL_Offish]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_EquipmentBlackListDepartments_CL_EquipmentBlackList]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_EquipmentBlackListDepartments]'))
ALTER TABLE [dbo].[CL_EquipmentBlackListDepartments]  WITH CHECK ADD  CONSTRAINT [FK_CL_EquipmentBlackListDepartments_CL_EquipmentBlackList] FOREIGN KEY([blDep_EquipmentBlackListId])
REFERENCES [dbo].[CL_EquipmentBlackList] ([EqpBl_ID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_EquipmentBlackListDepartments_CL_EquipmentBlackList]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_EquipmentBlackListDepartments]'))
ALTER TABLE [dbo].[CL_EquipmentBlackListDepartments] CHECK CONSTRAINT [FK_CL_EquipmentBlackListDepartments_CL_EquipmentBlackList]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_EquipmentBlackListDepartments_TA_Department]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_EquipmentBlackListDepartments]'))
ALTER TABLE [dbo].[CL_EquipmentBlackListDepartments]  WITH CHECK ADD  CONSTRAINT [FK_CL_EquipmentBlackListDepartments_TA_Department] FOREIGN KEY([blDep_DepId])
REFERENCES [dbo].[TA_Department] ([dep_ID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_EquipmentBlackListDepartments_TA_Department]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_EquipmentBlackListDepartments]'))
ALTER TABLE [dbo].[CL_EquipmentBlackListDepartments] CHECK CONSTRAINT [FK_CL_EquipmentBlackListDepartments_TA_Department]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Offish_CL_OffishType]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Offish]'))
ALTER TABLE [dbo].[CL_Offish]  WITH CHECK ADD  CONSTRAINT [FK_CL_Offish_CL_OffishType] FOREIGN KEY([offish_ofishTypeId])
REFERENCES [dbo].[CL_OffishType] ([ofishType_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_Offish_CL_OffishType]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_Offish]'))
ALTER TABLE [dbo].[CL_Offish] CHECK CONSTRAINT [FK_CL_Offish_CL_OffishType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonCLSpec_CL_DepartmentPosition]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonCLSpec]'))
ALTER TABLE [dbo].[CL_PersonCLSpec]  WITH CHECK ADD  CONSTRAINT [FK_CL_PersonCLSpec_CL_DepartmentPosition] FOREIGN KEY([prsCL_DepartmentPosition])
REFERENCES [dbo].[CL_DepartmentPosition] ([pos_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonCLSpec_CL_DepartmentPosition]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonCLSpec]'))
ALTER TABLE [dbo].[CL_PersonCLSpec] CHECK CONSTRAINT [FK_CL_PersonCLSpec_CL_DepartmentPosition]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonCLSpec_TA_ControlStation]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonCLSpec]'))
ALTER TABLE [dbo].[CL_PersonCLSpec]  WITH CHECK ADD  CONSTRAINT [FK_CL_PersonCLSpec_TA_ControlStation] FOREIGN KEY([prsCL_ControlStationId])
REFERENCES [dbo].[TA_ControlStation] ([Station_ID])
ON DELETE SET NULL
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonCLSpec_TA_ControlStation]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonCLSpec]'))
ALTER TABLE [dbo].[CL_PersonCLSpec] CHECK CONSTRAINT [FK_CL_PersonCLSpec_TA_ControlStation]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonCLSpec_TA_Person]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonCLSpec]'))
ALTER TABLE [dbo].[CL_PersonCLSpec]  WITH CHECK ADD  CONSTRAINT [FK_CL_PersonCLSpec_TA_Person] FOREIGN KEY([prsCL_ID])
REFERENCES [dbo].[TA_Person] ([Prs_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonCLSpec_TA_Person]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonCLSpec]'))
ALTER TABLE [dbo].[CL_PersonCLSpec] CHECK CONSTRAINT [FK_CL_PersonCLSpec_TA_Person]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonCLSpec_TA_UIValidationGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonCLSpec]'))
ALTER TABLE [dbo].[CL_PersonCLSpec]  WITH CHECK ADD  CONSTRAINT [FK_CL_PersonCLSpec_TA_UIValidationGroup] FOREIGN KEY([prsCL_UIValidationGroupID])
REFERENCES [dbo].[TA_UIValidationGroup] ([UIValGrp_ID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonCLSpec_TA_UIValidationGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonCLSpec]'))
ALTER TABLE [dbo].[CL_PersonCLSpec] CHECK CONSTRAINT [FK_CL_PersonCLSpec_TA_UIValidationGroup]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonOffish_CL_ClientelePerson]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonOffish]'))
ALTER TABLE [dbo].[CL_PersonOffish]  WITH CHECK ADD  CONSTRAINT [FK_CL_PersonOffish_CL_ClientelePerson] FOREIGN KEY([prsOffish_PersonId])
REFERENCES [dbo].[CL_ClientelePerson] ([clientelePrs_ID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonOffish_CL_ClientelePerson]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonOffish]'))
ALTER TABLE [dbo].[CL_PersonOffish] CHECK CONSTRAINT [FK_CL_PersonOffish_CL_ClientelePerson]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonOffish_CL_Offish]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonOffish]'))
ALTER TABLE [dbo].[CL_PersonOffish]  WITH CHECK ADD  CONSTRAINT [FK_CL_PersonOffish_CL_Offish] FOREIGN KEY([prsOffish_OffishId])
REFERENCES [dbo].[CL_Offish] ([offish_ID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CL_PersonOffish_CL_Offish]') AND parent_object_id = OBJECT_ID(N'[dbo].[CL_PersonOffish]'))
ALTER TABLE [dbo].[CL_PersonOffish] CHECK CONSTRAINT [FK_CL_PersonOffish_CL_Offish]
GO
