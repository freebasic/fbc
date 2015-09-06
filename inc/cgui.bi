'' FreeBASIC binding for cgui-2.0.4
''
'' based on the C header files:
''   A C Graphical User Interface [add on to Allegro] by Christer Sandberg
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "cgui"

#include once "crt/long.bi"
#include once "crt/stdio.bi"
#include once "crt/errno.bi"
#include once "crt/stdlib.bi"
#include once "allegro.bi"

'' The following symbols have been renamed:
''     constant DIR_TOPLEFT => CGUI_DIR_TOPLEFT
''     constant DIR_RIGHT => CGUI_DIR_RIGHT
''     constant DIR_LEFT => CGUI_DIR_LEFT
''     constant DIR_DOWNLEFT => CGUI_DIR_DOWNLEFT
''     constant DIR_DOWN => CGUI_DIR_DOWN
''     constant AUTOINDICATOR => CGUI_AUTOINDICATOR
''     constant ALIGNCENTRE => CGUI_ALIGNCENTRE
''     constant ALIGNBOTTOM => CGUI_ALIGNBOTTOM
''     constant ALIGNRIGHT => CGUI_ALIGNRIGHT
''     constant HORIZONTAL => CGUI_HORIZONTAL
''     constant VERTICAL => CGUI_VERTICAL
''     constant FILLSPACE => CGUI_FILLSPACE
''     constant EQUALWIDTH => CGUI_EQUALWIDTH
''     constant EQUALHEIGHT => CGUI_EQUALHEIGHT
''     constant W_SIBLING => CGUI_W_SIBLING
''     constant W_NOMOVE => CGUI_W_NOMOVE
''     constant W_FLOATING => CGUI_W_FLOATING
''     constant W_TOP => CGUI_W_TOP
''     constant W_BOTTOM => CGUI_W_BOTTOM
''     constant W_LEFT => CGUI_W_LEFT
''     constant W_RIGHT => CGUI_W_RIGHT
''     constant W_CENTRE_H => CGUI_W_CENTRE_H
''     constant W_CENTRE_V => CGUI_W_CENTRE_V
''     constant W_CENTRE => CGUI_W_CENTRE
''     variable ID_DESKTOP => CGUI_ID_DESKTOP
''     constant R_HORIZONTAL => CGUI_R_HORIZONTAL
''     constant R_VERTICAL => CGUI_R_VERTICAL
''     constant TR_SHOWPOS => CGUI_TR_SHOWPOS
''     constant SL_SCALE => CGUI_SL_SCALE
''     constant SL_LABEL => CGUI_SL_LABEL
''     constant SL_STYLE1 => CGUI_SL_STYLE1
''     constant SL_STYLE2 => CGUI_SL_STYLE2
''     constant SL_STYLE3 => CGUI_SL_STYLE3
''     constant TB_FRAMERAISE => CGUI_TB_FRAMERAISE
''     constant TB_FRAMESINK => CGUI_TB_FRAMESINK
''     constant TB_PREFORMAT => CGUI_TB_PREFORMAT
''     constant TB_LINEFEED_ => CGUI_TB_LINEFEED_
''     constant TB_FIXFONT => CGUI_TB_FIXFONT
''     constant TB_WHITE => CGUI_TB_WHITE
''     constant TB_TEXTFILE => CGUI_TB_TEXTFILE
''     constant TB_FOCUS_END => CGUI_TB_FOCUS_END
''     constant TERMINATE_EDIT => CGUI_TERMINATE_EDIT
''     constant FBYTE => CGUI_FBYTE
''     constant FSHORT => CGUI_FSHORT
''     constant FINT => CGUI_FINT
''     constant FLONG => CGUI_FLONG
''     constant FSTRING => CGUI_FSTRING
''     constant FPTRSTR => CGUI_FPTRSTR
''     constant FPOINTS => CGUI_FPOINTS
''     constant FBPOINTS => CGUI_FBPOINTS
''     constant FFLOAT => CGUI_FFLOAT
''     constant FHEX1 => CGUI_FHEX1
''     constant FHEX2 => CGUI_FHEX2
''     constant FHEX4 => CGUI_FHEX4
''     constant FOCT1 => CGUI_FOCT1
''     constant FOCT2 => CGUI_FOCT2
''     constant FOCT3 => CGUI_FOCT3
''     constant FOCT4 => CGUI_FOCT4
''     constant FNAME => CGUI_FNAME
''     constant FBLANK0 => CGUI_FBLANK0
''     constant FUNDEF => CGUI_FUNDEF
''     constant B_UNDEF_VAL => CGUI_B_UNDEF_VAL
''     constant S_UNDEF_VAL => CGUI_S_UNDEF_VAL
''     constant I_UNDEF_VAL => CGUI_I_UNDEF_VAL
''     constant L_UNDEF_VAL => CGUI_L_UNDEF_VAL
''     constant P_UNDEF_VAL => CGUI_P_UNDEF_VAL
''     constant BP_UNDEF_VAL => CGUI_BP_UNDEF_VAL
''     constant IMAGE_BMP => CGUI_IMAGE_BMP
''     constant IMAGE_TRANS_BMP => CGUI_IMAGE_TRANS_BMP
''     constant IMAGE_RLE_SPRITE => CGUI_IMAGE_RLE_SPRITE
''     constant IMAGE_CMP_SPRITE => CGUI_IMAGE_CMP_SPRITE
''     constant LEFT_MOUSE => CGUI_LEFT_MOUSE
''     constant RIGHT_MOUSE => CGUI_RIGHT_MOUSE
''     constant DD_GRIPPED => CGUI_DD_GRIPPED
''     constant DD_UNGRIPPED => CGUI_DD_UNGRIPPED
''     constant DD_SUCCESS => CGUI_DD_SUCCESS
''     constant DD_OVER_GRIP => CGUI_DD_OVER_GRIP
''     constant DD_OVER_DROP => CGUI_DD_OVER_DROP
''     constant DD_END_OVER_DROP => CGUI_DD_END_OVER_DROP
''     constant SL_OVER => CGUI_SL_OVER
''     constant SL_OVER_END => CGUI_SL_OVER_END
''     constant SL_STARTED => CGUI_SL_STARTED
''     constant SL_PROGRESS => CGUI_SL_PROGRESS
''     constant SL_STOPPED => CGUI_SL_STOPPED
''     constant SV_HIDE_LABEL => CGUI_SV_HIDE_LABEL
''     constant SV_HIDE_ICON => CGUI_SV_HIDE_ICON
''     constant SV_NO_TOOLTIP => CGUI_SV_NO_TOOLTIP
''     constant SV_ONLY_BRIEF => CGUI_SV_ONLY_BRIEF
''     constant SV_ONLY_LONG => CGUI_SV_ONLY_LONG
''     constant SV_PREFERE_BRIEF => CGUI_SV_PREFERE_BRIEF
''     constant SV_PREFERE_LONG => CGUI_SV_PREFERE_LONG
''     procedure Remove => Remove_
''     constant CT_BORDER => CGUI_CT_BORDER
''     constant CT_OBJECT_TABLE => CGUI_CT_OBJECT_TABLE
''     constant OFF => CGUI_OFF
''     constant ON => CGUI_ON
''     constant ROW_STRIKE => CGUI_ROW_STRIKE
''     constant ROW_UNDERLINE => CGUI_ROW_UNDERLINE
''     constant ROW_CHECK => CGUI_ROW_CHECK
''     constant ROW_UNCHECK => CGUI_ROW_UNCHECK
''     constant COL_RIGHT_ALIGN => CGUI_COL_RIGHT_ALIGN
''     constant ROW_COLUMN_UNDERLINE => CGUI_ROW_COLUMN_UNDERLINE
''     constant TR_HIDE_ROOT => CGUI_TR_HIDE_ROOT
''     constant LIST_COLUMNS_ADJUSTABLE => CGUI_LIST_COLUMNS_ADJUSTABLE
''     constant LIST_COLUMNS_ADJUSTABLE_KEEP_BOX_WIDTH => CGUI_LIST_COLUMNS_ADJUSTABLE_KEEP_BOX_WIDTH
''     constant LIST_COLUMNS_DELIMITER => CGUI_LIST_COLUMNS_DELIMITER
''     constant FS_BROWSE_DAT => CGUI_FS_BROWSE_DAT
''     constant FS_DISABLE_EDIT_DAT => CGUI_FS_DISABLE_EDIT_DAT
''     constant FS_WARN_EXISTING_FILE => CGUI_FS_WARN_EXISTING_FILE
''     constant FS_FORBID_EXISTING_FILE => CGUI_FS_FORBID_EXISTING_FILE
''     constant FS_REQUIRE_EXISTING_FILE => CGUI_FS_REQUIRE_EXISTING_FILE
''     constant FS_SELECT_DIR => CGUI_FS_SELECT_DIR
''     constant FS_DISABLE_CREATE_DIR => CGUI_FS_DISABLE_CREATE_DIR
''     constant FS_DISABLE_DELETING => CGUI_FS_DISABLE_DELETING
''     constant FS_DISABLE_COPYING => CGUI_FS_DISABLE_COPYING
''     constant FS_SHOW_MENU => CGUI_FS_SHOW_MENU
''     constant FS_NO_SETTINGS_IN_CONFIG => CGUI_FS_NO_SETTINGS_IN_CONFIG
''     constant FS_MULTIPLE_SELECTION => CGUI_FS_MULTIPLE_SELECTION
''     constant FS_NO_DRAG_DROP => CGUI_FS_NO_DRAG_DROP
''     constant FS_DIRECT_SELECT_BY_DOUBLE_CLICK => CGUI_FS_DIRECT_SELECT_BY_DOUBLE_CLICK
''     constant FS_SAVE_AS => CGUI_FS_SAVE_AS
''     constant FS_SHOW_DIR_TREE => CGUI_FS_SHOW_DIR_TREE
''     constant FS_SHOW_DIRS_IN_FILE_VIEW => CGUI_FS_SHOW_DIRS_IN_FILE_VIEW
''     constant FS_HIDE_LOCATION => CGUI_FS_HIDE_LOCATION
''     constant FS_HIDE_UP_BUTTON => CGUI_FS_HIDE_UP_BUTTON
''     constant FS_HIDE_UP_DIRECTORY => CGUI_FS_HIDE_UP_DIRECTORY
''     constant FS_FILE_FILTER_IS_READ_ONLY => CGUI_FS_FILE_FILTER_IS_READ_ONLY
''     constant FM_HIDE_FILE_VEW => CGUI_FM_HIDE_FILE_VEW
''     constant FM_DO_NOT_SHOW_MENU => CGUI_FM_DO_NOT_SHOW_MENU
''     constant FM_NO_FLOATING => CGUI_FM_NO_FLOATING
''     constant FM_BROWSE_DAT => CGUI_FM_BROWSE_DAT
''     constant FM_DISABLE_EDIT_DAT => CGUI_FM_DISABLE_EDIT_DAT
''     constant FM_DISABLE_CREATE_DIR => CGUI_FM_DISABLE_CREATE_DIR
''     constant FM_DISABLE_DELETING => CGUI_FM_DISABLE_DELETING
''     constant FM_DISABLE_COPYING => CGUI_FM_DISABLE_COPYING
''     constant FM_NO_SETTINGS_IN_CONFIG => CGUI_FM_NO_SETTINGS_IN_CONFIG
''     constant FM_SHOW_DIRS_IN_FILE_VIEW => CGUI_FM_SHOW_DIRS_IN_FILE_VIEW
''     constant FM_HIDE_LOCATION => CGUI_FM_HIDE_LOCATION
''     constant FM_HIDE_UP_BUTTON => CGUI_FM_HIDE_UP_BUTTON
''     constant FM_HIDE_UP_DIRECTORY => CGUI_FM_HIDE_UP_DIRECTORY
''     constant CLOCK_SHOW_SECONDS => CGUI_CLOCK_SHOW_SECONDS
''     constant CLOCK_SHOW_MINUTES => CGUI_CLOCK_SHOW_MINUTES
''     constant CLOCK_NO_DIALOGUE => CGUI_CLOCK_NO_DIALOGUE
''     constant CURS_ILLEGAL => CGUI_CURS_ILLEGAL
''     constant CURS_DRAGGABLE => CGUI_CURS_DRAGGABLE
''     constant CURS_DRAG_V => CGUI_CURS_DRAG_V
''     constant CURS_DRAG_H => CGUI_CURS_DRAG_H
''     constant CURS_CROSS => CGUI_CURS_CROSS
''     constant CURS_BUSY => CGUI_CURS_BUSY
''     constant CURS_DEFAULT => CGUI_CURS_DEFAULT
''     constant NO_VERTICAL => CGUI_NO_VERTICAL
''     constant NO_HORIZONTAL => CGUI_NO_HORIZONTAL
''     constant FRAMERAISE => CGUI_FRAMERAISE
''     constant FRAMESINK => CGUI_FRAMESINK
''     constant W_NOMODAL => CGUI_W_NOMODAL
''     constant W_CHILD => CGUI_W_CHILD

