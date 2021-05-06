////////////////////////////////////////////////////////////////////////////////
// COMMCTRLEX                                                                 //
////////////////////////////////////////////////////////////////////////////////
// Enhanced COMMCTRL for D2                                                   //
// * some constants and functions forgoten by Borland,...                     //
////////////////////////////////////////////////////////////////////////////////
// Version 1.2                                                                //
// Date de création           : 10/03/1997                                    //
// Date dernière modification : 20/10/1997                                    //
////////////////////////////////////////////////////////////////////////////////
// Jean-Luc Mattei                                                            //
// jlucm@club-internet.fr                                                     //
////////////////////////////////////////////////////////////////////////////////
//  REVISIONS :                                                               //
//                                                                            //
//  1.1 :                                                                     //
//        * Added (some) IE4 TabControl constants                             //
//  1.2 :                                                                     //
//        * Some IE4 TAB CONTROL declarations where missing                   //
//          (thanks to Gerhard Volk)                                          //
//  1.3 : * PageScroller const, type & func                                   //
//        * NativeFontControl const, type & func                              //
////////////////////////////////////////////////////////////////////////////////

unit CommCtrlEx;

interface

uses Messages, Windows, CommCtrl;

{ Interface for the Windows Tab Control }

//==================== CUSTOM CONTROL EX ====================================

Type
	TInitCommonControlsEx = record
          dwSize : LONGINT;
          dwICC  : LONGINT;
        end;

Const

	ICC_LISTVIEW_CLASSES = $00000001; // listview, header
	ICC_TREEVIEW_CLASSES = $00000002; // treeview, tooltips
	ICC_BAR_CLASSES      = $00000004; // toolbar, statusbar, trackbar, tooltips
	ICC_TAB_CLASSES      = $00000008; // tab, tooltips
	ICC_UPDOWN_CLASS     = $00000010; // updown
	ICC_PROGRESS_CLASS   = $00000020; // progress
	ICC_HOTKEY_CLASS     = $00000040; // hotkey
	ICC_ANIMATE_CLASS    = $00000080; // animate
	ICC_WIN95_CLASSES    = $000000FF;
	ICC_DATE_CLASSES     = $00000100; // month picker, date picker, time picker, updown
	ICC_USEREX_CLASSES   = $00000200; // comboex
        ICC_COOL_CLASSES     = $00000400; // rebar (coolbar) control

        // IE4 ONLY
        ICC_INTERNET_CLASSES   = $00000800;
        ICC_PAGESCROLLER_CLASS = $00001000;   // page scroller
        ICC_NATIVEFNTCTL_CLASS = $00002000;   // native font control

function InitCommonControlsEx(Var CC : TInitCommonControlsEx): boolean; stdcall
procedure InitTabCommonControlEx;
procedure InitCoolBarCommonControlEx;
procedure InitToolBarCommonControlEx;
procedure InitComboExCommonControlEx;
procedure InitPickerCommonControlEx;
procedure InitIPAdressCommonControlEx;

Const

    MCN_FIRST              = 0-750;       // monthcal
    MCN_LAST               = 0-759;

    DTN_FIRST              = 0-760;       // datetimepick
    DTN_LAST               = 0-799;

    CBEN_FIRST             = 0-800;       // combo box ex
    CBEN_LAST              = 0-830;

    RBN_FIRST              = 0-831;       // rebar
    RBN_LAST               = 0-859;

    // IE4 ONLY
    IPN_FIRST             = (0-860); // internet address
    IPN_LAST              = (0-879); // internet address

    PGM_FIRST             = $1400;  // Pager control messages

    PGN_FIRST             = (0-900); // Pager Control
    PGN_LAST              = (0-950);

    CCS_VERT               = $00000080;
    CCS_LEFT               = (CCS_VERT OR CCS_TOP);
    CCS_RIGHT              = (CCS_VERT OR CCS_BOTTOM);
    CCS_NOMOVEX            = (CCS_VERT OR CCS_NOMOVEY);

    CCM_FIRST             = $2000;           // Common control shared messages
    CCM_SETBKCOLOR        = (CCM_FIRST + 1); // lParam is bkColor

  (*
typedef struct tagCOLORSCHEME {
   DWORD            dwSize;
   COLORREF         clrBtnHighlight;       // highlight color
   COLORREF         clrBtnShadow;          // shadow color
} COLORSCHEME, *LPCOLORSCHEME;
  *)

    CCM_SETCOLORSCHEME    =  (CCM_FIRST + 2); // lParam is color scheme
    CCM_GETCOLORSCHEME    =  (CCM_FIRST + 3); // fills in COLORSCHEME pointed to by lParam
    CCM_GETDROPTARGET     =  (CCM_FIRST + 4);
    CCM_SETUNICODEFORMAT  =  (CCM_FIRST + 5);
    CCM_GETUNICODEFORMAT  =  (CCM_FIRST + 6);

//==================== CUSTOM DRAW ==========================================

// custom draw return flags
// values under 0x00010000 are reserved for global custom draw values.
// above that are for specific controls

const
	CDRF_DODEFAULT        = $00000000;
        CDRF_NEWFONT          = $00000002;
	CDRF_SKIPDEFAULT      = $00000004;

	CDRF_NOTIFYPOSTPAINT  = $00000010;
	CDRF_NOTIFYITEMDRAW   = $00000020;
        CDRF_NOTIFYPOSTERASE  = $00000040;
        CDRF_NOTIFYITEMERASE  = $00000080;

// drawstage flags
// values under 0x00010000 are reserved for global custom draw values.
// above that are for specific controls

	CDDS_PREPAINT         = $000000001;
	CDDS_POSTPAINT        = $000000002;
        CDDS_PREERASE         = $000000003;
        CDDS_POSTERASE        = $000000004;

// the 0x000010000 bit means it's individual item specific

	CDDS_ITEM             = $000010000;
	CDDS_ITEMPREPAINT     = (CDDS_ITEM OR CDDS_PREPAINT);
	CDDS_ITEMPOSTPAINT    = (CDDS_ITEM OR CDDS_POSTPAINT);
        CDDS_ITEMPREERASE     = (CDDS_ITEM OR CDDS_PREERASE);
        CDDS_ITEMPOSTERASE    = (CDDS_ITEM OR CDDS_POSTERASE);


// itemState flags

	CDIS_SELECTED  =  $0001;
	CDIS_GRAYED    =  $0002;
	CDIS_DISABLED  =  $0004;
	CDIS_CHECKED   =  $0008;
	CDIS_FOCUS     =  $0010;
	CDIS_DEFAULT   =  $0020;
        CDIS_HOT       =  $0040;

	NM_CUSTOMDRAW  = (NM_FIRST-12);
	NM_HOVER       = (NM_FIRST-13);

Type
         PNMCustomDrawInfo = ^TNMCustomDrawInfo;
	 TNMCustomDrawInfo = packed record
		hdr : TNMHDR;
		dwDrawStage : LONGINT;
		hdc : HDC;
		rc : TRect;
		dwItemSpec : LONGINT;  // this is control specific, but it's how to specify an item.  valid only with CDDS_ITEM bit set
		uItemState : Cardinal;
	 end;

         PNMLVCustomDraw = ^TNMLVCustomDraw;
         TNMLVCustomDraw = packed record
            nmcd : TNMCUSTOMDRAWInfo;
            clrText : COLORREF;
            clrTextBk : COLORREF;
         end;

////////////////////  TAB CONTROL ////////////////////////////////

