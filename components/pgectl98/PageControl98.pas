////////////////////////////////////////////////////////////////////////////////
// PAGECONTROL98                                                              //
////////////////////////////////////////////////////////////////////////////////
// Enhanced PageControl for D2 & D3                                           //
// * Image List, Right & Left Tabs, ...                                       //
////////////////////////////////////////////////////////////////////////////////
// Version 2.16                                                               //
// Date de création           : 10/03/1997                                    //
// Date dernière modification : 18/03/1998                                    //
////////////////////////////////////////////////////////////////////////////////
// Jean-Luc Mattei                                                            //
// jlucm@club-internet.fr  / jlucm@mygale.org                                 //
////////////////////////////////////////////////////////////////////////////////
// IMPORTANT NOTICE :                                                         //
//                                                                            //
//                                                                            //
// This program is FreeWare                                                   //
//                                                                            //
// Please do not release modified versions of this source code.               //
// If you've made any changes that you think should have been there,          //
// feel free to submit them to me at jlucm@club-internet.fr                   //
////////////////////////////////////////////////////////////////////////////////
//  REVISIONS :                                                               //
//                                                                            //
//  1.00 :                                                                    //
//         * Added .DCR                                                       //
//  1.10 : * CommCtrlEx.pas included (for D2)                                 //
//         * TNMCustomDraw Ok (for D2)                                        //
//  1.20 : * Added FlatButtons style (IE4 installed only)                     //
//  1.30 : * Added MeasureItem                                                //
//         * Added Image drawing                                              //
//  1.40 : * CommCtrlEx Modified for D2 (thanks to Gerhard Volk)              //
//         * TDrawTabEvent, TMeasureTabEvent Pagre parameter changed from     //
//           TPageControl to TPageControl98 (thanks to Marcus Monnig)         //
//  1.50 : * CustomPageControl98 allows hidden properties                     //
//         * TTabSheet98 allows selecting imageindex for a page               //
//         * ENGLISH and FRANCAIS compiler directive for messages langage     //
//  1.60 : * Removed unused properties                                        //
//         * Sme declaration modified for D2 compatibility                   //
//           (thanks to Gerhard Volk - again - for all the tests :-))         //
//         * Unified version number                                           //
//  1.70 : * See TabControl98 for changes                                     //
//         * Disabled Pages Painting (Roger Misteli)                          //
//         * Disabled Pages can't be selected now (Roger Misteli)             //
//         * TabSheet98 has a Color property now                              //
//  1.80 : * New DrawTab Painting method to avoid strange borders             //
//         * LockWindowUpdate removed to avoid entire screen flickering       //
//         * PageHint for each Page                                           //
//         * No more "PageIndex invalid" message when Position is left / right//
//         * Font can be choosen for each Tab (TabFont property)              //
//         * New Paint method for "colorized" Pages                           //
//         * TTabShhet SetImageIndex modified to correctly handle imageindex  //
//           when some pages are not visible (thanks to Fred Covely)          //
//  1.90 : * New TabSheet98 propertie Data (a pointer) and a new even         //
//         * OnDestroy (Added by Rafal Smotrzyk)                              //
//  1.91 : * New WMPaint method for Colorized Pages : no more control         //
//           "overdrawing" (Thanks again to Rafal Smotrzyk)                   //
//  1.95 : * New proc BorderColorPaint to handle correctly PageBorder color   //
//           (if you have a client aligned control in your TabSheet border is //
//            drawn correctly)                                                //
//         * When you change TabPosition at runtime tabs looks ok now         //
//           (if you have more than on tab)                                   //
//         * BorderColor is not drawn if Button or IE4 Button Style           //
//         * BUG : If you are in Left or right BUTTON mode tabsheet have a    //
//           strange size (half size) if someone find why ....                //
//         * Images are still visible at design time when you change a        //
//           "RecreateWindow Property" like Pagecontrol.Color                 //
//           (thanks to Richard Chang for his comments)                       //
//         * NEED TABCONTROL98 V 1.95                                         //
//  1.96 : * ToolTip GPF Bug corrected                                        //
//  1.97 : * Works with D2 (CM_RECREATEWND replaced by CM_SHOWINGCHANGED)     //
//         * Uses ComCtl98.pas for D2 & D3                                    //
//  1.98 : * Some bugs removed                                                //
//  1.99 : * More bugs removed (thanks to Edward Zhuravlov)                   //
//  2.00 : * IconJustification properties (thanks to Wayne Niddery)           //
//  2.01 : * Bug corrected (If you didn't used ImageList there were errors).  //
//           Thanks to Adrian Logan and Alper Yazgan.                         //
//  2.10 : * NEED TABCONTROL98 V 2.10                                         //
//         * Bug corrected (If you didn't used ImageList there were errors).  //
//           Thanks to Adrian Logan and Alper Yazgan.                         //
//           this time is the good one :-)                                    //
//  2.11 : * TabSheet Font is destroyed now (thanks to Olivier Grosclaude)    //
//  2.12 : * AnsiString added for GetVerb (compiles with short strings        //
//           compiler options on)                                             //
//  2.13 : * OnChange Event occurs only one time now                          //
//         * Border color don't overlap controls when Tabs are Left / Right or//
//           Bottom. (thanks to Jérôme Bouvattier)                            //
//  2.14 : * Transparent property added                                       //
//         * OnGetTabColor change TabColor only                               //
//  2.15 : * TabIndex Property is public, you can use it to know activepage   //
//  2.16 : * Spanish version added (thanks to Carlos Ponce de León)           //
//         * Property Tabs is public in TCustomTabControl98 (V 2.14)          //
//         * SetActivePage and ChangeActivePage Modified                      //
//           (thanks to Shraga Milon)                                         //
////////////////////////////////////////////////////////////////////////////////

