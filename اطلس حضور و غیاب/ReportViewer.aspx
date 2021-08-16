<%@ page language="C#" autoeventwireup="true" inherits="ReportViewer, App_Web_vccxcelb" %>

<%@ Register Assembly="Stimulsoft.Report.Web" Namespace="Stimulsoft.Report.Web" TagPrefix="Sti" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="css/alert_box.css" runat="server" type="text/css" rel="Stylesheet" />
    <title></title>
</head>
<body onload="ReportViewer_onPageLoad();">
    <script type="text/javascript" src="JS/API/ReportViewer_Operations.js"></script>
    <script type="text/javascript" src="JS/API/Alert_Box.js"></script>
    <form id="ReportViewerForm" runat="server">
    <div>
        <Sti:StiWebViewer ID="StiReportViewer" runat="server" Width="100%" Height="309px" RenderMode="AjaxWithCache"
            ButtonsImagesPath="Images" ToolBarBackColor="WhiteSmoke" ButtonImagesPath="Images/ReportViewer/" ShowExportToPdf="true">
        </Sti:StiWebViewer>
    </div>
    <asp:HiddenField runat="server" ID="hfReportViewerTitle_ReportViewer"/>
    </form>
</body>
</html>
