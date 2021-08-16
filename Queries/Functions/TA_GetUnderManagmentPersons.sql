
CREATE FUNCTION [dbo].[TA_GetUnderManagmentPersons]
(	
	@FlowId numeric
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT Prs_Id 
	FROM TA_Person
	WHERE Prs_ID IN (SELECT underMng_PersonID
					 FROM TA_UnderManagment
					 WHERE underMng_FlowID = @FlowId
							AND
						  underMng_Contains = 1
							AND
						  underMng_PersonID IS NOT NULL
				    )
			OR
		  Prs_ID in (SELECT Prs.Prs_ID
					 FROM (SELECT * 
						   FROM TA_UnderManagment
						   WHERE underMng_FlowID = @FlowId
									AND
								 underMng_PersonID IS NULL
									AND
								 underMng_Contains = 1
									AND
								 underMng_ContainInnerChilds = 0) UnderMngDep
					 INNER JOIN	TA_Person Prs
					 ON Prs.Prs_DepartmentId = UnderMngDep.underMng_DepartmentID
					 WHERE Prs.Prs_ID NOT IN (SELECT underMng_PersonID
											  FROM TA_UnderManagment
											  WHERE underMng_FlowID = @FlowId
											 		 AND
												   underMng_Contains = 0
													 AND
												   underMng_PersonID IS NOT NULL)										   																			   
					)
			OR
		 Prs_ID IN (SELECT Prs.Prs_ID
					FROM (SELECT * 
					      FROM TA_UnderManagment
						  WHERE underMng_FlowID = @FlowId
									AND
								 underMng_PersonID IS NULL
									AND
								 underMng_Contains = 1
									AND
								 underMng_ContainInnerChilds = 1) UnderMngDep
					INNER JOIN TA_Person Prs
					ON 	Prs.Prs_DepartmentId IN (SELECT Dep.dep_ID 
												 FROM TA_Department Dep
												 WHERE dep_ParentPath LIKE '%,' + CONVERT(nvarchar(max), UnderMngDep.underMng_DepartmentID) + ',%'
												)
							OR								 
						Prs.Prs_DepartmentId = UnderMngDep.underMng_DepartmentID
					WHERE Prs.Prs_ID NOT IN (SELECT Prs.Prs_ID
										 	 FROM (SELECT * 
											 	   FROM TA_UnderManagment
												   WHERE underMng_FlowID = @FlowId
															AND
														 underMng_PersonID IS NULL
															AND
														 underMng_Contains = 0
															AND
														 underMng_ContainInnerChilds = 1) UnderMngDep
											 	   INNER JOIN TA_Person Prs
												   ON 	Prs.Prs_DepartmentId IN (SELECT Dep.dep_ID 
																				 FROM TA_Department Dep
																				 WHERE dep_ParentPath LIKE '%,' + CONVERT(nvarchar(max), UnderMngDep.underMng_DepartmentID) + ',%'
																				)
															OR								 
														Prs.Prs_DepartmentId = UnderMngDep.underMng_DepartmentID
										    )
							AND
						 Prs.Prs_ID NOT IN (SELECT Prs.Prs_ID
										 	 FROM (SELECT * 
											 	   FROM TA_UnderManagment
												   WHERE underMng_FlowID = @FlowId
															AND
														 underMng_PersonID IS NULL
															AND
														 underMng_Contains = 0
															AND
														 underMng_ContainInnerChilds = 0) UnderMngDep
											 INNER JOIN TA_Person Prs
											 ON Prs.Prs_DepartmentId = underMng_DepartmentID
										   )
				   )	
		    AND
		  Prs_ID NOT IN (SELECT underMng_PersonID
						 FROM TA_UnderManagment
					     WHERE underMng_FlowID = @FlowId
								AND
							  underMng_Contains = 0
								AND
							  underMng_PersonID IS NOT NULL
						)						  		
)

GO


