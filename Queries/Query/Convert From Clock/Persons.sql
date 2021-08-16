INSERT INTO TA_Person
(
	-- Prs_ID -- this column value is auto-generated,
	Prs_Barcode,
	Prs_Active,
	Prs_CardNum,
	Prs_DepartmentId,
	Prs_EmploymentNum,
	Prs_EmploymentDate,
	Prs_ControlStationId,
	Prs_EndEmploymentDate,
	Prs_EmployId,
	Prs_Sex,
	Prs_Education,
	Prs_FirstName,
	Prs_MaritalStatus,
	Prs_LastName,
	
	Prs_UIValidationGroupID
)

SELECT 
	/* Prs_Barcode	*/P_BarCode,
	/* Prs_Active	*/1,
	/* Prs_CardNum	*/P_BarCode,
	/* Prs_DepartmentId	*/convert(numeric,p_parts),
	/* Prs_EmploymentNum	*/P_BarCode,
	/* Prs_EmploymentDate	*/'2000-01-01',
	/* Prs_ControlStationId	*/32549,
	/* Prs_EndEmploymentDate	*/NULL,
	/* Prs_EmployId	*/8974,
	/* Prs_Sex	*/0,
	/* Prs_Education	*/'',
	/* Prs_FirstName	*/P_Name,
	/* Prs_MaritalStatus	*/1,
	/* Prs_LastName	*/P_Family,
	/* Prs_UIValidationGroupID	*/3
	FROM [clock].dbo.persons p
	

---------------------------------------------
--
INSERT INTO dbo.TA_PersonDetail(PrsDtl_ID,PrsDtl_MeliCode)
SELECT prs_ID,p_melicode FROM TA_Person tp
JOIN [clock].dbo.persons p
ON p.P_BarCode=tp.Prs_Barcode	

update ta_person set Prs_PrsDtlID=prs_id