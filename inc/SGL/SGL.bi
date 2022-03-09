''MIT License

''Copyright (c) 2020 ruanjiaxing

''Permission is hereby granted, free of charge, to any person obtaining a copy
''of this software and associated documentation files (the "Software"), to deal
''in the Software without restriction, including without limitation the rights
''to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''copies of the Software, and to permit persons to whom the Software is
''furnished to do so, subject to the following conditions:
''
''The above copyright notice and this permission notice shall be included in all
''copies or substantial portions of the Software.

''THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
''SOFTWARE.

#pragma once

#include once "windows.bi"
#include once "crt/stdarg.bi"

extern "C"

#define OEMRESOURCE
const SGL_PANEL = 1000
const SGL_HIDDENFRAME = SGL_PANEL + 1
const SGL_ROUNDEDFRAME = SGL_PANEL + 2
declare function SGL_PanelIpaddingSet(byval hwnd as HWND, byval ipad as RECT ptr) as long
declare function SGL_PanelIpaddingGet(byval hwnd as HWND, byval ipad as RECT ptr) as long
type SGL_RESIZECB as function(byval hwnd as HWND, byval wOffset as long, byval hOffset as long) as long
declare function SGL_ResizeInstall(byval hwnd as HWND, byval widthMin as long, byval heightMin as long, byval resizeCB as SGL_RESIZECB) as long
const NONE = 0
const STD = 1
const ERR_ = 2
const FATAL = 3
const QUIT = 4

declare sub SGL_Log(byval mask as long, byval fmt as zstring ptr, ...)
declare sub SGL_Fatal(byval file as zstring ptr, byval line as long, byval diag as zstring ptr)
declare sub SGL_Error(byval file as zstring ptr, byval line as long, byval eresult as long)

#define NELEMS(a) (sizeof(a) / sizeof((a)[0]))
#macro PCHECK(p)
	if (p) = NULL then
		SGL_Fatal(__FILE__, __LINE__, "ALLOCATION")
	end if