extern "C"

#if defined(CGUI_STATICLINK) or ((not defined(CGUI_STATICLINK)) and (defined(__FB_DOS__) or defined(__FB_LINUX__)))
	#define EXTERNVAR extern
#else
	#define EXTERNVAR extern import
#endif

#define CGUI_H
#define CGUI_HAS_INLINE
#define CGUI_INLINE_PROVIDE_CODE
const CGUI_VERSION_MAJOR = 2
const CGUI_VERSION_MINOR = 0
const CGUI_VERSION_PATCH = 4
#define CGUI_VERSION_STRING "2.0.4"
const CGUI_DATE = 20091206
#define CGUI_DATE_STRING "Dec 06, 2009"
const CGUI_INIT_CODE = 0
const CGUI_INIT_LOAD = 0
const CGUI_INIT_WINDOWED = 1
const CGUI_INIT_FULLSCREEN = 2
const CGUI_INIT_KEEP_CURRENT = 0
declare function InitCguiEx(byval w as long, byval h as long, byval colour_depth as long, byval errno_ptr as long ptr, byval atexit_ptr as function(byval f as sub()) as long) as long
#define InitCguiLoadMode() InitCguiEx(0, CGUI_INIT_LOAD, CGUI_INIT_CODE, @errno, cptr(function cdecl(byval as sub cdecl()) as long, @atexit))
#define InitCguiFullscreenMode() InitCguiEx(0, CGUI_INIT_FULLSCREEN, CGUI_INIT_CODE, @errno, cptr(function cdecl(byval as sub cdecl()) as long, @atexit))
#define InitCguiWindowedMode() InitCguiEx(0, CGUI_INIT_WINDOWED, CGUI_INIT_CODE, @errno, cptr(function cdecl(byval as sub cdecl()) as long, @atexit))
#define InitCguiKeepCurrent() InitCguiEx(0, CGUI_INIT_KEEP_CURRENT, CGUI_INIT_CODE, @errno, cptr(function cdecl(byval as sub cdecl()) as long, @atexit))
#define InitCgui(w, h, bpp) InitCguiEx(w, h, bpp, @errno, cptr(function cdecl(byval as sub cdecl()) as long, @atexit))

