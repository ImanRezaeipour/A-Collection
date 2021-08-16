Alter Table CL_Contractor
DROP CONSTRAINT FK_CL_Contractor_TA_Person
Go
Alter Table CL_Contractor
DROP COLUMN contractor_MeetingPersonId
Go
Alter Table CL_Contractor
ADD contractor_MeetingPersonId numeric(18,0) 
Go
ALTER TABLE CL_Contractor  WITH CHECK ADD  CONSTRAINT FK_CL_Contractor_TA_Person FOREIGN KEY([contractor_MeetingPersonId])
REFERENCES TA_Person([Prs_ID])
Go
 