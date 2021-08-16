Alter TRIGGER trg_InsUpdDel_init_4InsUpdDelTA_CalculationDateRangeTemplate
   ON  [init] 
   AFTER INSERT, DELETE, UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	begin try
	DECLARE @Init_Title nvarchar(30),
			@Init_Value nvarchar(30),
			@Init_Code int,
			@Init_Normal int
	DECLARE cursor_inserted CURSOR 
	FOR SELECT * FROM inserted
	OPEN cursor_inserted
	FETCH NEXT FROM cursor_inserted
	INTO @Init_Title, @Init_Value, @Init_Code
	WHILE @@FETCH_STATUS = 0
	BEGIN			 
	------------------------------
		if(@Init_Title = 'monthnormal' and @init_Value=0
			and Exists(select * from init where Init_Title='monthnormal' and Init_Value=0 and Init_Code=@init_Code))
		begin
			DELETE FROM TA_CalculationDateRangeTemplate
			WHERE calcDateRng_Param = @Init_Code
				
			INSERT INTO TA_CalculationDateRangeTemplate
				SELECT CnpTmp.ConceptTmp_ID,
						DateRange.FromDate,
						DateRange.ToDate,
						1,
						DateRange.Init_Code
				FROM		
				(SELECT @Init_Code Init_Code, normDateRng_ToDate [ToDate],normDateRng_FromDate [FromDate]
				 FROM TA_NormalDateRange
				 															
				 ) DateRange
				CROSS JOIN
				 (SELECT * FROM TA_ConceptTemplate WHERE ConceptTmp_IsRangely = 1) CnpTmp
		end
		else
		begin	
		IF (@Init_Title = 'monthends')
		BEGIN
			IF (SUBSTRING(@Init_Value, 1, LEN(@Init_Value) - 2) = 12)
			BEGIN							

				DELETE FROM TA_CalculationDateRangeTemplate
				WHERE calcDateRng_Param = @Init_Code
				
				INSERT INTO TA_CalculationDateRangeTemplate
				SELECT CnpTmp.ConceptTmp_ID,
						DateRange.FromDate,
						DateRange.ToDate,
						1,
						DateRange.Init_Code
				FROM		
				(SELECT @Init_Code Init_Code, dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10),'1388' +	'/' +
		   														 SUBSTRING(Init_Value, 1, LEN(Init_Value) - 2) + '/' +
																 SUBSTRING(Init_Value, LEN(Init_Value) - 1, LEN(Init_Value)),101)) [ToDate],
											  dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10),dbo.GetFromDateOFInit(@Init_Code, 
																	1388, 
																	SUBSTRING(Init_Value, 1, LEN(Init_Value) - 2)),101)) [FromDate]
				 FROM init
				 WHERE Init_Title = 'monthends' 
						AND
					   Init_Code = @Init_Code																
				 ) DateRange
				CROSS JOIN
				 (SELECT * FROM TA_ConceptTemplate WHERE ConceptTmp_IsRangely = 1) CnpTmp
				 
				INSERT INTO TA_CalculationDateRangeTemplate
				SELECT CnpTmp.ConceptTmp_ID,
						DateRange.FromDate,
						DateRange.ToDate,
						1,
						DateRange.Init_Code
				FROM		
				(SELECT @Init_Code Init_Code, dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10),'1389' +	'/' +
		   														 SUBSTRING(Init_Value, 1, LEN(Init_Value) - 2) + '/' +
																 SUBSTRING(Init_Value, LEN(Init_Value) - 1, LEN(Init_Value)),101)) [ToDate],
											  dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10),dbo.GetFromDateOFInit(@Init_Code, 
																	1389, 
																	SUBSTRING(Init_Value, 1, LEN(Init_Value) - 2)),101)) [FromDate]
				 FROM init
				 WHERE Init_Title = 'monthends' 
						AND
					   Init_Code = @Init_Code																
				 ) DateRange
				CROSS JOIN
				 (SELECT * FROM TA_ConceptTemplate WHERE ConceptTmp_IsRangely = 1) CnpTmp
				 
			 END		 
		 END
		 end
		FETCH NEXT FROM cursor_inserted
		INTO @Init_Title, @Init_Value, @Init_Code		 
	END
	CLOSE cursor_inserted
	DEALLOCATE cursor_inserted
	
	
