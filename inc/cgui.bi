''
''
'' cgui -- A C Graphical User Interface [add on to Allegro] 
''		   (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cgui_bi__
#define __cgui_bi__

#include once "crt.bi"

#ifndef FONT
type FONT as any
type BITMAP as any
type DATAFILE as any
#endif

#ifndef NULL
#define NULL 0
#endif

#ifdef CGUI_STATICLINK
#define EXTERNVAR extern 
#else
#define EXTERNVAR extern import
#endif

#inclib "cgui"

#define CGUI_VERSION_MAJOR 1
#define CGUI_VERSION_MINOR 6
#define CGUI_VERSION_PATCH 9
#define CGUI_VERSION_STRING "1.6.9"
#define CGUI_DATE 20041205
#define CGUI_DATE_STRING "Dec 05, 2004"
#define CGUI_INIT_CODE 0
#define CGUI_INIT_LOAD 0
#define CGUI_INIT_WINDOWED 1
#define CGUI_INIT_FULLSCREEN 2
#define CGUI_INIT_KEEP_CURRENT 0

declare function InitCguiEx cdecl alias "InitCguiEx" (byval w as integer, byval h as integer, byval colour_depth as integer, byval errno_ptr as integer ptr, byval atexit_ptr as function cdecl(byval as sub cdecl()) as integer) as integer
declare sub DeInitCgui cdecl alias "DeInitCgui" ()

#define InitCguiLoadMode()  InitCguiEx(0, CGUI_INIT_LOAD, CGUI_INIT_CODE, @errno, @atexit)
#define InitCguiFullscreenMode()  InitCguiEx(0, CGUI_INIT_FULLSCREEN, CGUI_INIT_CODE, @errno, @atexit)
#define InitCguiWindowedMode()  InitCguiEx(0, CGUI_INIT_WINDOWED, CGUI_INIT_CODE, @errno, @atexit)
#define InitCguiKeepCurrent()  InitCguiEx(0, CGUI_INIT_KEEP_CURRENT, CGUI_INIT_CODE, @errno, @atexit)
#define InitCgui(w,h,bpp)  InitCguiEx(w, h, bpp, @errno, @atexit)

EXTERNVAR cgui_ver alias "cgui_ver" as integer
EXTERNVAR cgui_rev alias "cgui_rev" as integer
EXTERNVAR cgui_minor_rev alias "cgui_minor_rev" as integer
EXTERNVAR cgui_release_date alias "cgui_release_date" as integer

#define CGUI_DIR_TOPLEFT 1
#define CGUI_DIR_RIGHT 2
#define CGUI_DIR_LEFT 4
#define CGUI_DIR_DOWNLEFT 8
#define CGUI_DIR_DOWN &h10
#define CGUI_AUTOINDICATOR &h007fffff
#define CGUI_TOPLEFT CGUI_DIR_TOPLEFT,CGUI_AUTOINDICATOR
#define CGUI_RIGHT CGUI_DIR_RIGHT,CGUI_AUTOINDICATOR
#define CGUI_DOWNLEFT CGUI_DIR_DOWNLEFT,CGUI_AUTOINDICATOR
#define CGUI_LEFT CGUI_DIR_LEFT,CGUI_AUTOINDICATOR
#define CGUI_DOWN CGUI_DIR_DOWN,CGUI_AUTOINDICATOR
#define CGUI_ALIGNCENTRE &h00800000
#define CGUI_ALIGNBOTTOM &h01000000
#define CGUI_ALIGNRIGHT &h02000000
#define CGUI_HORIZONTAL &h04000000
#define CGUI_VERTICAL &h08000000
#define CGUI_FILLSPACE &h10000000
#define CGUI_EQUALWIDTH &h20000000
#define CGUI_EQUALHEIGHT &h40000000

#define CGUI_ADAPTIVE        0,CGUI_AUTOINDICATOR
#define CGUI_FILLSCREEN      1,CGUI_AUTOINDICATOR

declare function MkDialogue cdecl alias "MkDialogue" (byval width as integer, byval height as integer, byval label as zstring ptr, byval attr as integer) as integer

#define CGUI_W_SIBLING (1 shl 0)
#define CGUI_W_NOMOVE (1 shl 2)
#define CGUI_W_FLOATING (1 shl 3)
#define CGUI_W_TOP (1 shl 4)
#define CGUI_W_BOTTOM (1 shl 5)
#define CGUI_W_LEFT (1 shl 6)
#define CGUI_W_RIGHT (1 shl 7)
#define CGUI_W_CENTRE_H ((1 shl 6) or (1 shl 7))
#define CGUI_W_CENTRE_V ((1 shl 4) or (1 shl 5))
#define CGUI_W_CENTRE (((1 shl 6) or (1 shl 7)) or ((1 shl 4) or (1 shl 5)))

declare sub DisplayWin cdecl alias "DisplayWin" ()
declare sub CloseWin cdecl alias "CloseWin" (byval dummy as any ptr)
declare sub SetWindowPosition cdecl alias "SetWindowPosition" (byval x as integer, byval y as integer)
declare sub GetWinInfo cdecl alias "GetWinInfo" (byval id as integer, byval x as integer ptr, byval y as integer ptr, byval width as integer ptr, byval height as integer ptr)
declare sub DesktopImage cdecl alias "DesktopImage" (byval bmp as BITMAP ptr)
declare function CurrentWindow cdecl alias "CurrentWindow" () as integer
declare sub SetOperatingWindow cdecl alias "SetOperatingWindow" (byval winid as integer)
declare function Req cdecl alias "Req" (byval winheader as zstring ptr, byval format_text as zstring ptr) as integer
declare function Request cdecl alias "Request" (byval title as zstring ptr, byval options as integer, byval width as integer, byval format as zstring ptr, ...) as integer
declare sub RedrawScreen cdecl alias "RedrawScreen" ()
declare sub ScrMode cdecl alias "ScrMode" (byval CallBack as sub cdecl())
declare function MkProgressWindow cdecl alias "MkProgressWindow" (byval wlabel as zstring ptr, byval blabel as zstring ptr, byval w as integer) as integer

#define CGUI_ID_DESKTOP cgui_desktop_id
EXTERNVAR cgui_desktop_id alias "cgui_desktop_id" as integer

declare function MkMenu cdecl alias "MkMenu" (byval text as zstring ptr, byval CallBack as sub cdecl(byval as any ptr), byval data as any ptr) as integer
declare function MakeMenuBar cdecl alias "MakeMenuBar" () as integer
declare function MkMenuBarItem cdecl alias "MkMenuBarItem" (byval text as zstring ptr, byval CallBack as sub cdecl(byval as any ptr), byval data as any ptr) as integer
declare sub EndMenuBar cdecl alias "EndMenuBar" ()
declare function MkScratchMenu cdecl alias "MkScratchMenu" (byval id as integer, byval CallBack as sub cdecl(byval as any ptr), byval data as any ptr) as integer
declare function MkSingleMenu cdecl alias "MkSingleMenu" (byval x as integer, byval y as integer, byval text as zstring ptr, byval CallBack as sub cdecl(byval as any ptr), byval data as any ptr) as integer
declare function MkMenuItem cdecl alias "MkMenuItem" (byval sub as integer, byval text as zstring ptr, byval shortcut as zstring ptr, byval CallBack as sub cdecl(byval as any ptr), byval data as any ptr) as integer
declare function MkMenuRadio cdecl alias "MkMenuRadio" (byval selvar as integer ptr, byval n as integer, ...) as integer
declare function MkMenuCheck cdecl alias "MkMenuCheck" (byval checkvar as integer ptr, byval text as zstring ptr) as integer
declare function HookMenuClose cdecl alias "HookMenuClose" (byval CloseHook as sub cdecl(byval as any ptr), byval data as any ptr) as integer
declare function MkGroove cdecl alias "MkGroove" () as integer
declare function AddButton cdecl alias "AddButton" (byval x as integer, byval y as integer, byval label as zstring ptr, byval CallBack as sub cdecl(byval as any ptr), byval data as any ptr) as integer
declare function AddCheck cdecl alias "AddCheck" (byval x as integer, byval y as integer, byval label as zstring ptr, byval sel as integer ptr) as integer

#define CGUI_R_HORIZONTAL 0
#define CGUI_R_VERTICAL 1

declare function AddFlip cdecl alias "AddFlip" (byval x as integer, byval y as integer, byval label as zstring ptr, byval strs as byte ptr ptr, byval sel as integer ptr) as integer
declare function AddDropDown cdecl alias "AddDropDown" (byval x as integer, byval y as integer, byval width as integer, byval label as zstring ptr, byval sel as integer ptr, byval data as any ptr, byval n as integer, byval CallBack as sub cdecl(byval as any ptr, byval as integer, byval as zstring ptr)) as integer
declare function AddDropDownS cdecl alias "AddDropDownS" (byval x as integer, byval y as integer, byval width as integer, byval label as zstring ptr, byval sel as integer ptr, byval strs as byte ptr ptr, byval n as integer) as integer
declare function MkRadioContainer cdecl alias "MkRadioContainer" (byval x as integer, byval y as integer, byval var as integer ptr, byval direction as integer) as integer
declare function AddRadioButton cdecl alias "AddRadioButton" (byval name as zstring ptr) as integer
declare sub EndRadioContainer cdecl alias "EndRadioContainer" ()
declare function AddIcon cdecl alias "AddIcon" (byval id as integer, byval x as integer, byval y as integer, byval iconname as zstring ptr, byval CallBack as sub cdecl(byval as any ptr), byval data as any ptr) as integer
declare function MkCanvas cdecl alias "MkCanvas" (byval x as integer, byval y as integer, byval width as integer, byval height as integer, byval CallBack as sub cdecl(byval as BITMAP ptr, byval as integer, byval as integer, byval as any ptr), byval data as any ptr) as integer
declare function GetRulerTabList cdecl alias "GetRulerTabList" (byval id as integer, byval n as integer ptr) as integer ptr
declare function FlipRulerTab cdecl alias "FlipRulerTab" (byval id as integer, byval x as integer) as integer
declare function AddTabRuler cdecl alias "AddTabRuler" (byval x as integer, byval y as integer, byval width as integer, byval height as integer, byval dx as integer, byval options as integer, byval CallBack as sub cdecl(byval as any ptr, byval as integer, byval as integer ptr, byval as integer), byval data as any ptr) as integer

#define CGUI_TR_SHOWPOS 1

declare function UpdateProgressValue cdecl alias "UpdateProgressValue" (byval id as integer, byval percent as integer) as integer
declare function AddProgressBar cdecl alias "AddProgressBar" (byval x as integer, byval y as integer, byval w as integer, byval h as integer) as integer

#define CGUI_SL_SCALE 1
#define CGUI_SL_LABEL 2
#define CGUI_SL_STYLE1 4
#define CGUI_SL_STYLE2 8
#define CGUI_SL_STYLE3 &h20

declare function AddSlider cdecl alias "AddSlider" (byval x as integer, byval y as integer, byval length as integer, byval ctrl as integer ptr, byval start as integer, byval end as integer, byval option as integer, byval id as integer) as integer
declare function HookSpinButtons cdecl alias "HookSpinButtons" (byval id as integer, byval var as integer ptr, byval delta1 as integer, byval delta2 as integer, byval minv as integer, byval maxv as integer) as integer
declare function AddTag cdecl alias "AddTag" (byval x as integer, byval y as integer, byval tag as zstring ptr) as integer
declare function AddStatusField cdecl alias "AddStatusField" (byval x as integer, byval y as integer, byval width as integer, byval FormatFunc as sub cdecl(byval as any ptr, byval as zstring ptr), byval data as any ptr) as integer
declare function AddTextBox cdecl alias "AddTextBox" (byval x as integer, byval y as integer, byval text as zstring ptr, byval width as integer, byval nrows as integer, byval option as integer) as integer

#define CGUI_TB_FRAMERAISE &h80000000
#define CGUI_TB_FRAMESINK &h40000000
#define CGUI_TB_PREFORMAT &h20000000
#define CGUI_TB_LINEFEED_ &h10000000
#define CGUI_TB_FIXFONT &h08000000
#define CGUI_TB_WHITE &h04000000
#define CGUI_TB_TEXTFILE &h02000000
#define CGUI_TB_FOCUS_END &h01000000

declare function UpdateTextBoxText cdecl alias "UpdateTextBoxText" (byval id as integer, byval s as zstring ptr) as integer
declare function AddEditBox cdecl alias "AddEditBox" (byval x as integer, byval y as integer, byval width as integer, byval label as zstring ptr, byval format as integer, byval maxchar as integer, byval data as any ptr) as integer

#define CGUI_TERMINATE_EDIT 999

declare sub GetEditData cdecl alias "GetEditData" (byval scan as integer ptr, byval ascii as integer ptr, byval offset as integer ptr)
declare sub SetEditData cdecl alias "SetEditData" (byval scan as integer, byval ascii as integer, byval offset as integer)
declare function TabOnCR cdecl alias "TabOnCR" (byval id as integer) as integer

#define CGUI_FBYTE 1
#define CGUI_FSHORT 2
#define CGUI_FINT 3
#define CGUI_FLONG 4
#define CGUI_FSTRING 5
#define CGUI_FPTRSTR 6
#define CGUI_FPOINTS 7
#define CGUI_FBPOINTS 8
#define CGUI_FFLOAT 9
#define CGUI_FHEX1 10
#define CGUI_FHEX2 11
#define CGUI_FHEX4 12
#define CGUI_FOCT1 13
#define CGUI_FOCT2 14
#define CGUI_FOCT3 15
#define CGUI_FOCT4 16
#define CGUI_FNAME &h20
#define CGUI_FBLANK0 &h40
#define CGUI_FUNDEF &h6000
#define CGUI_B_UNDEF_VAL &hFF
#define CGUI_S_UNDEF_VAL &h8000
#define CGUI_I_UNDEF_VAL &h80000000L
#define CGUI_L_UNDEF_VAL &h80000000L
#define CGUI_P_UNDEF_VAL &h8000
#define CGUI_BP_UNDEF_VAL &h80

declare sub Refresh cdecl alias "Refresh" (byval id as integer)
declare sub DeActivate cdecl alias "DeActivate" (byval id as integer)
declare sub Activate cdecl alias "Activate" (byval id as integer)
declare function CguiLoadImage cdecl alias "CguiLoadImage" (byval filename as zstring ptr, byval imagename as zstring ptr, byval transp as integer, byval id as integer) as integer
declare function InsertPoint cdecl alias "InsertPoint" (byval id as integer) as integer

#define CGUI_IMAGE_BMP 0
#define CGUI_IMAGE_TRANS_BMP 1
#define CGUI_IMAGE_RLE_SPRITE 2
#define CGUI_IMAGE_CMP_SPRITE 3

declare function RegisterImage cdecl alias "RegisterImage" (byval data as any ptr, byval imagename as zstring ptr, byval type as integer, byval id as integer) as integer
declare function GetRegisteredImage cdecl alias "GetRegisteredImage" (byval name as zstring ptr, byval type as integer ptr, byval id as integer) as any ptr

#define CGUI_LEFT_MOUSE 1
#define CGUI_RIGHT_MOUSE 2

declare sub SetObjectSlidable cdecl alias "SetObjectSlidable" (byval id as integer, byval Slider as function cdecl(byval as integer, byval as integer, byval as any ptr, byval as integer, byval as integer) as integer, byval buttons as integer, byval data as any ptr)
declare sub SetObjectDouble cdecl alias "SetObjectDouble" (byval id as integer, byval DoubleCall as sub cdecl(byval as any ptr), byval data as any ptr, byval button as integer)
declare sub SetObjectGrippable cdecl alias "SetObjectGrippable" (byval id as integer, byval Grip as sub cdecl(byval as any ptr, byval as integer, byval as integer), byval flags as integer, byval buttons as integer, byval data as any ptr)
declare sub SetObjectDroppable cdecl alias "SetObjectDroppable" (byval id as integer, byval Drop as function cdecl(byval as any ptr, byval as integer, byval as any ptr, byval as integer, byval as integer) as integer, byval flags as integer, byval data as any ptr)

#define CGUI_DD_GRIPPED 0
#define CGUI_DD_UNGRIPPED 1
#define CGUI_DD_SUCCESS 2
#define CGUI_DD_OVER_GRIP 3
#define CGUI_DD_OVER_DROP 4
#define CGUI_DD_END_OVER_DROP 5
#define CGUI_SL_OVER 6
#define CGUI_SL_OVER_END 7
#define CGUI_SL_STARTED 8
#define CGUI_SL_PROGRESS 9
#define CGUI_SL_STOPPED 10

declare function ToolTipText cdecl alias "ToolTipText" (byval id as integer, byval text as zstring ptr) as integer
declare function SetView cdecl alias "SetView" (byval id as integer, byval flags as integer) as integer

#define CGUI_SV_HIDE_LABEL 1
#define CGUI_SV_HIDE_ICON 2
#define CGUI_SV_NO_TOOLTIP 4
#define CGUI_SV_ONLY_BRIEF 8
#define CGUI_SV_ONLY_LONG 16
#define CGUI_SV_PREFERE_BRIEF 32
#define CGUI_SV_PREFERE_LONG 0

declare function RegisterDragFlag cdecl alias "RegisterDragFlag" (byval flag as integer) as integer
declare function UnRegisterDragFlag cdecl alias "UnRegisterDragFlag" (byval flag as integer) as integer
declare function SetMouseButtons cdecl alias "SetMouseButtons" (byval id as integer, byval buttons as integer) as integer
declare sub Remove_ cdecl alias "Remove" (byval id as integer)
declare sub Destroy cdecl alias "Destroy" (byval id as integer)
declare function GetPressedButton cdecl alias "GetPressedButton" (byval id as integer) as integer
declare sub PointerOn cdecl alias "PointerOn" (byval id as integer)
declare sub ModifyHeader cdecl alias "ModifyHeader" (byval id as integer, byval newtag as zstring ptr)
declare function AddHandler cdecl alias "AddHandler" (byval id as integer, byval Handler as sub cdecl(byval as any ptr), byval data as any ptr) as integer
declare sub Click cdecl alias "Click" (byval id as integer)
declare function GetObjectPosition cdecl alias "GetObjectPosition" (byval id as integer, byval x as integer ptr, byval y as integer ptr, byval wx as integer ptr, byval wy as integer ptr) as integer
declare sub SetBlitLimit cdecl alias "SetBlitLimit" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)

