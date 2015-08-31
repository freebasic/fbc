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

#include once "_mingw_unicode.bi"

extern "Windows"

#define _PRSHT_H_
#define CCSIZEOF_STRUCT(structname, member) (clng(cast(LPBYTE, @cptr(structname ptr, 0)->member) - cast(LPBYTE, cptr(structname ptr, 0))) + sizeof(cptr(structname ptr, 0)->member))

#ifdef UNICODE
	declare function SNDMSG alias "SendMessageW"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#else
	declare function SNDMSG alias "SendMessageA"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

const MAXPROPPAGES = 100
type HPROPSHEETPAGE as _PSP ptr
type _PROPSHEETPAGEA as _PROPSHEETPAGEA_
type LPFNPSPCALLBACKA as function(byval hwnd as HWND, byval uMsg as UINT, byval ppsp as _PROPSHEETPAGEA ptr) as UINT
type _PROPSHEETPAGEW as _PROPSHEETPAGEW_
type LPFNPSPCALLBACKW as function(byval hwnd as HWND, byval uMsg as UINT, byval ppsp as _PROPSHEETPAGEW ptr) as UINT

#ifdef UNICODE
	type LPFNPSPCALLBACK as LPFNPSPCALLBACKW
#else
	type LPFNPSPCALLBACK as LPFNPSPCALLBACKA
#endif

const PSP_DEFAULT = &h00000000
const PSP_DLGINDIRECT = &h00000001
const PSP_USEHICON = &h00000002
const PSP_USEICONID = &h00000004
const PSP_USETITLE = &h00000008
const PSP_RTLREADING = &h00000010
const PSP_HASHELP = &h00000020
const PSP_USEREFPARENT = &h00000040
const PSP_USECALLBACK = &h00000080
const PSP_PREMATURE = &h00000400
const PSP_HIDEHEADER = &h00000800
const PSP_USEHEADERTITLE = &h00001000
const PSP_USEHEADERSUBTITLE = &h00002000
const PSP_USEFUSIONCONTEXT = &h00004000
const PSPCB_ADDREF = 0
const PSPCB_RELEASE = 1
const PSPCB_CREATE = 2
#define PROPSHEETPAGEA_V1_SIZE CCSIZEOF_STRUCT(PROPSHEETPAGEA, pcRefParent)
#define PROPSHEETPAGEW_V1_SIZE CCSIZEOF_STRUCT(PROPSHEETPAGEW, pcRefParent)
#define PROPSHEETPAGEA_V2_SIZE CCSIZEOF_STRUCT(PROPSHEETPAGEA, pszHeaderSubTitle)
#define PROPSHEETPAGEW_V2_SIZE CCSIZEOF_STRUCT(PROPSHEETPAGEW, pszHeaderSubTitle)
type PROPSHEETPAGE_RESOURCE as LPCDLGTEMPLATE

#ifdef __FB_64BIT__
	type _PROPSHEETPAGEA_V1
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union
			pszTemplate as LPCSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union
			hIcon as HICON
			pszIcon as LPCSTR
		end union

		pszTitle as LPCSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKA
		pcRefParent as UINT ptr
	end type
#else
	type _PROPSHEETPAGEA_V1 field = 4
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union field = 4
			pszTemplate as LPCSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union field = 4
			hIcon as HICON
			pszIcon as LPCSTR
		end union

		pszTitle as LPCSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKA
		pcRefParent as UINT ptr
	end type
#endif

type PROPSHEETPAGEA_V1 as _PROPSHEETPAGEA_V1
type LPPROPSHEETPAGEA_V1 as _PROPSHEETPAGEA_V1 ptr
type LPCPROPSHEETPAGEA_V1 as const PROPSHEETPAGEA_V1 ptr

#ifdef __FB_64BIT__
	type _PROPSHEETPAGEA_V2
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union
			pszTemplate as LPCSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union
			hIcon as HICON
			pszIcon as LPCSTR
		end union

		pszTitle as LPCSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKA
		pcRefParent as UINT ptr
		pszHeaderTitle as LPCSTR
		pszHeaderSubTitle as LPCSTR
	end type
