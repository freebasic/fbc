''
''
'' uxtheme -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_uxtheme_bi__
#define __win_uxtheme_bi__

#inclib "uxtheme"

#include once "win/commctrl.bi"

#define DTBG_CLIPRECT &h00000001
#define DTBG_DRAWSOLID &h00000002
#define DTBG_OMITBORDER &h00000004
#define DTBG_OMITCONTENT &h00000008
#define DTBG_COMPUTINGREGION &h00000010
#define DTBG_MIRRORDC &h00000020
#define DTT_GRAYED &h00000001
#define ETDT_DISABLE &h00000001
#define ETDT_ENABLE &h00000002
#define ETDT_USETABTEXTURE &h00000004
#define ETDT_ENABLETAB (&h00000002 or &h00000004)
#define STAP_ALLOW_NONCLIENT &h00000001
#define STAP_ALLOW_CONTROLS &h00000002
#define STAP_ALLOW_WEBCONTENT &h00000004
#define HTTB_BACKGROUNDSEG &h0000
#define HTTB_FIXEDBORDER &h0002
#define HTTB_CAPTION &h0004
#define HTTB_RESIZINGBORDER_LEFT &h0010
#define HTTB_RESIZINGBORDER_TOP &h0020
#define HTTB_RESIZINGBORDER_RIGHT &h0040
#define HTTB_RESIZINGBORDER_BOTTOM &h0080
#define HTTB_RESIZINGBORDER (&h0010 or &h0020 or &h0040 or &h0080)
#define HTTB_SIZINGTEMPLATE &h0100
#define HTTB_SYSTEMSIZINGMARGINS &h0200

enum PROPERTYORIGIN
	PO_STATE = 0
	PO_PART = 1
	PO_CLASS = 2
	PO_GLOBAL = 3
	PO_NOTFOUND = 4
end enum


enum THEMESIZE
	TS_MIN
	TS_TRUE
	TS_DRAW
end enum

type THEME_SIZE as THEMESIZE

type DTBGOPTS
	dwSize as DWORD
	dwFlags as DWORD
	rcClip as RECT
end type

type PDTBGOPTS as DTBGOPTS ptr

#define MAX_INTLIST_COUNT 10

type INTLIST
	iValueCount as integer
	iValues(0 to 10-1) as integer
end type

type PINTLIST as INTLIST ptr

type MARGINS
	cxLeftWidth as integer
	cxRightWidth as integer
	cyTopHeight as integer
	cyBottomHeight as integer
end type

type PMARGINS as MARGINS ptr

type HTHEME as HANDLE