EXTERNVAR cgui_use_vsync alias "cgui_use_vsync" as integer

#define CGUI_CT_BORDER 1
#define CGUI_CT_OBJECT_TABLE 2

declare function StartContainer cdecl alias "StartContainer" (byval x as integer, byval y as integer, byval width as integer, byval height as integer, byval label as zstring ptr, byval options as integer) as integer
declare sub EndContainer cdecl alias "EndContainer" ()
declare sub SelectContainer cdecl alias "SelectContainer" (byval id as integer)
declare sub SetMeasure cdecl alias "SetMeasure" (byval leftx as integer, byval xdist as integer, byval rightx as integer, byval topy as integer, byval ydist as integer, byval boty as integer)
declare sub SetDistance cdecl alias "SetDistance" (byval xdist as integer, byval ydist as integer)
declare sub ReBuildContainer cdecl alias "ReBuildContainer" (byval id as integer)
declare sub EmptyContainer cdecl alias "EmptyContainer" (byval id as integer)

#define CGUI_OFF 0
#define CGUI_ON 1
#define CGUI_ROW_STRIKE &h80000000
#define CGUI_ROW_UNDERLINE &h40000000
#define CGUI_ROW_CHECK &h20000000
#define CGUI_ROW_UNCHECK &h10000000
#define CGUI_COL_RIGHT_ALIGN &h08000000