declare sub DeInitCgui()
declare sub CguiUseUTF8()
declare function CguiParseLabels(byval state as long) as long

EXTERNVAR cgui_ver as long
EXTERNVAR cgui_rev as long
EXTERNVAR cgui_minor_rev as long
EXTERNVAR cgui_release_date as long

const CGUI_DIR_TOPLEFT = 1
const CGUI_DIR_RIGHT = 2
const CGUI_DIR_LEFT = 4
const CGUI_DIR_DOWNLEFT = 8
const CGUI_DIR_DOWN = &h10
const CGUI_AUTOINDICATOR = &h007fffff
#define CGUI_TOPLEFT CGUI_DIR_TOPLEFT,CGUI_AUTOINDICATOR
#define CGUI_RIGHT CGUI_DIR_RIGHT,CGUI_AUTOINDICATOR
#define CGUI_DOWNLEFT CGUI_DIR_DOWNLEFT,CGUI_AUTOINDICATOR
#define CGUI_LEFT CGUI_DIR_LEFT,CGUI_AUTOINDICATOR
#define CGUI_DOWN CGUI_DIR_DOWN,CGUI_AUTOINDICATOR
const CGUI_ALIGNCENTRE = &h00800000
const CGUI_ALIGNBOTTOM = &h01000000
const CGUI_ALIGNRIGHT = &h02000000
const CGUI_HORIZONTAL = &h04000000
const CGUI_VERTICAL = &h08000000
const CGUI_FILLSPACE = &h10000000
const CGUI_EQUALWIDTH = &h20000000
const CGUI_EQUALHEIGHT = &h40000000
#define CGUI_ADAPTIVE 0,CGUI_AUTOINDICATOR
#define CGUI_FILLSCREEN 1,CGUI_AUTOINDICATOR
declare function MkDialogue(byval width as long, byval height as long, byval label as const zstring ptr, byval attr as long) as long
const CGUI_W_SIBLING = 1 shl 0
const CGUI_W_NOMOVE = 1 shl 2
const CGUI_W_FLOATING = 1 shl 3
const CGUI_W_TOP = 1 shl 4
const CGUI_W_BOTTOM = 1 shl 5
const CGUI_W_LEFT = 1 shl 6
const CGUI_W_RIGHT = 1 shl 7
const CGUI_W_CENTRE_H = CGUI_W_LEFT or CGUI_W_RIGHT
const CGUI_W_CENTRE_V = CGUI_W_TOP or CGUI_W_BOTTOM
const CGUI_W_CENTRE = CGUI_W_CENTRE_H or CGUI_W_CENTRE_V