{$define FRANCAIS}
//{$define ENGLISH}

unit PageControl98;

interface

// Remove this line if 'Duplicate resource' compiler error
//{$R *.DCR}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Controls, Dialogs,
  CommCtrl, ComCtrls, TabControl98, ComCtl98;

type

  TCustomPageControl98 = class;
  TTabSheet98 = class;
  TTabSheet98Event = procedure(asheet : TTabSheet98) of object;

  TTabSheet98 = class(TWinControl)
  private
    FPageControl: TCustomPageControl98;
    FTabVisible: Boolean;
    FTabShowing: Boolean;
    FImageIndex: Integer;
    FTabFont: TFont;
    FData: Pointer;
    FOnDestroy: TTabSheet98Event;
    procedure SetImageIndex(Value: Integer);
    function GetPageIndex: Integer;
    function GetTabIndex: Integer;
    procedure SetPageControl(APageControl: TCustomPageControl98);
    procedure SetPageIndex(Value: Integer);
    procedure SetTabShowing(Value: Boolean);
    procedure SetTabVisible(Value: Boolean);
    procedure UpdateTabShowing;
    function  GetColor: TColor;
    procedure SetColor(Value: TColor);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    Procedure setTabFont(Value: TFont);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ReadState(Reader: TReader); override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure BorderColorPaint;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property PageControl: TCustomPageControl98 read FPageControl write SetPageControl;
    property TabIndex: Integer read GetTabIndex;
    property Data: Pointer read FData write FData;
  published
    property Color: TColor read GetColor write SetColor;
    property Caption;
    property Enabled;
    property Font;
    property TabFont: TFont read FTabFont write SetTabFont;
    property Hint;
    property Height stored False;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Left stored False;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabVisible: Boolean read FTabVisible write SetTabVisible default True;
    property Top stored False;
    property Visible stored False;
    property Width stored False;
    property OnDestroy: TTabSheet98Event read FOnDestroy write FOnDestroy;
    property OnDragDrop;
    property OnDragOver;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TCustomPageControl98 = class(TCustomTabControl98)
  private
    FPages: TList;
    FActivePage: TTabSheet98;
    FLastOne: TTabSheet98;
    procedure ChangeActivePage(Page: TTabSheet98);
    procedure DeleteTab(Page: TTabSheet98);
    function GetPage(Index: Integer): TTabSheet98;
    function GetPageCount: Integer;
    procedure InsertPage(Page: TTabSheet98);
    procedure InsertTab(Page: TTabSheet98);
    procedure MoveTab(CurIndex, NewIndex: Integer);
    procedure RemovePage(Page: TTabSheet98);
    procedure SetActivePage(Page: TTabSheet98);
    procedure UpdateTab(Page: TTabSheet98);
    procedure UpdateActivePage;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
  protected
    procedure SetTransparent(Value: Boolean); override;
    procedure SetTabPosition (Value: TTabPosition); override;
    procedure Change; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure ShowControl(AControl: TControl); override;
    procedure AssociateImages; override;
  public
    constructor Create(AOwner: TComponent); override;
    //property TabIndex;
    destructor Destroy; override;
    function FindNextPage(CurPage: TTabSheet98;
      GoForward, CheckTabVisible: Boolean): TTabSheet98;
    procedure SelectNextPage(GoForward: Boolean);
    property PageCount: Integer read GetPageCount;
    property Pages[Index: Integer]: TTabSheet98 read GetPage;
    property ActivePage: TTabSheet98 read FActivePage write SetActivePage;
  end;

  TPageControl98 = class(TCustomPageControl98)
  published
    property Color;
    property DefaultDrawing;
    property DrawStyle;
    property Images;
    property MultiSelect;
    property TabPosition;
    {$ifndef VER100}
    property TabType;
    {$endif}
    property TabStyle;
    property TabJustification;
    property TabIconJustification;
    property OnDrawTab;
    property OnMeasureTab;
    property OnGetTabColor;

    property ActivePage;
    property Align;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HotTrack;
    property MultiLine;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    {$ifdef VER100}
    property ScrollOpposite;
    {$endif}
    property ShowHint;
    property TabHeight;
    property TabOrder;
    property TabStop;
    property TabWidth;
    property Transparent;
    property Visible;
    property OnChange;
    property OnChanging;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

