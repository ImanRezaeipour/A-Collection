
function GetBoxesHeaders_PublicNews() {
    parent.document.getElementById('header_' + this.frameElement.id).innerHTML = document.getElementById('hfheader_PublicNews').value;
}

function GetErrorMessage_PublicNews() {
    var errorMessage = document.getElementById('ErrorHiddenField_PublicNews').value;
    if (errorMessage != '' && errorMessage != undefined) {
        errorMessage = eval('(' + errorMessage + ')');
        if (errorMessage[2] != 'success')
            showDialog(errorMessage[0], errorMessage[1], errorMessage[2]);
    }
}

