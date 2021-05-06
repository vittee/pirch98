////////////////////////////////////////////////////////////////////////////////
// TABCONTROL98                                                               //
////////////////////////////////////////////////////////////////////////////////
// Enhanced TabControl for D2 & D3                                            //
// * Image List, Right & Left Tabs, ...                                       //
////////////////////////////////////////////////////////////////////////////////
// Version 2.14 Beta                                                          //
// Date de création           : 08/07/1997                                    //
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
//  1.10 : * Added CNMeasureItem                                              //
//         * Added image drawing in default drawing                           //
//  1.11 : * CommCtrlEx Modified for D2 (thanks to Gerhard Volk)              //
//         * TDrawTabCtrlEvent, TMeasureTabCtrlEvent Page parameter changed   //
//           from TTabControl to TTabControl98 (thanks to Marcus Monnig)      //
//  1.20 : * CustomTabControl98 allows hiddenproperties                       //
//         * Some properties modified                                         //
//         * Justification only works with fixed width                        //
//         * Multiline and Buttons looks bad when set (but ok after)          //
//         * DrawTab Procedure modified                                       //
//  1.60 : * Removed unused properties                                        //
//         * Some declaration modified for D2 compatibility                   //
//           (thanks to Gerhard Volk - again - for all the tests :-))         //
//         * Unified version number                                           //
//  1.70 : * Color Property added and OnGetColor Event added                  //
//           (Changes made by Tomas Tejon)                                    //
//         * Added Multiple Default Drawing                                   //
//           ddMode1 : Default                                                //
//           ddMode2 : Written by Tomas Tejon                                 //
//           ddMode3 : Written by Roger Misteli                               //
//  1.80 : * Tab Hint                                                         //
//         * Font can be choosen for each tab                                 //
//  1.95 : * Version number unification with PageControl                      //
//         * Images are still visible at design time when you change a        //
//           "RecreateWindow Property" like Tabcontrol.Color                  //
//         * OnGetImageIndexEvent added                                       //
//         * OnGetHintEvent added                                             //
//  1.96 : * ToolTip GPF Bug corrected                                        //
//  1.97 : * Works with D2 (CM_RECREATEWND replaced by CM_SHOWINGCHANGED)     //
//         * Uses ComCtl98.pas for D2 & D3                                    //
//  1.98 : * WM_MEASUREITEM is NEVER sent to TabControl !!!! thanks Microsoft //
//           An alternative to this problem is an invalidate in               //
//           WMRecreateWnd (but it's not what i want)                         //
//           Some bugs removed.                                               //
//  1.99 : * More bugs removed (thanks to Edward Zhuravlov)                   //
//  2.00 : * IconJustification properties (thanks to Wayne Niddery)           //
//           (RightJustification works only with ddMode1)                     //
//  2.01 : * Bug corrected (If you didn't used ImageList there were errors).  //
//           Thanks to Adrian Logan and Alper Yazgan.                         //
//  2.10 : * Some minor changes (for DBTabControl98)                          //
//         * Works with or without ImageList                                  //
//         * Hint uses TabText instead of Hint                                //
//  2.11 : * OnChange Event occurs only one time now                          //
//           (thanks to Jérôme Bouvattier)                                    //
//  2.12 : * Transparent property added                                       //
//         * OnGetTabColor modified to handle different color with PageControl//
//  2.13 : * TabIndex property is now public (thanks to Carlos Ponce de Leon) //
//  2.14 : * Tabs property is now public (thanks to Carlos Ponce de Leon)     //
////////////////////////////////////////////////////////////////////////////////

unit TabControl98;

interface

// Remove this line if you got a Duplicate ressource error
//{$R *.DCR}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Controls, Dialogs,
  CommCtrl, ComCtrls, ComCtl98, ImgList;

