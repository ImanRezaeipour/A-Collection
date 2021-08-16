SELECT nEventLogIdn [ID], nReaderIdn [Device Id], nUserID [Barcode], nTNAEvent [Traffic Type], 
	   DATEADD(s, nDateTime , '1970-01-01') as [date]
FROM [BioStar].dbo.TB_EVENT_LOG
WHERE  --nUserID=2155 and
	  nUserID <> 0
	    AND
	  DATEADD(s, nDateTime , '1970-01-01') >= '2012-10-01'
	 -- AND	
	 -- nEventLogIdn not in 
		--(SELECT ISNULL(BasicTraffic_ReportsListId, 0) FROM [appsrv].[GhadirGTS].dbo.TA_BaseTraffic)
		
ORDER BY nDateTime