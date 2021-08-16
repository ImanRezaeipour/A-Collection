update TA_ReportFile
set ReportFile_File=REPLACE(ReportFile_File,'LeaveYearRemain_Date&gt;=@fromDate','LeaveYearRemain_Date&gt;=@fromDate and LeaveYearRemain_Date&lt;=@toDate')
 where ReportFile_Name='R4343A395'