const

	TCS_SCROLLOPPOSITE    = $0001;   // assumes multiline tab
	TCS_BOTTOM            = $0002;
	TCS_RIGHT             = $0002;
        TCS_MULTISELECT       = $0004;   // allow multi-select in button mode
	TCS_VERTICAL          = $0080;   // only valid with multiline mode
        TCS_HOTTRACK          = $0040;

	TCIF_RTLREADING       = $0004;
	TCIF_STATE            = $0010;

	TCIS_BUTTONPRESSED    = $0001;

        // IE4 ONLY
        TCS_FLATBUTTONS       = $0008;
        // IE4 ONLY
        TCS_EX_FLATSEPARATORS = $00000001;
        // IE4 ONLY
        TCS_EX_REGISTERDROP   = $00000002;

        // IE4 ONLY
        TCIS_HIGHLIGHTED      = $0002;

        // IE4 ONLY
        TCM_HIGHLIGHTITEM     = (TCM_FIRST + 51);
        TCM_SETEXTENDEDSTYLE  = (TCM_FIRST + 52);  // optional wParam == mask
        TCM_GETEXTENDEDSTYLE  = (TCM_FIRST + 53);

  function TabCtrl_HighlightItem(hwnd: HWND; i : Cardinal; fHighlight : Bool): Bool;
  // (BOOL)SNDMSG((hwnd), TCM_HIGHLIGHTITEM, (WPARAM)i, (LPARAM)MAKELONG (fHighlight, 0))

  function TabCtrl_SetExtendedStyle(hwnd: HWND; dw: Longint): Longint;
  // (DWORD)SNDMSG((hwnd), TCM_SETEXTENDEDSTYLE, 0, dw)

  function TabCtrl_GetExtendedStyle(hwnd: HWND): Longint;
  // (DWORD)SNDMSG((hwnd), TCM_GETEXTENDEDSTYLE, 0, 0)

Const

        // IE4 ONLY
        TCN_GETOBJECT         = (TCN_FIRST - 3);

(*----------------------------------------------------------------------**)

////////////////////  ComboBoxEx ////////////////////////////////

Const

      WC_COMBOBOXEX = 'ComboBoxEx32';

      CBEIF_TEXT            =  $00000001;
      CBEIF_IMAGE           =  $00000002;
      CBEIF_SELECTEDIMAGE   =  $00000004;
      CBEIF_OVERLAY         =  $00000008;
      CBEIF_INDENT          =  $00000010;
      CBEIF_LPARAM          =  $00000020;

      CBEIF_DI_SETITEM      =  $10000000;

Type  PComboBoxExItemA = ^TComboBoxExItemA;
      PComboBoxExItemW = ^TComboBoxExItemW;
      PComboBoxExItem  = PComboBoxExItemA;

      TComboBoxExItemA = packed record
        mask: Cardinal;
        iItem: Integer;
        pszText: PAnsiChar;
        cchTextMax: Integer;
        iImage: Integer;
        iSelectedImage: Integer;
        iOverlay: Integer;
        iIndent: Integer;
        lParam: LPARAM;
      end;

      TComboBoxExItemW = packed record
        mask: Cardinal;
        iItem: Integer;
        pszText: PWideChar;
        cchTextMax: Integer;
        iImage: Integer;
        iSelectedImage: Integer;
        iOverlay: Integer;
        iIndent: Integer;
        lParam: LPARAM;
      end;

      TComboBoxExItem = TComboBoxExItemA;

Const

    CBEM_INSERTITEMA       = (WM_USER + 1);
    CBEM_SETIMAGELIST      = (WM_USER + 2);
    CBEM_GETIMAGELIST      = (WM_USER + 3);
    CBEM_GETITEMA          = (WM_USER + 4);
    CBEM_SETITEMA          = (WM_USER + 5);
    CBEM_DELETEITEM        = CB_DELETESTRING;
    CBEM_GETCOMBOCONTROL   = (WM_USER + 6);
    CBEM_GETEDITCONTROL    = (WM_USER + 7);
    CBEM_SETEXSTYLE        = (WM_USER + 8);
    CBEM_GETEXSTYLE        = (WM_USER + 9);
    CBEM_HASEDITCHANGED    = (WM_USER + 10);
    CBEM_INSERTITEMW       = (WM_USER + 11);
    CBEM_SETITEMW          = (WM_USER + 12);
    CBEM_GETITEMW          = (WM_USER + 13);

    CBEM_INSERTITEM        = CBEM_INSERTITEMA;
    CBEM_SETITEM           = CBEM_SETITEMA;
    CBEM_GETITEM           = CBEM_GETITEMA;

    CBES_EX_NOEDITIMAGE        =  $00000001;
    CBES_EX_NOEDITIMAGEINDENT  =  $00000002;
    CBES_EX_PATHWORDBREAKPROC  =  $00000004;

Type

    PNMComboBoxExA = ^TNMComboBoxExA;
    PNMComboBoxExW = ^TNMComboBoxExW;
    PNMComboBoxEx  = PNMComboBoxExA;

    TNMComboBoxExA = packed record
       hdr : TNMHDR;
       ceItem : TComboBoxExItemA;
    end;

    TNMComboBoxExW = packed record
       hdr : TNMHDR;
       ceItem : TComboBoxExItemW;
    end;

    TNMComboBoxEx = TNMComboBoxExA;

Const

    CBEN_GETDISPINFO     =  (CBEN_FIRST - 0);
    CBEN_INSERTITEM      =  (CBEN_FIRST - 1);
    CBEN_DELETEITEM      =  (CBEN_FIRST - 2);
    CBEN_BEGINEDIT       =  (CBEN_FIRST - 4);
    CBEN_ENDEDITA        =  (CBEN_FIRST - 5);
    CBEN_ENDEDITW        =  (CBEN_FIRST - 6);

    // lParam specifies why the endedit is happening

    CBEN_ENDEDIT         =  CBEN_ENDEDITA;

    CBENF_KILLFOCUS      =   1;
    CBENF_RETURN         =   2;
    CBENF_ESCAPE         =   3;
    CBENF_DROPDOWN       =   4;

    CBEMAXSTRLEN  = 260;

// CBEN_ENDEDIT sends this information...
// fChanged if the user actually did anything
// iNewSelection gives what would be the new selection unless the notify is failed
//                      iNewSelection may be CB_ERR if there's no match

Type

    PNMCBEEndEditW = ^TNMCBEEndEditW;
    PNMCBEEndEditA = ^TNMCBEEndEditA;
    PNMCBEEndEdit  = PNMCBEEndEditA;

    TNMCBEEndEditW = packed record
       hdr: TNMHDR;
       fChanged: Boolean;
       iNewSelection: Integer;
       szText: Array[0..CBEMAXSTRLEN] of Char;
       iWhy: Integer;
    end;

    TNMCBEEndEditA = packed record
       hdr: TNMHDR;
       fChanged: Boolean;
       iNewSelection: Integer;
       szText: Array[0..CBEMAXSTRLEN] of Char;
       iWhy: Integer;
    end;

    TNMCBEEndEdit= TNMCBEEndEditA;

//====== TOOLBAR CONTROL ========================================================

Const

    IDB_HIST_SMALL_COLOR    = 8;
    IDB_HIST_LARGE_COLOR    = 9;

    TBSTATE_ELLIPSES     =  $40;

    TBSTYLE_DROPDOWN     =  $08;

    TBSTYLE_FLAT         =  $0800;
    TBSTYLE_LIST         =  $1000;
    TBSTYLE_CUSTOMERASE  =  $2000;

