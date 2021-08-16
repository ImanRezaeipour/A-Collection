Alter PROC spr_InitTrafficSettings(@rule_Code int)
As
begin

declare 	@beginTimeDutyByCart int, 
			@delayCartAllowed int, 
			@serviceDelayCartAllowed int,
			@autoEnterCart int, 
			@autoExitCart int, 
			@oneEnterOneExit int, 
			@fullMomtad int,
			@nearTraffic int,
			@virtualMidnight int,
			@fixVirtualMidnight bit,
			@dayNightMinutes int,
			@outInWorkMax int
			
		set @dayNightMinutes=1440;
		print 'spr_InitTrafficSettings Rule_Code:'+ Convert(varchar(5),@rule_Code)	
		select @virtualMidNight=Rule_Shrmarz,@fixVirtualMidnight=Rule_Shrfix,@autoEnterCart=Rule_InCard
		,@autoExitCart=Rule_OutCard,@oneEnterOneExit=Rule_In1_Out2,@nearTraffic=Rule_trdnear
		,@outInWorkMax=Rule_outinworkmax  
		from rulesetc where rule_Code=@Rule_Code
		
		if(exists(select * from rulesetc where Rule_Code=@rule_Code and  Rule_outinwork=0))
		begin
			set @outInWorkMax=0;
		end
		
		SELECT @beginTimeDutyByCart=Rule_MAms1,@delayCartAllowed= Rule_GTMM,@serviceDelayCartAllowed= Rule_GTSM,@fullMomtad= Rule_e28fullmomtad
		FROM rules where Rule_Code=@Rule_Code

		set @virtualMidNight =@virtualMidNight+@dayNightMinutes-1;
		if @virtualMidNight >= @dayNightMinutes
		begin
			set @virtualMidNight=@virtualMidNight-@dayNightMinutes;
		end
	    
		delete from TA_TrafficSettings 
			where trafficSet_PersonId in (select Prs_Id from TA_Person where Prs_Barcode in ( select p_barcode from persons where P_RuleGroup =@Rule_Code))
		
		insert into TA_TrafficSettings ( trafficSet_PersonId
		  ,[TrafficSet_BeginTimeHourDutyByCart]
		  ,[TrafficSet_DutyByPermision]
		  ,[TrafficSet_DelayCartIsAllowed]
		  ,[TrafficSet_DelayCartServiceIsAllowd]
		  ,[TrafficSet_OneEnterOneExit]
		  ,[TrafficSet_28_29ExpireLength]
		  ,[TrafficSet_AutoEnterTraffic]
		  ,[TrafficSet_AutoExitTraffic]
		  ,[TrafficSet_TrafficMinLength]
		  ,[TrafficSet_VirtualMidNight]
		  ,[TrafficSet_FixVirtualMidNight]
		  ,[TrafficSet_OutInWorkMax] )
		select Prs_Id,isnull(@beginTimeDutyByCart,0),0,isnull(@delayCartAllowed,0),isnull(@serviceDelayCartAllowed,0)
		,isnull(@oneEnterOneExit,0),isnull(@fullMomtad,0),isnull(@autoEnterCart,0),isnull(@autoExitCart,0)
		,isnull(@nearTraffic,0),isnull(@virtualMidNight,@dayNightMinutes-1),ISNULL(@fixVirtualMidnight,0),ISNULL(@outInWorkMax,0)
    	from TA_Person where Prs_Barcode in ( select p_barcode from persons where P_RuleGroup =@Rule_Code)
    	


end