
alter TRIGGER [dbo].[trg_ins_addfree]
   ON  [dbo].[addfree]
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	begin try
	declare @personId  numeric, @date  varchar(10),@startDate varchar(10),@endDate  varchar(10),@time int,@PermitId numeric,@filled bit;
	
    insert into ta_calculation_flag_persons 
    select add_pcode,convert(varchar(4),add_year)+'/'+dbo.zerofixed(add_month,2)+'/01' 
    from inserted    
    
    DECLARE PesmitCrsor CURSOR
				FOR SELECT dbo.getperson(Add_PCode) as PersonId,convert(varchar(4),add_year)+'/'+dbo.zerofixed(add_month,2)+'/01' ,Add_TimeOK FROM  inserted
					WHERE Add_PCode in (SELECT p_barcode from persons) 
	OPEN PesmitCrsor	
	FETCH NEXT FROM PesmitCrsor
	INTO @personId,@date,@time 
	
		begin try			
				WHILE @@FETCH_STATUS = 0
				BEGIN
					
					set @startDate=dbo.GTS_ASM_ShamsiToMiladi(@date);
					SET @endDate=dbo.GTS_ASM_GetEndOfShamsiMonth(Convert(varchar(10),@date,101));
					set @PermitId=0
				   	set @filled=1
					if @time is not null  and @time > 0
					begin
																				
					SELECT @PermitId=Permit_ID from TA_Permit where Permit_PersonId =@personID and Permit_FromDate=@startDate and Permit_ToDate =@endDate 
					if @PermitId is not null and @PermitId > 0  
					begin
						if(exists(select permitpair_ID from ta_permitpair where permitpair_permitid=@permitid and permitpair_pishcardid=126))
						begin
							update 	ta_permitpair	set  permitpair_value=@time
							where permitpair_permitid=@permitid and permitpair_value=@time and permitpair_pishcardid=126
						end					
						else
						begin					
							insert into ta_permitpair (permitpair_permitid,permitpair_pishcardid,permitpair_from,permitpair_to,permitpair_value,permitpair_isfilled)
							values (@permitid,126,0,0,@time,@filled)																  
						end
					end
					else
					begin
						
						INSERT INTO TA_Permit (Permit_PersonId,Permit_FromDate,Permit_ToDate,Permit_IsPairly)
						VALUES (@personID,@startDate,@endDate,1)
						Set @PermitId=Scope_Identity()
						
						if @PermitId<>0
						 begin
							INSERT INTO TA_PermitPair (PermitPair_PermitId,PermitPair_PishCardID,PermitPair_From,PermitPair_To,PermitPair_Value,PermitPair_IsFilled)
							VALUES (@PermitId,126,0,0,@time,@filled)
						 end
					end					
					end
				FETCH NEXT FROM PesmitCrsor
					INTO @personId,@date,@time 
				END
		end try
		begin catch
		exec spr_GetTriggerLog 
		end catch
	CLOSE PesmitCrsor
	DEALLOCATE PesmitCrsor
    
    
    end try
	begin catch
	exec spr_gettriggerlog 
	end catch
END

GO


