/*
insert into TA_Request(request_PrecardID,request_PersonID,request_FromDate,request_ToDate,request_FromTime,request_ToTime,request_TimeDuration,request_Description,request_RegisterDate,request_UserID,request_OperatorUser)
select Precrd_ID,Prs_ID,dbo.GTS_ASM_ShamsiToMiladi(Clock_BDate),dbo.GTS_ASM_ShamsiToMiladi(Clock_BDate),-1000,-1000,-1000,'',dbo.GTS_ASM_ShamsiToMiladi(Clock_BDate),35440,Prs_FirstName+' ' +Prs_LastName
 from [clock].dbo.C139112 
join TA_Person on Prs_Barcode=Clock_BarCode
join TA_Precard on Precrd_Code=Clock_BRecState

where Clock_BRecState<>0-- and Clock_BarCode=70577
*/

insert into TA_Request(request_PrecardID,request_PersonID,request_FromDate,request_ToDate,request_FromTime,request_ToTime,request_TimeDuration,request_Description,request_RegisterDate,request_UserID,request_OperatorUser)
select Precrd_ID,Prs_ID,dbo.GTS_ASM_ShamsiToMiladi(Clock_Date),dbo.GTS_ASM_ShamsiToMiladi(Clock_Date),clock_time,clock_etime,-1000,'',dbo.GTS_ASM_ShamsiToMiladi(Clock_Date),35440,Prs_FirstName+' ' +Prs_LastName
 from [clock].dbo.t139101
join TA_Person on Prs_Barcode=Clock_BarCode
join TA_Precard on Precrd_Code=Clock_RecState