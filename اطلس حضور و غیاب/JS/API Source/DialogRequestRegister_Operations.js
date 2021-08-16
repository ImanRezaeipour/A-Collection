
var CurrentPageCombosCallBcakStateObj = new Object();
var ObjRequestRegister = null;
var LoadState_cmbPersonnel_RequestRegister = 'Normal';
var SearchTerm_cmbPersonnel_RequestRegister = '';
var AdvancedSearchTerm_cmbPersonnel_RequestRegister = '';
var CurrentPageIndex_cmbPersonnel_RequestRegister = 0;
var StrUnCollectivePersonnelList_CollectiveTraffic = '';
var CurrentPageIndex_GridPersonnel_CollectiveTraffic = 0;
var RequestPersonnelCountState_RequestRegister = 'Single';
var CollectiveConditions = null;
var zeroTime = '00';
var NullTime_RequestRegister = '';

function GetBoxesHeaders_RequestRegister() {
    var ObjDialogRequestRegister = parent.DialogRequestRegister.get_value();
    var RequestCaller = ObjDialogRequestRegister.Caller;
    if (RequestCaller == 'Operator') {
        document.getElementById('clmnName_cmbPersonnel_RequestRegister').innerHTML = document.getElementById('hfclmnName_cmbPersonnel_RequestRegister').value;
        document.getElementById('clmnBarCode_cmbPersonnel_RequestRegister').innerHTML = document.getElementById('hfclmnBarCode_cmbPersonnel_RequestRegister').value;
        document.getElementById('clmnCardNum_cmbPersonnel_RequestRegister').innerHTML = document.getElementById('hfclmnCardNum_cmbPersonnel_RequestRegister').value;
    }
    parent.document.getElementById('Title_DialogRequestRegister').innerHTML = document.getElementById('hfTitle_DialogRequestRegister').value;
    document.getElementById('cmbRequestType_tbHourly_RequestRegister_Input').value = document.getElementById('cmbRequestType_tbDaily_RequestRegister_Input').value = document.getElementById('cmbRequestType_tbOverTime_RequestRegister_Input').value = document.getElementById('hfcmbAlarm_RequestRegister').value;
    document.getElementById('header_Personnel_CollectiveTraffic').innerHTML = document.getElementById('hfheader_Personnel_CollectiveTraffic').value;
    document.getElementById('footer_GridPersonnel_CollectiveTraffic').innerHTML = document.getElementById('hffooter_GridPersonnel_CollectiveTraffic').value;
}

function initTimePickers_RequestRegister(pageState) {
    SetButtonImages_TimeSelectors_DialogRequestRegister();
    ChangeTimePickersEnabled_RequestRegister(pageState, 'enable');
    ResetTimepickers_RequestRegister(pageState);
}

function ChangeTimePickersEnabled_RequestRegister(pageState, state) {
    ChangeTimePickerEnabled_RequestRegister(pageState, 'TimeSelector_FromHour_tbHourly_RequestRegister', state);
    ChangeTimePickerEnabled_RequestRegister(pageState, 'TimeSelector_ToHour_tbHourly_RequestRegister', state);
    ChangeTimePickerEnabled_RequestRegister(pageState, 'TimeSelector_FromHour_tbOverTime_RequestRegister', state);
    ChangeTimePickerEnabled_RequestRegister(pageState, 'TimeSelector_ToHour_tbOverTime_RequestRegister', state);
    ChangeTimePickerEnabled_RequestRegister(pageState, 'TimeSelector_Duration_tbOverTime_RequestRegister', state);
}

function ChangeTimePickerEnabled_RequestRegister(pageState, TimeSelector, state) {
    var disabled = null;
    switch (state) {
        case 'disable':
            disabled = 'disabled';
            document.getElementById("" + TimeSelector + "_imgUp").onclick = " ";
            document.getElementById("" + TimeSelector + "_imgDown").onclick = " ";
            break;
        case 'enable':
            disabled = '';
            document.getElementById("" + TimeSelector + "_imgUp").onclick = function () {
                CheckTimePickerState_RequestRegister(TimeSelector + '_txtHour');
                CheckTimePickerState_RequestRegister(TimeSelector + '_txtMinute');
                addTime(document.getElementById("" + TimeSelector + "_imgUp"), 24, 1, 1);
            };
            document.getElementById("" + TimeSelector + "_imgDown").onclick = function () {
                CheckTimePickerState_RequestRegister(TimeSelector + '_txtHour');
                CheckTimePickerState_RequestRegister(TimeSelector + '_txtMinute');
                subtractTime(document.getElementById("" + TimeSelector + "_imgDown"), 24, 1, 1);
            };
            document.getElementById("" + TimeSelector + "_txtHour").onchange = function () {
                CheckTimeSelectorPartValue_RequestRegister(pageState, TimeSelector, '_txtHour');
            };
            document.getElementById("" + TimeSelector + "_txtMinute").onchange = function () {
                CheckTimeSelectorPartValue_RequestRegister(pageState, TimeSelector, '_txtMinute');
            };
            break;
    }
    document.getElementById("" + TimeSelector + "_txtHour").disabled = disabled;
    document.getElementById("" + TimeSelector + "_txtHour").nextSibling.disabled = disabled;
    document.getElementById("" + TimeSelector + "_txtMinute").disabled = disabled;
    document.getElementById("" + TimeSelector + "_txtMinute").nextSibling.disabled = disabled;
    document.getElementById("" + TimeSelector + "_txtSecond").disabled = disabled;
}

function CheckTimeSelectorPartValue_RequestRegister(pageState, TimeSelectorPartID, identifier) {
    if (document.getElementById(TimeSelectorPartID + identifier).value == "") {
        switch (identifier) {
            case '_txtHour':
                var strTime = zeroTime;
                switch (pageState) {
                    case 'Load':
                        break;
                    case 'Change':
                        if (cmbRequestType_tbHourly_RequestRegister.getSelectedItem() != undefined) {
                            var ObjRequestTargetFeatures = cmbRequestType_tbHourly_RequestRegister.getSelectedItem().get_value();
                            ObjRequestTargetFeatures = eval('(' + ObjRequestTargetFeatures + ')');
                            if (ObjRequestTargetFeatures.IsTraffic)
                                strTime = NullTime_RequestRegister;
                        }
                        break;
                }
                document.getElementById(TimeSelectorPartID + identifier).value = strTime;
                break;
            case '_txtMinute':
                document.getElementById(TimeSelectorPartID + identifier).value = zeroTime;
                intOnly(document.getElementById(TimeSelectorPartID + identifier), 24);
                break;
        }
    }
    else {
        intOnly(document.getElementById(TimeSelectorPartID + identifier), 24);
    }
}

function RequestRegister_onKeyDown(event) {
    var activeID = null;
    if (event.keyCode == 38 || event.keyCode == 40) {
        activeID = document.activeElement.id;
        CheckTimePickerState_RequestRegister(activeID);
    }
}

function CheckTimePickerState_RequestRegister(TimeSelector) {
    if ((TimeSelector == 'TimeSelector_FromHour_tbHourly_RequestRegister_txtHour' && isNaN(document.getElementById(TimeSelector).value)) || (TimeSelector == 'TimeSelector_FromHour_tbHourly_RequestRegister_txtMinute' && (isNaN(document.getElementById(TimeSelector).value) || document.getElementById('TimeSelector_FromHour_tbHourly_RequestRegister_txtHour').value == NullTime_RequestRegister)) || (TimeSelector == 'TimeSelector_FromHour_tbHourly_RequestRegister_txtHour' && parseInt(document.getElementById(TimeSelector).value) < 0))
        document.getElementById('TimeSelector_FromHour_tbHourly_RequestRegister_txtHour').value = zeroTime;
    if ((TimeSelector == 'TimeSelector_ToHour_tbHourly_RequestRegister_txtHour' && isNaN(document.getElementById(TimeSelector).value)) || (TimeSelector == 'TimeSelector_ToHour_tbHourly_RequestRegister_txtMinute' && (isNaN(document.getElementById(TimeSelector).value) || document.getElementById('TimeSelector_ToHour_tbHourly_RequestRegister_txtHour').value == NullTime_RequestRegister)) || (TimeSelector == 'TimeSelector_ToHour_tbHourly_RequestRegister_txtHour' && parseInt(document.getElementById(TimeSelector).value) < 0))
        document.getElementById('TimeSelector_ToHour_tbHourly_RequestRegister_txtHour').value = zeroTime;
    if ((TimeSelector == 'TimeSelector_FromHour_tbOverTime_RequestRegister_txtHour' && isNaN(document.getElementById(TimeSelector).value)) || (TimeSelector == 'TimeSelector_FromHour_tbOverTime_RequestRegister_txtMinute' && (isNaN(document.getElementById(TimeSelector).value) || document.getElementById('TimeSelector_FromHour_tbOverTime_RequestRegister_txtHour').value == NullTime_RequestRegister)) || (TimeSelector == 'TimeSelector_FromHour_tbOverTime_RequestRegister_txtHour' && parseInt(document.getElementById(TimeSelector).value) < 0))
        document.getElementById('TimeSelector_FromHour_tbOverTime_RequestRegister_txtHour').value = zeroTime;
    if ((TimeSelector == 'TimeSelector_ToHour_tbOverTime_RequestRegister_txtHour' && isNaN(document.getElementById(TimeSelector).value)) || (TimeSelector == 'TimeSelector_ToHour_tbOverTime_RequestRegister_txtMinute' && (isNaN(document.getElementById(TimeSelector).value) || document.getElementById('TimeSelector_ToHour_tbOverTime_RequestRegister_txtHour').value == NullTime_RequestRegister)) || (TimeSelector == 'TimeSelector_ToHour_tbOverTime_RequestRegister_txtHour' && parseInt(document.getElementById(TimeSelector).value) < 0))
        document.getElementById('TimeSelector_ToHour_tbOverTime_RequestRegister_txtHour').value = zeroTime;
    if ((TimeSelector == 'TimeSelector_Duration_tbOverTime_RequestRegister_txtHour' && isNaN(document.getElementById(TimeSelector).value)) || (TimeSelector == 'TimeSelector_Duration_tbOverTime_RequestRegister_txtMinute' && (isNaN(document.getElementById(TimeSelector).value) || document.getElementById('TimeSelector_Duration_tbOverTime_RequestRegister_txtHour').value == NullTime_RequestRegister)) || (TimeSelector == 'TimeSelector_Duration_tbOverTime_RequestRegister_txtHour' && parseInt(document.getElementById(TimeSelector).value) < 0))
        document.getElementById('TimeSelector_Duration_tbOverTime_RequestRegister_txtHour').value = zeroTime;
    if ((TimeSelector == 'TimeSelector_FromHour_tbHourly_RequestRegister_txtMinute' || TimeSelector == 'TimeSelector_ToHour_tbHourly_RequestRegister_txtMinute' || TimeSelector == 'TimeSelector_FromHour_tbOverTime_RequestRegister_txtMinute' || TimeSelector == 'TimeSelector_ToHour_tbOverTime_RequestRegister_txtMinute' || TimeSelector == 'TimeSelector_ToHour_tbOverTime_RequestRegister_txtMinute' || TimeSelector == 'TimeSelector_Duration_tbOverTime_RequestRegister_txtMinute') && (isNaN(document.getElementById(TimeSelector).value) || parseInt(document.getElementById(TimeSelector).value) < 0))
        document.getElementById(TimeSelector).value = zeroTime;
}