type
  TTabPosition = (tpTop, tpBottom, tpLeft, tpRight);
  TTabType = (ttDefault, ttOpposite);
  TTabStyle = (tsDefault, tsButtons, tsIE4FlatButtons);
  TTabJustification = (tjLeftText, tjCenterText, tjRightText);
  TTabDrawStyle = (tdDefault, tdOwnerDrawFixed);
  TDefaultDrawingType = (ddNone, ddMode1, ddMode2, ddMode3);
  TTabIconJustification = (ijLeftIcon, ijRightIcon, ijDefault);

  TCustomTabControl98 = class;

  TDrawTabEvent = procedure(Page: TCustomTabControl98; Tab: Integer;
                            const Rect: TRect) of object;
  TMeasureTabEvent = procedure(Page: TCustomTabControl98; Tab: Integer;
                            Var Height, Width: Integer) of object;
  TGetTabColorEvent= procedure(Page:TCustomTabControl98; Tab:Integer;
                            Var TabColor, FontColor: TColor) of object;
  TGetImageIndexEvent= function(Page:TCustomTabControl98; Tab:Integer): integer of object;
  TGetHintEvent= function(Page:TCustomTabControl98; Tab:Integer): string of object;

  TCustomTabControl98 = class(TCustomTabControl)
  private
    FImages: TImageList;
    FImageChangeLink: TChangeLink;
    FTabPosition: TTabPosition;
    FTabStyle: TTabStyle;
    FTabJustification: TTabJustification;
    FTabIconJustification: TTabIconJustification;
    {$ifndef VER100}
    FHotTrack: Boolean;
    FTabType: TTabType;
    {$endif}
    FMultiSelect: Boolean;
    FDrawStyle: TTabDrawStyle;
    FCanvas: TCanvas;
    FOnDrawTab: TDrawTabEvent;
    FOnMeasureTab: TMeasureTabEvent;
    FOnGetTabColor: TGetTabColorEvent;
    FOnGetImageIndex: TGetImageIndexEvent;
    FOnGetHint: TGetHintEvent;
    FDefaultDrawing: TDefaultDrawingType;
    FColor: TColor;
    FTransparent: Boolean;
    procedure ImageListChange (Sender: TObject);
    procedure SetImages (Value: TImageList);
    procedure SetImage (Index: Integer; imIndex: Integer);
    function GetImage (Index: Integer): Integer;
    {$ifndef VER100}
    procedure SetTabType (Value: TTabType);
    procedure SetHotTrack (Value: Boolean);
    {$endif}
    procedure SetTabStyle (Value: TTabStyle);
    procedure SetTabJustification (Value: TTabJustification);
    procedure SetTabIconJustification (Value: TTabIconJustification);
    procedure SetDrawStyle (Value: TTabDrawStyle);
    procedure SetMultiSelect (Value: Boolean);
    procedure SetColor(Value: TColor);
    procedure SetDefaultDrawing(Value: TDefaultDrawingType);
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
    {$ifdef VER100}
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
    {$else}
    procedure CMRecreateWnd(var Message: TMessage); message CM_SHOWINGCHANGED;
    {$endif}
  protected
    procedure SetTransparent(Value: Boolean); virtual;
    procedure SetTabPosition (Value: TTabPosition); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawTab(TabNdx: Integer; const Rect: TRect); dynamic;
    procedure AssociateImages; dynamic;
    function  InternalHint(TabNdx: Integer): String;
  public
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
    property TabIndex;
    property Tabs;
    property Image[Index: Integer]: Integer read GetImage write SetImage; default;
    property Canvas: TCanvas read FCanvas;
    property Color: TColor read FColor write SetColor default clBtnFace;
    property DefaultDrawing: TDefaultDrawingType read FDefaultDrawing write SetDefaultDrawing default ddMode1;
    property DrawStyle: TTabDrawStyle read FDrawStyle write SetDrawStyle default tdOwnerDrawFixed;
    property Images: TImageList read FImages write SetImages;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default False;
    property TabPosition: TTabPosition read FTabPosition write SetTabPosition default tpTop;
    {$ifndef VER100}
    property TabType: TTabType read FTabType write SetTabType default ttdefault;
    property HotTrack: Boolean read FHotTrack write SetHotTrack default False;
    {$endif}
    property TabStyle: TTabStyle read FTabStyle write SetTabStyle default tsDefault;
    property TabJustification: TTabJustification read FTabJustification write SetTabJustification default tjLeftText;
    property TabIconJustification: TTabIconJustification read FTabIconJustification write SetTabIconJustification default ijLeftIcon;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property OnDrawTab: TDrawTabEvent read FOnDrawTab write FOnDrawTab;
    property OnMeasureTab: TMeasureTabEvent read FOnMeasureTab write FOnMeasureTab;
    property OnGetTabColor: TGetTabColorEvent read FOnGetTabColor write FOnGetTabColor;
    property OnGetImageIndex: TGetImageIndexEvent read FOnGetImageIndex write FOnGetImageIndex;
    property OnGetHint: TGetHintEvent read FOnGetHint write FOnGetHint;
  end;

  TTabControl98 = class(TCustomTabControl98)
  public
    property DisplayRect;
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
    property HotTrack;
    property TabStyle;
    property TabJustification;
    property TabIconJustification;
    property Transparent;
    property OnDrawTab;
    property OnMeasureTab;
    property OnGetTabColor;
    property OnGetImageIndex;
    property OnGetHint;

    property Align;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property MultiLine;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    {$ifdef VER100}
    property ScrollOpposite;
    {$endif}
    property ShowHint;
    property TabHeight;
    property TabIndex;
    property TabOrder;
    //property TabPosition;
    property Tabs;
    property TabStop;
    property TabWidth;
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