Type

    PTBReplaceBitmap = ^TTBReplaceBitmap;

    TTBReplaceBitmap = packed record
      hInstOld: THandle;
      nIDOld: Cardinal;
      hInstNew: THandle;
      nIDNew: Cardinal;
      nButtons: Integer;
    end;

Const


    TB_REPLACEBITMAP        = (WM_USER + 46);
    TB_SETINDENT            = (WM_USER + 47);
    TB_SETIMAGELIST         = (WM_USER + 48);
    TB_GETIMAGELIST         = (WM_USER + 49);
    TB_LOADIMAGES           = (WM_USER + 50);
    TB_GETRECT              = (WM_USER + 51); // wParam is the Cmd instead of index
    TB_SETHOTIMAGELIST      = (WM_USER + 52);
    TB_GETHOTIMAGELIST      = (WM_USER + 53);
    TB_SETDISABLEDIMAGELIST = (WM_USER + 54);
    TB_GETDISABLEDIMAGELIST = (WM_USER + 55);
    TB_SETSTYLE             = (WM_USER + 56);
    TB_GETSTYLE             = (WM_USER + 57);
    TB_GETBUTTONSIZE        = (WM_USER + 58);
    TB_SETBUTTONWIDTH       = (WM_USER + 59);
    TB_SETMAXTEXTROWS       = (WM_USER + 60);
    TB_GETTEXTROWS          = (WM_USER + 61);

    TBN_DROPDOWN         =  (TBN_FIRST - 10);
    TBN_CLOSEUP          =  (TBN_FIRST - 11);

Type

    PTBNotifyA = ^TTBNotifyA;
    PTBNotifyW = ^TTBNotifyW;
    PTBNotify = PTBNotifyA;

    TTBNotifyA = packed record
      hdr: TNMHdr;
      iItem: Integer;
      tbButton: TTBButton;
      cchText: Integer;
      pszText: PAnsiChar;
    end;

    TTBNotifyW = packed record
      hdr: TNMHdr;
      iItem: Integer;
      tbButton: TTBButton;
      cchText: Integer;
      pszText: PWideChar;
    end;

    TTBNotify = TTBNotifyA;

//====== REBAR CONTROL ========================================================

Const

    REBARCLASSNAME  = 'ReBarWindow32';

    RBIM_IMAGELIST  = $00000001;

    RBS_TOOLTIPS    = $00000100;
    RBS_VARHEIGHT   = $00000200;
    RBS_BANDBORDERS = $00000400;
    RBS_FIXEDORDER  = $00000800;

Type

    PRebarInfo = ^TRebarInfo;

    TRebarInfo = packed record
       cbSize: Cardinal;
       fMask: Cardinal;
       {$ifndef NOIMAGEAPIS}
       himl: HIMAGELIST;
       {$else}
       himl: HANDLE;
       {$endif}
    end;

Const

    RBBS_BREAK       = $00000001;  // break to new line
    RBBS_FIXEDSIZE   = $00000002;  // band can't be sized
    RBBS_CHILDEDGE   = $00000004;  // edge around top & bottom of child window
    RBBS_HIDDEN      = $00000008;  // don't show
    RBBS_NOVERT      = $00000010;  // don't show when vertical
    RBBS_FIXEDBMP    = $00000020;  // bitmap doesn't move during band resize

    RBBIM_STYLE      = $00000001;
    RBBIM_COLORS     = $00000002;
    RBBIM_TEXT       = $00000004;
    RBBIM_IMAGE      = $00000008;
    RBBIM_CHILD      = $00000010;
    RBBIM_CHILDSIZE  = $00000020;
    RBBIM_SIZE       = $00000040;
    RBBIM_BACKGROUND = $00000080;
    RBBIM_ID         = $00000100;

Type

    PRebarBandInfoA = ^TRebarBandInfoA;
    PRebarBandInfoW = ^TRebarBandInfoW;
    PRebarBandInfo  = PRebarBandInfoA;

    TRebarBandInfoA = packed record
      cbSize: Cardinal;
      fMask: Cardinal;
      fStyle: Cardinal;
      clrFore: TColorRef;
      clrBack: TColorRef;
      lpText: PAnsiChar;
      cch: Cardinal;
      iImage: Integer;
      hwndChild: HWND;
      cxMinChild: Cardinal;
      cyMinChild: Cardinal;
      cx: Cardinal;
      hbmBack: HBITMAP;
      wID: Cardinal;
    end;

    TRebarBandInfoW = packed record
      cbSize: Cardinal;
      fMask: Cardinal;
      fStyle: Cardinal;
      clrFore: TColorRef;
      clrBack: TColorRef;
      lpText: PWideChar;
      cch: Cardinal;
      iImage: Integer;
      hwndChild: HWND;
      cxMinChild: Cardinal;
      cyMinChild: Cardinal;
      cx: Cardinal;
      hbmBack: HBITMAP;
      wID: Cardinal;
    end;

    TRebarBandInfo = TRebarBandInfoA;

Const

    RB_INSERTBANDA  = (WM_USER +  1);
    RB_DELETEBAND   = (WM_USER +  2);
    RB_GETBARINFO   = (WM_USER +  3);
    RB_SETBARINFO   = (WM_USER +  4);
    RB_GETBANDINFO  = (WM_USER +  5);
    RB_SETBANDINFOA = (WM_USER +  6);
    RB_SETPARENT    = (WM_USER +  7);
    RB_INSERTBANDW  = (WM_USER +  10);
    RB_SETBANDINFOW = (WM_USER +  11);
    RB_GETBANDCOUNT = (WM_USER +  12);
    RB_GETROWCOUNT  = (WM_USER +  13);
    RB_GETROWHEIGHT = (WM_USER +  14);

    RB_INSERTBAND   = RB_INSERTBANDA;
    RB_SETBANDINFO  = RB_SETBANDINFOA;

    RBN_HEIGHTCHANGE  = (RBN_FIRST - 0);


//====== MONTHCAL CONTROL ======================================================

Const
    MONTHCAL_CLASS   =  'SysMonthCal32';

// bit-packed array of "bold" info for a month
// if a bit is on, that day is drawn bold

Type
    SystemTime = packed record
      wYear: Word;
      wMonth: Word;
      wDayOfWeek: Word;
      wDay: Word;
      wHour: Word;
      wMinute: Word;
      wSecond: Word;
      wMilliseconds: Word;
    end;

    PMonthDayState = ^TMonthDayState;
    TMonthDayState = Longint;
    PMCHitTestInfo = ^TMCHitTestInfo;

    TMCHitTestInfo = packed record
       cbSize: Cardinal;
       pt: TPoint;
       uHit: Cardinal;   // out param
       st: SystemTime;
    end;

Const

    MCM_FIRST           =  $1000;
    MCM_GETCURSEL       = (MCM_FIRST + 1);
    MCM_SETCURSEL       = (MCM_FIRST + 2);
    MCM_GETMAXSELCOUNT  = (MCM_FIRST + 3);
    MCM_SETMAXSELCOUNT  = (MCM_FIRST + 4);
    MCM_GETSELRANGE     = (MCM_FIRST + 5);
    MCM_SETSELRANGE     = (MCM_FIRST + 6);
    MCM_GETMONTHRANGE   = (MCM_FIRST + 7);
    MCM_SETDAYSTATE     = (MCM_FIRST + 8);
    MCM_GETMINREQRECT   = (MCM_FIRST + 9);
    MCM_SETTODAY        = (MCM_FIRST + 12);
    MCM_GETTODAY        = (MCM_FIRST + 13);
    MCM_HITTEST         = (MCM_FIRST + 14);



