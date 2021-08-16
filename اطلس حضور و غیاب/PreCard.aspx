<%@ page language="C#" autoeventwireup="true" inherits="GTS.Clock.Presentaion.WebForms.PreCard, App_Web_zm3lnrmt" %>

<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="Css/toolbar.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="Css/gridStyle.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="css/style.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="css/combobox.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/inputStyle.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/iframe.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/tableStyle.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/label.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/alert_box.css" runat="server" type="text/css" rel="Stylesheet" />
    <title></title>
</head>
<body>
    <script type="text/javascript" src="JS/jquery.js"></script>
    <script type="text/javascript" src="JS/API/PreCard_onPageLoad.js"></script>
    <script type="text/javascript" src="JS/API/tbPreCard_TabStripMenus_Operations.js"></script>
    <script type="text/javascript" src="JS/API/Alert_Box.js"></script>
    <script type="text/javascript" src="JS/API/HelpForm_Operations.js"></script>
    <form id="PreCardForm" runat="server" meta:resourcekey="PreCardForm">
    <table style="width: 100%; height: 400px; font-family: Arial; font-size: small">
        <tr>
            <td>
                <ComponentArt:ToolBar ID="TlbPreCard" runat="server" CssClass="toolbar" DefaultItemActiveCssClass="itemActive"
                    DefaultItemCheckedCssClass="itemChecked" DefaultItemCheckedHoverCssClass="itemActive"
                    DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover" DefaultItemImageHeight="16px"
                    DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText" DefaultItemTextImageSpacing="0"
                    ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                    <Items>
                        <ComponentArt:ToolBarItem ID="tlbItemNew_TlbPreCard" runat="server" ClientSideCommand="tlbItemNew_TlbPreCard_onClick();"
                            DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="add.png"
                            ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemNew_TlbPreCard"
                            TextImageSpacing="5" />
                        <ComponentArt:ToolBarItem ID="tlbItemEdit_TlbPreCard" runat="server" ClientSideCommand="tlbItemEdit_TlbPreCard_onClick();"
                            DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="edit.png"
                            ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemEdit_TlbPreCard"
                            TextImageSpacing="5" />
                        <ComponentArt:ToolBarItem ID="tlbItemDelete_TlbPreCard" runat="server" DropDownImageHeight="16px"
                            DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="remove.png" ImageWidth="16px"
                            ClientSideCommand="tlbItemDelete_TlbPreCard_onClick();" ItemType="Command" meta:resourcekey="tlbItemDelete_TlbPreCard"
                            TextImageSpacing="5" />
                        <ComponentArt:ToolBarItem ID="tlbItemHelp_TlbPreCard" runat="server" DropDownImageHeight="16px"
                            DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="help.gif" ImageWidth="16px"
                            ItemType="Command" meta:resourcekey="tlbItemHelp_TlbPreCard" TextImageSpacing="5"
                            ClientSideCommand="tlbItemHelp_TlbPreCard_onClick();" />
                        <ComponentArt:ToolBarItem ID="tlbItemSave_TlbPreCard" runat="server" DropDownImageHeight="16px"
                            ClientSideCommand="tlbItemSave_TlbPreCard_onClick();" DropDownImageWidth="16px"
                            Enabled="false" ImageHeight="16px" ImageUrl="save_silver.png" ImageWidth="16px"
                            ItemType="Command" meta:resourcekey="tlbItemSave_TlbPreCard" TextImageSpacing="5" />
                        <ComponentArt:ToolBarItem ID="tlbItemCancel_TlbPreCard" runat="server" DropDownImageHeight="16px"
                            DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="cancel_silver.png" ImageWidth="16px"
                            ItemType="Command" meta:resourcekey="tlbItemCancel_TlbPreCard" TextImageSpacing="5"
                            ClientSideCommand="tlbItemCancel_TlbPreCard_onClick();" Enabled="false" />
                        <ComponentArt:ToolBarItem ID="tlbItemFormReconstruction_TlbPreCard" runat="server"
                            ClientSideCommand="tlbItemFormReconstruction_TlbPreCard_onClick();" DropDownImageHeight="16px"
                            DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="refresh.png" ImageWidth="16px"
                            ItemType="Command" meta:resourcekey="tlbItemFormReconstruction_TlbPreCard" TextImageSpacing="5" />
                        <ComponentArt:ToolBarItem ID="tlbItemExit_TlbPreCard" runat="server" DropDownImageHeight="16px"
                            ClientSideCommand="tlbItemExit_TlbPreCard_onClick();" DropDownImageWidth="16px"
                            ImageHeight="16px" ImageUrl="exit.png" ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemExit_TlbPreCard"
                            TextImageSpacing="5" />
                    </Items>
                </ComponentArt:ToolBar>
            </td>
            <td id="ActionMode_PreCard" class="ToolbarMode">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height: 60%">
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 70%">
                            <table style="width: 100%;" class="BoxStyle">
                                <tr>
                                    <td style="color: White; width: 100%">
                                        <table style="width: 100%">
                                            <tr>
                                                <td id="header_PreCards_PreCard" class="HeaderLabel" style="width: 50%">
                                                    PreCarrds
                                                </td>
                                                <td id="loadingPanel_GridPreCards_PreCard" class="HeaderLabel" style="width: 45%">
                                                </td>
                                                <td id="Td1" runat="server" style="width: 5%" meta:resourcekey="InverseAlignObj">
                                                    <ComponentArt:ToolBar ID="TlbRefresh_GridPreCards_PreCard" runat="server" CssClass="toolbar"
                                                        DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                                                        DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                                                        DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText"
                                                        ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                                                        <Items>
                                                            <ComponentArt:ToolBarItem ID="tlbItemRefresh_TlbRefresh_GridPreCards_PreCard" runat="server"
                                                                ClientSideCommand="Refresh_GridPreCards_PreCard();" DropDownImageHeight="16px"
                                                                DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="refresh.png" ImageWidth="16px"
                                                                ItemType="Command" meta:resourcekey="tlbItemRefresh_TlbRefresh_GridPreCards_PreCard"
                                                                TextImageSpacing="5" />
                                                        </Items>
                                                    </ComponentArt:ToolBar>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100%">
                                        <ComponentArt:CallBack runat="server" ID="CallBack_GridPreCards_PreCard" OnCallback="CallBack_GridPreCards_PreCard_onCallBack">
                                            <Content>
                                                <ComponentArt:DataGrid ID="GridPreCards_PreCard" runat="server" CssClass="Grid" EnableViewState="true"
                                                    FillContainer="true" FooterCssClass="GridFooter" ImagesBaseUrl="images/Grid/"
                                                    PagePaddingEnabled="true" PagerTextCssClass="GridFooterText" PageSize="14" RunningMode="Client"
                                                    SearchTextCssClass="GridHeaderText" Width="100%" AllowMultipleSelect="false"
                                                    ShowFooter="false" AllowColumnResizing="false" ScrollBar="On" ScrollTopBottomImagesEnabled="true"
                                                    ScrollTopBottomImageHeight="2" ScrollTopBottomImageWidth="16" ScrollImagesFolderUrl="images/Grid/scroller/"
                                                    ScrollButtonWidth="16" ScrollButtonHeight="17" ScrollBarCssClass="ScrollBar"
                                                    ScrollGripCssClass="ScrollGrip" ScrollBarWidth="16">
                                                    <Levels>
                                                        <ComponentArt:GridLevel AlternatingRowCssClass="AlternatingRow" DataCellCssClass="DataCell"
                                                            DataKeyField="ID" HeadingCellCssClass="HeadingCell" HeadingTextCssClass="HeadingCellText"
                                                            RowCssClass="Row" SelectedRowCssClass="SelectedRow" SelectorCellCssClass="SelectorCell"
                                                            SortAscendingImageUrl="asc.gif" SortDescendingImageUrl="desc.gif" SortImageHeight="5"
                                                            SortImageWidth="9">
                                                            <Columns>
                                                                <ComponentArt:GridColumn DataField="ID" Visible="false" />
                                                                <ComponentArt:GridColumn Align="Center" DataField="Active" DefaultSortDirection="Descending"
                                                                    HeadingTextCssClass="HeadingText" ColumnType="CheckBox" meta:resourcekey="clmnActive_GridPreCard_PreCard" />
                                                                <ComponentArt:GridColumn Align="Center" DataField="Code" DefaultSortDirection="Descending"
                                                                    HeadingTextCssClass="HeadingText" meta:resourcekey="clmnPreCardCode_GridPreCard_PreCard" />
                                                                <ComponentArt:GridColumn Align="Center" DataField="Name" DefaultSortDirection="Descending"
                                                                    HeadingTextCssClass="HeadingText" meta:resourcekey="clmnPreCardName_GridPreCard_PreCard" />
                                                                <ComponentArt:GridColumn Visible="false" DataField="PrecardGroup.ID" />
                                                                <ComponentArt:GridColumn Align="Center" DataField="PrecardGroup.Name" DefaultSortDirection="Descending"
                                                                    HeadingTextCssClass="HeadingText" meta:resourcekey="clmnPreCardType_GridPreCard_PreCard" />
                                                                <ComponentArt:GridColumn Align="Center" ColumnType="CheckBox" DataField="IsDaily"
                                                                    DefaultSortDirection="Descending" HeadingTextCssClass="HeadingText" meta:resourcekey="clmnDaily_GridPreCard_PreCard" />
                                                                <ComponentArt:GridColumn Align="Center" ColumnType="CheckBox" DataField="IsHourly"
                                                                    DefaultSortDirection="Descending" HeadingTextCssClass="HeadingText" meta:resourcekey="clmnHourly_GridPreCard_PreCard" />
                                                                <ComponentArt:GridColumn Align="Center" ColumnType="CheckBox" DataField="IsPermit"
                                                                    DefaultSortDirection="Descending" HeadingTextCssClass="HeadingText" meta:resourcekey="clmnJustification_GridPreCard_PreCard" />
                                                            </Columns>
                                                        </ComponentArt:GridLevel>
                                                    </Levels>
                                                    <ClientEvents>
                                                        <Load EventHandler="GridPreCards_PreCard_onLoad" />
                                                        <ItemSelect EventHandler="GridPreCards_PreCard_onItemSelect" />
                                                    </ClientEvents>
                                                </ComponentArt:DataGrid>
                                                <asp:HiddenField runat="server" ID="ErrorHiddenField_PreCards" />
                                            </Content>
                                            <ClientEvents>
                                                <CallbackComplete EventHandler="CallBack_GridPreCards_PreCard_onCallbackComplete" />
                                                <CallbackError EventHandler="CallBack_GridPreCards_PreCard_onCallbackError" />
                                            </ClientEvents>
                                        </ComponentArt:CallBack>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 30%" valign="middle" align="center">
                            <table style="width: 80%;" class="BoxStyle" id="tblPreCards_PreCard">
                                <tr runat="server" meta:resourcekey="AlignObj">
                                    <td class="DetailsBoxHeaderStyle">
                                        <div id="header_tblPreCards_PreCard" runat="server" meta:resourcekey="AlignObj" style="color: White; width: 100%; height: 100%" class="BoxContainerHeader">                                            
                                            PreCard Details</div>
                                    </td>
                                </tr>
                                <tr runat="server" meta:resourcekey="AlignObj">
                                    <td>
                                        <table style="width: 100%;">
                                            <tr>
                                                <td style="width: 5%">
                                                    <input id="chbActivePreCard_PreCard" type="checkbox" disabled="disabled" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblActivePreCard_PreCard" runat="server" Text="فعال" CssClass="WhiteLabel"
                                                        meta:resourcekey="lblActivePreCard_PreCard"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server" meta:resourcekey="AlignObj">
                                    <td>
                                        <asp:Label ID="lblPreCardCode_PreCard" runat="server" meta:resourcekey="lblPreCardCode_PreCard"
                                            Text=": کد پیش کارت " CssClass="WhiteLabel"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="Tr2" runat="server" meta:resourcekey="AlignObj">
                                    <td>
                                        <input type="text" runat="server" class="TextBoxes" id="txtPreCardCode_PreCard" style="width: 97%"
                                            disabled="disabled" />
                                    </td>
                                </tr>
                                <tr id="Tr3" runat="server" meta:resourcekey="AlignObj">
                                    <td>
                                        <asp:Label ID="lblPreCardName_PreCard" runat="server" meta:resourcekey="lblPreCardName_PreCard"
                                            Text=": نام پیش کارت " CssClass="WhiteLabel"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="Tr4" runat="server" meta:resourcekey="AlignObj">
                                    <td>
                                        <input type="text" runat="server" style="width: 97%;" class="TextBoxes" id="txtPreCardName_PreCard"
                                            disabled="disabled" />
                                    </td>
                                </tr>
                                <tr id="Tr5" runat="server" meta:resourcekey="AlignObj">
                                    <td>
                                        <asp:Label ID="lblPreCardType_PreCard" runat="server" meta:resourcekey="lblPreCardType_PreCard"
                                            Text=": نوع پیش کارت" CssClass="WhiteLabel"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="Tr6" runat="server" meta:resourcekey="AlignObj">
                                    <td>
                                        <ComponentArt:CallBack ID="CallBack_cmbPreCardType_PreCard" runat="server" OnCallback="CallBack_cmbPreCardType_PreCard_onCallBack"
                                            Height="26">
                                            <Content>
                                                <ComponentArt:ComboBox ID="cmbPreCardType_PreCard" runat="server" AutoComplete="true"
                                                    AutoFilter="true" AutoHighlight="false" CssClass="comboBox" DropDownCssClass="comboDropDown"
                                                    DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                    DataTextField="Name" DataValueField="ID" DropImageUrl="Images/ComboBox/ddn.png"
                                                    Enabled="false" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                    ItemCssClass="comboItem" ItemHoverCssClass="comboItemHover" SelectedItemCssClass="comboItemHover"
                                                    Style="width: 100%" TextBoxCssClass="comboTextBox">
                                                    <ClientEvents>
                                                        <Expand EventHandler="cmbPreCardType_PreCard_onExpand" />
                                                        <Collapse EventHandler="cmbPreCardType_PreCard_onCollapse" />
                                                    </ClientEvents>
                                                </ComponentArt:ComboBox>
                                                <asp:HiddenField ID="ErrorHiddenField_PreCardType" runat="server" />
                                            </Content>
                                            <ClientEvents>
                                                <BeforeCallback EventHandler="CallBack_cmbPreCardType_PreCard_onBeforeCallback" />
                                                <CallbackComplete EventHandler="CallBack_cmbPreCardType_PreCard_onCallbackComplete" />
                                            </ClientEvents>
                                        </ComponentArt:CallBack>
                                    </td>
                                </tr>
                                <tr id="Tr7" runat="server" meta:resourcekey="AlignObj">
                                    <td>
                                        <table style="width: 100%;">
                                            <tr>
                                                <td style="width: 5%">
                                                    <input id="rdbDaily_PreCard" type="radio" name="DurationType" disabled="disabled" />
                                                </td>
                                                <td style="width: 45%">
                                                    <asp:Label ID="lblDaily_PreCard" runat="server" meta:resourcekey="lblDaily_PreCard"
                                                        Text="روزانه" CssClass="WhiteLabel"></asp:Label>
                                                </td>
                                                <td style="width: 5%">
                                                    <input id="rdbHourly_PreCard" type="radio" name="DurationType" disabled="disabled" />
                                                </td>
                                                <td style="width: 45%">
                                                    <asp:Label ID="lblHourly_PreCard" runat="server" meta:resourcekey="lblHourly_PreCard"
                                                        Text="ساعتی" CssClass="WhiteLabel"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server" meta:resourcekey="AlignObj">
                                    <td>
                                        <table style="width: 100%;">
                                            <tr>
                                                <td style="width: 5%">
                                                    <input id="chbJustification_PreCard" type="checkbox" disabled="disabled" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblJustification_PreCard" runat="server" Text=": مجوز" CssClass="WhiteLabel"
                                                        meta:resourcekey="lblJustification_PreCard"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <ComponentArt:Dialog ModalMaskImage="Images/Dialog/alpha.png" HeaderCssClass="headerCss"
        Modal="true" AllowResize="false" AllowDrag="false" Alignment="MiddleCentre" ID="DialogConfirm"
        runat="server" Width="280px">
        <Content>
            <table style="width: 100%;" class="ConfirmStyle">
                <tr align="center">
                    <td colspan="2">
                        <asp:Label ID="lblConfirm" runat="server" CssClass="WhiteLabel"></asp:Label>
                    </td>
                </tr>
                <tr align="center">
                    <td style="width: 50%">
                        <ComponentArt:ToolBar ID="TlbOkConfirm" runat="server" CssClass="toolbar" DefaultItemActiveCssClass="itemActive"
                            DefaultItemCheckedCssClass="itemChecked" DefaultItemCheckedHoverCssClass="itemActive"
                            DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover" DefaultItemImageHeight="16px"
                            DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText" ImagesBaseUrl="images/ToolBar/"
                            ItemSpacing="1px" UseFadeEffect="false">
                            <Items>
                                <ComponentArt:ToolBarItem ID="tlbItemOk_TlbOkConfirm" runat="server" ClientSideCommand="tlbItemOk_TlbOkConfirm_onClick();"
                                    DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="save.png"
                                    ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemOk_TlbOkConfirm"
                                    TextImageSpacing="5" />
                            </Items>
                        </ComponentArt:ToolBar>
                    </td>
                    <td>
                        <ComponentArt:ToolBar ID="TlbCancelConfirm" runat="server" CssClass="toolbar" DefaultItemActiveCssClass="itemActive"
                            DefaultItemCheckedCssClass="itemChecked" DefaultItemCheckedHoverCssClass="itemActive"
                            DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover" DefaultItemImageHeight="16px"
                            DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText" ImagesBaseUrl="images/ToolBar/"
                            ItemSpacing="1px" UseFadeEffect="false">
                            <Items>
                                <ComponentArt:ToolBarItem ID="tlbItemCancel_TlbCancelConfirm" runat="server" ClientSideCommand="tlbItemCancel_TlbCancelConfirm_onClick();"
                                    DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="cancel.png"
                                    ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemCancel_TlbCancel"
                                    TextImageSpacing="5" />
                            </Items>
                        </ComponentArt:ToolBar>
                    </td>
                </tr>
            </table>
        </Content>
    </ComponentArt:Dialog>
    <asp:HiddenField runat="server" ID="hfheader_PreCards_PreCard" meta:resourcekey="hfheader_PreCards_PreCard" />
    <asp:HiddenField runat="server" ID="hfheader_tblPreCards_PreCard" meta:resourcekey="hfheader_tblPreCards_PreCard" />
    <asp:HiddenField runat="server" ID="hfloadingPanel_GridPreCards_PreCard" meta:resourcekey="hfloadingPanel_GridPreCards_PreCard" />
    <asp:HiddenField runat="server" ID="hfView_PreCard" meta:resourcekey="hfView_PreCard" />
    <asp:HiddenField runat="server" ID="hfAdd_PreCard" meta:resourcekey="hfAdd_PreCard" />
    <asp:HiddenField runat="server" ID="hfEdit_PreCard" meta:resourcekey="hfEdit_PreCard" />
    <asp:HiddenField runat="server" ID="hfDelete_PreCard" meta:resourcekey="hfDelete_PreCard" />
    <asp:HiddenField runat="server" ID="hfDeleteMessage_PreCard" meta:resourcekey="hfDeleteMessage_PreCard" />
    <asp:HiddenField runat="server" ID="hfCloseMessage_PreCard" meta:resourcekey="hfCloseMessage_PreCard" />
    <asp:HiddenField runat="server" ID="hfcmbAlarm_PreCard" meta:resourcekey="hfcmbAlarm_PreCard" />
    <asp:HiddenField runat="server" ID="hfErrorType_PreCard" meta:resourcekey="hfErrorType_PreCard" />
    <asp:HiddenField runat="server" ID="hfConnectionError_PreCard" meta:resourcekey="hfConnectionError_PreCard" />
    </form>
</body>
</html>
