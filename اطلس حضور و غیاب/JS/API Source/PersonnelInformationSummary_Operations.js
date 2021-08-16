
function GetBoxesHeaders_PersonnelInformationSummary() {
    parent.document.getElementById('header_' + this.frameElement.id).innerHTML = document.getElementById('hfheader_PersonnelInformationSummary').value;
}

function GetErrorMessage_PersonnelInformationSummary() {
    var errorMessage = document.getElementById('ErrorHiddenField_PersonnelInformationSummary').value;
    if (errorMessage != '' && errorMessage != undefined) {
        errorMessage = eval('(' + errorMessage + ')');
        if (errorMessage[2] != 'success')
            showDialog(errorMessage[0], errorMessage[1], errorMessage[2]);
    }
}

function ShowCurrentPersonnelImage_PersonnelInformationSummary() {
    var CurrentPersonnelID = document.getElementById('CurrentPersonnelID_PersonnelInformationSummary').value;
    if (CurrentPersonnelID != null && parseInt(CurrentPersonnelID) > 0)
       document.getElementById('CurrentPersonnelImage_PersonnelInformationSummary').src = 'ImageViewer.aspx?reload=""' + (new Date()).getTime() + '"&PersonnelID="' + CurrentPersonnelID + '"';
}