DELETE dbo.TA_CalculationDateRangeTemplate
WHERE calcDateRng_CnpTmpId = 111

DELETE dbo.TA_ConceptTemplate
WHERE ConceptTmp_ID = 111
/*
update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 24)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 25)

DELETE dbo.TA_CalculationDateRangeTemplate
WHERE calcDateRng_CnpTmpId = 110

DELETE dbo.TA_ConceptTemplate
WHERE ConceptTmp_ID = 110

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 23)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 27)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 23)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 28)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 34)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 35)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 36)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 40)

DELETE dbo.TA_CalculationDateRangeTemplate
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 45)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 42)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 46)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 47)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 49)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 56)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 58)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 2)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 76)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 2)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 19)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 52)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 79)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 367)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 82)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 83)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 84)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 34)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 85)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 92)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 95)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 93)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 96)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 91)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 97)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 94)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 98)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 100)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 121)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 119)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 122)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 99)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 123)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 99)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 41)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 120)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 124)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 125)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 127)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 126)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 128)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 4)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 130)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 132)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 75)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 6)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 155)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 13)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 156)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 113)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 157)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 112)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 158)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 112)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 159)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 106)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 160)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 1)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 78)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 225)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 226)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 375)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 374)


update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 64)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 65)

----------------------------------

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 330)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 335)


update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 331)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 336)


update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 332)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 337)


update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 333)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 338)


update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 334)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 339)


update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 317)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 501)


update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 315)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 502)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 323)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 503)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 319)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 504)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 321)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 505)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 517)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 527)

--„›ÂÊ„ „«Â«‰Â 529 ‘«„· ç‰œ „›ÂÊ„ «” 
insert into TA_CalculationDateRangeTemplate 
(calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type ,calcDateRng_CnpTmpId)
select calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type 
,(SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 519) 
from TA_CalculationDateRangeTemplate 
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =529) 

insert into TA_CalculationDateRangeTemplate 
(calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type ,calcDateRng_CnpTmpId)
select calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type 
,(SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 521) 
from TA_CalculationDateRangeTemplate 
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =529)

insert into TA_CalculationDateRangeTemplate 
(calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type ,calcDateRng_CnpTmpId)
select calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type 
,(SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 523) 
from TA_CalculationDateRangeTemplate 
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =529)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 525)
where calcDateRng_CnpTmpId in (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =529)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 507)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 526)

--„›ÂÊ„ „«Â«‰Â 528 ‘«„· ç‰œ „›ÂÊ„ «” 
insert into TA_CalculationDateRangeTemplate 
(calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type ,calcDateRng_CnpTmpId)
select calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type 
,(SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 509) 
from TA_CalculationDateRangeTemplate 
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =528)

insert into TA_CalculationDateRangeTemplate 
(calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type ,calcDateRng_CnpTmpId)
select calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type 
,(SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 511) 
from TA_CalculationDateRangeTemplate 
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =528)

insert into TA_CalculationDateRangeTemplate 
(calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type ,calcDateRng_CnpTmpId)
select calcDateRng_FromDate,calcDateRng_ToDate,calcDateRng_Param,calcDateRng_Type 
,(SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 513) 
from TA_CalculationDateRangeTemplate 
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =528)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =515)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 528)


update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 531)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =532)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 62)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =622)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 63)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =623)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 60)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =624)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 183)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =625)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 185)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =626)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 186)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =627)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 187)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =628)

update dbo.TA_CalculationDateRangeTemplate
set calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode = 188)
where calcDateRng_CnpTmpId = (SELECT ConceptTmp_ID FROM TA_ConceptTemplate WHERE ConceptTmp_IdentifierCode =629)
	*/
	end try
	begin catch
			exec spr_GetTriggerLog 
	end catch
END
GO
			
