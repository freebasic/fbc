'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "uxtheme"

#include once "commctrl.bi"

extern "Windows"

#define _UXTHEME_H_
type HTHEME as HANDLE

#if _WIN32_WINNT >= &h0601
	declare function BeginPanningFeedback(byval hwnd as HWND) as WINBOOL
	declare function UpdatePanningFeedback(byval hwnd as HWND, byval lTotalOverpanOffsetX as LONG, byval lTotalOverpanOffsetY as LONG, byval fInInertia as WINBOOL) as WINBOOL
	declare function EndPanningFeedback(byval hwnd as HWND, byval fAnimateBack as WINBOOL) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	const GBF_DIRECT = &h00000001
	const GBF_COPY = &h00000002
	const GBF_VALIDBITS = GBF_DIRECT or GBF_COPY

	declare function GetThemeBitmap(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval dwFlags as ULONG, byval phBitmap as HBITMAP ptr) as HRESULT
	declare function GetThemeStream(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval ppvStream as any ptr ptr, byval pcbStream as DWORD ptr, byval hInst as HINSTANCE) as HRESULT
	declare function GetThemeTransitionDuration(byval hTheme as HTHEME, byval iPartId as long, byval iStateIdFrom as long, byval iStateIdTo as long, byval iPropId as long, byval pdwDuration as DWORD ptr) as HRESULT

	type HPAINTBUFFER__
		unused as long
	end type

	type HPAINTBUFFER as HPAINTBUFFER__ ptr

	type _BP_BUFFERFORMAT as long
	enum
		BPBF_COMPATIBLEBITMAP
		BPBF_DIB
		BPBF_TOPDOWNDIB
		BPBF_TOPDOWNMONODIB
	end enum

	type BP_BUFFERFORMAT as _BP_BUFFERFORMAT
	const BPPF_ERASE = &h00000001
	const BPPF_NOCLIP = &h00000002
	const BPPF_NONCLIENT = &h00000004

	type _BP_PAINTPARAMS
		cbSize as DWORD
		dwFlags as DWORD
		prcExclude as const RECT ptr
		pBlendFunction as const BLENDFUNCTION ptr
	end type

	type BP_PAINTPARAMS as _BP_PAINTPARAMS
	type PBP_PAINTPARAMS as _BP_PAINTPARAMS ptr
	declare function BeginBufferedPaint(byval hdcTarget as HDC, byval prcTarget as const RECT ptr, byval dwFormat as BP_BUFFERFORMAT, byval pPaintParams as BP_PAINTPARAMS ptr, byval phdc as HDC ptr) as HPAINTBUFFER
	declare function EndBufferedPaint(byval hBufferedPaint as HPAINTBUFFER, byval fUpdateTarget as WINBOOL) as HRESULT
	declare function GetBufferedPaintTargetRect(byval hBufferedPaint as HPAINTBUFFER, byval prc as RECT ptr) as HRESULT
	declare function GetBufferedPaintTargetDC(byval hBufferedPaint as HPAINTBUFFER) as HDC
	declare function GetBufferedPaintDC(byval hBufferedPaint as HPAINTBUFFER) as HDC
	declare function GetBufferedPaintBits(byval hBufferedPaint as HPAINTBUFFER, byval ppbBuffer as RGBQUAD ptr ptr, byval pcxRow as long ptr) as HRESULT
	declare function BufferedPaintClear(byval hBufferedPaint as HPAINTBUFFER, byval prc as const RECT ptr) as HRESULT
	declare function BufferedPaintSetAlpha(byval hBufferedPaint as HPAINTBUFFER, byval prc as const RECT ptr, byval alpha as UBYTE) as HRESULT
	declare function BufferedPaintInit() as HRESULT
	declare function BufferedPaintUnInit() as HRESULT

	type HANIMATIONBUFFER__
		unused as long
	end type

	type HANIMATIONBUFFER as HANIMATIONBUFFER__ ptr

	type _BP_ANIMATIONSTYLE as long
	enum
		BPAS_NONE
		BPAS_LINEAR
		BPAS_CUBIC
		BPAS_SINE
	end enum

	type BP_ANIMATIONSTYLE as _BP_ANIMATIONSTYLE

	type _BP_ANIMATIONPARAMS
		cbSize as DWORD
		dwFlags as DWORD
		style as BP_ANIMATIONSTYLE
		dwDuration as DWORD
	end type

	type BP_ANIMATIONPARAMS as _BP_ANIMATIONPARAMS
	type PBP_ANIMATIONPARAMS as _BP_ANIMATIONPARAMS ptr
	declare function BeginBufferedAnimation(byval hwnd as HWND, byval hdcTarget as HDC, byval rcTarget as const RECT ptr, byval dwFormat as BP_BUFFERFORMAT, byval pPaintParams as BP_PAINTPARAMS ptr, byval pAnimationParams as BP_ANIMATIONPARAMS ptr, byval phdcFrom as HDC ptr, byval phdcTo as HDC ptr) as HANIMATIONBUFFER
	declare function EndBufferedAnimation(byval hbpAnimation as HANIMATIONBUFFER, byval fUpdateTarget as WINBOOL) as HRESULT
	declare function BufferedPaintRenderAnimation(byval hwnd as HWND, byval hdcTarget as HDC) as WINBOOL
	declare function BufferedPaintStopAllAnimations(byval hwnd as HWND) as HRESULT
	declare function IsCompositionActive() as WINBOOL

	type WINDOWTHEMEATTRIBUTETYPE as long
	enum
		WTA_NONCLIENT = 1
	end enum

	type WTA_OPTIONS
		dwFlags as DWORD
		dwMask as DWORD
	end type

	type PWTA_OPTIONS as WTA_OPTIONS ptr
	const WTNCA_NODRAWCAPTION = &h00000001
	const WTNCA_NODRAWICON = &h00000002
	const WTNCA_NOSYSMENU = &h00000004
	const WTNCA_NOMIRRORHELP = &h00000008
	const WTNCA_VALIDBITS = ((WTNCA_NODRAWCAPTION or WTNCA_NODRAWICON) or WTNCA_NOSYSMENU) or WTNCA_NOMIRRORHELP
	declare function SetWindowThemeAttribute(byval hwnd as HWND, byval eAttribute as WINDOWTHEMEATTRIBUTETYPE, byval pvAttribute as PVOID, byval cbAttribute as DWORD) as HRESULT

	private function SetWindowThemeNonClientAttributes cdecl(byval hwnd as HWND, byval dwMask as DWORD, byval dwAttributes as DWORD) as HRESULT
		dim wta as WTA_OPTIONS = (dwAttributes, dwMask)
		return SetWindowThemeAttribute(hwnd, WTA_NONCLIENT, @wta, sizeof(WTA_OPTIONS))
	end function