declare function AddList cdecl alias "AddList" (byval x as integer, byval y as integer, byval listdata as any ptr, byval n as integer ptr, byval width as integer, byval events as integer, byval TextFormatter as function cdecl(byval as any ptr, byval as zstring ptr) as integer, byval Action as sub cdecl(byval as integer, byval as any ptr), byval norows as integer) as integer
declare function SetLinkedList cdecl alias "SetLinkedList" (byval id as integer, byval NextCreater as sub cdecl(byval as any ptr, byval as any ptr)) as integer
declare function SetIndexedList cdecl alias "SetIndexedList" (byval id as integer, byval IndexCreater as sub cdecl(byval as any ptr, byval as integer)) as integer
declare function RefreshListRow cdecl alias "RefreshListRow" (byval id as integer, byval i as integer) as integer
declare function GetMarkedRows cdecl alias "GetMarkedRows" (byval listid as integer, byval n as integer ptr) as any ptr ptr
declare function BrowseToF cdecl alias "BrowseToF" (byval id as integer, byval i as integer) as integer
declare function BrowseToL cdecl alias "BrowseToL" (byval id as integer, byval i as integer) as integer
declare function BrowseTo cdecl alias "BrowseTo" (byval id as integer, byval i as integer, byval uncond as integer) as integer
declare function SetListColumns cdecl alias "SetListColumns" (byval id as integer, byval RowTextCreater as function cdecl(byval as any ptr, byval as zstring ptr, byval as integer) as integer, byval widths as integer ptr, byval n as integer, byval options as integer, byval labels as byte ptr ptr, byval CallBack as sub cdecl(byval as any ptr, byval as integer, byval as integer), byval data as any ptr) as integer
declare function SetListGrippable cdecl alias "SetListGrippable" (byval listid as integer, byval Grip as function cdecl(byval as any ptr, byval as integer, byval as any ptr, byval as integer) as integer, byval flags as integer, byval buttons as integer) as integer
declare function SetListDroppable cdecl alias "SetListDroppable" (byval listid as integer, byval Drop as function cdecl(byval as any ptr, byval as integer, byval as any ptr, byval as any ptr, byval as integer, byval as integer) as integer, byval flags as integer) as integer
declare function SetListDoubleClick cdecl alias "SetListDoubleClick" (byval listid as integer, byval AppDouble as sub cdecl(byval as integer, byval as any ptr, byval as integer), byval button as integer) as integer
declare function HookList cdecl alias "HookList" (byval listid as integer, byval listdata as any ptr, byval n as integer ptr, byval width as integer, byval events as integer, byval TextFormatter as function cdecl(byval as any ptr, byval as zstring ptr) as integer, byval Action as sub cdecl(byval as integer, byval as any ptr)) as integer
declare function SetDeleteHandler cdecl alias "SetDeleteHandler" (byval listid as integer, byval CallBack as sub cdecl(byval as integer, byval as any ptr)) as integer
declare function SetInsertHandler cdecl alias "SetInsertHandler" (byval listid as integer, byval CallBack as sub cdecl(byval as any ptr, byval as integer)) as integer
declare function GetListIndex cdecl alias "GetListIndex" (byval id as integer) as integer
declare function HookExit cdecl alias "HookExit" (byval id as integer, byval ExitFun as sub cdecl(byval as any ptr), byval data as any ptr) as integer
declare function NotifyFocusMove cdecl alias "NotifyFocusMove" (byval listid as integer, byval CallBack as sub cdecl(byval as integer, byval as any ptr)) as integer