#else
	type _PROPSHEETPAGEA_V2 field = 4
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union field = 4
			pszTemplate as LPCSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union field = 4
			hIcon as HICON
			pszIcon as LPCSTR
		end union

		pszTitle as LPCSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKA
		pcRefParent as UINT ptr
		pszHeaderTitle as LPCSTR
		pszHeaderSubTitle as LPCSTR
	end type
#endif

type PROPSHEETPAGEA_V2 as _PROPSHEETPAGEA_V2
type LPPROPSHEETPAGEA_V2 as _PROPSHEETPAGEA_V2 ptr
type LPCPROPSHEETPAGEA_V2 as const PROPSHEETPAGEA_V2 ptr

#ifdef __FB_64BIT__
	type _PROPSHEETPAGEA_
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union
			pszTemplate as LPCSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union
			hIcon as HICON
			pszIcon as LPCSTR
		end union

		pszTitle as LPCSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKA
		pcRefParent as UINT ptr
		pszHeaderTitle as LPCSTR
		pszHeaderSubTitle as LPCSTR
		hActCtx as HANDLE
	end type
#else
	type _PROPSHEETPAGEA_ field = 4
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union field = 4
			pszTemplate as LPCSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union field = 4
			hIcon as HICON
			pszIcon as LPCSTR
		end union

		pszTitle as LPCSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKA
		pcRefParent as UINT ptr
		pszHeaderTitle as LPCSTR
		pszHeaderSubTitle as LPCSTR
		hActCtx as HANDLE
	end type
#endif

type _PROPSHEETPAGEA_V3 as _PROPSHEETPAGEA
type PROPSHEETPAGEA_V3 as _PROPSHEETPAGEA
type LPPROPSHEETPAGEA_V3 as _PROPSHEETPAGEA ptr
type LPCPROPSHEETPAGEA_V3 as const PROPSHEETPAGEA_V3 ptr

#ifdef __FB_64BIT__
	type _PROPSHEETPAGEW_V1
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union
			pszTemplate as LPCWSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union
			hIcon as HICON
			pszIcon as LPCWSTR
		end union

		pszTitle as LPCWSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKW
		pcRefParent as UINT ptr
	end type
#else
	type _PROPSHEETPAGEW_V1 field = 4
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union field = 4
			pszTemplate as LPCWSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union field = 4
			hIcon as HICON
			pszIcon as LPCWSTR
		end union

		pszTitle as LPCWSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKW
		pcRefParent as UINT ptr
	end type
#endif

type PROPSHEETPAGEW_V1 as _PROPSHEETPAGEW_V1
type LPPROPSHEETPAGEW_V1 as _PROPSHEETPAGEW_V1 ptr
type LPCPROPSHEETPAGEW_V1 as const PROPSHEETPAGEW_V1 ptr

#ifdef __FB_64BIT__
	type _PROPSHEETPAGEW_V2
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union
			pszTemplate as LPCWSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union
			hIcon as HICON
			pszIcon as LPCWSTR
		end union

		pszTitle as LPCWSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKW
		pcRefParent as UINT ptr
		pszHeaderTitle as LPCWSTR
		pszHeaderSubTitle as LPCWSTR
	end type
#else
	type _PROPSHEETPAGEW_V2 field = 4
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union field = 4
			pszTemplate as LPCWSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union field = 4
			hIcon as HICON
			pszIcon as LPCWSTR
		end union

		pszTitle as LPCWSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKW
		pcRefParent as UINT ptr
		pszHeaderTitle as LPCWSTR
		pszHeaderSubTitle as LPCWSTR
	end type
#endif

type PROPSHEETPAGEW_V2 as _PROPSHEETPAGEW_V2
type LPPROPSHEETPAGEW_V2 as _PROPSHEETPAGEW_V2 ptr
type LPCPROPSHEETPAGEW_V2 as const PROPSHEETPAGEW_V2 ptr

#ifdef __FB_64BIT__
	type _PROPSHEETPAGEW_
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union
			pszTemplate as LPCWSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union
			hIcon as HICON
			pszIcon as LPCWSTR
		end union

		pszTitle as LPCWSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKW
		pcRefParent as UINT ptr
		pszHeaderTitle as LPCWSTR
		pszHeaderSubTitle as LPCWSTR
		hActCtx as HANDLE
	end type