procedure Register;

implementation

uses PageControl98;

procedure Register;
begin
  RegisterComponents('Travail', [TTabControl98]);
end;


procedure TCustomTabControl98.DrawTab(TabNdx: Integer; const Rect: TRect);
Var LogRec: TLOGFONT;
    OldFont,
    NewFont: HFONT;
    R : TRect;
    TabColor, FontColor: TColor;

  procedure DrawingMode1;
  begin
    //FCanvas.FillRect(Rect);
    if ( TabPosition in [tpLeft, tpRight] ) then begin
      GetObject(Canvas.Font.Handle, SizeOf(LogRec), @LogRec);
      if ( TabPosition = tpLeft ) then
        LogRec.lfEscapement := 900
      else
        LogRec.lfEscapement := -900;
      LogRec.lfOutPrecision := OUT_TT_ONLY_PRECIS;
      NewFont:= CreateFontIndirect(LogRec);
      OldFont:= SelectObject(FCanvas.Handle,NewFont);
      if ( TabIndex = TabNdx ) then
        InflateRect(R, 0, -4);
      if ( TabPosition = tpLeft ) then begin
        if ( Images <> nil ) and ( Image[TabNdx] >= 0 ) then begin
          case TabIconJustification of
            ijLeftIcon,
            ijDefault : begin
              Images.Draw(FCanvas, R.Left+2, R.Bottom - Images.Height - 2, Image[TabNdx]);
              R.Bottom:= R.Bottom - 4 - Images.Width;
            end;
            ijRightIcon : begin
              Images.Draw(FCanvas, R.Left+2, R.Top + 2, Image[TabNdx]);
              R.Top:= R.Top + 4 + Images.Width;
            end;
          end;
        end;
        FCanvas.TextOut(Rect.Left + 1 + (Rect.Right - Rect.Left - FCanvas.TextHeight(Tabs[TabNdx])) Div 2,
                        Rect.Bottom - 1 - (Rect.Bottom - Rect.Top - FCanvas.TextWidth(Tabs[TabNdx])) Div 2, Tabs[TabNdx]);
      end;
      if ( TabPosition = tpRight ) then begin
        if ( Images <> nil ) and ( Image[TabNdx] >= 0 ) then begin
          case TabIconJustification of
            ijLeftIcon,
            ijDefault : begin
              Images.Draw(FCanvas, R.Right - 2 - Images.Width, R.Top + 2, Image[TabNdx]);
              R.Top:= R.Top + 4 + Images.Width;
            end;
            ijRightIcon : begin
              Images.Draw(FCanvas, R.Right - 2 - Images.Width, R.Bottom - Images.Height - 2, Image[TabNdx]);
              R.Bottom:= R.Bottom - 4 - Images.Width;
            end;
          end;
        end;
        FCanvas.TextOut(Rect.Right - (Rect.Right - 1 - Rect.Left - FCanvas.TextHeight(Tabs[TabNdx])) Div 2,
                        Rect.Top + 1 + (Rect.Bottom - Rect.Top - FCanvas.TextWidth(Tabs[TabNdx])) Div 2, Tabs[TabNdx]);
      end;
      NewFont:= SelectObject(FCanvas.Handle,OldFont);
      DeleteObject(NewFont);
    end
    else begin
      if ( TabIndex = TabNdx ) then
        InflateRect(R, -4, 0);
      if ( TabPosition in [tpBottom] ) then begin
        if ( Images <> nil ) and ( Image[TabNdx] >= 0 ) then begin
          case TabIconJustification of
            ijLeftIcon,
            ijDefault : begin
              Images.Draw(FCanvas, R.Left + 2, R.Bottom - Images.Height - 2, Image[TabNdx]);
              R.Left:= R.Left + 4 + Images.Width;
            end;
            ijRightIcon : begin
              Images.Draw(FCanvas, R.Right - Images.Width - 2, R.Bottom - Images.Height - 2, Image[TabNdx]);
              R.Right:= R.Right - 4 - Images.Width;
            end;
          end;
        end;
        FCanvas.TextOut(R.Left + (R.Right - R.Left - FCanvas.TextWidth(Tabs[TabNdx])) Div 2,
                      R.Bottom - 3 - FCanvas.TextHeight(Tabs[TabNdx]), Tabs[TabNdx]);
      end
      else begin
        if ( Images <> nil ) and ( Image[TabNdx] >= 0 ) then begin
          case TabIconJustification of
            ijLeftIcon,
            ijDefault : begin
              Images.Draw(FCanvas, R.Left + 2, R.Top + 2, Image[TabNdx]);
              R.Left:= R.Left + 4 + Images.Width;
              R.Bottom:= R.Top + Images.Height;
            end;
            ijRightIcon : begin
              Images.Draw(FCanvas, R.Right - 2 - Images.Width, R.Top + 2, Image[TabNdx]);
              R.Right:= R.Right - 2 - Images.Width;
              R.Bottom:= R.Top + Images.Height;
            end;
          end;
        end;
        FCanvas.TextOut(R.Left + (R.Right - R.Left - FCanvas.TextWidth(Tabs[TabNdx])) Div 2,
                      R.Top + 2 + (R.Bottom - R.Top - FCanvas.TextHeight(Tabs[TabNdx])) Div 2, Tabs[TabNdx]);
      end;
    end;
  end;

  // Written by Tomas Tejon
  procedure DrawingMode2;
  begin
    //FCanvas.FillRect(Rect);
    if Assigned(Images) and (Image[TabNdx]>=0)
       THEN Case TabPosition OF
                 tpLeft:BEGIN
                             Images.Draw(FCanvas,(R.Right+R.Left-Images.Width) DIV 2,R.Bottom-Images.Height-2,Image[TabNdx]);
                             R.Bottom:=R.Bottom-4-Images.Height
                        END;
                 tpRight:BEGIN
                              Images.Draw(FCanvas,(R.Right+R.Left-Images.Width) DIV 2,R.Top+2,Image[TabNdx]);
                              R.Top:=R.Top+4+Images.Height
                         END;
                 tpTop,
                 tpBottom:BEGIN
                               Images.Draw(FCanvas,R.Left+2,(R.Bottom+R.Top-Images.Height) DIV 2,Image[TabNdx]);
                               R.Left:=R.Left+4+Images.Width
                          END;
            end;
    Case TabPosition OF
         tpLeft,
         tpRight:BEGIN
                      GetObject(Canvas.Font.Handle, SizeOf(LogRec), @LogRec);
                      if (TabPosition=tpLeft)
                         then LogRec.lfEscapement := 900
                         else LogRec.lfEscapement := -900;
                      LogRec.lfOutPrecision := OUT_TT_ONLY_PRECIS;
                      NewFont:= CreateFontIndirect(LogRec);
                      OldFont:= SelectObject(FCanvas.Handle,NewFont);
                      IF TabPosition=tpLeft
                         THEN FCanvas.TextOut((R.Right+R.Left-FCanvas.TextHeight(Tabs[TabNdx])) Div 2,
                                              (R.Bottom+R.Top+FCanvas.TextWidth(Tabs[TabNdx])) Div 2,Tabs[TabNdx])
                         ELSE FCanvas.TextOut((R.Right+R.Left+FCanvas.TextHeight(Tabs[TabNdx])) Div 2,
                                              (R.Bottom+R.Top-FCanvas.TextWidth(Tabs[TabNdx])) Div 2,Tabs[TabNdx]);
                      NewFont:= SelectObject(FCanvas.Handle,OldFont);
                      DeleteObject(NewFont);
                 END;
         tpBottom:FCanvas.TextOut((R.Right+R.Left-FCanvas.TextWidth(Tabs[TabNdx])) Div 2,
                                  (R.Bottom+R.Top-FCanvas.TextHeight(Tabs[TabNdx])) Div 2,Tabs[TabNdx]);
         tpTop:FCanvas.TextOut((R.Right+R.Left-FCanvas.TextWidth(Tabs[TabNdx])) Div 2,
                               (R.Bottom+R.Top-FCanvas.TextHeight(Tabs[TabNdx])) Div 2, Tabs[TabNdx])
    END
  end;

  // Written by Roger Misteli
  procedure DrawTextEx(TabNdx: Integer; Canvas: TCanvas; X, Y: Integer; sCaption: String);
  var       i: Integer;
  begin
    i:=GetBkMode(Canvas.Handle);
    SetBkMode(Canvas.Handle, Integer(TRANSPARENT));
    if ( Self is TCustomPageControl98 ) then begin
      with Self As TCustomPageControl98 do begin
        if Pages[TabNdx].Enabled then
          Canvas.TextOut(X, Y, sCaption)
        else begin
          Canvas.Font.Color:=clBtnHighlight;
          Windows.TextOut(Canvas.Handle, Succ(X), Succ(Y), PChar(sCaption), Length(sCaption));
          Canvas.Font.Color:=clBtnShadow;
          Windows.TextOut(Canvas.Handle, X, Y, PChar(sCaption), Length(sCaption));
        end;
      end;
    end
    else
      Canvas.TextOut(X, Y, sCaption);
    SetBkMode(Canvas.Handle, i);
  end;

  // Written by Roger Misteli
  procedure DrawingMode3;
  begin
    if ( TabPosition in [tpLeft, tpRight] ) then begin
      GetObject(Canvas.Font.Handle, SizeOf(LogRec), @LogRec);
      if ( TabPosition = tpLeft ) then
        LogRec.lfEscapement := 900
      else
        LogRec.lfEscapement := -900;
      LogRec.lfOutPrecision := OUT_TT_ONLY_PRECIS;
      NewFont:= CreateFontIndirect(LogRec);
      OldFont:= SelectObject(FCanvas.Handle,NewFont);
    end;
    if ( TabPosition in [tpLeft, tpRight] ) then begin
      DrawTextEx(TabNdx, FCanvas, Rect.Left + (Rect.Right - Rect.Left - FCanvas.TextHeight(Tabs[TabNdx])) Div 2,
                      Rect.Top + 1 + (Rect.Bottom - Rect.Top - FCanvas.TextWidth(Tabs[TabNdx])) Div 2, Tabs[TabNdx]);
      NewFont:= SelectObject(FCanvas.Handle,OldFont);
      DeleteObject(NewFont);
    end
    else
      DrawTextEx(TabNdx, FCanvas, Rect.Left + (Rect.Right - Rect.Left - FCanvas.TextWidth(Tabs[TabNdx])) Div 2,
                      Rect.Top + 1 + (Rect.Bottom - Rect.Top - FCanvas.TextHeight(Tabs[TabNdx])) Div 2, Tabs[TabNdx]);
  end;