// BOOL MonthCal_GetCurSel(HWND hmc, LPSYSTEMTIME pst)
//   returns FALSE if MCS_MULTISELECT
//   returns TRUE and sets *pst to the currently selected date otherwise

function MonthCal_GetCurSel(hmc: HWND; Var pst: SystemTime): Boolean;
  //  (BOOL)SNDMSG(hmc, MCM_GETCURSEL, 0, (LPARAM)(pst))

// BOOL MonthCal_SetCurSel(HWND hmc, LPSYSTEMTIME pst)
//   returns FALSE if MCS_MULTISELECT
//   returns TURE and sets the currently selected date to *pst otherwise

function MonthCal_SetCurSel(hmc: HWND; Var pst: SystemTime): Boolean;
  //  (BOOL)SNDMSG(hmc, MCM_SETCURSEL, 0, (LPARAM)(pst))

// DWORD MonthCal_GetMaxSelCount(HWND hmc)
//   returns the maximum number of selectable days allowed

function MonthCal_GetMaxSelCount(hmc: HWND): Longint;
  // (DWORD)SNDMSG(hmc, MCM_GETMAXSELCOUNT, 0, 0L)

// BOOL MonthCal_SetMaxSelCount(HWND hmc, UINT n)
//   sets the max number days that can be selected iff MCS_MULTISELECT
function MonthCal_SetMaxSelCount(hmc: HWND; n: Cardinal): Boolean;
  // (BOOL)SNDMSG(hmc, MCM_SETMAXSELCOUNT, (WPARAM)(n), 0L)

// BOOL MonthCal_GetSelRange(HWND hmc, LPSYSTEMTIME rgst)
//   sets rgst[0] to the first day of the selection range
//   sets rgst[1] to the last day of the selection range
function MonthCal_GetSelRange(hmc: HWND; Var rgst: SystemTime): Longint;
  // SNDMSG(hmc, MCM_GETSELRANGE, 0, (LPARAM)(rgst))

// BOOL MonthCal_SetSelRange(HWND hmc, LPSYSTEMTIME rgst)
//   selects the range of days from rgst[0] to rgst[1]
function MonthCal_SetSelRange(hmc: HWND; Var rgst: SystemTime): Longint;
  //SNDMSG(hmc, MCM_SETSELRANGE, 0, (LPARAM)(rgst))

// DWORD MonthCal_GetMonthRange(HWND hmc, DWORD gmr, LPSYSTEMTIME rgst)
//   if rgst specified, sets rgst[0] to the starting date and
//      and rgst[1] to the ending date of the the selectable (non-grayed)
//      days if GMR_VISIBLE or all the displayed days (including grayed)
//      if GMR_DAYSTATE.
//   returns the number of months spanned by the above range.
function MonthCal_GetMonthRange(hmc: HWND; gmr: Integer; Var rgst: SystemTime): Longint;
  //(DWORD)SNDMSG(hmc, MCM_GETMONTHRANGE, (WPARAM)(gmr), (LPARAM)(rgst))

// BOOL MonthCal_SetDayState(HWND hmc, int cbds, DAYSTATE *rgds)
//   cbds is the count of DAYSTATE items in rgds and it must be equal
//   to the value returned from MonthCal_GetMonthRange(hmc, GMR_DAYSTATE, NULL)
//   This sets the DAYSTATE bits for each month (grayed and non-grayed
//   days) displayed in the calendar. The first bit in a month's DAYSTATE
//   corresponts to bolding day 1, the second bit affects day 2, etc.

function MonthCal_SetDayState(hmc: HWND; cbds: Integer; Var rgds: PMonthDayState): Longint;
  //SNDMSG(hmc, MCM_SETDAYSTATE, (WPARAM)(cbds), (LPARAM)(rgds))

// BOOL MonthCal_GetMinReqRect(HWND hmc, LPRECT prc)
//   sets *prc the minimal size needed to display one month

function MonthCal_GetMinReqRect(hmc: HWND; Var prc: TRect): Longint;
  //SNDMSG(hmc, MCM_GETMINREQRECT, 0, (LPARAM)(prc))

// set what day is "today"   send NULL to revert back to real date

function MonthCal_SetToday(hmc: HWND; Var pst: SystemTime): Longint;
  //SNDMSG(hmc, MCM_SETTODAY, 0, (LPARAM)pst)

// get what day is "today"
// returns BOOL for success/failure

function MonthCal_GetToday(hmc: HWND; Var pst: SystemTime): Boolean;
  //(BOOL)SNDMSG(hmc, MCM_GETTODAY, 0, (LPARAM)pst)

// determine what pinfo->pt is over

function MonthCal_HitTest(hmc: HWND; Var pinfo : PMCHitTestInfo): Longint;
  //SNDMSG(hmc, MCM_HITTEST, 0, (LPARAM)(PMCHITTESTINFO)pinfo)

Const

    MCHT_TITLE               =       $00010000;
    MCHT_CALENDAR            =       $00020000;
    MCHT_TODAYLINK           =       $00030000;

    MCHT_NEXT                =       $01000000;   // these indicate that hitting
    MCHT_PREV                =       $02000000;  // here will go to the next/prev month

    MCHT_NOWHERE             =       $00000000;

    MCHT_TITLEBK             =       (MCHT_TITLE);
    MCHT_TITLEMONTH          =       (MCHT_TITLE OR $0001);
    MCHT_TITLEYEAR           =       (MCHT_TITLE OR $0002);
    MCHT_TITLEBTNNEXT        =       (MCHT_TITLE OR MCHT_NEXT OR $0003);
    MCHT_TITLEBTNPREV        =       (MCHT_TITLE OR MCHT_PREV OR $0003);

    MCHT_CALENDARBK          =       (MCHT_CALENDAR);
    MCHT_CALENDARDATE        =       (MCHT_CALENDAR OR $0001);
    MCHT_CALENDARDATENEXT    =       (MCHT_CALENDARDATE OR MCHT_NEXT);
    MCHT_CALENDARDATEPREV    =       (MCHT_CALENDARDATE OR MCHT_PREV);
    MCHT_CALENDARDAY         =       (MCHT_CALENDAR OR $0002);
    MCHT_CALENDARWEEKNUM     =       (MCHT_CALENDAR OR $0003);

    // set colors to draw control with -- see MCSC_ bits below
    MCM_SETCOLOR             = (MCM_FIRST + 10);
    MCM_GETCOLOR             = (MCM_FIRST + 11);

    function MonthCal_SetColor(hmc: HWND; iColor: Integer; clr: TColorRef): Longint;
    function MonthCal_GetColor(hmc: HWND; iColor: Integer): Longint;