#else
	type _PROPSHEETPAGEW_ field = 4
		dwSize as DWORD
		dwFlags as DWORD
		hInstance as HINSTANCE

		union field = 4
			pszTemplate as LPCWSTR
			pResource as PROPSHEETPAGE_RESOURCE
		end union

		union field = 4
			hIcon as HICON
			pszIcon as LPCWSTR
		end union

		pszTitle as LPCWSTR
		pfnDlgProc as DLGPROC
		lParam as LPARAM
		pfnCallback as LPFNPSPCALLBACKW
		pcRefParent as UINT ptr
		pszHeaderTitle as LPCWSTR
		pszHeaderSubTitle as LPCWSTR
		hActCtx as HANDLE
	end type
#endif

type _PROPSHEETPAGEW_V3 as _PROPSHEETPAGEW
type PROPSHEETPAGEW_V3 as _PROPSHEETPAGEW
type LPPROPSHEETPAGEW_V3 as _PROPSHEETPAGEW ptr
type LPCPROPSHEETPAGEW_V3 as const PROPSHEETPAGEW_V3 ptr
type PROPSHEETPAGEA_LATEST as PROPSHEETPAGEA_V3
type PROPSHEETPAGEW_LATEST as PROPSHEETPAGEW_V3
type LPPROPSHEETPAGEA_LATEST as LPPROPSHEETPAGEA_V3
type LPPROPSHEETPAGEW_LATEST as LPPROPSHEETPAGEW_V3
type LPCPROPSHEETPAGEA_LATEST as LPCPROPSHEETPAGEA_V3
type LPCPROPSHEETPAGEW_LATEST as LPCPROPSHEETPAGEW_V3
type PROPSHEETPAGEA as PROPSHEETPAGEA_V3
type PROPSHEETPAGEW as PROPSHEETPAGEW_V3
type LPPROPSHEETPAGEA as LPPROPSHEETPAGEA_V3
type LPPROPSHEETPAGEW as LPPROPSHEETPAGEW_V3
type LPCPROPSHEETPAGEA as LPCPROPSHEETPAGEA_V3
type LPCPROPSHEETPAGEW as LPCPROPSHEETPAGEW_V3

#ifdef UNICODE
	type PROPSHEETPAGE as PROPSHEETPAGEW
	type LPPROPSHEETPAGE as LPPROPSHEETPAGEW
	type LPCPROPSHEETPAGE as LPCPROPSHEETPAGEW
	#define PROPSHEETPAGE_V1_SIZE PROPSHEETPAGEW_V1_SIZE
	#define PROPSHEETPAGE_V2_SIZE PROPSHEETPAGEW_V2_SIZE
	type PROPSHEETPAGE_V1 as PROPSHEETPAGEW_V1
	type LPPROPSHEETPAGE_V1 as LPPROPSHEETPAGEW_V1
	type LPCPROPSHEETPAGE_V1 as LPCPROPSHEETPAGEW_V1
	type PROPSHEETPAGE_V2 as PROPSHEETPAGEW_V2
	type LPPROPSHEETPAGE_V2 as LPPROPSHEETPAGEW_V2
	type LPCPROPSHEETPAGE_V2 as LPCPROPSHEETPAGEW_V2
	type PROPSHEETPAGE_V3 as PROPSHEETPAGEW_V3
	type LPPROPSHEETPAGE_V3 as LPPROPSHEETPAGEW_V3
	type LPCPROPSHEETPAGE_V3 as LPCPROPSHEETPAGEW_V3
	type PROPSHEETPAGE_LATEST as PROPSHEETPAGEW_LATEST
	type LPPROPSHEETPAGE_LATEST as LPPROPSHEETPAGEW_LATEST
	type LPCPROPSHEETPAGE_LATEST as LPCPROPSHEETPAGEW_LATEST
