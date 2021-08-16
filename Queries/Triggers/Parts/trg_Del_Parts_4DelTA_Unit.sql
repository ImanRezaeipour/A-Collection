CREATE TRIGGER trg_Del_Parts_4DelTA_Unit
   ON  parts
   AFTER delete
AS 
BEGIN
SET NOCOUNT ON;
begin try
delete TA_Unit where Unit_ID in (select p_code from deleted)
end try
begin catch
exec spr_GetTriggerLog 
end catch
END
GO
