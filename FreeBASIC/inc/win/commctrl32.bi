#ifndef COMMCTRL32_BI
#define COMMCTRL32_BI
'-----------
'COMMCTRL32.BI
'-----------
'
'This header defines every obtainable commctrl32 Function and related data types and structures.

'VERSION: 1.02

'Changelog:
'  1.02: TINITCOMMONCONTROLSEX named back to INITCOMMONCONTROLSEX, TYPE's can have the same name as other symbols since ver 0.09 (v1ctor)
'  1.01: bunch of constants added (many missing), INITCOMMONCONTROLSEX with a T prefix now to not clash with the proc (v1c)

'$include once: 'win\winbase.bi'
'$include once: "win\user32.bi"
'$include once: "win\gdi32.bi"

'----------------------
'| REQUIRED CONSTANTS |
'----------------------

#define ICC_LISTVIEW_CLASSES  1
#define ICC_TREEVIEW_CLASSES  2
#define ICC_BAR_CLASSES  4
#define ICC_TAB_CLASSES  8
#define ICC_UPDOWN_CLASS  16
#define ICC_PROGRESS_CLASS  32
#define ICC_HOTKEY_CLASS  64
#define ICC_ANIMATE_CLASS  128
#define ICC_WIN95_CLASSES  255
#define ICC_DATE_CLASSES  256
#define ICC_USEREX_CLASSES  512
#define ICC_COOL_CLASSES  1024
#define ICC_INTERNET_CLASSES  2048
#define ICC_PAGESCROLLER_CLASS  4096
#define ICC_NATIVEFNTCTL_CLASS  8192

#define HINST_COMMCTRL  -1 

#define IDB_STD_SMALL_COLOR  0
#define IDB_STD_LARGE_COLOR  1
#define IDB_VIEW_SMALL_COLOR  4
#define IDB_VIEW_LARGE_COLOR  5
#define IDB_HIST_SMALL_COLOR  8
#define IDB_HIST_LARGE_COLOR  9

#define TBSTATE_CHECKED  1
#define TBSTATE_PRESSED  2
#define TBSTATE_ENABLED  4
#define TBSTATE_HIDDEN  8
#define TBSTATE_INDETERMINATE  16
#define TBSTATE_WRAP  32
#define TBSTATE_MARKED  &h0080
#define TBSTYLE_BUTTON  0
#define TBSTYLE_SEP  1
#define TBSTYLE_CHECK  2
#define TBSTYLE_GROUP  4
#define TBSTYLE_CHECKGROUP  (TBSTYLE_GROUP or TBSTYLE_CHECK)
#define TBSTYLE_DROPDOWN  8
#define TBSTYLE_AUTOSIZE  16
#define TBSTYLE_NOPREFIX  32
#define TBSTYLE_TOOLTIPS  256
#define TBSTYLE_WRAPABLE  512
#define TBSTYLE_ALTDRAG  1024
#define TBSTYLE_FLAT  2048
#define TBSTYLE_LIST  4096
#define TBSTYLE_CUSTOMERASE  8192
#define TBSTYLE_REGISTERDROP  &h4000
#define TBSTYLE_TRANSPARENT  &h8000
#define TBSTYLE_EX_DRAWDDARROWS  &h00000001
#define TBSTYLE_EX_MIXEDBUTTONS  8
#define TBSTYLE_EX_HIDECLIPPEDBUTTONS  16
#define TBSTYLE_EX_DOUBLEBUFFER  &h80

#define CCS_TOP  1
#define CCS_NOMOVEY  2
#define CCS_BOTTOM  3
#define CCS_NORESIZE  4
#define CCS_NOPARENTALIGN  8
#define CCS_ADJUSTABLE  32
#define CCS_NODIVIDER  64
#define CCS_VERT  128
#define CCS_LEFT  129
#define CCS_NOMOVEX  130
#define CCS_RIGHT  131

#define STD_CUT  0
#define STD_COPY  1
#define STD_PASTE  2
#define STD_UNDO  3
#define STD_REDOW  4
#define STD_DELETE  5
#define STD_FILENEW  6
#define STD_FILEOPEN  7
#define STD_FILESAVE  8
#define STD_PRINTPRE  9
#define STD_PROPERTIES  10
#define STD_HELP  11
#define STD_FIND  12
#define STD_REPLACE  13
#define STD_PRINT  14

