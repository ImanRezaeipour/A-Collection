ALTER PROC [UpdatePTable](@barCode varchar(20), 
								@year varchar(4), 
								@month varchar(4), 
								@day varchar(4),
								@GregorianDate varchar(20))
AS
BEGIN
	DECLARE @tmpTableName varchar(50), 
			@TableName varchar(10),
			@sqlCommand nvarchar(MAX),
			@FromDate nvarchar(10),
			@NextMonth nvarchar(10)

	SET @month=RIGHT('00'+ CONVERT(VARCHAR,@month),2);
	SET @day=RIGHT('00'+ CONVERT(VARCHAR,@day),2);
	SET @tmpTableName = 'P' + @year + @month + '_' + @barCode
	SET @TableName = 'P' + @year + @month
	SET @FromDate = Convert(nvarchar(10), @GregorianDate)
	SET @NextMonth = dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10),dbo.GTS_ASM_AddShamsiMonth(@year, @month, 1, 1),101))

	IF NOT EXISTS(SELECT name
				  FROM sys.objects
				  WHERE name = @tmpTableName)				  	
	BEGIN	
		EXEC('CREATE TABLE dbo.' + @tmpTableName + '( '
				+ '[Prc_PCode] nvarchar(8) NOT NULL, '
				+ '[Prc_Date] nvarchar(10) NOT NULL, '
				+ '[Prc_FirstIn] [smallint] NULL, '
				+ '[Prc_FirstOut] [smallint] NULL, '
				+ '[Prc_SecondIn] [smallint] NULL, '
				+ '[Prc_SecondOut] [smallint] NULL, '
				+ '[Prc_ThirdIn] [smallint] NULL, '
				+ '[Prc_ThirdOut] [smallint] NULL, '
				+ '[Prc_FourthIn] [smallint] NULL, '
				+ '[Prc_FourthOut] [smallint] NULL, '
				+ '[Prc_FifthIn] [smallint] NULL, '
				+ '[Prc_FifthOut] [smallint] NULL, '
				+ '[Prc_LastIn] [smallint] NULL, '
				+ '[Prc_LastOut] [smallint] NULL, '
				+ '[Prc_LastInOut] [smallint] NULL, '
				+ '[Prc_NormWork] [int] NULL, '
				+ '[Prc_NormWorkDay] [smallint] NULL, '
				+ '[Prc_PresenceWork] [int] NULL, '
				+ '[Prc_PresenceWorkDay] [smallint] NULL, '
				+ '[Prc_PresenceHolliday] [int] NULL, '
				+ '[Prc_PresenceHollidays] [int] NULL, '
				+ '[Prc_PresenceFriday] [int] NULL, '
				+ '[Prc_PresenceFridays] [int] NULL, '
				+ '[Prc_WorkFridays] [int] NULL, '
				+ '[Prc_addnoworkday] [int] NULL, '
				+ '[Prc_TotalWork] [int] NULL, '
				+ '[Prc_PureWork] [int] NULL, '
				+ '[Prc_PureWorkKham] [int] NULL, '
				+ '[Prc_PureDayWork] [smallint] NULL, '
				+ '[Prc_PureWorkNight] [int] NULL, '
				+ '[Prc_PureWorkNights] [smallint] NULL, '
				+ '[Prc_standardwork] [int] NULL, '
				+ '[Prc_ValidTakhir] [int] NULL, '
				+ '[Prc_ValidTajil] [int] NULL, '
				+ '[Prc_ValidAddWork] [int] NULL, '
				+ '[Prc_ValidAddWorkHolliday] [int] NULL, '
				+ '[Prc_ValidAddWorkNoworkday] [int] NULL, '
				+ '[Prc_ValidaddWorkFriday] [int] NULL, '
				+ '[Prc_InValidaddWorkFriday] [int] NULL, '
				+ '[Prc_ValidaddWorkHolNoFr] [int] NULL, '
				+ '[Prc_InvalidaddWorkHolNoFr] [int] NULL, '
				+ '[Prc_ValidAddWorkbefore] [int] NULL, '
				+ '[Prc_ValidAddWorkafter] [int] NULL, '
				+ '[Prc_ValidAddWorkbein] [int] NULL, '
				+ '[Prc_keshik] [int] NULL, '
				+ '[Prc_janbaz] [int] NULL, '
				+ '[Prc_ValidAddWorkNight] [int] NULL, '
				+ '[Prc_ValidAddWorkFree] [int] NULL, '
				+ '[Prc_InvalidAddWork] [int] NULL, '
				+ '[Prc_TotalLessWork] [int] NULL, '
				+ '[Prc_ValidLessWork] [int] NULL, '
				+ '[Prc_BeinLessWork] [int] NULL, '
				+ '[Prc_TakhirLessWork] [int] NULL, '
				+ '[Prc_TajilLessWork] [int] NULL, '
				+ '[Prc_HourAbsence] [int] NULL, '
				+ '[Prc_DayAbsence] [smallint] NULL, '
				+ '[Prc_HourDayAbsence] [int] NULL, '
				+ '[Prc_DayAbsencePure] [smallint] NULL, '
				+ '[Prc_HourAbsencePure] [smallint] NULL, '
				+ '[Prc_AbsenceNaghes] [smallint] NULL, '
				+ '[Prc_HourleaveNoSalary] [int] NULL, '
				+ '[Prc_DayleaveNoSalary] [smallint] NULL, '
				+ '[Prc_HourDayleaveNoSalary] [int] NULL, '
				+ '[Prc_HourSleaveNoSalary] [int] NULL, '
				+ '[Prc_DaySleaveNoSalary] [smallint] NULL, '
				+ '[Prc_HourDaySleaveNoSalary] [int] NULL, '
				+ '[Prc_HourleaveSalary] [int] NULL, '
				+ '[Prc_DayleaveSalary] [smallint] NULL, '
				+ '[Prc_HourDayleaveSalary] [int] NULL, '
				+ '[Prc_HourEleaveSalary] [int] NULL, '
				+ '[Prc_HourEleaveSalarysum] [int] NULL, '
				+ '[Prc_DayEleaveSalary] [smallint] NULL, '
				+ '[Prc_HourDayEleaveSalary] [int] NULL, '
				+ '[Prc_HourSleaveSalary] [int] NULL, '
				+ '[Prc_DaySleaveSalary] [smallint] NULL, '
				+ '[Prc_HourDaySleaveSalary] [int] NULL, '
				+ '[Prc_HourMission] [int] NULL, '
				+ '[Prc_DayMission] [smallint] NULL, '
				+ '[Prc_HourDayMission] [int] NULL, '
				+ '[Prc_FullMission] [int] NULL, '
				+ '[Prc_FullHourMission] [int] NULL, '
				+ '[Prc_HourMission51] [int] NULL, '
				+ '[Prc_DayMission61] [smallint] NULL, '
				+ '[Prc_FullMission71] [int] NULL, '
				+ '[Prc_HourMission52] [int] NULL, '
				+ '[Prc_DayMission62] [smallint] NULL, '
				+ '[Prc_FullMission72] [int] NULL, '
				+ '[Prc_Shift1Count] [int] NULL, '
				+ '[Prc_Shift1time] [int] NULL, '
				+ '[Prc_Shift2Count] [int] NULL, '
				+ '[Prc_Shift2time] [int] NULL, '
				+ '[Prc_Shift3Count] [int] NULL, '
				+ '[Prc_Shift3time] [int] NULL, '
				+ '[Prc_Shift4Count] [int] NULL, '
				+ '[Prc_Shift4time] [int] NULL, '
				+ '[Prc_Shift5Count] [int] NULL, '
				+ '[Prc_Shift5time] [int] NULL, '
				+ '[Prc_Zahab] [smallint] NULL, '
				+ '[Prc_Ghaza] [smallint] NULL, '
				+ '[Prc_Type] [smallint] NULL, '
				+ '[Prc_Kind] [smallint] NULL, '
				+ '[Prc_28] [smallint] NULL, '
				+ '[Prc_shiftcode] [smallint] NULL, '
				+ '[Prc_Station] [smallint] NULL, '
				+ '[Prc_Reserve99] [smallint] NULL, '
				+ '[Prc_Changed] [smallint] NULL, '
				+ '[Prc_TakhirCnt] [smallint] NULL, '
				+ '[Prc_TakhirTotal] [smallint] NULL, '
				+ '[Prc_TakhirTotalJarimeh] [smallint] NULL, '
				+ '[Prc_addfreeRemark] [nvarchar](30) NULL, '
				+ '[Prc_scrtimes1] [int] NULL, '
				+ '[Prc_scrtimes2] [int] NULL, '
				+ '[Prc_scrtimes3] [int] NULL, '
				+ '[Prc_scrtimes4] [int] NULL, '
				+ '[Prc_scrtimes5] [int] NULL, '
				+ '[Prc_scrtimes6] [int] NULL, '
				+ '[Prc_scrtimes7] [int] NULL, '
				+ '[Prc_scrtimes8] [int] NULL, '
				+ '[Prc_scrtimes9] [int] NULL, '
				+ '[Prc_scrtimes10] [int] NULL, '
				+ '[Prc_scrdays1] [smallint] NULL, '
				+ '[Prc_scrdays2] [smallint] NULL, '
				+ '[Prc_scrdays3] [smallint] NULL, '
				+ '[Prc_scrdays4] [smallint] NULL, '
				+ '[Prc_scrdays5] [smallint] NULL, '
				+ '[Prc_scrdays6] [smallint] NULL, '
				+ '[Prc_scrdays7] [smallint] NULL, '
				+ '[Prc_scrdays8] [smallint] NULL, '
				+ '[Prc_scrdays9] [smallint] NULL, '
				+ '[Prc_scrdays10] [smallint] NULL, '
				+ '[Prc_PresenceSpecial] [smallint] NULL, '
			+ 'PRIMARY KEY CLUSTERED  '
			+ '( '
				+ '[Prc_PCode] ASC, '
				+ '[Prc_Date] ASC '
			+ ')WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] '
			+ ') ON [PRIMARY]')				
	END			  			  
	SET @sqlCommand = N'DELETE FROM ' + @tmpTableName + ' ' +
						   'WHERE Prc_PCode = ''' + @barCode + '''' +
						   ' AND (' + 
						   'Prc_Date >= ''' + @year + '/' + @month + '/' + @day + '''' +
						   ' OR ' +
						   'Prc_Date = ''' + @year + '/' + @month + '/00'')' 

	EXEC sp_executesql @sqlCommand

	EXEC(N'DECLARE @tbl_ProceedTraffic TABLE(PrcTraffic_From int, ' 
									      + 'PrcTraffic_To int, '   
									      + 'PrcTraffic_Date datetime ,PrcTraffic_precard int,hasdaily bit,hashourly bit) '						  
					+ 'INSERT INTO @tbl_ProceedTraffic '
					+ 'SELECT ptp.ProceedTrafficPair_From, '
						   + 'ptp.ProceedTrafficPair_To, '
						   + 'pt.ProceedTraffic_FromDate,
						   ptp.ProceedTrafficPair_PishCardID , '	
						   + ' pt.ProceedTraffic_HasDailyItem , pt.ProceedTraffic_HasHourlyItem '
					+'FROM TA_ProceedTraffic pt '
						+ 'INNER JOIN TA_ProceedTrafficPair ptp '
							+ 'ON ptp.ProceedTrafficPair_ProceedTrafficId = pt.ProceedTraffic_ID '
					+ 'WHERE pt.ProceedTraffic_PersonId = (SELECT Prs_ID FROM TA_Person WHERE Prs_Barcode = ''' + @barCode + ''') '
					+ 'ORDER BY pt.ProceedTraffic_FromDate, ptp.ProceedTrafficPair_From '

					+ 'UPDATE @tbl_ProceedTraffic SET PrcTraffic_From =-1000 , PrcTraffic_To=-1000 
					   WHERE PrcTraffic_precard IN (41,61,62,63,64,65)'
					   
					/*+ 'UPDATE @tbl_ProceedTraffic SET PrcTraffic_From =-1000 
					   WHERE PrcTraffic_From = 0 --and PrcTraffic_precard IN (41,61,62,63,64,65)'
					   
					+ 'UPDATE @tbl_ProceedTraffic SET PrcTraffic_To =-1000
					   WHERE PrcTraffic_To = 0 --and PrcTraffic_precard IN (41,61,62,63,64,65)'
					   */
					+ 'DELETE FROM  @tbl_ProceedTraffic  
					   WHERE PrcTraffic_precard IN (11,12,13,14,15,21,22,23,24,25,26,27,51,52,53,54,55,81)'  
					
					+ 'DELETE  FROM @tbl_ProceedTraffic WHERE hasdaily=1 and hashourly=1 and PrcTraffic_From=-1000 and PrcTraffic_To=-1000'
					
					+ 'DECLARE @tbl_ConceptValue TABLE(Value int, ' 
												+   'Value_FromDate datetime, ' 
												+   'Value_ToDate   datetime, ' 													
												+	'Value_PersonId decimal, ' 
												+	'Value_IsRangely bit, ' 
												+	'Value_ScndCnp__PColumn nvarchar(50)) ' 
						+ 'INSERT INTO @tbl_ConceptValue ' 
							+ 'SELECT  scv.ScndCnpValue_Value Value, '
									+ 'scv.ScndCnpValue_FromDate FromDate, '
									+ 'scv.ScndCnpValue_ToDate ToDate, '
									+ 'scv.ScndCnpValue_PersonId PersonId, '
									+ 'sc.ScndCnp_IsRangely IsRangely, '
									+ 'sc.ScndCnp__PColumn PColumn '
							+ 'FROM TA_SecondaryConceptValue scv '
								+ 'INNER JOIN TA_SecondaryConcept sc '
								+	'ON sc.ScndCnp_ID = scv.ScndCnpValue_SecondaryConceptId ' 
							+ 'WHERE scv.ScndCnpValue_PersonId = (SELECT Prs_ID FROM TA_Person WHERE Prs_Barcode = ''' + @barCode + ''') ' 
									+ 'AND scv.ScndCnpValue_ToDate >= ''' + @FromDate + ''' '
									+ 'AND scv.ScndCnpValue_ToDate < ''' + @NextMonth + ''' '
								    + 'AND sc.ScndCnp_IsRangely = 0 '
								    + 'AND sc.ScndCnp__PColumn IS NOT NULL ' 
								    + 'AND SC.ScndCnp__PColumn <> '''' '									    
								    
						+ 'INSERT INTO ' 
						+ @tmpTableName 
							+ '(' 
							+ 'Prc_PCode, Prc_Date, Prc_FirstIn, Prc_FirstOut, Prc_SecondIn, Prc_SecondOut, Prc_ThirdIn, Prc_ThirdOut, Prc_FourthIn, ' 
							+ 'Prc_FourthOut, Prc_FifthIn, Prc_FifthOut, Prc_LastIn, Prc_LastOut, Prc_LastInOut, Prc_NormWork, Prc_NormWorkDay, Prc_PresenceWork, '
							+ 'Prc_PresenceWorkDay, Prc_PresenceHolliday, Prc_PresenceHollidays, Prc_PresenceFriday, Prc_PresenceFridays, Prc_WorkFridays, Prc_addnoworkday, Prc_TotalWork, Prc_PureWork, '
							+ 'Prc_PureWorkKham, Prc_PureDayWork, Prc_PureWorkNight, Prc_PureWorkNights, Prc_standardwork, Prc_ValidTakhir, Prc_ValidTajil, Prc_ValidAddWork, Prc_ValidAddWorkHolliday, '
							+ 'Prc_ValidAddWorkNoworkday, Prc_ValidaddWorkFriday, Prc_InValidaddWorkFriday, Prc_ValidaddWorkHolNoFr, Prc_InvalidaddWorkHolNoFr, Prc_ValidAddWorkbefore, Prc_ValidAddWorkafter, Prc_keshik, Prc_janbaz, '
							+ 'Prc_ValidAddWorkNight, Prc_ValidAddWorkFree, Prc_InvalidAddWork, Prc_TotalLessWork, Prc_ValidLessWork, Prc_BeinLessWork, Prc_TakhirLessWork, Prc_TajilLessWork, Prc_HourAbsence, '
							+ 'Prc_DayAbsence, Prc_HourDayAbsence, Prc_DayAbsencePure, Prc_HourAbsencePure, Prc_AbsenceNaghes, Prc_HourleaveNoSalary, Prc_DayleaveNoSalary, Prc_HourDayleaveNoSalary, Prc_HourSleaveNoSalary, '
							+ 'Prc_DaySleaveNoSalary, Prc_HourDaySleaveNoSalary, Prc_HourleaveSalary, Prc_DayleaveSalary, Prc_HourDayleaveSalary, Prc_HourEleaveSalary, Prc_HourEleaveSalarysum, Prc_DayEleaveSalary, Prc_HourDayEleaveSalary, '
							+ 'Prc_HourSleaveSalary, Prc_DaySleaveSalary, Prc_HourDaySleaveSalary, Prc_HourMission, Prc_DayMission, Prc_HourDayMission, Prc_FullMission, Prc_FullHourMission, Prc_HourMission51, '
							+ 'Prc_DayMission61, Prc_FullMission71, Prc_HourMission52, Prc_DayMission62, Prc_FullMission72, Prc_shift1Count, Prc_shift1time, Prc_shift2Count, Prc_shift2time, '
							+ 'Prc_shift3Count, Prc_shift3time, Prc_shift4Count, Prc_shift4time, Prc_shift5Count, Prc_shift5time, Prc_Zahab, Prc_Ghaza, Prc_Type, '
							+ 'Prc_Kind, Prc_28, Prc_shiftcode, Prc_Station, Prc_Reserve99, Prc_Changed, Prc_TakhirCnt, Prc_TakhirTotal, Prc_TakhirTotalJarimeh, '
						    + 'Prc_addfreeRemark, Prc_PresenceSpecial, Prc_ValidAddWorkBein' + ') '
						+ 'SELECT ''' + @barCode + ''', dbo.GTS_ASM_MiladiToShamsi(CONVERT(varchar(10),Value_FromDate,101)), ' + 'ISNULL((SELECT PrcTraffic_From '
																							  +  'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_From ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate and PrcTraffic_From<> -1000) AS RESULT '
																							   + 'WHERE RowNo = 1), -1000) AS FirstIn, '  
																							  + 'ISNULL((SELECT PrcTraffic_To '
																							   + 'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_To ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate and PrcTraffic_To<> -1000) AS RESULT '
																							   + 'WHERE RowNo = 1), -1000) AS FirstOut, ' 
																							  + 'ISNULL((SELECT PrcTraffic_From '
																							   + 'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_From ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate) AS RESULT '
																							   + 'WHERE RowNo = 2), -1000) AS SecondIn, '  
																							  + 'ISNULL((SELECT PrcTraffic_To '
																							   + 'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_To ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate) AS RESULT '
																							   + 'WHERE RowNo = 2), -1000) AS SecondOut, '
																							  + 'ISNULL((SELECT PrcTraffic_From '
																							   + 'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_From ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate) AS RESULT '
																							   + 'WHERE RowNo = 3), -1000) AS ThirdIn, '  
																							  + 'ISNULL((SELECT PrcTraffic_To '
																							   + 'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_To ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate) AS RESULT '
																							   + 'WHERE RowNo = 3), -1000) AS ThirdOut, '	
																							  + 'ISNULL((SELECT PrcTraffic_From '
																							   + 'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_From ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate) AS RESULT '
																							   + 'WHERE RowNo = 4), -1000) AS FourthIn, '  
																							  + 'ISNULL((SELECT PrcTraffic_To '
																							   + 'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_To ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate) AS RESULT '
																							   + 'WHERE RowNo = 4), -1000) AS FourthOut, '
																							  + 'ISNULL((SELECT PrcTraffic_From '
																							   + 'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_From ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate) AS RESULT '
																							   + 'WHERE RowNo = 5), -1000) AS FifthIn, '  
																							  + 'ISNULL((SELECT PrcTraffic_To '
																							   + 'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_To ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate) AS RESULT '
																							   + 'WHERE RowNo = 5), -1000) AS FifthOut, '																							   																							   																						   																							   
																							  + 'ISNULL((SELECT TOP 1 PrcTraffic_From '
																							   + 'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_From ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate) AS RESULT '
																							   + 'ORDER BY RowNo DESC), -1000) AS LastIn, '  
																							  + 'ISNULL((SELECT Top 1 PrcTraffic_To '
																							   + 'FROM(SELECT ROW_NUMBER() OVER '
																										+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_To ' 
																							    	+ 'FROM @tbl_ProceedTraffic '
																									+ 'WHERE PrcTraffic_Date = Value_FromDate) AS RESULT '
																							   + 'ORDER BY RowNo DESC), -1000) AS LastOut, '
																							  + 'ISNULL((SELECT ISNULL(PrcTraffic_To, PrcTraffic_From) '
																							   + 'FROM (SELECT TOP 1 PrcTraffic_From, PrcTraffic_To '
																									 + 'FROM(SELECT ROW_NUMBER() OVER '
																											+ '(ORDER BY PrcTraffic_Date, PrcTraffic_From) AS RowNo, PrcTraffic_From, PrcTraffic_To ' 
																							    		  + 'FROM @tbl_ProceedTraffic '
																										  + 'WHERE PrcTraffic_Date = Value_FromDate) AS RESULT '
																									 + 'ORDER BY RowNo DESC) AS LastTraffic), -1000), '				   																							   
								 + 'SUM(isnull(Prc_NormWork,0)), SUM(Prc_NormWorkDay), SUM(Prc_PresenceWork), '									  
								 + 'SUM(isnull(Prc_PresenceWorkDay,0)), SUM(Prc_PresenceHolliday), SUM(Prc_PresenceHollidays), SUM(Prc_PresenceFriday), SUM(Prc_PresenceFridays), SUM(Prc_WorkFridays), SUM(Prc_addnoworkday), SUM(Prc_TotalWork), SUM(Prc_PureWork), '
								 + 'SUM(isnull(Prc_PureWorkKham,0)), SUM(Prc_PureDayWork), SUM(Prc_PureWorkNight), SUM(Prc_PureWorkNights), SUM(Prc_standardwork), SUM(Prc_ValidTakhir), SUM(Prc_ValidTajil), SUM(Prc_ValidAddWork), SUM(Prc_ValidAddWorkHolliday), '							
								 + 'SUM(isnull(Prc_ValidAddWorkNoworkday,0)), SUM(Prc_ValidaddWorkFriday), SUM(Prc_InValidaddWorkFriday), SUM(Prc_ValidaddWorkHolNoFr), SUM(Prc_InvalidaddWorkHolNoFr), SUM(Prc_ValidAddWorkbefore), SUM(Prc_ValidAddWorkafter), SUM(Prc_keshik), SUM(Prc_janbaz), '						
								 + 'SUM(isnull(Prc_ValidAddWorkNight,0)), SUM(Prc_ValidAddWorkFree), SUM(Prc_InvalidAddWork), SUM(Prc_TotalLessWork), SUM(isnull(Prc_ValidLessWork,0)), SUM(Prc_BeinLessWork), SUM(Prc_TakhirLessWork), SUM(Prc_TajilLessWork), SUM(Prc_HourAbsence), '
								 + 'SUM(isnull(Prc_DayAbsence,0)), SUM(Prc_HourDayAbsence), SUM(Prc_DayAbsencePure), SUM(Prc_HourAbsencePure), SUM(Prc_AbsenceNaghes), SUM(Prc_HourleaveNoSalary), SUM(Prc_DayleaveNoSalary), SUM(Prc_HourDayleaveNoSalary), SUM(Prc_HourSleaveNoSalary), '
								 + 'SUM(isnull(Prc_DaySleaveNoSalary,0)), SUM(Prc_HourDaySleaveNoSalary), SUM(Prc_HourleaveSalary), SUM(Prc_DayleaveSalary), SUM(Prc_HourDayleaveSalary), SUM(Prc_HourEleaveSalary), SUM(Prc_HourEleaveSalarysum), SUM(Prc_DayEleaveSalary), SUM(Prc_HourDayEleaveSalary), '
								 + 'SUM(isnull(Prc_HourSleaveSalary,0)), SUM(Prc_DaySleaveSalary), SUM(Prc_HourDaySleaveSalary), SUM(Prc_HourMission), SUM(Prc_DayMission), SUM(Prc_HourDayMission), SUM(Prc_FullMission), SUM(Prc_FullHourMission), SUM(Prc_HourMission51), '
								 + 'SUM(isnull(Prc_DayMission61,0)), SUM(Prc_FullMission71), SUM(Prc_HourMission52), SUM(Prc_DayMission62), SUM(Prc_FullMission72), SUM(Prc_shift1Count), SUM(Prc_shift1time), SUM(Prc_shift2Count), SUM(Prc_shift2time), '
								 + 'SUM(isnull(Prc_shift3Count,0)), SUM(isnull(Prc_shift3time,0)), SUM(isnull(Prc_shift4Count,0)), SUM(isnull(Prc_shift4time,0)), SUM(isnull(Prc_shift5Count,0)), SUM(isnull(Prc_shift5time,0)), SUM(isnull(Prc_Zahab,0)), SUM(isnull(Prc_Ghaza,0)), SUM(isnull(Prc_Type,0)), '
								 + 'SUM(isnull(Prc_Kind,0)), SUM(isnull(Prc_28,0)), SUM(isnull(Prc_shiftcode,0)), SUM(isnull(Prc_Station,0)), SUM(isnull(Prc_Reserve99,0)), SUM(isnull(Prc_Changed,0)), SUM(isnull(Prc_TakhirCnt,0)), SUM(isnull(Prc_TakhirTotal,0)), SUM(isnull(Prc_TakhirTotalJarimeh,0)), '
								 + 'SUM(Prc_addfreeRemark), SUM(Prc_PresenceSpecial), SUM(isnull(Prc_ValidAddWorkBein,0)) ' 
								 + 'FROM '
								 + ' (SELECT Value, Value_FromDate, Value_ScndCnp__PColumn FROM @tbl_ConceptValue) AS [Source] '
								 + 'PIVOT ' 
								 + '( '
								 + '  SUM(Value)'
								 + '  FOR Value_ScndCnp__PColumn '
								 + '			IN (Prc_NormWork, Prc_NormWorkDay, Prc_PresenceWork, '
								 + '				Prc_PresenceWorkDay, Prc_PresenceHolliday, Prc_PresenceHollidays, Prc_PresenceFriday, Prc_PresenceFridays, Prc_WorkFridays, Prc_addnoworkday, Prc_TotalWork, Prc_PureWork, '
								 + '				Prc_PureWorkKham, Prc_PureDayWork, Prc_PureWorkNight, Prc_PureWorkNights, Prc_standardwork, Prc_ValidTakhir, Prc_ValidTajil, Prc_ValidAddWork, Prc_ValidAddWorkHolliday, '
								 + '				Prc_ValidAddWorkNoworkday, Prc_ValidaddWorkFriday, Prc_InValidaddWorkFriday, Prc_ValidaddWorkHolNoFr, Prc_InvalidaddWorkHolNoFr, Prc_ValidAddWorkbefore, Prc_ValidAddWorkafter, Prc_keshik, Prc_janbaz, '
								 + '				Prc_ValidAddWorkNight, Prc_ValidAddWorkFree, Prc_InvalidAddWork, Prc_TotalLessWork, Prc_ValidLessWork, Prc_BeinLessWork, Prc_TakhirLessWork, Prc_TajilLessWork, Prc_HourAbsence, '
								 + '				Prc_DayAbsence, Prc_HourDayAbsence, Prc_DayAbsencePure, Prc_HourAbsencePure, Prc_AbsenceNaghes, Prc_HourleaveNoSalary, Prc_DayleaveNoSalary, Prc_HourDayleaveNoSalary, Prc_HourSleaveNoSalary, '
								 + '				Prc_DaySleaveNoSalary, Prc_HourDaySleaveNoSalary, Prc_HourleaveSalary, Prc_DayleaveSalary, Prc_HourDayleaveSalary, Prc_HourEleaveSalary, Prc_HourEleaveSalarysum, Prc_DayEleaveSalary, Prc_HourDayEleaveSalary, '
								 + '				Prc_HourSleaveSalary, Prc_DaySleaveSalary, Prc_HourDaySleaveSalary, Prc_HourMission, Prc_DayMission, Prc_HourDayMission, Prc_FullMission, Prc_FullHourMission, Prc_HourMission51, '
								 + '				Prc_DayMission61, Prc_FullMission71, Prc_HourMission52, Prc_DayMission62, Prc_FullMission72, Prc_shift1Count, Prc_shift1time, Prc_shift2Count, Prc_shift2time, '
								 + '				Prc_shift3Count, Prc_shift3time, Prc_shift4Count, Prc_shift4time, Prc_shift5Count, Prc_shift5time, Prc_Zahab, Prc_Ghaza, Prc_Type, '
								 + '				Prc_Kind, Prc_28, Prc_shiftcode, Prc_Station, Prc_Reserve99, Prc_Changed, Prc_TakhirCnt, Prc_TakhirTotal, Prc_TakhirTotalJarimeh, '
								 + '				Prc_addfreeRemark, Prc_PresenceSpecial, Prc_ValidAddWorkBein' + ') '									 									 
								 + ') AS Result '
								 + 'GROUP BY Value_FromDate ')								 

	EXEC(N'DECLARE @tbl_ConceptValue TABLE(Value int, ' 
													+   'Value_FromDate datetime, ' 
													+   'Value_ToDate   datetime, ' 													
													+	'Value_PersonId decimal, ' 
													+	'Value_IsRangely bit, ' 
													+	'Value_ScndCnp__PColumn nvarchar(50)) ' 
							+ 'INSERT INTO @tbl_ConceptValue ' 
								+ 'SELECT  scv.ScndCnpValue_Value Value, '
										+ 'scv.ScndCnpValue_FromDate FromDate, '
										+ 'scv.ScndCnpValue_ToDate ToDate, '
										+ 'scv.ScndCnpValue_PersonId PersonId, '
										+ 'sc.ScndCnp_IsRangely IsRangely, '
										+ 'sc.ScndCnp__PColumn PColumn '
								+ 'FROM TA_SecondaryConceptValue scv '
									+ 'INNER JOIN TA_SecondaryConcept sc '
									+	'ON sc.ScndCnp_ID = scv.ScndCnpValue_SecondaryConceptId ' 
								+ 'WHERE scv.ScndCnpValue_PersonId = (SELECT Prs_ID FROM TA_Person WHERE Prs_Barcode = ''' + @barCode + ''') ' 
										+ 'AND ''' + @FromDate + ''' BETWEEN scv.ScndCnpValue_FromDate AND scv.ScndCnpValue_ToDate '
									    + 'AND sc.ScndCnp_IsRangely = 1 '									    
									    + 'AND sc.ScndCnp__PColumn IS NOT NULL '						
									    
									    
							+ 'INSERT INTO ' 
							+ @tmpTableName 
								+ '(' 
								+ 'Prc_PCode, Prc_Date, Prc_FirstIn, Prc_FirstOut, Prc_SecondIn, Prc_SecondOut, Prc_ThirdIn, Prc_ThirdOut, Prc_FourthIn, ' 
								+ 'Prc_FourthOut, Prc_FifthIn, Prc_FifthOut, Prc_LastIn, Prc_LastOut, Prc_LastInOut, Prc_NormWork, Prc_NormWorkDay, Prc_PresenceWork, '
								+ 'Prc_PresenceWorkDay, Prc_PresenceHolliday, Prc_PresenceHollidays, Prc_PresenceFriday, Prc_PresenceFridays, Prc_WorkFridays, Prc_addnoworkday, Prc_TotalWork, Prc_PureWork, '
								+ 'Prc_PureWorkKham, Prc_PureDayWork, Prc_PureWorkNight, Prc_PureWorkNights, Prc_standardwork, Prc_ValidTakhir, Prc_ValidTajil, Prc_ValidAddWork, Prc_ValidAddWorkHolliday, '
								+ 'Prc_ValidAddWorkNoworkday, Prc_ValidaddWorkFriday, Prc_InValidaddWorkFriday, Prc_ValidaddWorkHolNoFr, Prc_InvalidaddWorkHolNoFr, Prc_ValidAddWorkbefore, Prc_ValidAddWorkafter, Prc_keshik, Prc_janbaz, '
								+ 'Prc_ValidAddWorkNight, Prc_ValidAddWorkFree, Prc_InvalidAddWork, Prc_TotalLessWork, Prc_ValidLessWork, Prc_BeinLessWork, Prc_TakhirLessWork, Prc_TajilLessWork, Prc_HourAbsence, '
								+ 'Prc_DayAbsence, Prc_HourDayAbsence, Prc_DayAbsencePure, Prc_HourAbsencePure, Prc_AbsenceNaghes, Prc_HourleaveNoSalary, Prc_DayleaveNoSalary, Prc_HourDayleaveNoSalary, Prc_HourSleaveNoSalary, '
								+ 'Prc_DaySleaveNoSalary, Prc_HourDaySleaveNoSalary, Prc_HourleaveSalary, Prc_DayleaveSalary, Prc_HourDayleaveSalary, Prc_HourEleaveSalary, Prc_HourEleaveSalarysum, Prc_DayEleaveSalary, Prc_HourDayEleaveSalary, '
								+ 'Prc_HourSleaveSalary, Prc_DaySleaveSalary, Prc_HourDaySleaveSalary, Prc_HourMission, Prc_DayMission, Prc_HourDayMission, Prc_FullMission, Prc_FullHourMission, Prc_HourMission51, '
								+ 'Prc_DayMission61, Prc_FullMission71, Prc_HourMission52, Prc_DayMission62, Prc_FullMission72, Prc_shift1Count, Prc_shift1time, Prc_shift2Count, Prc_shift2time, '
								+ 'Prc_shift3Count, Prc_shift3time, Prc_shift4Count, Prc_shift4time, Prc_shift5Count, Prc_shift5time, Prc_Zahab, Prc_Ghaza, Prc_Type, '
								+ 'Prc_Kind, Prc_28, Prc_shiftcode, Prc_Station, Prc_Reserve99, Prc_Changed, Prc_TakhirCnt, Prc_TakhirTotal, Prc_TakhirTotalJarimeh, '
							    + 'Prc_addfreeRemark, Prc_PresenceSpecial, Prc_ValidAddWorkBein' + ') '
							+ 'SELECT ''' + @barCode + ''', ''' +  @year + ''' + ''/'' + ''' + @month + ''' + ''/00''' + ', -1000 AS FirstIn, -1000 AS FirstOut, -1000 AS SecondIn, -1000 AS SecondOut, -1000 AS ThirdIn, -1000 AS ThirdOut, -1000 AS FourthIn, '  
									 + '-1000 AS FourthOut, -1000 AS FifthIn, -1000 AS FifthOut, -1000 AS LastIn, -1000 AS LastOut, -1000 AS LastTraffic, SUM(Prc_NormWork), SUM(Prc_NormWorkDay), SUM(Prc_PresenceWork), '									  
									 + 'SUM(Prc_PresenceWorkDay), SUM(Prc_PresenceHolliday), SUM(Prc_PresenceHollidays), SUM(Prc_PresenceFriday), SUM(Prc_PresenceFridays), SUM(Prc_WorkFridays), SUM(Prc_addnoworkday), SUM(Prc_TotalWork), SUM(Prc_PureWork), '
									 + 'SUM(Prc_PureWorkKham), SUM(Prc_PureDayWork), SUM(Prc_PureWorkNight), SUM(Prc_PureWorkNights), SUM(Prc_standardwork), SUM(Prc_ValidTakhir), SUM(Prc_ValidTajil), SUM(Prc_ValidAddWork), SUM(Prc_ValidAddWorkHolliday), '							
									 + 'SUM(Prc_ValidAddWorkNoworkday), SUM(Prc_ValidaddWorkFriday), SUM(Prc_InValidaddWorkFriday), SUM(Prc_ValidaddWorkHolNoFr), SUM(Prc_InvalidaddWorkHolNoFr), SUM(Prc_ValidAddWorkbefore), SUM(Prc_ValidAddWorkafter), SUM(Prc_keshik), SUM(Prc_janbaz), '						
									 + 'SUM(Prc_ValidAddWorkNight), SUM(Prc_ValidAddWorkFree), SUM(Prc_InvalidAddWork), SUM(Prc_TotalLessWork), SUM(isnull(Prc_ValidLessWork,0)), SUM(Prc_BeinLessWork), SUM(Prc_TakhirLessWork), SUM(Prc_TajilLessWork), SUM(Prc_HourAbsence), '
									 + 'SUM(Prc_DayAbsence), SUM(Prc_HourDayAbsence), SUM(Prc_DayAbsencePure), SUM(Prc_HourAbsencePure), SUM(Prc_AbsenceNaghes), SUM(Prc_HourleaveNoSalary), SUM(Prc_DayleaveNoSalary), SUM(Prc_HourDayleaveNoSalary), SUM(Prc_HourSleaveNoSalary), '
									 + 'SUM(isnull(Prc_DaySleaveNoSalary,0)), SUM(Prc_HourDaySleaveNoSalary), SUM(Prc_HourleaveSalary), SUM(Prc_DayleaveSalary), SUM(Prc_HourDayleaveSalary), SUM(Prc_HourEleaveSalary), SUM(Prc_HourEleaveSalarysum), SUM(Prc_DayEleaveSalary), SUM(Prc_HourDayEleaveSalary), '
									 + 'SUM(Prc_HourSleaveSalary), SUM(isnull(Prc_DaySleaveSalary,0)), SUM(Prc_HourDaySleaveSalary), SUM(Prc_HourMission), SUM(Prc_DayMission), SUM(Prc_HourDayMission), SUM(Prc_FullMission), SUM(Prc_FullHourMission), SUM(Prc_HourMission51), '
									 + 'SUM(Prc_DayMission61), SUM(Prc_FullMission71), SUM(Prc_HourMission52), SUM(Prc_DayMission62), SUM(Prc_FullMission72), SUM(Prc_shift1Count), SUM(Prc_shift1time), SUM(Prc_shift2Count), SUM(Prc_shift2time), '
									 + 'SUM(Prc_shift3Count), SUM(Prc_shift3time), SUM(Prc_shift4Count), SUM(Prc_shift4time), SUM(Prc_shift5Count), SUM(Prc_shift5time), SUM(Prc_Zahab), SUM(Prc_Ghaza), SUM(Prc_Type), '
									 + 'SUM(Prc_Kind), SUM(Prc_28), SUM(Prc_shiftcode), SUM(Prc_Station), SUM(Prc_Reserve99), SUM(Prc_Changed), SUM(Prc_TakhirCnt), SUM(Prc_TakhirTotal), SUM(Prc_TakhirTotalJarimeh), '
									 + 'SUM(isnull(Prc_addfreeRemark,0)), SUM(isnull(Prc_PresenceSpecial,0)), SUM(isnull(Prc_ValidAddWorkBein,0)) ' 
									 + 'FROM '
									 + ' (SELECT Value, Value_FromDate, Value_ScndCnp__PColumn FROM @tbl_ConceptValue) AS [Source] '
									 + 'PIVOT ' 
									 + '( '
									 + '  SUM(Value)'
									 + '  FOR Value_ScndCnp__PColumn '
									 + '			IN (Prc_NormWork, Prc_NormWorkDay, Prc_PresenceWork, '
									 + '				Prc_PresenceWorkDay, Prc_PresenceHolliday, Prc_PresenceHollidays, Prc_PresenceFriday, Prc_PresenceFridays, Prc_WorkFridays, Prc_addnoworkday, Prc_TotalWork, Prc_PureWork, '
									 + '				Prc_PureWorkKham, Prc_PureDayWork, Prc_PureWorkNight, Prc_PureWorkNights, Prc_standardwork, Prc_ValidTakhir, Prc_ValidTajil, Prc_ValidAddWork, Prc_ValidAddWorkHolliday, '
									 + '				Prc_ValidAddWorkNoworkday, Prc_ValidaddWorkFriday, Prc_InValidaddWorkFriday, Prc_ValidaddWorkHolNoFr, Prc_InvalidaddWorkHolNoFr, Prc_ValidAddWorkbefore, Prc_ValidAddWorkafter, Prc_keshik, Prc_janbaz, '
									 + '				Prc_ValidAddWorkNight, Prc_ValidAddWorkFree, Prc_InvalidAddWork, Prc_TotalLessWork, Prc_ValidLessWork, Prc_BeinLessWork, Prc_TakhirLessWork, Prc_TajilLessWork, Prc_HourAbsence, '
									 + '				Prc_DayAbsence, Prc_HourDayAbsence, Prc_DayAbsencePure, Prc_HourAbsencePure, Prc_AbsenceNaghes, Prc_HourleaveNoSalary, Prc_DayleaveNoSalary, Prc_HourDayleaveNoSalary, Prc_HourSleaveNoSalary, '
									 + '				Prc_DaySleaveNoSalary, Prc_HourDaySleaveNoSalary, Prc_HourleaveSalary, Prc_DayleaveSalary, Prc_HourDayleaveSalary, Prc_HourEleaveSalary, Prc_HourEleaveSalarysum, Prc_DayEleaveSalary, Prc_HourDayEleaveSalary, '
									 + '				Prc_HourSleaveSalary, Prc_DaySleaveSalary, Prc_HourDaySleaveSalary, Prc_HourMission, Prc_DayMission, Prc_HourDayMission, Prc_FullMission, Prc_FullHourMission, Prc_HourMission51, '
									 + '				Prc_DayMission61, Prc_FullMission71, Prc_HourMission52, Prc_DayMission62, Prc_FullMission72, Prc_shift1Count, Prc_shift1time, Prc_shift2Count, Prc_shift2time, '
									 + '				Prc_shift3Count, Prc_shift3time, Prc_shift4Count, Prc_shift4time, Prc_shift5Count, Prc_shift5time, Prc_Zahab, Prc_Ghaza, Prc_Type, '
									 + '				Prc_Kind, Prc_28, Prc_shiftcode, Prc_Station, Prc_Reserve99, Prc_Changed, Prc_TakhirCnt, Prc_TakhirTotal, Prc_TakhirTotalJarimeh, '
									 + '				Prc_addfreeRemark, Prc_PresenceSpecial, Prc_ValidAddWorkBein' + ') '									 									 
									 + ') AS Result '
									 + 'GROUP BY Value_FromDate ')							 		

	
	IF NOT EXISTS(SELECT name
				  FROM sys.objects
				  WHERE name = @TableName)				  	
	BEGIN	
		EXEC('CREATE TABLE [dbo].[' + @TableName + ']( '
				+ '[Prc_PCode] [nvarchar](8) NOT NULL, '
				+ '[Prc_Date] [nvarchar](10) NOT NULL, '
				+ '[Prc_FirstIn] [smallint] NULL, '
				+ '[Prc_FirstOut] [smallint] NULL, '
				+ '[Prc_SecondIn] [smallint] NULL, '
				+ '[Prc_SecondOut] [smallint] NULL, '
				+ '[Prc_ThirdIn] [smallint] NULL, '
				+ '[Prc_ThirdOut] [smallint] NULL, '
				+ '[Prc_FourthIn] [smallint] NULL, '
				+ '[Prc_FourthOut] [smallint] NULL, '
				+ '[Prc_FifthIn] [smallint] NULL, '
				+ '[Prc_FifthOut] [smallint] NULL, '
				+ '[Prc_LastIn] [smallint] NULL, '
				+ '[Prc_LastOut] [smallint] NULL, '
				+ '[Prc_LastInOut] [smallint] NULL, '
				+ '[Prc_NormWork] [int] NULL, '
				+ '[Prc_NormWorkDay] [smallint] NULL, '
				+ '[Prc_PresenceWork] [int] NULL, '
				+ '[Prc_PresenceWorkDay] [smallint] NULL, '
				+ '[Prc_PresenceHolliday] [int] NULL, '
				+ '[Prc_PresenceHollidays] [int] NULL, '
				+ '[Prc_PresenceFriday] [int] NULL, '
				+ '[Prc_PresenceFridays] [int] NULL, '
				+ '[Prc_WorkFridays] [int] NULL, '
				+ '[Prc_addnoworkday] [int] NULL, '
				+ '[Prc_TotalWork] [int] NULL, '
				+ '[Prc_PureWork] [int] NULL, '
				+ '[Prc_PureWorkKham] [int] NULL, '
				+ '[Prc_PureDayWork] [smallint] NULL, '
				+ '[Prc_PureWorkNight] [int] NULL, '
				+ '[Prc_PureWorkNights] [smallint] NULL, '
				+ '[Prc_standardwork] [int] NULL, '
				+ '[Prc_ValidTakhir] [int] NULL, '
				+ '[Prc_ValidTajil] [int] NULL, '
				+ '[Prc_ValidAddWork] [int] NULL, '
				+ '[Prc_ValidAddWorkHolliday] [int] NULL, '
				+ '[Prc_ValidAddWorkNoworkday] [int] NULL, '
				+ '[Prc_ValidaddWorkFriday] [int] NULL, '
				+ '[Prc_InValidaddWorkFriday] [int] NULL, '
				+ '[Prc_ValidaddWorkHolNoFr] [int] NULL, '
				+ '[Prc_InvalidaddWorkHolNoFr] [int] NULL, '
				+ '[Prc_ValidAddWorkbefore] [int] NULL, '
				+ '[Prc_ValidAddWorkafter] [int] NULL, '
				+ '[Prc_ValidAddWorkbein] [int] NULL, '
				+ '[Prc_keshik] [int] NULL, '
				+ '[Prc_janbaz] [int] NULL, '
				+ '[Prc_ValidAddWorkNight] [int] NULL, '
				+ '[Prc_ValidAddWorkFree] [int] NULL, '
				+ '[Prc_InvalidAddWork] [int] NULL, '
				+ '[Prc_TotalLessWork] [int] NULL, '
				+ '[Prc_ValidLessWork] [int] NULL, '
				+ '[Prc_BeinLessWork] [int] NULL, '
				+ '[Prc_TakhirLessWork] [int] NULL, '
				+ '[Prc_TajilLessWork] [int] NULL, '
				+ '[Prc_HourAbsence] [int] NULL, '
				+ '[Prc_DayAbsence] [smallint] NULL, '
				+ '[Prc_HourDayAbsence] [int] NULL, '
				+ '[Prc_DayAbsencePure] [smallint] NULL, '
				+ '[Prc_HourAbsencePure] [smallint] NULL, '
				+ '[Prc_AbsenceNaghes] [smallint] NULL, '
				+ '[Prc_HourleaveNoSalary] [int] NULL, '
				+ '[Prc_DayleaveNoSalary] [smallint] NULL, '
				+ '[Prc_HourDayleaveNoSalary] [int] NULL, '
				+ '[Prc_HourSleaveNoSalary] [int] NULL, '
				+ '[Prc_DaySleaveNoSalary] [smallint] NULL, '
				+ '[Prc_HourDaySleaveNoSalary] [int] NULL, '
				+ '[Prc_HourleaveSalary] [int] NULL, '
				+ '[Prc_DayleaveSalary] [smallint] NULL, '
				+ '[Prc_HourDayleaveSalary] [int] NULL, '
				+ '[Prc_HourEleaveSalary] [int] NULL, '
				+ '[Prc_HourEleaveSalarysum] [int] NULL, '
				+ '[Prc_DayEleaveSalary] [smallint] NULL, '
				+ '[Prc_HourDayEleaveSalary] [int] NULL, '
				+ '[Prc_HourSleaveSalary] [int] NULL, '
				+ '[Prc_DaySleaveSalary] [smallint] NULL, '
				+ '[Prc_HourDaySleaveSalary] [int] NULL, '
				+ '[Prc_HourMission] [int] NULL, '
				+ '[Prc_DayMission] [smallint] NULL, '
				+ '[Prc_HourDayMission] [int] NULL, '
				+ '[Prc_FullMission] [int] NULL, '
				+ '[Prc_FullHourMission] [int] NULL, '
				+ '[Prc_HourMission51] [int] NULL, '
				+ '[Prc_DayMission61] [smallint] NULL, '
				+ '[Prc_FullMission71] [int] NULL, '
				+ '[Prc_HourMission52] [int] NULL, '
				+ '[Prc_DayMission62] [smallint] NULL, '
				+ '[Prc_FullMission72] [int] NULL, '
				+ '[Prc_Shift1Count] [int] NULL, '
				+ '[Prc_Shift1time] [int] NULL, '
				+ '[Prc_Shift2Count] [int] NULL, '
				+ '[Prc_Shift2time] [int] NULL, '
				+ '[Prc_Shift3Count] [int] NULL, '
				+ '[Prc_Shift3time] [int] NULL, '
				+ '[Prc_Shift4Count] [int] NULL, '
				+ '[Prc_Shift4time] [int] NULL, '
				+ '[Prc_Shift5Count] [int] NULL, '
				+ '[Prc_Shift5time] [int] NULL, '
				+ '[Prc_Zahab] [smallint] NULL, '
				+ '[Prc_Ghaza] [smallint] NULL, '
				+ '[Prc_Type] [smallint] NULL, '
				+ '[Prc_Kind] [smallint] NULL, '
				+ '[Prc_28] [smallint] NULL, '
				+ '[Prc_shiftcode] [smallint] NULL, '
				+ '[Prc_Station] [smallint] NULL, '
				+ '[Prc_Reserve99] [smallint] NULL, '
				+ '[Prc_Changed] [smallint] NULL, '
				+ '[Prc_TakhirCnt] [smallint] NULL, '
				+ '[Prc_TakhirTotal] [smallint] NULL, '
				+ '[Prc_TakhirTotalJarimeh] [smallint] NULL, '
				+ '[Prc_addfreeRemark] [nvarchar](30) NULL, '
				+ '[Prc_scrtimes1] [int] NULL, '
				+ '[Prc_scrtimes2] [int] NULL, '
				+ '[Prc_scrtimes3] [int] NULL, '
				+ '[Prc_scrtimes4] [int] NULL, '
				+ '[Prc_scrtimes5] [int] NULL, '
				+ '[Prc_scrtimes6] [int] NULL, '
				+ '[Prc_scrtimes7] [int] NULL, '
				+ '[Prc_scrtimes8] [int] NULL, '
				+ '[Prc_scrtimes9] [int] NULL, '
				+ '[Prc_scrtimes10] [int] NULL, '
				+ '[Prc_scrdays1] [smallint] NULL, '
				+ '[Prc_scrdays2] [smallint] NULL, '
				+ '[Prc_scrdays3] [smallint] NULL, '
				+ '[Prc_scrdays4] [smallint] NULL, '
				+ '[Prc_scrdays5] [smallint] NULL, '
				+ '[Prc_scrdays6] [smallint] NULL, '
				+ '[Prc_scrdays7] [smallint] NULL, '
				+ '[Prc_scrdays8] [smallint] NULL, '
				+ '[Prc_scrdays9] [smallint] NULL, '
				+ '[Prc_scrdays10] [smallint] NULL, '
				+ '[Prc_PresenceSpecial] [smallint] NULL, '
			+ 'PRIMARY KEY CLUSTERED  '
			+ '( '
				+ '[Prc_PCode] ASC, '
				+ '[Prc_Date] ASC '
			+ ')WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] '
			+ ') ON [PRIMARY]')				
	END			  			  
	SET @sqlCommand = N'DELETE FROM ' + @TableName + ' ' +
						   'WHERE Prc_PCode = ''' + @barCode + '''' +
						   ' AND (' + 
						   'Prc_Date >= ''' + @year + '/' + @month + '/' + @day + '''' +
						   ' OR ' +
						   'Prc_Date = ''' + @year + '/' + @month + '/00'') ' +
						   ' INSERT INTO ' + @TableName + ' (Prc_PCode, ' +
															'Prc_Date, ' +
															'Prc_FirstIn , ' +
															'Prc_FirstOut , ' +
															'Prc_SecondIn , ' +
															'Prc_SecondOut , ' +
															'Prc_ThirdIn , ' +
															'Prc_ThirdOut , ' +
															'Prc_FourthIn , ' +
															'Prc_FourthOut , ' +
															'Prc_FifthIn , ' +
															'Prc_FifthOut , ' +
															'Prc_LastIn , ' +
															'Prc_LastOut , ' +
															'Prc_LastInOut , ' +
															'Prc_NormWork , ' +
															'Prc_NormWorkDay , ' +
															'Prc_PresenceWork , ' +
															'Prc_PresenceWorkDay , ' +
															'Prc_PresenceHolliday , ' +
															'Prc_PresenceHollidays , ' +
															'Prc_PresenceFriday , ' +
															'Prc_PresenceFridays , ' +
															'Prc_WorkFridays , ' +
															'Prc_addnoworkday , ' +
															'Prc_TotalWork , ' +
															'Prc_PureWork , ' +
															'Prc_PureWorkKham , ' +
															'Prc_PureDayWork , ' +
															'Prc_PureWorkNight , ' +
															'Prc_PureWorkNights , ' +
															'Prc_standardwork , ' +
															'Prc_ValidTakhir , ' +
															'Prc_ValidTajil , ' +
															'Prc_ValidAddWork , ' +
															'Prc_ValidAddWorkHolliday , ' +
															'Prc_ValidAddWorkNoworkday , ' +
															'Prc_ValidaddWorkFriday , ' +
															'Prc_InValidaddWorkFriday , ' +
															'Prc_ValidaddWorkHolNoFr , ' +
															'Prc_InvalidaddWorkHolNoFr , ' +
															'Prc_ValidAddWorkbefore , ' +
															'Prc_ValidAddWorkafter , ' +
															'Prc_ValidAddWorkbein , ' +
															'Prc_keshik , ' +
															'Prc_janbaz , ' +
															'Prc_ValidAddWorkNight , ' +
															'Prc_ValidAddWorkFree , ' +
															'Prc_InvalidAddWork , ' +
															'Prc_TotalLessWork , ' +
															'Prc_ValidLessWork , ' +
															'Prc_BeinLessWork , ' +
															'Prc_TakhirLessWork , ' +
															'Prc_TajilLessWork , ' +
															'Prc_HourAbsence , ' +
															'Prc_DayAbsence , ' +
															'Prc_HourDayAbsence , ' +
															'Prc_DayAbsencePure , ' +
															'Prc_HourAbsencePure , ' +
															'Prc_AbsenceNaghes , ' +
															'Prc_HourleaveNoSalary , ' +
															'Prc_DayleaveNoSalary , ' +
															'Prc_HourDayleaveNoSalary , ' +
															'Prc_HourSleaveNoSalary , ' +
															'Prc_DaySleaveNoSalary , ' +
															'Prc_HourDaySleaveNoSalary , ' +
															'Prc_HourleaveSalary , ' +
															'Prc_DayleaveSalary , ' +
															'Prc_HourDayleaveSalary , ' +
															'Prc_HourEleaveSalary , ' +
															'Prc_HourEleaveSalarysum , ' +
															'Prc_DayEleaveSalary , ' +
															'Prc_HourDayEleaveSalary , ' +
															'Prc_HourSleaveSalary , ' +
															'Prc_DaySleaveSalary , ' +
															'Prc_HourDaySleaveSalary , ' +
															'Prc_HourMission , ' +
															'Prc_DayMission , ' +
															'Prc_HourDayMission , ' +
															'Prc_FullMission , ' +
															'Prc_FullHourMission , ' +
															'Prc_HourMission51 , ' +
															'Prc_DayMission61 , ' +
															'Prc_FullMission71 , ' +
															'Prc_HourMission52 , ' +
															'Prc_DayMission62 , ' +
															'Prc_FullMission72 , ' +
															'Prc_Shift1Count , ' +
															'Prc_Shift1time , ' +
															'Prc_Shift2Count , ' +
															'Prc_Shift2time , ' +
															'Prc_Shift3Count , ' +
															'Prc_Shift3time , ' +
															'Prc_Shift4Count , ' +
															'Prc_Shift4time , ' +
															'Prc_Shift5Count , ' +
															'Prc_Shift5time , ' +
															'Prc_Zahab , ' +
															'Prc_Ghaza , ' +
															'Prc_Type , ' +
															'Prc_Kind , ' +
															'Prc_28 , ' +
															'Prc_shiftcode , ' +
															'Prc_Station , ' +
															'Prc_Reserve99 , ' +
															'Prc_Changed , ' +
															'Prc_TakhirCnt , ' +
															'Prc_TakhirTotal , ' +
															'Prc_TakhirTotalJarimeh , ' +
															'Prc_addfreeRemark, ' +
															'Prc_scrtimes1 , ' +
															'Prc_scrtimes2 , ' +
															'Prc_scrtimes3 , ' +
															'Prc_scrtimes4 , ' +
															'Prc_scrtimes5 , ' +
															'Prc_scrtimes6 , ' +
															'Prc_scrtimes7 , ' +
															'Prc_scrtimes8 , ' +
															'Prc_scrtimes9 , ' +
															'Prc_scrtimes10 , ' +
															'Prc_scrdays1 , ' +
															'Prc_scrdays2 , ' +
															'Prc_scrdays3 , ' +
															'Prc_scrdays4 , ' +
															'Prc_scrdays5 , ' +
															'Prc_scrdays6 , ' +
															'Prc_scrdays7 , ' +
															'Prc_scrdays8 , ' +
															'Prc_scrdays9 , ' +
															'Prc_scrdays10 , ' +
															'Prc_PresenceSpecial) ' +
							'SELECT * ' +
							'FROM ' + @tmpTableName + ' ' +
							'DROP TABLE ' + @tmpTableName
						    

	EXEC sp_executesql @sqlCommand

	SELECT 1 AS UpdatePTable_ID, 0 AS UpdatePTable_Result										 					 
				
	
END
