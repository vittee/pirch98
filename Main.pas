unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, TabControl98, ImgList, ExtDlgs, Menus, ExtCtrls,
  DdeMan, ToolWin, Tips, MMSystem;

type
  TMainForm = class(TForm)
    ImageList1: TImageList;
    Image1: TImage;
    TabsMenu: TPopupMenu;
    Alignment1: TMenuItem;
    Top1: TMenuItem;
    Right1: TMenuItem;
    Style2: TMenuItem;
    Color1: TMenuItem;
    Blue1: TMenuItem;
    Red1: TMenuItem;
    N12: TMenuItem;
    Flat1: TMenuItem;
    Buttons1: TMenuItem;
    Tabs1: TMenuItem;
    N13: TMenuItem;
    Blinkonactivity1: TMenuItem;
    ToolBtnMenu: TPopupMenu;
    DeleteToolBarBtn1: TMenuItem;
    MoveButtontotheleft1: TMenuItem;
    MoveButtontotheright1: TMenuItem;
    FavoritesListMenu: TPopupMenu;
    MenuItem4: TMenuItem;
    Recentchannels1: TMenuItem;
    MenuItem5: TMenuItem;
    ServerListMenu: TPopupMenu;
    Edit1: TMenuItem;
    MenuItem1: TMenuItem;
    SpeechDDEClientItem: TDdeClientConv;
    SaveDialog: TSaveDialog;
    FontDialog1: TFontDialog;
    OpenDialog: TOpenDialog;
    MainMenu: TMainMenu;
    Server1: TMenuItem;      // TODO: WMDrawItem
    IRCConnect: TMenuItem;
    IRCServerList: TMenuItem;
    IRCAutoconnectSetup: TMenuItem;
    N9: TMenuItem;
    IRCProxySetup: TMenuItem;
    N8: TMenuItem;
    IRCPrinterSetup: TMenuItem;
    IRCPrint: TMenuItem;
    N1: TMenuItem;
    IRCExit: TMenuItem;
    Tools1: TMenuItem;
    ToolsFavoriteChannels: TMenuItem;
    ToolsWorldWideWebLinks: TMenuItem;
    ToolsFingerClient: TMenuItem;
    ToolsIdentServer: TMenuItem;
    ToolsMediaControlPanel: TMenuItem;
    ToolsBioViewer: TMenuItem;
    ToolsNotifyWindow: TMenuItem;
    ToolsFileServer: TMenuItem;
    ToolsVideoServer: TMenuItem;
    N4: TMenuItem;
    ToolsAliases: TMenuItem;
    ToolsEventsControls: TMenuItem;
    ToolsPopups: TMenuItem;
    N6: TMenuItem;
    DCCManager1: TMenuItem;
    ToolsDCCFileSender: TMenuItem;
    DccChat1: TMenuItem;
    Options1: TMenuItem;
    OptionsPreferences: TMenuItem;
    OptionsColors: TMenuItem;
    OptionsDCCExtensionMap: TMenuItem;
    OptionsPersonalBio: TMenuItem;
    OptionsTexttoSpeech: TMenuItem;
    OptionsAutoexecCommands: TMenuItem;
    N5: TMenuItem;
    OptionsDesktopOptions: TMenuItem;
    N10: TMenuItem;
    OptionsToolbar: TMenuItem;
    OptionsToolbarCustomize: TMenuItem;
    OptionsToolbarVisible: TMenuItem;
    Window1: TMenuItem;
    WindowCascade: TMenuItem;
    WindowTile: TMenuItem;
    WindowArrangeIcons: TMenuItem;
    WindowMinimizeAll: TMenuItem;
    WindowClose: TMenuItem;
    Help1: TMenuItem;
    HelpContents: TMenuItem;
    HelpCommandReference: TMenuItem;
    HelpSearch: TMenuItem;
    HelpTips: TMenuItem;
    N3: TMenuItem;
    HelpRegistrationForm: TMenuItem;
    N7: TMenuItem;
    HelpUpdates: TMenuItem;
    N2: TMenuItem;
    HelpAbout: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    TimeOutTimer: TTimer;
    LogoPopupmenu: TPopupMenu;
    LiveChatEventSchedule1: TMenuItem;
    UpdateIRCServerListing1: TMenuItem;
    ToolbarPopupMenu: TPopupMenu;
    Align1: TMenuItem;
    Left2: TMenuItem;
    Right2: TMenuItem;
    Top2: TMenuItem;
    Bottom2: TMenuItem;
    Style1: TMenuItem;
    TextOnly1: TMenuItem;
    IconsOnly1: TMenuItem;
    TextIcons1: TMenuItem;
    N14: TMenuItem;
    Flat2: TMenuItem;
    Classic1: TMenuItem;
    N11: TMenuItem;
    MenuItem2: TMenuItem;
    OpenPictureDialog: TOpenPictureDialog;
    CoolBar1: TCoolBar;
    LogoPanel: TPanel;
    ToolBtnPanel: TToolBar;
    WindowTabs1: TTabControl98;
    Tips: TTips;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IRCExitClick(Sender: TObject);
    procedure IRCConnectClick(Sender: TObject);
    procedure IRCServerListClick(Sender: TObject);
    procedure IRCAutoconnectSetupClick(Sender: TObject);
    procedure IRCProxySetupClick(Sender: TObject);
    procedure IRCPrinterSetupClick(Sender: TObject);
    procedure IRCPrintClick(Sender: TObject);
    procedure ToolsFavoriteChannelsClick(Sender: TObject);
    procedure ToolsWorldWideWebLinksClick(Sender: TObject);
    procedure ToolsFingerClientClick(Sender: TObject);
    procedure ToolsIdentServerClick(Sender: TObject);
    procedure ToolsMediaControlPanelClick(Sender: TObject);
    procedure ToolsBioViewerClick(Sender: TObject);
    procedure ToolsNotifyWindowClick(Sender: TObject);
    procedure ToolsFileServerClick(Sender: TObject);
    procedure ToolsVideoServerClick(Sender: TObject);
    procedure ToolsAliasesClick(Sender: TObject);
    procedure ToolsEventsControlsClick(Sender: TObject);
    procedure ToolsPopupsClick(Sender: TObject);
    procedure DCCManager1Click(Sender: TObject);
    procedure ToolsDCCFileSenderClick(Sender: TObject);
    procedure DccChat1Click(Sender: TObject);
    procedure OptionsPreferencesClick(Sender: TObject);
    procedure OptionsColorsClick(Sender: TObject);
    procedure OptionsDCCExtensionMapClick(Sender: TObject);
    procedure OptionsPersonalBioClick(Sender: TObject);
    procedure OptionsTexttoSpeechClick(Sender: TObject);
    procedure OptionsAutoexecCommandsClick(Sender: TObject);
    procedure OptionsDesktopOptionsClick(Sender: TObject);
    procedure OptionsToolbarCustomizeClick(Sender: TObject);
    procedure OptionsToolbarClick(Sender: TObject);
    procedure OptionsToolbarVisibleClick(Sender: TObject);
    procedure WindowCascadeClick(Sender: TObject);
    procedure WindowTileClick(Sender: TObject);
    procedure WindowArrangeIconsClick(Sender: TObject);
    procedure WindowMinimizeAllClick(Sender: TObject);
    procedure WindowCloseClick(Sender: TObject);
    procedure HelpContentsClick(Sender: TObject);
    procedure HelpCommandReferenceClick(Sender: TObject);
    procedure HelpSearchClick(Sender: TObject);
    procedure HelpTipsClick(Sender: TObject);
    procedure HelpRegistrationFormClick(Sender: TObject);
    procedure HelpUpdatesClick(Sender: TObject);
    procedure HelpAboutClick(Sender: TObject);
    procedure TimeOutTimerTimer(Sender: TObject);
    procedure SpeechDDEClientItemClose(Sender: TObject);
    procedure SpeechDDEClientItemOpen(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FMenuBitmap: TBitmap;
    FMenuHeight: Integer;
    FClientWndProcPtr: Pointer;
    FPrevClientProc: Pointer;

    procedure ClientWndProc(var Message: TMessage);
    //
    procedure WMMeasureItem(var Message: TWMMeasureItem); message WM_MEASUREITEM;
    procedure WMDrawItem(var Message: TWMDrawItem); message WM_DRAWITEM;
    // TODO: WM_803
    //
    procedure HandleOnMessage(var Msg: TMsg; var Handled: Boolean);
    //
    procedure LoadTips;
  public
    { Public declarations }

    ShowTips: Boolean;
  end;

  // TODO: UpdateMenuItems (Event)

var
  MainForm: TMainForm;

implementation

uses Math, IniFiles;

{$R *.dfm}

var
  MenuLogoBitmap: HBITMAP;

procedure TMainForm.FormCreate(Sender: TObject);
var
  dc: HDC;
begin
  // TODO: PIRCHUTL.INI

  dc := GetDC(Handle);
  GetDeviceCaps(dc, COLORRES);
  ReleaseDC(Handle, dc);

  // TODO: call 4D158C

  // 004CB641
  FMenuBitmap := TBitmap.Create;
  FMenuBitmap.Handle := MenuLogoBitmap;

  InsertMenu(Server1.Handle, 0, MF_BYPOSITION or MF_OWNERDRAW, 0, PChar(FMenuBitmap.Handle));

  // 004cb689
  FClientWndProcPtr := Classes.MakeObjectInstance(ClientWndProc);
  FPrevClientProc := Pointer(GetWindowLong(Handle, GWL_WNDPROC));
  Randomize;

  // TODO:
  // Application.On?? (TNotifyEvent)
  // Application.OnException :=
  Application.OnMessage := HandleOnMessage;
  // TODO: Screen.OnActiveFormChange := UpdateMenuItems;

  // 004CB75B
  // TODO: TStringList

  // 004cb78e
  with TIniFile.Create('PIRCHUTL.INI') do
  begin
    ReadString()
  end;

  // 004CBC0B
  ShowTips := Tips.LoadFromRegistry;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FMenuBitmap) then
  begin
    FMenuBitmap.Handle := 0;
    FMenuBitmap.Free;
  end;

  // 004CC1AE
  // TODO:
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // TODO:
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  // TODO: Resize
end;

