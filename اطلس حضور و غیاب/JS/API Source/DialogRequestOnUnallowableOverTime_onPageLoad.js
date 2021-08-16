

function DialogRequestOnUnallowableOverTime_onShow(sender, e) {
    var CurrentLangID = parent.CurrentLangID;
    DialogRequestOnUnallowableOverTime.set_contentUrl("RequestOnUnallowableOverTime.aspx");
    document.getElementById('DialogRequestOnUnallowableOverTime_IFrame').style.display = '';
    document.getElementById('DialogRequestOnUnallowableOverTime_IFrame').style.visibility = 'visible';

    if (CurrentLangID == 'fa-IR') {
        document.getElementById('DialogRequestOnUnallowableOverTime_topLeftImage').src = 'Images/Dialog/top_right.gif';
        document.getElementById('DialogRequestOnUnallowableOverTime_topRightImage').src = 'Images/Dialog/top_left.gif';
        document.getElementById('DialogRequestOnUnallowableOverTime_downLeftImage').src = 'Images/Dialog/down_right.gif';
        document.getElementById('DialogRequestOnUnallowableOverTime_downRightImage').src = 'Images/Dialog/down_left.gif';
        document.getElementById('CloseButton_DialogRequestOnUnallowableOverTime').align = 'left';
        document.getElementById('tbl_DialogRequestOnUnallowableOverTimeheader').dir = 'rtl';
        document.getElementById('tbl_DialogRequestOnUnallowableOverTimefooter').dir = 'rtl';        
    }
    if (CurrentLangID == 'en-US')
        document.getElementById('CloseButton_DialogRequestOnUnallowableOverTime').align = 'right';
}

function DialogRequestOnUnallowableOverTime_onClose(sender, e) {
    document.getElementById('DialogRequestOnUnallowableOverTime_IFrame').style.display = 'none';
    document.getElementById('DialogRequestOnUnallowableOverTime_IFrame').style.visibility = 'hidden';
    DialogRequestOnUnallowableOverTime.set_contentUrl("about:blank");
}
