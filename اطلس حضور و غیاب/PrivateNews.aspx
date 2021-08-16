<%@ page language="C#" autoeventwireup="true" inherits="PrivateNews, App_Web_vccxcelb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="css/label.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/alert_box.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/inputStyle.css" runat="server" type="text/css" rel="Stylesheet" />
    <title></title>
</head>
<body>
    <script type="text/javascript" src="JS/jquery.js"></script>
    <script type="text/javascript" src="JS/API/PrivateNews_onPageLoad.js"></script>
    <script type="text/javascript" src="JS/API/PrivateNews_Operation.js"></script>
    <script type="text/javascript" src="JS/API/Alert_Box.js"></script>
    <form id="PrivateNewsForm" runat="server" meta:resourcekey="PrivateNewsForm">
    <asp:HiddenField runat="server" ID="hfheader_PrivateNews" meta:resourcekey="hfheader_PrivateNews"/>
    <asp:HiddenField runat="server" ID="ErrorHiddenField_PrivateNews"/>
    </form>
</body>
</html>