declare sub DisplayWin()
declare sub CloseWin(byval dummy as any ptr)
declare sub SetWindowPosition(byval x as long, byval y as long)
declare sub GetWinInfo(byval id as long, byval x as long ptr, byval y as long ptr, byval width as long ptr, byval height as long ptr)
declare sub DesktopImage(byval bmp as BITMAP ptr)
declare function CurrentWindow() as long
declare sub SetOperatingWindow(byval winid as long)
declare function Req(byval winheader as const zstring ptr, byval format_text as const zstring ptr) as long
declare function Request(byval title as const zstring ptr, byval options as long, byval width as long, byval format as const zstring ptr, ...) as long
declare sub RedrawScreen()
declare sub ScrMode(byval CallBack as sub())
declare function MkProgressWindow(byval wlabel as const zstring ptr, byval blabel as const zstring ptr, byval w as long) as long
EXTERNVAR cgui_desktop_id as long
EXTERNVAR CGUI_ID_DESKTOP alias "cgui_desktop_id" as long
declare function MkMenu(byval text as const zstring ptr, byval CallBack as sub(byval as any ptr), byval data as any ptr) as long
declare function MakeMenuBar() as long
declare function MkMenuBarItem(byval text as const zstring ptr, byval CallBack as sub(byval as any ptr), byval data as any ptr) as long
declare sub EndMenuBar()
declare function MkScratchMenu(byval id as long, byval CallBack as sub(byval as any ptr), byval data as any ptr) as long
declare function MkSingleMenu(byval x as long, byval y as long, byval text as const zstring ptr, byval CallBack as sub(byval as any ptr), byval data as any ptr) as long
declare function MkMenuItem(byval sub as long, byval text as const zstring ptr, byval shortcut as const zstring ptr, byval CallBack as sub(byval as any ptr), byval data as any ptr) as long
declare function MkMenuRadio(byval selvar as long ptr, byval n as long, ...) as long
declare function MkMenuCheck(byval checkvar as long ptr, byval text as const zstring ptr) as long
declare function HookMenuClose(byval CloseHook as sub(byval as any ptr), byval data as any ptr) as long
declare function MkGroove() as long
declare function AddButton(byval x as long, byval y as long, byval label as const zstring ptr, byval CallBack as sub(byval data as any ptr), byval data as any ptr) as long
declare function AddCheck(byval x as long, byval y as long, byval label as const zstring ptr, byval sel as long ptr) as long
const CGUI_R_HORIZONTAL = 0
const CGUI_R_VERTICAL = 1
declare function AddFlip(byval x as long, byval y as long, byval label as const zstring ptr, byval strs as const zstring const ptr ptr, byval sel as long ptr) as long
declare function AddDropDown(byval x as long, byval y as long, byval width as long, byval label as const zstring ptr, byval sel as long ptr, byval data as const any ptr, byval n as long, byval CallBack as sub(byval data as const any ptr, byval i as long, byval s as zstring ptr)) as long
declare function AddDropDownS(byval x as long, byval y as long, byval width as long, byval label as const zstring ptr, byval sel as long ptr, byval strs as const zstring const ptr ptr, byval n as long) as long
EXTERNVAR cgui_drop_down_list_row_spacing as long
declare function MkRadioContainer(byval x as long, byval y as long, byval var as long ptr, byval direction as long) as long
declare function AddRadioButton(byval name as const zstring ptr) as long
declare sub EndRadioContainer()
declare function AddIcon(byval id as long, byval x as long, byval y as long, byval iconname as const zstring ptr, byval CallBack as sub(byval as any ptr), byval data as any ptr) as long
declare function MkCanvas(byval x as long, byval y as long, byval width as long, byval height as long, byval CallBack as sub(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval data as any ptr), byval data as any ptr) as long
declare function GetRulerTabList(byval id as long, byval n as long ptr) as long ptr
declare function FlipRulerTab(byval id as long, byval x as long) as long
declare function AddTabRuler(byval x as long, byval y as long, byval width as long, byval height as long, byval dx as long, byval options as long, byval CallBack as sub(byval data as any ptr, byval x as long, byval tabs as long ptr, byval n as long), byval data as any ptr) as long
const CGUI_TR_SHOWPOS = 1
declare function UpdateProgressValue(byval id as long, byval percent as long) as long
declare function AddProgressBar(byval x as long, byval y as long, byval w as long, byval h as long) as long

const CGUI_SL_SCALE = 1
const CGUI_SL_LABEL = 2
const CGUI_SL_STYLE1 = 4
const CGUI_SL_STYLE2 = 8
const CGUI_SL_STYLE3 = &h20

declare function AddSlider(byval x as long, byval y as long, byval length as long, byval ctrl as long ptr, byval start as long, byval end as long, byval option as long, byval id as long) as long
declare function AddSliderFloat(byval x as long, byval y as long, byval length as long, byval ctrl as single ptr, byval start as single, byval end as single, byval ndecimals as long, byval option as long, byval id as long) as long
declare function HookSpinButtons(byval id as long, byval var as long ptr, byval delta1 as long, byval delta2 as long, byval minv as long, byval maxv as long) as long
declare function AddTag(byval x as long, byval y as long, byval tag as const zstring ptr) as long
declare function AddStatusField(byval x as long, byval y as long, byval width as long, byval FormatFunc as sub(byval data as any ptr, byval string as zstring ptr), byval data as any ptr) as long
declare function AddTextBox(byval x as long, byval y as long, byval text as const zstring ptr, byval width as long, byval nrows as long, byval option as long) as long
declare sub TextboxHighlighting(byval id as long, byval bgcolor as long, byval textcolor as long, byval line_nr as long)
declare sub TextboxScrollDownOneLine(byval id as long)
declare function TextboxGetHighlightedText(byval id as long) as const zstring ptr

const CGUI_TB_FRAMERAISE = &h80000000
const CGUI_TB_FRAMESINK = &h40000000
const CGUI_TB_PREFORMAT = &h20000000
const CGUI_TB_LINEFEED_ = &h10000000
const CGUI_TB_FIXFONT = &h08000000
const CGUI_TB_WHITE = &h04000000
const CGUI_TB_TEXTFILE = &h02000000
const CGUI_TB_FOCUS_END = &h01000000
declare function UpdateTextBoxText(byval id as long, byval s as const zstring ptr) as long
declare function AddEditBox(byval x as long, byval y as long, byval width as long, byval label as const zstring ptr, byval format as long, byval string_buffer_size as long, byval data as any ptr) as long
const CGUI_TERMINATE_EDIT = 999

