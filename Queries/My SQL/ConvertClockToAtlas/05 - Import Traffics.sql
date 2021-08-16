SET NOCOUNT ON

BEGIN TRANSACTION ImportTraffics

PRINT 'انتقال ترددها'
BEGIN

	IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CTemp]') AND type in (N'U'))
	    CREATE TABLE [CTemp] ([Clock_BarCode] [varchar](8) NULL,[Clock_BDate] [varchar](10) NULL,[Clock_BTime] [bigint] NULL,[Clock_BRdrCode] [bigint] NULL,[Clock_BRecState] [bigint] NULL,[Clock_Date] [varchar](10) NULL,[Clock_Time] [bigint] NULL,[Clock_RdrCode] [bigint] NULL,[Clock_Chg] [bigint] NULL,[Clock_RecState] [bigint] NULL,[Clock_User] [varchar](15) NULL) ON [PRIMARY]

	declare @CTable nvarchar(max)
	declare cur cursor for
	SELECT TABLE_NAME FROM clock.INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG='clock' AND TABLE_NAME lIKE N'C139___'
	
	open cur
	fetch next from cur into @CTable
	while @@FETCH_STATUS=0
	BEGIN
		declare @query nvarchar(max) = 'INSERT INTO [CTemp] ([Clock_BarCode], [Clock_BDate], [Clock_BTime], [Clock_BRdrCode], [Clock_BRecState], [Clock_Date], [Clock_Time], [Clock_RdrCode], [Clock_Chg], [Clock_RecState], [Clock_User]) SELECT [Clock_BarCode], [Clock_BDate], [Clock_BTime], [Clock_BRdrCode], [Clock_BRecState], [Clock_Date], [Clock_Time], [Clock_RdrCode], [Clock_Chg], [Clock_RecState], [Clock_User] FROM Clock.dbo.' + @CTable
		exec(@query)
		fetch next from cur into @CTable
	end
	close cur
	deallocate cur

	INSERT INTO [TA_BaseTraffic] ([BasicTraffic_PrecardId],[BasicTraffic_PersonID],[BasicTraffic_Date],[BasicTraffic_Time],[BasicTraffic_Used],[BasicTraffic_Active],[BasicTraffic_Manual],[BasicTraffic_State],[BasicTraffic_ReportsListId],[BasicTraffic_OperatorPersonID],[BasicTraffic_Description],[BasicTraffic_ClockCustomCode],[BasicTraffic_BioStarId],[BasicTraffic_Transferred])
	SELECT (select top 1 Precrd_ID from TA_Precard where Precrd_Code=0),(select top 1 prs_id from TA_Person where cast(Prs_Barcode as nvarchar(max))=substring(c.Clock_BarCode, patindex('%[^0]%',c.Clock_BarCode), 10)),dbo.GTS_ASM_ShamsiToMiladi(isnull(c.Clock_Date,'1400/01/01')),c.Clock_Time,0,1,0,1,null,null,c.Clock_User,c.Clock_RdrCode,1,1 FROM [CTemp] C
	where c.Clock_Date <> '' AND c.Clock_BarCode <> ''

	DROP TABLE [CTemp]

END

COMMIT TRANSACTION ImportTraffics