implementation

const
  {$ifdef ENGLISH}
  SPage98IndexError = 'Sheet index Error';
  {$endif}

  {$ifdef ESPANOL}
  SPage98IndexError = 'Indice de página incorrecto';
  {$endif}

  {$ifdef FRANCAIS}
  SPage98IndexError = 'Index de page incorect';
  {$endif}


{ TTabSheet98 }

constructor TTabSheet98.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible, csOpaque] - [csFramed];
  Visible := False;
  FTabVisible := True;
  FImageIndex:= -1;
  FTabFont:= TFont.Create;
  FTabFont.Name:= 'Arial';
  FOnDestroy:= nil;
  FData:= nil;
end;

procedure TTabSheet98.SetTabFont(Value: TFont);
begin
  FTabFont.Assign(Value);
end;

procedure TTabSheet98.SetImageIndex(Value: Integer);
begin
  if ( PageControl is TCustomPageControl98 ) then begin
    FImageIndex:= Value;
    with ( PageControl as TCustomPageControl98 ) do begin
      if ( PageIndex >= 0 ) and ( PageIndex < PageCount ) then
        // Modifié par Fred Covely - Gestion des images correcte avec pages invisibles
        Image[Self.TabIndex]:= FImageIndex;
    end;
  end
end;

destructor TTabSheet98.Destroy;
begin
  FTabFont.Free;
  if Assigned(FOnDestroy) then FOnDestroy(Self);
  if FPageControl <> nil then FPageControl.RemovePage(Self);
  inherited Destroy;
end;

function TTabSheet98.GetPageIndex: Integer;
begin
  if FPageControl <> nil then
    Result := FPageControl.FPages.IndexOf(Self) else
    Result := -1;
end;

function TTabSheet98.GetTabIndex: Integer;
var
  I: Integer;
begin
  Result := 0;
  if not FTabShowing then Dec(Result) else
    for I := 0 to PageIndex - 1 do
      if TTabSheet98(FPageControl.FPages[I]).FTabShowing then
        Inc(Result);
end;

procedure TTabSheet98.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    style := style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TTabSheet98.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TCustomPageControl98 then
    PageControl := TCustomPageControl98(Reader.Parent);
end;

procedure TTabSheet98.WMPaint(var Message: TWMPaint);
begin
  BorderColorPaint;
  inherited;
end;

procedure TTabSheet98.BorderColorPaint;
var
  R, RTab, RPCli, R1: TRect;
  Dc: HDC;

