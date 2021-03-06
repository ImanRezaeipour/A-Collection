
alter PROCEDURE [dbo].[spr_trg_IDU_tbl]
@tbl_name varchar(7)
AS
BEGIN
	SET NOCOUNT ON;
------------------------
    declare @typ_ varchar(1)
	set @typ_=SUBSTRING(@tbl_name,1,1)
	declare @str_ varchar(MAX)
    if @typ_='c' 
    Begin
		if  exists(select id from sysobjects where xtype='tr' and name='trg_DEL_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger  trg_DEL_CFP_'+@tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_DEL_CFP_'+@tbl_name+ ' ON ' + @tbl_name+' AFTER delete AS  
			BEGIN   
			 SET NOCOUNT ON; 
			 begin try  
			 declare  @date varchar(10),@time int,@barcode varchar(10)
			 SELECT @date=clock_date,@time=clock_time  FROM deleted 
			 insert into TA_Calculation_Flag_Persons   
			 SELECT Clock_BarCode,Clock_Date FROM deleted   
			 WHERE Clock_BarCode IS NOT NULL  
			 
			 DECLARE DeletedCursor CURSOR
    				FOR SELECT clock_barcode,clock_date,clock_time FROM DELETED
    				
    		OPEN DeletedCursor
    		FETCH NEXT FROM DeletedCursor
				INTO @barcode,@date,@time
			WHILE @@FETCH_STATUS = 0
				BEGIN
				UPDATe TA_BaseTraffic set BasicTraffic_Active=0
				WHERE BasicTraffic_PersonID in
				(SELECT Prs_Id FROM TA_Person WHERE Prs_Barcode =@barcode)
				 and dbo.GTS_ASM_MiladiToShamsi(Convert(varchar(10), BasicTraffic_Date,101))=@date  and BasicTraffic_Time=@time  		
				 FETCH NEXT FROM DeletedCursor
				 INTO @barcode,@date,@time
				END	
			CLOSE DeletedCursor
			DEALLOCATE DeletedCursor	
			end try
			begin catch
			exec spr_GetTriggerLog 
			end catch			
		   END '
			exec(@str_)
		
		if  exists(select id from sysobjects where xtype='tr' and name='trg_INS_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger trg_INS_CFP_'+@tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_INS_CFP_'+@tbl_name+' ON '+@tbl_name+' AFTER insert AS '+
			'BEGIN ' + 
			'set nocount on;    
			begin try
			 declare @personid int,@barcode varchar(10) ,@date varchar(10) ,@pishcard int,@time int,@manual int
			 
			 	declare cursor_inserted cursor 
	for select clock_barcode,clock_date,clock_time,clock_recstate,clock_chg from inserted	
	open cursor_inserted
	fetch next from cursor_inserted
	into @barcode,@date,@time,@pishcard,@manual
	while @@fetch_status = 0
	begin			 
	
			
			 select @personid =prs_id from ta_person where prs_barcode =@barcode    
			 
			 if(@personid is not null and @personid!=0)
			 begin	
			 insert into ta_calculation_flag_persons    
			 values( @barcode,@date )
			  	
			 insert into ta_basetraffic (basictraffic_personid,basictraffic_precard ,basictraffic_date ,basictraffic_time ,basictraffic_used,basictraffic_manual,basictraffic_state  )
				values(@personid, @pishcard,dbo.GTS_ASM_ShamsiToMiladi(@date) ,@time, 0, @manual,isnull(@manual,0))
			end	
			set @personid=0;	
			fetch next from cursor_inserted
			into @barcode,@date,@time,@pishcard,@manual	 
	end
	close cursor_inserted
	deallocate cursor_inserted	
			end try
			begin catch
			exec spr_GetTriggerLog 
			end catch	'+		
			' END '
			exec(@str_)
		
		if  exists(select id from sysobjects where xtype='tr' and name='trg_UPD_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger  trg_UPD_CFP_' + @tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_UPD_CFP_'+@tbl_name+' ON '+@tbl_name+' AFTER update AS ' +
			'BEGIN ' +
			' SET NOCOUNT ON; ' + 
			' begin try '+
			' insert into TA_Calculation_Flag_Persons ' + 
			' select Clock_BarCode,Clock_Date from inserted ' + 
			' WHERE Clock_BarCode IS NOT NULL ' +	
			'end try
		   	 begin catch
			 exec spr_GetTriggerLog 
			 end catch '+		
			'END '
			exec(@str_)
		
	END
---------------------------------------------
	  if  @typ_='t'
    Begin
		if  exists(select id from sysobjects where xtype='tr' and name='trg_DEL_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger  trg_DEL_CFP_'+@tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_DEL_CFP_'+@tbl_name+' ON '+@tbl_name+' AFTER delete AS ' +
			'BEGIN ' + 
			' SET NOCOUNT ON;  ' +
			' begin try '+
			' declare  @date varchar(10),@time int,@barcode varchar(10) '+ 
			' select @date=clock_date,@time=clock_time ,@barcode=clock_barcode from deleted '+
			' insert into TA_Calculation_Flag_Persons ' + 
			' select Clock_BarCode, Clock_Date from deleted ' + 
			' WHERE Clock_BarCode IS NOT NULL ' +	
			' end try
			  begin catch
			  exec spr_GetTriggerLog 
			  end catch '+					
			'END ' 
			exec(@str_)
			
			if  exists(select id from sysobjects where xtype='tr' and name='trg_PermitConvertINS'+@tbl_name)
			Begin
				set @str_= ' drop trigger  trg_PermitConvertINS'+@tbl_name
				exec(@str_)
			END			
			set @str_ = 
			'CREATE TRIGGER trg_PermitConvertINS'+@tbl_name+'
			ON '+@tbl_name+' AFTER INSERT
			AS
			BEGIN
				DECLARE	@time int,@etime int,@date varchar(10),@pishcart int,@personID int,@barcode varchar(10),@PermitId int,@filled bit
						,@datetime datetime
				
				DECLARE PesmitCrsor CURSOR
				FOR SELECT clock_barcode,clock_date,clock_time,clock_etime,clock_RecState FROM  inserted
					WHERE clock_barcode in (SELECT p_barcode from persons)
				
				OPEN PesmitCrsor	
				FETCH NEXT FROM PesmitCrsor
				INTO @barcode,@date,@time,@etime,@pishcart
				
				begin try			
				WHILE @@FETCH_STATUS = 0
				BEGIN
					set @PermitId=0
				   	set @filled=1
					if @time is null or @etime is null
					begin
						set @filled=0
					end
					IF @etime = 0
					begin 
						set @etime=1439;
					end

					SELECT @personID=Prs_ID from TA_Person where Prs_Barcode=@barcode
					SELECT @PermitId=Permit_ID from TA_Permit where Permit_PersonId =@personID and Permit_FromDate=dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10),@date,101))
					if @PermitId > 0  and  @pishcart in (51,52,53,54,55,21,22,23,24,25,26,27,12) 
					begin
						if(exists(select permitpair_ID from ta_permitpair where permitpair_permitid=@permitid and permitpair_from=@time and permitpair_to=@etime 
																					  and permitpair_pishcardid=@pishcart))
						begin
							update 	ta_permitpair	set  permitpair_from=@time,permitpair_to=@etime,permitpair_pishcardid=@pishcart
							where permitpair_permitid=@permitid and permitpair_from=@time and permitpair_to=@etime
																					  and permitpair_pishcardid=@pishcart 
						end					
						else					
							insert into ta_permitpair (permitpair_permitid,permitpair_pishcardid,permitpair_from,permitpair_to,permitpair_isfilled)
							values (@permitid,@pishcart,@time,@etime,@filled)																  
					end
					if @pishcart in (51,52,53,54,55,21,22,23,24,25,26,27,12) 
						and not exists(select * from TA_Permit where Permit_PersonId =@personID and Permit_FromDate=dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10),@date,101)))
					begin
						SET @datetime=dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10),@date,101));
						INSERT INTO TA_Permit (Permit_PersonId,Permit_ToDate,Permit_FromDate,Permit_IsPairly)
						VALUES (@personID,@datetime,@datetime,1)
						Set @PermitId=Scope_Identity()
						
						if @PermitId<>0
						 begin
							INSERT INTO TA_PermitPair (PermitPair_PermitId,PermitPair_PishCardID,PermitPair_From,PermitPair_To,PermitPair_IsFilled)
							VALUES (@PermitId,@pishcart,@time,@etime,@filled)
						 end
					end
					else
					begin
						select @PermitId=Permit_ID from TA_Permit where Permit_PersonId =@personID and Permit_FromDate=dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10),@date,101))
					end
					
					
					FETCH NEXT FROM PesmitCrsor
					INTO @barcode,@date,@time,@etime,@pishcart
				END
				end try
				begin catch
				exec spr_GetTriggerLog 
				end catch
				CLOSE PesmitCrsor
				DEALLOCATE PesmitCrsor

			END'
						
			exec(@str_)
		
			if  exists(select id from sysobjects where xtype = 'tr' and name = 'trg_PermitConvertDLT' + @tbl_name)
			Begin
				set @str_= ' DROP TRIGGER  trg_PermitConvertDLT' + @tbl_name
				exec(@str_)
			END			
			set @str_ = 
			'CREATE TRIGGER trg_PermitConvertDLT' + @tbl_name + '
			ON ' + @tbl_name + ' AFTER DELETE
			AS
			BEGIN
				DECLARE	@time int,@etime int,@date varchar(10),@pishcart int,@personID int,@barcode varchar(10),@PermitId int,@filled bit
						,@datetime datetime
				
				DECLARE PesmitCrsor CURSOR
				FOR SELECT clock_barcode,clock_date,clock_time,clock_etime,clock_RecState FROM  deleted
					WHERE clock_barcode in (SELECT p_barcode from persons)
				
				OPEN PesmitCrsor	
				FETCH NEXT FROM PesmitCrsor
				INTO @barcode,@date,@time,@etime,@pishcart
				
				BEGIN 
				TRY			
				
				WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @PermitId=0
				   	SET @filled=1
					IF @time is null or @etime is null
					BEGIN
						SET @filled=0
					END
					IF @etime = 0
					BEGIN 
						SET @etime=1439;
					END

					SELECT @personID=Prs_ID 
					FROM TA_Person 
					WHERE Prs_Barcode=@barcode
					
					SELECT @PermitId=Permit_ID 
					FROM TA_Permit 
					WHERE Permit_PersonId =@personID 
						AND 
						  Permit_FromDate=dbo.GTS_ASM_ShamsiToMiladi(CONVERT(VARCHAR(10),@date,101))
						  
					IF @PermitId > 0  
						AND  
					   @pishcart IN (51,52,53,54,55,21,22,23,24,25,26,27,12) 
					BEGIN
						IF(EXISTS(SELECT permitpair_ID 
								  FROM ta_permitpair 
								  WHERE permitpair_permitid = @permitid 
											AND permitpair_from = @time 
											AND permitpair_to = @etime 																					  
										    AND permitpair_pishcardid = @pishcart))
						BEGIN							
							DELETE FROM TA_PermitPair							
							WHERE permitpair_permitid = @permitid 
									AND 
								  permitpair_from = @time 
									AND 
								  permitpair_to = @etime
									AND 
								  permitpair_pishcardid = @pishcart 
						END					
					end
				
					
					FETCH NEXT FROM PesmitCrsor
					INTO @barcode,@date,@time,@etime,@pishcart
				END
				END TRY
				BEGIN CATCH
				EXEC spr_GetTriggerLog 
				END CATCH
				CLOSE PesmitCrsor
				DEALLOCATE PesmitCrsor

			END'
						
			exec(@str_)
		
		if  exists(select id from sysobjects where xtype='tr' and name='trg_INS_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger trg_INS_CFP_'+@tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_INS_CFP_'+@tbl_name+' ON '+@tbl_name+' AFTER insert AS '+
			'BEGIN ' + 
			' SET NOCOUNT ON; 
		   	  begin try ' + 
			' insert into TA_Calculation_Flag_Persons ' + 
			' select Clock_BarCode,Clock_Date from inserted ' + 
			' WHERE Clock_BarCode IS NOT NULL ' +	
			' end try
			  begin catch
			  exec spr_GetTriggerLog 
			  end catch '+		
			'END '
			exec(@str_)
		
		if  exists(select id from sysobjects where xtype='tr' and name='trg_UPD_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger  trg_UPD_CFP_' + @tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_UPD_CFP_'+@tbl_name+' ON '+@tbl_name+' AFTER update AS ' +
			'BEGIN ' +
			' SET NOCOUNT ON; ' + 
			' begin try ' +
			' insert into TA_Calculation_Flag_Persons ' + 
			' select Clock_BarCode,Clock_Date from inserted ' + 
			' WHERE Clock_BarCode IS NOT NULL ' +	
			' end try
			  begin catch
			  exec spr_GetTriggerLog 
			  end catch '+			
			'END '
			exec(@str_)
		
	END
---------------------------------------------
	if @typ_='a'
	begin
	
	if  exists(select id from sysobjects where xtype='tr' and name='trg_DEL_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger  trg_DEL_CFP_'+@tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_DEL_CFP_'+@tbl_name+' ON '+@tbl_name+' AFTER delete AS ' +
			'BEGIN SET NOCOUNT ON; 
			 begin try ' + 					
			' insert into TA_Calculation_Flag_Persons ' + 
			' select e_pcode,'''+SUBSTRING(@tbl_name,2,4)+'/'+SUBSTRING(@tbl_name,6,2)+'/01'+''' from deleted ' + 
			' WHERE e_pcode IS NOT NULL ' +											
			' end try
			  begin catch
			  exec spr_GetTriggerLog 
			  end catch '+	
			'END '
		    exec(@str_)
		    
    if  exists(select id from sysobjects where xtype='tr' and name='trg_INS_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger  trg_INS_CFP_'+@tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_INS_CFP_'+@tbl_name+' ON '+@tbl_name+' AFTER insert AS ' +
			'BEGIN SET NOCOUNT ON; 
			  begin try ' + 
			' insert into TA_Calculation_Flag_Persons ' + 
			' select e_pcode,'''+SUBSTRING(@tbl_name,2,4)+'/'+SUBSTRING(@tbl_name,6,2)+'/01'+''' from inserted ' + 
			' WHERE e_pcode IS NOT NULL ' +									
			' end try
			  begin catch
			  exec spr_GetTriggerLog 
			  end catch '+	
			'END '
			exec(@str_)
		
		if  exists(select id from sysobjects where xtype='tr' and name='trg_UPD_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger  trg_UPD_CFP_'+@tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_UPD_CFP_'+@tbl_name+' ON '+@tbl_name+' AFTER update AS ' +
			'BEGIN SET NOCOUNT ON; 
			begin try ' + 
			' insert into TA_Calculation_Flag_Persons ' + 
			' select e_pcode,'''+SUBSTRING(@tbl_name,2,4)+'/'+SUBSTRING(@tbl_name,6,2)+'/01'+''' from inserted ' + 
			' WHERE e_pcode IS NOT NULL ' +									
			' end try
			  begin catch
			  exec spr_GetTriggerLog 
			  end catch '+	
			'END '
			exec(@str_)
	
	end
---------------------------------------------
    if  @typ_='e'
    Begin
		if  exists(select id from sysobjects where xtype='tr' and name='trg_DEL_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger  trg_DEL_CFP_'+@tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_DEL_CFP_'+@tbl_name+' ON '+@tbl_name+' AFTER delete AS ' +
			'BEGIN SET NOCOUNT ON; 
			 begin try ' + 					
			' insert into TA_Calculation_Flag_Persons ' + 
			' select e_pcode,'''+SUBSTRING(@tbl_name,2,4)+'/'+SUBSTRING(@tbl_name,6,2)+'/01'+''' from deleted ' + 
			' WHERE e_pcode IS NOT NULL ' +						
			' end try
			  begin catch
			  exec spr_GetTriggerLog 
			  end catch '+	
			'END '
			exec(@str_)
		
		if  exists(select id from sysobjects where xtype='tr' and name='trg_INS_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger  trg_INS_CFP_'+@tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_INS_CFP_'+@tbl_name+' ON '+@tbl_name+' AFTER insert AS ' +
			'BEGIN SET NOCOUNT ON; 
			  begin try ' + 
			' insert into TA_Calculation_Flag_Persons ' + 
			' select e_pcode,'''+SUBSTRING(@tbl_name,2,4)+'/'+SUBSTRING(@tbl_name,6,2)+'/01'+''' from inserted ' + 
			' WHERE e_pcode IS NOT NULL ' +									
			' declare @E_ColName varchar(10)

declare EColumns_cursor cursor
for SELECT name FROM sys.columns WHERE object_id = OBJECT_ID(''' +@tbl_name +''') AND name <>''E_PCode''

open EColumns_cursor
fetch next from EColumns_cursor
into  @E_ColName
while @@fetch_status = 0
begin
-------------------------------------------
select * into inserted_tmp from inserted
declare @sql varchar(max)
set @sql = ''
declare @pcode varchar(10) , @E_DVal int
declare @date varchar(10),@date_tmp varchar(10),@permitid decimal '' +
'' set @date = '''''' +SUBSTRING('''+@tbl_name+''',2,4)+''/''+SUBSTRING('''+@tbl_name+''',6,2)+''/'''''' +
 '' declare overtimePermit_cursor cursor
for select E_PCode,isnull(''+@E_ColName+'',0)
from inserted_tmp
open overtimePermit_cursor
fetch next from overtimePermit_cursor
into  @pcode,@E_DVal

while @@fetch_status = 0
begin
	if(@E_DVal>0)
	begin
		set  @PermitId =0
		set @date_tmp = @date + '''''''+'+SUBSTRING(@E_ColName,4,2)+'+'''''''
		SELECT @permitid=Permit_ID from TA_Permit where Permit_PersonId =dbo.GetPerson(@pcode) and Permit_FromDate=dbo.GTS_ASM_ShamsiToMiladi(@date_tmp)
		if @PermitId <= 0 or  @PermitId is null
		begin
			insert into TA_Permit (Permit_PersonId,Permit_FromDate ,Permit_ToDate ,Permit_IsPairly )
			values(dbo.GetPerson(@pcode),dbo.GTS_ASM_ShamsiToMiladi(@date_tmp),dbo.GTS_ASM_ShamsiToMiladi(@date_tmp),0)
			
			set @permitid=scope_identity()
		end			
						
		if @permitid<>0
		 begin
			insert into ta_permitpair (PermitPair_PermitId ,PermitPair_From ,PermitPair_To ,PermitPair_PishCardID ,PermitPair_IsFilled,PermitPair_Value )
			values (@permitid,0,0,125,1,@E_DVal)
		 end								
	end	
	
	fetch next from overtimePermit_cursor
    into @pcode,@E_DVal

end 
close overtimePermit_cursor
deallocate overtimePermit_cursor 
''
Execute(@sql)
drop table inserted_tmp
-------------------------------------------


fetch next from EColumns_cursor
into 
@E_ColName
end
close EColumns_cursor
deallocate EColumns_cursor 
' 
			 
			 +		
			
			' end try
			  begin catch
			  exec spr_GetTriggerLog 
			  end catch '+	
			'END '
			exec(@str_)
		
		if  exists(select id from sysobjects where xtype='tr' and name='trg_UPD_CFP_'+@tbl_name)
		Begin
			set @str_= ' drop trigger  trg_UPD_CFP_'+@tbl_name
			exec(@str_)
		END
			set @str_=
			'CREATE TRIGGER trg_UPD_CFP_'+@tbl_name+' ON '+@tbl_name+' AFTER update AS ' +
			'BEGIN SET NOCOUNT ON; 
			begin try ' + 
			' insert into TA_Calculation_Flag_Persons ' + 
			' select e_pcode,'''+SUBSTRING(@tbl_name,2,4)+'/'+SUBSTRING(@tbl_name,6,2)+'/01'+''' from inserted ' + 
			' WHERE e_pcode IS NOT NULL ' +									
			' end try
			  begin catch
			  exec spr_GetTriggerLog 
			  end catch '+	
			'END '
			exec(@str_)
		
	END
-------------------------------------------	
END



