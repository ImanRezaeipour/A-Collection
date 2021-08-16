------------------------------------------
-- EXEC spr_InitPriodics 30
------------------------------------------
ALTER PROC spr_InitPriodics(@rule_Code int)
AS
BEGIN
BEGIN TRANSACTION T1

	SELECT p1.ScndCnp_ID RanglyCnp, p2.ScndCnp_ID detilCnp INTO PriodicTMP 
	FROM (SELECT TA_SecondaryConcept.ScndCnp_ID,TA_PeriodicScndCnpDetailTemplate.PeriodicScndCnpDetail_ID  
		  FROM TA_CategoryPart 
			JOIN  
			   TA_ObjectCategory 
			ON ObjCat_CategoryId = CatPart_ChildCatId
			JOIN 
			   TA_SecondaryConcept 
			ON ScndCnp_ID = ObjCat_ObjectId 
			JOIN TA_PeriodicScndCnpDetailTemplate 
			ON ScndCnp__CnpTmpID = periodicscndcnpdetail_periodicscndcnpid
		  WHERE CatPart_ParentCatId in (SELECT Cat_ID 
										FROM  TA_Category 
										WHERE Cat_CustomCode = '00' + CONVERT(VARCHAR(5), @rule_Code))
		 ) AS p1
	  JOIN
		(SELECT TA_SecondaryConcept.ScndCnp_ID,TA_PeriodicScndCnpDetailTemplate.PeriodicScndCnpDetail_ID  
		 FROM TA_CategoryPart 
		   JOIN  
		      TA_ObjectCategory 
		   ON ObjCat_CategoryId = CatPart_ChildCatId
		   JOIN 
			  TA_SecondaryConcept 
		   ON ScndCnp_ID = ObjCat_ObjectId 
		   join 
		      TA_PeriodicScndCnpDetailTemplate 
		   ON ScndCnp__CnpTmpID = PeriodicScndCnpDetail_DetailScndCnpID
		 WHERE CatPart_ParentCatId IN (SELECT Cat_ID 
									   FROM  TA_Category 
									   WHERE Cat_CustomCode = '00' + CONVERT(VARCHAR(5), @rule_Code))
        ) AS p2
	  ON p1.PeriodicScndCnpDetail_ID = p2.PeriodicScndCnpDetail_ID 
				
	DELETE FROM TA_PeriodicScndCnpDetail 
		   WHERE TA_PeriodicScndCnpDetail.PeriodicScndCnpDetail_PeriodicScndCnpID in (SELECT RanglyCnp FROM PriodicTMP)

	INSERT INTO TA_PeriodicScndCnpDetail 		
		SELECT * FROM PriodicTMP		
		
	DROP TABLE PriodicTMP		
COMMIT TRANSACTION T1
		
END