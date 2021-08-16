<%@ page language="C#" autoeventwireup="true" inherits="PersonnelInformationSummary, App_Web_aaak0nyc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="css/label.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/alert_box.css" runat="server" type="text/css" rel="Stylesheet" />
    <title></title>
</head>
<body>
    <script type="text/javascript" src="JS/jquery.js"></script>
    <script type="text/javascript" src="JS/API/PersonnelInformationSummary_onPageLoad.js"></script>
    <script type="text/javascript" src="JS/API/PersonnelInformationSummary_Operations.js"></script>
    <script type="text/javascript" src="JS/API/Alert_Box.js"></script>

    <form id="PersonnelInformationSummaryForm" runat="server" meta:resourcekey="PersonnelInformationSummaryForm">
    <table style="width: 100%;">
        <tr>
            <td id="PersonnelInformationSummaryContainer_PersonnelInformationSummary" runat="server" valign="top">
            </td>
            <td style="width: 40%">
                <iframe id="CurrentPersonnelImage_PersonnelInformationSummary" runat="server" scrolling="yes"
                    style="width: 95%; height: 170px; overflow:hidden" allowtransparency="true" frameborder="0"></iframe>
            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hfheader_PersonnelInformationSummary" meta:resourcekey="hfheader_PersonnelInformationSummary"/>
    <asp:HiddenField runat="server" ID="ErrorHiddenField_PersonnelInformationSummary"/>
    <asp:HiddenField runat="server" ID="CurrentPersonnelID_PersonnelInformationSummary"/>
    </form>
</body>
</html>
