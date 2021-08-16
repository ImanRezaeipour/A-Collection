select * from ta_shifttype
select * from ta_shift

update ta_shift set Shift_MinNobatKari=0,Shift_Breakfast=0,Shift_Lunch=0,Shift_Dinner=0
select * from [clock].dbo.shifts
delete from ta_shift
insert into TA_shift 
(shift_name,Shift_CustomCode,Shift_Color)
select sh_name,sh_code,'' from [clock].dbo.shifts


insert into ta_shiftpair
(ShiftPair_ShiftId,ShiftPair_From,ShiftPair_To,ShiftPair_AfterTolerance,ShiftPair_BeforeTolerance)
select Shift_ID,sh_from1,sh_to1,0,0 from [clock].dbo.shifts
join ta_shift on shift_customcode=sh_code