#define CGUI_TR_HIDE_ROOT &h00000001

declare function ListTreeView cdecl alias "ListTreeView" (byval listid as integer, byval width as integer, byval IsLeaf as function cdecl(byval as any ptr) as integer, byval options as integer) as integer

EXTERNVAR cgui_list_no_multiple_row_selection alias "cgui_list_no_multiple_row_selection" as integer
EXTERNVAR CGUI_list_font alias "CGUI_list_font" as FONT ptr
EXTERNVAR CGUI_list_row_font alias "CGUI_list_row_font" as FONT ptr
EXTERNVAR CGUI_list_row_f_color alias "CGUI_list_row_f_color" as integer
EXTERNVAR CGUI_list_row_b_color alias "CGUI_list_row_b_color" as integer
EXTERNVAR CGUI_list_row_delimiter_color alias "CGUI_list_row_delimiter_color" as integer
EXTERNVAR CGUI_list_vspace alias "CGUI_list_vspace" as integer
EXTERNVAR CGUI_list_column_delimiter_color alias "CGUI_list_column_delimiter_color" as integer
EXTERNVAR CGUI_list_fixfont alias "CGUI_list_fixfont" as integer
EXTERNVAR cgui_list_fix_digits alias "cgui_list_fix_digits" as integer

#define CGUI_LIST_COLUMNS_ADJUSTABLE 1
#define CGUI_LIST_COLUMNS_DELIMITER 2

