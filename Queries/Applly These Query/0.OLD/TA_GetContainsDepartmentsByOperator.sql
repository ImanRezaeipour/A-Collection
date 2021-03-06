
Create function [dbo].[TA_GetContainsDepartmentsByOperator] (@personId numeric)
RETURNS @department table
(
[dep_ID] [numeric](18, 0)
)
as
begin
insert into @department
select dep.dep_ID from TA_UnderManagment 
join TA_Department dep on dep_ParentPath like('%,'+CONVERT(varchar(250),underMng_DepartmentID) +',%')
where underMng_FlowID in (select opr_FlowId from TA_Operator where opr_PersonId=@personId) 
and underMng_Contains=1 and underMng_PersonID is null
and underMng_ContainInnerChilds =1
and dep_ID not in (
select underMng_DepartmentID from TA_UnderManagment 
where underMng_FlowID in (select opr_FlowId from TA_Operator where opr_PersonId=@personId) 
 and underMng_Contains=0 and underMng_PersonID is null)
and dep_ID not in (
select dep_ID from TA_UnderManagment 
join TA_Department dep on dep_ParentPath like('%,'+CONVERT(varchar(250),underMng_DepartmentID) +',%')
where underMng_FlowID in (select opr_FlowId from TA_Operator where opr_PersonId=@personId) 
 and underMng_Contains=0 and underMng_PersonID is null
and underMng_ContainInnerChilds =1)

union

select dep_ID from TA_Department where dep_ID in 
(select underMng_DepartmentID from TA_UnderManagment where
underMng_FlowID in (select opr_FlowId from TA_Operator where opr_PersonId=@personId)  and  
((underMng_PersonID is not null) OR (underMng_PersonID is null and underMng_Contains=1)))
return
end
