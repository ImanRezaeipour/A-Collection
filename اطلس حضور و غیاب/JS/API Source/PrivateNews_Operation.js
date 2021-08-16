
function GetBoxesHeaders_PrivateNews() {
    parent.document.getElementById('header_' + this.frameElement.id).innerHTML = document.getElementById('hfheader_PrivateNews').value;
}

function GetErrorMessage_PrivateNews() {
    var errorMessage = document.getElementById('ErrorHiddenField_PrivateNews').value;
    if (errorMessage != '' && errorMessage != undefined) {
        errorMessage = eval('(' + errorMessage + ')');
        if (errorMessage[2] != 'success')
            showDialog(errorMessage[0], errorMessage[1], errorMessage[2]);
    }
}