#else
	type PROPSHEETPAGE as PROPSHEETPAGEA
	type LPPROPSHEETPAGE as LPPROPSHEETPAGEA
	type LPCPROPSHEETPAGE as LPCPROPSHEETPAGEA
	#define PROPSHEETPAGE_V1_SIZE PROPSHEETPAGEA_V1_SIZE
	#define PROPSHEETPAGE_V2_SIZE PROPSHEETPAGEA_V2_SIZE
	type PROPSHEETPAGE_V1 as PROPSHEETPAGEA_V1
	type LPPROPSHEETPAGE_V1 as LPPROPSHEETPAGEA_V1
	type LPCPROPSHEETPAGE_V1 as LPCPROPSHEETPAGEA_V1
	type PROPSHEETPAGE_V2 as PROPSHEETPAGEA_V2
	type LPPROPSHEETPAGE_V2 as LPPROPSHEETPAGEA_V2
	type LPCPROPSHEETPAGE_V2 as LPCPROPSHEETPAGEA_V2
	type PROPSHEETPAGE_V3 as PROPSHEETPAGEA_V3
	type LPPROPSHEETPAGE_V3 as LPPROPSHEETPAGEA_V3
	type LPCPROPSHEETPAGE_V3 as LPCPROPSHEETPAGEA_V3
	type PROPSHEETPAGE_LATEST as PROPSHEETPAGEA_LATEST
	type LPPROPSHEETPAGE_LATEST as LPPROPSHEETPAGEA_LATEST
	type LPCPROPSHEETPAGE_LATEST as LPCPROPSHEETPAGEA_LATEST
#endif

const PSH_DEFAULT = &h00000000
const PSH_PROPTITLE = &h00000001
const PSH_USEHICON = &h00000002
const PSH_USEICONID = &h00000004
const PSH_PROPSHEETPAGE = &h00000008
const PSH_WIZARDHASFINISH = &h00000010
const PSH_WIZARD = &h00000020
const PSH_USEPSTARTPAGE = &h00000040
const PSH_NOAPPLYNOW = &h00000080
const PSH_USECALLBACK = &h00000100
const PSH_HASHELP = &h00000200
const PSH_MODELESS = &h00000400
const PSH_RTLREADING = &h00000800
const PSH_WIZARDCONTEXTHELP = &h00001000
const PSH_WIZARD97 = &h01000000
const PSH_WATERMARK = &h00008000
const PSH_USEHBMWATERMARK = &h00010000
const PSH_USEHPLWATERMARK = &h00020000
const PSH_STRETCHWATERMARK = &h00040000
const PSH_HEADER = &h00080000
const PSH_USEHBMHEADER = &h00100000
const PSH_USEPAGELANG = &h00200000
const PSH_WIZARD_LITE = &h00400000
const PSH_NOCONTEXTHELP = &h02000000
type PFNPROPSHEETCALLBACK as function(byval as HWND, byval as UINT, byval as LPARAM) as long
#define PROPSHEETHEADERA_V1_SIZE CCSIZEOF_STRUCT(PROPSHEETHEADERA, pfnCallback)
#define PROPSHEETHEADERW_V1_SIZE CCSIZEOF_STRUCT(PROPSHEETHEADERW, pfnCallback)
#define PROPSHEETHEADERA_V2_SIZE CCSIZEOF_STRUCT(PROPSHEETHEADERA, DUMMYUNION5_MEMBER(hbmHeader))
#define PROPSHEETHEADERW_V2_SIZE CCSIZEOF_STRUCT(PROPSHEETHEADERW, DUMMYUNION5_MEMBER(hbmHeader))

#ifdef __FB_64BIT__
	type _PROPSHEETHEADERA
		dwSize as DWORD
		dwFlags as DWORD
		hwndParent as HWND
		hInstance as HINSTANCE

		union
			hIcon as HICON
			pszIcon as LPCSTR
		end union

		pszCaption as LPCSTR
		nPages as UINT

		union
			nStartPage as UINT
			pStartPage as LPCSTR
		end union

		union
			ppsp as LPCPROPSHEETPAGEA
			phpage as HPROPSHEETPAGE ptr
		end union

		pfnCallback as PFNPROPSHEETCALLBACK

		union
			hbmWatermark as HBITMAP
			pszbmWatermark as LPCSTR
		end union

		hplWatermark as HPALETTE

		union
			hbmHeader as HBITMAP
			pszbmHeader as LPCSTR
		end union
	end type