function ViewCurrentLangCalendars_RequestRegister() {
    switch (parent.parent.SysLangID) {
        case 'en-US':
            document.getElementById("pdpRequestDate_tbHourly_RequestRegister").parentNode.removeChild(document.getElementById("pdpRequestDate_tbHourly_RequestRegister"));
            document.getElementById("pdpRequestDate_tbHourly_RequestRegisterimgbt").parentNode.removeChild(document.getElementById("pdpRequestDate_tbHourly_RequestRegisterimgbt"));
            document.getElementById("pdpFromDate_tbDaily_RequestRegister").parentNode.removeChild(document.getElementById("pdpFromDate_tbDaily_RequestRegister"));
            document.getElementById("pdpFromDate_tbDaily_RequestRegisterimgbt").parentNode.removeChild(document.getElementById("pdpFromDate_tbDaily_RequestRegisterimgbt"));
            document.getElementById("pdpToDate_tbDaily_RequestRegister").parentNode.removeChild(document.getElementById("pdpToDate_tbDaily_RequestRegister"));
            document.getElementById("pdpToDate_tbDaily_RequestRegisterimgbt").parentNode.removeChild(document.getElementById("pdpToDate_tbDaily_RequestRegisterimgbt"));
            document.getElementById("pdpFromDate_tbOverTime_RequestRegister").parentNode.removeChild(document.getElementById("pdpFromDate_tbOverTime_RequestRegister"));
            document.getElementById("pdpFromDate_tbOverTime_RequestRegisterimgbt").parentNode.removeChild(document.getElementById("pdpFromDate_tbOverTime_RequestRegisterimgbt"));
            document.getElementById("pdpToDate_tbOverTime_RequestRegister").parentNode.removeChild(document.getElementById("pdpToDate_tbOverTime_RequestRegister"));
            document.getElementById("pdpToDate_tbOverTime_RequestRegisterimgbt").parentNode.removeChild(document.getElementById("pdpToDate_tbOverTime_RequestRegisterimgbt"));
            break;
        case 'fa-IR':
            document.getElementById("Container_RequestDateCalendars_tbHourly_RequestRegister").removeChild(document.getElementById("Container_gCalRequestDate_tbHourly_RequestRegister"));
            document.getElementById("Container_FromDateCalendars_tbDaily_RequestRegister").removeChild(document.getElementById("Container_gCalFromDate_tbDaily_RequestRegister"));
            document.getElementById("Container_ToDateCalendars_tbDaily_RequestRegister").removeChild(document.getElementById("Container_gCalToDate_tbDaily_RequestRegister"));
            document.getElementById("Container_FromDateCalendars_tbOverTime_RequestRegister").removeChild(document.getElementById("Container_gCalFromDate_tbOverTime_RequestRegister"));
            document.getElementById("Container_ToDateCalendars_tbOverTime_RequestRegister").removeChild(document.getElementById("Container_gCalToDate_tbOverTime_RequestRegister"));
            break;
    }
}

function SetButtonImages_TimeSelectors_DialogRequestRegister() {
    SetButtonImages_TimeSelector_DialogRequestRegister('TimeSelector_FromHour_tbHourly_RequestRegister');
    SetButtonImages_TimeSelector_DialogRequestRegister('TimeSelector_ToHour_tbHourly_RequestRegister');
    SetButtonImages_TimeSelector_DialogRequestRegister('TimeSelector_FromHour_tbOverTime_RequestRegister');
    SetButtonImages_TimeSelector_DialogRequestRegister('TimeSelector_ToHour_tbOverTime_RequestRegister');
    SetButtonImages_TimeSelector_DialogRequestRegister('TimeSelector_Duration_tbOverTime_RequestRegister');
}

function SetButtonImages_TimeSelector_DialogRequestRegister(TimeSelector) {
    document.getElementById("" + TimeSelector + "_imgUp").src = "images/TimeSelector/CustomUp.gif";
    document.getElementById("" + TimeSelector + "_imgDown").src = "images/TimeSelector/CustomDown.gif";
    document.getElementById("" + TimeSelector + "_imgUp").onmouseover = function () {
        document.getElementById("" + TimeSelector + "_imgUp").src = "images/TimeSelector/oie_CustomUp.gif";
        FocusOnCurrentTimeSelector(TimeSelector);
    };
    document.getElementById("" + TimeSelector + "_imgDown").onmouseover = function () {
        document.getElementById("" + TimeSelector + "_imgDown").src = "images/TimeSelector/oie_CustomDown.gif";
        FocusOnCurrentTimeSelector(TimeSelector);
    };
    document.getElementById("" + TimeSelector + "_imgUp").onmouseout = function () {
        document.getElementById("" + TimeSelector + "_imgUp").src = "images/TimeSelector/CustomUp.gif";
    };
    document.getElementById("" + TimeSelector + "_imgDown").onmouseout = function () {
        document.getElementById("" + TimeSelector + "_imgDown").src = "images/TimeSelector/CustomDown.gif";
    };
}

function FocusOnCurrentTimeSelector(TimeSelector) {
    try {
        if (document.activeElement.id != "" + TimeSelector + "_txtHour" && document.activeElement.id != "" + TimeSelector + "_txtMinute" && document.activeElement.id != "" + TimeSelector + "_txtSecond")
            document.getElementById("" + TimeSelector + "_txtHour").focus();
    }
    catch (error) {
    }
}

function btn_gdpRequestDate_tbHourly_RequestRegister_OnMouseUp(event) {
    if (gCalRequestDate_tbHourly_RequestRegister.get_popUpShowing()) {
        event.cancelBubble = true;
        event.returnValue = false;
        return false;
    }
    else {
        return true;
    }
}

function btn_gdpRequestDate_tbHourly_RequestRegister_OnClick(event) {
    if (gCalRequestDate_tbHourly_RequestRegister.get_popUpShowing()) {
        gCalRequestDate_tbHourly_RequestRegister.hide();
    }
    else {
        gCalRequestDate_tbHourly_RequestRegister.setSelectedDate(gdpRequestDate_tbHourly_RequestRegister.getSelectedDate());
        gCalRequestDate_tbHourly_RequestRegister.show();
    }
}

function gdpRequestDate_tbHourly_RequestRegister_OnDateChange(sender, e) {
    var RequestDate = gdpRequestDate_tbHourly_RequestRegister.getSelectedDate();
    gCalRequestDate_tbHourly_RequestRegister.setSelectedDate(RequestDate);
}

function gCalRequestDate_tbHourly_RequestRegister_OnChange(sender, e) {
    var RequestDate = gCalRequestDate_tbHourly_RequestRegister.getSelectedDate();
    gdpRequestDate_tbHourly_RequestRegister.setSelectedDate(RequestDate);
}

function gCalRequestDate_tbHourly_RequestRegister_OnLoad(sender, e) {
    window.gCalRequestDate_tbHourly_RequestRegister.PopUpObject.z = 25000000;
}

function btn_gdpFromDate_tbDaily_RequestRegister_OnMouseUp(event) {
    if (gCalFromDate_tbDaily_RequestRegister.get_popUpShowing()) {
        event.cancelBubble = true;
        event.returnValue = false;
        return false;
    }
    else {
        return true;
    }
}

function btn_gdpFromDate_tbDaily_RequestRegister_OnClick(event) {
    if (gCalFromDate_tbDaily_RequestRegister.get_popUpShowing()) {
        gCalFromDate_tbDaily_RequestRegister.hide();
    }
    else {
        gCalFromDate_tbDaily_RequestRegister.setSelectedDate(gdpFromDate_tbDaily_RequestRegister.getSelectedDate());
        gCalFromDate_tbDaily_RequestRegister.show();
    }
}

function gdpFromDate_tbDaily_RequestRegister_OnDateChange(sender, e) {
    var FromDate = gdpFromDate_tbDaily_RequestRegister.getSelectedDate();
    gCalFromDate_tbDaily_RequestRegister.setSelectedDate(FromDate);
}

function gCalFromDate_tbDaily_RequestRegister_OnChange(sender, e) {
    var FromDate = gCalFromDate_tbDaily_RequestRegister.getSelectedDate();
    gdpFromDate_tbDaily_RequestRegister.setSelectedDate(FromDate);
}

function gCalFromDate_tbDaily_RequestRegister_OnLoad(sender, e) {
    window.gCalFromDate_tbDaily_RequestRegister.PopUpObject.z = 25000000;
}

function btn_gdpToDate_tbDaily_RequestRegister_OnMouseUp(event) {
    if (gCalToDate_tbDaily_RequestRegister.get_popUpShowing()) {
        event.cancelBubble = true;
        event.returnValue = false;
        return false;
    }
    else {
        return true;
    }
}

function btn_gdpToDate_tbDaily_RequestRegister_OnClick(event) {
    if (gCalToDate_tbDaily_RequestRegister.get_popUpShowing()) {
        gCalToDate_tbDaily_RequestRegister.hide();
    }
    else {
        gCalToDate_tbDaily_RequestRegister.setSelectedDate(gdpToDate_tbDaily_RequestRegister.getSelectedDate());
        gCalToDate_tbDaily_RequestRegister.show();
    }
}

function gdpToDate_tbDaily_RequestRegister_OnDateChange(sender, e) {
    var ToDate = gdpToDate_tbDaily_RequestRegister.getSelectedDate();
    gCalToDate_tbDaily_RequestRegister.setSelectedDate(ToDate);
}

function gCalToDate_tbDaily_RequestRegister_OnChange(sender, e) {
    var ToDate = gCalToDate_tbDaily_RequestRegister.getSelectedDate();
    gdpToDate_tbDaily_RequestRegister.setSelectedDate(ToDate);
}

function gCalToDate_tbDaily_RequestRegister_OnLoad(sender, e) {
    window.gCalToDate_tbDaily_RequestRegister.PopUpObject.z = 25000000;
}

function btn_gdpFromDate_tbOverTime_RequestRegister_OnMouseUp(event) {
    if (gCalFromDate_tbOverTime_RequestRegister.get_popUpShowing()) {
        event.cancelBubble = true;
        event.returnValue = false;
        return false;
    }
    else {
        return true;
    }
}

function btn_gdpFromDate_tbOverTime_RequestRegister_OnClick(event) {
    if (gCalFromDate_tbOverTime_RequestRegister.get_popUpShowing()) {
        gCalFromDate_tbOverTime_RequestRegister.hide();
    }
    else {
        gCalFromDate_tbOverTime_RequestRegister.setSelectedDate(gdpFromDate_tbOverTime_RequestRegister.getSelectedDate());
        gCalFromDate_tbOverTime_RequestRegister.show();
    }
}

function gdpFromDate_tbOverTime_RequestRegister_OnDateChange(sender, e) {
    var FromDate = gdpFromDate_tbOverTime_RequestRegister.getSelectedDate();
    gCalFromDate_tbOverTime_RequestRegister.setSelectedDate(FromDate);
}

function gCalFromDate_tbOverTime_RequestRegister_OnChange(sender, e) {
    var FromDate = gCalFromDate_tbOverTime_RequestRegister.getSelectedDate();
    gdpFromDate_tbOverTime_RequestRegister.setSelectedDate(FromDate);
}

function gCalFromDate_tbOverTime_RequestRegister_OnLoad(sender, e) {
    window.gCalFromDate_tbOverTime_RequestRegister.PopUpObject.z = 25000000;
}

function btn_gdpToDate_tbOverTime_RequestRegister_OnMouseUp(event) {
    if (gCalToDate_tbOverTime_RequestRegister.get_popUpShowing()) {
        event.cancelBubble = true;
        event.returnValue = false;
        return false;
    }
    else {
        return true;
    }
}

function btn_gdpToDate_tbOverTime_RequestRegister_OnClick(event) {
    if (gCalToDate_tbOverTime_RequestRegister.get_popUpShowing()) {
        gCalToDate_tbOverTime_RequestRegister.hide();
    }
    else {
        gCalToDate_tbOverTime_RequestRegister.setSelectedDate(gdpToDate_tbOverTime_RequestRegister.getSelectedDate());
        gCalToDate_tbOverTime_RequestRegister.show();
    }

}

function gdpToDate_tbOverTime_RequestRegister_OnDateChange(sender, e) {
    var ToDate = gdpToDate_tbOverTime_RequestRegister.getSelectedDate();
    gCalToDate_tbOverTime_RequestRegister.setSelectedDate(ToDate);
}

function gCalToDate_tbOverTime_RequestRegister_OnChange(sender, e) {
    var ToDate = gCalToDate_tbOverTime_RequestRegister.getSelectedDate();
    gdpToDate_tbOverTime_RequestRegister.setSelectedDate(ToDate);
}

function gCalToDate_tbOverTime_RequestRegister_OnLoad(sender, e) {
    window.gCalToDate_tbOverTime_RequestRegister.PopUpObject.z = 25000000;
}

function tlbItemEndorsement_TlbHourly_onClick() {
    UpdateRequest_RequestRegister();
}

function tlbItemExit_TlbHourly_onClick() {
    ShowDialogConfirm('RequestRegister');
}

function ShowDialogConfirm(caller) {
    switch (caller) {
        case 'RequestRegister':
            document.getElementById('lblConfirm').innerHTML = document.getElementById('hfCloseMessage_RequestRegister').value;
            break;
        case 'CollectiveTraffic':
            document.getElementById('lblConfirm').innerHTML = document.getElementById('hfCloseMessage_CollectiveTraffic').value;
            break;
    }
    DialogConfirm.set_value(caller);
    DialogConfirm.Show();
    CollapseControls_RequestRegister();
}

