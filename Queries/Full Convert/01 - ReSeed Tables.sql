BEGIN TRANSACTION ReSeedTables

BEGIN -- ریسید کردن جداول 

    DBCC CHECKIDENT ('TA_Person', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Illness', RESEED, 0)	
    DBCC CHECKIDENT ('TA_FlowGroup', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessOrgan', RESEED, 0)	
    DBCC CHECKIDENT ('TA_OrganDefine', RESEED, 0)	
    DBCC CHECKIDENT ('TA_PermitPair', RESEED, 0)	
    DBCC CHECKIDENT ('TA_AssignWorkGroup', RESEED, 0)	
    DBCC CHECKIDENT ('TA_AssignRuleParameter', RESEED, 0)	
    DBCC CHECKIDENT ('TA_CalculationDateRangeTemplate', RESEED, 0)	
    DBCC CHECKIDENT ('TA_EngineCalculationDateRange', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessWorkGroup', RESEED, 0)	
    DBCC CHECKIDENT ('TA_LeaveSettings', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Calculation_Flag_Persons', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessShift', RESEED, 0)	
    DBCC CHECKIDENT ('TA_EmploymentType', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ELESetting', RESEED, 0)	
    DBCC CHECKIDENT ('TA_UsedLeaveDetail', RESEED, 0)	
    DBCC CHECKIDENT ('TA_WorkGroupDetail', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessRuleGroup', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DutyPlace', RESEED, 0)	
    DBCC CHECKIDENT ('TA_TrafficSettings', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Doctor', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Department', RESEED, 0)	
    DBCC CHECKIDENT ('TA_RuleConcept', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DefinedConceptValue', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ControlStation', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessManager', RESEED, 0)	
    DBCC CHECKIDENT ('TA_SecondaryConceptParameter', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ConceptTemplateParameter', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ShiftPair', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ConceptTemplateMapping', RESEED, 0)	
    DBCC CHECKIDENT ('TA_PersonParamValue', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ShiftException', RESEED, 0)	
    DBCC CHECKIDENT ('TA_CompaireDiffrence', RESEED, 0)	
    DBCC CHECKIDENT ('TA_UnderManagment', RESEED, 0)	
    DBCC CHECKIDENT ('TA_TriggerLog', RESEED, 0)	
    DBCC CHECKIDENT ('TA_UserSettings', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Request', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Rule', RESEED, 0)	
    DBCC CHECKIDENT ('TA_SecondaryConceptMap', RESEED, 0)	
    DBCC CHECKIDENT ('TA_RuleParameter', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ImperativeRequest', RESEED, 0)	
    DBCC CHECKIDENT ('TA_RuleCategory', RESEED, 0)	
    DBCC CHECKIDENT ('TA_CalcClose', RESEED, 0)	
    DBCC CHECKIDENT ('TA_LeaveYearRemain', RESEED, 0)	
    DBCC CHECKIDENT ('TA_CFPLog', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Manager', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ProceedTrafficPair', RESEED, 0)	
    DBCC CHECKIDENT ('TA_LeaveCalcResult', RESEED, 0)	
    DBCC CHECKIDENT ('TA_OperatorDateRangeAccess', RESEED, 0)	
    DBCC CHECKIDENT ('TA_OperatorWorkGroupAccess', RESEED, 0)	
    DBCC CHECKIDENT ('TA_WorkGroup', RESEED, 0)	
    DBCC CHECKIDENT ('TA_OperatorUndermanagement', RESEED, 0)	
    DBCC CHECKIDENT ('TA_OperatorShiftAccess', RESEED, 0)	
    DBCC CHECKIDENT ('TA_OperatorRuleGroupAccess', RESEED, 0)	
    DBCC CHECKIDENT ('TA_SecurityActiveDirectoryDomains', RESEED, 0)	
    DBCC CHECKIDENT ('TA_SecurityUser', RESEED, 0)	
    DBCC CHECKIDENT ('TA_OperatorReportAccess', RESEED, 0)	
    DBCC CHECKIDENT ('TA_OperatorManagerAccess', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Shift', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ManagerFlow', RESEED, 0)	
    DBCC CHECKIDENT ('TA_GridMonthlyOperationGridClientSettings', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessOrganizationUnit', RESEED, 0)	
    DBCC CHECKIDENT ('TA_GridMonthlyOperationGridMasterSettings', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ExceptionShift', RESEED, 0)	
    DBCC CHECKIDENT ('TA_RequestDetail', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessPrecard', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Substitute', RESEED, 0)	
    DBCC CHECKIDENT ('TA_SubstitutePrecardAccess', RESEED, 0)	
    DBCC CHECKIDENT ('TA_RuleCategoryPart', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessReport', RESEED, 0)	
    DBCC CHECKIDENT ('TA_RequestStatus', RESEED, 0)	
    DBCC CHECKIDENT ('TA_SecondaryConcept', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessFlow', RESEED, 0)	
    DBCC CHECKIDENT ('TA_CoceptsReserveField', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DesignedReportColumn', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessDoctor', RESEED, 0)	
    DBCC CHECKIDENT ('TA_GunChartClientSettings', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Budget', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DesignedReportCondition', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessCtrlStation', RESEED, 0)	
    DBCC CHECKIDENT ('TA_NotificationServicesHistory', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Flow', RESEED, 0)	
    DBCC CHECKIDENT ('TA_PairableSecondaryConceptValuePair', RESEED, 0)	
    DBCC CHECKIDENT ('TA_LeaveIncDec', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Clock', RESEED, 0)	
    DBCC CHECKIDENT ('TA_GridDetailedMonthlyOperationGridFields', RESEED, 0)	
    DBCC CHECKIDENT ('TA_PTable', RESEED, 0)	
    DBCC CHECKIDENT ('TA_DataAccessDepartment', RESEED, 0)	
    DBCC CHECKIDENT ('TA_PriorityDependency', RESEED, 0)	
    DBCC CHECKIDENT ('TA_BaseTraffic', RESEED, 0)	
    DBCC CHECKIDENT ('TA_PublicMessage', RESEED, 0)	
    DBCC CHECKIDENT ('TA_OverTimePermit', RESEED, 0)	
    DBCC CHECKIDENT ('TA_NobatKari', RESEED, 0)	
    DBCC CHECKIDENT ('TA_OrganizationUnit', RESEED, 0)	
    DBCC CHECKIDENT ('TA_PrivateMessage', RESEED, 0)	
    DBCC CHECKIDENT ('TA_MissionLocation', RESEED, 0)	
    DBCC CHECKIDENT ('TA_PersonRangeAssignment', RESEED, 0)	
    DBCC CHECKIDENT ('TA_PersonCalculationValidity', RESEED, 0)	
    DBCC CHECKIDENT ('TA_GridMasterMonthlyOperationGridFields', RESEED, 0)	
    DBCC CHECKIDENT ('TA_UIValidationGrouping', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Permit', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ArchiveConceptValue', RESEED, 0)	
    DBCC CHECKIDENT ('TA_GridExistConcepts', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ClockType', RESEED, 0)	
    DBCC CHECKIDENT ('TA_PersonRuleCategoryAssignment', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Chart', RESEED, 0)	
    DBCC CHECKIDENT ('TA_ProceedTraffic', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Operator', RESEED, 0)	
    DBCC CHECKIDENT ('TA_GridColumnColor', RESEED, 0)	
    DBCC CHECKIDENT ('TA_Grade', RESEED, 0)	
	DBCC CHECKIDENT ('TA_BioTmpIds', RESEED, 0)	
	DBCC CHECKIDENT ('TA_NormalDateRange', RESEED, 0)	
	DBCC CHECKIDENT ('TA_UIValidationRuleParameter', RESEED, 0)	
	DBCC CHECKIDENT ('TA_PersonReserveFieldComboValue', RESEED, 0)	
	DBCC CHECKIDENT ('TA_TemplateCondition', RESEED, 0)	
	DBCC CHECKIDENT ('TA_RuleTemplateMapping', RESEED, 0)	
	DBCC CHECKIDENT ('TA_UIValidationGroup', RESEED, 0)	
	DBCC CHECKIDENT ('TA_GridMonthlyOperationConceptValues', RESEED, 0)	
	DBCC CHECKIDENT ('TA_SecondaryConceptValue', RESEED, 0)	
	--DBCC CHECKIDENT ('TA_DashboardSettings', RESEED, 0)	
	--DBCC CHECKIDENT ('TA_SMSSettings', RESEED, 0)	
	--DBCC CHECKIDENT ('TA_EmailSettings', RESEED, 0)	
    --DBCC CHECKIDENT ('TA_PersonTASpec', RESEED, 0)	
	--DBCC CHECKIDENT ('TA_PersonDetail', RESEED, 0)	

	 --SELECT * FROM TA_DesignedReportType
	 --SELECT * FROM TA_UIValidationRuleTempPatameter
	 --SELECT * FROM TA_SecurityAuthorize
     --SELECT * FROM TA_ArchiveDataFieldMap
     --SELECT * FROM TA_PrecardAccessGroupDetail
     --SELECT * FROM TA_UISkin
     --SELECT * FROM TA_CalendarType
     --SELECT * FROM TA_PeriodicCnpTmpDetail
     --SELECT * FROM TA_Languages
     --SELECT * FROM TA_KartablSummary
     --SELECT * FROM TA_RuleTemplateParameter
     --SELECT * FROM TA_PrecardGroups
     --SELECT * FROM TA_Precard
     --SELECT * FROM TA_PrecardAccessGroup
     --SELECT * FROM TA_GridMonthlyOperationGridClientGeneralSettings
     --SELECT * FROM TA_Calendar
     --SELECT * FROM TA_RolePrecard
     --SELECT * FROM TA_GridMonthlyOperationGridMasterGeneralSettings
     --SELECT * FROM TA_HolidaysTemplate
     --SELECT * FROM TA_CalculationDateRange
     --SELECT * FROM TA_ApplicationLanguageSettings
     --SELECT * FROM TA_RuleTemplate
     --SELECT * FROM TA_Report
     --SELECT * FROM TA_ReportParameter
     --SELECT * FROM TA_Help
     --SELECT * FROM TA_PersonReserveField
     --SELECT * FROM TA_ConceptTemplate
     --SELECT * FROM TA_Dashboards
     --SELECT * FROM TA_SecurityResource
     --SELECT * FROM TA_SecurityRole
     --SELECT * FROM TA_ReportUIParameter
     --SELECT * FROM TA_UIValidationRulePrecard
     --SELECT * FROM TA_ReportFile
     --SELECT * FROM TA_RuleType
     --SELECT * FROM TA_PersonParamFields
     --SELECT * FROM TA_ShiftPairType
     --SELECT * FROM TA_ApplicationSettings
     --SELECT * FROM TA_CalculationRangeGroup
     --SELECT * FROM TA_UIValidationRule							

END

COMMIT TRANSACTION ReSeedTables