#else
	type _PROPSHEETHEADERA field = 4
		dwSize as DWORD
		dwFlags as DWORD
		hwndParent as HWND
		hInstance as HINSTANCE

		union field = 4
			hIcon as HICON
			pszIcon as LPCSTR
		end union

		pszCaption as LPCSTR
		nPages as UINT

		union field = 4
			nStartPage as UINT
			pStartPage as LPCSTR
		end union

		union field = 4
			ppsp as LPCPROPSHEETPAGEA
			phpage as HPROPSHEETPAGE ptr
		end union

		pfnCallback as PFNPROPSHEETCALLBACK

		union field = 4
			hbmWatermark as HBITMAP
			pszbmWatermark as LPCSTR
		end union

		hplWatermark as HPALETTE

		union field = 4
			hbmHeader as HBITMAP
			pszbmHeader as LPCSTR
		end union
	end type
#endif

type PROPSHEETHEADERA as _PROPSHEETHEADERA
type LPPROPSHEETHEADERA as _PROPSHEETHEADERA ptr
type LPCPROPSHEETHEADERA as const PROPSHEETHEADERA ptr

#ifdef __FB_64BIT__
	type _PROPSHEETHEADERW
		dwSize as DWORD
		dwFlags as DWORD
		hwndParent as HWND
		hInstance as HINSTANCE

		union
			hIcon as HICON
			pszIcon as LPCWSTR
		end union

		pszCaption as LPCWSTR
		nPages as UINT

		union
			nStartPage as UINT
			pStartPage as LPCWSTR
		end union

		union
			ppsp as LPCPROPSHEETPAGEW
			phpage as HPROPSHEETPAGE ptr
		end union

		pfnCallback as PFNPROPSHEETCALLBACK

		union
			hbmWatermark as HBITMAP
			pszbmWatermark as LPCWSTR
		end union

		hplWatermark as HPALETTE

		union
			hbmHeader as HBITMAP
			pszbmHeader as LPCWSTR
		end union
	end type
#else
	type _PROPSHEETHEADERW field = 4
		dwSize as DWORD
		dwFlags as DWORD
		hwndParent as HWND
		hInstance as HINSTANCE

		union field = 4
			hIcon as HICON
			pszIcon as LPCWSTR
		end union

		pszCaption as LPCWSTR
		nPages as UINT

		union field = 4
			nStartPage as UINT
			pStartPage as LPCWSTR
		end union

		union field = 4
			ppsp as LPCPROPSHEETPAGEW
			phpage as HPROPSHEETPAGE ptr
		end union

		pfnCallback as PFNPROPSHEETCALLBACK

		union field = 4
			hbmWatermark as HBITMAP
			pszbmWatermark as LPCWSTR
		end union

		hplWatermark as HPALETTE

		union field = 4
			hbmHeader as HBITMAP
			pszbmHeader as LPCWSTR
		end union
	end type
#endif

type PROPSHEETHEADERW as _PROPSHEETHEADERW
type LPPROPSHEETHEADERW as _PROPSHEETHEADERW ptr
type LPCPROPSHEETHEADERW as const PROPSHEETHEADERW ptr

#ifdef UNICODE
	type PROPSHEETHEADER as PROPSHEETHEADERW
	type LPPROPSHEETHEADER as LPPROPSHEETHEADERW
	type LPCPROPSHEETHEADER as LPCPROPSHEETHEADERW
	#define PROPSHEETHEADER_V1_SIZE PROPSHEETHEADERW_V1_SIZE
	#define PROPSHEETHEADER_V2_SIZE PROPSHEETHEADERW_V2_SIZE
#else
	type PROPSHEETHEADER as PROPSHEETHEADERA
	type LPPROPSHEETHEADER as LPPROPSHEETHEADERA
	type LPCPROPSHEETHEADER as LPCPROPSHEETHEADERA
	#define PROPSHEETHEADER_V1_SIZE PROPSHEETHEADERA_V1_SIZE
	#define PROPSHEETHEADER_V2_SIZE PROPSHEETHEADERA_V2_SIZE
#endif