function cmbIllnesses_tbHourly_RequestRegister_onExpand(sender, e) {
    if (cmbIllnesses_tbHourly_RequestRegister.get_itemCount() == 0 && CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbIllnesses_tbHourly_RequestRegister == undefined) {
        CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbIllnesses_tbHourly_RequestRegister = true;
        CallBack_cmbIllnesses_tbHourly_RequestRegister.callback();
    }
}

function cmbIllnesses_tbHourly_RequestRegister_onCollapse(sender, e) {
    if (CurrentPageCombosCallBcakStateObj.cmbIllnesses_tbHourly_RequestRegister) {
        CurrentPageCombosCallBcakStateObj.cmbIllnesses_tbHourly_RequestRegister = false;
        cmbIllnesses_tbHourly_RequestRegister.expand();
    }
}

function CallBack_cmbIllnesses_tbHourly_RequestRegister_onBeforeCallback(sender, e) {
    cmbIllnesses_tbHourly_RequestRegister.dispose();
}

function CallBack_cmbIllnesses_tbHourly_RequestRegister_onCallbackComplete(sender, e) {
    var error = document.getElementById('ErrorHiddenField_Illnesses_tbHourly_RequestRegister').value;
    if (error == "") {
        if (CheckNavigator_onCmbCallBackCompleted())
            CurrentPageCombosCallBcakStateObj.cmbIllnesses_tbHourly_RequestRegister = true;
        else
            CurrentPageCombosCallBcakStateObj.cmbIllnesses_tbHourly_RequestRegister = false;
        document.getElementById('cmbIllnesses_tbHourly_RequestRegister_DropDown').style.display = 'none';
        cmbIllnesses_tbHourly_RequestRegister.expand();
        ChangeControlDirection_RequestRegister('cmbIllnesses_tbHourly_RequestRegister_DropDownContent');
    }
    else {
        var errorParts = eval('(' + error + ')');
        showDialog(errorParts[0], errorParts[1], errorParts[2]);
        document.getElementById('cmbIllnesses_tbHourly_RequestRegister_DropDown').style.display = 'none';
    }
}

function CallBack_cmbIllnesses_tbHourly_RequestRegister_onCallbackError(sender, e) {
    ShowConnectionError_RequestRegister();
}

function CheckNavigator_onCmbCallBackCompleted() {
    if (navigator.userAgent.indexOf('Safari') != -1 || navigator.userAgent.indexOf('Chrome') != -1)
        return true;
    return false;
}


function cmbDoctors_tbHourly_RequestRegister_onExpand(sender, e) {
    if (cmbDoctors_tbHourly_RequestRegister.get_itemCount() == 0 && CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbDoctors_tbHourly_RequestRegister == undefined) {
        CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbDoctors_tbHourly_RequestRegister = true;
        CallBack_cmbDoctors_tbHourly_RequestRegister.callback();
    }
}

function cmbDoctors_tbHourly_RequestRegister_onCollapse(sender, e) {
    if (CurrentPageCombosCallBcakStateObj.cmbDoctors_tbHourly_RequestRegister) {
        CurrentPageCombosCallBcakStateObj.cmbDoctors_tbHourly_RequestRegister = false;
        cmbDoctors_tbHourly_RequestRegister.expand();
    }
}

function CallBack_cmbDoctors_tbHourly_RequestRegister_onBeforeCallback(sender, e) {
    cmbDoctors_tbHourly_RequestRegister.dispose();
}

function CallBack_cmbDoctors_tbHourly_RequestRegister_onCallbackComplete(sender, e) {
    var error = document.getElementById('ErrorHiddenField_Doctors_tbHourly_RequestRegister').value;
    if (error == "") {
        if (CheckNavigator_onCmbCallBackCompleted())
            CurrentPageCombosCallBcakStateObj.cmbDoctors_tbHourly_RequestRegister = true;
        else
            CurrentPageCombosCallBcakStateObj.cmbDoctors_tbHourly_RequestRegister = false;
        document.getElementById('cmbDoctors_tbHourly_RequestRegister_DropDown').style.display = 'none';
        cmbDoctors_tbHourly_RequestRegister.expand();
        ChangeControlDirection_RequestRegister('cmbDoctors_tbHourly_RequestRegister_DropDownContent');
    }
    else {
        var errorParts = eval('(' + error + ')');
        showDialog(errorParts[0], errorParts[1], errorParts[2]);
        document.getElementById('cmbDoctors_tbHourly_RequestRegister_DropDown').style.display = 'none';
    }
}

function CallBack_cmbDoctors_tbHourly_RequestRegister_onCallbackError(sender, e) {
    ShowConnectionError_RequestRegister();
}

function trvMissionLocation_tbHourly_RequestRegister_onNodeSelect(sender, e) {
    cmbMissionLocation_tbHourly_RequestRegister.set_text(document.getElementById('cmbMissionLocation_tbHourly_RequestRegister_TextBox').innerHTML = e.get_node().get_text());
    cmbMissionLocation_tbHourly_RequestRegister.collapse();
}

function cmbMissionLocation_tbHourly_RequestRegister_onExpand(sender, e) {
    if (trvMissionLocation_tbHourly_RequestRegister.get_nodes().get_length() == 0 && CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbMissionLocation_tbHourly_RequestRegister == undefined) {
        CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbMissionLocation_tbHourly_RequestRegister == true;
        CallBack_cmbMissionLocation_tbHourly_RequestRegister.callback();
    }
}

function cmbMissionLocation_tbHourly_RequestRegister_onCollapse(sender, e) {
    if (CurrentPageCombosCallBcakStateObj.cmbMissionLocation_tbHourly_RequestRegister) {
        CurrentPageCombosCallBcakStateObj.cmbMissionLocation_tbHourly_RequestRegister = false;
        cmbMissionLocation_tbHourly_RequestRegister.expand();
    }
}

function CallBack_cmbMissionLocation_tbHourly_RequestRegister_onBeforeCallback(sender, e) {
    cmbMissionLocation_tbHourly_RequestRegister.dispose();
}

function CallBack_cmbMissionLocation_tbHourly_RequestRegister_onCallbackComplete(sender, e) {
    var error = document.getElementById('ErrorHiddenField_Doctors_tbHourly_RequestRegister').value;
    if (error == "") {
        document.getElementById('cmbMissionLocation_tbHourly_RequestRegister_DropDown').style.display = 'none';
        if (CheckNavigator_onCmbCallBackCompleted())
            CurrentPageCombosCallBcakStateObj.cmbMissionLocation_tbHourly_RequestRegister = true;
        else
            CurrentPageCombosCallBcakStateObj.cmbMissionLocation_tbHourly_RequestRegister = false;
        cmbMissionLocation_tbHourly_RequestRegister.expand();
        ChangeControlDirection_RequestRegister('cmbMissionLocation_tbHourly_RequestRegister_DropDownContent');
    }
    else {
        var erroParts = eval('(' + error + ')');
        showDialog(erroParts[0], erroParts[1], erroParts[2]);
        document.getElementById('cmbMissionLocation_tbHourly_RequestRegister_DropDown').style.display = 'none';
    }
}

function CallBack_cmbMissionLocation_tbHourly_RequestRegister_onCallbackError(sender, e) {
    ShowConnectionError_RequestRegister();
}

function cmbRequestType_tbHourly_RequestRegister_onChange(sender, e) {
    if (cmbRequestType_tbHourly_RequestRegister.getSelectedItem() != undefined) {
        var ObjRequestTargetFeatures = cmbRequestType_tbHourly_RequestRegister.getSelectedItem().get_value();
        ObjRequestTargetFeatures = eval('(' + ObjRequestTargetFeatures + ')');
        initTimePickers_RequestRegister('Change');
        ChangeHideElementsState_RequestRegister(ObjRequestTargetFeatures.IsSickLeave, ObjRequestTargetFeatures.IsMission, ObjRequestTargetFeatures.IsMinistryOverTime, false);
    }
}

function cmbRequestType_tbHourly_RequestRegister_onExpand(sender, e) {
    if (cmbRequestType_tbHourly_RequestRegister.get_itemCount() == 0 && CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbRequestType_tbHourly_RequestRegister == undefined) {
        CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbRequestType_tbHourly_RequestRegister = true;
        CallBack_cmbRequestType_tbHourly_RequestRegister.callback();
    }
}

function cmbRequestType_tbHourly_RequestRegister_onCollapse(sender, e) {
    if (CurrentPageCombosCallBcakStateObj.cmbRequestType_tbHourly_RequestRegister) {
        CurrentPageCombosCallBcakStateObj.cmbRequestType_tbHourly_RequestRegister = false;
        cmbRequestType_tbHourly_RequestRegister.expand();
    }
    if (cmbRequestType_tbHourly_RequestRegister.getSelectedItem() == undefined)
        document.getElementById('cmbRequestType_tbHourly_RequestRegister_TextBox').innerHTML = document.getElementById('hfcmbAlarm_RequestRegister').value;
}

function CallBack_cmbRequestType_tbHourly_RequestRegister_onBeforeCallback(sender, e) {
    cmbRequestType_tbHourly_RequestRegister.dispose();
}

function CallBack_cmbRequestType_tbHourly_RequestRegister_onCallbackComplete(sender, e) {
    var error = document.getElementById('ErrorHiddenField_RequestTypes_tbHourly_RequestRegister').value;
    if (error == "") {
        if (CheckNavigator_onCmbCallBackCompleted())
            CurrentPageCombosCallBcakStateObj.cmbRequestType_tbHourly_RequestRegister = true;
        else
            CurrentPageCombosCallBcakStateObj.cmbRequestType_tbHourly_RequestRegister = false;
        document.getElementById('cmbRequestType_tbHourly_RequestRegister_DropDown').style.display = 'none';
        cmbRequestType_tbHourly_RequestRegister.expand();
        ChangeControlDirection_RequestRegister('cmbRequestType_tbHourly_RequestRegister_DropDownContent');
    }
    else {
        var errorParts = eval('(' + error + ')');
        showDialog(errorParts[0], errorParts[1], errorParts[2]);
        document.getElementById('cmbRequestType_tbHourly_RequestRegister_DropDown').style.display = 'none';
    }
}

function tlbItemEndorsement_TlbDaily_onClick() {
    UpdateRequest_RequestRegister();
}

function tlbItemExit_TlbDaily_onClick() {
    ShowDialogConfirm('RequestRegister');
}

function cmbIllnesses_tbDaily_RequestRegister_onExpand(sender, e) {
    if (cmbIllnesses_tbDaily_RequestRegister.get_itemCount() == 0 && CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbIllnesses_tbDaily_RequestRegister == undefined) {
        CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbIllnesses_tbDaily_RequestRegister = true;
        CallBack_cmbIllnesses_tbDaily_RequestRegister.callback();
    }
}

function cmbIllnesses_tbDaily_RequestRegister_onCollapse(sender, e) {
    if (CurrentPageCombosCallBcakStateObj.cmbIllnesses_tbDaily_RequestRegister) {
        CurrentPageCombosCallBcakStateObj.cmbIllnesses_tbDaily_RequestRegister = false;
        cmbIllnesses_tbDaily_RequestRegister.expand();
    }
}

function CallBack_cmbIllnesses_tbDaily_RequestRegister_onBeforeCallback(sender, e) {
    cmbIllnesses_tbDaily_RequestRegister.dispose();
}

function CallBack_cmbIllnesses_tbDaily_RequestRegister_onCallbackComplete(sender, e) {
    var error = document.getElementById('ErrorHiddenField_Illnesses_tbDaily_RequestRegister').value;
    if (error == "") {
        if (CheckNavigator_onCmbCallBackCompleted())
            CurrentPageCombosCallBcakStateObj.cmbIllnesses_tbDaily_RequestRegister = true;
        else
            CurrentPageCombosCallBcakStateObj.cmbIllnesses_tbDaily_RequestRegister = false;
        document.getElementById('cmbIllnesses_tbDaily_RequestRegister_DropDown').style.display = 'none';
        cmbIllnesses_tbDaily_RequestRegister.expand();
        ChangeControlDirection_RequestRegister('cmbIllnesses_tbDaily_RequestRegister_DropDownContent');
    }
    else {
        var errorParts = eval('(' + error + ')');
        showDialog(errorParts[0], errorParts[1], errorParts[2]);
        document.getElementById('cmbIllnesses_tbDaily_RequestRegister_DropDown').style.display = 'none';
    }
}