declare function MkVerticalBrowser cdecl alias "MkVerticalBrowser" (byval x as integer, byval y as integer, byval CallBack as sub cdecl(byval as any ptr), byval data as any ptr, byval viewpos as integer ptr) as integer
declare function MkHorizontalBrowser cdecl alias "MkHorizontalBrowser" (byval x as integer, byval y as integer, byval CallBack as sub cdecl(byval as any ptr), byval data as any ptr, byval viewpos as integer ptr) as integer
declare function NotifyBrowser cdecl alias "NotifyBrowser" (byval id as integer, byval step as integer, byval scrolled_area_length as integer) as integer
declare function SetBrowserSize cdecl alias "SetBrowserSize" (byval id as integer, byval view_port_length as integer, byval browser_length as integer) as integer
declare function RegisterFileType cdecl alias "RegisterFileType" (byval ext as zstring ptr, byval Handler as sub cdecl(byval as any ptr, byval as zstring ptr), byval data as any ptr, byval aname as zstring ptr, byval icon as zstring ptr, byval label as zstring ptr, byval Viewer as sub cdecl(byval as any ptr, byval as any ptr)) as integer
declare function FileSelect cdecl alias "FileSelect" (byval masks as zstring ptr, byval rpath as zstring ptr, byval flags as integer, byval winheader as zstring ptr, byval buttonlabel as zstring ptr) as zstring ptr
declare sub FileManager cdecl alias "FileManager" (byval winheader as zstring ptr, byval flags as integer)
declare function UnPackSelection cdecl alias "UnPackSelection" (byval flist as byte ptr ptr) as zstring ptr