#endif

declare function OpenThemeData(byval hwnd as HWND, byval pszClassList as LPCWSTR) as HTHEME

#if _WIN32_WINNT >= &h0600
	const OTD_FORCE_RECT_SIZING = &h00000001
	const OTD_NONCLIENT = &h00000002
	const OTD_VALIDBITS = OTD_FORCE_RECT_SIZING or OTD_NONCLIENT
	declare function OpenThemeDataEx(byval hwnd as HWND, byval pszClassList as LPCWSTR, byval dwFlags as DWORD) as HTHEME
#endif

declare function CloseThemeData(byval hTheme as HTHEME) as HRESULT
declare function DrawThemeBackground(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval pRect as const RECT ptr, byval pClipRect as const RECT ptr) as HRESULT
const DTT_GRAYED = &h1
declare function DrawThemeText(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval pszText as LPCWSTR, byval iCharCount as long, byval dwTextFlags as DWORD, byval dwTextFlags2 as DWORD, byval pRect as const RECT ptr) as HRESULT

#if _WIN32_WINNT >= &h0600
	const DTT_TEXTCOLOR = culng(1u shl 0)
	const DTT_BORDERCOLOR = culng(1u shl 1)
	const DTT_SHADOWCOLOR = culng(1u shl 2)
	const DTT_SHADOWTYPE = culng(1u shl 3)
	const DTT_SHADOWOFFSET = culng(1u shl 4)
	const DTT_BORDERSIZE = culng(1u shl 5)
	const DTT_FONTPROP = culng(1u shl 6)
	const DTT_COLORPROP = culng(1u shl 7)
	const DTT_STATEID = culng(1u shl 8)
	const DTT_CALCRECT = culng(1u shl 9)
	const DTT_APPLYOVERLAY = culng(1u shl 10)
	const DTT_GLOWSIZE = culng(1u shl 11)
	const DTT_CALLBACK = culng(1u shl 12)
	const DTT_COMPOSITED = culng(1u shl 13)
	const DTT_VALIDBITS = culng(culng(culng(culng(culng(culng(culng(culng(culng(culng(culng(culng(DTT_TEXTCOLOR or DTT_BORDERCOLOR) or DTT_SHADOWCOLOR) or DTT_SHADOWTYPE) or DTT_SHADOWOFFSET) or DTT_BORDERSIZE) or DTT_FONTPROP) or DTT_COLORPROP) or DTT_STATEID) or DTT_CALCRECT) or DTT_APPLYOVERLAY) or DTT_GLOWSIZE) or DTT_COMPOSITED)
	type DTT_CALLBACK_PROC as function(byval hdc as HDC, byval pszText as LPWSTR, byval cchText as long, byval prc as LPRECT, byval dwFlags as UINT, byval lParam as LPARAM) as long

	type _DTTOPTS
		dwSize as DWORD
		dwFlags as DWORD
		crText as COLORREF
		crBorder as COLORREF
		crShadow as COLORREF
		iTextShadowType as long
		ptShadowOffset as POINT
		iBorderSize as long
		iFontPropId as long
		iColorPropId as long
		iStateId as long
		fApplyOverlay as WINBOOL
		iGlowSize as long
		pfnDrawTextCallback as DTT_CALLBACK_PROC
		lParam as LPARAM
	end type

	type DTTOPTS as _DTTOPTS
	type PDTTOPTS as _DTTOPTS ptr
	declare function DrawThemeTextEx(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval pszText as LPCWSTR, byval iCharCount as long, byval dwFlags as DWORD, byval pRect as LPRECT, byval pOptions as const DTTOPTS ptr) as HRESULT