function CallBack_cmbIllnesses_tbDaily_RequestRegister_onCallbackError(sender, e) {
    ShowConnectionError_RequestRegister();
}

function cmbDoctors_tbDaily_RequestRegister_onExpand(sender, e) {
    if (cmbDoctors_tbDaily_RequestRegister.get_itemCount() == 0 && CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbDoctors_tbDaily_RequestRegister == undefined) {
        CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbDoctors_tbDaily_RequestRegister = true;
        CallBack_cmbDoctors_tbDaily_RequestRegister.callback();
    }
}

function cmbDoctors_tbDaily_RequestRegister_onCollapse(sender, e) {
    if (CurrentPageCombosCallBcakStateObj.cmbDoctors_tbDaily_RequestRegister) {
        CurrentPageCombosCallBcakStateObj.cmbDoctors_tbDaily_RequestRegister = false;
        cmbDoctors_tbDaily_RequestRegister.expand();
    }
}

function CallBack_cmbDoctors_tbDaily_RequestRegister_onBeforeCallback(sender, e) {
    cmbDoctors_tbDaily_RequestRegister.dispose();
}

function CallBack_cmbDoctors_tbDaily_RequestRegister_onCallbackComplete(sender, e) {
    var error = document.getElementById('ErrorHiddenField_Doctors_tbDaily_RequestRegister').value;
    if (error == "") {
        if (CheckNavigator_onCmbCallBackCompleted())
            CurrentPageCombosCallBcakStateObj.cmbDoctors_tbDaily_RequestRegister = true;
        else
            CurrentPageCombosCallBcakStateObj.cmbDoctors_tbDaily_RequestRegister = false;
        document.getElementById('cmbDoctors_tbDaily_RequestRegister_DropDown').style.display = 'none';
        cmbDoctors_tbDaily_RequestRegister.expand();
        ChangeControlDirection_RequestRegister('cmbDoctors_tbDaily_RequestRegister_DropDownContent');
    }
    else {
        var errorParts = eval('(' + error + ')');
        showDialog(errorParts[0], errorParts[1], errorParts[2]);
        document.getElementById('cmbDoctors_tbDaily_RequestRegister_DropDown').style.display = 'none';
    }
}

function CallBack_cmbDoctors_tbDaily_RequestRegister_onCallbackError(sender, e) {
    ShowConnectionError_RequestRegister();
}

function trvMissionLocation_tbDaily_RequestRegister_onNodeSelect(sender, e) {
    cmbMissionLocation_tbDaily_RequestRegister.set_text(document.getElementById('cmbMissionLocation_tbDaily_RequestRegister_TextBox').innerHTML = e.get_node().get_text());
    cmbMissionLocation_tbDaily_RequestRegister.collapse();
}

function cmbMissionLocation_tbDaily_RequestRegister_onExpand(sender, e) {
    if (trvMissionLocation_tbDaily_RequestRegister.get_nodes().get_length() == 0 && CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbMissionLocation_tbDaily_RequestRegister == undefined) {
        CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbMissionLocation_tbDaily_RequestRegister == true;
        CallBack_cmbMissionLocation_tbDaily_RequestRegister.callback();
    }
}

function cmbMissionLocation_tbDaily_RequestRegister_onCollapse(sender, e) {
    if (CurrentPageCombosCallBcakStateObj.cmbMissionLocation_tbDaily_RequestRegister) {
        CurrentPageCombosCallBcakStateObj.cmbMissionLocation_tbDaily_RequestRegister = false;
        cmbMissionLocation_tbDaily_RequestRegister.expand();
    }
}

function CallBack_cmbMissionLocation_tbDaily_RequestRegister_onBeforeCallback(sender, e) {
    cmbMissionLocation_tbDaily_RequestRegister.dispose();
}

function CallBack_cmbMissionLocation_tbDaily_RequestRegister_onCallbackComplete(sender, e) {
    var error = document.getElementById('ErrorHiddenField_MissionLocations_tbDaily_RequestRegister').value;
    if (error == "") {
        document.getElementById('cmbMissionLocation_tbDaily_RequestRegister_DropDown').style.display = 'none';
        if (CheckNavigator_onCmbCallBackCompleted())
            CurrentPageCombosCallBcakStateObj.cmbMissionLocation_tbDaily_RequestRegister = true;
        else
            CurrentPageCombosCallBcakStateObj.cmbMissionLocation_tbDaily_RequestRegister = false;
        cmbMissionLocation_tbDaily_RequestRegister.expand();
        ChangeControlDirection_RequestRegister('cmbMissionLocation_tbDaily_RequestRegister_DropDownContent');
    }
    else {
        var erroParts = eval('(' + error + ')');
        showDialog(erroParts[0], erroParts[1], erroParts[2]);
        document.getElementById('cmbMissionLocation_tbDaily_RequestRegister_DropDown').style.display = 'none';
    }
}

function CallBack_cmbMissionLocation_tbDaily_RequestRegister_onCallbackError(sender, e) {
    ShowConnectionError_RequestRegister();
}

function cmbRequestType_tbDaily_RequestRegister_onChange(sender, e) {
    if (cmbRequestType_tbDaily_RequestRegister.getSelectedItem() != undefined) {
        var ObjRequestTargetFeatures = cmbRequestType_tbDaily_RequestRegister.getSelectedItem().get_value();
        ObjRequestTargetFeatures = eval('(' + ObjRequestTargetFeatures + ')');
        ChangeHideElementsState_RequestRegister(ObjRequestTargetFeatures.IsSickLeave, ObjRequestTargetFeatures.IsMission, ObjRequestTargetFeatures.IsMinistryOverTime, false);
    }
}

function cmbRequestType_tbDaily_RequestRegister_onExpand(sender, e) {
    if (cmbRequestType_tbDaily_RequestRegister.get_itemCount() == 0 && CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbRequestType_tbDaily_RequestRegister == undefined) {
        CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbRequestType_tbDaily_RequestRegister = true;
        CallBack_cmbRequestType_tbDaily_RequestRegister.callback();
    }
}

function cmbRequestType_tbDaily_RequestRegister_onCollapse(sender, e) {
    if (CurrentPageCombosCallBcakStateObj.cmbRequestType_tbDaily_RequestRegister) {
        CurrentPageCombosCallBcakStateObj.cmbRequestType_tbDaily_RequestRegister = false;
        cmbRequestType_tbDaily_RequestRegister.expand();
    }
    if (cmbRequestType_tbDaily_RequestRegister.getSelectedItem() == undefined)
        document.getElementById('cmbRequestType_tbDaily_RequestRegister_TextBox').innerHTML = document.getElementById('hfcmbAlarm_RequestRegister').value;
}

function CallBack_cmbRequestType_tbDaily_RequestRegister_onBeforeCallback(sender, e) {
    cmbRequestType_tbDaily_RequestRegister.dispose();
}

function CallBack_cmbRequestType_tbDaily_RequestRegister_onCallbackComplete(sender, e) {
    var error = document.getElementById('ErrorHiddenField_RequestTypes_tbDaily_RequestRegister').value;
    if (error == "") {
        if (CheckNavigator_onCmbCallBackCompleted())
            CurrentPageCombosCallBcakStateObj.cmbRequestType_tbDaily_RequestRegister = true;
        else
            CurrentPageCombosCallBcakStateObj.cmbRequestType_tbDaily_RequestRegister = false;
        document.getElementById('cmbRequestType_tbDaily_RequestRegister_DropDown').style.display = 'none';
        cmbRequestType_tbDaily_RequestRegister.expand();
        ChangeControlDirection_RequestRegister('cmbRequestType_tbDaily_RequestRegister_DropDownContent');
    }
    else {
        var errorParts = eval('(' + error + ')');
        showDialog(errorParts[0], errorParts[1], errorParts[2]);
        document.getElementById('cmbRequestType_tbDaily_RequestRegister_DropDown').style.display = 'none';
    }
}

function CallBack_cmbRequestType_tbDaily_RequestRegister_onCallbackError(sender, e) {
    ShowConnectionError_RequestRegister();
}

function tlbItemEndorsement_TlbOverTime_onClick() {
    UpdateRequest_RequestRegister();
}

function tlbItemExit_TlbOverTime_onClick() {
    ShowDialogConfirm('RequestRegister');
}

function cmbRequestType_tbOverTime_RequestRegister_onExpand(sender, e) {
    if (cmbRequestType_tbOverTime_RequestRegister.get_itemCount() == 0 && CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbRequestType_tbOverTime_RequestRegister == undefined) {
        CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbRequestType_tbOverTime_RequestRegister = true;
        CallBack_cmbRequestType_tbOverTime_RequestRegister.callback();
    }
}

function cmbRequestType_tbOverTime_RequestRegister_onCollapse(sender, e) {
    if (CurrentPageCombosCallBcakStateObj.cmbRequestType_tbOverTime_RequestRegister) {
        CurrentPageCombosCallBcakStateObj.cmbRequestType_tbOverTime_RequestRegister = false;
        cmbRequestType_tbOverTime_RequestRegister.expand();
    }
    if (cmbRequestType_tbOverTime_RequestRegister.getSelectedItem() == undefined)
        document.getElementById('cmbRequestType_tbOverTime_RequestRegister_TextBox').innerHTML = document.getElementById('hfcmbAlarm_RequestRegister').value;
}

function cmbRequestType_tbOverTime_RequestRegister_onBeforeCallback(sender, e) {
    cmbRequestType_tbOverTime_RequestRegister.dispose();
}

function cmbRequestType_tbOverTime_RequestRegister_onCallbackComplete(sender, e) {
    var error = document.getElementById('ErrorHiddenField_RequestTypes_tbOverTime_RequestRegister').value;
    if (error == "") {
        if (CheckNavigator_onCmbCallBackCompleted())
            CurrentPageCombosCallBcakStateObj.cmbRequestType_tbOverTime_RequestRegister = true;
        else
            CurrentPageCombosCallBcakStateObj.cmbRequestType_tbOverTime_RequestRegister = false;
        document.getElementById('cmbRequestType_tbOverTime_RequestRegister_DropDown').style.display = 'none';
        cmbRequestType_tbOverTime_RequestRegister.expand();
        ChangeControlDirection_RequestRegister('cmbRequestType_tbOverTime_RequestRegister_DropDownContent');
    }
    else {
        var errorParts = eval('(' + error + ')');
        showDialog(errorParts[0], errorParts[1], errorParts[2]);
        document.getElementById('cmbRequestType_tbOverTime_RequestRegister_DropDown').style.display = 'none';
    }
}

function cmbRequestType_tbOverTime_RequestRegister_onCallbackError(sender, e) {
    ShowConnectionError_RequestRegister();
}

function tlbItemOk_TlbOkConfirm_onClick() {
    var ConfirmCaller = DialogConfirm.get_value();
    switch (ConfirmCaller) {
        case 'RequestRegister':
            RequestRegister_onClose();
            break;
        case 'CollectiveTraffic':
            CollectiveTraffic_onClose();
            break;
    }
    DialogConfirm.Close();
}

function RequestRegister_onClose() {
    if (ObjRequestRegister != null) {
        parent.parent.document.getElementById('DialogRegisteredRequests_IFrame').contentWindow.RequestRegister_onAfterUpdate(parseInt(ObjRequestRegister.PageCount) - 1);
        parent.document.getElementById('DialogRequestRegister_IFrame').src = 'WhitePage.aspx';
        parent.DialogRequestRegister.Close();
    }
}

function tlbItemCancel_TlbCancelConfirm_onClick() {
    DialogConfirm.Close();
}

function ShowConnectionError_RequestRegister() {
    var error = document.getElementById('hfErrorType_RequestRegister').value;
    var errorBody = document.getElementById('hfConnectionError_RequestRegister').value;
    showDialog(error, errorBody, 'error');
}

