
function initializeParts_MainView() {
    document.getElementById('MainViewPart1_MainView').src = 'PrivateNews.aspx?' + (new Date()).getDate();
    document.getElementById('MainViewPart2_MainView').src = 'PersonnelInformationSummary.aspx?' + (new Date()).getDate();
    document.getElementById('MainViewPart3_MainView').src = 'PublicNews.aspx?' + (new Date()).getDate();
    document.getElementById('MainViewPart4_MainView').src = 'LocalDateTime.aspx?' + (new Date()).getDate();
}

function Refresh_MainViewPart1_MainView() {
    document.getElementById('MainViewPart1_MainView').src = 'PrivateNews.aspx?' + (new Date()).getDate();
}

function Refresh_MainViewPart2_MainView() {
    document.getElementById('MainViewPart2_MainView').src = 'PersonnelInformationSummary.aspx?' + (new Date()).getDate();
}

function Refresh_MainViewPart3_MainView() {
    document.getElementById('MainViewPart3_MainView').src = 'PublicNews.aspx?' + (new Date()).getDate();
}

function Refresh_MainViewPart4_MainView() {
    document.getElementById('MainViewPart4_MainView').src = 'LocalDateTime.aspx?' + (new Date()).getDate();
}