declare function CloseThemeData alias "CloseThemeData" (byval as HTHEME) as HRESULT
declare function DrawThemeBackground alias "DrawThemeBackground" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as RECT ptr, byval as RECT ptr) as HRESULT
declare function DrawThemeBackgroundEx alias "DrawThemeBackgroundEx" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as RECT ptr, byval as DTBGOPTS ptr) as HRESULT
declare function DrawThemeEdge alias "DrawThemeEdge" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as RECT ptr, byval as UINT, byval as UINT, byval as RECT ptr) as HRESULT
declare function DrawThemeIcon alias "DrawThemeIcon" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as RECT ptr, byval as HIMAGELIST, byval as integer) as HRESULT
declare function DrawThemeParentBackground alias "DrawThemeParentBackground" (byval as HWND, byval as HDC, byval as RECT ptr) as HRESULT
declare function DrawThemeText alias "DrawThemeText" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as LPCWSTR, byval as integer, byval as DWORD, byval as DWORD, byval as RECT ptr) as HRESULT
declare function EnableThemeDialogTexture alias "EnableThemeDialogTexture" (byval as HWND, byval as DWORD) as HRESULT
declare function EnableTheming alias "EnableTheming" (byval as BOOL) as HRESULT
declare function GetCurrentThemeName alias "GetCurrentThemeName" (byval as LPWSTR, byval as integer, byval as LPWSTR, byval as integer, byval as LPWSTR, byval as integer) as HRESULT
declare function GetThemeAppProperties alias "GetThemeAppProperties" () as DWORD
declare function GetThemeBackgroundContentRect alias "GetThemeBackgroundContentRect" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as RECT ptr, byval as RECT ptr) as HRESULT
declare function GetThemeBackgroundExtent alias "GetThemeBackgroundExtent" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as RECT ptr, byval as RECT ptr) as HRESULT
declare function GetThemeBackgroundRegion alias "GetThemeBackgroundRegion" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as RECT ptr, byval as HRGN ptr) as HRESULT
declare function GetThemeBool alias "GetThemeBool" (byval as HTHEME, byval as integer, byval as integer, byval as integer, byval as BOOL ptr) as HRESULT
declare function GetThemeColor alias "GetThemeColor" (byval as HTHEME, byval as integer, byval as integer, byval as integer, byval as COLORREF ptr) as HRESULT
declare function GetThemeDocumentationProperty alias "GetThemeDocumentationProperty" (byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as integer) as HRESULT
declare function GetThemeEnumValue alias "GetThemeEnumValue" (byval as HTHEME, byval as integer, byval as integer, byval as integer, byval as integer ptr) as HRESULT
declare function GetThemeFilename alias "GetThemeFilename" (byval as HTHEME, byval as integer, byval as integer, byval as integer, byval as LPWSTR, byval as integer) as HRESULT
declare function GetThemeFont alias "GetThemeFont" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as integer, byval as LOGFONT ptr) as HRESULT
declare function GetThemeInt alias "GetThemeInt" (byval as HTHEME, byval as integer, byval as integer, byval as integer, byval as integer ptr) as HRESULT
declare function GetThemeIntList alias "GetThemeIntList" (byval as HTHEME, byval as integer, byval as integer, byval as integer, byval as INTLIST ptr) as HRESULT
declare function GetThemeMargins alias "GetThemeMargins" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as integer, byval as RECT ptr, byval as MARGINS ptr) as HRESULT
declare function GetThemeMetric alias "GetThemeMetric" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as integer, byval as integer ptr) as HRESULT
declare function GetThemePartSize alias "GetThemePartSize" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as RECT ptr, byval as THEME_SIZE, byval as SIZE ptr) as HRESULT
declare function GetThemePosition alias "GetThemePosition" (byval as HTHEME, byval as integer, byval as integer, byval as integer, byval as POINT ptr) as HRESULT
declare function GetThemePropertyOrigin alias "GetThemePropertyOrigin" (byval as HTHEME, byval as integer, byval as integer, byval as integer, byval as PROPERTYORIGIN ptr) as HRESULT
declare function GetThemeRect alias "GetThemeRect" (byval as HTHEME, byval as integer, byval as integer, byval as integer, byval as RECT ptr) as HRESULT
declare function GetThemeString alias "GetThemeString" (byval as HTHEME, byval as integer, byval as integer, byval as integer, byval as LPWSTR, byval as integer) as HRESULT
declare function GetThemeSysBool alias "GetThemeSysBool" (byval as HTHEME, byval as integer) as BOOL
declare function GetThemeSysColor alias "GetThemeSysColor" (byval as HTHEME, byval as integer) as COLORREF
declare function GetThemeSysColorBrush alias "GetThemeSysColorBrush" (byval as HTHEME, byval as integer) as HBRUSH
declare function GetThemeSysFont alias "GetThemeSysFont" (byval as HTHEME, byval as integer, byval as LOGFONT ptr) as HRESULT
declare function GetThemeSysInt alias "GetThemeSysInt" (byval as HTHEME, byval as integer, byval as integer ptr) as HRESULT
declare function GetThemeSysSize alias "GetThemeSysSize" (byval as HTHEME, byval as integer) as integer
declare function GetThemeSysString alias "GetThemeSysString" (byval as HTHEME, byval as integer, byval as LPWSTR, byval as integer) as HRESULT
declare function GetThemeTextExtent alias "GetThemeTextExtent" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as LPCWSTR, byval as integer, byval as DWORD, byval as RECT ptr, byval as RECT ptr) as HRESULT
declare function GetThemeTextMetrics alias "GetThemeTextMetrics" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as TEXTMETRIC ptr) as HRESULT
declare function GetWindowTheme alias "GetWindowTheme" (byval as HWND) as HTHEME
declare function HitTestThemeBackground alias "HitTestThemeBackground" (byval as HTHEME, byval as HDC, byval as integer, byval as integer, byval as DWORD, byval as RECT ptr, byval as HRGN, byval as POINT, byval as WORD ptr) as HRESULT
declare function IsAppThemed alias "IsAppThemed" () as BOOL
declare function IsThemeActive alias "IsThemeActive" () as BOOL
declare function IsThemeBackgroundPartiallyTransparent alias "IsThemeBackgroundPartiallyTransparent" (byval as HTHEME, byval as integer, byval as integer) as BOOL
declare function IsThemeDialogTextureEnabled alias "IsThemeDialogTextureEnabled" (byval as HWND) as BOOL
declare function IsThemePartDefined alias "IsThemePartDefined" (byval as HTHEME, byval as integer, byval as integer) as BOOL
declare function OpenThemeData alias "OpenThemeData" (byval as HWND, byval as LPCWSTR) as HTHEME
declare sub SetThemeAppProperties alias "SetThemeAppProperties" (byval as DWORD)
declare function SetWindowTheme alias "SetWindowTheme" (byval as HWND, byval as LPCWSTR, byval as LPCWSTR) as HRESULT

#endif
