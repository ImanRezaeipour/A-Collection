<%@ page language="C#" autoeventwireup="true" inherits="PublicNews, App_Web_zm3lnrmt" %>

<%@ Register Assembly="ComponentArt.Web.UI" Namespace="ComponentArt.Web.UI" TagPrefix="ComponentArt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="css/bulletedListStyle.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="css/rotator.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="css/label.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/alert_box.css" runat="server" type="text/css" rel="Stylesheet" />
    <title></title>
</head>
<body>
    <script type="text/javascript" src="JS/jquery.js"></script>
    <script type="text/javascript" src="JS/API/PublicNews_onPageLoad.js"></script>
    <script type="text/javascript" src="JS/API/PublicNews_Operations.js"></script>
    <script type="text/javascript" src="JS/API/Alert_Box.js"></script>
    <form id="PublicNewsForm" runat="server" meta:resourcekey="PublicNewsForm">
    <table style="width: 100%; height: 180px" class="HeaderLabel">
        <tr>
            <td valign="top">                
                <asp:BulletedList ID="bulletedListPublicNews_PublicNews" DataTextField="Message" DataValueField="ID" runat="server">
                </asp:BulletedList>
            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hfheader_PublicNews" meta:resourcekey="hfheader_PublicNews"/>
    <asp:HiddenField runat="server" ID="ErrorHiddenField_PublicNews"/>
    </form>
</body>
</html>