#endif

declare function GetThemeBackgroundContentRect(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval pBoundingRect as const RECT ptr, byval pContentRect as RECT ptr) as HRESULT
declare function GetThemeBackgroundExtent(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval pContentRect as const RECT ptr, byval pExtentRect as RECT ptr) as HRESULT

type THEMESIZE as long
enum
	TS_MIN
	TS_TRUE
	TS_DRAW
end enum

declare function GetThemePartSize(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval prc as RECT ptr, byval eSize as THEMESIZE, byval psz as SIZE ptr) as HRESULT
declare function GetThemeTextExtent(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval pszText as LPCWSTR, byval iCharCount as long, byval dwTextFlags as DWORD, byval pBoundingRect as const RECT ptr, byval pExtentRect as RECT ptr) as HRESULT
declare function GetThemeTextMetrics(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval ptm as TEXTMETRIC ptr) as HRESULT
declare function GetThemeBackgroundRegion(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval pRect as const RECT ptr, byval pRegion as HRGN ptr) as HRESULT

const HTTB_BACKGROUNDSEG = &h0000
const HTTB_FIXEDBORDER = &h0002
const HTTB_CAPTION = &h0004
const HTTB_RESIZINGBORDER_LEFT = &h0010
const HTTB_RESIZINGBORDER_TOP = &h0020
const HTTB_RESIZINGBORDER_RIGHT = &h0040
const HTTB_RESIZINGBORDER_BOTTOM = &h0080
const HTTB_RESIZINGBORDER = ((HTTB_RESIZINGBORDER_LEFT or HTTB_RESIZINGBORDER_TOP) or HTTB_RESIZINGBORDER_RIGHT) or HTTB_RESIZINGBORDER_BOTTOM
const HTTB_SIZINGTEMPLATE = &h0100
const HTTB_SYSTEMSIZINGMARGINS = &h0200