declare sub CguiEditBoxSetSelectionMode(byval mode as long)
declare sub GetEditData(byval scan as long ptr, byval ascii as long ptr, byval offset as long ptr)
declare sub SetEditData(byval scan as long, byval ascii as long, byval offset as long)
declare function TabOnCR(byval id as long) as long

const CGUI_FBYTE = 1
const CGUI_FSHORT = 2
const CGUI_FINT = 3
const CGUI_FLONG = 4
const CGUI_FSTRING = 5
const CGUI_FPTRSTR = 6
const CGUI_FPOINTS = 7
const CGUI_FBPOINTS = 8
const CGUI_FFLOAT = 9
const CGUI_FHEX1 = 10
const CGUI_FHEX2 = 11
const CGUI_FHEX4 = 12
const CGUI_FOCT1 = 13
const CGUI_FOCT2 = 14
const CGUI_FOCT3 = 15
const CGUI_FOCT4 = 16
const CGUI_FNAME = &h20
const CGUI_FBLANK0 = &h40
const CGUI_FUNDEF = &h6000
const CGUI_B_UNDEF_VAL = &hFF
const CGUI_S_UNDEF_VAL = &h8000
const CGUI_I_UNDEF_VAL = cast(clong, &h80000000)
const CGUI_L_UNDEF_VAL = cast(clong, &h80000000)
const CGUI_P_UNDEF_VAL = &h8000
const CGUI_BP_UNDEF_VAL = &h80

declare sub Refresh(byval id as long)
declare sub DeActivate(byval id as long)
declare sub Activate(byval id as long)
declare function CguiLoadImage(byval filename as const zstring ptr, byval imagename as const zstring ptr, byval transp as long, byval id as long) as long
declare function InsertPoint(byval id as long) as long

const CGUI_IMAGE_BMP = 0
const CGUI_IMAGE_TRANS_BMP = 1
const CGUI_IMAGE_RLE_SPRITE = 2
const CGUI_IMAGE_CMP_SPRITE = 3
declare function RegisterImage(byval data as any ptr, byval imagename as const zstring ptr, byval type as long, byval id as long) as long
declare function GetRegisteredImage(byval name as const zstring ptr, byval type as long ptr, byval id as long) as const any ptr
const CGUI_LEFT_MOUSE = 1
const CGUI_RIGHT_MOUSE = 2

declare sub SetObjectSlidable(byval id as long, byval Slider as function(byval x as long, byval y as long, byval src as any ptr, byval id as long, byval reason as long) as long, byval buttons as long, byval data as any ptr)
declare sub SetObjectDouble(byval id as long, byval DoubleCall as sub(byval as any ptr), byval data as any ptr, byval button as long)
declare sub SetObjectGrippable(byval id as long, byval Grip as function(byval src as any ptr, byval id as long, byval reason as long) as any ptr, byval flags as long, byval buttons as long, byval data as any ptr)
declare sub SetObjectDroppable(byval id as long, byval Drop as function(byval dest as any ptr, byval id as long, byval src as any ptr, byval reason as long, byval flags as long) as long, byval flags as long, byval data as any ptr)

const CGUI_DD_GRIPPED = 0
const CGUI_DD_UNGRIPPED = 1
const CGUI_DD_SUCCESS = 2
const CGUI_DD_OVER_GRIP = 3
const CGUI_DD_OVER_DROP = 4
const CGUI_DD_END_OVER_DROP = 5
const CGUI_SL_OVER = 6
const CGUI_SL_OVER_END = 7
const CGUI_SL_STARTED = 8
const CGUI_SL_PROGRESS = 9
const CGUI_SL_STOPPED = 10

declare function ToolTipText(byval id as long, byval text as const zstring ptr) as long
declare sub CguiSetToolTipDelay(byval delay as long)
declare sub CguiSetToolTipAnimation(byval step as long, byval delay as long)
declare function SetView(byval id as long, byval flags as long) as long

const CGUI_SV_HIDE_LABEL = 1
const CGUI_SV_HIDE_ICON = 2
const CGUI_SV_NO_TOOLTIP = 4
const CGUI_SV_ONLY_BRIEF = 8
const CGUI_SV_ONLY_LONG = 16
const CGUI_SV_PREFERE_BRIEF = 32
const CGUI_SV_PREFERE_LONG = 0

declare function RegisterDragFlag(byval flag as long) as long
declare function UnRegisterDragFlag(byval flag as long) as long
declare function SetMouseButtons(byval id as long, byval buttons as long) as long
declare sub Remove_ alias "Remove"(byval id as long)
declare sub Destroy(byval id as long)
declare function GetPressedButton(byval id as long) as long
declare sub PointerOn(byval id as long)
declare sub ModifyHeader(byval id as long, byval newtag as zstring ptr)
declare function AddHandler(byval id as long, byval Handler as sub(byval data as any ptr), byval data as any ptr) as long
declare sub Click(byval id as long)
declare function GetObjectPosition(byval id as long, byval x as long ptr, byval y as long ptr, byval wx as long ptr, byval wy as long ptr) as long
declare sub SetBlitLimit(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)

EXTERNVAR cgui_use_vsync as long

const CGUI_CT_BORDER = 1
const CGUI_CT_OBJECT_TABLE = 2
declare function StartContainer(byval x as long, byval y as long, byval width as long, byval height as long, byval label as const zstring ptr, byval options as long) as long
declare sub EndContainer()
declare sub SelectContainer(byval id as long)
declare function SetSpacing(byval id as long, byval leftx as long, byval xdist as long, byval rightx as long, byval topy as long, byval ydist as long, byval boty as long) as long
declare sub SetMeasure(byval leftx as long, byval xdist as long, byval rightx as long, byval topy as long, byval ydist as long, byval boty as long)
declare sub SetDistance(byval xdist as long, byval ydist as long)
declare sub ReBuildContainer(byval id as long)
declare sub EmptyContainer(byval id as long)

const CGUI_OFF = 0
const CGUI_ON = 1
const CGUI_ROW_STRIKE = 1 shl 31
const CGUI_ROW_UNDERLINE = 1 shl 30
const CGUI_ROW_CHECK = 1 shl 29
const CGUI_ROW_UNCHECK = 1 shl 28
const CGUI_COL_RIGHT_ALIGN = 1 shl 27
const CGUI_ROW_COLUMN_UNDERLINE = 1 shl 26