function UpdateRequest_RequestRegister() {
    var ObjRequestTarget_RequestTarget = new Object();
    ObjRequestTarget_RequestTarget.RequestCaller = '';
    ObjRequestTarget_RequestTarget.RequestPersonnelCountState = RequestPersonnelCountState_RequestRegister;
    ObjRequestTarget_RequestTarget.SinglePersonnelID = '0';
    ObjRequestTarget_RequestTarget.CollectiveConditionsLoadState = 'Normal';
    ObjRequestTarget_RequestTarget.CollectiveConditions = null;
    ObjRequestTarget_RequestTarget.StrUnCollectivePersonnelList = null;
    ObjRequestTarget_RequestTarget.RequestTarget = GetCurrentRequestTarget_RequestRegister();
    ObjRequestTarget_RequestTarget.Year = null;
    ObjRequestTarget_RequestTarget.Month = null;
    ObjRequestTarget_RequestTarget.PageSize = '0';
    ObjRequestTarget_RequestTarget.ID = '0';
    ObjRequestTarget_RequestTarget.PreCardID = '0';
    ObjRequestTarget_RequestTarget.PreCardTitle = null;
    ObjRequestTarget_RequestTarget.RequestDate = null;
    ObjRequestTarget_RequestTarget.FromDate = null;
    ObjRequestTarget_RequestTarget.ToDate = null;
    ObjRequestTarget_RequestTarget.FromTime = null;
    ObjRequestTarget_RequestTarget.ToTime = null;
    ObjRequestTarget_RequestTarget.Duration = '00:00';
    ObjRequestTarget_RequestTarget.Description = null;
    ObjRequestTarget_RequestTarget.IsSeakLeave = false;
    ObjRequestTarget_RequestTarget.IllnessID = '0';
    ObjRequestTarget_RequestTarget.DoctorID = '0';
    ObjRequestTarget_RequestTarget.IsMission = false;
    ObjRequestTarget_RequestTarget.MissionLocationID = '0';
    ObjRequestTarget_RequestTarget.IsMinistryOverTime = false;

    var ObjRequestRegister = parent.DialogRequestRegister.get_value();
    ObjRequestTarget_RequestTarget.RequestCaller = ObjRequestRegister.Caller;
    switch (ObjRequestTarget_RequestTarget.RequestCaller) {
        case 'NormalUser':
            break;
        case 'Operator':
            switch (ObjRequestTarget_RequestTarget.RequestPersonnelCountState) {
                case 'Single':
                    if (cmbPersonnel_RequestRegister.getSelectedItem() != undefined) {
                        var ObjPersonnel = cmbPersonnel_RequestRegister.getSelectedItem().get_value();
                        ObjPersonnel = eval('(' + ObjPersonnel + ')');
                        ObjRequestTarget_RequestTarget.SinglePersonnelID = ObjPersonnel.ID;
                    }
                    break;
                case 'Collective':
                    ObjRequestTarget_RequestTarget.CollectiveConditionsLoadState = LoadState_cmbPersonnel_RequestRegister;
                    ObjRequestTarget_RequestTarget.CollectiveConditions = CollectiveConditions;
                    ObjRequestTarget_RequestTarget.StrUnCollectivePersonnelList = StrUnCollectivePersonnelList_CollectiveTraffic;
                    break;
            }
            break;
    }
    ObjRequestTarget_RequestTarget.Year = ObjRequestRegister.Year;
    ObjRequestTarget_RequestTarget.Month = ObjRequestRegister.Month;
    ObjRequestTarget_RequestTarget.PageSize = ObjRequestRegister.PageSize;
    switch (ObjRequestTarget_RequestTarget.RequestTarget) {
        case 'Hourly':
            if (cmbRequestType_tbHourly_RequestRegister.getSelectedItem() != undefined) {
                ObjRequestTarget_RequestTarget.PreCardID = cmbRequestType_tbHourly_RequestRegister.getSelectedItem().get_id();
                ObjRequestTarget_RequestTarget.PreCardTitle = cmbRequestType_tbHourly_RequestRegister.getSelectedItem().get_text();
            }
            switch (parent.parent.SysLangID) {
                case 'fa-IR':
                    ObjRequestTarget_RequestTarget.RequestDate = document.getElementById('pdpRequestDate_tbHourly_RequestRegister').value;
                    break;
                case 'en-Us':
                    ObjRequestTarget_RequestTarget.RequestDate = document.getElementById('gdpRequestDate_tbHourly_RequestRegister_picker').value;
                    break;
            }
            ObjRequestTarget_RequestTarget.FromTime = GetDuration_TimePicker_RequestRegister('TimeSelector_FromHour_tbHourly_RequestRegister');
            ObjRequestTarget_RequestTarget.ToTime = GetDuration_TimePicker_RequestRegister('TimeSelector_ToHour_tbHourly_RequestRegister');
            ObjRequestTarget_RequestTarget.Description = document.getElementById('txtDescription_tbHourly_RequestRegister').value;
            var ObjRequestTargetFeatures = GetRequestTargetFeatures_RequestRegister();
            if (ObjRequestTargetFeatures != null) {
                if (ObjRequestTargetFeatures.IsSickLeave) {
                    ObjRequestTarget_RequestTarget.IsSeakLeave = true;
                    if (cmbIllnesses_tbHourly_RequestRegister.getSelectedItem() != undefined)
                        ObjRequestTarget_RequestTarget.IllnessID = cmbIllnesses_tbHourly_RequestRegister.getSelectedItem().get_value();
                    if (cmbDoctors_tbHourly_RequestRegister.getSelectedItem() != undefined)
                        ObjRequestTarget_RequestTarget.DoctorID = cmbDoctors_tbHourly_RequestRegister.getSelectedItem().get_value();
                }
                if (ObjRequestTargetFeatures.IsMission) {
                    ObjRequestTarget_RequestTarget.IsMission = true;
                    if (trvMissionLocation_tbHourly_RequestRegister.get_selectedNode() != undefined) {
                        if (trvMissionLocation_tbHourly_RequestRegister.get_selectedNode().get_parentNode() != undefined)
                            ObjRequestTarget_RequestTarget.MissionLocationID = trvMissionLocation_tbHourly_RequestRegister.get_selectedNode().get_id();
                    }
                }
            }
            break;
        case 'Daily':
            if (cmbRequestType_tbDaily_RequestRegister.getSelectedItem() != undefined) {
                ObjRequestTarget_RequestTarget.PreCardID = cmbRequestType_tbDaily_RequestRegister.getSelectedItem().get_id();
                ObjRequestTarget_RequestTarget.PreCardTitle = cmbRequestType_tbDaily_RequestRegister.getSelectedItem().get_text();
            }
            switch (parent.parent.SysLangID) {
                case 'fa-IR':
                    ObjRequestTarget_RequestTarget.FromDate = document.getElementById('pdpFromDate_tbDaily_RequestRegister').value;
                    ObjRequestTarget_RequestTarget.ToDate = document.getElementById('pdpToDate_tbDaily_RequestRegister').value;
                    break;
                case 'en-Us':
                    ObjRequestTarget_RequestTarget.FromDate = document.getElementById('gdpFromDate_tbDaily_RequestRegister_picker').value;
                    ObjRequestTarget_RequestTarget.ToDate = document.getElementById('gdpToDate_tbDaily_RequestRegister_picker').value;
                    break;
            }
            ObjRequestTarget_RequestTarget.Description = document.getElementById('txtDescription_tbDaily_RequestRegister').value;
            var ObjRequestTargetFeatures = GetRequestTargetFeatures_RequestRegister();
            if (ObjRequestTargetFeatures != null) {
                if (ObjRequestTargetFeatures.IsSickLeave) {
                    ObjRequestTarget_RequestTarget.IsSeakLeave = true;
                    if (cmbIllnesses_tbDaily_RequestRegister.getSelectedItem() != undefined)
                        ObjRequestTarget_RequestTarget.IllnessID = cmbIllnesses_tbDaily_RequestRegister.getSelectedItem().get_value();
                    if (cmbDoctors_tbDaily_RequestRegister.getSelectedItem() != undefined)
                        ObjRequestTarget_RequestTarget.DoctorID = cmbDoctors_tbDaily_RequestRegister.getSelectedItem().get_value();
                }
                if (ObjRequestTargetFeatures.IsMission) {
                    ObjRequestTarget_RequestTarget.IsMission = true;
                    if (trvMissionLocation_tbDaily_RequestRegister.get_selectedNode() != undefined) {
                        if (trvMissionLocation_tbDaily_RequestRegister.get_selectedNode().get_parentNode() != undefined)
                            ObjRequestTarget_RequestTarget.MissionLocationID = trvMissionLocation_tbDaily_RequestRegister.get_selectedNode().get_id();
                    }
                }
            }
            break;
        case 'OverTime':
            if (cmbRequestType_tbOverTime_RequestRegister.getSelectedItem() != undefined) {
                ObjRequestTarget_RequestTarget.PreCardID = cmbRequestType_tbOverTime_RequestRegister.getSelectedItem().get_id();
                ObjRequestTarget_RequestTarget.PreCardTitle = cmbRequestType_tbOverTime_RequestRegister.getSelectedItem().get_text();
            }
            ObjRequestTarget_RequestTarget.Description = document.getElementById('txtDescription_tbOverTime_RequestRegister').value;
            var ObjRequestTargetFeatures = GetRequestTargetFeatures_RequestRegister();
            if (ObjRequestTargetFeatures != null) {
                if (ObjRequestTargetFeatures.IsMinistryOverTime) {
                    ObjRequestTarget_RequestTarget.IsMinistryOverTime = true;
                    switch (parent.parent.SysLangID) {
                        case 'fa-IR':
                            ObjRequestTarget_RequestTarget.FromDate = document.getElementById('pdpFromDate_tbOverTime_RequestRegister').value;
                            break;
                        case 'en-Us':
                            ObjRequestTarget_RequestTarget.FromDate = document.getElementById('gdpFromDate_tbOverTime_RequestRegister_picker').value;
                            break;
                    }
                    ObjRequestTarget_RequestTarget.Duration = GetDuration_TimePicker_RequestRegister('TimeSelector_MinistryDuration_tbOverTime_RequestRegister');
                }
                else {
                    switch (parent.parent.SysLangID) {
                        case 'fa-IR':
                            ObjRequestTarget_RequestTarget.FromDate = document.getElementById('pdpFromDate_tbOverTime_RequestRegister').value;
                            ObjRequestTarget_RequestTarget.ToDate = document.getElementById('pdpToDate_tbOverTime_RequestRegister').value;
                            break;
                        case 'en-Us':
                            ObjRequestTarget_RequestTarget.FromDate = document.getElementById('gdpFromDate_tbOverTime_RequestRegister_picker').value;
                            ObjRequestTarget_RequestTarget.ToDate = document.getElementById('gdpToDate_tbOverTime_RequestRegister_picker').value;
                            break;
                    }
                    ObjRequestTarget_RequestTarget.FromTime = GetDuration_TimePicker_RequestRegister('TimeSelector_FromHour_tbOverTime_RequestRegister');
                    ObjRequestTarget_RequestTarget.ToTime = GetDuration_TimePicker_RequestRegister('TimeSelector_ToHour_tbOverTime_RequestRegister');
                    ObjRequestTarget_RequestTarget.Duration = GetDuration_TimePicker_RequestRegister('TimeSelector_Duration_tbOverTime_RequestRegister');
                }
            }
            break;
    }
    UpdateRequest_RequestRegisterPage(CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.RequestCaller), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.RequestPersonnelCountState), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.SinglePersonnelID), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.CollectiveConditionsLoadState), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.CollectiveConditions), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.StrUnCollectivePersonnelList), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.RequestTarget), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.Year), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.Month), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.PageSize), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.ID), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.PreCardID), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.RequestDate), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.FromDate), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.ToDate), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.FromTime), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.ToTime), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.Duration), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.Description), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.IsSeakLeave.toString()), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.IllnessID), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.DoctorID), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.IsMission.toString()), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.MissionLocationID), CharToKeyCode_RequestRegister(ObjRequestTarget_RequestTarget.IsMinistryOverTime.toString()));
}

function UpdateRequest_RequestRegisterPage_onCallBack(Response) {
    var RetMessage = Response;
    if (RetMessage != null && RetMessage.length > 0) {
        if (Response[1] == "ConnectionError") {
            Response[0] = document.getElementById('hfErrorType_RequestRegister').value;
            Response[1] = document.getElementById('hfConnectionError_RequestRegister').value;
        }
        showDialog(RetMessage[0], Response[1], RetMessage[2], false, document.getElementById('Mastertbl_RequestRegister').offsetWidth);
        if (RetMessage[2] == 'success') {
            if (ObjRequestRegister != null)
                ObjRequestRegister.PageCount = Response[3];
            ClearList_RequestRegister();
        }
    }
}

function GetDialogRequestRegisterObjVal_RequestRegister() {
    ObjRequestRegister = parent.DialogRequestRegister.get_value();
}

