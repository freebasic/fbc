#pragma once

#include once "_mingw_unicode.bi"

extern "Windows"

#define _PRSHT_H_
#define CCSIZEOF_STRUCT(structname, member) (clng(cast(LPBYTE, @cptr(structname ptr, 0)->member) - cast(LPBYTE, cptr(structname ptr, 0))) + sizeof(cptr(structname ptr, 0)->member))
#define SNDMSG SendMessage
#define MAXPROPPAGES 100

type HPROPSHEETPAGE as _PSP ptr

type _PROPSHEETPAGEA as _PROPSHEETPAGEA_

type LPFNPSPCALLBACKA as function(byval hwnd as HWND, byval uMsg as UINT, byval ppsp as _PROPSHEETPAGEA ptr) as UINT

type _PROPSHEETPAGEW as _PROPSHEETPAGEW_

type LPFNPSPCALLBACKW as function(byval hwnd as HWND, byval uMsg as UINT, byval ppsp as _PROPSHEETPAGEW ptr) as UINT

#ifdef UNICODE
	#define LPFNPSPCALLBACK LPFNPSPCALLBACKW
#else
	#define LPFNPSPCALLBACK LPFNPSPCALLBACKA
#endif

#define PSP_DEFAULT &h00000000
#define PSP_DLGINDIRECT &h00000001
#define PSP_USEHICON &h00000002
#define PSP_USEICONID &h00000004
#define PSP_USETITLE &h00000008
#define PSP_RTLREADING &h00000010
#define PSP_HASHELP &h00000020
#define PSP_USEREFPARENT &h00000040
#define PSP_USECALLBACK &h00000080
#define PSP_PREMATURE &h00000400
#define PSP_HIDEHEADER &h00000800
#define PSP_USEHEADERTITLE &h00001000
#define PSP_USEHEADERSUBTITLE &h00002000
#define PSP_USEFUSIONCONTEXT &h00004000
#define PSPCB_ADDREF 0
#define PSPCB_RELEASE 1
#define PSPCB_CREATE 2
#define PROPSHEETPAGEA_V1_SIZE CCSIZEOF_STRUCT(PROPSHEETPAGEA, pcRefParent)
#define PROPSHEETPAGEW_V1_SIZE CCSIZEOF_STRUCT(PROPSHEETPAGEW, pcRefParent)
#define PROPSHEETPAGEA_V2_SIZE CCSIZEOF_STRUCT(PROPSHEETPAGEA, pszHeaderSubTitle)
#define PROPSHEETPAGEW_V2_SIZE CCSIZEOF_STRUCT(PROPSHEETPAGEW, pszHeaderSubTitle)

type PROPSHEETPAGE_RESOURCE as LPCDLGTEMPLATE

#define _PROPSHEETPAGEA_V3 _PROPSHEETPAGEA
#define _PROPSHEETPAGEW_V3 _PROPSHEETPAGEW

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
	#define PROPSHEETPAGE PROPSHEETPAGEW
	#define LPPROPSHEETPAGE LPPROPSHEETPAGEW
	#define LPCPROPSHEETPAGE LPCPROPSHEETPAGEW
	#define PROPSHEETPAGE_V1_SIZE PROPSHEETPAGEW_V1_SIZE
	#define PROPSHEETPAGE_V2_SIZE PROPSHEETPAGEW_V2_SIZE
	#define PROPSHEETPAGE_V1 PROPSHEETPAGEW_V1
	#define LPPROPSHEETPAGE_V1 LPPROPSHEETPAGEW_V1
	#define LPCPROPSHEETPAGE_V1 LPCPROPSHEETPAGEW_V1
	#define PROPSHEETPAGE_V2 PROPSHEETPAGEW_V2
	#define LPPROPSHEETPAGE_V2 LPPROPSHEETPAGEW_V2
	#define LPCPROPSHEETPAGE_V2 LPCPROPSHEETPAGEW_V2
	#define PROPSHEETPAGE_V3 PROPSHEETPAGEW_V3
	#define LPPROPSHEETPAGE_V3 LPPROPSHEETPAGEW_V3
	#define LPCPROPSHEETPAGE_V3 LPCPROPSHEETPAGEW_V3
	#define PROPSHEETPAGE_LATEST PROPSHEETPAGEW_LATEST
	#define LPPROPSHEETPAGE_LATEST LPPROPSHEETPAGEW_LATEST
	#define LPCPROPSHEETPAGE_LATEST LPCPROPSHEETPAGEW_LATEST