Const

    MCSC_BACKGROUND   = 0;   // the background color (between months)
    MCSC_TEXT         = 1;   // the dates
    MCSC_TITLEBK      = 2;   // background of the title
    MCSC_TITLETEXT    = 3;
    MCSC_MONTHBK      = 4;   // background within the month cal
    MCSC_TRAILINGTEXT = 5;   // the text color of header & trailing days

    // set first day of week to iDay:
    // 0 for Monday, 1 for Tuesday, ..., 6 for Sunday
    // -1 for means use locale info
    MCM_SETFIRSTDAYOFWEEK  = (MCM_FIRST + 15);
    MCM_GETFIRSTDAYOFWEEK  = (MCM_FIRST + 16);
    MCM_GETRANGE           = (MCM_FIRST + 17);
    MCM_SETRANGE           = (MCM_FIRST + 18);
    MCM_GETMONTHDELTA      = (MCM_FIRST + 19);
    MCM_SETMONTHDELTA      = (MCM_FIRST + 20);

    function MonthCal_SetFirstDayOfWeek(hmc: HWND; iDay: Longint): Longint;
     //       SNDMSG(hmc, MCM_SETFIRSTDAYOFWEEK, 0, iDay)

    // DWORD result...  low word has the day.  high word is bool if this is app set
    // or not (FALSE == using locale info)
    function MonthCal_GetFirstDayOfWeek(hmc: HWND): Integer;
     //       (DWORD)SNDMSG(hmc, MCM_GETFIRSTDAYOFWEEK, 0, 0)

    // DWORD MonthCal_GetRange(HWND hmc, LPSYSTEMTIME rgst)
    //   modifies rgst[0] to be the minimum ALLOWABLE systemtime (or 0 if no minimum)
    //   modifies rgst[1] to be the maximum ALLOWABLE systemtime (or 0 if no maximum)
    //   returns GDTR_MIN|GDTR_MAX if there is a minimum|maximum limit
    function MonthCal_GetRange(hmc: HWND; Var rgst : SYSTEMTIME): Integer;
      //        (DWORD)SNDMSG(hmc, MCM_GETRANGE, 0, (LPARAM)(rgst))

    // BOOL MonthCal_SetRange(HWND hmc, DWORD gdtr, LPSYSTEMTIME rgst)
    //   if GDTR_MIN, sets the minimum ALLOWABLE systemtime to rgst[0], otherwise removes minimum
    //   if GDTR_MAX, sets the maximum ALLOWABLE systemtime to rgst[1], otherwise removes maximum
    //   returns TRUE on success, FALSE on error (such as invalid parameters)

    function MonthCal_SetRange(hmc: HWND; gd: Integer; Var rgst: SYSTEMTIME): Boolean;
    //    (BOOL)SNDMSG(hmc, MCM_SETRANGE, (WPARAM)(gd), (LPARAM)(rgst))

    // int MonthCal_GetMonthDelta(HWND hmc)
    //   returns the number of months one click on a next/prev button moves by

    function MonthCal_GetMonthDelta(hmc: HWND): Integer;
     //   (int)SNDMSG(hmc, MCM_GETMONTHDELTA, 0, 0)

    // int MonthCal_SetMonthDelta(HWND hmc, int n)
    //   sets the month delta to n. n==0 reverts to moving by a page of months
    //   returns the previous value of n.
    function MonthCal_SetMonthDelta(hmc: HWND; n: Integer): Integer;
     //   (int)SNDMSG(hmc, MCM_SETMONTHDELTA, n, 0)

Type

    // MCN_SELCHANGE is sent whenever the currently displayed date changes
    // via month change, year change, keyboard navigation, prev/next button
    //

    PNMSelChange = ^TNMSelChange;

    TNMSelChange = packed record
      nmhdr: TNMHdr;  // this must be first, so we don't break WM_NOTIFY
      stSelStart: SYSTEMTIME;
      stSelEnd: SYSTEMTIME;
    end;

    PNMDayState = ^TNMDayState;

    // MCN_GETDAYSTATE is sent for MCS_DAYSTATE controls whenever new daystate
    // information is needed (month or year scroll) to draw bolding information.
    // The app must fill in cDayState months worth of information starting from
    // stStart date. The app may fill in the array at prgDayState or change
    // prgDayState to point to a different array out of which the information
    // will be copied. (similar to tooltips)
    //

    TNMDayState = packed record
      nmhdr: TNMHdr;  // this must be first, so we don't break WM_NOTIFY
      stSelStart: SYSTEMTIME;
      cDayState: Integer;
      prgDayState: PMonthDaystate;
    end;

    // MCN_SELECT is sent whenever a selection has occured (via mouse or keyboard)
    //

    PNMSelect = ^TNMSelect;
    TNMSelect = TNMSelChange;

Const

    MCN_SELCHANGE     =  (MCN_FIRST + 1);
    MCN_GETDAYSTATE   =  (MCN_FIRST + 3);
    MCN_SELECT        =  (MCN_FIRST + 4);

    MCS_DAYSTATE      =  $0001;
    MCS_MULTISELECT   =  $0002;
    MCS_WEEKNUMBERS   =  $0004;
    MCS_NOTODAY       =  $0008;


    GMR_VISIBLE   =  0;       // visible portion of display
    GMR_DAYSTATE  =  1;       // above plus the grayed out parts of
                              // partially displayed months

//====== DATETIMEPICK CONTROL ==================================================

Const

    DATETIMEPICK_CLASS  =  'SysDateTimePick32';

    DTM_FIRST     =   $1000;

    DTM_GETSYSTEMTIME  = (DTM_FIRST + 1);
    DTM_SETSYSTEMTIME  = (DTM_FIRST + 2);
    DTM_GETRANGE       = (DTM_FIRST + 3);
    DTM_SETRANGE       = (DTM_FIRST + 4);
    DTM_SETFORMATA     = (DTM_FIRST + 5);
    DTM_SETFORMATW     = (DTM_FIRST + 50);
    DTM_SETFORMAT      = DTM_SETFORMATA;
    DTM_SETMCCOLOR     = (DTM_FIRST + 6);
    DTM_GETMCCOLOR     = (DTM_FIRST + 7);
    DTM_GETMONTHCAL    = (DTM_FIRST + 8);
    DTM_SETMCFONT      = (DTM_FIRST + 9);
    DTM_GETMCFONT      = (DTM_FIRST + 10);

    // DWORD DateTimePick_GetSystemtime(HWND hdp, LPSYSTEMTIME pst)
    //   returns GDT_NONE if "none" is selected (DTS_SHOWNONE only)
    //   returns GDT_VALID and modifies *pst to be the currently selected value

    function DateTime_GetSystemtime(hdp: HWND; Var pst: SYSTEMTIME): Integer;
    //  (DWORD)SNDMSG(hdp, DTM_GETSYSTEMTIME, 0, (LPARAM)(pst))

    // BOOL DateTime_SetSystemtime(HWND hdp, DWORD gd, LPSYSTEMTIME pst)
    //   if gd==GDT_NONE, sets datetimepick to None (DTS_SHOWNONE only)
    //   if gd==GDT_VALID, sets datetimepick to *pst
    //   returns TRUE on success, FALSE on error (such as bad params)

    function DateTime_SetSystemtime(hdp: HWND; gd: Integer;Var pst: SYSTEMTIME): Boolean;
    //    (BOOL)SNDMSG(hdp, DTM_SETSYSTEMTIME, (LPARAM)(gd), (LPARAM)(pst))

    // DWORD DateTime_GetRange(HWND hdp, LPSYSTEMTIME rgst)
    //   modifies rgst[0] to be the minimum ALLOWABLE systemtime (or 0 if no minimum)
    //   modifies rgst[1] to be the maximum ALLOWABLE systemtime (or 0 if no maximum)
    //   returns GDTR_MIN|GDTR_MAX if there is a minimum|maximum limit
    function DateTime_GetRange(hdp: HWND; Var rgst: SYSTEMTIME): Integer;
    //  (DWORD)SNDMSG(hdp, DTM_GETRANGE, 0, (LPARAM)(rgst))

    // BOOL DateTime_SetRange(HWND hdp, DWORD gdtr, LPSYSTEMTIME rgst)
    //   if GDTR_MIN, sets the minimum ALLOWABLE systemtime to rgst[0], otherwise removes minimum
    //   if GDTR_MAX, sets the maximum ALLOWABLE systemtime to rgst[1], otherwise removes maximum
    //   returns TRUE on success, FALSE on error (such as invalid parameters)

    function DateTime_SetRange(hdp: HWND; gd: Integer; Var rgst: SYSTEMTIME): Boolean;
    //  (BOOL)SNDMSG(hdp, DTM_SETRANGE, (WPARAM)(gd), (LPARAM)(rgst))

    // BOOL DateTime_SetFormat(HWND hdp, LPCTSTR sz)
    //   sets the display formatting string to sz (see GetDateFormat and GetTimeFormat for valid formatting chars)
    //   NOTE: 'X' is a valid formatting character which indicates that the application
    //   will determine how to display information. Such apps must support DTN_WMKEYDOWN,
    //   DTN_FORMAT, and DTN_FORMATQUERY.


    function DateTime_SetFormatA(hdp: HWND; Var sz : PAnsiChar): Boolean;
    function DateTime_SetFormatW(hdp: HWND; Var sz : PWideChar): Boolean;
    function DateTime_SetFormat(hdp: HWND; Var sz : PAnsiChar): Boolean;
    //  (BOOL)SNDMSG(hdp, DTM_SETFORMAT, 0, (LPARAM)(sz))

    function DateTime_SetMonthCalColor(hdp: HWND; iColor: Integer; clr: TColorRef): Longint;
    // SNDMSG(hdp, DTM_SETMCCOLOR, iColor, clr)

    function DateTime_GetMonthCalColor(hdp: HWND; iColor: Integer): Longint;
    // SNDMSG(hdp, DTM_GETMCCOLOR, iColor, 0)

    // HWND DateTime_GetMonthCal(HWND hdp)
    //   returns the HWND of the MonthCal popup window. Only valid
    // between DTN_DROPDOWN and DTN_CLOSEUP notifications.

    function DateTime_GetMonthCal(hdp: HWND): HWND;
    // (HWND)SNDMSG(hdp, DTM_GETMONTHCAL, 0, 0)

    function DateTime_SetMonthCalFont(hdp: HWND; hfont: HFONT; fRedraw: Boolean): Longint;
    // SNDMSG(hdp, DTM_SETMCFONT, (WPARAM)hfont, (LPARAM)fRedraw)

    function DateTime_GetMonthCalFont(hdp: HWND): Longint;
    // SNDMSG(hdp, DTM_GETMCFONT, 0, 0);