const PSCB_INITIALIZED = 1
const PSCB_PRECREATE = 2
const PSCB_BUTTONPRESSED = 3

declare function CreatePropertySheetPageA(byval constPropSheetPagePointer as LPCPROPSHEETPAGEA) as HPROPSHEETPAGE
declare function CreatePropertySheetPageW(byval constPropSheetPagePointer as LPCPROPSHEETPAGEW) as HPROPSHEETPAGE
declare function DestroyPropertySheetPage(byval as HPROPSHEETPAGE) as WINBOOL
declare function PropertySheetA(byval as LPCPROPSHEETHEADERA) as INT_PTR
declare function PropertySheetW(byval as LPCPROPSHEETHEADERW) as INT_PTR

#ifdef UNICODE
	declare function CreatePropertySheetPage alias "CreatePropertySheetPageW"(byval constPropSheetPagePointer as LPCPROPSHEETPAGEW) as HPROPSHEETPAGE
	declare function PropertySheet alias "PropertySheetW"(byval as LPCPROPSHEETHEADERW) as INT_PTR
#else
	declare function CreatePropertySheetPage alias "CreatePropertySheetPageA"(byval constPropSheetPagePointer as LPCPROPSHEETPAGEA) as HPROPSHEETPAGE
	declare function PropertySheet alias "PropertySheetA"(byval as LPCPROPSHEETHEADERA) as INT_PTR
#endif

type LPFNADDPROPSHEETPAGE as function(byval as HPROPSHEETPAGE, byval as LPARAM) as WINBOOL
type LPFNADDPROPSHEETPAGES as function(byval as LPVOID, byval as LPFNADDPROPSHEETPAGE, byval as LPARAM) as WINBOOL

#ifdef __FB_64BIT__
	type _PSHNOTIFY
		hdr as NMHDR
		lParam as LPARAM
	end type
#else
	type _PSHNOTIFY field = 4
		hdr as NMHDR
		lParam as LPARAM
	end type
#endif

type PSHNOTIFY as _PSHNOTIFY
type LPPSHNOTIFY as _PSHNOTIFY ptr
const PSN_FIRST = culng(0u - 200u)
const PSN_LAST = culng(0u - 299u)
const PSN_SETACTIVE = culng(PSN_FIRST - 0)
const PSN_KILLACTIVE = culng(PSN_FIRST - 1)
const PSN_APPLY = culng(PSN_FIRST - 2)
const PSN_RESET = culng(PSN_FIRST - 3)
const PSN_HELP = culng(PSN_FIRST - 5)
const PSN_WIZBACK = culng(PSN_FIRST - 6)
const PSN_WIZNEXT = culng(PSN_FIRST - 7)
const PSN_WIZFINISH = culng(PSN_FIRST - 8)
const PSN_QUERYCANCEL = culng(PSN_FIRST - 9)
const PSN_GETOBJECT = culng(PSN_FIRST - 10)
const PSN_TRANSLATEACCELERATOR = culng(PSN_FIRST - 12)
const PSN_QUERYINITIALFOCUS = culng(PSN_FIRST - 13)
const PSNRET_NOERROR = 0
const PSNRET_INVALID = 1
const PSNRET_INVALID_NOCHANGEPAGE = 2
const PSNRET_MESSAGEHANDLED = 3
const PSM_SETCURSEL = WM_USER + 101
#define PropSheet_SetCurSel(hDlg, hpage, index) SNDMSG(hDlg, PSM_SETCURSEL, cast(WPARAM, index), cast(LPARAM, hpage))
const PSM_REMOVEPAGE = WM_USER + 102
#define PropSheet_RemovePage(hDlg, index, hpage) SNDMSG(hDlg, PSM_REMOVEPAGE, index, cast(LPARAM, hpage))
const PSM_ADDPAGE = WM_USER + 103
#define PropSheet_AddPage(hDlg, hpage) SNDMSG(hDlg, PSM_ADDPAGE, 0, cast(LPARAM, hpage))
const PSM_CHANGED = WM_USER + 104
#define PropSheet_Changed(hDlg, hwnd) SNDMSG(hDlg, PSM_CHANGED, cast(WPARAM, hwnd), cast(LPARAM, 0))
const PSM_RESTARTWINDOWS = WM_USER + 105
#define PropSheet_RestartWindows(hDlg) SNDMSG(hDlg, PSM_RESTARTWINDOWS, cast(WPARAM, 0), cast(LPARAM, 0))
const PSM_REBOOTSYSTEM = WM_USER + 106
#define PropSheet_RebootSystem(hDlg) SNDMSG(hDlg, PSM_REBOOTSYSTEM, cast(WPARAM, 0), cast(LPARAM, 0))
const PSM_CANCELTOCLOSE = WM_USER + 107
#define PropSheet_CancelToClose(hDlg) PostMessage(hDlg, PSM_CANCELTOCLOSE, cast(WPARAM, 0), cast(LPARAM, 0))
const PSM_QUERYSIBLINGS = WM_USER + 108
#define PropSheet_QuerySiblings(hDlg, wParam, lParam) SNDMSG(hDlg, PSM_QUERYSIBLINGS, wParam, lParam)
const PSM_UNCHANGED = WM_USER + 109
#define PropSheet_UnChanged(hDlg, hwnd) SNDMSG(hDlg, PSM_UNCHANGED, cast(WPARAM, hwnd), cast(LPARAM, 0))
const PSM_APPLY = WM_USER + 110
#define PropSheet_Apply(hDlg) SNDMSG(hDlg, PSM_APPLY, cast(WPARAM, 0), cast(LPARAM, 0))
const PSM_SETTITLEA = WM_USER + 111
const PSM_SETTITLEW = WM_USER + 120