#else
	#define PROPSHEETPAGE PROPSHEETPAGEA
	#define LPPROPSHEETPAGE LPPROPSHEETPAGEA
	#define LPCPROPSHEETPAGE LPCPROPSHEETPAGEA
	#define PROPSHEETPAGE_V1_SIZE PROPSHEETPAGEA_V1_SIZE
	#define PROPSHEETPAGE_V2_SIZE PROPSHEETPAGEA_V2_SIZE
	#define PROPSHEETPAGE_V1 PROPSHEETPAGEA_V1
	#define LPPROPSHEETPAGE_V1 LPPROPSHEETPAGEA_V1
	#define LPCPROPSHEETPAGE_V1 LPCPROPSHEETPAGEA_V1
	#define PROPSHEETPAGE_V2 PROPSHEETPAGEA_V2
	#define LPPROPSHEETPAGE_V2 LPPROPSHEETPAGEA_V2
	#define LPCPROPSHEETPAGE_V2 LPCPROPSHEETPAGEA_V2
	#define PROPSHEETPAGE_V3 PROPSHEETPAGEA_V3
	#define LPPROPSHEETPAGE_V3 LPPROPSHEETPAGEA_V3
	#define LPCPROPSHEETPAGE_V3 LPCPROPSHEETPAGEA_V3
	#define PROPSHEETPAGE_LATEST PROPSHEETPAGEA_LATEST
	#define LPPROPSHEETPAGE_LATEST LPPROPSHEETPAGEA_LATEST
	#define LPCPROPSHEETPAGE_LATEST LPCPROPSHEETPAGEA_LATEST
#endif

#define PSH_DEFAULT &h00000000
#define PSH_PROPTITLE &h00000001
#define PSH_USEHICON &h00000002
#define PSH_USEICONID &h00000004
#define PSH_PROPSHEETPAGE &h00000008
#define PSH_WIZARDHASFINISH &h00000010
#define PSH_WIZARD &h00000020
#define PSH_USEPSTARTPAGE &h00000040
#define PSH_NOAPPLYNOW &h00000080
#define PSH_USECALLBACK &h00000100
#define PSH_HASHELP &h00000200
#define PSH_MODELESS &h00000400
#define PSH_RTLREADING &h00000800
#define PSH_WIZARDCONTEXTHELP &h00001000
#define PSH_WIZARD97 &h01000000
#define PSH_WATERMARK &h00008000
#define PSH_USEHBMWATERMARK &h00010000
#define PSH_USEHPLWATERMARK &h00020000
#define PSH_STRETCHWATERMARK &h00040000
#define PSH_HEADER &h00080000
#define PSH_USEHBMHEADER &h00100000
#define PSH_USEPAGELANG &h00200000
#define PSH_WIZARD_LITE &h00400000
#define PSH_NOCONTEXTHELP &h02000000

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
	#define PROPSHEETHEADER PROPSHEETHEADERW
	#define LPCPROPSHEETHEADER LPCPROPSHEETHEADERW
	#define PROPSHEETHEADER_V1_SIZE PROPSHEETHEADERW_V1_SIZE
	#define PROPSHEETHEADER_V2_SIZE PROPSHEETHEADERW_V2_SIZE
