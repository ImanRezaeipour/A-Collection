$(document).ready
        (
            function () {
                document.body.dir = document.FromDate_ToDate_ReportParameterForm.dir;
                SetWrapper_Alert_Box(document.FromDate_ToDate_ReportParameterForm.id);
                //ViewCurrentLangCalendars_RuleParameters();
                ResetCalendars_FromDate_ToDate_ReportParameter();
                SetReportParameterObj_FromDate_ToDate_ReportParameter();

            }
        );