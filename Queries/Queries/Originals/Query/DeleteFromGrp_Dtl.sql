DELETE FROM grp_dtl
WHERE Grd_Code in(SELECT Grd_Code
				  FROM grp_dtl
				  WHERE Grd_Code not in(SELECT g.Grd_Code 
										FROM grp_dtl g
											INNER JOIN groups w
												ON w.Grp_Code = g.Grd_Code
										)
				 )
