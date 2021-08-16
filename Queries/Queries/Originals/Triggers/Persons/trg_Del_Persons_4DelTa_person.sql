CREATE TRIGGER trg_Del_Persons_4DelTa_person
   ON   persons
   AFTER Delete
AS 
BEGIN
	SET NOCOUNT ON;
begin try
  delete TA_Person where Prs_Barcode in (select p_barcode from deleted)
  end try
  begin catch
	exec spr_GetTriggerLog 
	end catch
END
GO