Const

    DTS_UPDOWN          = $0001; // use UPDOWN instead of MONTHCAL
    DTS_SHOWNONE        = $0002; // allow a NONE selection
    DTS_SHORTDATEFORMAT = $0000; // use the short date format (app must forward WM_WININICHANGE messages)
    DTS_LONGDATEFORMAT  = $0004; // use the long date format (app must forward WM_WININICHANGE messages)
    DTS_TIMEFORMAT      = $0009; // use the time format (app must forward WM_WININICHANGE messages)
    DTS_APPCANPARSE     = $0010; // allow user entered strings (app MUST respond to DTN_USERSTRING)
    DTS_RIGHTALIGN      = $0020; // right-align popup instead of left-align it

    DTN_DATETIMECHANGE  = (DTN_FIRST + 1); // the systemtime has changed
    DTN_USERSTRINGA     = (DTN_FIRST + 2); // the user has entered a string
    DTN_USERSTRINGW     = (DTN_FIRST + 15);
    DTN_USERSTRING      = DTN_USERSTRINGA;
    DTN_WMKEYDOWNA      = (DTN_FIRST + 3); // modify keydown on app format field (X)
    DTN_WMKEYDOWNW      = (DTN_FIRST + 16);
    DTN_WMKEYDOWN       = DTN_WMKEYDOWNA;
    DTN_FORMATA         = (DTN_FIRST + 4); // query display for app format field (X)
    DTN_FORMATW         = (DTN_FIRST + 17);
    DTN_FORMAT          = DTN_FORMATA;
    DTN_FORMATQUERYA    = (DTN_FIRST + 5); // query formatting info for app format field (X)
    DTN_FORMATQUERYW    = (DTN_FIRST + 18);
    DTN_FORMATQUERY     = DTN_FORMATQUERYA;

    DTN_DROPDOWN        = (DTN_FIRST + 6); // MonthCal has dropped down
    DTN_CLOSEUP         = (DTN_FIRST + 7); // MonthCal is popping up


    GDTR_MIN   =  $0001;
    GDTR_MAX   =  $0002;

    GDT_ERROR  =  -1;
    GDT_VALID  =  0;
    GDT_NONE   =  1;

Type

    PNMDateTimeChange = ^TNMDateTimeChange;
    TNMDateTimeChange = packed record
      nmhdr: TNMHdr;
      dwFlags: Longint;    // GDT_VALID or GDT_NONE
      st: SYSTEMTIME;         // valid iff dwFlags==GDT_VALID
    end;

    PNMDateTimeStringA = ^TNMDateTimeStringA;
    PNMDateTimeStringW = ^TNMDateTimeStringW;
    PNMDateTimeString  = PNMDateTimeStringA;

    TNMDateTimeStringA = packed record
      nmhdr: TNMHdr;
      pszUserString: PAnsiChar;  // string user entered
      st: SYSTEMTIME;            // app fills this in
      dwFlags: Longint;          // GDT_VALID or GDT_NONE
    end;

    TNMDateTimeStringW = packed record
      nmhdr: TNMHdr;
      pszUserString: PWideChar;  // string user entered
      st: SYSTEMTIME;            // app fills this in
      dwFlags: Longint;          // GDT_VALID or GDT_NONE
    end;

    TNMDateTimeString  = TNMDateTimeStringA;

    PNMDateTimeWMKeyDownA = ^TNMDateTimeWMKeyDownA;
    PNMDateTimeWMKeyDownW = ^TNMDateTimeWMKeyDownW;
    PNMDateTimeWMKeyDown  = PNMDateTimeWMKeyDownA;

    TNMDateTimeWMKeyDownA = packed record
      nmhdr: TNMHdr;
      nVirtKey: Integer;     // virtual key code of WM_KEYDOWN which MODIFIES an X field
      pszFormat: PAnsiChar;  // format substring
      st: SYSTEMTIME;        // current systemtime, app should modify based on key
    end;

    TNMDateTimeWMKeyDownW = packed record
      nmhdr: TNMHdr;
      nVirtKey: Integer;     // virtual key code of WM_KEYDOWN which MODIFIES an X field
      pszFormat: PWideChar;  // format substring
      st: SYSTEMTIME;        // current systemtime, app should modify based on key
    end;

    TNMDateTimeWMKeyDown  = TNMDateTimeWMKeyDownA;

    PNMDateTimeFormatA = ^TNMDateTimeFormatA;
    PNMDateTimeFormatW = ^TNMDateTimeFormatW;
    PNMDateTimeFormat  = PNMDateTimeFormatA;

    TNMDateTimeFormatA = packed record
      nmhdr: TNMHdr;
      pszFormat: PAnsiChar;  // format substring
      st: SYSTEMTIME;        // current systemtime
      pszDisplay: PAnsiChar; // string to display
      szDisplay: Array[0..64] of char; // buffer pszDisplay originally points at
    end;

    TNMDateTimeFormatW = packed record
      nmhdr: TNMHdr;
      pszFormat: PWideChar;  // format substring
      st: SYSTEMTIME;        // current systemtime
      pszDisplay: PWideChar; // string to display
      szDisplay: Array[0..64] of char; // buffer pszDisplay originally points at
    end;

    TNMDateTimeFormat  = TNMDateTimeFormatA;

    PNMDateTimeFormatQueryA = ^TNMDateTimeFormatQueryA;
    PNMDateTimeFormatQueryW = ^TNMDateTimeFormatQueryW;
    PNMDateTimeFormatQuery  = PNMDateTimeFormatQueryA;

    TNMDateTimeFormatQueryA = packed record
      nmhdr: TNMHdr;
      pszFormat: PAnsiChar;  // format substring
      szMax: TSize;           // max bounding rectangle app will use for this format string
    end;

    TNMDateTimeFormatQueryW = packed record
      nmhdr: TNMHdr;
      pszFormat: PWideChar;  // format substring
      szMax: TSize;           // max bounding rectangle app will use for this format string
    end;

    TNMDateTimeFormatQuery  = TNMDateTimeFormatQueryA;