declare function HitTestThemeBackground(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval dwOptions as DWORD, byval pRect as const RECT ptr, byval hrgn as HRGN, byval ptTest as POINT, byval pwHitTestCode as WORD ptr) as HRESULT
declare function DrawThemeEdge(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval pDestRect as const RECT ptr, byval uEdge as UINT, byval uFlags as UINT, byval pContentRect as RECT ptr) as HRESULT
declare function DrawThemeIcon(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval pRect as const RECT ptr, byval himl as HIMAGELIST, byval iImageIndex as long) as HRESULT
declare function IsThemePartDefined(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long) as WINBOOL
declare function IsThemeBackgroundPartiallyTransparent(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long) as WINBOOL
declare function GetThemeColor(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval pColor as COLORREF ptr) as HRESULT
declare function GetThemeMetric(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval piVal as long ptr) as HRESULT
declare function GetThemeString(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval pszBuff as LPWSTR, byval cchMaxBuffChars as long) as HRESULT
declare function GetThemeBool(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval pfVal as WINBOOL ptr) as HRESULT
declare function GetThemeInt(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval piVal as long ptr) as HRESULT
declare function GetThemeEnumValue(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval piVal as long ptr) as HRESULT
declare function GetThemePosition(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval pPoint as POINT ptr) as HRESULT
declare function GetThemeFont(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval pFont as LOGFONT ptr) as HRESULT
declare function GetThemeRect(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval pRect as RECT ptr) as HRESULT

type _MARGINS
	cxLeftWidth as long
	cxRightWidth as long
	cyTopHeight as long
	cyBottomHeight as long
end type

type MARGINS as _MARGINS
type PMARGINS as _MARGINS ptr
declare function GetThemeMargins(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval prc as RECT ptr, byval pMargins as MARGINS ptr) as HRESULT

#if _WIN32_WINNT <= &h0502
	const MAX_INTLIST_COUNT = 10
#else
	const MAX_INTLIST_COUNT = 402
#endif

type _INTLIST
	iValueCount as long

	#if _WIN32_WINNT <= &h0502
		iValues(0 to 9) as long
	#else
		iValues(0 to 401) as long
	#endif
end type

type INTLIST as _INTLIST
type PINTLIST as _INTLIST ptr
declare function GetThemeIntList(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval pIntList as INTLIST ptr) as HRESULT

type PROPERTYORIGIN as long
enum
	PO_STATE
	PO_PART
	PO_CLASS
	PO_GLOBAL
	PO_NOTFOUND
end enum

declare function GetThemePropertyOrigin(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval pOrigin as PROPERTYORIGIN ptr) as HRESULT
declare function SetWindowTheme(byval hwnd as HWND, byval pszSubAppName as LPCWSTR, byval pszSubIdList as LPCWSTR) as HRESULT
declare function GetThemeFilename(byval hTheme as HTHEME, byval iPartId as long, byval iStateId as long, byval iPropId as long, byval pszThemeFileName as LPWSTR, byval cchMaxBuffChars as long) as HRESULT
declare function GetThemeSysColor(byval hTheme as HTHEME, byval iColorId as long) as COLORREF
declare function GetThemeSysColorBrush(byval hTheme as HTHEME, byval iColorId as long) as HBRUSH
declare function GetThemeSysBool(byval hTheme as HTHEME, byval iBoolId as long) as WINBOOL
declare function GetThemeSysSize(byval hTheme as HTHEME, byval iSizeId as long) as long
declare function GetThemeSysFont(byval hTheme as HTHEME, byval iFontId as long, byval plf as LOGFONT ptr) as HRESULT
declare function GetThemeSysString(byval hTheme as HTHEME, byval iStringId as long, byval pszStringBuff as LPWSTR, byval cchMaxStringChars as long) as HRESULT
declare function GetThemeSysInt(byval hTheme as HTHEME, byval iIntId as long, byval piValue as long ptr) as HRESULT
declare function IsThemeActive() as WINBOOL
declare function IsAppThemed() as WINBOOL
declare function GetWindowTheme(byval hwnd as HWND) as HTHEME