#define TB_ENABLEBUTTON  (WM_USER+1)
#define TB_CHECKBUTTON  (WM_USER+2)
#define TB_PRESSBUTTON  (WM_USER+3)
#define TB_HIDEBUTTON  (WM_USER+4)
#define TB_INDETERMINATE  (WM_USER+5)
#define TB_ISBUTTONENABLED  (WM_USER+9)
#define TB_ISBUTTONCHECKED  (WM_USER+10)
#define TB_ISBUTTONPRESSED  (WM_USER+11)
#define TB_ISBUTTONHIDDEN  (WM_USER+12)
#define TB_ISBUTTONINDETERMINATE  (WM_USER+13)
#define TB_ISBUTTONHIGHLIGHTED  (WM_USER+14)
#define TB_SETSTATE  (WM_USER+17)
#define TB_GETSTATE  (WM_USER+18)
#define TB_ADDBITMAP  (WM_USER+19)
#define TB_ADDBUTTONSA  (WM_USER+20)
#define TB_INSERTBUTTONA  (WM_USER+21)
#define TB_ADDBUTTONS  (WM_USER+20)
#define TB_INSERTBUTTON  (WM_USER+21)
#define TB_DELETEBUTTON  (WM_USER+22)
#define TB_GETBUTTON  (WM_USER+23)
#define TB_BUTTONCOUNT  (WM_USER+24)
#define TB_COMMANDTOINDEX  (WM_USER+25)
#define TB_SAVERESTOREA  (WM_USER+26)
#define TB_SAVERESTOREW  (WM_USER+76)
#define TB_CUSTOMIZE  (WM_USER+27)
#define TB_ADDSTRINGA  (WM_USER+28)
#define TB_ADDSTRINGW  (WM_USER+77)
#define TB_GETITEMRECT  (WM_USER+29)
#define TB_BUTTONSTRUCTSIZE  (WM_USER+30)
#define TB_SETBUTTONSIZE  (WM_USER+31)
#define TB_SETBITMAPSIZE  (WM_USER+32)
#define TB_AUTOSIZE  (WM_USER+33)
#define TB_GETTOOLTIPS  (WM_USER+35)
#define TB_SETTOOLTIPS  (WM_USER+36)
#define TB_SETPARENT  (WM_USER+37)
#define TB_SETROWS  (WM_USER+39)
#define TB_GETROWS  (WM_USER+40)
#define TB_GETBITMAPFLAGS  (WM_USER+41)
#define TB_SETCMDID  (WM_USER+42)
#define TB_CHANGEBITMAP  (WM_USER+43)
#define TB_GETBITMAP  (WM_USER+44)
#define TB_GETBUTTONTEXTA  (WM_USER+45)
#define TB_GETBUTTONTEXTW  (WM_USER+75)
#define TB_REPLACEBITMAP  (WM_USER+46)
#define TB_GETBUTTONSIZE  (WM_USER+58)
#define TB_SETBUTTONWIDTH  (WM_USER+59)
#define TB_SETINDENT  (WM_USER+47)
#define TB_SETIMAGELIST  (WM_USER+48)
#define TB_GETIMAGELIST  (WM_USER+49)
#define TB_LOADIMAGES  (WM_USER+50)
#define TB_GETRECT  (WM_USER+51)
#define TB_SETHOTIMAGELIST  (WM_USER+52)
#define TB_GETHOTIMAGELIST  (WM_USER+53)
#define TB_SETDISABLEDIMAGELIST  (WM_USER+54)
#define TB_GETDISABLEDIMAGELIST  (WM_USER+55)
#define TB_SETSTYLE  (WM_USER+56)
#define TB_GETSTYLE  (WM_USER+57)
#define TB_SETMAXTEXTROWS  (WM_USER+60)
#define TB_GETTEXTROWS  (WM_USER+61)
#define TB_GETOBJECT  (WM_USER+62)
#define TB_GETBUTTONINFOW  (WM_USER+63)
#define TB_SETBUTTONINFOW  (WM_USER+64)
#define TB_GETBUTTONINFOA  (WM_USER+65)
#define TB_SETBUTTONINFOA  (WM_USER+66)
#define TB_INSERTBUTTONW  (WM_USER+67)
#define TB_ADDBUTTONSW  (WM_USER+68)
#define TB_HITTEST  (WM_USER+69)
#define TB_SETEXTENDEDSTYLE  (WM_USER+84)
#define TB_GETEXTENDEDSTYLE  (WM_USER+85)
#define TB_SETDRAWTEXTFLAGS  (WM_USER+70)
#define TB_GETHOTITEM  (WM_USER+71)
#define TB_SETHOTITEM  (WM_USER+72)
#define TB_SETANCHORHIGHLIGHT  (WM_USER+73)
#define TB_GETANCHORHIGHLIGHT  (WM_USER+74)
#define TB_MAPACCELERATORA  (WM_USER+78)
#define TB_GETINSERTMARK  (WM_USER+79)
#define TB_SETINSERTMARK  (WM_USER+80)
#define TB_INSERTMARKHITTEST  (WM_USER+81)
#define TB_MOVEBUTTON  (WM_USER+82)
#define TB_GETMAXSIZE  (WM_USER+83)
#define TB_GETPADDING  (WM_USER+86)
#define TB_SETPADDING  (WM_USER+87)
#define TB_SETINSERTMARKCOLOR  (WM_USER+88)
#define TB_GETINSERTMARKCOLOR  (WM_USER+89)
#define TB_MAPACCELERATORW  (WM_USER+90)
'''''#define TB_SETCOLORSCHEME  CCM_SETCOLORSCHEME
'''''#define TB_GETCOLORSCHEME  CCM_GETCOLORSCHEME
'''''#define TB_SETUNICODEFORMAT  CCM_SETUNICODEFORMAT
'''''#define TB_GETUNICODEFORMAT  CCM_GETUNICODEFORMAT