#else
	#define PROPSHEETHEADER PROPSHEETHEADERA
	#define LPCPROPSHEETHEADER LPCPROPSHEETHEADERA
	#define PROPSHEETHEADER_V1_SIZE PROPSHEETHEADERA_V1_SIZE
	#define PROPSHEETHEADER_V2_SIZE PROPSHEETHEADERA_V2_SIZE
#endif

#define PSCB_INITIALIZED 1
#define PSCB_PRECREATE 2
#define PSCB_BUTTONPRESSED 3

declare function CreatePropertySheetPageA(byval constPropSheetPagePointer as LPCPROPSHEETPAGEA) as HPROPSHEETPAGE
declare function CreatePropertySheetPageW(byval constPropSheetPagePointer as LPCPROPSHEETPAGEW) as HPROPSHEETPAGE
declare function DestroyPropertySheetPage(byval as HPROPSHEETPAGE) as WINBOOL
declare function PropertySheetA(byval as LPCPROPSHEETHEADERA) as INT_PTR
declare function PropertySheetW(byval as LPCPROPSHEETHEADERW) as INT_PTR

#ifdef UNICODE
	#define CreatePropertySheetPage CreatePropertySheetPageW
	#define PropertySheet PropertySheetW
#else
	#define CreatePropertySheetPage CreatePropertySheetPageA
	#define PropertySheet PropertySheetA
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

#define PSN_FIRST culng(0u - 200u)
#define PSN_LAST culng(0u - 299u)
#define PSN_SETACTIVE culng(PSN_FIRST - 0)
#define PSN_KILLACTIVE culng(PSN_FIRST - 1)
#define PSN_APPLY culng(PSN_FIRST - 2)
#define PSN_RESET culng(PSN_FIRST - 3)
#define PSN_HELP culng(PSN_FIRST - 5)
#define PSN_WIZBACK culng(PSN_FIRST - 6)
#define PSN_WIZNEXT culng(PSN_FIRST - 7)
#define PSN_WIZFINISH culng(PSN_FIRST - 8)
#define PSN_QUERYCANCEL culng(PSN_FIRST - 9)
#define PSN_GETOBJECT culng(PSN_FIRST - 10)
#define PSN_TRANSLATEACCELERATOR culng(PSN_FIRST - 12)
#define PSN_QUERYINITIALFOCUS culng(PSN_FIRST - 13)
#define PSNRET_NOERROR 0
#define PSNRET_INVALID 1
#define PSNRET_INVALID_NOCHANGEPAGE 2
#define PSNRET_MESSAGEHANDLED 3
#define PSM_SETCURSEL (WM_USER + 101)
#define PropSheet_SetCurSel(hDlg, hpage, index) SNDMSG(hDlg, PSM_SETCURSEL, cast(WPARAM, index), cast(LPARAM, hpage))
#define PSM_REMOVEPAGE (WM_USER + 102)
#define PropSheet_RemovePage(hDlg, index, hpage) SNDMSG(hDlg, PSM_REMOVEPAGE, index, cast(LPARAM, hpage))
#define PSM_ADDPAGE (WM_USER + 103)
#define PropSheet_AddPage(hDlg, hpage) SNDMSG(hDlg, PSM_ADDPAGE, 0, cast(LPARAM, hpage))
#define PSM_CHANGED (WM_USER + 104)
#define PropSheet_Changed(hDlg, hwnd) SNDMSG(hDlg, PSM_CHANGED, cast(WPARAM, hwnd), cast(LPARAM, 0))
#define PSM_RESTARTWINDOWS (WM_USER + 105)
#define PropSheet_RestartWindows(hDlg) SNDMSG(hDlg, PSM_RESTARTWINDOWS, cast(WPARAM, 0), cast(LPARAM, 0))
#define PSM_REBOOTSYSTEM (WM_USER + 106)
#define PropSheet_RebootSystem(hDlg) SNDMSG(hDlg, PSM_REBOOTSYSTEM, cast(WPARAM, 0), cast(LPARAM, 0))
#define PSM_CANCELTOCLOSE (WM_USER + 107)
#define PropSheet_CancelToClose(hDlg) PostMessage(hDlg, PSM_CANCELTOCLOSE, cast(WPARAM, 0), cast(LPARAM, 0))
#define PSM_QUERYSIBLINGS (WM_USER + 108)
#define PropSheet_QuerySiblings(hDlg, wParam, lParam) SNDMSG(hDlg, PSM_QUERYSIBLINGS, wParam, lParam)
#define PSM_UNCHANGED (WM_USER + 109)
#define PropSheet_UnChanged(hDlg, hwnd) SNDMSG(hDlg, PSM_UNCHANGED, cast(WPARAM, hwnd), cast(LPARAM, 0))
#define PSM_APPLY (WM_USER + 110)
#define PropSheet_Apply(hDlg) SNDMSG(hDlg, PSM_APPLY, cast(WPARAM, 0), cast(LPARAM, 0))
#define PSM_SETTITLEA (WM_USER + 111)
#define PSM_SETTITLEW (WM_USER + 120)

