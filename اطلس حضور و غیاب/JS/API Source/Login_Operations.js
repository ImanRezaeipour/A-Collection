
function initControls_Login() {
    document.getElementById('theLogincontrol_UserName').focus();
    document.getElementById('theLogincontrol_UserName').onclick = function () {
        this.select();
    };
    document.getElementById('theLogincontrol_UserName').onfocus = function () {
        this.select();
    };
    document.getElementById('theLogincontrol_Password').onclick = function () {
        this.select();
    };
    document.getElementById('theLogincontrol_Password').onfocus = function () {
        this.select();
    };   
}

function ShowKeyboard() {
    VKI_show(document.getElementById('theLogincontrol_Password'));
}

function CheckReferer() {
    if (this.location.search != '' && this.location.search.indexOf('.aspx') >= 0 && this.location.search.indexOf('MainPage.aspx') < 0) {
        if (parent.window == this.window)
            return;
        var parentWindow = parent.window;
        while (true) {
            if (parentWindow.document.getElementById('MainForm') != null) {
                parentWindow.location = 'Login.aspx';
                break;
            }
            else
                parentWindow = parentWindow.parent;
        };
    }    
}