begin
  R:= Rect;
  FontColor:= FCanvas.Font.Color;
  TabColor:= FCanvas.Brush.Color;
  if Assigned(fOnGetTabColor) then
    FOnGetTabColor(Self, TabNdx, TabColor, FontColor);
  FCanvas.Font.Color:=FontColor;
  FCanvas.Brush.Color:= TabColor;
  if ( TabNdx <> TabIndex ) then begin
    case TabPosition of
      tpLeft   : R.Right:= R.Right + 2;
      tpTop    : R.Bottom:= R.Bottom + 2;
      tpRight  : R.Left:= R.Left - 2;
      tpBottom : R.Top:= R.Top - 2;
    end;
    FCanvas.FillRect(R);
    R:= Rect;
  end
  else
    FCanvas.FillRect(Rect);
  with FCanvas do begin
    case DefaultDrawing of
      ddMode1 : DrawingMode1;
      ddMode2 : DrawingMode2;
      ddMode3 : DrawingMode3;
      ddNone  : ;
    end;
  end;
  if Assigned(FOnDrawTab) then
    FOnDrawTab(Self, TabNdx, Rect);
end;

procedure TCustomTabControl98.CNDrawItem(var Message: TWMDrawItem);
var
  SaveIndex: Integer;
  //TabColor, FontColor: TColor;
