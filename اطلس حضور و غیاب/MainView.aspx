<%@ page language="C#" autoeventwireup="true" inherits="MainView, App_Web_vccxcelb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="css/tableStyle.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/label.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/iframe.css" runat="server" type="text/css" rel="Stylesheet" />
    <title></title>
</head>
<body>
    <script type="text/javascript" src="JS/jquery.js"></script>
    <script type="text/javascript" src="JS/API/MainView_onPageLoad.js"></script>
    <script type="text/javascript" src="JS/API/tbMainView_Operations.js"></script>
    <form id="MainViewForm" runat="server" meta:resourcekey="MainViewForm">
    <table style="width: 100%; height: 400px; font-family: Arial; font-size: small;"
        class="BoxStyle">
        <tr>
            <td style="width: 50%" valign="top">
                <table style="width: 100%;" class="MainViewPartStyle">
                    <tr>
                        <td>
                            <table style="width: 100%;" class="ContainerHeader">
                                <tr>
                                    <td valign="top">
                                        <div id="header_MainViewPart1_MainView" runat="server" class="HeaderLabel" meta:resourcekey="AlignObj"
                                            style="color: White; width: 100%; height: 100%">
                                        </div>
                                    </td>
                                    <td style="width: 3%; cursor: pointer">
                                        <ComponentArt:ToolBar ID="TlbRefresh_MainViewPart1_MainView" runat="server" CssClass="toolbar"
                                            DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                                            DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                                            DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText"
                                            ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                                            <Items>
                                                <ComponentArt:ToolBarItem ID="tlbItemRefresh_TlbRefresh_MainViewPart1_MainView" runat="server"
                                                    ClientSideCommand="Refresh_MainViewPart1_MainView();" DropDownImageHeight="16px"
                                                    DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="refresh.png" ImageWidth="16px"
                                                    ItemType="Command" meta:resourcekey="tlbItemRefresh_TlbRefresh_MainViewPart1_MainView"
                                                    TextImageSpacing="5" />
                                            </Items>
                                        </ComponentArt:ToolBar>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <iframe id="MainViewPart1_MainView" allowtransparency="true" src="about:blank" frameborder="0"
                                class="MainViewPart1_iFrame" name="MainViewPart1_MainView"></iframe>
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top">
                <table style="width: 100%;" class="MainViewPartStyle">
                    <tr>
                        <td>
                            <table style="width: 100%;" class="ContainerHeader">
                                <tr>
                                    <td valign="top">
                                        <div id="header_MainViewPart2_MainView" runat="server" class="HeaderLabel" meta:resourcekey="AlignObj"
                                            style="color: White; width: 100%; height: 100%">
                                        </div>
                                    </td>
                                    <td style="width: 3%; cursor: pointer">
                                        <ComponentArt:ToolBar ID="TlbRefresh_MainViewPart2_MainView" runat="server" CssClass="toolbar"
                                            DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                                            DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                                            DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText"
                                            ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                                            <Items>
                                                <ComponentArt:ToolBarItem ID="tlbItemRefresh_TlbRefresh_MainViewPart2_MainView" runat="server"
                                                    ClientSideCommand="Refresh_MainViewPart2_MainView();" DropDownImageHeight="16px"
                                                    DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="refresh.png" ImageWidth="16px"
                                                    ItemType="Command" meta:resourcekey="tlbItemRefresh_TlbRefresh_MainViewPart2_MainView"
                                                    TextImageSpacing="5" />
                                            </Items>
                                        </ComponentArt:ToolBar>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <iframe id="MainViewPart2_MainView" allowtransparency="true" src="about:blank" frameborder="0"
                                class="MainViewPart2_iFrame" name="MainViewPart2_MainView"></iframe>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <table style="width: 100%;" class="MainViewPartStyle">
                    <tr>
                        <td>
                            <table style="width: 100%;" class="ContainerHeader">
                                <tr>
                                    <td valign="top">
                                        <div id="header_MainViewPart3_MainView" runat="server" class="HeaderLabel" meta:resourcekey="AlignObj"
                                            style="color: White; width: 100%; height: 100%">
                                        </div>
                                    </td>
                                    <td style="width: 3%; cursor: pointer">
                                        <ComponentArt:ToolBar ID="TlbRefresh_MainViewPart3_MainView" runat="server" CssClass="toolbar"
                                            DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                                            DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                                            DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText"
                                            ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                                            <Items>
                                                <ComponentArt:ToolBarItem ID="tlbItemRefresh_TlbRefresh_MainViewPart3_MainView" runat="server"
                                                    ClientSideCommand="Refresh_MainViewPart3_MainView();" DropDownImageHeight="16px"
                                                    DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="refresh.png" ImageWidth="16px"
                                                    ItemType="Command" meta:resourcekey="tlbItemRefresh_TlbRefresh_MainViewPart3_MainView"
                                                    TextImageSpacing="5"/>
                                            </Items>
                                        </ComponentArt:ToolBar>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <iframe id="MainViewPart3_MainView" allowtransparency="true" src="about:blank" frameborder="0"
                                class="MainViewPart3_iFrame" name="MainViewPart3_MainView"></iframe>
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top">
                <table style="width: 100%;" class="MainViewPartStyle">
                    <tr>
                        <td>
                            <table style="width: 100%;" class="ContainerHeader">
                                <tr>
                                    <td valign="top">
                                        <div id="header_MainViewPart4_MainView" runat="server" class="HeaderLabel" meta:resourcekey="AlignObj"
                                            style="color: White; width: 100%; height: 100%">
                                        </div>
                                    </td>
                                    <td style="width: 3%; cursor: pointer">
                                        <ComponentArt:ToolBar ID="TlbRefresh_MainViewPart4_MainView" runat="server" CssClass="toolbar"
                                            DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                                            DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                                            DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText"
                                            ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                                            <Items>
                                                <ComponentArt:ToolBarItem ID="tlbItemRefresh_TlbRefresh_MainViewPart4_MainView" runat="server"
                                                    ClientSideCommand="Refresh_MainViewPart4_MainView();" DropDownImageHeight="16px"
                                                    DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="refresh.png" ImageWidth="16px"
                                                    ItemType="Command" meta:resourcekey="tlbItemRefresh_TlbRefresh_MainViewPart4_MainView"
                                                    TextImageSpacing="5" />
                                            </Items>
                                        </ComponentArt:ToolBar>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <iframe id="MainViewPart4_MainView" allowtransparency="true" src="about:blank" frameborder="0"
                                class="MainViewPart4_iFrame" name="MainViewPart4_MainView"></iframe>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