declare function AddList(byval x as long, byval y as long, byval listdata as any ptr, byval n as long ptr, byval width as long, byval events as long, byval TextFormatter as function(byval as any ptr, byval as zstring ptr) as long, byval Action as sub(byval id as long, byval as any ptr), byval norows as long) as long
declare function SetLinkedList(byval id as long, byval NextCreater as function(byval list as any ptr, byval prev as any ptr) as any ptr) as long
declare function SetIndexedList(byval id as long, byval IndexCreater as function(byval list as any ptr, byval i as long) as any ptr) as long
declare function RefreshListRow(byval id as long, byval i as long) as long
declare function GetMarkedRows(byval listid as long, byval n as long ptr) as any ptr ptr
declare function BrowseToF(byval id as long, byval i as long) as long
declare function BrowseToL(byval id as long, byval i as long) as long
declare function BrowseTo(byval id as long, byval i as long, byval uncond as long) as long
declare function SetListColumns(byval id as long, byval RowTextCreater as function(byval rowdata as any ptr, byval s as zstring ptr, byval colnr as long) as long, byval widths as long ptr, byval n as long, byval options as long, byval labels as zstring ptr ptr, byval CallBack as sub(byval data as any ptr, byval id as long, byval i as long), byval data as any ptr) as long
declare function SetListGrippable(byval listid as long, byval Grip as function(byval srcobj as any ptr, byval reason as long, byval srclist as any ptr, byval i as long) as long, byval flags as long, byval buttons as long) as long
declare function SetListDroppable(byval listid as long, byval Drop as function(byval destobj as any ptr, byval reason as long, byval srcobj as any ptr, byval destlist as any ptr, byval i as long, byval flags as long) as long, byval flags as long) as long
declare function SetListDoubleClick(byval listid as long, byval AppDouble as sub(byval id as long, byval data as any ptr, byval i as long), byval button as long) as long
declare function HookList(byval listid as long, byval listdata as any ptr, byval n as long ptr, byval width as long, byval events as long, byval TextFormatter as function(byval as any ptr, byval as zstring ptr) as long, byval Action as sub(byval as long, byval as any ptr)) as long
declare function SetDeleteHandler(byval listid as long, byval CallBack as sub(byval rowid as long, byval object as any ptr)) as long
declare function SetInsertHandler(byval listid as long, byval CallBack as sub(byval list as any ptr, byval index as long)) as long
declare function GetListIndex(byval id as long) as long
declare function HookExit(byval id as long, byval ExitFun as sub(byval data as any ptr), byval data as any ptr) as long
declare function NotifyFocusMove(byval listid as long, byval CallBack as sub(byval id as long, byval rowobject as any ptr)) as long
const CGUI_TR_HIDE_ROOT = &h00000001
declare function ListTreeView(byval listid as long, byval width as long, byval IsLeaf as function(byval rowobject as any ptr) as long, byval options as long) as long
declare function ListTreeSetNodesExpandedState(byval listid as long, byval IsExpanded as function(byval data as any ptr) as long) as long
declare function ListTreeSetNodeExpandedState(byval listid as long, byval new_expanded_state as long, byval data as any ptr) as long
declare function InstallBelowListEndCallBack(byval listid as long, byval CallBack as sub(byval id as long, byval data as any ptr), byval data as any ptr) as long
declare function CguiListBoxSetToolTip(byval listid as long, byval mode as long, byval options as long) as long
declare sub CguiListBoxRowSetBar(byval color as long, byval percentage as double)
declare function CguiListBoxRowGetClickedColumn(byval rowid as long) as long
declare sub CguiListBoxSetColumnSelection(byval listid as long, byval state as long)

EXTERNVAR cgui_list_no_multiple_row_selection as long
EXTERNVAR cgui_list_show_focused_row as long
EXTERNVAR CGUI_list_font as FONT ptr
EXTERNVAR CGUI_list_row_font as FONT ptr
EXTERNVAR CGUI_list_row_f_color as long
EXTERNVAR CGUI_list_row_b_color as long
EXTERNVAR CGUI_list_vspace as long
EXTERNVAR CGUI_list_fixfont as long
EXTERNVAR cgui_list_fix_digits as long

const CGUI_LIST_COLUMNS_ADJUSTABLE = 1 shl 0
const CGUI_LIST_COLUMNS_ADJUSTABLE_KEEP_BOX_WIDTH = 1 shl 1
const CGUI_LIST_COLUMNS_DELIMITER = 1 shl 2

declare function MkVerticalBrowser(byval x as long, byval y as long, byval CallBack as sub(byval data as any ptr), byval data as any ptr, byval viewpos as long ptr) as long
declare function MkHorizontalBrowser(byval x as long, byval y as long, byval CallBack as sub(byval data as any ptr), byval data as any ptr, byval viewpos as long ptr) as long
declare function NotifyBrowser(byval id as long, byval step as long, byval scrolled_area_length as long) as long
declare function SetBrowserSize(byval id as long, byval view_port_length as long, byval browser_length as long) as long
declare function RegisterFileType(byval ext as const zstring ptr, byval Handler as sub(byval data as any ptr, byval path as zstring ptr), byval data as any ptr, byval aname as const zstring ptr, byval icon as const zstring ptr, byval label as const zstring ptr, byval Viewer as sub(byval privatedata as any ptr, byval viewdata as any ptr)) as long
declare function FileSelect(byval masks as const zstring ptr, byval rpath as const zstring ptr, byval flags as long, byval winheader as const zstring ptr, byval buttonlabel as const zstring ptr) as const zstring ptr
declare sub FileManager(byval winheader as const zstring ptr, byval flags as long)
declare function UnPackSelection(byval flist as zstring ptr ptr) as zstring ptr