begin
  if ( FPageControl.TabStyle <> tsDefault ) then Exit;
  R:= BoundsRect;
  ValidateRect(FPageControl.Handle, @R);
  TabCtrl_GetItemRect(FPageControl.Handle, PageIndex, RTab);
  RPCli:= FPageControl.GetClientRect;
  InflateRect(RPCli, -2, -2);
  case FPageControl.TabPosition of
    tpTop    : RPCli.Top:= RTab.Bottom + 2;
    tpBottom : RPCli.Bottom:= RTab.Top - 2;
    tpLeft   : RPCli.Left:= RTab.Right + 2;
    tpRight  : RPCli.Right:= RTab.Left - 2;
  end;
  R:= RPCli;
  Dc:= GetWindowDC(FPageControl.Handle);
  R1:= R;
  R1.Left:= R1.Right-2;
  if ( FPageControl.TabPosition <> tpRight) then
    FillRect(Dc, R1, Brush.Handle);
  R1:= R;
  R1.Right:= R1.Left+2;
  if ( FPageControl.TabPosition <> tpLeft) then
    FillRect(Dc, R1, Brush.Handle);
  R1:= R;
  R1.Top:= R1.Bottom-2;
  if ( FPageControl.TabPosition <> tpBottom) then
    FillRect(Dc, R1, Brush.Handle);
  R1:= R;
  if ( FPageControl.TabPosition = tpTop ) then
    R1.Bottom:= R1.Top+2
  else
    R1.Bottom:= R1.Top+4;
  FillRect(Dc, R1, Brush.Handle);
  ReleaseDC(FPageControl.Handle, Dc);
end;

procedure TTabSheet98.SetPageControl(APageControl: TCustomPageControl98);
begin
  if FPageControl <> APageControl then
  begin
    if FPageControl <> nil then FPageControl.RemovePage(Self);
    Parent := APageControl;
    if APageControl <> nil then APageControl.InsertPage(Self);
  end;
end;

procedure TTabSheet98.SetPageIndex(Value: Integer);
var
  I, MaxPageIndex: Integer;
begin
  if FPageControl <> nil then
  begin
    MaxPageIndex := FPageControl.FPages.Count - 1;
    if Value > MaxPageIndex then
      raise EListError.CreateFmt(SPage98IndexError, [Value, MaxPageIndex]);
    I := TabIndex;
    FPageControl.FPages.Move(PageIndex, Value);
    if I >= 0 then FPageControl.MoveTab(I, TabIndex);
  end;
end;

procedure TTabSheet98.SetTabShowing(Value: Boolean);
begin
  if FTabShowing <> Value then
    if Value then
    begin
      FTabShowing := True;
      FPageControl.InsertTab(Self);
    end else
    begin
      FPageControl.DeleteTab(Self);
      FTabShowing := False;
    end;
end;

procedure TTabSheet98.SetTabVisible(Value: Boolean);
begin
  if FTabVisible <> Value then
  begin
    FTabVisible := Value;
    UpdateTabShowing;
  end;
end;

procedure TTabSheet98.UpdateTabShowing;
begin
  SetTabShowing((FPageControl <> nil) and FTabVisible);
end;

procedure TTabSheet98.CMTextChanged(var Message: TMessage);
begin
  if FTabShowing then FPageControl.UpdateTab(Self);
end;

function TTabSheet98.GetColor: TColor;
begin
  Result:= Brush.Color;
end;

procedure TTabSheet98.SetColor(Value: TColor);
begin
  Brush.Color:= Value;
  Invalidate;
end;

{ TCustomPageControl98 }

constructor TCustomPageControl98.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csDoubleClicks];
  FPages := TList.Create;
end;

destructor TCustomPageControl98.Destroy;
var
  I: Integer;
begin
  for I := 0 to FPages.Count - 1 do TTabSheet98(FPages[I]).FPageControl := nil;
  FPages.Free;
  inherited Destroy;
end;

procedure TCustomPageControl98.Change;
var
  Form: {$ifdef VER100} TCustomForm {$else} TForm {$endif};
begin
  UpdateActivePage;
  if csDesigning in ComponentState then
  begin
    Form := TForm(GetParentForm(Self));
    if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
  end;
  inherited Change;
end;

procedure TCustomPageControl98.ChangeActivePage(Page: TTabSheet98);
var
  ParentForm: {$ifdef VER100} TCustomForm {$else} TForm {$endif};
