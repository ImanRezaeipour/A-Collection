if not exists(select * from sys.columns 
            where Name = N'BasicTraffic_Transferred' and Object_ID = Object_ID(N'TA_BaseTraffic'))
begin
  alter table TA_BaseTraffic
  add  BasicTraffic_Transferred bit not null default(0)
end