#ifdef UNICODE
	#define PSM_SETTITLE PSM_SETTITLEW
#else
	#define PSM_SETTITLE PSM_SETTITLEA
#endif

#define PropSheet_SetTitle(hDlg, wStyle, lpszText) SNDMSG(hDlg, PSM_SETTITLE, wStyle, cast(LPARAM, cast(LPCTSTR, (lpszText))))
#define PSM_SETWIZBUTTONS (WM_USER + 112)
#define PropSheet_SetWizButtons(hDlg, dwFlags) PostMessage(hDlg, PSM_SETWIZBUTTONS, cast(WPARAM, 0), cast(LPARAM, dwFlags))
#define PSWIZB_BACK &h00000001
#define PSWIZB_NEXT &h00000002
#define PSWIZB_FINISH &h00000004
#define PSWIZB_DISABLEDFINISH &h00000008
#define PSM_PRESSBUTTON (WM_USER + 113)
#define PropSheet_PressButton(hDlg, iButton) PostMessage(hDlg, PSM_PRESSBUTTON, cast(WPARAM, iButton), cast(LPARAM, 0))
#define PSBTN_BACK 0
#define PSBTN_NEXT 1
#define PSBTN_FINISH 2
#define PSBTN_OK 3
#define PSBTN_APPLYNOW 4
#define PSBTN_CANCEL 5
#define PSBTN_HELP 6
#define PSBTN_MAX 6
#define PSM_SETCURSELID (WM_USER + 114)
#define PropSheet_SetCurSelByID(hDlg, id) SNDMSG(hDlg, PSM_SETCURSELID, 0, cast(LPARAM, id))
#define PSM_SETFINISHTEXTA (WM_USER + 115)
#define PSM_SETFINISHTEXTW (WM_USER + 121)

#ifdef UNICODE
	#define PSM_SETFINISHTEXT PSM_SETFINISHTEXTW
#else
	#define PSM_SETFINISHTEXT PSM_SETFINISHTEXTA
#endif

#define PropSheet_SetFinishText(hDlg, lpszText) SNDMSG(hDlg, PSM_SETFINISHTEXT, 0, cast(LPARAM, lpszText))
#define PSM_GETTABCONTROL (WM_USER + 116)
#define PropSheet_GetTabControl(hDlg) cast(HWND, SNDMSG(hDlg, PSM_GETTABCONTROL, 0, 0))
#define PSM_ISDIALOGMESSAGE (WM_USER + 117)
#define PropSheet_IsDialogMessage(hDlg, pMsg) cast(WINBOOL, SNDMSG(hDlg, PSM_ISDIALOGMESSAGE, 0, cast(LPARAM, pMsg)))
#define PSM_GETCURRENTPAGEHWND (WM_USER + 118)
#define PropSheet_GetCurrentPageHwnd(hDlg) cast(HWND, SNDMSG(hDlg, PSM_GETCURRENTPAGEHWND, cast(WPARAM, 0), cast(LPARAM, 0)))
#define PSM_INSERTPAGE (WM_USER + 119)
#define PropSheet_InsertPage(hDlg, index, hpage) SNDMSG(hDlg, PSM_INSERTPAGE, cast(WPARAM, (index)), cast(LPARAM, (hpage)))
#define PSM_SETHEADERTITLEA (WM_USER + 125)
#define PSM_SETHEADERTITLEW (WM_USER + 126)

