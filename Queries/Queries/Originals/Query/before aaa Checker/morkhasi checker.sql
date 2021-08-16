select Mor_PCode,mor_year,COUNT(*) from morkhasi
group by Mor_PCode,mor_year
having COUNT(*) > 1

select * from morkhasi where Mor_PCode ='00010269' and Mor_Year=1389


	select budgetyear_personid,budgetyear_year,COUNT(*) from TA_BudgetYear
	group by budgetyear_personid,budgetyear_year
	having count(*)>1 and budgetyear_personid is not null
	
