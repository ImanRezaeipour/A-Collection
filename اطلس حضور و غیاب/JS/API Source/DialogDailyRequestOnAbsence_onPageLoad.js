

function DialogDailyRequestOnAbsence_onShow(sender, e) {
    var CurrentLangID = parent.CurrentLangID;
    DialogDailyRequestOnAbsence.set_contentUrl("DailyRequestOnAbsence.aspx");
    document.getElementById('DialogDailyRequestOnAbsence_IFrame').style.display = '';
    document.getElementById('DialogDailyRequestOnAbsence_IFrame').style.visibility = 'visible';

    if (CurrentLangID == 'fa-IR') {
        document.getElementById('DialogDailyRequestOnAbsence_topLeftImage').src = 'Images/Dialog/top_right.gif';
        document.getElementById('DialogDailyRequestOnAbsence_topRightImage').src = 'Images/Dialog/top_left.gif';
        document.getElementById('DialogDailyRequestOnAbsence_downLeftImage').src = 'Images/Dialog/down_right.gif';
        document.getElementById('DialogDailyRequestOnAbsence_downRightImage').src = 'Images/Dialog/down_left.gif';
        document.getElementById('CloseButton_DialogDailyRequestOnAbsence').align = 'left';
        document.getElementById('tbl_DialogDailyRequestOnAbsenceheader').dir = 'rtl';
        document.getElementById('tbl_DialogDailyRequestOnAbsencefooter').dir = 'rtl';        
    }
    if (CurrentLangID == 'en-US')
        document.getElementById('CloseButton_DialogDailyRequestOnAbsence').align = 'right';
}

function DialogDailyRequestOnAbsence_onClose(sender, e) {
    document.getElementById('DialogDailyRequestOnAbsence_IFrame').style.display = 'none';
    document.getElementById('DialogDailyRequestOnAbsence_IFrame').style.visibility = 'hidden';
    DialogDailyRequestOnAbsence.set_contentUrl("about:blank");
}
