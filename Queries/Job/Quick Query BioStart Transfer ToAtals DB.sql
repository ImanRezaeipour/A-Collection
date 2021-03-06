	DECLARE @nIndex numeric
	DECLARE @DeviceId int ---   شناسه دستگاه
	DECLARE @dtDateTime datetime ---  تاریخ زمان
	DECLARE @Date date
	DECLARE @MinDate date
	DECLARE @minute varchar(10)--زمان برحسب دقیقه
	DECLARE @UserID int   ---شماره پرسنلی
	DECLARE @LastUserID int
	DECLARE @prsId numeric
	DECLARE @bioPrecard varchar(10)
	DECLARE @UsualPrecardId numeric
	DECLARE @BIOStarId varchar(50)
	DECLARE @Inserted bit
	
SELECT top(1) @BIOStarId=CONVERT(varchar(50),softwareid) FROM [appserver27].[BIOSTAR].dbo.TA_BioStarID

SELECT @UsualPrecardId=Precrd_ID FROM [appserver24].[FalatGTS].dbo.TA_Precard
WHERE Precrd_Code='0'

print 'Retriving BioStar Traffics Started ' +Convert(varchar(100), CURRENT_TIMESTAMP)

INSERT INTO[appserver24].[FalatGTS].dbo.TA_BaseTraffic (
[BasicTraffic_PrecardId],[BasicTraffic_PersonID],[BasicTraffic_Date],[BasicTraffic_Time],[BasicTraffic_Used],
[BasicTraffic_Active],[BasicTraffic_Manual],[BasicTraffic_ReportsListId],[BasicTraffic_ClockCustomCode],[BasicTraffic_BioStarId])
SELECT 
8832,dbo.GetPerson(nUserID),Convert(date,DATEADD(s, nDateTime , '1970-01-01'),103) as [date],DATEPART(HH, DATEADD(s, nDateTime , '1970-01-01')) * 60 + DATEPART(MI, DATEADD(s, nDateTime , '1970-01-01')),0,
 1,0,nEventLogIdn,  nReaderIdn [Device Id],  @BIOStarId
FROM [appserver27].[BIOSTAR].dbo.TB_EVENT_LOG
WHERE  
	  len(isnull(nUserID,0)) > 2 -- exclude device barcode
	    AND
	  nEventIdn in (55,39) AND nTNAEvent=255
		AND
	  isnull(GTS_Transfered,0)=0
	    AND
	  DATEADD(s, nDateTime , '1970-01-01') >= '2012-10-01'
		AND 
	nUserID in (select Prs_Barcode from TA_Person where prs_IsDeleted=0 and Prs_Active=1)
	   AND	
	  nEventLogIdn not in 
		(SELECT BasicTraffic_ReportsListId FROM [appserver24].[FalatGTS].dbo.TA_BaseTraffic 
		 WHERE BasicTraffic_ReportsListId is not null and BasicTraffic_BioStarId=@BIOStarId)