#ifdef UNICODE
	#define PSM_SETHEADERTITLE PSM_SETHEADERTITLEW
#else
	#define PSM_SETHEADERTITLE PSM_SETHEADERTITLEA
#endif

#define PropSheet_SetHeaderTitle(hDlg, index, lpszText) SNDMSG(hDlg, PSM_SETHEADERTITLE, cast(WPARAM, (index)), cast(LPARAM, (lpszText)))
#define PSM_SETHEADERSUBTITLEA (WM_USER + 127)
#define PSM_SETHEADERSUBTITLEW (WM_USER + 128)

#ifdef UNICODE
	#define PSM_SETHEADERSUBTITLE PSM_SETHEADERSUBTITLEW
#else
	#define PSM_SETHEADERSUBTITLE PSM_SETHEADERSUBTITLEA
#endif

#define PropSheet_SetHeaderSubTitle(hDlg, index, lpszText) SNDMSG(hDlg, PSM_SETHEADERSUBTITLE, cast(WPARAM, (index)), cast(LPARAM, (lpszText)))
#define PSM_HWNDTOINDEX (WM_USER + 129)
#define PropSheet_HwndToIndex(hDlg, hwnd) clng(SNDMSG(hDlg, PSM_HWNDTOINDEX, cast(WPARAM, (hwnd)), 0))
#define PSM_INDEXTOHWND (WM_USER + 130)
#define PropSheet_IndexToHwnd(hDlg, i) cast(HWND, SNDMSG(hDlg, PSM_INDEXTOHWND, cast(WPARAM, (i)), 0))
#define PSM_PAGETOINDEX (WM_USER + 131)
#define PropSheet_PageToIndex(hDlg, hpage) clng(SNDMSG(hDlg, PSM_PAGETOINDEX, 0, cast(LPARAM, (hpage))))
#define PSM_INDEXTOPAGE (WM_USER + 132)
#define PropSheet_IndexToPage(hDlg, i) cast(HPROPSHEETPAGE, SNDMSG(hDlg, PSM_INDEXTOPAGE, cast(WPARAM, (i)), 0))
#define PSM_IDTOINDEX (WM_USER + 133)
#define PropSheet_IdToIndex(hDlg, id) clng(SNDMSG(hDlg, PSM_IDTOINDEX, 0, cast(LPARAM, (id))))
#define PSM_INDEXTOID (WM_USER + 134)
#define PropSheet_IndexToId(hDlg, i) SNDMSG(hDlg, PSM_INDEXTOID, cast(WPARAM, (i)), 0)
#define PSM_GETRESULT (WM_USER + 135)
#define PropSheet_GetResult(hDlg) SNDMSG(hDlg, PSM_GETRESULT, 0, 0)
#define PSM_RECALCPAGESIZES (WM_USER + 136)
#define PropSheet_RecalcPageSizes(hDlg) SNDMSG(hDlg, PSM_RECALCPAGESIZES, 0, 0)
#define ID_PSRESTARTWINDOWS &h2
#define ID_PSREBOOTSYSTEM (ID_PSRESTARTWINDOWS or &h1)
#define WIZ_CXDLG 276
#define WIZ_CYDLG 140
#define WIZ_CXBMP 80
#define WIZ_BODYX 92
#define WIZ_BODYCX 184
#define PROP_SM_CXDLG 212
#define PROP_SM_CYDLG 188
#define PROP_MED_CXDLG 227
#define PROP_MED_CYDLG 215
#define PROP_LG_CXDLG 252
#define PROP_LG_CYDLG 218

end extern
