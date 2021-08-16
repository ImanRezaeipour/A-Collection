<%@ page language="C#" autoeventwireup="true" inherits="LocalDateTime, App_Web_aaak0nyc" %>

<%@ Register Assembly="FlashControl" Namespace="Bewise.Web.UI.WebControls" TagPrefix="Bewise" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="css/label.css" runat="server" type="text/css" rel="Stylesheet" />
    <title></title>
</head>
<body>
    <script type="text/javascript" src="JS/jquery.js"></script>
    <script type="text/javascript" src="JS/API/LocalDateTime_onPageLoad.js"></script>
    <script type="text/javascript" src="JS/API/LocalDateTime_Operations.js"></script>
    <form id="LocalDateTimeForm" runat="server" meta:resourcekey="LocalDateTimeForm">
    <table style="width: 100%; height: 160px">
        <tr>
            <td valign="middle" align="center">
                <Bewise:FlashControl ID="HeaderFlashControl" runat="server" MovieUrl="~/swf/clock13.swf"
                    Menu="false" Scale="Exactfit" WMode="Transparent" BrowserDetection="False" Height="157px"
                    Width="157" Quality="High" Loop="true"/>
            </td>
            <td valign="middle" style="width: 50%" align="center">
                <asp:Label ID="lblCurrentDateTime_LocalDateTime" runat="server" Text="" CssClass="HeaderLabel"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hfheader_LocalDateTime" meta:resourcekey="hfheader_LocalDateTime"/>
    </form>
</body>
</html>