#endmacro
#define CHKERR(m) scope : SGL_Error(__FILE__, __LINE__, (m)) : end scope
#macro GCLK(m)
	scope
		dim _t_t as double = SGL_Timer()
		m
		_t_t = SGL_Timer() - _t_t
		SGL_Log(STD, ":CLK: %-50.50s :%12.4f ms", #m, 1.e3 * _t_t)
	end scope
#endmacro
const SGL_ERR_INT = -1
const SGL_ERR_ALLOC = -2
const SGL_ERR_TYPE = -3
const SGL_ERR_PARM = -4
const SGL_FONT_NORMAL = 1
const SGL_FONT_FIXED = 0
const SGL_FONT_BOLD = 2
const SGL_FONT_ITALIC = 3
const SGL_FONT_SYMBOL = 4
const SGL_FONT_EXTRA = 5
const SGL_FONT_SMALL = 0
const SGL_FONT_LARGE = 2
const SGL_FONT_BIG = 3
const SGL_CENTER = 0
const SGL_LEFT = 1
const SGL_RIGHT = 2
const SGL_TOP = SGL_LEFT shl 8
const SGL_BOTTOM = SGL_RIGHT shl 8
const SGL_BORDER_NONE = 0
const SGL_BORDER_FLAT = 1
const SGL_BORDER_RFLAT = 2
const SGL_BORDER_BEVEL_UP = 3
const SGL_BORDER_BEVEL_DOWN = 4
const SGL_BORDER_ETCHED_UP = 5
const SGL_BORDER_ETCHED_DOWN = 6
const SGL_WIDTH = 101
const SGL_HEIGHT = SGL_WIDTH + 1
const SGL_SYSCOLOR = &h80000000
#define SGL_LTGRAY (SGL_SYSCOLOR or COLOR_BTNFACE)
#define SGL_GRAY (SGL_SYSCOLOR or COLOR_BTNSHADOW)
const SGL_BLACK = 0
const SGL_WHITE = &h00ffffff
#define SGL_KEY_SHIFT (GetKeyState(VK_SHIFT) < 0)
#define SGL_KEY_CTRL (GetKeyState(VK_CONTROL) < 0)
#define SGL_LBUTTON (GetKeyState(VK_LBUTTON) < 0)
#define SGL_MBUTTON (GetKeyState(VK_MBUTTON) < 0)
#define SGL_RBUTTON (GetKeyState(VK_RBUTTON) < 0)
type SGL_CB as function(byval hwnd as HWND, byval event as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as long

type SGL_CONTEXT_T
	selected as long
	dimmed as long
	bgdColor as COLORREF
	fgdColor as COLORREF
	fontSizeIx as long
	fontStyle as long
end type

declare sub SGL_Init(byval hInstance as HINSTANCE, byval iconRsc as zstring ptr)
declare sub SGL_Exit()
declare function SGL_New(byval parent as HWND, byval type as long, byval style as DWORD, byval title as zstring ptr, byval left as long, byval top as long) as HWND
declare function SGL_Duplicate(byval parentDest as HWND, byval childSource as HWND, byval title as zstring ptr, byval left as long, byval top as long) as HWND
declare function SGL_Timer() as double
declare sub SGL_Layout(byval hwnd as HWND)
declare function SGL_Redraw(byval hwnd as HWND) as long
declare function SGL_Run() as long
declare sub SGL_Destroy(byval hwnd as HWND)
declare function SGL_RefSizeGet() as long
declare sub SGL_DefPaddingSet(byval l as long)
declare function SGL_DefPaddingGet() as long
declare function SGL_FontLoad(byval fName as zstring ptr) as long
declare function SGL_FontFaceSet(byval option as long, byval name as zstring ptr) as long
declare function SGL_FontSizeSet(byval sizeIx as long, byval size as long) as long
declare function SGL_FontFaceGet(byval option as long, byval name as zstring ptr) as long
declare function SGL_FontHandleGet(byval hwnd as HWND, byval sizeIx as long, byval option as long) as HFONT
declare function SGL_FontSizeGet(byval hwnd as HWND) as long
declare function SGL_FontHeightGet(byval hwnd as HWND) as long
declare function SGL_FontSizeIxSet(byval hwnd as HWND, byval sizeIx as long) as long
declare function SGL_FontSizeIxGet(byval hwnd as HWND) as long
declare function SGL_FontStyleSet(byval hwnd as HWND, byval option as long) as long
declare function SGL_FontStyleGet(byval hwnd as HWND) as long
declare function SGL_PositionSet(byval hwnd as HWND, byval left as long, byval top as long) as long
declare function SGL_PositionGet(byval hwnd as HWND, byval left as long ptr, byval top as long ptr) as long
declare function SGL_SizeSet(byval hwnd as HWND, byval sizeID as long, byval size as long) as long
declare function SGL_SizeGet(byval hwnd as HWND, byval sizeID as long, byval size as long ptr) as long
const SGL_SAVE_POSITION = 1
const SGL_SAVE_SIZE = 2
declare function SGL_LayoutConfigure(byval hwnd as HWND, byval section as zstring ptr, byval op as long) as long
declare function SGL_AlignmentSet(byval hwnd as HWND, byval align as long) as long
declare function SGL_AlignmentGet(byval hwnd as HWND) as long
declare function SGL_PaddingSet(byval hwnd as HWND, byval padding as RECT ptr) as long
declare function SGL_PaddingGet(byval hwnd as HWND, byval padding as RECT ptr) as long
declare function SGL_VisibleSet(byval hwnd as HWND, byval visible as long) as long
declare function SGL_VisibleGet(byval hwnd as HWND) as long
declare sub SGL_DebugSet(byval hwnd as HWND, byval debugLevel as long)
declare function SGL_DebugGet(byval hwnd as HWND) as long
declare function SGL_CursorPositionSet(byval hwnd as HWND, byval pt as POINT ptr) as long
declare function SGL_CursorPositionGet(byval hwnd as HWND, byval current as long, byval pt as POINT ptr) as long
declare function SGL_TitleSet(byval hwnd as HWND, byval title as zstring ptr) as long
declare function SGL_TitleGet(byval hwnd as HWND, byval title as zstring ptr ptr) as long
declare function SGL_DimmedSet(byval hwnd as HWND, byval dimmed as long) as long
declare function SGL_DimmedGet(byval hwnd as HWND) as long
declare function SGL_BGcolorSet(byval hwnd as HWND, byval color as COLORREF) as long
declare function SGL_BGcolorGet(byval hwnd as HWND) as long
declare function SGL_FGcolorSet(byval hwnd as HWND, byval color as COLORREF) as long
declare function SGL_FGcolorGet(byval hwnd as HWND) as long
declare function SGL_BorderStyleSet(byval hwnd as HWND, byval style as long) as long
declare function SGL_BorderStyleGet(byval hwnd as HWND) as long
declare function SGL_BorderThicknessSet(byval hwnd as HWND, byval e as long) as long
declare function SGL_BorderThicknessGet(byval hwnd as HWND, byval e as long ptr) as long
declare function SGL_BorderColorSet(byval hwnd as HWND, byval color as COLORREF) as long
declare function SGL_BorderColorGet(byval hwnd as HWND, byval color as COLORREF ptr) as long
declare function SGL_BorderDraw(byval hdc as HDC, byval rect as RECT ptr, byval style as long, byval width as long, byval color as long, byval dim as long) as long
declare function SGL_CallbackFunctionSet(byval hwnd as HWND, byval func as SGL_CB) as long
declare function SGL_CallbackFunctionGet(byval hwnd as HWND, byval func as SGL_CB ptr) as long
declare function SGL_CallbackDataSet(byval hwnd as HWND, byval dataPtr as any ptr) as long
declare function SGL_CallbackDataGet(byval hwnd as HWND, byval dataPtr as any ptr ptr) as long
declare function SGL_ContextGet(byval hwnd as HWND, byval context as SGL_CONTEXT_T ptr) as long

const SGL_CTRL_BUTTON = 1200
const SGL_CTRL_PUSHBUTTON = SGL_CTRL_BUTTON + 1
const SGL_CTRL_CHECKBUTTON = SGL_CTRL_BUTTON + 2
const SGL_CTRL_RADIOBUTTON = SGL_CTRL_BUTTON + 3
declare function SGL_ButtonValueSet(byval hwnd as HWND, byval value as long) as long
declare function SGL_ButtonValueGet(byval hwnd as HWND) as long
const SGL_CTRL_EDIT = 1300

declare function SGL_EditTextSet(byval hwnd as HWND, byval text as zstring ptr) as long
declare function SGL_EditTextAppend(byval hwnd as HWND, byval text as zstring ptr) as long
declare function SGL_EditTextLengthGet(byval hwnd as HWND) as long
declare function SGL_EditTextGet(byval hwnd as HWND, byval text as zstring ptr, byval maxLen as long) as long
const SGL_CTRL_IMAGE = 1600
declare function SGL_ImageLoad(byval hwnd as HWND, byval fileName as zstring ptr) as long
declare function SGL_ImageLoadW(byval hwnd as HWND, byval fileName as wstring ptr) as long
declare function SGL_ImageUnload(byval hwnd as HWND) as long
declare function SGL_ImageFittingSet(byval hwnd as HWND, byval fit as long) as long
declare function SGL_ImageFittingGet(byval hwnd as HWND) as long
declare function SGL_ImageFrameIndexSet(byval hwnd as HWND, byval frameIndex as long) as long
declare function SGL_ImageFrameIndexGet(byval hwnd as HWND) as long
declare function SGL_ImageFrameCountGet(byval hwnd as HWND) as long
declare function SGL_ImagePlay(byval hwnd as HWND, byval speed100 as long) as long
const SGL_CTRL_GRAPH = 1500
type SGL_GRAPH_PLOTCB as sub(byval hwnd as HWND, byval hdc as HDC, byval layer as long, byval item as long)
type SGL_GRAPH_LABELCB as sub(byval hwnd as HWND, byval hdc as HDC, byval value as double, byval rect as RECT ptr, byval axisID as long)

type SGL_GRAPH_AXIS_T
	lowValue as double
	highValue as double
	interval as double
	ntick as long
	labelCB as SGL_GRAPH_LABELCB
	grid as long
	color as COLORREF
end type

declare function SGL_GraphAxisSet(byval hwnd as HWND, byval axisID as long, byval uAxis as SGL_GRAPH_AXIS_T ptr) as long
declare function SGL_GraphAxisGet(byval hwnd as HWND, byval axisID as long, byval uAxis as SGL_GRAPH_AXIS_T ptr) as long
declare function SGL_GraphMarginSet(byval hwnd as HWND, byval margin as RECT ptr) as long
declare function SGL_GraphMarginGet(byval hwnd as HWND, byval margin as RECT ptr) as long
declare function SGL_GraphPlotRectGet(byval hwnd as HWND, byval plotRect as RECT ptr) as long
declare function SGL_GraphTickLengthSet(byval hwnd as HWND, byval tickLen as long) as long
declare function SGL_GraphTickLengthGet(byval hwnd as HWND, byval tickLen as long ptr) as long
declare function SGL_GraphBGcolorSet(byval hwnd as HWND, byval layer as long, byval bgColor as COLORREF) as long
declare function SGL_GraphBGcolorGet(byval hwnd as HWND, byval layer as long, byval bgColor as COLORREF ptr) as long
declare function SGL_GraphPlotFunctionSet(byval hwnd as HWND, byval plotFunc as SGL_GRAPH_PLOTCB) as long
declare function SGL_GraphPlotFunctionGet(byval hwnd as HWND, byval plotFunc as SGL_GRAPH_PLOTCB ptr) as long
declare function SGL_GraphPlotRequest(byval hwnd as HWND, byval layer as long, byval item as long) as long
declare function SGL_GraphClear(byval hwnd as HWND, byval layer as long) as long
declare function SGL_GraphUserToPixel(byval hwnd as HWND, byval axisID as long, byval x as double) as long
declare function SGL_GraphPixelToUser(byval hwnd as HWND, byval axisID as long, byval xp as long, byval x as double ptr) as long
const SGL_CTRL_OPENGL = 1700
declare function SGL_OglZoomSet(byval hwnd as HWND, byval nFoc as double) as long
declare function SGL_OglZoomGet(byval hwnd as HWND, byval nFoc as double ptr) as long
declare function SGL_OglDepthOfFieldSet(byval hwnd as HWND, byval zNear as double, byval zFar as double) as long
declare function SGL_OglDepthOfFieldGet(byval hwnd as HWND, byval zNear as double ptr, byval zFar as double ptr) as long
type SGL_EDITCB as function(byval virtKey as long, byval text as zstring ptr, byval textLen as long, byval caret as long, byval CBdataPtr as any ptr) as long
declare function SGL_PopupEdit(byval hwnd as HWND, byval rect as RECT ptr, byval style as DWORD, byval text as zstring ptr, byval textLen as long, byval editCB as SGL_EDITCB, byval CBdataPtr as any ptr) as HWND

const SGL_TIME = &h100
const SGL_DATE = &h200
const SGL_DT_LONG = &h80
const SGL_DT_CALENDAR = &h40
const SGL_DT_WEEKNB = &h20
const SGL_DT_TODAY = &h10
const SGL_DT_NONE = &h1
type SGL_DTIMECB as sub(byval event as long, byval datetime as SYSTEMTIME ptr, byval CBdataPtr as any ptr)
const SGL_DT_INSTALL = 0
const SGL_DT_DELETE = 1
const SGL_DT_CHANGED = 2
const SGL_DT_RELEASE = 3
#define SGL_DATETIME_NONE_SET(dt) scope : (dt).wYear = 0 : end scope
#define SGL_DATETIME_NONE_IS(dt) ((dt).wYear = 0)

declare function SGL_PopupDatetime(byval hwnd as HWND, byval rect as RECT ptr, byval style as long, byval format as zstring ptr, byval datetime as SYSTEMTIME ptr, byval dtimeCB as SGL_DTIMECB, byval CBdataPtr as any ptr) as HWND
declare function SGL_DateTimeStringGet(byval datetime as SYSTEMTIME ptr, byval style as long, byval format as zstring ptr, byval dst as zstring ptr, byval max as long) as long
declare function SGL_DateTimeNow() as SYSTEMTIME

type SGL_POPUPMENU_OPTIONS_T
	state as long
	text as zstring ptr
end type

declare function SGL_PopupMenu(byval hwnd as HWND, byval option as SGL_POPUPMENU_OPTIONS_T ptr, byval rect as RECT ptr, byval align as long) as long
const SGL_CTRL_HSEP = 1100
const SGL_CTRL_VSEP = SGL_CTRL_HSEP + 1
const SGL_CTRL_TABLE = 1400
type SGL_TABLE_FILLCB as sub(byval as HWND, byval as HDC, byval as long, byval as long, byval as RECT ptr)

type SGL_TABLE_COLUMN_T
	width as long
	headerMerge as long
	cellNoRightSep as long
	cellBGcolor as COLORREF
end type

declare function SGL_TableColumnsSet(byval hwnd as HWND, byval columns as SGL_TABLE_COLUMN_T ptr) as long
declare function SGL_TableColumnsGet(byval hwnd as HWND, byval columns as SGL_TABLE_COLUMN_T ptr ptr) as long
declare function SGL_TableHeaderHeightSet(byval hwnd as HWND, byval linePercent as long) as long
declare function SGL_TableHeaderHeightGet(byval hwnd as HWND) as long
declare function SGL_TableHeaderBorderThicknessSet(byval hwnd as HWND, byval e as long) as long
declare function SGL_TableHeaderBorderThicknessGet(byval hwnd as HWND, byval e as long ptr) as long
declare function SGL_TableHeightAdjust(byval hwnd as HWND, byval rowMin as long) as long
declare function SGL_TableRowNbSet(byval hwnd as HWND, byval rowNB as long) as long
declare function SGL_TableRowNbGet(byval hwnd as HWND) as long
declare function SGL_TableRowShow(byval hwnd as HWND, byval row as long) as long
declare function SGL_TableSelectionModeSet(byval hwnd as HWND, byval selMode as long) as long
declare function SGL_TableSelectionModeGet(byval hwnd as HWND) as long
declare function SGL_TableSelectionSet(byval hwnd as HWND, byval row as long, byval col as long) as long
declare function SGL_TableSelectionGet(byval hwnd as HWND, byval row as long ptr, byval col as long ptr) as long
declare function SGL_TableFillFunctionSet(byval hwnd as HWND, byval fillFunc as SGL_TABLE_FILLCB) as long
declare function SGL_TableUpdate(byval hwnd as HWND, byval row1 as long, byval rowNB as long, byval col as long) as long
declare function SGL_TableHGridSet(byval hwnd as HWND, byval rowGrid as long) as long
declare function SGL_TableHGridGet(byval hwnd as HWND) as long
declare function SGL_TableGridThicknessSet(byval hwnd as HWND, byval e as long) as long
declare function SGL_TableGridThicknessGet(byval hwnd as HWND, byval e as long ptr) as long
declare function SGL_TableGridColorSet(byval hwnd as HWND, byval color as COLORREF) as long
declare function SGL_TableGridColorGet(byval hwnd as HWND, byval color as COLORREF ptr) as long
declare function SGL_TableAltRowSet(byval hwnd as HWND, byval dim as long) as long
declare function SGL_TableAltRowGet(byval hwnd as HWND, byval dim as long ptr) as long
declare function SGL_TableCellHeightGet(byval hwnd as HWND) as long
declare function SGL_TableCellCoordinatesGet(byval hwnd as HWND, byval row as long ptr, byval col as long ptr) as long
declare function SGL_TableCellRectangleGet(byval hwnd as HWND, byval row as long, byval col as long, byval rect as RECT ptr) as long
declare function SGL_ProfileInit(byval fileName as zstring ptr) as zstring ptr
declare sub SGL_ProfileStringGet(byval section as zstring ptr, byval key as zstring ptr, byval l as zstring ptr, byval size as long)
declare sub SGL_ProfileStringSet(byval section as zstring ptr, byval key as zstring ptr, byval l as zstring ptr)
declare function SGL_ProfileIntGet(byval section as zstring ptr, byval key as zstring ptr, byval defValue as long) as long
declare function SGL_ProfileIntSet(byval section as zstring ptr, byval key as zstring ptr, byval value as long, byval hex as long) as long
declare function SGL_ColorDim(byval color as COLORREF, byval dimmed as long) as COLORREF
declare function SGL_ColorInterpolate(byval color0 as COLORREF, byval color1 as COLORREF, byval k as double) as COLORREF
type COLORS_CB as sub(byval ix as long, byval color as COLORREF)
declare function SGL_ColorsConfigure(byval colorKey as zstring ptr ptr, byval section as zstring ptr, byval colorCB as COLORS_CB) as long
declare sub SGL_ColorsSet()

end extern
