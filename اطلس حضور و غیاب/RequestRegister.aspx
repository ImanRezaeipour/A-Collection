<%@ page language="C#" autoeventwireup="true" inherits="RequestRegister, App_Web_aaak0nyc" %>

<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<%@ Register Assembly="AspNetPersianDatePickup" Namespace="AspNetPersianDatePickup"
    TagPrefix="pcal" %>
<%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="MKB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Css/toolbar.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="Css/tabStyle.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="Css/multiPage.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="css/style.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="css/treeStyle.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/combobox.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/inputStyle.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/dialog.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/iframe.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/calendarStyle.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="css/tableStyle.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/mainpage.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/label.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/persianDatePicker.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="Css/gridStyle.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="css/alert_box.css" runat="server" type="text/css" rel="Stylesheet" />
    <title></title>
</head>
<body onkeydown="RequestRegister_onKeyDown(event);">
    <script type="text/javascript" src="JS/jquery.js"></script>
    <script type="text/javascript" src="JS/API/RequestRegister_onPageLoad.js"></script>
    <script type="text/javascript" src="JS/API/DialogRequestRegister_Operations.js"></script>
    <script type="text/javascript" src="JS/API/Alert_Box.js"></script>
    <form id="RequestRegisterForm" runat="server" meta:resourcekey="RequestRegisterForm">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table id="Mastertbl_RequestRegister" style="width: 100%;" class="BoxStyle">
        <tr>
            <td valign="top" id="Container_PersonnelSearch_RequestRegister">
                <table style="width: 70%;" id="PersonnelSearchBox_RequestRegister">
                    <tr>
                        <td>
                            <table runat="server" style="width: 100%;" id="Container_PersonnelSelect_RequestRegister">
                                <tr>
                                    <td style="width: 78%">
                                        <table style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPersonnel_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                        meta:resourcekey="lblPersonnel_RequestRegister" Text=": پرسنل"></asp:Label>
                                                </td>
                                                <td id="Td4" runat="server" meta:resourcekey="InverseAlignObj">
                                                    <ComponentArt:ToolBar ID="TlbPaging_PersonnelSearch_RequestRegister" runat="server"
                                                        CssClass="toolbar" DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                                                        DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                                                        DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageOnly"
                                                        DefaultItemTextImageSpacing="0" ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px"
                                                        Style="direction: ltr;" UseFadeEffect="false">
                                                        <Items>
                                                            <ComponentArt:ToolBarItem ID="tlbItemRefresh_TlbPaging_PersonnelSearch_RequestRegister"
                                                                runat="server" ClientSideCommand="tlbItemRefresh_TlbPaging_PersonnelSearch_RequestRegister_onClick();"
                                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="refresh.png"
                                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemRefresh_TlbPaging_PersonnelSearch_RequestRegister"
                                                                TextImageSpacing="5" />
                                                            <ComponentArt:ToolBarItem ID="tlbItemFirst_TlbPaging_PersonnelSearch_RequestRegister"
                                                                runat="server" ClientSideCommand="tlbItemFirst_TlbPaging_PersonnelSearch_RequestRegister_onClick();"
                                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="first.png"
                                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemFirst_TlbPaging_PersonnelSearch_RequestRegister"
                                                                TextImageSpacing="5" />
                                                            <ComponentArt:ToolBarItem ID="tlbItemBefore_TlbPaging_PersonnelSearch_RequestRegister"
                                                                runat="server" ClientSideCommand="tlbItemBefore_TlbPaging_PersonnelSearch_RequestRegister_onClick();"
                                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="Before.png"
                                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemBefore_TlbPaging_PersonnelSearch_RequestRegister"
                                                                TextImageSpacing="5" />
                                                            <ComponentArt:ToolBarItem ID="tlbItemNext_TlbPaging_PersonnelSearch_RequestRegister"
                                                                runat="server" ClientSideCommand="tlbItemNext_TlbPaging_PersonnelSearch_RequestRegister_onClick();"
                                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="Next.png"
                                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemNext_TlbPaging_PersonnelSearch_RequestRegister"
                                                                TextImageSpacing="5" />
                                                            <ComponentArt:ToolBarItem ID="tlbItemLast_TlbPaging_PersonnelSearch_RequestRegister"
                                                                runat="server" ClientSideCommand="tlbItemLast_TlbPaging_PersonnelSearch_RequestRegister_onClick();"
                                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="last.png"
                                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemLast_TlbPaging_PersonnelSearch_RequestRegister"
                                                                TextImageSpacing="5" />
                                                            <ComponentArt:ToolBarItem ID="tlbItemCollectiveTrrafic_TlbPaging_PersonnelSearch_RequestRegister"
                                                                runat="server" ClientSideCommand="tlbItemCollectiveTrrafic_TlbPaging_PersonnelSearch_RequestRegister_onClick();"
                                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="collection.png"
                                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemCollectiveTrrafic_TlbPaging_PersonnelSearch_RequestRegister"
                                                                TextImageSpacing="5" />
                                                        </Items>
                                                    </ComponentArt:ToolBar>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td id="headerPersonnelCount_RequestRegister" style="width: 22%">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ComponentArt:CallBack ID="CallBack_cmbPersonnel_RequestRegister" runat="server"
                                            OnCallback="CallBack_cmbPersonnel_RequestRegister_onCallBack" Height="26">
                                            <Content>
                                                <ComponentArt:ComboBox ID="cmbPersonnel_RequestRegister" runat="server" AutoComplete="true"
                                                    AutoHighlight="false" CssClass="comboBox" DataFields="BarCode" DataTextField="Name"
                                                    DropDownCssClass="comboDropDown" DropDownHeight="300" DropDownPageSize="10" DropDownWidth="400"
                                                    DropHoverImageUrl="Images/ComboBox/ddn-hover.png" DropImageUrl="Images/ComboBox/ddn.png"
                                                    FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover" ItemClientTemplateId="ItemTemplate_cmbPersonnel_RequestRegister"
                                                    ItemCssClass="comboItem" ItemHoverCssClass="comboItemHover" RunningMode="Client"
                                                    SelectedItemCssClass="comboItemHover" Style="width: 100%" TextBoxCssClass="comboTextBox">
                                                    <ClientTemplates>
                                                        <ComponentArt:ClientTemplate ID="ItemTemplate_cmbPersonnel_RequestRegister">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                <tr class="dataRow">
                                                                    <td class="dataCell" style="width: 40%">
                                                                        ## DataItem.getProperty('Text') ##
                                                                    </td>
                                                                    <td class="dataCell" style="width: 30%">
                                                                        ## DataItem.getProperty('BarCode') ##
                                                                    </td>
                                                                    <td class="dataCell" style="width: 30%">
                                                                        ## DataItem.getProperty('CardNum') ##
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ComponentArt:ClientTemplate>
                                                    </ClientTemplates>
                                                    <DropDownHeader>
                                                        <table border="0" cellpadding="0" cellspacing="0" width="400">
                                                            <tr class="headingRow">
                                                                <td id="clmnName_cmbPersonnel_RequestRegister" class="headingCell" style="width: 40%;
                                                                    text-align: center">
                                                                    Name And Family
                                                                </td>
                                                                <td id="clmnBarCode_cmbPersonnel_RequestRegister" class="headingCell" style="width: 30%;
                                                                    text-align: center">
                                                                    BarCode
                                                                </td>
                                                                <td id="clmnCardNum_cmbPersonnel_RequestRegister" class="headingCell" style="width: 30%;
                                                                    text-align: center">
                                                                    CardNum
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </DropDownHeader>
                                                    <ClientEvents>
                                                        <Expand EventHandler="cmbPersonnel_RequestRegister_onExpand" />
                                                        <Collapse EventHandler="cmbPersonnel_RequestRegister_onCollapse" />
                                                    </ClientEvents>
                                                </ComponentArt:ComboBox>
                                                <asp:HiddenField ID="ErrorHiddenField_Personnel_RequestRegister" runat="server" />
                                                <asp:HiddenField ID="hfPersonnelPageCount_RequestRegister" runat="server" />
                                                <asp:HiddenField ID="hfPersonnelCount_RequestRegister" runat="server" />
                                            </Content>
                                            <ClientEvents>
                                                <BeforeCallback EventHandler="CallBack_cmbPersonnel_RequestRegister_onBeforeCallback" />
                                                <CallbackComplete EventHandler="CallBack_cmbPersonnel_RequestRegister_onCallBackComplete" />
                                                <CallbackError EventHandler="CallBack_cmbPersonnel_RequestRegister_onCallbackError" />
                                            </ClientEvents>
                                        </ComponentArt:CallBack>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input id="txtPersonnelSearch_RequestRegister" runat="server" class="TextBoxes" onclick="this.select();"
                                            onfocus="this.select();" style="width: 99%" type="text" />
                                    </td>
                                    <td>
                                        <ComponentArt:ToolBar ID="TlbSearchPersonnel_RequestRegister" runat="server" CssClass="toolbar"
                                            DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                                            DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                                            DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText"
                                            ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                                            <Items>
                                                <ComponentArt:ToolBarItem ID="tlbItemSearch_TlbSearchPersonnel_RequestRegister" runat="server"
                                                    ClientSideCommand="tlbItemSearch_TlbSearchPersonnel_RequestRegister_onClick();"
                                                    DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="search.png"
                                                    ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemSearch_TlbSearchPersonnel_RequestRegister"
                                                    TextImageSpacing="5" />
                                            </Items>
                                        </ComponentArt:ToolBar>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        <ComponentArt:ToolBar ID="TlbAdvancedSearch_RequestRegister" runat="server" CssClass="toolbar"
                                            DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                                            DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                                            DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText"
                                            ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                                            <Items>
                                                <ComponentArt:ToolBarItem ID="tlbItemAdvancedSearch_TlbAdvancedSearch_RequestRegister"
                                                    runat="server" ClientSideCommand="tlbItemAdvancedSearch_TlbAdvancedSearch_RequestRegister_onClick();"
                                                    DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="eyeglasses.png"
                                                    ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemAdvancedSearch_TlbAdvancedSearch_RequestRegister"
                                                    TextImageSpacing="5" />
                                            </Items>
                                        </ComponentArt:ToolBar>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <ComponentArt:TabStrip ID="TabStripRequestRegister" runat="server" DefaultGroupTabSpacing="1"
                    DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook"
                    ImagesBaseUrl="images/TabStrip" MultiPageId="MultiPageRequestRegister" ScrollLeftLookId="ScrollItem"
                    ScrollRightLookId="ScrollItem" Width="100%">
                    <ItemLooks>
                        <ComponentArt:ItemLook CssClass="DefaultTab" HoverCssClass="DefaultTabHover" LabelPaddingBottom="4"
                            LabelPaddingLeft="15" LabelPaddingRight="15" LabelPaddingTop="4" LeftIconHeight="22"
                            LeftIconUrl="tab_left_icon.gif" LeftIconWidth="13" LookId="DefaultTabLook" meta:resourcekey="DefaultTabLook"
                            RightIconHeight="22" RightIconUrl="tab_right_icon.gif" RightIconWidth="13" />
                        <ComponentArt:ItemLook CssClass="SelectedTab" LabelPaddingBottom="4" LabelPaddingLeft="15"
                            LabelPaddingRight="15" LabelPaddingTop="4" LeftIconHeight="22" LeftIconUrl="selected_tab_left_icon.gif"
                            LeftIconWidth="13" LookId="SelectedTabLook" meta:resourcekey="SelectedTabLook"
                            RightIconHeight="22" RightIconUrl="selected_tab_right_icon.gif" RightIconWidth="13" />
                        <ComponentArt:ItemLook CssClass="ScrollItem" HoverCssClass="ScrollItemHover" LabelPaddingBottom="0"
                            LabelPaddingLeft="5" LabelPaddingRight="5" LabelPaddingTop="0" LookId="ScrollItem" />
                    </ItemLooks>
                    <Tabs>
                        <ComponentArt:TabStripTab ID="tbHourly_TabStripRequestRegister" meta:resourcekey="tbHourly_TabStripRequestRegister"
                            Text="ساعتی" Value="Hourly">
                        </ComponentArt:TabStripTab>
                        <ComponentArt:TabStripTab ID="tbDaily_TabStripRequestRegister" meta:resourcekey="tbDaily_TabStripRequestRegister"
                            Text="روزانه" Value="Daily">
                        </ComponentArt:TabStripTab>
                        <ComponentArt:TabStripTab ID="tbOvertime_TabStripRequestRegister" meta:resourcekey="tbOvertime_TabStripRequestRegister"
                            Text="اضافه کار" Value="OverTime">
                        </ComponentArt:TabStripTab>
                    </Tabs>
                    <ClientEvents>
                        <TabSelect EventHandler="TabStripRequestRegister_onTabSelect" />
                    </ClientEvents>
                </ComponentArt:TabStrip>
                <ComponentArt:MultiPage ID="MultiPageRequestRegister" runat="server" CssClass="MultiPage"
                    Width="780">
                    <ComponentArt:PageView CssClass="PageContent" runat="server" ID="pgvHourly_DialogRequestRegister"
                        Visible="true">
                        <table class="BoxStyle" style="width: 100%; font-family: Arial; font-size: small;">
                            <tr>
                                <td colspan="3">
                                    <ComponentArt:ToolBar ID="TlbHourly" runat="server" CssClass="toolbar" DefaultItemActiveCssClass="itemActive"
                                        DefaultItemCheckedCssClass="itemChecked" DefaultItemCheckedHoverCssClass="itemActive"
                                        DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover" DefaultItemImageHeight="16px"
                                        DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText" DefaultItemTextImageSpacing="0"
                                        ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                                        <Items>
                                            <ComponentArt:ToolBarItem ID="tlbItemEndorsement_TlbHourly" runat="server" ClientSideCommand="tlbItemEndorsement_TlbHourly_onClick();"
                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="save.png"
                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemEndorsement_TlbHourly"
                                                TextImageSpacing="5" />
                                            <ComponentArt:ToolBarItem ID="tlbItemFormReconstruction_TlbHourly" runat="server"
                                                ClientSideCommand="tlbItemFormReconstruction_TlbHourly_onClick();" DropDownImageHeight="16px"
                                                DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="refresh.png" ImageWidth="16px"
                                                ItemType="Command" meta:resourcekey="tlbItemFormReconstruction_TlbHourly" TextImageSpacing="5" />
                                            <ComponentArt:ToolBarItem ID="tlbItemExit_TlbHourly" runat="server" ClientSideCommand="tlbItemExit_TlbHourly_onClick();"
                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="exit.png"
                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemExit_TlbHourly"
                                                TextImageSpacing="5" />
                                        </Items>
                                    </ComponentArt:ToolBar>
                                </td>
                            </tr>
                            <tr id="Tr1" runat="server">
                                <td colspan="2">
                                    <asp:Label ID="lblRequestType_tbHourly_RequestRegister" runat="server" CssClass="WhiteLabel"
                                        meta:resourcekey="lblRequesType_tbHourly_RequestRegister" Text=": نوع درخواست"></asp:Label>
                                </td>
                                <td id="Td3" runat="server" meta:resourcekey="InverseAlignObj" rowspan="3" style="width: 40%"
                                    valign="top">
                                    <table class="BoxStyle" style="width: 95%; border: 1px outset black">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblIllnesses_tbHourly_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                    meta:resourcekey="lblIllnesses_tbHourly_RequestRegister" Text=": نام بیماری"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="Tr3" runat="server" meta:resourcekey="AlignObj">
                                            <td id="Container_cmbIllnesses_tbHourly_RequestRegister">
                                                <ComponentArt:CallBack ID="CallBack_cmbIllnesses_tbHourly_RequestRegister" runat="server"
                                                    OnCallback="CallBack_cmbIllnesses_tbHourly_RequestRegister_onCallback" Height="26">
                                                    <Content>
                                                        <ComponentArt:ComboBox ID="cmbIllnesses_tbHourly_RequestRegister" runat="server"
                                                            AutoComplete="true" AutoFilter="true" AutoHighlight="false" CssClass="comboBox"
                                                            DropDownCssClass="comboDropDown" DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                            DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                            ItemCssClass="comboItem" ItemHoverCssClass="comboItemHover" SelectedItemCssClass="comboItemHover"
                                                            Style="width: 100%; visibility: hidden" TextBoxCssClass="comboTextBox" TextBoxEnabled="false">
                                                            <ClientEvents>
                                                                <Expand EventHandler="cmbIllnesses_tbHourly_RequestRegister_onExpand" />
                                                                <Collapse EventHandler="cmbIllnesses_tbHourly_RequestRegister_onCollapse" />
                                                            </ClientEvents>
                                                        </ComponentArt:ComboBox>
                                                        <asp:HiddenField ID="ErrorHiddenField_Illnesses_tbHourly_RequestRegister" runat="server" />
                                                    </Content>
                                                    <ClientEvents>
                                                        <BeforeCallback EventHandler="CallBack_cmbIllnesses_tbHourly_RequestRegister_onBeforeCallback" />
                                                        <CallbackComplete EventHandler="CallBack_cmbIllnesses_tbHourly_RequestRegister_onCallbackComplete" />
                                                        <CallbackError EventHandler="CallBack_cmbIllnesses_tbHourly_RequestRegister_onCallbackError" />
                                                    </ClientEvents>
                                                </ComponentArt:CallBack>
                                            </td>
                                        </tr>
                                        <tr id="Tr4" runat="server" meta:resourcekey="AlignObj">
                                            <td>
                                                <asp:Label ID="lblDoctors_tbHourly_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                    meta:resourcekey="lblDoctors_tbHourly_RequestRegister" Text=": نام دکتر"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="Tr5" runat="server" meta:resourcekey="AlignObj">
                                            <td id="Container_cmbDoctors_tbHourly_RequestRegister">
                                                <ComponentArt:CallBack ID="CallBack_cmbDoctors_tbHourly_RequestRegister" runat="server"
                                                    OnCallback="CallBack_cmbDoctors_tbHourly_RequestRegister_onCallback" Height="26">
                                                    <Content>
                                                        <ComponentArt:ComboBox ID="cmbDoctors_tbHourly_RequestRegister" runat="server" AutoComplete="true"
                                                            AutoFilter="true" AutoHighlight="false" CssClass="comboBox" DropDownCssClass="comboDropDown"
                                                            DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                            DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                            ItemCssClass="comboItem" ItemHoverCssClass="comboItemHover" SelectedItemCssClass="comboItemHover"
                                                            Style="width: 100%" TextBoxCssClass="comboTextBox" TextBoxEnabled="false">
                                                            <ClientEvents>
                                                                <Expand EventHandler="cmbDoctors_tbHourly_RequestRegister_onExpand" />
                                                                <Collapse EventHandler="cmbDoctors_tbHourly_RequestRegister_onCollapse" />
                                                            </ClientEvents>
                                                        </ComponentArt:ComboBox>
                                                        <asp:HiddenField ID="ErrorHiddenField_Doctors_tbHourly_RequestRegister" runat="server" />
                                                    </Content>
                                                    <ClientEvents>
                                                        <BeforeCallback EventHandler="CallBack_cmbDoctors_tbHourly_RequestRegister_onBeforeCallback" />
                                                        <CallbackComplete EventHandler="CallBack_cmbDoctors_tbHourly_RequestRegister_onCallbackComplete" />
                                                        <CallbackError EventHandler="CallBack_cmbDoctors_tbHourly_RequestRegister_onCallbackError" />
                                                    </ClientEvents>
                                                </ComponentArt:CallBack>
                                            </td>
                                        </tr>
                                        <tr id="Tr6" runat="server" meta:resourcekey="AlignObj">
                                            <td>
                                                <asp:Label ID="lblMissionLocation_tbHourly_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                    meta:resourcekey="lblMissionLocation_tbHourly_RequestRegister" Text=": محل ماموریت"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="Tr18" runat="server" meta:resourcekey="AlignObj">
                                            <td id="Container_cmbMissionLocation_tbHourly_RequestRegister">
                                                <ComponentArt:CallBack ID="CallBack_cmbMissionLocation_tbHourly_RequestRegister"
                                                    runat="server" OnCallback="CallBack_cmbMissionLocation_tbHourly_RequestRegister_onCallback"
                                                    Height="26">
                                                    <Content>
                                                        <ComponentArt:ComboBox ID="cmbMissionLocation_tbHourly_RequestRegister" runat="server"
                                                            AutoComplete="true" AutoFilter="true" AutoHighlight="false" CssClass="comboBox"
                                                            DropDownCssClass="comboDropDown" DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                            DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                            ItemCssClass="comboItem" ItemHoverCssClass="comboItemHover" SelectedItemCssClass="comboItemHover"
                                                            Style="width: 100%" TextBoxCssClass="comboTextBox" TextBoxEnabled="false" DropDownHeight="200">
                                                            <DropDownContent>
                                                                <ComponentArt:TreeView ID="trvMissionLocation_tbHourly_RequestRegister" runat="server"
                                                                    CollapseImageUrl="images/TreeView/exp.gif" CssClass="TreeView" DefaultImageHeight="16"
                                                                    DefaultImageWidth="16" DragAndDropEnabled="false" EnableViewState="false" ExpandCollapseImageHeight="15"
                                                                    ExpandCollapseImageWidth="17" ExpandImageUrl="images/TreeView/col.gif" Height="95%"
                                                                    HoverNodeCssClass="HoverTreeNode" ItemSpacing="2" KeyboardEnabled="true" LineImageHeight="20"
                                                                    LineImageWidth="19" meta:resourcekey="trvMissionLocation_tbHourly_RequestRegister"
                                                                    NodeCssClass="TreeNode" NodeEditCssClass="NodeEdit" NodeIndent="17" NodeLabelPadding="3"
                                                                    SelectedNodeCssClass="SelectedTreeNode" ShowLines="true" Width="100%">
                                                                    <ClientEvents>
                                                                        <NodeSelect EventHandler="trvMissionLocation_tbHourly_RequestRegister_onNodeSelect" />
                                                                    </ClientEvents>
                                                                </ComponentArt:TreeView>
                                                            </DropDownContent>
                                                            <ClientEvents>
                                                                <Expand EventHandler="cmbMissionLocation_tbHourly_RequestRegister_onExpand" />
                                                                <Collapse EventHandler="cmbMissionLocation_tbHourly_RequestRegister_onCollapse" />
                                                            </ClientEvents>
                                                        </ComponentArt:ComboBox>
                                                        <asp:HiddenField ID="ErrorHiddenField_MissionLocations_tbHourly_RequestRegister"
                                                            runat="server" />
                                                    </Content>
                                                    <ClientEvents>
                                                        <BeforeCallback EventHandler="CallBack_cmbMissionLocation_tbHourly_RequestRegister_onBeforeCallback" />
                                                        <CallbackComplete EventHandler="CallBack_cmbMissionLocation_tbHourly_RequestRegister_onCallbackComplete" />
                                                        <CallbackError EventHandler="CallBack_cmbMissionLocation_tbHourly_RequestRegister_onCallbackError" />
                                                    </ClientEvents>
                                                </ComponentArt:CallBack>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="Tr19" runat="server">
                                <td colspan="2">
                                    <ComponentArt:CallBack ID="CallBack_cmbRequestType_tbHourly_RequestRegister" runat="server"
                                        OnCallback="CallBack_cmbRequestType_tbHourly_RequestRegister_onCallback" Height="26">
                                        <Content>
                                            <ComponentArt:ComboBox ID="cmbRequestType_tbHourly_RequestRegister" runat="server"
                                                AutoComplete="true" AutoFilter="true" AutoHighlight="false" CssClass="comboBox"
                                                DropDownCssClass="comboDropDown" DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                ItemCssClass="comboItem" ItemHoverCssClass="comboItemHover" SelectedItemCssClass="comboItemHover"
                                                Style="width: 100%" TextBoxCssClass="comboTextBox" TextBoxEnabled="false">
                                                <ClientEvents>
                                                    <Change EventHandler="cmbRequestType_tbHourly_RequestRegister_onChange" />
                                                    <Expand EventHandler="cmbRequestType_tbHourly_RequestRegister_onExpand" />
                                                    <Collapse EventHandler="cmbRequestType_tbHourly_RequestRegister_onCollapse" />
                                                </ClientEvents>
                                            </ComponentArt:ComboBox>
                                            <asp:HiddenField ID="ErrorHiddenField_RequestTypes_tbHourly_RequestRegister" runat="server" />
                                        </Content>
                                        <ClientEvents>
                                            <BeforeCallback EventHandler="CallBack_cmbRequestType_tbHourly_RequestRegister_onBeforeCallback" />
                                            <CallbackComplete EventHandler="CallBack_cmbRequestType_tbHourly_RequestRegister_onCallbackComplete" />
                                            <CallbackError EventHandler="CallBack_cmbRequestType_tbHourly_RequestRegister_onCallbackError" />
                                        </ClientEvents>
                                    </ComponentArt:CallBack>
                                </td>
                            </tr>
                            <tr id="Tr20" runat="server">
                                <td colspan="2">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 50%">
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblFromHour_tbHourly_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                                meta:resourcekey="lblFromHour_tbHourly_RequestRegister" Text=": از ساعت"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <MKB:TimeSelector ID="TimeSelector_FromHour_tbHourly_RequestRegister" runat="server"
                                                                DisplaySeconds="true" MinuteIncrement="1" SelectedTimeFormat="TwentyFour" Style="direction: ltr;"
                                                                Visible="true">
                                                            </MKB:TimeSelector>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblToHour_tbHourly_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                                meta:resourcekey="lblToHour_tbHourly_RequestRegister" Text=": تا ساعت"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <MKB:TimeSelector ID="TimeSelector_ToHour_tbHourly_RequestRegister" runat="server"
                                                                DisplaySeconds="true" MinuteIncrement="1" SelectedTimeFormat="TwentyFour" Style="direction: ltr;"
                                                                Visible="true">
                                                            </MKB:TimeSelector>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="top">
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td>
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblRequestDate_tbHourly_RequestRegister"
                                                                runat="server" CssClass="WhiteLabel" meta:resourcekey="lblRequestDate_tbHourly_RequestRegister"
                                                                Text=": تاریخ درخواست"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server" meta:resourcekey="InverseAlignObj">
                                                        <td id="Container_RequestDateCalendars_tbHourly_RequestRegister">
                                                            <table runat="server" id="Container_pdpRequestDate_tbHourly_RequestRegister" visible="false"
                                                                style="width: 100%">
                                                                <tr>
                                                                    <td>
                                                                        <pcal:PersianDatePickup ID="pdpRequestDate_tbHourly_RequestRegister" runat="server"
                                                                            CssClass="PersianDatePicker" ReadOnly="true"></pcal:PersianDatePickup>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="Container_gdpRequestDate_tbHourly_RequestRegister" visible="false"
                                                                style="width: 100%">
                                                                <tr>
                                                                    <td>
                                                                        <table id="Container_gCalRequestDate_tbHourly_RequestRegister" border="0" cellpadding="0"
                                                                            cellspacing="0">
                                                                            <tr>
                                                                                <td onmouseup="btn_gdpRequestDate_tbHourly_RequestRegister_OnMouseUp(event)">
                                                                                    <ComponentArt:Calendar ID="gdpRequestDate_tbHourly_RequestRegister" runat="server"
                                                                                        ControlType="Picker" MaxDate="2122-1-1" PickerCssClass="picker" PickerCustomFormat="yyyy/MM/dd"
                                                                                        PickerFormat="Custom" SelectedDate="2008-1-1">
                                                                                        <ClientEvents>
                                                                                            <SelectionChanged EventHandler="gdpRequestDate_tbHourly_RequestRegister_OnDateChange" />
                                                                                        </ClientEvents>
                                                                                    </ComponentArt:Calendar>
                                                                                </td>
                                                                                <td style="font-size: 10px;">
                                                                                    &nbsp;
                                                                                </td>
                                                                                <td>
                                                                                    <img id="btn_gdpRequestDate_tbHourly_RequestRegister" alt="" class="calendar_button"
                                                                                        onclick="btn_gdpRequestDate_tbHourly_RequestRegister_OnClick(event)" onmouseup="btn_gdpRequestDate_tbHourly_RequestRegister_OnMouseUp(event)"
                                                                                        src="Images/Calendar/btn_calendar.gif" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <ComponentArt:Calendar ID="gCalRequestDate_tbHourly_RequestRegister" runat="server"
                                                                            AllowMonthSelection="false" AllowMultipleSelection="false" AllowWeekSelection="false"
                                                                            CalendarCssClass="calendar" CalendarTitleCssClass="title" ControlType="Calendar"
                                                                            DayCssClass="day" DayHeaderCssClass="dayheader" DayHoverCssClass="dayhover" DayNameFormat="FirstTwoLetters"
                                                                            ImagesBaseUrl="Images/Calendar" MaxDate="2122-1-1" MonthCssClass="month" NextImageUrl="cal_nextMonth.gif"
                                                                            NextPrevCssClass="nextprev" OtherMonthDayCssClass="othermonthday" PopUp="Custom"
                                                                            PopUpExpandControlId="btn_gdpRequestDate_tbHourly_RequestRegister" PrevImageUrl="cal_prevMonth.gif"
                                                                            SelectedDate="2008-1-1" SelectedDayCssClass="selectedday" SwapDuration="300"
                                                                            SwapSlide="Linear" VisibleDate="2008-1-1">
                                                                            <ClientEvents>
                                                                                <SelectionChanged EventHandler="gCalRequestDate_tbHourly_RequestRegister_OnChange" />
                                                                                <Load EventHandler="gCalRequestDate_tbHourly_RequestRegister_OnLoad" />
                                                                            </ClientEvents>
                                                                        </ComponentArt:Calendar>
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
                            <tr>
                                <td>
                                    <asp:Label ID="lblDescription_tbHourly_RequestRegister" runat="server" CssClass="WhiteLabel"
                                        meta:resourcekey="lblDescription_tbHourly_RequestRegister" Text=": توضیحات"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <textarea id="txtDescription_tbHourly_RequestRegister" class="TextBoxes" cols="20"
                                        name="S1" rows="3" style="width: 99%; height: 160px;"></textarea>
                                </td>
                            </tr>
                        </table>
                    </ComponentArt:PageView>
                    <ComponentArt:PageView CssClass="PageContent" runat="server" ID="pgvDaily_DialogRequestRegister"
                        Visible="true">
                        <table class="BoxStyle" style="width: 100%; font-family: Arial; font-size: small;">
                            <tr>
                                <td colspan="3">
                                    <ComponentArt:ToolBar ID="TlbDaily" runat="server" CssClass="toolbar" DefaultItemActiveCssClass="itemActive"
                                        DefaultItemCheckedCssClass="itemChecked" DefaultItemCheckedHoverCssClass="itemActive"
                                        DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover" DefaultItemImageHeight="16px"
                                        DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText" DefaultItemTextImageSpacing="0"
                                        ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                                        <Items>
                                            <ComponentArt:ToolBarItem ID="tlbItemEndorsement_TlbDaily" runat="server" ClientSideCommand="tlbItemEndorsement_TlbDaily_onClick();"
                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="save.png"
                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemEndorsement_TlbDaily"
                                                TextImageSpacing="5" />
                                            <ComponentArt:ToolBarItem ID="tlbItemFormReconstruction_TlbDaily" runat="server"
                                                ClientSideCommand="tlbItemFormReconstruction_TlbDaily_onClick();" DropDownImageHeight="16px"
                                                DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="refresh.png" ImageWidth="16px"
                                                ItemType="Command" meta:resourcekey="tlbItemFormReconstruction_TlbDaily" TextImageSpacing="5" />
                                            <ComponentArt:ToolBarItem ID="tlbItemExit_TlbDaily" runat="server" ClientSideCommand="tlbItemExit_TlbDaily_onClick();"
                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="exit.png"
                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemExit_TlbDaily"
                                                TextImageSpacing="5" />
                                        </Items>
                                    </ComponentArt:ToolBar>
                                </td>
                            </tr>
                            <tr id="Tr7" runat="server">
                                <td colspan="2">
                                    <asp:Label ID="lblRequesType_tbDaily_RequestRegister" runat="server" CssClass="WhiteLabel"
                                        meta:resourcekey="lblRequesType_tbDaily_RequestRegister" Text=": نوع درخواست"></asp:Label>
                                </td>
                                <td id="Td1" runat="server" meta:resourcekey="InverseAlignObj" rowspan="3" style="width: 40%"
                                    valign="top">
                                    <table class="BoxStyle" style="width: 95%; border: 1px outset black">
                                        <tr id="Tr8" runat="server" meta:resourcekey="AlignObj">
                                            <td>
                                                <asp:Label ID="lblIllnesses_tbDaily_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                    meta:resourcekey="lblIllnesses_tbDaily_RequestRegister" Text=": نام بیماری"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="Tr9" runat="server" meta:resourcekey="AlignObj">
                                            <td id="Container_cmbIllnesses_tbDaily_RequestRegister">
                                                <ComponentArt:CallBack ID="CallBack_cmbIllnesses_tbDaily_RequestRegister" runat="server"
                                                    OnCallback="CallBack_cmbIllnesses_tbDaily_RequestRegister_onCallback" Height="26">
                                                    <Content>
                                                        <ComponentArt:ComboBox ID="cmbIllnesses_tbDaily_RequestRegister" runat="server" AutoComplete="true"
                                                            AutoFilter="true" AutoHighlight="false" CssClass="comboBox" DropDownCssClass="comboDropDown"
                                                            DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                            DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                            ItemCssClass="comboItem" ItemHoverCssClass="comboItemHover" SelectedItemCssClass="comboItemHover"
                                                            Style="width: 100%" TextBoxCssClass="comboTextBox" TextBoxEnabled="false">
                                                            <ClientEvents>
                                                                <Expand EventHandler="cmbIllnesses_tbDaily_RequestRegister_onExpand" />
                                                                <Collapse EventHandler="cmbIllnesses_tbDaily_RequestRegister_onCollapse" />
                                                            </ClientEvents>
                                                        </ComponentArt:ComboBox>
                                                        <asp:HiddenField ID="ErrorHiddenField_Illnesses_tbDaily_RequestRegister" runat="server" />
                                                    </Content>
                                                    <ClientEvents>
                                                        <BeforeCallback EventHandler="CallBack_cmbIllnesses_tbDaily_RequestRegister_onBeforeCallback" />
                                                        <CallbackComplete EventHandler="CallBack_cmbIllnesses_tbDaily_RequestRegister_onCallbackComplete" />
                                                        <CallbackError EventHandler="CallBack_cmbIllnesses_tbDaily_RequestRegister_onCallbackError" />
                                                    </ClientEvents>
                                                </ComponentArt:CallBack>
                                            </td>
                                        </tr>
                                        <tr id="Tr10" runat="server" meta:resourcekey="AlignObj">
                                            <td>
                                                <asp:Label ID="lblDoctors_tbDaily_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                    meta:resourcekey="lblDoctors_tbDaily_RequestRegister" Text=": نام دکتر"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="Tr11" runat="server" meta:resourcekey="AlignObj">
                                            <td id="Container_cmbDoctors_tbDaily_RequestRegister">
                                                <ComponentArt:CallBack ID="CallBack_cmbDoctors_tbDaily_RequestRegister" runat="server"
                                                    OnCallback="CallBack_cmbDoctors_tbDaily_RequestRegister_onCallback" Height="26">
                                                    <Content>
                                                        <ComponentArt:ComboBox ID="cmbDoctors_tbDaily_RequestRegister" runat="server" AutoComplete="true"
                                                            AutoFilter="true" AutoHighlight="false" CssClass="comboBox" DropDownCssClass="comboDropDown"
                                                            DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                            DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                            ItemCssClass="comboItem" ItemHoverCssClass="comboItemHover" SelectedItemCssClass="comboItemHover"
                                                            Style="width: 100%" TextBoxCssClass="comboTextBox" TextBoxEnabled="false">
                                                            <ClientEvents>
                                                                <Expand EventHandler="cmbDoctors_tbDaily_RequestRegister_onExpand" />
                                                                <Collapse EventHandler="cmbDoctors_tbDaily_RequestRegister_onCollapse" />
                                                            </ClientEvents>
                                                        </ComponentArt:ComboBox>
                                                        <asp:HiddenField ID="ErrorHiddenField_Doctors_tbDaily_RequestRegister" runat="server" />
                                                    </Content>
                                                    <ClientEvents>
                                                        <BeforeCallback EventHandler="CallBack_cmbDoctors_tbDaily_RequestRegister_onBeforeCallback" />
                                                        <CallbackComplete EventHandler="CallBack_cmbDoctors_tbDaily_RequestRegister_onCallbackComplete" />
                                                        <CallbackError EventHandler="CallBack_cmbDoctors_tbDaily_RequestRegister_onCallbackError" />
                                                    </ClientEvents>
                                                </ComponentArt:CallBack>
                                            </td>
                                        </tr>
                                        <tr id="Tr12" runat="server" meta:resourcekey="AlignObj">
                                            <td>
                                                <asp:Label ID="lblMissionLocation_tbDaily_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                    meta:resourcekey="lblMissionLocation_tbDaily_RequestRegister" Text=": محل ماموریت"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="Tr21" runat="server" meta:resourcekey="AlignObj">
                                            <td id="Container_cmbMissionLocation_tbDaily_RequestRegister">
                                                <ComponentArt:CallBack ID="CallBack_cmbMissionLocation_tbDaily_RequestRegister" runat="server"
                                                    OnCallback="CallBack_cmbMissionLocation_tbDaily_RequestRegister_onCallback" Height="26">
                                                    <Content>
                                                        <ComponentArt:ComboBox ID="cmbMissionLocation_tbDaily_RequestRegister" runat="server"
                                                            AutoComplete="true" AutoFilter="true" AutoHighlight="false" CssClass="comboBox"
                                                            DropDownCssClass="comboDropDown" DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                            DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                            ItemCssClass="comboItem" ItemHoverCssClass="comboItemHover" SelectedItemCssClass="comboItemHover"
                                                            Style="width: 100%" TextBoxCssClass="comboTextBox" TextBoxEnabled="false" DropDownHeight="200">
                                                            <DropDownContent>
                                                                <ComponentArt:TreeView ID="trvMissionLocation_tbDaily_RequestRegister" runat="server"
                                                                    CollapseImageUrl="images/TreeView/exp.gif" CssClass="TreeView" DefaultImageHeight="16"
                                                                    DefaultImageWidth="16" DragAndDropEnabled="false" EnableViewState="false" ExpandCollapseImageHeight="15"
                                                                    ExpandCollapseImageWidth="17" ExpandImageUrl="images/TreeView/col.gif" Height="95%"
                                                                    HoverNodeCssClass="HoverTreeNode" ItemSpacing="2" KeyboardEnabled="true" LineImageHeight="20"
                                                                    LineImageWidth="19" meta:resourcekey="trvMissionLocation_tbDaily_RequestRegister"
                                                                    NodeCssClass="TreeNode" NodeEditCssClass="NodeEdit" NodeIndent="17" NodeLabelPadding="3"
                                                                    SelectedNodeCssClass="SelectedTreeNode" ShowLines="true" Width="100%">
                                                                    <ClientEvents>
                                                                        <NodeSelect EventHandler="trvMissionLocation_tbDaily_RequestRegister_onNodeSelect" />
                                                                    </ClientEvents>
                                                                </ComponentArt:TreeView>
                                                            </DropDownContent>
                                                            <ClientEvents>
                                                                <Expand EventHandler="cmbMissionLocation_tbDaily_RequestRegister_onExpand" />
                                                                <Collapse EventHandler="cmbMissionLocation_tbDaily_RequestRegister_onCollapse" />
                                                            </ClientEvents>
                                                        </ComponentArt:ComboBox>
                                                        <asp:HiddenField ID="ErrorHiddenField_MissionLocations_tbDaily_RequestRegister" runat="server" />
                                                    </Content>
                                                    <ClientEvents>
                                                        <BeforeCallback EventHandler="CallBack_cmbMissionLocation_tbDaily_RequestRegister_onBeforeCallback" />
                                                        <CallbackComplete EventHandler="CallBack_cmbMissionLocation_tbDaily_RequestRegister_onCallbackComplete" />
                                                        <CallbackError EventHandler="CallBack_cmbMissionLocation_tbDaily_RequestRegister_onCallbackError" />
                                                    </ClientEvents>
                                                </ComponentArt:CallBack>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="Tr22" runat="server">
                                <td colspan="2">
                                    <ComponentArt:CallBack ID="CallBack_cmbRequestType_tbDaily_RequestRegister" runat="server"
                                        OnCallback="CallBack_cmbRequestType_tbDaily_RequestRegister_onCallback" Height="26">
                                        <Content>
                                            <ComponentArt:ComboBox ID="cmbRequestType_tbDaily_RequestRegister" runat="server"
                                                AutoComplete="true" AutoFilter="true" AutoHighlight="false" CssClass="comboBox"
                                                DropDownCssClass="comboDropDown" DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                ItemCssClass="comboItem" ItemHoverCssClass="comboItemHover" SelectedItemCssClass="comboItemHover"
                                                Style="width: 100%" TextBoxCssClass="comboTextBox" TextBoxEnabled="false">
                                                <ClientEvents>
                                                    <Change EventHandler="cmbRequestType_tbDaily_RequestRegister_onChange" />
                                                    <Expand EventHandler="cmbRequestType_tbDaily_RequestRegister_onExpand" />
                                                    <Collapse EventHandler="cmbRequestType_tbDaily_RequestRegister_onCollapse" />
                                                </ClientEvents>
                                            </ComponentArt:ComboBox>
                                            <asp:HiddenField ID="ErrorHiddenField_RequestTypes_tbDaily_RequestRegister" runat="server" />
                                        </Content>
                                        <ClientEvents>
                                            <BeforeCallback EventHandler="CallBack_cmbRequestType_tbDaily_RequestRegister_onBeforeCallback" />
                                            <CallbackComplete EventHandler="CallBack_cmbRequestType_tbDaily_RequestRegister_onCallbackComplete" />
                                            <CallbackError EventHandler="CallBack_cmbRequestType_tbDaily_RequestRegister_onCallbackError" />
                                        </ClientEvents>
                                    </ComponentArt:CallBack>
                                </td>
                            </tr>
                            <tr id="Tr23" runat="server" align="center">
                                <td colspan="2">
                                    <table style="width: 50%;">
                                        <tr runat="server" meta:resourcekey="AlignObj">
                                            <td>
                                                <asp:Label ID="lblFromDate_tbDaily_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                    meta:resourcekey="lblFromDate_tbDaily_RequestRegister" Text=": از تاریخ"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr runat="server" meta:resourcekey="AlignObj">
                                            <td id="Container_FromDateCalendars_tbDaily_RequestRegister">
                                                <table runat="server" id="Container_pdpFromDate_tbDaily_RequestRegister" visible="false"
                                                    style="width: 100%">
                                                    <tr>
                                                        <td>
                                                            <pcal:PersianDatePickup ID="pdpFromDate_tbDaily_RequestRegister" runat="server" CssClass="PersianDatePicker"
                                                                Style="margin: 0 40 0 0" ReadOnly="true"></pcal:PersianDatePickup>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table runat="server" id="Container_gdpFromDate_tbDaily_RequestRegister" visible="false"
                                                    style="width: 100%">
                                                    <tr>
                                                        <td>
                                                            <table id="Container_gCalFromDate_tbDaily_RequestRegister" border="0" cellpadding="0"
                                                                cellspacing="0">
                                                                <tr>
                                                                    <td onmouseup="btn_gdpFromDate_tbDaily_RequestRegister_OnMouseUp(event)">
                                                                        <ComponentArt:Calendar ID="gdpFromDate_tbDaily_RequestRegister" runat="server" ControlType="Picker"
                                                                            MaxDate="2122-1-1" PickerCssClass="picker" PickerCustomFormat="yyyy/MM/dd" PickerFormat="Custom"
                                                                            SelectedDate="2008-1-1">
                                                                            <ClientEvents>
                                                                                <SelectionChanged EventHandler="gdpFromDate_tbDaily_RequestRegister_OnDateChange" />
                                                                            </ClientEvents>
                                                                        </ComponentArt:Calendar>
                                                                    </td>
                                                                    <td style="font-size: 10px;">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <img id="btn_gdpFromDate_tbDaily_RequestRegister" alt="" class="calendar_button"
                                                                            onclick="btn_gdpFromDate_tbDaily_RequestRegister_OnClick(event)" onmouseup="btn_gdpFromDate_tbDaily_RequestRegister_OnMouseUp(event)"
                                                                            src="Images/Calendar/btn_calendar.gif" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <ComponentArt:Calendar ID="gCalFromDate_tbDaily_RequestRegister" runat="server" AllowMonthSelection="false"
                                                                AllowMultipleSelection="false" AllowWeekSelection="false" CalendarCssClass="calendar"
                                                                CalendarTitleCssClass="title" ControlType="Calendar" DayCssClass="day" DayHeaderCssClass="dayheader"
                                                                DayHoverCssClass="dayhover" DayNameFormat="FirstTwoLetters" ImagesBaseUrl="Images/Calendar"
                                                                MaxDate="2122-1-1" MonthCssClass="month" NextImageUrl="cal_nextMonth.gif" NextPrevCssClass="nextprev"
                                                                OtherMonthDayCssClass="othermonthday" PopUp="Custom" PopUpExpandControlId="btn_gdpFromDate_tbDaily_RequestRegister"
                                                                PrevImageUrl="cal_prevMonth.gif" SelectedDate="2008-1-1" SelectedDayCssClass="selectedday"
                                                                SwapDuration="300" SwapSlide="Linear" VisibleDate="2008-1-1">
                                                                <ClientEvents>
                                                                    <SelectionChanged EventHandler="gCalFromDate_tbDaily_RequestRegister_OnChange" />
                                                                    <Load EventHandler="gCalFromDate_tbDaily_RequestRegister_OnLoad" />
                                                                </ClientEvents>
                                                            </ComponentArt:Calendar>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr runat="server" meta:resourcekey="AlignObj">
                                            <td>
                                                <asp:Label ID="lblToDate_tbDaily_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                    meta:resourcekey="lblToDate_tbDaily_RequestRegister" Text=": تا تاریخ"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr runat="server" meta:resourcekey="AlignObj">
                                            <td id="Container_ToDateCalendars_tbDaily_RequestRegister">
                                                <table runat="server" id="Container_pdpToDate_tbDaily_RequestRegister" visible="false"
                                                    style="width: 100%">
                                                    <tr>
                                                        <td>
                                                            <pcal:PersianDatePickup ID="pdpToDate_tbDaily_RequestRegister" runat="server" CssClass="PersianDatePicker"
                                                                ReadOnly="true"></pcal:PersianDatePickup>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table runat="server" id="Container_gdpToDate_tbDaily_RequestRegister" visible="false"
                                                    style="width: 100%">
                                                    <tr>
                                                        <td>
                                                            <table id="Container_gCalToDate_tbDaily_RequestRegister" border="0" cellpadding="0"
                                                                cellspacing="0">
                                                                <tr>
                                                                    <td onmouseup="btn_gdpToDate_tbDaily_RequestRegister_OnMouseUp(event)">
                                                                        <ComponentArt:Calendar ID="gdpToDate_tbDaily_RequestRegister" runat="server" ControlType="Picker"
                                                                            MaxDate="2122-1-1" PickerCssClass="picker" PickerCustomFormat="yyyy/MM/dd" PickerFormat="Custom"
                                                                            SelectedDate="2008-1-1">
                                                                            <ClientEvents>
                                                                                <SelectionChanged EventHandler="gdpToDate_tbDaily_RequestRegister_OnDateChange" />
                                                                            </ClientEvents>
                                                                        </ComponentArt:Calendar>
                                                                    </td>
                                                                    <td style="font-size: 10px;">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <img id="btn_gdpToDate_tbDaily_RequestRegister" alt="" class="calendar_button" onclick="btn_gdpToDate_tbDaily_RequestRegister_OnClick(event)"
                                                                            onmouseup="btn_gdpToDate_tbDaily_RequestRegister_OnMouseUp(event)" src="Images/Calendar/btn_calendar.gif" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <ComponentArt:Calendar ID="gCalToDate_tbDaily_RequestRegister" runat="server" AllowMonthSelection="false"
                                                                AllowMultipleSelection="false" AllowWeekSelection="false" CalendarCssClass="calendar"
                                                                CalendarTitleCssClass="title" ControlType="Calendar" DayCssClass="day" DayHeaderCssClass="dayheader"
                                                                DayHoverCssClass="dayhover" DayNameFormat="FirstTwoLetters" ImagesBaseUrl="Images/Calendar"
                                                                MaxDate="2122-1-1" MonthCssClass="month" NextImageUrl="cal_nextMonth.gif" NextPrevCssClass="nextprev"
                                                                OtherMonthDayCssClass="othermonthday" PopUp="Custom" PopUpExpandControlId="btn_gdpToDate_tbDaily_RequestRegister"
                                                                PrevImageUrl="cal_prevMonth.gif" SelectedDate="2008-1-1" SelectedDayCssClass="selectedday"
                                                                SwapDuration="300" SwapSlide="Linear" VisibleDate="2008-1-1">
                                                                <ClientEvents>
                                                                    <SelectionChanged EventHandler="gCalToDate_tbDaily_RequestRegister_OnChange" />
                                                                    <Load EventHandler="gCalToDate_tbDaily_RequestRegister_OnLoad" />
                                                                </ClientEvents>
                                                            </ComponentArt:Calendar>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDescription_tbDaily_RequestRegister" runat="server" CssClass="WhiteLabel"
                                        meta:resourcekey="lblDescription_tbDaily_RequestRegister" Text=": توضیحات"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <textarea id="txtDescription_tbDaily_RequestRegister" class="TextBoxes" cols="20"
                                        name="S1" rows="3" style="width: 99%; height: 160px;"></textarea>
                                </td>
                            </tr>
                        </table>
                    </ComponentArt:PageView>
                    <ComponentArt:PageView CssClass="PageContent" runat="server" ID="pgvOverTime_DialogRequestRegister"
                        Visible="true">
                        <table class="BoxStyle" style="width: 100%; font-family: Arial; font-size: small;">
                            <tr>
                                <td>
                                    <ComponentArt:ToolBar ID="TlbOverTime" runat="server" CssClass="toolbar" DefaultItemActiveCssClass="itemActive"
                                        DefaultItemCheckedCssClass="itemChecked" DefaultItemCheckedHoverCssClass="itemActive"
                                        DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover" DefaultItemImageHeight="16px"
                                        DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText" DefaultItemTextImageSpacing="0"
                                        ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                                        <Items>
                                            <ComponentArt:ToolBarItem ID="tlbItemEndorsement_TlbOverTime" runat="server" ClientSideCommand="tlbItemEndorsement_TlbOverTime_onClick();"
                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="save.png"
                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemEndorsement_TlbOverTime"
                                                TextImageSpacing="5" />
                                            <ComponentArt:ToolBarItem ID="tlbItemFormReconstruction_TlbOverTime" runat="server"
                                                ClientSideCommand="tlbItemFormReconstruction_TlbOverTime_onClick();" DropDownImageHeight="16px"
                                                DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="refresh.png" ImageWidth="16px"
                                                ItemType="Command" meta:resourcekey="tlbItemFormReconstruction_TlbOverTime" TextImageSpacing="5" />
                                            <ComponentArt:ToolBarItem ID="tlbItemExit_TlbOverTime" runat="server" ClientSideCommand="tlbItemExit_TlbOverTime_onClick();"
                                                DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="exit.png"
                                                ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemExit_TlbOverTime"
                                                TextImageSpacing="5" />
                                        </Items>
                                    </ComponentArt:ToolBar>
                                </td>
                            </tr>
                            <tr id="Tr13" runat="server">
                                <td>
                                    <asp:Label ID="lblRequesType_tbOverTime_RequestRegister" runat="server" CssClass="WhiteLabel"
                                        meta:resourcekey="lblRequesType_tbOverTime_RequestRegister" Text=": نوع درخواست"></asp:Label>
                                </td>
                            </tr>
                            <tr id="Tr14" runat="server">
                                <td>
                                    <ComponentArt:CallBack ID="CallBack_cmbRequestType_tbOverTime_RequestRegister" runat="server"
                                        OnCallback="CallBack_cmbRequestType_tbOverTime_RequestRegister_onCallback" Height="26">
                                        <Content>
                                            <ComponentArt:ComboBox ID="cmbRequestType_tbOverTime_RequestRegister" runat="server"
                                                AutoComplete="true" AutoFilter="true" AutoHighlight="false" CssClass="comboBox"
                                                DataTextField="Name" DataValueField="ID" DropDownCssClass="comboDropDown" DropDownResizingMode="Corner"
                                                DropHoverImageUrl="Images/ComboBox/ddn-hover.png" DropImageUrl="Images/ComboBox/ddn.png"
                                                FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover" ItemCssClass="comboItem"
                                                ItemHoverCssClass="comboItemHover" SelectedItemCssClass="comboItemHover" Style="width: 100%"
                                                TextBoxCssClass="comboTextBox" TextBoxEnabled="false">
                                                <ClientEvents>
                                                    <Expand EventHandler="cmbRequestType_tbOverTime_RequestRegister_onExpand" />
                                                    <Collapse EventHandler="cmbRequestType_tbOverTime_RequestRegister_onCollapse" />
                                                    <Change EventHandler="cmbRequestType_tbOverTime_RequestRegister_onChange"/>
                                                </ClientEvents>
                                            </ComponentArt:ComboBox>
                                            <asp:HiddenField ID="ErrorHiddenField_RequestTypes_tbOverTime_RequestRegister" runat="server" />
                                        </Content>
                                        <ClientEvents>
                                            <BeforeCallback EventHandler="cmbRequestType_tbOverTime_RequestRegister_onBeforeCallback" />
                                            <CallbackComplete EventHandler="cmbRequestType_tbOverTime_RequestRegister_onCallbackComplete" />
                                            <CallbackError EventHandler="cmbRequestType_tbOverTime_RequestRegister_onCallbackError" />
                                        </ClientEvents>
                                    </ComponentArt:CallBack>
                                </td>
                            </tr>
                            <tr id="Tr16" runat="server">
                                <td>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td valign="top" style="width: 30%">
                                                <div id="Container_NormalTimeParts_tbOverTime_RequestRegister">
                                                    <table style="width: 100%;">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblFromHour_tbOverTime_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                                    meta:resourcekey="lblFromHour_tbOverTime_RequestRegister" Text=": از ساعت"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <MKB:TimeSelector ID="TimeSelector_FromHour_tbOverTime_RequestRegister" runat="server"
                                                                    DisplaySeconds="true" MinuteIncrement="1" SelectedTimeFormat="TwentyFour" Style="direction: ltr;"
                                                                    Visible="true">
                                                                </MKB:TimeSelector>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblToHour_tbOverTime_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                                    meta:resourcekey="lblToHour_tbOverTime_RequestRegister" Text=": تا ساعت"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <MKB:TimeSelector ID="TimeSelector_ToHour_tbOverTime_RequestRegister" runat="server"
                                                                    DisplaySeconds="true" MinuteIncrement="1" SelectedTimeFormat="TwentyFour" Style="direction: ltr;"
                                                                    Visible="true">
                                                                </MKB:TimeSelector>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblDuration_tbOverTime_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                                    meta:resourcekey="lblDuration_tbOverTime_RequestRegister" Text=": مدت زمان"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <MKB:TimeSelector ID="TimeSelector_Duration_tbOverTime_RequestRegister" runat="server"
                                                                    DisplaySeconds="true" MinuteIncrement="1" SelectedTimeFormat="TwentyFour" Style="direction: ltr;"
                                                                    Visible="true">
                                                                </MKB:TimeSelector>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td style="width: 40%" valign="top">
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td>
                                                            <div id="Container_FromDateCalendars_tbOverTime_RequestRegister">
                                                                <table style="width: 100%;">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblFromDate_tbOverTime_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                                                meta:resourcekey="lblFromDate_tbOverTime_RequestRegister" Text=": از تاریخ"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table id="Container_pdpFromDate_tbOverTime_RequestRegister" runat="server" style="width: 100%"
                                                                                visible="false">
                                                                                <tr>
                                                                                    <td>
                                                                                        <pcal:PersianDatePickup ID="pdpFromDate_tbOverTime_RequestRegister" runat="server"
                                                                                            CssClass="PersianDatePicker" ReadOnly="true"></pcal:PersianDatePickup>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <table id="Container_gdpFromDate_tbOverTime_RequestRegister" runat="server" style="width: 100%"
                                                                                visible="false">
                                                                                <tr>
                                                                                    <td>
                                                                                        <table id="Container_gCalFromDate_tbOverTime_RequestRegister" border="0" cellpadding="0"
                                                                                            cellspacing="0">
                                                                                            <tr>
                                                                                                <td onmouseup="btn_gdpFromDate_tbOverTime_RequestRegister_OnMouseUp(event)">
                                                                                                    <ComponentArt:Calendar ID="gdpFromDate_tbOverTime_RequestRegister" runat="server"
                                                                                                        ControlType="Picker" MaxDate="2122-1-1" PickerCssClass="picker" PickerCustomFormat="yyyy/MM/dd"
                                                                                                        PickerFormat="Custom" SelectedDate="2008-1-1">
                                                                                                        <ClientEvents>
                                                                                                            <SelectionChanged EventHandler="gdpFromDate_tbOverTime_RequestRegister_OnDateChange" />
                                                                                                        </ClientEvents>
                                                                                                    </ComponentArt:Calendar>
                                                                                                </td>
                                                                                                <td style="font-size: 10px;">
                                                                                                    &nbsp;
                                                                                                </td>
                                                                                                <td>
                                                                                                    <img id="btn_gdpFromDate_tbOverTime_RequestRegister" alt="" class="calendar_button"
                                                                                                        onclick="btn_gdpFromDate_tbOverTime_RequestRegister_OnClick(event)" onmouseup="btn_gdpFromDate_tbOverTime_RequestRegister_OnMouseUp(event)"
                                                                                                        src="Images/Calendar/btn_calendar.gif" />
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                        <ComponentArt:Calendar ID="gCalFromDate_tbOverTime_RequestRegister" runat="server"
                                                                                            AllowMonthSelection="false" AllowMultipleSelection="false" AllowWeekSelection="false"
                                                                                            CalendarCssClass="calendar" CalendarTitleCssClass="title" ControlType="Calendar"
                                                                                            DayCssClass="day" DayHeaderCssClass="dayheader" DayHoverCssClass="dayhover" DayNameFormat="FirstTwoLetters"
                                                                                            ImagesBaseUrl="Images/Calendar" MaxDate="2122-1-1" MonthCssClass="month" NextImageUrl="cal_nextMonth.gif"
                                                                                            NextPrevCssClass="nextprev" OtherMonthDayCssClass="othermonthday" PopUp="Custom"
                                                                                            PopUpExpandControlId="btn_gdpFromDate_tbOverTime_RequestRegister" PrevImageUrl="cal_prevMonth.gif"
                                                                                            SelectedDate="2008-1-1" SelectedDayCssClass="selectedday" SwapDuration="300"
                                                                                            SwapSlide="Linear" VisibleDate="2008-1-1">
                                                                                            <ClientEvents>
                                                                                                <SelectionChanged EventHandler="gCalFromDate_tbOverTime_RequestRegister_OnChange" />
                                                                                                <Load EventHandler="gCalFromDate_tbOverTime_RequestRegister_OnLoad" />
                                                                                            </ClientEvents>
                                                                                        </ComponentArt:Calendar>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div id="Container_ToDateCalendars_tbOverTime_RequestRegister">
                                                                <table style="width: 100%;">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblToDate_tbOverTime_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                                                meta:resourcekey="lblToDate_tbOverTime_RequestRegister" Text=": تا تاریخ"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table id="Container_pdpToDate_tbOverTime_RequestRegister" runat="server" style="width: 100%"
                                                                                visible="false">
                                                                                <tr>
                                                                                    <td>
                                                                                        <pcal:PersianDatePickup ID="pdpToDate_tbOverTime_RequestRegister" runat="server"
                                                                                            CssClass="PersianDatePicker" ReadOnly="true"></pcal:PersianDatePickup>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <table id="Container_gdpToDate_tbOverTime_RequestRegister" runat="server" style="width: 100%"
                                                                                visible="false">
                                                                                <tr>
                                                                                    <td>
                                                                                        <table id="Container_gCalToDate_tbOverTime_RequestRegister" border="0" cellpadding="0"
                                                                                            cellspacing="0">
                                                                                            <tr>
                                                                                                <td onmouseup="btn_gdpToDate_tbOverTime_RequestRegister_OnMouseUp(event)">
                                                                                                    <ComponentArt:Calendar ID="gdpToDate_tbOverTime_RequestRegister" runat="server" ControlType="Picker"
                                                                                                        MaxDate="2122-1-1" PickerCssClass="picker" PickerCustomFormat="yyyy/MM/dd" PickerFormat="Custom"
                                                                                                        SelectedDate="2008-1-1">
                                                                                                        <ClientEvents>
                                                                                                            <SelectionChanged EventHandler="gdpToDate_tbOverTime_RequestRegister_OnDateChange" />
                                                                                                        </ClientEvents>
                                                                                                    </ComponentArt:Calendar>
                                                                                                </td>
                                                                                                <td style="font-size: 10px;">
                                                                                                    &nbsp;
                                                                                                </td>
                                                                                                <td>
                                                                                                    <img id="btn_gdpToDate_tbOverTime_RequestRegister" alt="" class="calendar_button"
                                                                                                        onclick="btn_gdpToDate_tbOverTime_RequestRegister_OnClick(event)" onmouseup="btn_gdpToDate_tbOverTime_RequestRegister_OnMouseUp(event)"
                                                                                                        src="Images/Calendar/btn_calendar.gif" />
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                        <ComponentArt:Calendar ID="gCalToDate_tbOverTime_RequestRegister" runat="server"
                                                                                            AllowMonthSelection="false" AllowMultipleSelection="false" AllowWeekSelection="false"
                                                                                            CalendarCssClass="calendar" CalendarTitleCssClass="title" ControlType="Calendar"
                                                                                            DayCssClass="day" DayHeaderCssClass="dayheader" DayHoverCssClass="dayhover" DayNameFormat="FirstTwoLetters"
                                                                                            ImagesBaseUrl="Images/Calendar" MaxDate="2122-1-1" MonthCssClass="month" NextImageUrl="cal_nextMonth.gif"
                                                                                            NextPrevCssClass="nextprev" OtherMonthDayCssClass="othermonthday" PopUp="Custom"
                                                                                            PopUpExpandControlId="btn_gdpToDate_tbOverTime_RequestRegister" PrevImageUrl="cal_prevMonth.gif"
                                                                                            SelectedDate="2008-1-1" SelectedDayCssClass="selectedday" SwapDuration="300"
                                                                                            SwapSlide="Linear" VisibleDate="2008-1-1">
                                                                                            <ClientEvents>
                                                                                                <SelectionChanged EventHandler="gCalToDate_tbOverTime_RequestRegister_OnChange" />
                                                                                                <Load EventHandler="gCalToDate_tbOverTime_RequestRegister_OnLoad" />
                                                                                            </ClientEvents>
                                                                                        </ComponentArt:Calendar>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 30%" valign="top">
                                                <div id="Container_MinistryTimeParts_tbOverTime_RequestRegister" style="visibility:hidden">
                                                    <table style="width: 100%;">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblMinistryDuration_tbOverTime_RequestRegister" runat="server" CssClass="WhiteLabel"
                                                                    meta:resourcekey="lblMinistryDuration_tbOverTime_RequestRegister" Text=": مدت زمان"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table style="width: 70%" dir="ltr">
                                                                    <tr>
                                                                        <td align="center" style="width: 49%">
                                                                            <input id="TimeSelector_MinistryDuration_tbOverTime_RequestRegister_txtHour" onchange="TimeSelector_MinistryDuration_tbOverTime_RequestRegister_onChange('txtHour')"
                                                                                style="width: 70%; text-align: center" type="text" />
                                                                        </td>
                                                                        <td align="center">
                                                                            :
                                                                        </td>
                                                                        <td align="center" style="width: 49%">
                                                                            <input id="TimeSelector_MinistryDuration_tbOverTime_RequestRegister_txtMinute" onchange="TimeSelector_MinistryDuration_tbOverTime_RequestRegister_onChange('txtMinute')"
                                                                                style="width: 70%; text-align: center" type="text" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDescription_tbOverTime_RequestRegister" runat="server" CssClass="WhiteLabel"
                                        meta:resourcekey="lblDescription_tbOverTime_RequestRegister" Text=": توضیحات"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <textarea id="txtDescription_tbOverTime_RequestRegister" class="TextBoxes" cols="20"
                                        name="S1" rows="3" style="width: 99%; height: 160px;"></textarea>
                                </td>
                            </tr>
                        </table>
                    </ComponentArt:PageView>
                </ComponentArt:MultiPage>
            </td>
        </tr>
    </table>
    <ComponentArt:Dialog ModalMaskImage="Images/Dialog/alpha.png" HeaderCssClass="headerCss"
        Modal="true" AllowResize="false" AllowDrag="false" Alignment="MiddleCentre" ID="DialogCollectiveTraffic"
        runat="server" Width="780px" HeaderClientTemplateId="DialogCollectiveTrafficheader"
        FooterClientTemplateId="DialogCollectiveTrafficfooter" Style="top: 611px; left: 0px">
        <ClientTemplates>
            <ComponentArt:ClientTemplate ID="DialogCollectiveTrafficheader">
                <table id="tbl_DialogCollectiveTrafficheader" style="width: 783px" cellpadding="0"
                    cellspacing="0" border="0" onmousedown="DialogCollectiveTraffic.StartDrag(event);">
                    <tr>
                        <td width="6">
                            <img id="DialogCollectiveTraffic_topLeftImage" style="display: block;" src="Images/Dialog/top_left.gif"
                                alt="" />
                        </td>
                        <td style="background-image: url(Images/Dialog/top.gif); padding: 3px">
                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td id="Title_DialogCollectiveTraffic" valign="bottom" style="color: White; font-size: 13px;
                                        font-family: Arial; font-weight: bold">
                                    </td>
                                    <td id="CloseButton_DialogCollectiveTraffic" valign="middle">
                                        <img alt="" src="Images/Dialog/close-down.png" onclick="DialogCollectiveTraffic.Close('cancelled')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="6">
                            <img id="DialogCollectiveTraffic_topRightImage" style="display: block;" src="Images/Dialog/top_right.gif"
                                alt="" />
                        </td>
                    </tr>
                </table>
            </ComponentArt:ClientTemplate>
            <ComponentArt:ClientTemplate ID="DialogCollectiveTrafficfooter">
                <table id="tbl_DialogCollectiveTrafficfooter" style="width: 783px" cellpadding="0"
                    cellspacing="0" border="0">
                    <tr>
                        <td width="6">
                            <img id="DialogCollectiveTraffic_downLeftImage" style="display: block;" src="Images/Dialog/down_left.gif"
                                alt="" />
                        </td>
                        <td style="background-image: url(Images/Dialog/down.gif); background-repeat: repeat;
                            padding: 3px">
                        </td>
                        <td width="6">
                            <img id="DialogCollectiveTraffic_downRightImage" style="display: block;" src="Images/Dialog/down_right.gif"
                                alt="" />
                        </td>
                    </tr>
                </table>
            </ComponentArt:ClientTemplate>
        </ClientTemplates>
        <Content>
            <table id="Mastertbl_CollectiveTraffic" class="BoxStyle" style="width: 100%; background-color: White">
                <tr>
                    <td>
                        <ComponentArt:ToolBar ID="TlbCollectiveTraffic" runat="server" class="BoxStyle" CssClass="toolbar"
                            DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                            DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                            DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText"
                            ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                            <Items>
                                <ComponentArt:ToolBarItem ID="tlbItemSave_TlbCollectiveTraffic" runat="server" ClientSideCommand="tlbItemSave_TlbCollectiveTraffic_onClick();"
                                    DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="save.png"
                                    ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemSave_TlbCollectiveTraffic"
                                    TextImageSpacing="5" />
                                <ComponentArt:ToolBarItem ID="tlbItemExit_TlbCollectiveTraffic" runat="server" ClientSideCommand="tlbItemExit_TlbCollectiveTraffic_onClick();"
                                    DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="exit.png"
                                    ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemExit_TlbCollectiveTraffic"
                                    TextImageSpacing="5" />
                            </Items>
                        </ComponentArt:ToolBar>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="BoxStyle" style="width: 100%;">
                            <tr>
                                <td style="color: White; width: 100%">
                                    <table style="width: 100%">
                                        <tr>
                                            <td id="header_Personnel_CollectiveTraffic" class="HeaderLabel" style="width: 50%;">
                                                Personnel
                                            </td>
                                            <td id="loadingPanel_GridPersonnel_CollectiveTraffic" class="HeaderLabel" style="width: 45%">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100%">
                                    <ComponentArt:CallBack ID="CallBack_GridPersonnel_CollectiveTraffic" runat="server"
                                        OnCallback="CallBack_GridPersonnel_CollectiveTraffic_onCallBack">
                                        <Content>
                                            <ComponentArt:DataGrid ID="GridPersonnel_CollectiveTraffic" runat="server" AllowColumnResizing="false"
                                                AllowHorizontalScrolling="true" AllowMultipleSelect="false" CssClass="Grid" EnableViewState="true"
                                                FillContainer="true" FooterCssClass="GridFooter" ImagesBaseUrl="images/Grid/"
                                                PagePaddingEnabled="true" PagerTextCssClass="GridFooterText" PageSize="10" RunningMode="Client"
                                                ScrollBar="Off" ScrollBarCssClass="ScrollBar" ScrollBarWidth="16" ScrollButtonHeight="17"
                                                ScrollButtonWidth="16" ScrollGripCssClass="ScrollGrip" ScrollImagesFolderUrl="images/Grid/scroller/"
                                                ScrollTopBottomImageHeight="2" ScrollTopBottomImagesEnabled="true" ScrollTopBottomImageWidth="16"
                                                SearchTextCssClass="GridHeaderText" ShowFooter="false" Width="600px">
                                                <Levels>
                                                    <ComponentArt:GridLevel AlternatingRowCssClass="AlternatingRow" DataCellCssClass="DataCell"
                                                        DataKeyField="ID" HeadingCellCssClass="HeadingCell" HeadingTextCssClass="HeadingCellText"
                                                        RowCssClass="Row" SelectedRowCssClass="SelectedRow" SelectorCellCssClass="SelectorCell"
                                                        SortAscendingImageUrl="asc.gif" SortDescendingImageUrl="desc.gif" SortImageHeight="5"
                                                        SortImageWidth="9">
                                                        <Columns>
                                                            <ComponentArt:GridColumn DataField="ID" Visible="false" />
                                                            <ComponentArt:GridColumn Align="Center" ColumnType="CheckBox" DataField="Select"
                                                                HeadingText="انتخاب" HeadingTextCssClass="HeadingText" meta:resourcekey="clmnSelect_GridPersonnel_CollectiveTraffic"
                                                                Width="50" AllowEditing="True" />
                                                            <ComponentArt:GridColumn Align="Center" DataField="PersonCode" DefaultSortDirection="Descending"
                                                                HeadingText="شماره پرسنلی" HeadingTextCssClass="HeadingText" meta:resourcekey="clmnPersonnelNumber_GridPersonnel_CollectiveTraffic"
                                                                Width="125" />
                                                            <ComponentArt:GridColumn Align="Center" DataField="Name" DefaultSortDirection="Descending"
                                                                HeadingText="نام و نام خانوادگی" HeadingTextCssClass="HeadingText" meta:resourcekey="clmnName_GridPersonnel_CollectiveTraffic"
                                                                Width="175" />
                                                            <ComponentArt:GridColumn Align="Center" DataField="Department.Name" DefaultSortDirection="Descending"
                                                                HeadingText="بخش" HeadingTextCssClass="HeadingText" meta:resourcekey="clmnDepartment_GridPersonnel_CollectiveTraffic"
                                                                Width="175" />
                                                            <ComponentArt:GridColumn Align="Center" DataField="OrganizationUnit.Name" DefaultSortDirection="Descending"
                                                                HeadingText="پست سازمانی" HeadingTextCssClass="HeadingText" meta:resourcekey="clmnOrganizationPost_GridPersonnel_CollectiveTraffic"
                                                                Width="175" />
                                                            <ComponentArt:GridColumn DataField="Department.ID" Visible="false" />
                                                            <ComponentArt:GridColumn DataField="OrganizationUnit.ID" Visible="false" />
                                                        </Columns>
                                                    </ComponentArt:GridLevel>
                                                </Levels>
                                                <ClientEvents>
                                                    <Load EventHandler="GridPersonnel_CollectiveTraffic_onLoad" />
                                                    <ItemCheckChange EventHandler="GridPersonnel_CollectiveTraffic_onItemCheckChange" />
                                                </ClientEvents>
                                            </ComponentArt:DataGrid>
                                            <asp:HiddenField ID="ErrorHiddenField_Personnel_CollectiveTraffic" runat="server" />
                                            <asp:HiddenField ID="hfPersonnelCount_Personnel_CollectiveTraffic" runat="server" />
                                            <asp:HiddenField ID="hfPersonnelPageCount_Personnel_CollectiveTraffic" runat="server" />
                                        </Content>
                                        <ClientEvents>
                                            <CallbackComplete EventHandler="CallBack_GridPersonnel_CollectiveTraffic_onCallbackComplete" />
                                            <CallbackError EventHandler="CallBack_GridPersonnel_CollectiveTraffic_onCallbackError" />
                                        </ClientEvents>
                                    </ComponentArt:CallBack>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100%">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td id="Td5" runat="server" meta:resourcekey="AlignObj" style="width: 50%;">
                                                <ComponentArt:ToolBar ID="TlbPaging_GridPersonnel_CollectiveTraffic" runat="server"
                                                    CssClass="toolbar" DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                                                    DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                                                    DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageOnly"
                                                    DefaultItemTextImageSpacing="0" ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px"
                                                    Style="direction: ltr" UseFadeEffect="false">
                                                    <Items>
                                                        <ComponentArt:ToolBarItem ID="tlbItemRefresh_TlbPaging_GridPersonnel_CollectiveTraffic"
                                                            runat="server" ClientSideCommand="tlbItemRefresh_TlbPaging_GridPersonnel_CollectiveTraffic_onClick();"
                                                            DropDownImageHeight="16px" DropDownImageWidth="16px" Enabled="true" ImageHeight="16px"
                                                            ImageUrl="refresh.png" ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemRefresh_TlbPaging_GridPersonnel_CollectiveTraffic"
                                                            TextImageSpacing="5" />
                                                        <ComponentArt:ToolBarItem ID="tlbItemFirst_TlbPaging_GridPersonnel_CollectiveTraffic"
                                                            runat="server" ClientSideCommand="tlbItemFirst_TlbPaging_GridPersonnel_CollectiveTraffic_onClick();"
                                                            DropDownImageHeight="16px" DropDownImageWidth="16px" Enabled="true" ImageHeight="16px"
                                                            ImageUrl="first.png" ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemFirst_TlbPaging_GridPersonnel_CollectiveTraffic"
                                                            TextImageSpacing="5" />
                                                        <ComponentArt:ToolBarItem ID="tlbItemBefore_TlbPaging_GridPersonnel_CollectiveTraffic"
                                                            runat="server" ClientSideCommand="tlbItemBefore_TlbPaging_GridPersonnel_CollectiveTraffic_onClick();"
                                                            DropDownImageHeight="16px" DropDownImageWidth="16px" Enabled="true" ImageHeight="16px"
                                                            ImageUrl="Before.png" ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemBefore_TlbPaging_GridPersonnel_CollectiveTraffic"
                                                            TextImageSpacing="5" />
                                                        <ComponentArt:ToolBarItem ID="tlbItemNext_TlbPaging_GridPersonnel_CollectiveTraffic"
                                                            runat="server" ClientSideCommand="tlbItemNext_TlbPaging_GridPersonnel_CollectiveTraffic_onClick();"
                                                            DropDownImageHeight="16px" DropDownImageWidth="16px" Enabled="true" ImageHeight="16px"
                                                            ImageUrl="Next.png" ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemNext_TlbPaging_GridPersonnel_CollectiveTraffic"
                                                            TextImageSpacing="5" />
                                                        <ComponentArt:ToolBarItem ID="tlbItemLast_TlbPaging_GridPersonnel_CollectiveTraffic"
                                                            runat="server" ClientSideCommand="tlbItemLast_TlbPaging_GridPersonnel_CollectiveTraffic_onClick();"
                                                            DropDownImageHeight="16px" DropDownImageWidth="16px" Enabled="true" ImageHeight="16px"
                                                            ImageUrl="last.png" ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemLast_TlbPaging_GridPersonnel_CollectiveTraffic"
                                                            TextImageSpacing="5" />
                                                    </Items>
                                                </ComponentArt:ToolBar>
                                            </td>
                                            <td id="PersonnelCount_GridPersonnel_CollectiveTraffic" class="WhiteLabel" style="width: 25%">
                                            </td>
                                            <td id="footer_GridPersonnel_CollectiveTraffic" class="WhiteLabel" style="width: 25%">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </Content>
        <ClientEvents>
            <OnShow EventHandler="DialogCollectiveTraffic_OnShow" />
        </ClientEvents>
    </ComponentArt:Dialog>
    <ComponentArt:Dialog ModalMaskImage="Images/Dialog/alpha.png" HeaderCssClass="headerCss"
        Modal="true" AllowResize="false" AllowDrag="false" Alignment="MiddleCentre" ID="DialogConfirm"
        runat="server" Width="300px">
        <Content>
            <table id="tblConfirm_DialogConfirm" style="width: 100%;" class="ConfirmStyle">
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
                                    ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemCancel_TlbCancelConfirm"
                                    TextImageSpacing="5" />
                            </Items>
                        </ComponentArt:ToolBar>
                    </td>
                </tr>
            </table>
        </Content>
    </ComponentArt:Dialog>
    <asp:HiddenField runat="server" ID="hfTitle_DialogRequestRegister" meta:resourcekey="hfTitle_DialogRequestRegister" />
    <asp:HiddenField runat="server" ID="hfCloseMessage_RequestRegister" meta:resourcekey="hfCloseMessage_RequestRegister" />
    <asp:HiddenField runat="server" ID="hfErrorType_RequestRegister" meta:resourcekey="hfErrorType_RequestRegister" />
    <asp:HiddenField runat="server" ID="hfConnectionError_RequestRegister" meta:resourcekey="hfConnectionError_RequestRegister" />
    <asp:HiddenField runat="server" ID="hfcmbAlarm_RequestRegister" meta:resourcekey="hfcmbAlarm_RequestRegister" />
    <asp:HiddenField runat="server" ID="hfclmnName_cmbPersonnel_RequestRegister" meta:resourcekey="hfclmnName_cmbPersonnel_RequestRegister" />
    <asp:HiddenField runat="server" ID="hfclmnBarCode_cmbPersonnel_RequestRegister" meta:resourcekey="hfclmnBarCode_cmbPersonnel_RequestRegister" />
    <asp:HiddenField runat="server" ID="hfclmnCardNum_cmbPersonnel_RequestRegister" meta:resourcekey="hfclmnCardNum_cmbPersonnel_RequestRegister" />
    <asp:HiddenField runat="server" ID="hfPersonnelPageSize_RequestRegister" />
    <asp:HiddenField runat="server" ID="hfCurrentDate_RequestRegister" />
    <asp:HiddenField runat="server" ID="hfTitle_DialogCollectiveTraffic" meta:resourcekey="hfTitle_DialogCollectiveTraffic" />
    <asp:HiddenField runat="server" ID="hffooter_GridPersonnel_CollectiveTraffic" meta:resourcekey="hffooter_GridPersonnel_CollectiveTraffic" />
    <asp:HiddenField runat="server" ID="hfheader_Personnel_CollectiveTraffic" meta:resourcekey="hfheader_Personnel_CollectiveTraffic" />
    <asp:HiddenField runat="server" ID="hfloadingPanel_GridPersonnel_CollectiveTraffic"
        meta:resourcekey="hfloadingPanel_GridPersonnel_CollectiveTraffic" />
    <asp:HiddenField runat="server" ID="hfCloseMessage_CollectiveTraffic" meta:resourcekey="hfCloseMessage_CollectiveTraffic" />
    <asp:HiddenField runat="server" ID="hfPersonnelPageSize_Personnel_CollectiveTraffic" />
    <asp:HiddenField runat="server" ID="hfheaderPersonnelCount_RequestRegister" meta:resourcekey="hfheaderPersonnelCount_RequestRegister" />
    <asp:HiddenField runat="server" ID="hfFromDate_tbOverTime_RequestRegister" meta:resourcekey="hfFromDate_tbOverTime_RequestRegister" />
    <asp:HiddenField runat="server" ID="hfDate_tbOverTime_RequestRegister" meta:resourcekey="hfDate_tbOverTime_RequestRegister" />
    </form>
</body>
</html>