''!!!WRITEME!!! loads of constants missing !!!WRITEME!!!


'------------------
'| REQUIRED TYPES |
'------------------

Type INITCOMMONCONTROLSEX
  dwSize As Integer 'size of this structure
  dwICC  As Integer 'flags indicating which classes to be initialized
End Type

Type IMAGEINFO
  hbmImage As Integer
  hbmMask  As Integer
  Unused1  As Integer
  Unused2  As Integer
  rcImage  As RECT
End Type

Type IMAGELISTDRAWPARAMS
  cbSize As Uinteger
'  himl As HIMAGELIST 'this is an OLE_HANDLE...???
  i As Integer
  hdcDst As Integer 'hdc
  x As Integer
  y As Integer
  cx As Integer
  cy As Integer
  xBitmap As Integer
  yBitmap As Integer
  rgbBk As Integer 'COLORREF
  rgbFg As Integer 'COLORREF
  fstyle As Uinteger
  dwRop As Integer
  fState As Integer
  Frame As Integer
  crEffect As Integer
End Type

type TBADDBITMAP 
   handle As Integer 
   nID    As Integer 
end type 

type TBBUTTON 
   iBitmap    As Integer 
   idCommand  As Integer 
   fsState    as byte
   fsStyle    as byte
   bReserved  as short
   dwData     As Integer 
   iString    As Integer 
end type 

'-----------------
'| API FUNCTIONS |
'-----------------