#define CGUI_FS_BROWSE_DAT 1
#define CGUI_FS_DISABLE_EDIT_DAT 2
#define CGUI_FS_WARN_EXISTING_FILE 4
#define CGUI_FS_FORBID_EXISTING_FILE 8
#define CGUI_FS_REQUIRE_EXISTING_FILE &h10
#define CGUI_FS_SELECT_DIR &h20
#define CGUI_FS_DISABLE_CREATE_DIR &h40
#define CGUI_FS_DISABLE_DELETING &h80
#define CGUI_FS_DISABLE_COPYING &h100
#define CGUI_FS_SHOW_MENU &h200
#define CGUI_FS_NO_SETTINGS_IN_CONFIG &h400
#define CGUI_FS_MULTIPLE_SELECTION &h800
#define CGUI_FS_NO_DRAG_DROP &h4000
#define CGUI_FS_SAVE_AS &h8000
#define CGUI_FM_BROWSE_DAT 1
#define CGUI_FM_DISABLE_EDIT_DAT 2
#define CGUI_FM_DISABLE_CREATE_DIR &h40
#define CGUI_FM_DISABLE_DELETING &h80
#define CGUI_FM_DISABLE_COPYING &h100
#define CGUI_FM_DO_NOT_SHOW_MENU &h2000
#define CGUI_FM_NO_SETTINGS_IN_CONFIG &h400
#define CGUI_FM_NO_FLOATING &h1000