const CGUI_FS_BROWSE_DAT = 1 shl 0
const CGUI_FS_DISABLE_EDIT_DAT = 1 shl 1
const CGUI_FS_WARN_EXISTING_FILE = 1 shl 2
const CGUI_FS_FORBID_EXISTING_FILE = 1 shl 3
const CGUI_FS_REQUIRE_EXISTING_FILE = 1 shl 4
const CGUI_FS_SELECT_DIR = 1 shl 5
const CGUI_FS_DISABLE_CREATE_DIR = 1 shl 6
const CGUI_FS_DISABLE_DELETING = 1 shl 7
const CGUI_FS_DISABLE_COPYING = 1 shl 8
const CGUI_FS_SHOW_MENU = 1 shl 9
const CGUI_FS_NO_SETTINGS_IN_CONFIG = 1 shl 10
const CGUI_FS_MULTIPLE_SELECTION = 1 shl 11
const CGUI_FS_NO_DRAG_DROP = 1 shl 12
const CGUI_FS_DIRECT_SELECT_BY_DOUBLE_CLICK = 1 shl 13
const CGUI_FS_SAVE_AS = 1 shl 14
const CGUI_FS_SHOW_DIR_TREE = 1 shl 15
const CGUI_FS_SHOW_DIRS_IN_FILE_VIEW = 1 shl 16
const CGUI_FS_HIDE_LOCATION = 1 shl 17
const CGUI_FS_HIDE_UP_BUTTON = 1 shl 18
const CGUI_FS_HIDE_UP_DIRECTORY = 1 shl 19
const CGUI_FS_FILE_FILTER_IS_READ_ONLY = 1 shl 20
const CGUI_FM_HIDE_FILE_VEW = 1 shl 21
const CGUI_FM_DO_NOT_SHOW_MENU = 1 shl 22
const CGUI_FM_NO_FLOATING = 1 shl 23
const CGUI_FM_BROWSE_DAT = CGUI_FS_BROWSE_DAT
const CGUI_FM_DISABLE_EDIT_DAT = CGUI_FS_DISABLE_EDIT_DAT
const CGUI_FM_DISABLE_CREATE_DIR = CGUI_FS_DISABLE_CREATE_DIR
const CGUI_FM_DISABLE_DELETING = CGUI_FS_DISABLE_DELETING
const CGUI_FM_DISABLE_COPYING = CGUI_FS_DISABLE_COPYING
const CGUI_FM_NO_SETTINGS_IN_CONFIG = CGUI_FS_NO_SETTINGS_IN_CONFIG
const CGUI_FM_SHOW_DIRS_IN_FILE_VIEW = CGUI_FS_SHOW_DIRS_IN_FILE_VIEW
const CGUI_FM_HIDE_LOCATION = CGUI_FS_HIDE_LOCATION
const CGUI_FM_HIDE_UP_BUTTON = CGUI_FS_HIDE_UP_BUTTON
const CGUI_FM_HIDE_UP_DIRECTORY = CGUI_FS_HIDE_UP_DIRECTORY

declare sub CguiUseIcons(byval filename as const zstring ptr)
declare function CreateTabWindow(byval x as long, byval y as long, byval width as long, byval height as long, byval status as long ptr) as long
declare function AddTab(byval id as long, byval callback as sub(byval data as any ptr, byval id as long), byval data as any ptr, byval label as const zstring ptr) as long
declare sub HookLeaveTab(byval callback as sub(byval data as any ptr), byval data as any ptr)
declare function SetFocusOn(byval id as long) as long
declare function JoinTabChain(byval id as long) as long
declare function GetCurrentFocus(byval id as long) as long
declare sub SetCguiFont(byval f as FONT ptr)
declare function GetCguiFont() as FONT ptr
declare function GetCguiFixFont() as FONT ptr
declare sub CguiSetBaseLine(byval base_line as long)
declare function Invite(byval mask as long, byval data as any ptr, byval text as zstring ptr) as long
declare function Attend(byval mask as long) as any ptr
declare sub ProcessEvents()
declare sub StopProcessEvents()
declare function GenEvent(byval Handler as sub(byval as any ptr), byval msg as any ptr, byval delay as ulong, byval objid as long) as ulong
declare sub CguiEventIterateFunction(byval Function as function(byval as any ptr) as long, byval as any ptr)
declare function KillEvent(byval id as ulong) as long
declare sub FlushGenEvents()
declare sub CguiYieldTimeslice(byval state as long)

EXTERNVAR event_message_buffer_size as long

declare sub InstallKBHandler(byval Handler as function(byval data as any ptr, byval scan as long, byval key as long) as long, byval data as any ptr)
declare function UnInstallKBHandler(byval Handler as function(byval as any ptr, byval as long, byval as long) as long) as any ptr
declare function SetHotKey(byval id as long, byval CallBack as sub(byval as any ptr), byval data as any ptr, byval scan as long, byval ascii as long) as long
declare function IsHotKey(byval scan as long, byval ascii as long) as long
declare sub SimulateHotKeys(byval control as long, byval key as long)
declare sub UseHotKeys(byval s as zstring ptr)
declare sub AutoHotKeys(byval mode as long)