function CustomizeRequestRegister_RequestRegister() {
    if (ObjRequestRegister != null)
        switch (ObjRequestRegister.Caller) {
        case 'NormalUser':
            document.getElementById("Container_PersonnelSearch_RequestRegister").removeChild(document.getElementById("PersonnelSearchBox_RequestRegister"));
            break;
        case 'Operator':
            break;
    }     
}

function ClearList_RequestRegister() {
    document.getElementById('cmbRequestType_tbHourly_RequestRegister_Input').value = '';
    cmbRequestType_tbHourly_RequestRegister.unSelect();
    Clear_cmbIllnesses_tbHourly_RequestRegister();
    Clear_cmbDoctors_tbHourly_RequestRegister();
    Clear_cmbMissionLocation_tbHourly_RequestRegister();
    document.getElementById('txtDescription_tbHourly_RequestRegister').value = '';
    document.getElementById('cmbRequestType_tbDaily_RequestRegister_Input').value = '';
    cmbRequestType_tbDaily_RequestRegister.unSelect();
    Clear_cmbIllnesses_tbDaily_RequestRegister();
    Clear_cmbDoctors_tbDaily_RequestRegister();
    Clear_cmbMissionLocation_tbDaily_RequestRegister();
    document.getElementById('txtDescription_tbDaily_RequestRegister').value = '';
    document.getElementById('cmbRequestType_tbOverTime_RequestRegister').value = '';
    cmbRequestType_tbOverTime_RequestRegister.unSelect();
    document.getElementById('txtDescription_tbOverTime_RequestRegister').value = '';
    ResetTimepickers_RequestRegister();
    ResetCalendars_RequestRegister();
}

function CharToKeyCode_RequestRegister(str) {
    var OutStr = '';
    if (str != null && str != undefined) {
        for (var i = 0; i < str.length; i++) {
            var KeyCode = str.charCodeAt(i);
            var CharKeyCode = '//' + KeyCode;
            OutStr += CharKeyCode;
        }
    }
    return OutStr;
}

function GetDuration_TimePicker_RequestRegister(TimePicker) {
    if (cmbRequestType_tbHourly_RequestRegister.getSelectedItem() != undefined) {
        var ObjRequestTargetFeatures = cmbRequestType_tbHourly_RequestRegister.getSelectedItem().get_value();
        ObjRequestTargetFeatures = eval('(' + ObjRequestTargetFeatures + ')');
        if (ObjRequestTargetFeatures.IsTraffic && document.getElementById(TimePicker + '_txtHour').value == NullTime_RequestRegister)
            return;
    }    
    var hour = document.getElementById(TimePicker + '_txtHour').value;
    var minute = document.getElementById(TimePicker + '_txtMinute').value;
    if (hour == '' || parseFloat(hour) < 0)
        document.getElementById(TimePicker + '_txtHour').value = hour = '00';
    if (minute == '' || parseFloat(minute) < 0)
        document.getElementById(TimePicker + '_txtMinute').value = minute = '00';
    if (document.getElementById(TimePicker + '_txtHour').value.length < 2)
        document.getElementById(TimePicker + '_txtHour').value = '0' + document.getElementById(TimePicker + '_txtHour').value;
    if (document.getElementById(TimePicker + '_txtMinute').value.length < 2)
        document.getElementById(TimePicker + '_txtMinute').value = '0' + document.getElementById(TimePicker + '_txtMinute').value;
    return document.getElementById(TimePicker + '_txtHour').value + ':' + document.getElementById(TimePicker + '_txtMinute').value;
}

function ResetCalendars_RequestRegister() {
    var currentDate_RequestRegister = document.getElementById('hfCurrentDate_RequestRegister').value;
    switch (parent.parent.SysLangID) {
        case 'en-US':
            currentDate_RequestRegister = new Date(currentDate_RequestRegister);
            gdpRequestDate_tbHourly_RequestRegister.setSelectedDate(currentDate_RequestRegister);
            gCalRequestDate_tbHourly_RequestRegister.setSelectedDate(currentDate_RequestRegister);
            gdpFromDate_tbDaily_RequestRegister.setSelectedDate(currentDate_RequestRegister);
            gCalFromDate_tbDaily_RequestRegister.setSelectedDate(currentDate_RequestRegister);
            gdpToDate_tbDaily_RequestRegister.setSelectedDate(currentDate_RequestRegister);
            gCalToDate_tbDaily_RequestRegister.setSelectedDate(currentDate_RequestRegister);
            gdpFromDate_tbOverTime_RequestRegister.setSelectedDate(currentDate_RequestRegister);
            gCalFromDate_tbOverTime_RequestRegister.setSelectedDate(currentDate_RequestRegister);
            gdpToDate_tbOverTime_RequestRegister.setSelectedDate(currentDate_RequestRegister);
            gCalToDate_tbOverTime_RequestRegister.setSelectedDate(currentDate_RequestRegister);
            break;
        case 'fa-IR':
            document.getElementById('pdpRequestDate_tbHourly_RequestRegister').value = currentDate_RequestRegister;
            document.getElementById('pdpFromDate_tbDaily_RequestRegister').value = currentDate_RequestRegister;
            document.getElementById('pdpToDate_tbDaily_RequestRegister').value = currentDate_RequestRegister;
            document.getElementById('pdpFromDate_tbOverTime_RequestRegister').value = currentDate_RequestRegister;
            document.getElementById('pdpToDate_tbOverTime_RequestRegister').value = currentDate_RequestRegister;
            break;
    }
}

function ResetTimepickers_RequestRegister(pageState) {
    ResetTimepicker_RequestRegister(pageState, 'TimeSelector_FromHour_tbHourly_RequestRegister');
    ResetTimepicker_RequestRegister(pageState, 'TimeSelector_ToHour_tbHourly_RequestRegister');
    ResetTimepicker_RequestRegister(pageState, 'TimeSelector_FromHour_tbOverTime_RequestRegister');
    ResetTimepicker_RequestRegister(pageState, 'TimeSelector_ToHour_tbOverTime_RequestRegister');
    ResetTimepicker_RequestRegister(pageState, 'TimeSelector_Duration_tbOverTime_RequestRegister');
}

function ResetTimepicker_RequestRegister(pageState, TimePicker) {
    var strTime = zeroTime;
    switch (pageState) {
        case 'Load':
            break;
        case 'Change':
            if (cmbRequestType_tbHourly_RequestRegister.getSelectedItem() != undefined) {
                var ObjRequestTargetFeatures = cmbRequestType_tbHourly_RequestRegister.getSelectedItem().get_value();
                ObjRequestTargetFeatures = eval('(' + ObjRequestTargetFeatures + ')');
                if (ObjRequestTargetFeatures.IsTraffic)
                    strTime = NullTime_RequestRegister;
            }
            break;
    }
    document.getElementById(TimePicker + "_txtHour").value = strTime;
    document.getElementById(TimePicker + "_txtMinute").value = zeroTime;
    document.getElementById(TimePicker + "_txtSecond").value = zeroTime;
}

function GetCurrentRequestTarget_RequestRegister() {
    return TabStripRequestRegister.getSelectedTab().get_value();
}

function GetVisibilityProps_RequestRegister(state) {
    var visibility = null;
    if (state)
        visibility = 'visible';
    else
        visibility = 'hidden';
    return visibility;
}