begin
  with Message.DrawItemStruct^ do
  begin
    //TabColor:=Color;
    //FontColor:=Font.Color;
    //if Assigned(fOnGetTabColor) then
    //  fOnGetTabColor(Self, itemID, TabColor, FontColor);
    SaveIndex := SaveDC(hDC);
    FCanvas.Handle := hDC;
    //FCanvas.Font.Color:=FontColor;
    if ( Self is TCustomPageControl98 ) then begin
      with ( Self as TCustomPageControl98 ) do begin
        FCanvas.Brush:= Pages[itemID].Brush;
        FCanvas.Font:= Pages[itemID].TabFont;
        //TabColor:= FCanvas.Brush.Color;
        //FontColor:= FCanvas.Font.Color;
      end;
    end;
    //if Assigned(fOnGetTabColor) then
    //  FOnGetTabColor(Self, itemID, TabColor, FontColor);
    //else begin
    //FCanvas.Font.Color:=FontColor;
    //FCanvas.Brush.Color:= TabColor;
    //end;
    FCanvas.Brush.Style := bsSolid;
    DrawTab(itemID, rcItem);
    FCanvas.Handle := 0;
    RestoreDC(hDC, SaveIndex);
  end;
  Message.Result := 1;
end;

procedure TCustomTabControl98.CNMeasureItem(var Message: TWMMeasureItem);
Var i : Integer;
    TmpWidth, TmpHeight,
    MaxWidth, MaxHeight: Integer;
