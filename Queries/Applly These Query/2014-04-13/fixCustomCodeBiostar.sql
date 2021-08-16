update TA_BaseTraffic
set BasicTraffic_ClockCustomCode=[nReaderIdn]
from [BioStar].[dbo].[TB_EVENT_LOG]
where BasicTraffic_ReportsListId=[nEventLogIdn]
and BasicTraffic_ClockCustomCode is null
and BasicTraffic_Date > '2014/03/20'