type t_cgui_colors as long
enum
	CGUI_COLOR_DESKTOP
	CGUI_COLOR_UNSELECTED_TAB
	CGUI_COLOR_SELECTED_TAB
	CGUI_COLOR_LIGHTENED_BORDER
	CGUI_COLOR_HEAVY_LIGHTENED_BORDER
	CGUI_COLOR_SHADOWED_BORDER
	CGUI_COLOR_HEAVY_SHADOWED_BORDER
	CGUI_COLOR_CONTAINER
	CGUI_COLOR_WIDGET_BACKGROUND
	CGUI_COLOR_LABEL
	CGUI_COLOR_LABEL_FOCUS
	CGUI_COLOR_LABEL_HIDDEN_FOCUS
	CGUI_COLOR_LABEL_INACTIVE_1
	CGUI_COLOR_LABEL_INACTIVE_2
	CGUI_COLOR_BUTTON_FRAME_FOCUS
	CGUI_COLOR_TEXT_CURSOR
	CGUI_COLOR_DRAGGED_TEXT
	CGUI_COLOR_LISTBOX_TEXT
	CGUI_COLOR_LISTBOX_BACKGROUND
	CGUI_COLOR_LISTBOX_FOCUS_TEXT
	CGUI_COLOR_LISTBOX_FOCUS_BACKGROUND
	CGUI_COLOR_LISTBOX_HIDDEN_FOCUS_BACKGROUND
	CGUI_COLOR_LISTBOX_HIDDEN_FOCUS_TEXT
	CGUI_COLOR_LISTBOX_ROW_DELIMITER
	CGUI_COLOR_LISTBOX_COLUMN_DELIMITER
	CGUI_COLOR_TOOL_TIP_BACKGROUND
	CGUI_COLOR_TOOL_TIP_FRAME
	CGUI_COLOR_TOOL_TIP_TEXT
	CGUI_COLOR_TEXTBOX_TEXT
	CGUI_COLOR_TEXTBOX_BACKGROUND
	CGUI_COLOR_CONTAINER_LABEL
	CGUI_COLOR_EDITBOX_BACKGROUND_MARK
	CGUI_COLOR_EDITBOX_TEXT_MARK
	CGUI_COLOR_EDITBOX_BACKGROUND_INACTIVE
	CGUI_COLOR_EDITBOX_TEXT_INACTIVE
	CGUI_COLOR_EDITBOX_BACKGROUND
	CGUI_COLOR_EDITBOX_TEXT
	CGUI_COLOR_STATUSFIELD_BACKGROUND
	CGUI_COLOR_STATUSFIELD_TEXT
	CGUI_COLOR_PROGRESSBAR
	CGUI_COLOR_PROGRESSBAR_BACKGROUND
	CGUI_COLOR_TITLE_FOCUS_BACKGROUND
	CGUI_COLOR_TITLE_FOCUS_TEXT
	CGUI_COLOR_TITLE_UNFOCUS_BACKGROUND
	CGUI_COLOR_TITLE_UNFOCUS_TEXT
	CGUI_COLOR_TREE_VIEW_BACKGROUND
	CGUI_COLOR_TREE_CONTROL_BACKGROUND
	CGUI_COLOR_TREE_CONTROL_OUTLINE
	CGUI_COLOR_CHECKBOX_MARK_BACKGROUND
	CGUI_COLOR_BROWSEBAR_BACKGROUND
	CGUI_COLOR_BROWSEBAR_HANDLE_BACKGROUND
	CGUI_COLOR_RESIZER_HANDLE
	NR_OF_CGUI_COLORS
end enum

EXTERNVAR cgui_colors(0 to NR_OF_CGUI_COLORS - 1) as long
declare function CguiSetColor(byval color_name as long, byval r as long, byval g as long, byval b as long) as long
declare sub NameCase(byval text as zstring ptr)
declare sub Sound(byval freq as long, byval duration as long)
declare function AddClock(byval x as long, byval y as long, byval options as long) as long

const CGUI_CLOCK_SHOW_SECONDS = 1
const CGUI_CLOCK_SHOW_MINUTES = 2
const CGUI_CLOCK_NO_DIALOGUE = 4

declare function ToUpper(byval chr as long) as long
declare function SaveDatafileObject(byval path as const zstring ptr, byval data as any ptr, byval type as long) as long
declare function CreateNewDataFile(byval path as const zstring ptr, byval fn as const zstring ptr, byval pack as long, byval pwd as const zstring ptr) as long
declare function msprintf(byval format as const zstring ptr, ...) as zstring ptr
declare sub InstallCursor(byval cursor_no as long, byval sprite as BITMAP ptr, byval x as long, byval y as long)
declare sub ShowPointer()
declare sub HidePointer()
declare sub PointerLocation(byval id as long, byval x as long ptr, byval y as long ptr)
declare function ObjectApearance(byval id as long) as BITMAP ptr
declare sub OverlayPointer(byval sprite as BITMAP ptr, byval x as long, byval y as long)
declare sub RemoveOverlayPointer()
declare sub MkTextPointer(byval f as FONT ptr, byval text as const zstring ptr)
declare sub SelectCursor(byval cursor_no as long)

const CGUI_CURS_ILLEGAL = 0
const CGUI_CURS_DRAGGABLE = 1
const CGUI_CURS_DRAG_V = 2
const CGUI_CURS_DRAG_H = 3
const CGUI_CURS_CROSS = 4
const CGUI_CURS_BUSY = 5
const CGUI_CURS_DEFAULT = 6
declare sub CguiSetMouseInput(byval MouseInput as sub(byval x as long ptr, byval y as long ptr, byval z as long ptr, byval buttons as long ptr), byval ForcePos as sub(byval x as long, byval y as long), byval SetRange as sub(byval x as long, byval y as long, byval w as long, byval h as long))
declare sub SetMousePos(byval x as long, byval y as long)
EXTERNVAR cgui_mouse_draw_in_interrupt as long
declare function LoadTexts(byval fn as const zstring ptr, byval section as const zstring ptr, byval nr as long ptr) as const zstring const ptr ptr
declare sub DestroyTexts()
declare sub RegisterConversionHandler(byval Handler as sub(byval as any ptr, byval as zstring ptr), byval data as any ptr, byval name as const zstring ptr)
declare sub PrintFloatingConversion(byval dest as zstring ptr, byval src as const zstring ptr)
declare function LoadCompiledTexts(byval dat as const DATAFILE ptr, byval section as const zstring ptr, byval nr as long ptr) as const zstring const ptr ptr
declare sub RegisterRefresh(byval id as long, byval AppUpd as sub(byval id as long, byval data as any ptr, byval calldata as any ptr, byval reason as long), byval data as any ptr)
declare sub ConditionalRefresh(byval calldata as any ptr, byval reason as long)
declare function GetSizeOffset(byval id as long, byval x as long ptr, byval y as long ptr) as long
declare function SetSizeOffset(byval id as long, byval x as long, byval y as long) as long
declare function MakeStretchable(byval id as long, byval Notify as sub(byval as any ptr), byval data as any ptr, byval options as long) as long
const CGUI_NO_VERTICAL = 1
const CGUI_NO_HORIZONTAL = 2
EXTERNVAR continous_update_resize as long
const CGUI_FRAMERAISE = CGUI_TB_FRAMERAISE
const CGUI_FRAMESINK = CGUI_TB_FRAMESINK
const CGUI_W_NOMODAL = CGUI_W_FLOATING
const CGUI_W_CHILD = 0

end extern