declare sub CguiUseIcons cdecl alias "CguiUseIcons" (byval filename as zstring ptr)
declare function CreateTabWindow cdecl alias "CreateTabWindow" (byval x as integer, byval y as integer, byval width as integer, byval height as integer, byval status as integer ptr) as integer
declare function AddTab cdecl alias "AddTab" (byval id as integer, byval callback as sub cdecl(byval as any ptr, byval as integer), byval data as any ptr, byval label as zstring ptr) as integer
declare sub HookLeaveTab cdecl alias "HookLeaveTab" (byval callback as sub cdecl(byval as any ptr), byval data as any ptr)
declare function SetFocusOn cdecl alias "SetFocusOn" (byval id as integer) as integer
declare function JoinTabChain cdecl alias "JoinTabChain" (byval id as integer) as integer
declare function GetCurrentFocus cdecl alias "GetCurrentFocus" (byval id as integer) as integer
declare sub SetCguiFont cdecl alias "SetCguiFont" (byval f as FONT ptr)
declare function GetCguiFont cdecl alias "GetCguiFont" () as FONT ptr
declare function Invite cdecl alias "Invite" (byval mask as integer, byval data as any ptr, byval text as zstring ptr) as integer
declare function Attend cdecl alias "Attend" (byval mask as integer) as any ptr
declare sub ProcessEvents cdecl alias "ProcessEvents" ()
declare sub StopProcessEvents cdecl alias "StopProcessEvents" ()
declare function GenEvent cdecl alias "GenEvent" (byval Handler as sub cdecl(byval as any ptr), byval msg as any ptr, byval delay as uinteger, byval objid as integer) as uinteger
declare function KillEvent cdecl alias "KillEvent" (byval id as uinteger) as integer
declare sub FlushGenEvents cdecl alias "FlushGenEvents" ()

EXTERNVAR event_message_buffer_size alias "event_message_buffer_size" as integer

declare sub InstallKBHandler cdecl alias "InstallKBHandler" (byval Handler as function cdecl(byval as any ptr, byval as integer, byval as integer) as integer, byval data as any ptr)
declare function UnInstallKBHandler cdecl alias "UnInstallKBHandler" (byval Handler as function cdecl(byval as any ptr, byval as integer, byval as integer) as integer) as any ptr
declare function SetHotKey cdecl alias "SetHotKey" (byval id as integer, byval CallBack as sub cdecl(byval as any ptr), byval data as any ptr, byval scan as integer, byval ascii as integer) as integer
declare function IsHotKey cdecl alias "IsHotKey" (byval scan as integer, byval ascii as integer) as integer
declare sub SimulateHotKeys cdecl alias "SimulateHotKeys" (byval control as integer, byval key as integer)
declare sub UseHotKeys cdecl alias "UseHotKeys" (byval s as zstring ptr)
declare sub AutoHotKeys cdecl alias "AutoHotKeys" (byval mode as integer)

EXTERNVAR cgui_white alias "cgui_white" as integer
EXTERNVAR cgui_lgray alias "cgui_lgray" as integer
EXTERNVAR cgui_dgray alias "cgui_dgray" as integer
EXTERNVAR cgui_gray alias "cgui_gray" as integer
EXTERNVAR cgui_black alias "cgui_black" as integer
EXTERNVAR cgui_lblue alias "cgui_lblue" as integer
EXTERNVAR cgui_blue alias "cgui_blue" as integer
EXTERNVAR cgui_dblue alias "cgui_dblue" as integer
EXTERNVAR cgui_red alias "cgui_red" as integer