'Declare Function CreateMappedBitmap Lib "comctl32" (ByVal hInstance As Integer, ByRef idBitmap As T_PTR, ByVal wFlags As Integer, ByRef lpColorMap As ColorMap, ByValumMaps As Integer) As Integer
'Declare Function CreatePropertySheetPage Lib "comctl32" (ByRef lpcpropsheetpagea As CPROPSHEETPAGEA) As Integer
Declare Function CreateStatusWindow Lib "comctl32" (ByVal style As Integer, ByVal lpszText As String, ByVal hwndParent As Integer, ByVal wID As Integer) As Integer
'Declare Function CreateToolbarEx Lib "comctl32" (ByVal hwnd As Integer, ByVal ws As Integer, ByVal wID As Integer, ByVal nBitmaps As Integer, ByVal hBMInst As Integer, ByRef wBMID As Integer, ByRef lpButtons As CTBBUTTON, ByVal numButtons As Integer, ByVal dxButton As Integer, ByVal dyButton As Integer, ByVal dxBitmap As Integer, ByVal dyBitmap As Integer, ByVal uStructSize As Integer) As Integer
Declare Function CreateUpDownControl Lib "comctl32" (ByVal dwStyle As Integer, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal hParent As Integer, ByVal nID As Integer, ByVal hInst As Integer, ByVal hBuddy As Integer, ByVal nUpper As Integer, ByVal nLower As Integer, ByVal nPos As Integer) As Integer
Declare Function DestroyPropertySheetPage Lib "comctl32" (ByVal hpropsheetpage As Integer) As Integer
Declare Sub DrawInsert Lib "comctl32" (ByVal handParent As Integer, ByVal hLB As Integer, ByVal nItem As Integer)
Declare Sub DrawStatusText Lib "comctl32" (ByVal hDC As Integer, ByRef lprc As RECT, ByVal pszText As String, ByVal uFlags As Integer)
Declare Function FlatSB_EnableScrollBar Lib "comctl32" (ByVal hwnd As Integer, ByValt As Integer, ByVal uint As Integer) As Integer
Declare Function FlatSB_GetScrollInfo Lib "comctl32" (ByVal hwnd As Integer, ByVal code As Integer, ByRef lpscrollinfo As SCROLLINFO) As Integer
Declare Function FlatSB_GetScrollPos Lib "comctl32" (ByVal hwnd As Integer, ByVal code As Integer) As Integer
Declare Function FlatSB_GetScrollProp Lib "comctl32" (ByVal hwnd As Integer, ByVal propIndex As Integer, ByRef lpint As Integer) As Integer
Declare Function FlatSB_GetScrollRange Lib "comctl32" (ByVal hwnd As Integer, ByVal code As Integer, ByRef lpint As Integer, ByRef lpint As Integer) As Integer
Declare Function FlatSB_SetScrollInfo Lib "comctl32" (ByVal hwnd As Integer, ByVal code As Integer, ByRef lpscrollinfo As SCROLLINFO, ByVal fRedraw As Integer) As Integer
Declare Function FlatSB_SetScrollPos Lib "comctl32" (ByVal hwnd As Integer, ByVal code As Integer, ByVal pos As Integer, ByVal fRedraw As Integer) As Integer
'Declare Function FlatSB_SetScrollProp Lib "comctl32" (ByVal hwnd As Integer, ByVal index As Integer, ByRef newValue As T_PTR, ByVal bool As Integer) As Integer
Declare Function FlatSB_SetScrollRange Lib "comctl32" (ByVal hwnd As Integer, ByVal code As Integer, ByVal min As Integer, ByVal max As Integer, ByVal fRedraw As Integer) As Integer
Declare Function FlatSB_ShowScrollBar Lib "comctl32" (ByVal hwnd As Integer, ByVal code As Integer, ByVal bool As Integer) As Integer
Declare Sub GetEffectiveClientRect Lib "comctl32" (ByVal hWnd As Integer, ByRef lprc As RECT, ByRef lpInfo As Integer)
Declare Function GetMUILanguage Lib "comctl32" () As Integer
Declare Function ImageList_Add Lib "comctl32" (ByVal himl As Integer, ByVal hbmImage As Integer, ByVal hbmMask As Integer) As Integer
Declare Function ImageList_AddMasked Lib "comctl32" (ByVal himl As Integer, ByVal hbmImage As Integer, ByVal crMask As Integer) As Integer
Declare Function ImageList_BeginDrag Lib "comctl32" (ByVal himlTrack As Integer, ByVal iTrack As Integer, ByVal dxHotspot As Integer, ByVal dyHotspot As Integer) As Integer
Declare Function ImageList_Copy Lib "comctl32" (ByVal himlDst As Integer, ByVal iDst As Integer, ByVal himlSrc As Integer, ByVal iSrc As Integer, ByVal uFlags As Integer) As Integer
Declare Function ImageList_Create Lib "comctl32" (ByVal cx As Integer, ByVal cy As Integer, ByVal flags As Integer, ByVal cInitial As Integer, ByVal cGrow As Integer) As Integer
Declare Function ImageList_Destroy Lib "comctl32" (ByVal himl As Integer) As Integer
Declare Function ImageList_DragEnter Lib "comctl32" (ByVal hwndLock As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function ImageList_DragLeave Lib "comctl32" (ByVal hwndLock As Integer) As Integer
Declare Function ImageList_DragMove Lib "comctl32" (ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function ImageList_DragShowNolock Lib "comctl32" (ByVal fShow As Integer) As Integer
Declare Function ImageList_Draw Lib "comctl32" (ByVal himl As Integer, ByVal i As Integer, ByVal hdcDst As Integer, ByVal x As Integer, ByVal y As Integer, ByVal fStyle As Integer) As Integer
Declare Function ImageList_DrawEx Lib "comctl32" (ByVal himl As Integer, ByVal i As Integer, ByVal hdcDst As Integer, ByVal x As Integer, ByVal y As Integer, ByVal dx As Integer, ByVal dy As Integer, ByVal rgbBk As Integer, ByVal rgbFg As Integer, ByVal fStyle As Integer) As Integer
Declare Function ImageList_DrawIndirect Lib "comctl32" (ByRef pimldp As IMAGELISTDRAWPARAMS) As Integer
Declare Function ImageList_Duplicate Lib "comctl32" (ByVal himl As Integer) As Integer
Declare Sub ImageList_EndDrag Lib "comctl32" ()
Declare Function ImageList_GetBkColor Lib "comctl32" (ByVal himl As Integer) As Integer
Declare Function ImageList_GetDragImage Lib "comctl32" (ByRef ppt As POINTAPI, ByRef pptHotspot As POINTAPI) As Integer
Declare Function ImageList_GetIcon Lib "comctl32" (ByVal himl As Integer, ByVal i As Integer, ByVal flags As Integer) As Integer
Declare Function ImageList_GetIconSize Lib "comctl32" (ByVal himl As Integer, ByRef cx As Integer, ByRef cy As Integer) As Integer
Declare Function ImageList_GetImageCount Lib "comctl32" (ByVal himl As Integer) As Integer
Declare Function ImageList_GetImageInfo Lib "comctl32" (ByVal himl As Integer, ByVal i As Integer, ByRef pImageInfo As IMAGEINFO) As Integer
Declare Function ImageList_LoadImage Lib "comctl32" (ByVal hi As Integer, ByVal lpbmp As String, ByVal cx As Integer, ByVal cGrow As Integer, ByVal crMask As Integer, ByVal uType As Integer, ByVal uFlags As Integer) As Integer
Declare Function ImageList_Merge Lib "comctl32" (ByVal himl1 As Integer, ByVal i1 As Integer, ByVal himl2 As Integer, ByVal i2 As Integer, ByVal dx As Integer, ByVal dy As Integer) As Integer
Declare Function ImageList_Read Lib "comctl32" (ByRef pstm As Integer) As Integer
Declare Function ImageList_Remove Lib "comctl32" (ByVal himl As Integer, ByVal i As Integer) As Integer
Declare Function ImageList_Replace Lib "comctl32" (ByVal himl As Integer, ByVal i As Integer, ByVal hbmImage As Integer, ByVal hbmMask As Integer) As Integer
Declare Function ImageList_ReplaceIcon Lib "comctl32" (ByVal himl As Integer, ByVal i As Integer, ByVal hicon As Integer) As Integer
Declare Function ImageList_SetBkColor Lib "comctl32" (ByVal himl As Integer, ByVal clrBk As Integer) As Integer
Declare Function ImageList_SetDragCursorImage Lib "comctl32" (ByVal himlDrag As Integer, ByVal iDrag As Integer, ByVal dxHotspot As Integer, ByVal dyHotspot As Integer) As Integer
Declare Function ImageList_SetIconSize Lib "comctl32" (ByVal himl As Integer, ByVal cx As Integer, ByVal cy As Integer) As Integer
Declare Function ImageList_SetImageCount Lib "comctl32" (ByVal himl As Integer, ByVal uNewCount As Integer) As Integer
Declare Function ImageList_SetOverlayImage Lib "comctl32" (ByVal himl As Integer, ByVal iImage As Integer, ByVal iOverlay As Integer) As Integer
Declare Function ImageList_Write Lib "comctl32" (ByVal himl As Integer, ByRef pstm As Integer) As Integer
Declare Sub InitCommonControls Lib "comctl32" ()
Declare Function InitCommonControlsEx Lib "comctl32" (ByRef TLPINITCOMMONCONTROLSEX As INITCOMMONCONTROLSEX) As Integer
Declare Sub InitMUILanguage Lib "comctl32" (ByVal uiLang As Integer)
Declare Function InitializeFlatSB Lib "comctl32" (ByVal hwnd As Integer) As Integer
Declare Function LBItemFromPt Lib "comctl32" (ByVal hLB As Integer, Byref pt As POINTAPI, ByVal bAutoScroll As Integer) As Integer
Declare Function MakeDragList Lib "comctl32" (ByVal hLB As Integer) As Integer
Declare Sub MenuHelp Lib "comctl32" (ByVal uMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer, ByVal hMainMenu As Integer, ByVal hInst As Integer, ByVal hwndStatus As Integer, ByRef lpwIDs As Integer)
'Declare Sub PropertySheet Lib "comctl32" (ByRef lpcpropsheetheadera As CPROPSHEETHEADERA)
Declare Function ShowHideMenuCtl Lib "comctl32" (ByVal hWnd As Integer, ByRef uFlags As Integer, ByRef lpInfo As Integer) As Integer
Declare Function UninitializeFlatSB Lib "comctl32" (ByVal hwnd As Integer) As Integer
'Declare Function TrackMouseEvent Lib "comctl32" (ByRef lpEventTrack As TRACKMOUSEEVENT) As Integer
#endif 'COMMCTRL32_BI