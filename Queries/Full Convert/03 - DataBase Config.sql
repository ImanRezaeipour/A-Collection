BEGIN TRANSACTION DatabaseConfig

BEGIN -- تنظیم دیتابیس 

    ALTER TABLE ta_person ALTER COLUMN prs_barcode
    NVARCHAR(50) COLLATE Arabic_CI_AS;
    ALTER TABLE clock.dbo.persons ALTER COLUMN p_parts
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;
	ALTER TABLE clock.dbo.persons ALTER COLUMN P_BarCode
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;
    ALTER TABLE clock.dbo.webpasspersons ALTER COLUMN barcode
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;
	ALTER TABLE clock.dbo.webpasspersons ALTER COLUMN personbarcode
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;
    ALTER TABLE clock.dbo.webpass ALTER COLUMN p_status
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;
	ALTER TABLE clock.dbo.webpass ALTER COLUMN p_barcode
    NVARCHAR(MAX) COLLATE Arabic_CI_AS;
	--DROP INDEX BCodeIdx ON clock.dbo.persons
	--ALTER TABLE clock.dbo.persons
	--DROP CONSTRAINT PK__persons__0DDB8BE7

END 

COMMIT TRANSACTION DatabaseConfig