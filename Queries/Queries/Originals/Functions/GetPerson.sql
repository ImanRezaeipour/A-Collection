create function GetPerson(@barcode varchar(8))
returns numeric
as
begin
declare @perondid numeric
select @perondid=prs_id from ta_person where Convert(int,prs_barcode)=Convert(int,@barcode)
return @perondid
end