begin
  //MessageBeep(Mb_Ok);
  MaxWidth:= 0;
  MaxHeight:= 0;
  TmpHeight:= 0;
  with Message.MeasureItemStruct^ do
  begin
    FCanvas.Handle:= GetDC(Handle);
    if ( Self is TCustomPageControl98 ) then
      FCanvas.Font:= ( Self as TCustomPageControl98 ).Pages[itemID].Font
    else
      FCanvas.Font:= Font;
    if Assigned ( FOnMeasureTab ) then begin
      FOnMeasureTab(Self, itemID, Integer(itemHeight), Integer(itemWidth));
    end
    else begin
      for i:= 0 to Tabs.Count - 1 do begin
        if ( Self is TCustomPageControl98 ) then
          FCanvas.Font:= ( Self as TCustomPageControl98 ).Pages[i].Font;
        if ( TabPosition in [tpBottom] ) then begin
          TmpWidth:= FCanvas.TextWidth(Tabs[i]) + 20;
        end
        else begin
          TmpWidth:= FCanvas.TextWidth(Tabs[i]);
        end;
        if ( FImages <> nil ) and ( Image[i] >= 0 ) then begin
          if ( ( FImages.Height + 4 ) > ItemHeight ) then
            TmpHeight:= FImages.Height + 4;
          TmpWidth:=TmpWidth + FImages.Height + 4;
        end;
        if ( TmpWidth > MaxWidth ) then
          MaxWidth:= TmpWidth;
        if ( TmpHeight > MaxHeight ) then
          MaxHeight:= TmpHeight;
      end;
      itemWidth:= MaxWidth;
      itemHeight:= MaxHeight;
      MessageDlg(IntToStr(MaxWidth) + ' ' + IntToStr(MaxHeight), mtWarning, [mbOk], 0);
    end;
    ReleaseDC(Handle, FCanvas.Handle);
    FCanvas.Handle:= 0;
  end;
  Message.Result:= 1;
end;

procedure TCustomTabControl98.WMNotify(var Message: TWMNotify);
var
  HitIndex: Integer;
  HitTestInfo: TTCHitTestInfo;
begin
  with Message.NMHdr^ do
    case code of
      TTN_NEEDTEXT:
        with Message do begin
          if ( Self is TCustomPageControl98 ) then
            Exit;
          Windows.GetCursorPos(HitTestInfo.pt);
          HitTestInfo.pt:= ScreenToClient(HitTestInfo.pt);
          HitIndex:= SendMessage(Handle, TCM_HITTEST, 0, Longint(@HitTestInfo));
          if (HitIndex <> -1) then begin
            if Assigned ( OnGetHint ) then
              strPCopy(PToolTipText(NMHdr)^.szText,Copy(OnGetHint(Self, HitIndex), 0, 80))
            else
              strPCopy(PToolTipText(NMHdr)^.szText,Copy(InternalHint(HitIndex), 0, 80));
          end
          else
            strPCopy(PToolTipText(NMHdr)^.szText,Copy(InternalHint(HitIndex), 0, 80));
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

procedure TCustomTabControl98.CNNotify(var Message: TWMNotify);
begin
  with Message.NMHdr^ do
    case code of
      TCN_SELCHANGE:
        begin
          Change;
          Exit;
        end;
      TCN_SELCHANGING:
        begin
          Message.Result := 1;
          if CanChange then Message.Result := 0;
          Exit;
        end;
      NM_HOVER :
        begin
          //MessageBeep(MB_Ok);
        end;
    end;
  inherited;