begin
  if FActivePage <> Page then
  begin
    ParentForm := TForm(GetParentForm(Self));
    if (ParentForm <> nil) and (FActivePage <> nil) and
        FActivePage.ContainsControl(ParentForm.ActiveControl) then begin
      ParentForm.ActiveControl := FActivePage;
      // *** You must be sure that the ParentForm.ActiveControl succeeded,
      //  only when ParentForm.ActiveControl = FActivePage and then continue,
      //  else exit from here.
      if ParentForm.ActiveControl <> FActivePage then begin
        TabIndex := FActivePage.TabIndex;
        Exit;
      end;
    end;
    if Page <> nil then
    begin
      Page.BringToFront;
      Page.Visible := True;
      Page.BorderColorPaint;
      if (ParentForm <> nil) and (FActivePage <> nil) and
        (ParentForm.ActiveControl = FActivePage) then
        if Page.CanFocus then
          ParentForm.ActiveControl := Page else
          ParentForm.ActiveControl := Self;
    end;
    if FActivePage <> nil then FActivePage.Visible := False;
    FActivePage := Page;
    if (ParentForm <> nil) and (FActivePage <> nil) and
      (ParentForm.ActiveControl = FActivePage) then
      FActivePage.SelectFirst;
  end;
end;

procedure TCustomPageControl98.DeleteTab(Page: TTabSheet98);
begin
  Tabs.Delete(Page.TabIndex);
  UpdateActivePage;
end;

function TCustomPageControl98.FindNextPage(CurPage: TTabSheet98;
  GoForward, CheckTabVisible: Boolean): TTabSheet98;
var
  I, StartIndex: Integer;
begin
  if FPages.Count <> 0 then
  begin
    StartIndex := FPages.IndexOf(CurPage);
    if StartIndex = -1 then
      if GoForward then StartIndex := FPages.Count - 1 else StartIndex := 0;
    I := StartIndex;
    repeat
      if GoForward then
      begin
        Inc(I);
        if I = FPages.Count then I := 0;
      end else
      begin
        if I = 0 then I := FPages.Count;
        Dec(I);
      end;
      Result := FPages[I];
      if not CheckTabVisible or Result.TabVisible then Exit;
    until I = StartIndex;
  end;
  Result := nil;
end;

procedure TCustomPageControl98.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to FPages.Count - 1 do Proc(TComponent(FPages[I]));
end;

function TCustomPageControl98.GetPage(Index: Integer): TTabSheet98;
begin
  Result := FPages[Index];
end;

function TCustomPageControl98.GetPageCount: Integer;
begin
  Result := FPages.Count;
end;

procedure TCustomPageControl98.InsertPage(Page: TTabSheet98);
begin
  FPages.Add(Page);
  Page.FPageControl := Self;
  Page.UpdateTabShowing;
end;

procedure TCustomPageControl98.InsertTab(Page: TTabSheet98);
begin
  Tabs.InsertObject(Page.TabIndex, Page.Caption, Page);
  UpdateActivePage;
end;

procedure TCustomPageControl98.MoveTab(CurIndex, NewIndex: Integer);
begin
  Tabs.Move(CurIndex, NewIndex);
end;

procedure TCustomPageControl98.RemovePage(Page: TTabSheet98);
begin
  if FActivePage = Page then SetActivePage(nil);
  Page.SetTabShowing(False);
  Page.FPageControl := nil;
  FPages.Remove(Page);
end;

procedure TCustomPageControl98.SelectNextPage(GoForward: Boolean);
var
  Page: TTabSheet98;
begin
  Page := FindNextPage(ActivePage, GoForward, True);
  if (Page <> nil) and (Page <> ActivePage) and CanChange then
  begin
    TabIndex := Page.TabIndex;
    Change;
  end;
end;

procedure TCustomPageControl98.SetActivePage(Page: TTabSheet98);
begin
  if (Page <> nil) and (Page.PageControl <> Self) then Exit;
  ChangeActivePage(Page);
  if Page = nil then
    TabIndex := -1
  // *** You must be sure that the ChangeActivePage succeeded,
  //   and only then you can change the value of TabIndex.
  else
    if Page = FActivePage then
      TabIndex := Page.TabIndex;
end;

procedure TCustomPageControl98.SetChildOrder(Child: TComponent; Order: Integer);
begin
  TTabSheet98(Child).PageIndex := Order;
end;

procedure TCustomPageControl98.ShowControl(AControl: TControl);
begin
  if (AControl is TTabSheet98) and (TTabSheet98(AControl).PageControl = Self) then
    SetActivePage(TTabSheet98(AControl));
  inherited ShowControl(AControl);
end;

procedure TCustomPageControl98.UpdateTab(Page: TTabSheet98);
begin
  Tabs[Page.TabIndex] := Page.Caption;
end;

procedure TCustomPageControl98.UpdateActivePage;
begin
  if TabIndex >= 0 then SetActivePage(TTabSheet98(Tabs.Objects[TabIndex]));
