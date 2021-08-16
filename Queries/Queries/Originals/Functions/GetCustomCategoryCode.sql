
CREATE FUNCTION GetCustomCategoryCode 
(
	@Rule_Code int,
	@Column_Name nvarchar(20)
)
RETURNS nvarchar(20)
AS
BEGIN
	DECLARE @Prifix nvarchar(2) 
	SET @Prifix = SUBSTRING(@Column_Name, 1, 1)
	IF @Prifix = 'e' return Convert(nvarchar(20), @Rule_Code) + '_1'
	IF @Prifix = 'g' return Convert(nvarchar(20), @Rule_Code) + '_2'
	SET @Prifix = SUBSTRING(@Column_Name, 1, 2)
	IF @Prifix = 'mo' return Convert(nvarchar(20), @Rule_Code) + '_3'
	IF @Prifix = 'ma' return Convert(nvarchar(20), @Rule_Code) + '_4'
	return Convert(nvarchar(20), @Rule_Code) + '_5'
END
GO

