-- Iman Rezaeipour ------------------------------------------------------------------------------------------
set nocount on
USE [db_clock]

--------------------------------------------------------------------------------------------------------------
declare @FromID bigint = (select recordno - 100 from  CollectRecordNO)
declare @ToID bigint = (select max(nEventLogIdn) from  Biostar.dbo.TB_EVENT_LOG)
delete from Biostar.dbo.TB_EVENT_LOG where nEventIdn not in(39,43,44,45,46,47,48,49,50,51,52,53,55,58,59,61,62,151)

--------------------------------------------------------------------------------------------------------------
declare @nEventLogIdn bigint, @nDateTime int, @nReaderIdn int, @nEventIdn int, @nUserID int, @nIsLog int, @nTNAEvent int, @nIsUseTA int, @nType int, @iMonth nvarchar(max), @iBarcode nvarchar(max), @iDate nvarchar(max), @iTime nvarchar(max)
declare Cursor_1 cursor for
select nEventLogIdn, nDateTime, nReaderIdn, nEventIdn, nUserID ,nIsLog ,nTNAEvent ,nIsUseTA ,nType
,substring(replace(dbo.MiladiTOShamsi( cast (DATEADD(s, nDateTime, '1970-01-01') as date) ),'/',''),1,6) iMonth
,isnull( (select top 1 p_barcode from persons where p_proxi = dbo.LTRIMX2(CONVERT (varchar(8),nUserID))) , dbo.LTRIMX2(CONVERT (varchar(8),nUserID)) ) iBarcode
,dbo.MiladiTOShamsi( cast (DATEADD(s, nDateTime, '1970-01-01') as date) ) iDate
,DATEPART(HOUR,CONVERT(nVarchar(32), DATEADD(s, nDateTime, '1970-01-01'), 20)) *60 +DATEPART(MINUTE,CONVERT(nVarchar(32), DATEADD(s, nDateTime, '1970-01-01'), 20)) as iTime from Biostar.dbo.TB_EVENT_LOG
where nEventIdn in(39,43,44,45,46,47,48,49,50,51,52,53,55,58,59,61,62,151)
and dbo.MiladiTOShamsi( cast (DATEADD(s, nDateTime, '1970-01-01') as date) ) > '1394/01/01'
and (nEventLogIdn between @FromID and @ToID)
order by nEventLogIdn,nDateTime,nReaderIdn

--------------------------------------------------------------------------------------------------------------
open Cursor_1
fetch next from Cursor_1 into @nEventLogIdn, @nDateTime, @nReaderIdn, @nEventIdn, @nUserID, @nIsLog, @nTNAEvent ,@nIsUseTA ,@nType, @iMonth, @iBarcode, @iDate, @iTime
while @@FETCH_STATUS = 0
begin  
	if (@nUserID in ('99999921', '99999951', '99999928', '99999929', '99999961'))
	begin
		UPDATE Biostar.dbo.TB_EVENT_LOG
		set nType=RIGHT(@nUserID,2)
		where nEventLogIdn = (select top 1 nEventLogIdn from Biostar.dbo.TB_EVENT_LOG
			where nEventLogIdn > @nEventLogIdn
			and nDateTime > @nDateTime
			and nDateTime - @nDateTime <= 15
			and nReaderIdn = @nReaderIdn
			and nEventIdn in(39,43,44,45,46,47,48,49,50,51,52,53,55,58,59,61,62,151)
			and nUserID not in ('99999921', '99999951', '99999928', '99999929', '99999961')
			order by nEventLogIdn,nDateTime,nReaderIdn)
	end
fetch next from Cursor_1 into @nEventLogIdn, @nDateTime, @nReaderIdn, @nEventIdn, @nUserID, @nIsLog, @nTNAEvent ,@nIsUseTA ,@nType, @iMonth, @iBarcode, @iDate, @iTime
end
close Cursor_1

--------------------------------------------------------------------------------------------------------------
open Cursor_1
fetch next from Cursor_1 into @nEventLogIdn, @nDateTime, @nReaderIdn, @nEventIdn, @nUserID, @nIsLog, @nTNAEvent ,@nIsUseTA ,@nType, @iMonth, @iBarcode, @iDate, @iTime
while @@FETCH_STATUS = 0
begin 
	if ( OBJECT_ID('C' + @iMonth) is  null )
	begin
		declare @create nvarchar(max) = N'CREATE TABLE C' + @iMonth + '( [Clock_BarCode] [varchar](8) NULL, [Clock_BDate] [varchar](10) NULL, [Clock_BTime] [bigint] NULL, [Clock_BRdrCode] [int] NULL, [Clock_BRecState] [bigint] NULL, [Clock_Date] [varchar](10) NULL, [Clock_Time] [bigint] NULL, [Clock_RdrCode] [int] NULL, [Clock_Chg] [bigint] NULL, [Clock_RecState] [bigint] NULL, [Clock_User] [varchar](15) NULL) ON [PRIMARY]'
		exec(@create)
	end
	declare @rowcount int
	declare @exist nvarchar(max) = N'select @rowcount = count(*) from c' + @iMonth + ' where clock_barcode = ''' + @iBarcode + ''' and clock_time = ' + @iTime + ' and clock_date = ''' + @iDate + ''' and clock_recstate = ' + cast(@nType as nvarchar(max))
	exec sp_executesql @exist, N'@rowcount int output', @rowcount output
	if(@rowcount = 0 )
	begin
		declare @insert nvarchar(max) = N'insert C' + @iMonth + ' values (''' + @iBarcode + ''',''' + @iDate + ''',' + @iTime + ',' + cast(@nReaderIdn as nvarchar(max)) + ',' + cast(@nType as nvarchar(max)) + ',''' + @iDate + ''',' + @iTime + ',' + cast(@nReaderIdn as nvarchar(max)) + ',' + '0' + ',' + cast(@nType as nvarchar(max)) + ',''' + 'iCollect' + ''')'
		exec (@insert)
	end
	else
	begin
		declare @update nvarchar(max) = N'update C' + @iMonth + ' SET Clock_recstate = ' + cast(@nType as nvarchar(max)) + ', Clock_brecstate = ' + cast(@nType as nvarchar(max)) + ' where Clock_barcode=''' + @iBarcode + ''' and clock_date = ''' + @iDate + ''' and Clock_time = ' + @iTime 
		exec(@update)
	end
fetch next from Cursor_1 into @nEventLogIdn, @nDateTime, @nReaderIdn, @nEventIdn, @nUserID, @nIsLog, @nTNAEvent ,@nIsUseTA ,@nType, @iMonth, @iBarcode, @iDate, @iTime
end
close Cursor_1
deallocate Cursor_1

-----------------------------------------------------------------------------------------------------------------
delete CollectRecordNO
insert CollectRecordNO (recordno) values(@ToID)

-----------------------------------------------------------------------------------------------------------------