end;

procedure TCustomPageControl98.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  HitIndex: Integer;
  HitTestInfo: TTCHitTestInfo;
begin
  HitTestInfo.pt := SmallPointToPoint(Message.Pos);
  HitIndex := SendMessage(Handle, TCM_HITTEST, 0, Longint(@HitTestInfo));
  if (HitIndex >= 0) and (HitIndex <> TabIndex) then Message.Result := 1;
end;

procedure TCustomPageControl98.CMDialogKey(var Message: TCMDialogKey);
begin
  if (Message.CharCode = VK_TAB) and (GetKeyState(VK_CONTROL) < 0) then
  begin
    SelectNextPage(GetKeyState(VK_SHIFT) >= 0);
    Message.Result := 1;
  end else
    inherited;
end;

procedure TCustomPageControl98.AssociateImages;
Var
  i: Integer;
begin
  if ( Images = nil ) then Exit;
  for i:= 0 to PageCount - 1 do begin
    if ( Pages[i].ImageIndex < Images.Count ) then
      Image[i]:= Pages[i].ImageIndex;
  end;
end;

procedure TCustomPageControl98.SetTransparent(Value: Boolean);
Var Keep: Integer;
begin
  if HandleAllocated and ( Transparent <> Value ) then begin
    inherited SetTransparent(Value);
    Keep:= ActivePage.PageIndex;
    if ( ( Keep + 1 ) < PageCount ) then
      ActivePage:= Pages[Keep+1]
    else
      if ( ( Keep - 1 ) >= 0 ) then
        ActivePage:= Pages[Keep-1];
    ActivePage:= Pages[Keep];
  end
  else
    inherited SetTransparent(Value);
end;

procedure TCustomPageControl98.SetTabPosition (Value: TTabPosition);
Var Keep: Integer;
begin
  if HandleAllocated and ( Value <> TabPosition ) then begin
    inherited SetTabPosition(Value);
    Keep:= ActivePage.PageIndex;
    if ( ( Keep + 1 ) < PageCount ) then
      ActivePage:= Pages[Keep+1]
    else
      if ( ( Keep - 1 ) >= 0 ) then
        ActivePage:= Pages[Keep-1];
    ActivePage:= Pages[Keep];
  end
  else
    inherited SetTabPosition(Value);
end;

procedure TCustomPageControl98.WMNotify(var Message: TWMNotify);
var
  HitIndex: Integer;
  HitTestInfo: TTCHitTestInfo;
begin
  with Message.NMHdr^ do
    case code of
      TTN_NEEDTEXT:
        with Message do begin
          Windows.GetCursorPos(HitTestInfo.pt);
          HitTestInfo.pt:= ScreenToClient(HitTestInfo.pt);
          HitIndex:= SendMessage(Handle, TCM_HITTEST, 0, Longint(@HitTestInfo));
          if (HitIndex <> -1) and (Pages[HitIndex].Hint <> '') then
            strPCopy(PToolTipText(NMHdr)^.szText,Copy(Pages[HitIndex].Hint, 0, 80))
          else
            strPCopy(PToolTipText(NMHdr)^.lpszText,Copy(Hint, 0, 80));
          PToolTipText(NMHdr)^.lpszText:= PToolTipText(NMHdr)^.szText;
          PToolTipText(NMHdr)^.hInst := 0;
          SetWindowPos(NMHdr^.hwndFrom, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or
          SWP_NOSIZE or SWP_NOMOVE);
          Result := 1;
        end;
      NM_HOVER :
        begin
          //MessageBeep(MB_Ok);
        end;
    end;
  inherited;
end;

procedure TCustomPageControl98.CNNotify(var Message: TWMNotify);
begin
  with Message.NMHdr^ do
    case code of
      TCN_SELCHANGE:   begin
                         Change;
                         if not ActivePage.Enabled then
                           ActivePage:=FLastOne;
                         Exit;
                         //LockWindowUpdate(0);
                       end;
      TCN_SELCHANGING: begin
                         Message.Result := 1;
                         if CanChange then
                           Message.Result := 0;
                         FLastOne:=ActivePage;
                         Exit;
                         //LockWindowUpdate(Handle);
                       end;
      NM_HOVER :
        begin
          //MessageBeep(MB_Ok);
        end;
    end;
  inherited;
end;

end.