//====== TrackMouseEvent  =====================================================

Const

    WM_MOUSEHOVER              =     $02A1;
    WM_MOUSELEAVE              =     $02A3;

//
// If the TRACKMOUSEEVENT structure and associated flags havent been declared
// then declare them now.
//

    TME_HOVER    =   $00000001;
    TME_LEAVE    =   $00000002;
    TME_QUERY    =   $40000000;
    TME_CANCEL   =   $80000000;


    HOVER_DEFAULT  = $FFFFFFFF;

Type

    PTrackMouseEvent = ^TTrackMouseEvent;
    TTrackMouseEvent = packed record
      cbSize: Longint;
      dwFlags: Longint;
      hwndTrack: HWND;
      dwHoverTime: Longint;
    end;

//
// Declare _TrackMouseEvent.  This API tries to use the window manager's
// implementation of TrackMouseEvent if it is present, otherwise it emulates.
//
function _TrackMouseEvent(Var lpEventTrack: PTrackMouseEvent): Boolean; stdcall;

  //==================== IP ADRESS EDIT CONTROL============================================
  //                         IE 4 EXTENSIONS

// Messages sent to IPAddress controls

const

  IPM_CLEARADDRESS = (WM_USER+100); // no parameters
  IPM_SETADDRESS   = (WM_USER+101); // lparam = TCP/IP address
  IPM_GETADDRESS   = (WM_USER+102); // lresult = # of non black fields.  lparam = LPDWORD for TCP/IP address
  IPM_SETRANGE     = (WM_USER+103); // wparam = field, lparam = range
  IPM_SETFOCUS     = (WM_USER+104); // wparam = field
  IPM_ISBLANK      = (WM_USER+105); // no parameters

  WC_IPADDRESS     = 'SysIPAddress32';

  IPN_FIELDCHANGED = (IPN_FIRST - 0);

type

  PNMIPAdress = ^TNMIPAdress;
  TNMIPAdress = packed record
    hdr: TNMHDR;
    iField: Integer;
    iValue: Integer;
  end;

// The following is a useful macro for passing the range values in the
// IPM_SETRANGE message.

function MakeIPRange(Low, High : Byte): Longint;
  //#define MAKEIPRANGE(low, high)    ((LPARAM)(WORD)(((BYTE)(high) << 8) + (BYTE)(low)))

// And this is a useful macro for making the IP Address to be passed
// as a LPARAM.

function MakeIPAdress(b1, b2, b3, b4 : Byte): Longint;
  //#define MAKEIPADDRESS(b1,b2,b3,b4)  ((LPARAM)(((DWORD)(b1)<<24)+((DWORD)(b2)<<16)+((DWORD)(b3)<<8)+((DWORD)(b4))))

// Get individual number
function First_IPAdress(x : Longint): Byte;
  //#define FIRST_IPADDRESS(x)  ((x>>24) & 0xff)
function Second_IPAdress(x : Longint): Byte;
  //#define SECOND_IPADDRESS(x) ((x>>16) & 0xff)
function Third_IPAdress(x : Longint): Byte;
  //#define THIRD_IPADDRESS(x)  ((x>>8) & 0xff)
function Fourth_IPAdress(x : Longint): Byte;
  //#define FOURTH_IPADDRESS(x) (x & 0xff)



implementation

const
  cctrl = 'comctl32.dll';

function InitCommonControlsEx(Var CC : TInitCommonControlsEx): boolean; external cctrl name 'InitCommonControlsEx';
function _TrackMouseEvent(Var lpEventTrack: PTrackMouseEvent): Boolean; external cctrl name '_TrackMouseEvent';

procedure InitTabCommonControlEx;
Var CC : TInitCommonControlsEx;
begin
  CC.dwSize:= sizeOf(TInitCommonControlsEx);
  CC.dwICC:= ICC_TAB_CLASSES;
  InitCommonControlsEx(CC);
end;

procedure InitCoolBarCommonControlEx;
Var CC : TInitCommonControlsEx;
begin
  CC.dwSize:= sizeOf(TInitCommonControlsEx);
  CC.dwICC:= ICC_COOL_CLASSES;
  InitCommonControlsEx(CC);
end;

procedure InitToolBarCommonControlEx;
Var CC : TInitCommonControlsEx;
begin
  CC.dwSize:= sizeOf(TInitCommonControlsEx);
  CC.dwICC:= ICC_BAR_CLASSES;
  InitCommonControlsEx(CC);
end;

procedure InitComboExCommonControlEx;
Var CC : TInitCommonControlsEx;
begin
  CC.dwSize:= sizeOf(TInitCommonControlsEx);
  CC.dwICC:= ICC_USEREX_CLASSES;
  InitCommonControlsEx(CC);
end;

procedure InitPickerCommonControlEx;
Var CC : TInitCommonControlsEx;
begin
  CC.dwSize:= sizeOf(TInitCommonControlsEx);
  CC.dwICC:= ICC_DATE_CLASSES;
  InitCommonControlsEx(CC);
end;

procedure InitIPAdressCommonControlEx;
Var CC : TInitCommonControlsEx;
begin
  CC.dwSize:= sizeOf(TInitCommonControlsEx);
  CC.dwICC:= ICC_INTERNET_CLASSES;
  InitCommonControlsEx(CC);
end;

function MonthCal_GetCurSel(hmc: HWND; Var pst: SystemTime): Boolean;
begin
  Result:= Boolean(SendMessage(hmc, MCM_GETCURSEL, 0, Longint(@pst)));
end;

function MonthCal_SetCurSel(hmc: HWND; Var pst: SystemTime): Boolean;
begin
  Result:= Boolean(SendMessage(hmc, MCM_SETCURSEL, 0, Longint(@pst)));
end;

function MonthCal_GetMaxSelCount(hmc: HWND): Longint;
begin
  Result:= SendMessage(hmc, MCM_GETMAXSELCOUNT, 0, 0);
end;

function MonthCal_SetMaxSelCount(hmc: HWND; n: Cardinal): Boolean;
begin
  Result:= Boolean(SendMessage(hmc, MCM_SETMAXSELCOUNT, WPARAM(n), 0));
end;

function MonthCal_GetSelRange(hmc: HWND; Var rgst: SystemTime): Longint;
begin
  Result:= SendMessage(hmc, MCM_GETSELRANGE, 0, Longint(@rgst));
end;

