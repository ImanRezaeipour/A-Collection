select P_Code  from parts  group by P_Code having COUNT(*) > 1
select * from parts where P_Code=120701
--select * from parts where P_CustomCode =120702
--update parts set p_code=1207010 where  P_CustomCode =120702

----------------------------------------------------

select Mor_PCode ,Mor_Year  from morkhasi group by Mor_PCode ,Mor_Year  having COUNT(*)>1

select * from morkhasi where Mor_PCode ='00666657' and Mor_Year  =1386

--delete from morkhasi where Mor_PCode ='00547451' and Mor_Year  =1385 and Mor_D2 =-1
--delete from morkhasi where Mor_PCode ='00666657' and Mor_Year  =1386 and Mor_DRemain is null
--delete from morkhasi where Mor_PCode ='00079889' and Mor_Year  =1386 and Mor_DRemain is null



-------------------------------------------------------
--delete from grp_dtl where Grd_Code not in (select grp_code from groups )