end;

procedure TCustomTabControl98.SetTransparent(Value: Boolean);
begin
  if ( FTransparent <> Value ) then begin
    FTransparent:= Value;
    if (HandleAllocated) then RecreateWnd;
  end;
end;

procedure TCustomTabControl98.SetMultiSelect (Value: Boolean);
begin
  if ( FMultiSelect <> Value ) then begin
    FMultiSelect:= Value;
    if ( HandleAllocated) then RecreateWnd;
  end;
end;

procedure TCustomTabControl98.SetColor(Value: TColor);
begin
  if FCOlor <> Value then begin
    FColor:= Value;
    if ( HandleAllocated) then RecreateWnd;
  end;
end;

procedure TCustomTabControl98.SetTabPosition (Value: TTabPosition);
begin
  if ( FTabPosition <> Value ) then begin
    if ( FTabStyle = tsIE4FlatButtons ) and ( Value <> tpTop ) then Exit;
    if ( FTabStyle = tsButtons ) and ( Value = tpBottom ) then Exit;
    FTabPosition:= Value;
    if ( HandleAllocated) then RecreateWnd;
  end;
end;

{$ifndef VER100}
procedure TCustomTabControl98.SetTabType (Value: TTabType);
begin
  if ( FTabType <> Value ) then begin
    FTabType:= Value;
    if ( HandleAllocated) then RecreateWnd;
  end;
end;
{$endif}

procedure TCustomTabControl98.SetTabStyle (Value: TTabStyle);
begin
  if ( FTabStyle <> Value ) then begin
    if ( Value = tsIE4FlatButtons ) and ( TabPosition <> tpTop ) then Exit;
    if ( Value = tsButtons ) and ( TabPosition = tpBottom ) then Exit;
    FTabStyle:= Value;
    if ( HandleAllocated) then RecreateWnd;
  end;
end;

procedure TCustomTabControl98.SetTabJustification (Value: TTabJustification);
begin
  if ( FTabJustification <> Value ) then begin
    FTabJustification:= Value;
    if ( HandleAllocated) then RecreateWnd;
  end;
end;

procedure TCustomTabControl98.SetTabIconJustification (Value: TTabIconJustification);
begin
  if ( FTabIconJustification <> Value ) then begin
    FTabIconJustification:= Value;
    if ( HandleAllocated) then RecreateWnd;
  end;
end;

{$ifndef VER100}
procedure TCustomTabControl98.SetHotTrack (Value: Boolean);
begin
  if ( FHotTrack <> Value ) then begin
    FHotTrack:= Value;
    if ( HandleAllocated) then RecreateWnd;
  end;
end;
{$endif}

procedure TCustomTabControl98.SetDrawStyle (Value: TTabDrawStyle);
begin
  if ( FDrawStyle <> Value ) then begin
    FDrawStyle:= Value;
    if ( HandleAllocated) then RecreateWnd;
  end;
end;

procedure TCustomTabControl98.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    if ( FTransparent ) then
      ExStyle:= ExStyle or WS_EX_TRANSPARENT
    else
      ExStyle:= ExStyle and  Not WS_EX_TRANSPARENT;
    Style:= Style or TCS_TOOLTIPS;
    if ( FMultiSelect ) then
      Style:= Style or TCS_MULTISELECT
    else
      Style:= Style and Not( TCS_MULTISELECT );
    if ( FDrawStyle = tdOwnerDrawFixed ) then
      Style:= Style or TCS_OWNERDRAWFIXED
    else
      Style:= Style and Not( TCS_OWNERDRAWFIXED );
    {$ifndef VER100}
    if ( FHotTrack ) then
      Style:= Style or TCS_HOTTRACK
    else
      Style:= Style and Not( TCS_HOTTRACK );
    {$endif}
    case FTabStyle of
      tsDefault: Style:= Style and ( Not(TCS_BUTTONS) or Not(TCS_FLATBUTTONS) );
      tsButtons: Style:= Style or TCS_BUTTONS and Not TCS_FLATBUTTONS;
      tsIE4FlatButtons: Style:= Style or TCS_BUTTONS or TCS_FLATBUTTONS;
    end;
    {$ifndef VER100}
    if ( FTabType = ttOpposite ) then
      Style:= Style or TCS_SCROLLOPPOSITE
    else
      Style:= Style and Not TCS_SCROLLOPPOSITE;
    {$endif}
    case FTabJustification of
      tjRightText   : Style:= Style and Not ( TCS_FORCELABELLEFT ) or TCS_RIGHTJUSTIFY or TCS_FORCEICONLEFT;
      tjLeftText    : Style:= Style or TCS_FORCELABELLEFT and Not ( TCS_RIGHTJUSTIFY );
      tjCenterText  : Style:= Style and Not ( TCS_FORCELABELLEFT or TCS_RIGHTJUSTIFY );
    end;
    case FTabIconJustification of
      ijLeftIcon  : Style:= Style or TCS_FORCEICONLEFT;
      ijDefault,
      ijRightIcon : Style:= Style and Not( TCS_FORCEICONLEFT );
    end;
    case FTabPosition of
      tpTop    : Style:= Style and Not ( TCS_VERTICAL or TCS_RIGHT or TCS_BOTTOM );
      tpBottom : Style:= Style and Not ( TCS_VERTICAL or TCS_RIGHT) or TCS_BOTTOM;
      tpLeft   : Style:= Style and Not ( TCS_RIGHT or TCS_BOTTOM ) or TCS_VERTICAL or TCS_MULTILINE;
      tpRight  : Style:= Style and Not ( TCS_BOTTOM ) or TCS_RIGHT or TCS_VERTICAL or TCS_MULTILINE;
    end;
  end;