function MonthCal_SetSelRange(hmc: HWND; Var rgst: SystemTime): Longint;
begin
  Result:= SendMessage(hmc, MCM_SETSELRANGE, 0, Longint(@rgst));
end;

function MonthCal_GetMonthRange(hmc: HWND; gmr: Integer; Var rgst: SystemTime): Longint;
begin
  Result:= SendMessage(hmc, MCM_GETMONTHRANGE, WPARAM(gmr), Longint(@rgst));
end;

function MonthCal_SetDayState(hmc: HWND; cbds: Integer; Var rgds: PMonthDayState): Longint;
begin
  Result:= SendMessage(hmc, MCM_SETDAYSTATE, WPARAM(cbds), Longint(@rgds));
end;

function MonthCal_GetMinReqRect(hmc: HWND; Var prc: TRect): Longint;
begin
  Result:= SendMessage(hmc, MCM_GETMINREQRECT, 0, Longint(@prc));
end;

function MonthCal_SetToday(hmc: HWND; Var pst: SystemTime): Longint;
begin
  Result:= SendMessage(hmc, MCM_SETTODAY, 0, Longint(@pst));
end;

function MonthCal_GetToday(hmc: HWND; Var pst: SystemTime): Boolean;
begin
 Result:= Boolean(SendMessage(hmc, MCM_GETTODAY, 0, Longint(@pst)));
end;

function MonthCal_HitTest(hmc: HWND; Var pinfo : PMCHitTestInfo): Longint;
begin
  Result:= SendMessage(hmc, MCM_HITTEST, 0, Longint(@pinfo));
end;

function MonthCal_SetColor(hmc: HWND; iColor: Integer; clr: TColorRef) : Longint;
begin
  Result:= SendMessage(hmc, MCM_SETCOLOR, iColor, Longint(clr));
end;

function MonthCal_GetColor(hmc: HWND; iColor: Integer) : Longint;
begin
  Result:= SendMessage(hmc, MCM_SETCOLOR, iColor, 0);
end;

function MonthCal_SetFirstDayOfWeek(hmc: HWND; iDay: Longint): Longint;
begin
  Result:= SendMessage(hmc, MCM_SETFIRSTDAYOFWEEK, 0, iDay);
end;

function MonthCal_GetFirstDayOfWeek(hmc: HWND): Integer;
begin
  Result:= Integer(SendMessage(hmc, MCM_GETFIRSTDAYOFWEEK, 0, 0));
end;

function MonthCal_GetRange(hmc: HWND; Var rgst : SYSTEMTIME): Integer;
begin
  Result:= Integer(SendMessage(hmc, MCM_GETRANGE, 0, Longint(@rgst)));
end;

function MonthCal_SetRange(hmc: HWND; gd: Integer; Var rgst: SYSTEMTIME): Boolean;
begin
  Result:= Boolean(SendMessage(hmc, MCM_SETRANGE, gd, Longint(@rgst)));
end;

function MonthCal_GetMonthDelta(hmc: HWND): Integer;
begin
  Result:= Integer(SendMessage(hmc, MCM_GETMONTHDELTA, 0, 0));
end;

function MonthCal_SetMonthDelta(hmc: HWND; n: Integer): Integer;
begin
  Result:= Integer(SendMessage(hmc, MCM_SETMONTHDELTA, n, 0));
end;

function DateTime_GetSystemtime(hdp: HWND; Var pst: SYSTEMTIME): Integer;
begin
  Result:= Integer(SendMessage(hdp, DTM_GETSYSTEMTIME, 0, Longint(@pst)));
end;

function DateTime_SetSystemtime(hdp: HWND; gd: Integer;Var pst: SYSTEMTIME): Boolean;
begin
  Result:= Boolean(SendMessage(hdp, DTM_SETSYSTEMTIME, gd, Longint(@pst)));
end;

function DateTime_GetRange(hdp: HWND; Var rgst: SYSTEMTIME): Integer;
begin
  Result:= Integer(SendMessage(hdp, DTM_GETRANGE, 0, Longint(@rgst)));
end;

function DateTime_SetRange(hdp: HWND; gd: Integer; Var rgst: SYSTEMTIME): Boolean;
begin
  Result:= Boolean(SendMessage(hdp, DTM_SETRANGE, gd, Longint(@rgst)));
end;

function DateTime_SetFormatA(hdp: HWND; Var sz : PAnsiChar): Boolean;
begin
  Result:= Boolean(SendMessage(hdp, DTM_SETFORMAT, 0, Longint(@sz)));
end;

function DateTime_SetFormatW(hdp: HWND; Var sz : PWideChar): Boolean;
begin
  Result:= Boolean(SendMessage(hdp, DTM_SETFORMAT, 0, Longint(@sz)));
end;

function DateTime_SetFormat(hdp: HWND; Var sz : PAnsiChar): Boolean;
begin
  Result:= Boolean(SendMessage(hdp, DTM_SETFORMAT, 0, Longint(@sz)));
end;

function DateTime_SetMonthCalColor(hdp: HWND; iColor: Integer; clr: TColorRef): Longint;
begin
  Result:= SendMessage(hdp, DTM_SETMCCOLOR, iColor, clr);
end;

function DateTime_GetMonthCalColor(hdp: HWND; iColor: Integer): Longint;
begin
  Result:= SendMessage(hdp, DTM_GETMCCOLOR, iColor, 0);
end;

function DateTime_GetMonthCal(hdp: HWND): HWND;
begin
  Result:= HWND(SendMessage(hdp, DTM_GETMONTHCAL, 0, 0));
end;

function DateTime_SetMonthCalFont(hdp: HWND; hfont: HFONT; fRedraw: Boolean): Longint;
begin
  Result:= SendMessage(hdp, DTM_SETMCFONT, Integer(hfont), Longint(fRedraw));
end;

function DateTime_GetMonthCalFont(hdp: HWND): Longint;
begin
  Result:= SendMessage(hdp, DTM_GETMCFONT, 0, 0);
end;

function TabCtrl_HighlightItem(hwnd: HWND; i : Cardinal; fHighlight : Bool): Bool;
begin
  Result:= Bool(SendMessage(hwnd, TCM_HIGHLIGHTITEM, i, Longint(fHighlight)));
end;

function TabCtrl_SetExtendedStyle(hwnd: HWND; dw: Longint): Longint;
begin
  Result:= SendMessage(hwnd, TCM_SETEXTENDEDSTYLE, 0, dw);
end;

function TabCtrl_GetExtendedStyle(hwnd: HWND): Longint;
begin
  Result:= SendMessage(hwnd, TCM_GETEXTENDEDSTYLE, 0, 0);
end;

function MakeIPRange(Low, High : Byte): Longint;
begin
  Result:= Longint((word(high) SHL 8) + low);
end;

function MakeIPAdress(b1, b2, b3, b4 : Byte): Longint;
begin
  Result:= Longint((Longint(b1) Shl 24)+(Longint(b2) Shl 16)+(Longint(b3) Shl 8)+(Longint(b4)));
end;

function First_IPAdress(x : Longint): Byte;
begin
  Result:= Byte((x Shr 24) and $0FF);
end;

function Second_IPAdress(x : Longint): Byte;
begin
  Result:= Byte((x Shr 16) and $0FF);
end;

function Third_IPAdress(x : Longint): Byte;
begin
  Result:= Byte((x Shr 8) and $0FF);
end;

function Fourth_IPAdress(x : Longint): Byte;
begin
  Result:= Byte(x and $0FF);
end;

end.
