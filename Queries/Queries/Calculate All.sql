-- انجام محاسبات برای همه پرسنل

DECLARE @CFP_PrsId NUMERIC(18,0)
DECLARE @Date DATE

-- تاریخ را به شمسی وارد کنید

SET @Date = dbo.GTS_ASM_ShamsiToMiladi('1392/03/11')

DECLARE Table_Cursor CURSOR
FOR
SELECT Prs_ID FROM TA_Person
WHERE [Prs_Active] = '1' and [Prs_IsDeleted] = '0'
OPEN Table_Cursor FETCH NEXT FROM Table_Cursor INTO @CFP_PrsId
WHILE (@@FETCH_STATUS = 0)
BEGIN
	 EXECUTE [dbo].[spr_UpdateCFP] @CFP_PrsId, @Date 
	 PRINT @CFP_PrsId
	 FETCH NEXT FROM Table_Cursor INTO @CFP_PrsId
END 
CLOSE Table_Cursor 
DEALLOCATE Table_Cursor