#ifdef UNICODE
	const PSM_SETTITLE = PSM_SETTITLEW
#else
	const PSM_SETTITLE = PSM_SETTITLEA
#endif

#define PropSheet_SetTitle(hDlg, wStyle, lpszText) SNDMSG(hDlg, PSM_SETTITLE, wStyle, cast(LPARAM, cast(LPCTSTR, (lpszText))))
const PSM_SETWIZBUTTONS = WM_USER + 112
#define PropSheet_SetWizButtons(hDlg, dwFlags) PostMessage(hDlg, PSM_SETWIZBUTTONS, cast(WPARAM, 0), cast(LPARAM, dwFlags))
const PSWIZB_BACK = &h00000001
const PSWIZB_NEXT = &h00000002
const PSWIZB_FINISH = &h00000004
const PSWIZB_DISABLEDFINISH = &h00000008
const PSM_PRESSBUTTON = WM_USER + 113
#define PropSheet_PressButton(hDlg, iButton) PostMessage(hDlg, PSM_PRESSBUTTON, cast(WPARAM, iButton), cast(LPARAM, 0))
const PSBTN_BACK = 0
const PSBTN_NEXT = 1
const PSBTN_FINISH = 2
const PSBTN_OK = 3
const PSBTN_APPLYNOW = 4
const PSBTN_CANCEL = 5
const PSBTN_HELP = 6
const PSBTN_MAX = 6
const PSM_SETCURSELID = WM_USER + 114
#define PropSheet_SetCurSelByID(hDlg, id) SNDMSG(hDlg, PSM_SETCURSELID, 0, cast(LPARAM, id))
const PSM_SETFINISHTEXTA = WM_USER + 115
const PSM_SETFINISHTEXTW = WM_USER + 121

#ifdef UNICODE
	const PSM_SETFINISHTEXT = PSM_SETFINISHTEXTW
#else
	const PSM_SETFINISHTEXT = PSM_SETFINISHTEXTA
#endif

#define PropSheet_SetFinishText(hDlg, lpszText) SNDMSG(hDlg, PSM_SETFINISHTEXT, 0, cast(LPARAM, lpszText))
const PSM_GETTABCONTROL = WM_USER + 116
#define PropSheet_GetTabControl(hDlg) cast(HWND, SNDMSG(hDlg, PSM_GETTABCONTROL, 0, 0))
const PSM_ISDIALOGMESSAGE = WM_USER + 117
#define PropSheet_IsDialogMessage(hDlg, pMsg) cast(WINBOOL, SNDMSG(hDlg, PSM_ISDIALOGMESSAGE, 0, cast(LPARAM, pMsg)))
const PSM_GETCURRENTPAGEHWND = WM_USER + 118
#define PropSheet_GetCurrentPageHwnd(hDlg) cast(HWND, SNDMSG(hDlg, PSM_GETCURRENTPAGEHWND, cast(WPARAM, 0), cast(LPARAM, 0)))
const PSM_INSERTPAGE = WM_USER + 119
#define PropSheet_InsertPage(hDlg, index, hpage) SNDMSG(hDlg, PSM_INSERTPAGE, cast(WPARAM, (index)), cast(LPARAM, (hpage)))
const PSM_SETHEADERTITLEA = WM_USER + 125
const PSM_SETHEADERTITLEW = WM_USER + 126