declare sub SetCguiColors cdecl alias "SetCguiColors" (byval exact as integer)
declare sub NameCase cdecl alias "NameCase" (byval text as zstring ptr)
declare sub Sound cdecl alias "Sound" (byval freq as integer, byval duration as integer)
declare function AddClock cdecl alias "AddClock" (byval x as integer, byval y as integer, byval options as integer) as integer

#define CGUI_CLOCK_SHOW_SECONDS 1
#define CGUI_CLOCK_SHOW_MINUTES 2
#define CGUI_CLOCK_NO_DIALOGUE 4

declare function ScanToAscii cdecl alias "ScanToAscii" (byval scancode as integer) as integer
declare function ToUpper_ cdecl alias "ToUpper" (byval chr as integer) as integer
declare function SaveDatafileObject cdecl alias "SaveDatafileObject" (byval path as zstring ptr, byval data as any ptr, byval type as integer) as integer
declare function msprintf cdecl alias "msprintf" (byval format as zstring ptr, ...) as zstring ptr
declare sub InstallCursor cdecl alias "InstallCursor" (byval cursor_no as integer, byval sprite as BITMAP ptr, byval x as integer, byval y as integer)
declare sub ShowPointer cdecl alias "ShowPointer" ()
declare sub HidePointer cdecl alias "HidePointer" ()
declare sub PointerLocation cdecl alias "PointerLocation" (byval id as integer, byval x as integer ptr, byval y as integer ptr)
declare function ObjectApearance cdecl alias "ObjectApearance" (byval id as integer) as BITMAP ptr
declare sub OverlayPointer cdecl alias "OverlayPointer" (byval sprite as BITMAP ptr, byval x as integer, byval y as integer)
declare sub RemoveOverlayPointer cdecl alias "RemoveOverlayPointer" ()
declare sub MkTextPointer cdecl alias "MkTextPointer" (byval f as FONT ptr, byval text as zstring ptr)
declare sub SelectCursor cdecl alias "SelectCursor" (byval cursor_no as integer)

#define CGUI_CURS_ILLEGAL 0
#define CGUI_CURS_DRAGGABLE 1
#define CGUI_CURS_DRAG_V 2
#define CGUI_CURS_DRAG_H 3
#define CGUI_CURS_CROSS 4
#define CGUI_CURS_BUSY 5
#define CGUI_CURS_DEFAULT 6

declare sub SetMousePos cdecl alias "SetMousePos" (byval x as integer, byval y as integer)

EXTERNVAR cgui_mouse_draw_in_interrupt alias "cgui_mouse_draw_in_interrupt" as integer

declare function LoadTexts cdecl alias "LoadTexts" (byval fn as zstring ptr, byval section as zstring ptr, byval nr as integer ptr) as byte ptr ptr
declare sub DestroyTexts cdecl alias "DestroyTexts" ()
declare sub RegisterConversionHandler cdecl alias "RegisterConversionHandler" (byval Handler as sub cdecl(byval as any ptr, byval as zstring ptr), byval data as any ptr, byval name as zstring ptr)
declare sub PrintFloatingConversion cdecl alias "PrintFloatingConversion" (byval dest as zstring ptr, byval src as zstring ptr)
declare function LoadCompiledTexts cdecl alias "LoadCompiledTexts" (byval dat as DATAFILE ptr, byval section as zstring ptr, byval nr as integer ptr) as byte ptr ptr
declare sub RegisterRefresh cdecl alias "RegisterRefresh" (byval id as integer, byval AppUpd as sub cdecl(byval as integer, byval as any ptr, byval as any ptr, byval as integer), byval data as any ptr)
declare sub ConditionalRefresh cdecl alias "ConditionalRefresh" (byval calldata as any ptr, byval reason as integer)
declare function GetSizeOffset cdecl alias "GetSizeOffset" (byval id as integer, byval x as integer ptr, byval y as integer ptr) as integer
declare function SetSizeOffset cdecl alias "SetSizeOffset" (byval id as integer, byval x as integer, byval y as integer) as integer
declare function MakeStretchable cdecl alias "MakeStretchable" (byval id as integer, byval Notify as sub cdecl(byval as any ptr), byval data as any ptr, byval options as integer) as integer

EXTERNVAR continous_update_resize alias "continous_update_resize" as integer

#define CGUI_NO_VERTICAL 1
#define CGUI_NO_HORIZONTAL 2
#define CGUI_FRAMERAISE &h80000000
#define CGUI_FRAMESINK &h40000000
#define CGUI_W_NOMODAL (1 shl 3)
#define CGUI_W_CHILD 0

#endif
