select 
nEventLogIdn [ID], 
nReaderIdn [Device Id],
nEventIdn [Authenticate type],
nUserID [Barcode],
nTNAEvent [Traffic Type],
CONVERT(nVarchar(32), DATEADD(s, nDateTime , '1970-01-01'), 103) as [date],
DATEPART(HH, DATEADD(s, nDateTime , '1970-01-01')) as [hour],
DATEPART(MI, DATEADD(s, nDateTime , '1970-01-01')) as [minutes]
from TB_EVENT_LOG
where nUserID=2155
order by nDateTime