const ETDT_DISABLE = &h00000001
const ETDT_ENABLE = &h00000002
const ETDT_USETABTEXTURE = &h00000004
const ETDT_ENABLETAB = ETDT_ENABLE or ETDT_USETABTEXTURE

#if _WIN32_WINNT >= &h0600
	const ETDT_USEAEROWIZARDTABTEXTURE = &h00000008
	const ETDT_ENABLEAEROWIZARDTAB = ETDT_ENABLE or ETDT_USEAEROWIZARDTABTEXTURE
	const ETDT_VALIDBITS = ((ETDT_DISABLE or ETDT_ENABLE) or ETDT_USETABTEXTURE) or ETDT_USEAEROWIZARDTABTEXTURE
#endif

declare function EnableThemeDialogTexture(byval hwnd as HWND, byval dwFlags as DWORD) as HRESULT
declare function IsThemeDialogTextureEnabled(byval hwnd as HWND) as WINBOOL
const STAP_ALLOW_NONCLIENT = 1 shl 0
const STAP_ALLOW_CONTROLS = 1 shl 1
const STAP_ALLOW_WEBCONTENT = 1 shl 2

declare function GetThemeAppProperties() as DWORD
declare sub SetThemeAppProperties(byval dwFlags as DWORD)
declare function GetCurrentThemeName(byval pszThemeFileName as LPWSTR, byval cchMaxNameChars as long, byval pszColorBuff as LPWSTR, byval cchMaxColorChars as long, byval pszSizeBuff as LPWSTR, byval cchMaxSizeChars as long) as HRESULT

#define SZ_THDOCPROP_DISPLAYNAME wstr("DisplayName")
#define SZ_THDOCPROP_CANONICALNAME wstr("ThemeName")
#define SZ_THDOCPROP_TOOLTIP wstr("ToolTip")
#define SZ_THDOCPROP_AUTHOR wstr("author")
declare function GetThemeDocumentationProperty(byval pszThemeName as LPCWSTR, byval pszPropertyName as LPCWSTR, byval pszValueBuff as LPWSTR, byval cchMaxValChars as long) as HRESULT
declare function DrawThemeParentBackground(byval hwnd as HWND, byval hdc as HDC, byval prc as RECT ptr) as HRESULT

#if _WIN32_WINNT >= &h0600
	const DTPB_WINDOWDC = &h00000001
	const DTPB_USECTLCOLORSTATIC = &h00000002
	const DTPB_USEERASEBKGND = &h00000004
	declare function DrawThemeParentBackgroundEx(byval hwnd as HWND, byval hdc as HDC, byval dwFlags as DWORD, byval prc as const RECT ptr) as HRESULT
#endif

declare function EnableTheming(byval fEnable as WINBOOL) as HRESULT
const DTBG_CLIPRECT = &h00000001
const DTBG_DRAWSOLID = &h00000002
const DTBG_OMITBORDER = &h00000004
const DTBG_OMITCONTENT = &h00000008
const DTBG_COMPUTINGREGION = &h00000010
const DTBG_MIRRORDC = &h00000020
const DTBG_NOMIRROR = &h00000040
const DTBG_VALIDBITS = (((((DTBG_CLIPRECT or DTBG_DRAWSOLID) or DTBG_OMITBORDER) or DTBG_OMITCONTENT) or DTBG_COMPUTINGREGION) or DTBG_MIRRORDC) or DTBG_NOMIRROR

type _DTBGOPTS
	dwSize as DWORD
	dwFlags as DWORD
	rcClip as RECT
end type

type DTBGOPTS as _DTBGOPTS
type PDTBGOPTS as _DTBGOPTS ptr
declare function DrawThemeBackgroundEx(byval hTheme as HTHEME, byval hdc as HDC, byval iPartId as long, byval iStateId as long, byval pRect as const RECT ptr, byval pOptions as const DTBGOPTS ptr) as HRESULT

end extern
