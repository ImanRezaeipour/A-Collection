Alter Procedure sp_LeaveBudgetPopulateByBarcodeYear  @barcode varchar(8) , @year int
AS

declare @Rule_Code int,@customeBudget int,@tmp int,@budgetYearID int
		,@dayMinutes int,@maxBrow int
		,@AllLeaveCount int
		,@budgetd1 int ,@budgeth1 int
		,@budgetd2 int ,@budgeth2 int
		,@budgetd3 int ,@budgeth3 int
		,@budgetd4 int ,@budgeth4 int
		,@budgetd5 int ,@budgeth5 int
		,@budgetd6 int ,@budgeth6 int
		,@budgetd7 int ,@budgeth7 int
		,@budgetd8 int ,@budgeth8 int
		,@budgetd9 int ,@budgeth9 int
		,@budgetd10 int ,@budgeth10 int
		,@budgetd11 int ,@budgeth11 int
		,@budgetd12 int ,@budgeth12 int
		
SELECT @Rule_Code =P_RuleGroup  from persons  WHERE P_BarCode=@barcode 

SELECT @budgetYearID=BudgetYear_ID from TA_BudgetYear where BudgetYear_PersonId =dbo.GetPerson(@barcode) and BudgetYear_Year=@year
	  		
SELECT @AllLeaveCount=isnull(Rule_MOEY,0),@customeBudget=isnull(Rule_moeylist,0) 	
			  ,@dayMinutes=isnull(Rule_MOHR	,0),@maxBrow =isnull(Rule_moeneg ,0)
			  ,@budgetd1=isnull(Rule_moeyd1,0),@budgeth1=isnull(Rule_moeyh1 ,0)
			  ,@budgetd2=isnull(Rule_moeyd2,0),@budgeth2=isnull(Rule_moeyh2 ,0)
			  ,@budgetd3=isnull(Rule_moeyd3,0),@budgeth3=isnull(Rule_moeyh3 ,0)
			  ,@budgetd4=isnull(Rule_moeyd4,0),@budgeth4=isnull(Rule_moeyh4 ,0)
			  ,@budgetd5=isnull(Rule_moeyd5,0),@budgeth5=isnull(Rule_moeyh5 ,0)
			  ,@budgetd6=isnull(Rule_moeyd6,0),@budgeth6=isnull(Rule_moeyh6 ,0)
			  ,@budgetd7=isnull(Rule_moeyd7,0),@budgeth7=isnull(Rule_moeyh7 ,0)
			  ,@budgetd8=isnull(Rule_moeyd8,0),@budgeth8=isnull(Rule_moeyh8 ,0)
			  ,@budgetd9=isnull(Rule_moeyd9,0),@budgeth9=isnull(Rule_moeyh9 ,0)
			  ,@budgetd10=isnull(Rule_moeyd10,0),@budgeth10=isnull(Rule_moeyh10 ,0)
			  ,@budgetd11=isnull(Rule_moeyd1,0),@budgeth11=isnull(Rule_moeyh11,0)
			  ,@budgetd12=isnull(Rule_moeyd12,0),@budgeth12=isnull(Rule_moeyh12 ,0)		 		
			  from rulesetc where Rule_Code=@Rule_Code 
 
		update TA_BudgetYear set BudgetYear_Maxborrow=@maxBrow where BudgetYear_ID=@budgetYearID
				
		 if(@dayMinutes =0 )
		 begin
			set @dayMinutes=480;
		 end
		 
		 if @customeBudget = 0
		 begin
			set @tmp = (@AllLeaveCount*@dayMinutes) / 12 ;
			set @budgetd1 =0;	set @budgeth1=@tmp;
			set @budgetd2 =0;	set @budgeth2=@tmp;
			set @budgetd3 =0;	set @budgeth3=@tmp;
			set @budgetd4 =0;	set @budgeth4=@tmp;
			set @budgetd5 =0;	set @budgeth5=@tmp;
			set @budgetd6 =0;	set @budgeth6=@tmp;
			set @budgetd7 =0;	set @budgeth7=@tmp;
			set @budgetd8 =0;	set @budgeth8=@tmp;
			set @budgetd9 =0;	set @budgeth9=@tmp;
			set @budgetd10 =0;	set @budgeth10=@tmp;
			set @budgetd11 =0;	set @budgeth11=@tmp;
			set @budgetd12 =0;	set @budgeth12=@tmp;			
		 end
		 
	 update TA_Budget set 
	  LeaveBud_t1 = @budgetd1*@dayMinutes+@budgeth1 , LeaveBud_calc_t1 = @budgetd1*@dayMinutes+@budgeth1 
	 ,LeaveBud_t2 = @budgetd2*@dayMinutes+@budgeth2 , LeaveBud_calc_t2 = @budgetd2*@dayMinutes+@budgeth2 
	 ,LeaveBud_t3 = @budgetd3*@dayMinutes+@budgeth3 , LeaveBud_calc_t3 = @budgetd3*@dayMinutes+@budgeth3 
	 ,LeaveBud_t4 = @budgetd4*@dayMinutes+@budgeth4 , LeaveBud_calc_t4 = @budgetd4*@dayMinutes+@budgeth4 
	 ,LeaveBud_t5 = @budgetd5*@dayMinutes+@budgeth5 , LeaveBud_calc_t5 = @budgetd5*@dayMinutes+@budgeth5 
	 ,LeaveBud_t6 = @budgetd6*@dayMinutes+@budgeth6 , LeaveBud_calc_t6 = @budgetd6*@dayMinutes+@budgeth6 
	 ,LeaveBud_t7 = @budgetd7*@dayMinutes+@budgeth7 , LeaveBud_calc_t7 = @budgetd7*@dayMinutes+@budgeth7 
	 ,LeaveBud_t8 = @budgetd8*@dayMinutes+@budgeth8 , LeaveBud_calc_t8 = @budgetd8*@dayMinutes+@budgeth8 
	 ,LeaveBud_t9 = @budgetd9*@dayMinutes+@budgeth9 , LeaveBud_calc_t9 = @budgetd9*@dayMinutes+@budgeth9 
	 ,LeaveBud_t10 = @budgetd10*@dayMinutes+@budgeth10 , LeaveBud_calc_t10 = @budgetd10*@dayMinutes+@budgeth10 
	 ,LeaveBud_t11 = @budgetd11*@dayMinutes+@budgeth11 , LeaveBud_calc_t11 = @budgetd11*@dayMinutes+@budgeth11
	 ,LeaveBud_t12 = @budgetd12*@dayMinutes+@budgeth12 , LeaveBud_calc_t12 = @budgetd12*@dayMinutes+@budgeth12
	 where LeaveBud_ID =@budgetYearID 
		
	
	 update TA_UsedBudget set 
	  UsedBudget_t1 = 0	 ,UsedBudget_t2 = 0	 ,UsedBudget_t3 = 0	 ,UsedBudget_t4 = 0	 
	  ,UsedBudget_t5 = 0	 ,UsedBudget_t6 = 0	 ,UsedBudget_t7 = 0	 ,UsedBudget_t8 = 0
	 ,UsedBudget_t9 = 0	 ,UsedBudget_t10 = 0	 ,UsedBudget_t11 = 0	 ,UsedBudget_t12 = 0
	 
	 where UsedBudget_ID =@budgetYearID 
	  
	  delete from TA_UsedBudgetDetail where usedDtl_UsedBudgetID =@budgetYearID 	  
	  /*
	   update TA_LeaveIncDec set  LeaveIncDec_Applyed = 0
	 where LeaveIncDec_LeaveYearId =@budgetYearID 
	 */
	 
	 	delete from TA_LeaveIncDec where LeaveIncDec_LeaveYearId=@budgetYearID 
		
		insert into TA_LeaveIncDec (LeaveIncDec_LeaveYearId ,LeaveIncDec_Date,LeaveIncDec_DayValue,LeaveIncDec_TimeValue ,LeaveIncDec_Description,LeaveIncDec_Applyed  )
		select @budgetYearID,dbo.GTS_ASM_ShamsiToMiladi(CONVERT(varchar(10), Spm_Date ,101)),Spm_Days ,Spm_time,Spm_Remark,0   
		from spmor where Spm_PCode=@barcode and  LEFT(Spm_Date,4)=@year   