function ChangeHideElementsState_RequestRegister(isSickLeave, isMission, isMinistryOverTime, isSwitchAll) {
    var RequestTarget = !isSwitchAll ? GetCurrentRequestTarget_RequestRegister() : 'SwitchAll';
    var IsSickLeave = GetVisibilityProps_RequestRegister(isSickLeave);
    var IsMission = GetVisibilityProps_RequestRegister(isMission);
    switch (RequestTarget) {
        case 'Hourly':
            document.getElementById('lblIllnesses_tbHourly_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('Container_cmbIllnesses_tbHourly_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('lblDoctors_tbHourly_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('Container_cmbDoctors_tbHourly_RequestRegister').style.visibility = IsSickLeave;
            if (!isSickLeave) {
                Clear_cmbIllnesses_tbHourly_RequestRegister();
                Clear_cmbDoctors_tbHourly_RequestRegister();
            }
            document.getElementById('lblMissionLocation_tbHourly_RequestRegister').style.visibility = IsMission;
            document.getElementById('Container_cmbMissionLocation_tbHourly_RequestRegister').style.visibility = IsMission;
            if (!isMission)
                Clear_cmbMissionLocation_tbHourly_RequestRegister();
            break;
        case 'Daily':
            document.getElementById('lblIllnesses_tbDaily_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('Container_cmbIllnesses_tbDaily_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('lblDoctors_tbDaily_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('Container_cmbDoctors_tbDaily_RequestRegister').style.visibility = IsSickLeave;
            if (!isSickLeave) {
                Clear_cmbIllnesses_tbDaily_RequestRegister();
                Clear_cmbDoctors_tbDaily_RequestRegister();
            }
            document.getElementById('lblMissionLocation_tbDaily_RequestRegister').style.visibility = IsMission;
            document.getElementById('Container_cmbMissionLocation_tbDaily_RequestRegister').style.visibility = IsMission;
            if (!isMission)
                Clear_cmbMissionLocation_tbDaily_RequestRegister();
            break;
        case 'OverTime':
            document.getElementById('Container_MinistryTimeParts_tbOverTime_RequestRegister').style.visibility = GetVisibilityProps_RequestRegister(isMinistryOverTime);
            document.getElementById('Container_NormalTimeParts_tbOverTime_RequestRegister').style.visibility = GetVisibilityProps_RequestRegister(!isMinistryOverTime);
            document.getElementById('Container_ToDateCalendars_tbOverTime_RequestRegister').style.visibility = GetVisibilityProps_RequestRegister(!isMinistryOverTime);
            if (isMinistryOverTime)
                document.getElementById('lblFromDate_tbOverTime_RequestRegister').innerHTML = document.getElementById('hfDate_tbOverTime_RequestRegister').value;
            else
                document.getElementById('lblFromDate_tbOverTime_RequestRegister').innerHTML = document.getElementById('hfFromDate_tbOverTime_RequestRegister').value;
            break;
        case 'SwitchAll':
            document.getElementById('lblIllnesses_tbHourly_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('Container_cmbIllnesses_tbHourly_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('lblDoctors_tbHourly_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('Container_cmbDoctors_tbHourly_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('lblMissionLocation_tbHourly_RequestRegister').style.visibility = IsMission;
            document.getElementById('Container_cmbMissionLocation_tbHourly_RequestRegister').style.visibility = IsMission;
            document.getElementById('lblIllnesses_tbDaily_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('Container_cmbIllnesses_tbDaily_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('lblDoctors_tbDaily_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('Container_cmbDoctors_tbDaily_RequestRegister').style.visibility = IsSickLeave;
            document.getElementById('lblMissionLocation_tbDaily_RequestRegister').style.visibility = IsMission;
            document.getElementById('Container_cmbMissionLocation_tbDaily_RequestRegister').style.visibility = IsMission;
            break;
    }
    if (!isSwitchAll) {
        cmbMissionLocation_tbHourly_RequestRegister.collapse();
        cmbMissionLocation_tbDaily_RequestRegister.collapse();
    }
}

function Clear_cmbIllnesses_tbHourly_RequestRegister() {
    if (cmbIllnesses_tbHourly_RequestRegister.get_itemCount() > 0)
        cmbIllnesses_tbHourly_RequestRegister.selectItemByIndex(0);
}

function Clear_cmbDoctors_tbHourly_RequestRegister() {
    if (cmbDoctors_tbHourly_RequestRegister.get_itemCount() > 0)
        cmbDoctors_tbHourly_RequestRegister.selectItemByIndex(0);
}

function Clear_cmbIllnesses_tbDaily_RequestRegister() {
    if (cmbIllnesses_tbDaily_RequestRegister.get_itemCount() > 0)
        cmbIllnesses_tbDaily_RequestRegister.selectItemByIndex(0);
}

function Clear_cmbDoctors_tbDaily_RequestRegister() {
    if (cmbDoctors_tbDaily_RequestRegister.get_itemCount() > 0)
        cmbDoctors_tbDaily_RequestRegister.selectItemByIndex(0);
}

function Clear_cmbMissionLocation_tbHourly_RequestRegister() {
    if (trvMissionLocation_tbHourly_RequestRegister.get_nodes().get_length() > 0) {
        var NoLocationNode = trvMissionLocation_tbHourly_RequestRegister.get_nodes().getNode(0);
        document.getElementById('cmbMissionLocation_tbHourly_RequestRegister_TextBox').innerHTML = NoLocationNode.get_text();
        trvMissionLocation_tbDaily_RequestRegister.selectNodeById(NoLocationNode.get_id());
    }
}

function Clear_cmbMissionLocation_tbDaily_RequestRegister() {
    if (trvMissionLocation_tbDaily_RequestRegister.get_nodes().get_length() > 0) {
        var NoLocationNode = trvMissionLocation_tbDaily_RequestRegister.get_nodes().getNode(0);
        document.getElementById('cmbMissionLocation_tbDaily_RequestRegister_TextBox').innerHTML = NoLocationNode.get_text();
        trvMissionLocation_tbDaily_RequestRegister.selectNodeById(NoLocationNode.get_id());
    }
}

function GetRequestTargetFeatures_RequestRegister() {
    var RequestTarget = GetCurrentRequestTarget_RequestRegister();
    var ObjRequestTargetFeatures = null;
    switch (RequestTarget) {
        case 'Hourly':
            if (cmbRequestType_tbHourly_RequestRegister.getSelectedItem() != undefined && cmbRequestType_tbHourly_RequestRegister.getSelectedItem() != null)
                ObjRequestTargetFeatures = cmbRequestType_tbHourly_RequestRegister.getSelectedItem().get_value();
            break;
        case 'Daily':
            if (cmbRequestType_tbDaily_RequestRegister.getSelectedItem() != undefined && cmbRequestType_tbDaily_RequestRegister.getSelectedItem() != null)
                ObjRequestTargetFeatures = cmbRequestType_tbDaily_RequestRegister.getSelectedItem().get_value();
            break;
        case 'OverTime':
            if (cmbRequestType_tbOverTime_RequestRegister.getSelectedItem() != undefined && cmbRequestType_tbOverTime_RequestRegister.getSelectedItem() != null)
                ObjRequestTargetFeatures = cmbRequestType_tbOverTime_RequestRegister.getSelectedItem().get_value();
            break;
    }
    ObjRequestTargetFeatures = eval('(' + ObjRequestTargetFeatures + ')');
    return ObjRequestTargetFeatures;
}

function TabStripRequestRegister_onTabSelect(sender, e) {
    CollapseControls_RequestRegister();
}

function CallBack_cmbRequestType_tbHourly_RequestRegister_onCallbackError(sender, e) {
    ShowConnectionError_RequestRegister();
}

function tlbItemRefresh_TlbPaging_PersonnelSearch_RequestRegister_onClick() {
    Refresh_cmbPersonnel_RequestRegister();
}

function Refresh_cmbPersonnel_RequestRegister() {
    ChangeLoadState_cmbPersonnel_RequestRegister('Normal');
    RequestPersonnelCountState_RequestRegister = 'Single';
    StrUnCollectivePersonnelList_CollectiveTraffic = '';
}

function tlbItemFirst_TlbPaging_PersonnelSearch_RequestRegister_onClick() {
    SetPageIndex_cmbPersonnel_RequestRegister(0);
}

function tlbItemBefore_TlbPaging_PersonnelSearch_RequestRegister_onClick() {
    if (CurrentPageIndex_cmbPersonnel_RequestRegister != 0) {
        CurrentPageIndex_cmbPersonnel_RequestRegister = CurrentPageIndex_cmbPersonnel_RequestRegister - 1;
        SetPageIndex_cmbPersonnel_RequestRegister(CurrentPageIndex_cmbPersonnel_RequestRegister);
    }
}

function tlbItemNext_TlbPaging_PersonnelSearch_RequestRegister_onClick() {
    if (CurrentPageIndex_cmbPersonnel_RequestRegister < parseInt(document.getElementById('hfPersonnelPageCount_RequestRegister').value) - 1) {
        CurrentPageIndex_cmbPersonnel_RequestRegister = CurrentPageIndex_cmbPersonnel_RequestRegister + 1;
        SetPageIndex_cmbPersonnel_RequestRegister(CurrentPageIndex_cmbPersonnel_RequestRegister);
    }
}

function tlbItemLast_TlbPaging_PersonnelSearch_RequestRegister_onClick() {
    SetPageIndex_cmbPersonnel_RequestRegister(parseInt(document.getElementById('hfPersonnelPageCount_RequestRegister').value) - 1);
}

function ChangeLoadState_cmbPersonnel_RequestRegister(state) {
    LoadState_cmbPersonnel_RequestRegister = state;
    SetPageIndex_cmbPersonnel_RequestRegister(0);
}

function SetPageIndex_cmbPersonnel_RequestRegister(pageIndex) {
    CurrentPageIndex_cmbPersonnel_RequestRegister = pageIndex;
    Fill_cmbPersonnel_RequestRegister(pageIndex);
}

function Fill_cmbPersonnel_RequestRegister(pageIndex) {
    var pageSize = parseInt(document.getElementById('hfPersonnelPageSize_RequestRegister').value);
    var SearchTermConditions = '';
    switch (LoadState_cmbPersonnel_RequestRegister) {
        case 'Normal':
            break;
        case 'Search':
            SearchTerm_cmbPersonnel_RequestRegister = SearchTermConditions = document.getElementById('txtPersonnelSearch_RequestRegister').value;
            break;
        case 'AdvancedSearch':
            SearchTermConditions = AdvancedSearchTerm_cmbPersonnel_RequestRegister;
            break;
    }
    CallBack_cmbPersonnel_RequestRegister.callback(CharToKeyCode_RequestRegister(LoadState_cmbPersonnel_RequestRegister), CharToKeyCode_RequestRegister(pageSize.toString()), CharToKeyCode_RequestRegister(pageIndex.toString()), CharToKeyCode_RequestRegister(SearchTermConditions));
}

function tlbItemCollectiveTrrafic_TlbPaging_PersonnelSearch_RequestRegister_onClick() {
    RequestPersonnelCountState_RequestRegister = 'Collective';
    ShowDialogCollectiveTraffic();
}

function ShowDialogCollectiveTraffic() {
    var ObjDialogCollectiveTraffic = new Object();
    ObjDialogCollectiveTraffic.CollectiveState = LoadState_cmbPersonnel_RequestRegister;
    switch (LoadState_cmbPersonnel_RequestRegister) {
        case 'Normal':
            CollectiveConditions = '';
            break;
        case 'Search':
            CollectiveConditions = SearchTerm_cmbPersonnel_RequestRegister;
            break;
        case 'AdvancedSearch':
            CollectiveConditions = AdvancedSearchTerm_cmbPersonnel_RequestRegister;
            break;
    }
    ObjDialogCollectiveTraffic.CollectiveConditions = CollectiveConditions;
    DialogCollectiveTraffic.set_value(ObjDialogCollectiveTraffic);
    DialogCollectiveTraffic.Show();
    CollapseControls_RequestRegister();
}

function cmbPersonnel_RequestRegister_onExpand(sender, e) {
    if (cmbPersonnel_RequestRegister.get_itemCount() == 0 && CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbPersonnel_RequestRegister == undefined) {
        CurrentPageCombosCallBcakStateObj.IsExpandOccured_cmbPersonnel_RequestRegister = true;
        SetPageIndex_cmbPersonnel_RequestRegister(0);
    }
}

function cmbPersonnel_RequestRegister_onCollapse(sender, e) {
    if (CurrentPageCombosCallBcakStateObj.cmbPersonnel_RequestRegister) {
        CurrentPageCombosCallBcakStateObj.cmbPersonnel_RequestRegister = false;
        //cmbPersonnel_RequestRegister.expand();
    }
}

function CallBack_cmbPersonnel_RequestRegister_onBeforeCallback(sender, e) {
    cmbPersonnel_RequestRegister.dispose();
}

function CallBack_cmbPersonnel_RequestRegister_onCallBackComplete(sender, e) {
    document.getElementById('clmnName_cmbPersonnel_RequestRegister').innerHTML = document.getElementById('hfclmnName_cmbPersonnel_RequestRegister').value;
    document.getElementById('clmnBarCode_cmbPersonnel_RequestRegister').innerHTML = document.getElementById('hfclmnBarCode_cmbPersonnel_RequestRegister').value;
    document.getElementById('clmnCardNum_cmbPersonnel_RequestRegister').innerHTML = document.getElementById('hfclmnCardNum_cmbPersonnel_RequestRegister').value;

    var error = document.getElementById('ErrorHiddenField_Personnel_RequestRegister').value;
    if (error == "") {
        if (CheckNavigator_onCmbCallBackCompleted())
            CurrentPageCombosCallBcakStateObj.cmbPersonnel_RequestRegister = true;
        else
            CurrentPageCombosCallBcakStateObj.cmbPersonnel_RequestRegister = false;
        document.getElementById('cmbPersonnel_RequestRegister_DropDown').style.display = 'none';
        cmbPersonnel_RequestRegister.expand();
        ChangeControlDirection_RequestRegister('cmbPersonnel_RequestRegister_DropDown');

        var personnelCount = document.getElementById('hfPersonnelCount_RequestRegister').value;
        ChangeRequestPersonnelCount_RequestRegister(personnelCount);
    }
    else {
        var errorParts = eval('(' + error + ')');
        showDialog(errorParts[0], errorParts[1], errorParts[2]);
        document.getElementById('cmbPersonnel_RequestRegister_DropDown').style.display = 'none';
    }
}

function CallBack_cmbPersonnel_RequestRegister_onCallbackError(sender, e) {
    ShowConnectionError_RequestRegister();
}

function tlbItemSearch_TlbSearchPersonnel_RequestRegister_onClick() {
    LoadState_cmbPersonnel_RequestRegister = 'Search';
    CurrentPageIndex_cmbPersonnel_RequestRegister = 0;
    SetPageIndex_cmbPersonnel_RequestRegister(0);
}

function tlbItemAdvancedSearch_TlbAdvancedSearch_RequestRegister_onClick() {
    LoadState_cmbPersonnel_RequestRegister = 'AdvancedSearch';
    CurrentPageIndex_cmbPersonnel_RequestRegister = 0;
    ShowDialogPersonnelSearch('RequestRegister');
}

function ShowDialogPersonnelSearch(state) {
    var ObjDialogPersonnelSearch = new Object();
    ObjDialogPersonnelSearch.Caller = state;
    parent.parent.DialogPersonnelSearch.set_value(ObjDialogPersonnelSearch);
    parent.parent.DialogPersonnelSearch.Show();
    CollapseControls_RequestRegister();
}

function RequestRegister_onAfterPersonnelAdvancedSearch(SearchTerm) {
    AdvancedSearchTerm_cmbPersonnel_RequestRegister = SearchTerm;
    SetPageIndex_cmbPersonnel_RequestRegister(0);
}

function tlbItemSave_TlbCollectiveTraffic_onClick() {
    UpdateRequestPersonnelCount_RequestRegister();
    DialogCollectiveTraffic.Close();
}

function UpdateRequestPersonnelCount_RequestRegister() {
    var personnelCount = parseInt(document.getElementById('hfPersonnelCount_Personnel_CollectiveTraffic'));
    var unCollectivePersonnelCount = 0;
    if (StrUnCollectivePersonnelList_CollectiveTraffic != '')
        unCollectivePersonnelCount = StrUnCollectivePersonnelList_CollectiveTraffic.split('#').length - 1;
    personnelCount -= unCollectivePersonnelCount;
    ChangeRequestPersonnelCount_RequestRegister(personnelCount);
}

function ChangeRequestPersonnelCount_RequestRegister(personnelCount) {
    var countVal = document.getElementById('headerPersonnelCount_RequestRegister').innerHTML;
    var countValCol = countVal.split(':');
    countVal = countValCol[0] + ':' + personnelCount;
    document.getElementById('footer_GridPersonnel_CollectiveTraffic').innerHTML = countVal;    
}

function tlbItemExit_TlbCollectiveTraffic_onClick() {
    ShowDialogConfirm('CollectiveTraffic');
}

function CollectiveTraffic_onClose() {
    RequestPersonnelCountState_RequestRegister = 'Single';
    DialogCollectiveTraffic.Close();
}

function GridPersonnel_CollectiveTraffic_onLoad(sender, e) {
    document.getElementById('loadingPanel_GridPersonnel_CollectiveTraffic').innerHTML = '';
}

function GridPersonnel_CollectiveTraffic_onItemCheckChange(sender, e) {
    ChangeStrUnCollectivePersonnelList_CollectivePersonnel(e.get_item());
}

function ChangeStrUnCollectivePersonnelList_CollectivePersonnel(PersonnelItem) {
    var checked = PersonnelItem.getMember('Select').get_value() ? true : false;
    var separator = '#';
    var identifier = PersonnelItem.getMember('ID').get_text() + separator;
    if (StrUnCollectivePersonnelList_CollectiveTraffic == '')
        StrUnCollectivePersonnelList_CollectiveTraffic = separator;
    if (checked) {
        if (StrUnCollectivePersonnelList_CollectiveTraffic.indexOf(identifier) < 0)
            StrUnCollectivePersonnelList_CollectiveTraffic += identifier;
    }
    else {
        if (StrUnCollectivePersonnelList_CollectiveTraffic.indexOf(identifier) >= 0)
            StrUnCollectivePersonnelList_CollectiveTraffic = StrUnCollectivePersonnelList_CollectiveTraffic.replace(separator + identifier, separator);
    }
}

function CallBack_GridPersonnel_CollectiveTraffic_onCallbackComplete(sender, e) {
    var error = document.getElementById('ErrorHiddenField_Personnel_CollectiveTraffic').value;
    if (error != "") {
        var errorParts = eval('(' + error + ')');
        if (errorParts[3] == 'Reload')
            SetPageIndex_GridPersonnel_CollectiveTraffic(0);
        else
            showDialog(errorParts[0], errorParts[1], errorParts[2], false, document.getElementById('Mastertbl_RegisteredRequestsForm').offsetWidth);
    }
    else {
        Changefooter_GridPersonnel_CollectiveTraffic();
        UpdateGridPersonnel_CollectiveTraffic();
    }
}

function UpdateGridPersonnel_CollectiveTraffic() {
    var separator = '';
    if (StrUnCollectivePersonnelList_CollectiveTraffic != null) {
        for (var i = 0; i < GridPersonnel_CollectiveTraffic.get_table().getRowCount(); i++) {
            personnelItem = GridPersonnel_CollectiveTraffic.get_table().getRow(i);
            var personnelID = personnelItem.getMember('ID').get_text();
            GridPersonnel_CollectiveTraffic.beginUpdate();
            if (StrUnCollectivePersonnelList_CollectiveTraffic.indexOf(separator + personnelID + separator) >= 0) 
                personnelItem.setValue(1, false, false);
            else
                personnelItem.setValue(1, true, false);                
            GridPersonnel_CollectiveTraffic.endUpdate();
        }
    }
}

function Changefooter_GridPersonnel_CollectiveTraffic() {
    var retfooterVal = '';
    var footerVal = document.getElementById('footer_GridPersonnel_CollectiveTraffic').innerHTML;
    var footerValCol = footerVal.split(' ');
    for (var i = 0; i < footerValCol.length; i++) {
        if (i == 1)
            footerValCol[i] = parseInt(document.getElementById('hfPersonnelPageCount_Personnel_CollectiveTraffic').value) > 0 ? CurrentPageIndex_GridPersonnel_CollectiveTraffic + 1 : 0;
        if (i == 3)
            footerValCol[i] = document.getElementById('hfPersonnelPageCount_Personnel_CollectiveTraffic').value;
        if ((i == 1 || i == 3) && GridPersonnel_CollectiveTraffic.get_table().getRowCount() == 0)
            footerValCol[i] = 0;
        retfooterVal += footerValCol[i] + ' ';
    }
    document.getElementById('footer_GridPersonnel_CollectiveTraffic').innerHTML = retfooterVal;
}


function CallBack_GridPersonnel_CollectiveTraffic_onCallbackError(sender, e) {
    ShowConnectionError_RequestRegister();
}

function tlbItemRefresh_TlbPaging_GridPersonnel_CollectiveTraffic_onClick() {
    SetPageIndex_GridPersonnel_CollectiveTraffic(0);
}

function tlbItemFirst_TlbPaging_GridPersonnel_CollectiveTraffic_onClick() {
    SetPageIndex_GridPersonnel_CollectiveTraffic(0);    
}

function tlbItemBefore_TlbPaging_GridPersonnel_CollectiveTraffic_onClick() {
    if (CurrentPageIndex_GridPersonnel_CollectiveTraffic != 0) {
        CurrentPageIndex_GridPersonnel_CollectiveTraffic = CurrentPageIndex_GridPersonnel_CollectiveTraffic - 1;
        SetPageIndex_GridPersonnel_CollectiveTraffic(CurrentPageIndex_GridPersonnel_CollectiveTraffic);
    }
}

function tlbItemNext_TlbPaging_GridPersonnel_CollectiveTraffic_onClick() {
    if (CurrentPageIndex_GridPersonnel_CollectiveTraffic < parseInt(document.getElementById('hfPersonnelPageCount_Personnel_CollectiveTraffic').value) - 1) {
        CurrentPageIndex_GridPersonnel_CollectiveTraffic = CurrentPageIndex_GridPersonnel_CollectiveTraffic + 1;
        SetPageIndex_GridPersonnel_CollectiveTraffic(CurrentPageIndex_GridPersonnel_CollectiveTraffic);
    }
}

function tlbItemLast_TlbPaging_GridPersonnel_CollectiveTraffic_onClick() {
    SetPageIndex_GridPersonnel_CollectiveTraffic(parseInt(document.getElementById('hfPersonnelPageCount_Personnel_CollectiveTraffic').value) - 1);
}

function SetPageIndex_GridPersonnel_CollectiveTraffic(pageIndex) {
    CurrentPageIndex_GridPersonnel_CollectiveTraffic = pageIndex;
    Fill_GridPersonnel_CollectiveTraffic(pageIndex);
}

function Fill_GridPersonnel_CollectiveTraffic(pageIndex) {
    document.getElementById('loadingPanel_GridPersonnel_CollectiveTraffic').innerHTML = document.getElementById('hfloadingPanel_GridPersonnel_CollectiveTraffic').value;
    var pageSize = parseInt(document.getElementById('hfPersonnelPageSize_Personnel_CollectiveTraffic').value);
    var ObjCollectiveTraffic = DialogCollectiveTraffic.get_value();
    var CollectiveState = ObjCollectiveTraffic.CollectiveState;
    var CollectiveConditions = ObjCollectiveTraffic.CollectiveConditions;
    CallBack_GridPersonnel_CollectiveTraffic.callback(CharToKeyCode_RequestRegister(CollectiveState), CharToKeyCode_RequestRegister(pageSize.toString()), CharToKeyCode_RequestRegister(pageIndex.toString()), CharToKeyCode_RequestRegister(CollectiveConditions));
}

function DialogCollectiveTraffic_OnShow(sender, e) {
    Init_DialogCollectiveTraffic();
    SetPageIndex_GridPersonnel_CollectiveTraffic(0);
}

function Init_DialogCollectiveTraffic() {
    document.getElementById('Title_DialogCollectiveTraffic').innerHTML = document.getElementById('hfTitle_DialogCollectiveTraffic').value;
    var CurrentLangID = parent.parent.CurrentLangID;
    if (CurrentLangID == 'fa-IR') {
        document.getElementById('DialogCollectiveTraffic_topLeftImage').src = 'Images/Dialog/top_right.gif';
        document.getElementById('DialogCollectiveTraffic_topRightImage').src = 'Images/Dialog/top_left.gif';
        document.getElementById('DialogCollectiveTraffic_downLeftImage').src = 'Images/Dialog/down_right.gif';
        document.getElementById('DialogCollectiveTraffic_downRightImage').src = 'Images/Dialog/down_left.gif';
        document.getElementById('CloseButton_DialogCollectiveTraffic').align = 'left';
    }
    if (CurrentLangID == 'en-US')
        document.getElementById('CloseButton_DialogCollectiveTraffic').align = 'right';

    ChangeControlDirection_RequestRegister('tbl_DialogCollectiveTrafficheader');
    ChangeControlDirection_RequestRegister('tbl_DialogCollectiveTrafficfooter');
}

function ChangeControlDirection_RequestRegister(ctrl) {
    var direction = null;
    switch (parent.CurrentLangID) {
        case 'fa-IR':
            direction = 'rtl';
            break;
        case 'en-US':
            direction = 'ltr';
            break;
    }
    if (ctrl == 'All') {
        if (document.getElementById('cmbPersonnel_RequestRegister_DropDownContent') != null)
            document.getElementById('cmbPersonnel_RequestRegister_DropDownContent').dir = direction;
        document.getElementById('Mastertbl_RequestRegister').dir = document.getElementById('cmbIllnesses_tbHourly_RequestRegister_DropDownContent').dir = document.getElementById('cmbDoctors_tbHourly_RequestRegister_DropDownContent').dir = document.getElementById('cmbMissionLocation_tbHourly_RequestRegister_DropDownContent').dir = document.getElementById('cmbMissionLocation_tbHourly_RequestRegister_DropDownContent').dir = document.getElementById('cmbRequestType_tbHourly_RequestRegister_DropDownContent').dir = document.getElementById('cmbIllnesses_tbDaily_RequestRegister_DropDownContent').dir = document.getElementById('cmbDoctors_tbDaily_RequestRegister_DropDownContent').dir = document.getElementById('cmbMissionLocation_tbDaily_RequestRegister_DropDownContent').dir = document.getElementById('cmbRequestType_tbDaily_RequestRegister_DropDownContent').dir = document.getElementById('cmbRequestType_tbOverTime_RequestRegister_DropDownContent').dir = document.getElementById('tblConfirm_DialogConfirm').dir = document.getElementById('Mastertbl_CollectiveTraffic').dir = direction;
    }
    else
        document.getElementById(ctrl).style.direction = direction;
}

function CollapseControls_RequestRegister() {
    var currentUserState = parent.DialogRequestRegister.get_value();
    switch (currentUserState) {
        case 'Operator':
            cmbPersonnel_RequestRegister.collapse();
            break;
        case 'NormalUser':
            break;
    }
    cmbIllnesses_tbHourly_RequestRegister.collapse();
    cmbDoctors_tbHourly_RequestRegister.collapse();
    cmbMissionLocation_tbHourly_RequestRegister.collapse();
    cmbRequestType_tbHourly_RequestRegister.collapse();
    cmbIllnesses_tbDaily_RequestRegister.collapse();
    cmbDoctors_tbDaily_RequestRegister.collapse();
    cmbMissionLocation_tbDaily_RequestRegister.collapse();
    cmbRequestType_tbDaily_RequestRegister.collapse();
    cmbRequestType_tbOverTime_RequestRegister.collapse();
    if (document.getElementById('datepickeriframe') != null && document.getElementById('datepickeriframe').style.visibility == 'visible')
        displayDatePicker('pdpRequestDate_tbHourly_RequestRegister');
}

function tlbItemFormReconstruction_TlbHourly_onClick() {
    ReconstrucForm_RequestRegister();
}

function tlbItemFormReconstruction_TlbDaily_onClick() {
    ReconstrucForm_RequestRegister();
}

function tlbItemFormReconstruction_TlbOverTime_onClick() {
    ReconstrucForm_RequestRegister();
}

function ReconstrucForm_RequestRegister() { 
    var ObjDialogRequestRegister = parent.DialogRequestRegister.get_value();
    var caller = ObjDialogRequestRegister.Caller;
    RequestRegister_onClose();
    parent.parent.document.getElementById('DialogRegisteredRequests_IFrame').contentWindow.ShowDialogRequestRegister(caller);
}

function TimeSelector_MinistryDuration_tbOverTime_RequestRegister_onChange(partID) {
    var id = 'TimeSelector_MinistryDuration_tbOverTime_RequestRegister_' + partID;
    var val = document.getElementById(id).value;
    val = !isNaN(parseFloat(val)) ? parseFloat(val) > 0 ? "" + parseFloat(val) + "" : '00' : '00';
    switch (partID) {
        case 'txtHour':
            break;
        case 'txtMinute':
            val = parseFloat(val) < 60 ? val : '59';
            break;
    }
    document.getElementById(id).value = val.length >= 2 ? val : '0' + val;
}

function cmbRequestType_tbOverTime_RequestRegister_onChange(sender, e) {
    if (cmbRequestType_tbOverTime_RequestRegister.getSelectedItem() != undefined) {
        var ObjRequestTargetFeatures = cmbRequestType_tbOverTime_RequestRegister.getSelectedItem().get_value();
        ObjRequestTargetFeatures = eval('(' + ObjRequestTargetFeatures + ')');
        ChangeHideElementsState_RequestRegister(ObjRequestTargetFeatures.IsSickLeave, ObjRequestTargetFeatures.IsMission, ObjRequestTargetFeatures.IsMinistryOverTime, false);
    }
}









