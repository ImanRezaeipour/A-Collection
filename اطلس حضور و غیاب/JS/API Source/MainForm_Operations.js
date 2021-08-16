var CurrentLangID = null;
var SysLangID = null;
var HelpRefererWindow = null;

function DockMenuItem_onClick(dmItemID) {
    var dmItemBaseText = dmItemID.substring(6, dmItemID.length - 9);
    var nvbItem = 'nvbItem' + dmItemBaseText + '_NavBarMain';
    if (dmItemID != 'dmItemWelcome_DockMenu') {
        if (CheckExistingNavBarItem_MainPage(nvbItem))
            NavBarMain_onItemSelect_Operations(NavBarMain.findItemById(nvbItem));
    }
    else {
        TabStripMenus.get_tabs().getTabById("tb" + dmItemBaseText + "_TabStripMenus").select();
        MultiPageMenus.findPageById('pgv' + dmItemBaseText).Show();
    }
}

function CheckExistingNavBarItem_MainPage(nvbItem) {
    var isExist = false;
    for (var i = 0; i < NavBarMain.get_items().get_length(); i++) {
        var parentNavbarItem = NavBarMain.get_items().get_itemArray()[i];
        if (parentNavbarItem.get_items().getItemById(nvbItem) != null) {
            isExist = true;
            return isExist
        }
    }
}

function SetNavBarHeight() {
    document.getElementById('NavBarMain_tr').style.height = parseInt(screen.height - 440) + "px";
    //document.getElementById('NavBarMain_tr').style.height = (parseInt(screen.height))*0.4818 + "px";
}

function SetCurrentCulture() {
    CurrentLangID = document.getElementById('hfCurrentUILangID').value;
    SysLangID = document.getElementById('hfCurrentSysLangID').value
}

function InitializeQuickLaunch_MainForm() {
    document.getElementById('qlItemHome').alt = document.getElementById('qlItemHome').title = document.getElementById('hfTitle_qlItemHome').value;
    document.getElementById('qlItemWorkFlows').alt = document.getElementById('qlItemWorkFlows').title = document.getElementById('hfTitle_qlItemWorkFlows').value;
    document.getElementById('qlItemTrafficsControl').alt = document.getElementById('qlItemTrafficsControl').title = document.getElementById('hfTitle_qlItemTrafficsControl').value;
    document.getElementById('qlItemRegisteredRequests').alt = document.getElementById('qlItemRegisteredRequests').title = document.getElementById('hfTitle_qlItemRegisteredRequests').value;
    document.getElementById('qlItemSurveyedRequests').alt = document.getElementById('qlItemSurveyedRequests').title = document.getElementById('hfTitle_qlItemSurveyedRequests').value;
    document.getElementById('qlItemCartable').alt = document.getElementById('qlItemCartable').title = document.getElementById('hfTitle_qlItemCartable').value;
    document.getElementById('qlItemReports').alt = document.getElementById('qlItemReports').title = document.getElementById('hfTitle_qlItemReports').value;
    document.getElementById('qlItemPersonnel').alt = document.getElementById('qlItemPersonnel').title = document.getElementById('hfTitle_qlItemPersonnel').value;
    document.getElementById('qlItemManagersMonthlyOperationReport').alt = document.getElementById('qlItemManagersMonthlyOperationReport').title = document.getElementById('hfTitle_qlItemManagersMonthlyOperationReport').value;
    document.getElementById('qlItemMonthlyOperationReport').alt = document.getElementById('qlItemMonthlyOperationReport').title = document.getElementById('hfTitle_qlItemMonthlyOperationReport').value;
}

function imgbtnPersian_onClick() {
    MainFrom_onBeforePostBack();
}

function ImgbtnEnglish_onClick() {
    MainFrom_onBeforePostBack();
}

function imgbtnLogOut_onClick() {
    MainFrom_onBeforePostBack();
}

function MainFrom_onBeforePostBack() {
    TabStripMenus.dispose();
}