end;

constructor TCustomTabControl98.Create (AOwner: TComponent);
begin
  inherited Create (AOwner);
  FDefaultDrawing:= ddMode1;
  FDrawStyle:= tdOwnerDrawFixed;
  FCanvas := TControlCanvas.Create;
  FColor:= clBtnFace;
  FTransparent:= False;
  TControlCanvas(FCanvas).Control := Self;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FOnGetTabColor:= nil;
  FOnGetHint:= nil;
  OnGetImageIndex:= nil;
  FOnDrawTab:= nil;
  FOnMeasureTab:= nil;
end;

destructor TCustomTabControl98.Destroy;
begin
  FImageChangeLink.Free;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TCustomTabControl98.ImageListChange(Sender: TObject);
begin
  if HandleAllocated then
    SendMessage(Handle, TCM_SETIMAGELIST, 0, Longint(TImageList(Sender).Handle));
end;

procedure TCustomTabControl98.SetImages (Value: TImageList);
begin
  if FImages <> nil then
    Images.UnRegisterChanges(FImageChangeLink);
  FImages:= Value;
  if FImages <> nil then
    begin
      Images.RegisterChanges (FImageChangeLink);
      SendMessage(Handle, TCM_SETIMAGELIST, 0, Longint(Images.Handle));
      AssociateImages;
    end
  else
    SendMessage(Handle, TCM_SETIMAGELIST, 0, Longint(0));
end;

procedure TCustomTabControl98.AssociateImages;
Var
  i: Integer;
begin
  if ( FImages <> nil ) then begin
    for i:= 0 to Tabs.Count - 1 do begin
      if Assigned ( OnGetImageIndex ) then
         SetImage( i, OnGetImageIndex(Self, TabIndex))
      else
        if ( FImages.Count > i ) then
          SetImage( i, i );
    end;
  end;
end;

procedure TCustomTabControl98.SetImage (Index: Integer; imIndex: Integer);
var
  imItem: TTCItem;
begin
  if ( Image[Index] = imIndex ) then Exit;
  imItem.iImage := imIndex;
  imItem.mask := TCIF_IMAGE;
  SendMessage (Handle, TCM_SETITEM, Index, Longint(@imItem));
end;

function TCustomTabControl98.GetImage (Index: Integer): Integer;
var
  imItem: TTCItem;
begin
  if FImages <> nil then
    begin
      imItem.mask := TCIF_IMAGE;
      SendMessage (Handle, TCM_GETITEM, Index, Longint(@imItem));
      Result := imItem.iImage;
    end
  else
    Result := -1
end;

procedure TCustomTabControl98.SetDefaultDrawing(Value: TDefaultDrawingType);
begin
  FDefaultDrawing:= Value;
end;

procedure TCustomTabControl98.CMRecreateWnd(var Message: TMessage);
//Var Pt: TSmallPoint;
begin
  inherited;
  Images:= FImages;
  AssociateImages;
  Invalidate;
end;

function TCustomTabControl98.InternalHint(TabNdx: Integer): String;
begin
  if ( TabNdx >= 0 ) then
    Result:= Tabs[TabNdx]
  else
    Result:= Hint;
end;

end.