#ifdef UNICODE
	const PSM_SETHEADERTITLE = PSM_SETHEADERTITLEW
#else
	const PSM_SETHEADERTITLE = PSM_SETHEADERTITLEA
#endif

#define PropSheet_SetHeaderTitle(hDlg, index, lpszText) SNDMSG(hDlg, PSM_SETHEADERTITLE, cast(WPARAM, (index)), cast(LPARAM, (lpszText)))
const PSM_SETHEADERSUBTITLEA = WM_USER + 127
const PSM_SETHEADERSUBTITLEW = WM_USER + 128

#ifdef UNICODE
	const PSM_SETHEADERSUBTITLE = PSM_SETHEADERSUBTITLEW
#else
	const PSM_SETHEADERSUBTITLE = PSM_SETHEADERSUBTITLEA
#endif

#define PropSheet_SetHeaderSubTitle(hDlg, index, lpszText) SNDMSG(hDlg, PSM_SETHEADERSUBTITLE, cast(WPARAM, (index)), cast(LPARAM, (lpszText)))
const PSM_HWNDTOINDEX = WM_USER + 129
#define PropSheet_HwndToIndex(hDlg, hwnd) clng(SNDMSG(hDlg, PSM_HWNDTOINDEX, cast(WPARAM, (hwnd)), 0))
const PSM_INDEXTOHWND = WM_USER + 130
#define PropSheet_IndexToHwnd(hDlg, i) cast(HWND, SNDMSG(hDlg, PSM_INDEXTOHWND, cast(WPARAM, (i)), 0))
const PSM_PAGETOINDEX = WM_USER + 131
#define PropSheet_PageToIndex(hDlg, hpage) clng(SNDMSG(hDlg, PSM_PAGETOINDEX, 0, cast(LPARAM, (hpage))))
const PSM_INDEXTOPAGE = WM_USER + 132
#define PropSheet_IndexToPage(hDlg, i) cast(HPROPSHEETPAGE, SNDMSG(hDlg, PSM_INDEXTOPAGE, cast(WPARAM, (i)), 0))
const PSM_IDTOINDEX = WM_USER + 133
#define PropSheet_IdToIndex(hDlg, id) clng(SNDMSG(hDlg, PSM_IDTOINDEX, 0, cast(LPARAM, (id))))
const PSM_INDEXTOID = WM_USER + 134
#define PropSheet_IndexToId(hDlg, i) SNDMSG(hDlg, PSM_INDEXTOID, cast(WPARAM, (i)), 0)
const PSM_GETRESULT = WM_USER + 135
#define PropSheet_GetResult(hDlg) SNDMSG(hDlg, PSM_GETRESULT, 0, 0)
const PSM_RECALCPAGESIZES = WM_USER + 136
#define PropSheet_RecalcPageSizes(hDlg) SNDMSG(hDlg, PSM_RECALCPAGESIZES, 0, 0)
const ID_PSRESTARTWINDOWS = &h2
const ID_PSREBOOTSYSTEM = ID_PSRESTARTWINDOWS or &h1
const WIZ_CXDLG = 276
const WIZ_CYDLG = 140
const WIZ_CXBMP = 80
const WIZ_BODYX = 92
const WIZ_BODYCX = 184
const PROP_SM_CXDLG = 212
const PROP_SM_CYDLG = 188
const PROP_MED_CXDLG = 227
const PROP_MED_CYDLG = 215
const PROP_LG_CXDLG = 252
const PROP_LG_CYDLG = 218

end extern