procedure TMainForm.IRCExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.IRCConnectClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.IRCServerListClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.IRCAutoconnectSetupClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.IRCProxySetupClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.IRCPrinterSetupClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TMainForm.IRCPrintClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsFavoriteChannelsClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsWorldWideWebLinksClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsFingerClientClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsIdentServerClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsMediaControlPanelClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsBioViewerClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsNotifyWindowClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsFileServerClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsVideoServerClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsAliasesClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsEventsControlsClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsPopupsClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.DCCManager1Click(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.ToolsDCCFileSenderClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.DccChat1Click(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.OptionsPreferencesClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.OptionsColorsClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.OptionsDCCExtensionMapClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.OptionsPersonalBioClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.OptionsTexttoSpeechClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.OptionsAutoexecCommandsClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.OptionsDesktopOptionsClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.OptionsToolbarClick(Sender: TObject);
begin
  OptionsToolbarVisible.Checked := ToolBtnPanel.Visible;
end;

procedure TMainForm.OptionsToolbarCustomizeClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.OptionsToolbarVisibleClick(Sender: TObject);
begin
  OptionsToolbarVisible.Checked := not OptionsToolbarVisible.Checked;
  ToolBtnPanel.Visible := OptionsToolbarVisible.Checked;
end;

procedure TMainForm.WindowCascadeClick(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.WindowTileClick(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.WindowArrangeIconsClick(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainForm.WindowMinimizeAllClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.WindowCloseClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.HelpContentsClick(Sender: TObject);
begin
  Application.HelpContext(3);
end;

procedure TMainForm.HelpCommandReferenceClick(Sender: TObject);
begin
  Application.HelpContext(32);
end;

procedure TMainForm.HelpSearchClick(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.HelpTipsClick(Sender: TObject);
begin
  if Tips.Tips.Count = 0 then
  begin
    LoadTips;
  end;

  Tips.Execute;
end;

procedure TMainForm.HelpRegistrationFormClick(Sender: TObject);
begin
  // TODO: register.txt
end;

procedure TMainForm.HelpUpdatesClick(Sender: TObject);
begin
  // TODO: updates.txt
end;

procedure TMainForm.HelpAboutClick(Sender: TObject);
begin
  // TODO: TAboutBox ShowModal
end;

procedure TMainForm.TimeOutTimerTimer(Sender: TObject);
begin
  // TODO:
end;

procedure TMainForm.SpeechDDEClientItemClose(Sender: TObject);
begin
  SpeechDDEClientItem.ConnectMode := ddeManual;
end;

procedure TMainForm.SpeechDDEClientItemOpen(Sender: TObject);
begin
  ;
end;

procedure TMainForm.LoadTips;
begin
  // TODO:
end;

var
  Initialized: Boolean = false;

procedure TMainForm.WMMeasureItem(var Message: TWMMeasureItem);
begin
  if FindControl(Message.IDCtl) = nil then
  begin
    // For Menu
    Message.MeasureItemStruct.itemWidth := FMenuBitmap.Width - GetSystemMetrics(SM_CXMENUCHECK);
    Message.Result := 0;
  end else
  begin
    // TODO: Use Image2 for measurement
  end;
end;

procedure TMainForm.WMDrawItem(var Message: TWMDrawItem);
var
  r, r2: TRect;
  bitmapDC: HDC;
begin
  if FindControl(Message.Ctl) = nil then
  begin
    // For Menu

    Windows.GetMenuItemRect(Handle, Server1.Handle, 0, r);
    Windows.GetClientRect(Message.DrawItemStruct.hwndItem, r2);
    Windows.GetClipBox(Message.DrawItemStruct.hDC, r2);
    //
    FMenuHeight := r2.Bottom - r2.Top;
    //
    bitmapDC := CreateCompatibleDC(Message.DrawItemStruct.hDC);
    SelectObject(bitmapDC, FMenuBitmap.Handle);

    BitBlt(
      Message.DrawItemStruct.hDC,
      Message.DrawItemStruct.rcItem.Top,
      FMenuHeight - FMenuBitmap.Height,
      Message.DrawItemStruct.rcItem.Right,
      FMenuBitmap.Height,
      bitmapDC,
      0,
      0,
      SRCCOPY
    );

    DeleteDC(bitmapDC);
  end else
  begin
    // TODO: For something else
  end;
end;

procedure TMainForm.ClientWndProc(var Message: TMessage);
begin
  ;
end;

procedure TMainForm.HandleOnMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.message = $803 then
  begin
    SendMessage(Application.MainForm.Handle, Msg.message, Msg.wParam, Msg.lParam);
  end;
end;

initialization
  MenuLogoBitmap := LoadBitmap(HInstance, 'BMP_MENULOGO');
  Initialized := True;


finalization
  if Initialized and (MenuLogoBitmap <> 0) then
    DeleteObject(MenuLogoBitmap);

end.

