create function GetPerson(@barcode varchar(8))
returns numeric
as
begin
set @barcode= RIGHT('00000000' + CONVERT(VARCHAR,@barcode), 8);
declare @perondid numeric
select @perondid=prs_id from ta_person where prs_barcode=@barcode
return @perondid
end