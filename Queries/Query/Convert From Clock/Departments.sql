select * from ta_department where dep_id=162
select * from ta_department where dep_parentid=162


insert into ta_department
(dep_id,dep_customcode,dep_name,dep_parentid)
select convert(numeric,p_code),p_customcode,p_name,convert(numeric,p_father) from [clock].dbo.parts

update ta_department 
set dep_parentid=162
where dep_parentid=-1