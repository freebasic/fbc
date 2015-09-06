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

#inclib "imm32"

#include once "_mingw_unicode.bi"

extern "Windows"

#define _IMM_
#define _IMM_SDK_DEFINED_

type HIMC__
	unused as long
end type

type HIMC as HIMC__ ptr

type HIMCC__
	unused as long
end type

type HIMCC as HIMCC__ ptr
type LPHKL as HKL ptr

type tagCOMPOSITIONFORM
	dwStyle as DWORD
	ptCurrentPos as POINT
	rcArea as RECT
end type

type COMPOSITIONFORM as tagCOMPOSITIONFORM
type PCOMPOSITIONFORM as tagCOMPOSITIONFORM ptr
type NPCOMPOSITIONFORM as tagCOMPOSITIONFORM ptr
type LPCOMPOSITIONFORM as tagCOMPOSITIONFORM ptr

type tagCANDIDATEFORM
	dwIndex as DWORD
	dwStyle as DWORD
	ptCurrentPos as POINT
	rcArea as RECT
end type

type CANDIDATEFORM as tagCANDIDATEFORM
type PCANDIDATEFORM as tagCANDIDATEFORM ptr
type NPCANDIDATEFORM as tagCANDIDATEFORM ptr
type LPCANDIDATEFORM as tagCANDIDATEFORM ptr

type tagCANDIDATELIST
	dwSize as DWORD
	dwStyle as DWORD
	dwCount as DWORD
	dwSelection as DWORD
	dwPageStart as DWORD
	dwPageSize as DWORD
	dwOffset(0 to 0) as DWORD
end type

type CANDIDATELIST as tagCANDIDATELIST
type PCANDIDATELIST as tagCANDIDATELIST ptr
type NPCANDIDATELIST as tagCANDIDATELIST ptr
type LPCANDIDATELIST as tagCANDIDATELIST ptr

type tagREGISTERWORDA
	lpReading as LPSTR
	lpWord as LPSTR
end type

type REGISTERWORDA as tagREGISTERWORDA
type PREGISTERWORDA as tagREGISTERWORDA ptr
type NPREGISTERWORDA as tagREGISTERWORDA ptr
type LPREGISTERWORDA as tagREGISTERWORDA ptr

type tagREGISTERWORDW
	lpReading as LPWSTR
	lpWord as LPWSTR
end type

type REGISTERWORDW as tagREGISTERWORDW
type PREGISTERWORDW as tagREGISTERWORDW ptr
type NPREGISTERWORDW as tagREGISTERWORDW ptr
type LPREGISTERWORDW as tagREGISTERWORDW ptr

#ifdef UNICODE
	type REGISTERWORD as REGISTERWORDW
	type PREGISTERWORD as PREGISTERWORDW
	type NPREGISTERWORD as NPREGISTERWORDW
	type LPREGISTERWORD as LPREGISTERWORDW
#else
	type REGISTERWORD as REGISTERWORDA
	type PREGISTERWORD as PREGISTERWORDA
	type NPREGISTERWORD as NPREGISTERWORDA
	type LPREGISTERWORD as LPREGISTERWORDA
#endif

type tagRECONVERTSTRING
	dwSize as DWORD
	dwVersion as DWORD
	dwStrLen as DWORD
	dwStrOffset as DWORD
	dwCompStrLen as DWORD
	dwCompStrOffset as DWORD
	dwTargetStrLen as DWORD
	dwTargetStrOffset as DWORD
end type

type RECONVERTSTRING as tagRECONVERTSTRING
type PRECONVERTSTRING as tagRECONVERTSTRING ptr
type NPRECONVERTSTRING as tagRECONVERTSTRING ptr
type LPRECONVERTSTRING as tagRECONVERTSTRING ptr
const STYLE_DESCRIPTION_SIZE = 32

type tagSTYLEBUFA
	dwStyle as DWORD
	szDescription as zstring * 32
end type

type STYLEBUFA as tagSTYLEBUFA
type PSTYLEBUFA as tagSTYLEBUFA ptr
type NPSTYLEBUFA as tagSTYLEBUFA ptr
type LPSTYLEBUFA as tagSTYLEBUFA ptr

type tagSTYLEBUFW
	dwStyle as DWORD
	szDescription as wstring * 32
end type

type STYLEBUFW as tagSTYLEBUFW
type PSTYLEBUFW as tagSTYLEBUFW ptr
type NPSTYLEBUFW as tagSTYLEBUFW ptr
type LPSTYLEBUFW as tagSTYLEBUFW ptr

#ifdef UNICODE
	type STYLEBUF as STYLEBUFW
	type PSTYLEBUF as PSTYLEBUFW
	type NPSTYLEBUF as NPSTYLEBUFW
	type LPSTYLEBUF as LPSTYLEBUFW
#else
	type STYLEBUF as STYLEBUFA
	type PSTYLEBUF as PSTYLEBUFA
	type NPSTYLEBUF as NPSTYLEBUFA
	type LPSTYLEBUF as LPSTYLEBUFA
#endif

const IMEMENUITEM_STRING_SIZE = 80

type tagIMEMENUITEMINFOA
	cbSize as UINT
	fType as UINT
	fState as UINT
	wID as UINT
	hbmpChecked as HBITMAP
	hbmpUnchecked as HBITMAP
	dwItemData as DWORD
	szString as zstring * 80
	hbmpItem as HBITMAP
end type

type IMEMENUITEMINFOA as tagIMEMENUITEMINFOA
type PIMEMENUITEMINFOA as tagIMEMENUITEMINFOA ptr
type NPIMEMENUITEMINFOA as tagIMEMENUITEMINFOA ptr
type LPIMEMENUITEMINFOA as tagIMEMENUITEMINFOA ptr

type tagIMEMENUITEMINFOW
	cbSize as UINT
	fType as UINT
	fState as UINT
	wID as UINT
	hbmpChecked as HBITMAP
	hbmpUnchecked as HBITMAP
	dwItemData as DWORD
	szString as wstring * 80
	hbmpItem as HBITMAP
end type

type IMEMENUITEMINFOW as tagIMEMENUITEMINFOW
type PIMEMENUITEMINFOW as tagIMEMENUITEMINFOW ptr
type NPIMEMENUITEMINFOW as tagIMEMENUITEMINFOW ptr
type LPIMEMENUITEMINFOW as tagIMEMENUITEMINFOW ptr

#ifdef UNICODE
	type IMEMENUITEMINFO as IMEMENUITEMINFOW
	type PIMEMENUITEMINFO as PIMEMENUITEMINFOW
	type NPIMEMENUITEMINFO as NPIMEMENUITEMINFOW
	type LPIMEMENUITEMINFO as LPIMEMENUITEMINFOW
#else
	type IMEMENUITEMINFO as IMEMENUITEMINFOA
	type PIMEMENUITEMINFO as PIMEMENUITEMINFOA
	type NPIMEMENUITEMINFO as NPIMEMENUITEMINFOA
	type LPIMEMENUITEMINFO as LPIMEMENUITEMINFOA
#endif

type tagIMECHARPOSITION
	dwSize as DWORD
	dwCharPos as DWORD
	pt as POINT
	cLineHeight as UINT
	rcDocument as RECT
end type

type IMECHARPOSITION as tagIMECHARPOSITION
type PIMECHARPOSITION as tagIMECHARPOSITION ptr
type NPIMECHARPOSITION as tagIMECHARPOSITION ptr
type LPIMECHARPOSITION as tagIMECHARPOSITION ptr
type IMCENUMPROC as function(byval as HIMC, byval as LPARAM) as WINBOOL
declare function ImmInstallIMEA(byval lpszIMEFileName as LPCSTR, byval lpszLayoutText as LPCSTR) as HKL

#ifndef UNICODE
	declare function ImmInstallIME alias "ImmInstallIMEA"(byval lpszIMEFileName as LPCSTR, byval lpszLayoutText as LPCSTR) as HKL
#endif

declare function ImmInstallIMEW(byval lpszIMEFileName as LPCWSTR, byval lpszLayoutText as LPCWSTR) as HKL

#ifdef UNICODE
	declare function ImmInstallIME alias "ImmInstallIMEW"(byval lpszIMEFileName as LPCWSTR, byval lpszLayoutText as LPCWSTR) as HKL
#endif

declare function ImmGetDefaultIMEWnd(byval as HWND) as HWND
declare function ImmGetDescriptionA(byval as HKL, byval as LPSTR, byval uBufLen as UINT) as UINT

#ifndef UNICODE
	declare function ImmGetDescription alias "ImmGetDescriptionA"(byval as HKL, byval as LPSTR, byval uBufLen as UINT) as UINT
#endif

declare function ImmGetDescriptionW(byval as HKL, byval as LPWSTR, byval uBufLen as UINT) as UINT

#ifdef UNICODE
	declare function ImmGetDescription alias "ImmGetDescriptionW"(byval as HKL, byval as LPWSTR, byval uBufLen as UINT) as UINT
#endif

declare function ImmGetIMEFileNameA(byval as HKL, byval as LPSTR, byval uBufLen as UINT) as UINT

#ifndef UNICODE
	declare function ImmGetIMEFileName alias "ImmGetIMEFileNameA"(byval as HKL, byval as LPSTR, byval uBufLen as UINT) as UINT
#endif

declare function ImmGetIMEFileNameW(byval as HKL, byval as LPWSTR, byval uBufLen as UINT) as UINT

#ifdef UNICODE
	declare function ImmGetIMEFileName alias "ImmGetIMEFileNameW"(byval as HKL, byval as LPWSTR, byval uBufLen as UINT) as UINT
#endif

declare function ImmGetProperty(byval as HKL, byval as DWORD) as DWORD
declare function ImmIsIME(byval as HKL) as WINBOOL
declare function ImmSimulateHotKey(byval as HWND, byval as DWORD) as WINBOOL
declare function ImmCreateContext() as HIMC
declare function ImmDestroyContext(byval as HIMC) as WINBOOL
declare function ImmGetContext(byval as HWND) as HIMC
declare function ImmReleaseContext(byval as HWND, byval as HIMC) as WINBOOL
declare function ImmAssociateContext(byval as HWND, byval as HIMC) as HIMC
declare function ImmAssociateContextEx(byval as HWND, byval as HIMC, byval as DWORD) as WINBOOL
declare function ImmGetCompositionStringA(byval as HIMC, byval as DWORD, byval as LPVOID, byval as DWORD) as LONG

#ifndef UNICODE
	declare function ImmGetCompositionString alias "ImmGetCompositionStringA"(byval as HIMC, byval as DWORD, byval as LPVOID, byval as DWORD) as LONG
#endif

declare function ImmGetCompositionStringW(byval as HIMC, byval as DWORD, byval as LPVOID, byval as DWORD) as LONG

#ifdef UNICODE
	declare function ImmGetCompositionString alias "ImmGetCompositionStringW"(byval as HIMC, byval as DWORD, byval as LPVOID, byval as DWORD) as LONG
#endif

declare function ImmSetCompositionStringA(byval as HIMC, byval dwIndex as DWORD, byval lpComp as LPVOID, byval as DWORD, byval lpRead as LPVOID, byval as DWORD) as WINBOOL

#ifndef UNICODE
	declare function ImmSetCompositionString alias "ImmSetCompositionStringA"(byval as HIMC, byval dwIndex as DWORD, byval lpComp as LPVOID, byval as DWORD, byval lpRead as LPVOID, byval as DWORD) as WINBOOL
#endif

declare function ImmSetCompositionStringW(byval as HIMC, byval dwIndex as DWORD, byval lpComp as LPVOID, byval as DWORD, byval lpRead as LPVOID, byval as DWORD) as WINBOOL

#ifdef UNICODE
	declare function ImmSetCompositionString alias "ImmSetCompositionStringW"(byval as HIMC, byval dwIndex as DWORD, byval lpComp as LPVOID, byval as DWORD, byval lpRead as LPVOID, byval as DWORD) as WINBOOL
#endif

declare function ImmGetCandidateListCountA(byval as HIMC, byval lpdwListCount as LPDWORD) as DWORD

#ifndef UNICODE
	declare function ImmGetCandidateListCount alias "ImmGetCandidateListCountA"(byval as HIMC, byval lpdwListCount as LPDWORD) as DWORD
#endif

declare function ImmGetCandidateListCountW(byval as HIMC, byval lpdwListCount as LPDWORD) as DWORD

#ifdef UNICODE
	declare function ImmGetCandidateListCount alias "ImmGetCandidateListCountW"(byval as HIMC, byval lpdwListCount as LPDWORD) as DWORD
#endif

declare function ImmGetCandidateListA(byval as HIMC, byval deIndex as DWORD, byval as LPCANDIDATELIST, byval dwBufLen as DWORD) as DWORD

#ifndef UNICODE
	declare function ImmGetCandidateList alias "ImmGetCandidateListA"(byval as HIMC, byval deIndex as DWORD, byval as LPCANDIDATELIST, byval dwBufLen as DWORD) as DWORD
#endif

declare function ImmGetCandidateListW(byval as HIMC, byval deIndex as DWORD, byval as LPCANDIDATELIST, byval dwBufLen as DWORD) as DWORD

#ifdef UNICODE
	declare function ImmGetCandidateList alias "ImmGetCandidateListW"(byval as HIMC, byval deIndex as DWORD, byval as LPCANDIDATELIST, byval dwBufLen as DWORD) as DWORD
#endif

declare function ImmGetGuideLineA(byval as HIMC, byval dwIndex as DWORD, byval as LPSTR, byval dwBufLen as DWORD) as DWORD

#ifndef UNICODE
	declare function ImmGetGuideLine alias "ImmGetGuideLineA"(byval as HIMC, byval dwIndex as DWORD, byval as LPSTR, byval dwBufLen as DWORD) as DWORD
#endif

declare function ImmGetGuideLineW(byval as HIMC, byval dwIndex as DWORD, byval as LPWSTR, byval dwBufLen as DWORD) as DWORD

#ifdef UNICODE
	declare function ImmGetGuideLine alias "ImmGetGuideLineW"(byval as HIMC, byval dwIndex as DWORD, byval as LPWSTR, byval dwBufLen as DWORD) as DWORD
#endif

declare function ImmGetConversionStatus(byval as HIMC, byval as LPDWORD, byval as LPDWORD) as WINBOOL
declare function ImmSetConversionStatus(byval as HIMC, byval as DWORD, byval as DWORD) as WINBOOL
declare function ImmGetOpenStatus(byval as HIMC) as WINBOOL
declare function ImmSetOpenStatus(byval as HIMC, byval as WINBOOL) as WINBOOL
declare function ImmGetCompositionFontA(byval as HIMC, byval as LPLOGFONTA) as WINBOOL

#ifndef UNICODE
	declare function ImmGetCompositionFont alias "ImmGetCompositionFontA"(byval as HIMC, byval as LPLOGFONTA) as WINBOOL
#endif

declare function ImmGetCompositionFontW(byval as HIMC, byval as LPLOGFONTW) as WINBOOL

#ifdef UNICODE
	declare function ImmGetCompositionFont alias "ImmGetCompositionFontW"(byval as HIMC, byval as LPLOGFONTW) as WINBOOL
#endif

declare function ImmSetCompositionFontA(byval as HIMC, byval as LPLOGFONTA) as WINBOOL

#ifndef UNICODE
	declare function ImmSetCompositionFont alias "ImmSetCompositionFontA"(byval as HIMC, byval as LPLOGFONTA) as WINBOOL
#endif

declare function ImmSetCompositionFontW(byval as HIMC, byval as LPLOGFONTW) as WINBOOL

#ifdef UNICODE
	declare function ImmSetCompositionFont alias "ImmSetCompositionFontW"(byval as HIMC, byval as LPLOGFONTW) as WINBOOL
#endif

type REGISTERWORDENUMPROCA as function(byval as LPCSTR, byval as DWORD, byval as LPCSTR, byval as LPVOID) as long
type REGISTERWORDENUMPROCW as function(byval as LPCWSTR, byval as DWORD, byval as LPCWSTR, byval as LPVOID) as long

#ifdef UNICODE
	type REGISTERWORDENUMPROC as REGISTERWORDENUMPROCW
#else
	type REGISTERWORDENUMPROC as REGISTERWORDENUMPROCA
#endif

declare function ImmConfigureIMEA(byval as HKL, byval as HWND, byval as DWORD, byval as LPVOID) as WINBOOL

#ifndef UNICODE
	declare function ImmConfigureIME alias "ImmConfigureIMEA"(byval as HKL, byval as HWND, byval as DWORD, byval as LPVOID) as WINBOOL
#endif

declare function ImmConfigureIMEW(byval as HKL, byval as HWND, byval as DWORD, byval as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function ImmConfigureIME alias "ImmConfigureIMEW"(byval as HKL, byval as HWND, byval as DWORD, byval as LPVOID) as WINBOOL
#endif

declare function ImmEscapeA(byval as HKL, byval as HIMC, byval as UINT, byval as LPVOID) as LRESULT

#ifndef UNICODE
	declare function ImmEscape alias "ImmEscapeA"(byval as HKL, byval as HIMC, byval as UINT, byval as LPVOID) as LRESULT
#endif

declare function ImmEscapeW(byval as HKL, byval as HIMC, byval as UINT, byval as LPVOID) as LRESULT

#ifdef UNICODE
	declare function ImmEscape alias "ImmEscapeW"(byval as HKL, byval as HIMC, byval as UINT, byval as LPVOID) as LRESULT
#endif

declare function ImmGetConversionListA(byval as HKL, byval as HIMC, byval as LPCSTR, byval as LPCANDIDATELIST, byval dwBufLen as DWORD, byval uFlag as UINT) as DWORD

#ifndef UNICODE
	declare function ImmGetConversionList alias "ImmGetConversionListA"(byval as HKL, byval as HIMC, byval as LPCSTR, byval as LPCANDIDATELIST, byval dwBufLen as DWORD, byval uFlag as UINT) as DWORD
#endif

declare function ImmGetConversionListW(byval as HKL, byval as HIMC, byval as LPCWSTR, byval as LPCANDIDATELIST, byval dwBufLen as DWORD, byval uFlag as UINT) as DWORD

#ifdef UNICODE
	declare function ImmGetConversionList alias "ImmGetConversionListW"(byval as HKL, byval as HIMC, byval as LPCWSTR, byval as LPCANDIDATELIST, byval dwBufLen as DWORD, byval uFlag as UINT) as DWORD
#endif

declare function ImmNotifyIME(byval as HIMC, byval dwAction as DWORD, byval dwIndex as DWORD, byval dwValue as DWORD) as WINBOOL
declare function ImmGetStatusWindowPos(byval as HIMC, byval as LPPOINT) as WINBOOL
declare function ImmSetStatusWindowPos(byval as HIMC, byval as LPPOINT) as WINBOOL
declare function ImmGetCompositionWindow(byval as HIMC, byval as LPCOMPOSITIONFORM) as WINBOOL
declare function ImmSetCompositionWindow(byval as HIMC, byval as LPCOMPOSITIONFORM) as WINBOOL
declare function ImmGetCandidateWindow(byval as HIMC, byval as DWORD, byval as LPCANDIDATEFORM) as WINBOOL
declare function ImmSetCandidateWindow(byval as HIMC, byval as LPCANDIDATEFORM) as WINBOOL
declare function ImmIsUIMessageA(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as WINBOOL

#ifndef UNICODE
	declare function ImmIsUIMessage alias "ImmIsUIMessageA"(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as WINBOOL
#endif

declare function ImmIsUIMessageW(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as WINBOOL

#ifdef UNICODE
	declare function ImmIsUIMessage alias "ImmIsUIMessageW"(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as WINBOOL
#endif

declare function ImmGetVirtualKey(byval as HWND) as UINT
declare function ImmRegisterWordA(byval as HKL, byval lpszReading as LPCSTR, byval as DWORD, byval lpszRegister as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function ImmRegisterWord alias "ImmRegisterWordA"(byval as HKL, byval lpszReading as LPCSTR, byval as DWORD, byval lpszRegister as LPCSTR) as WINBOOL
#endif

declare function ImmRegisterWordW(byval as HKL, byval lpszReading as LPCWSTR, byval as DWORD, byval lpszRegister as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function ImmRegisterWord alias "ImmRegisterWordW"(byval as HKL, byval lpszReading as LPCWSTR, byval as DWORD, byval lpszRegister as LPCWSTR) as WINBOOL
#endif

declare function ImmUnregisterWordA(byval as HKL, byval lpszReading as LPCSTR, byval as DWORD, byval lpszUnregister as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function ImmUnregisterWord alias "ImmUnregisterWordA"(byval as HKL, byval lpszReading as LPCSTR, byval as DWORD, byval lpszUnregister as LPCSTR) as WINBOOL
#endif

declare function ImmUnregisterWordW(byval as HKL, byval lpszReading as LPCWSTR, byval as DWORD, byval lpszUnregister as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function ImmUnregisterWord alias "ImmUnregisterWordW"(byval as HKL, byval lpszReading as LPCWSTR, byval as DWORD, byval lpszUnregister as LPCWSTR) as WINBOOL
#endif

declare function ImmGetRegisterWordStyleA(byval as HKL, byval nItem as UINT, byval as LPSTYLEBUFA) as UINT

#ifndef UNICODE
	declare function ImmGetRegisterWordStyle alias "ImmGetRegisterWordStyleA"(byval as HKL, byval nItem as UINT, byval as LPSTYLEBUFA) as UINT
#endif

declare function ImmGetRegisterWordStyleW(byval as HKL, byval nItem as UINT, byval as LPSTYLEBUFW) as UINT

#ifdef UNICODE
	declare function ImmGetRegisterWordStyle alias "ImmGetRegisterWordStyleW"(byval as HKL, byval nItem as UINT, byval as LPSTYLEBUFW) as UINT
#endif

declare function ImmEnumRegisterWordA(byval as HKL, byval as REGISTERWORDENUMPROCA, byval lpszReading as LPCSTR, byval as DWORD, byval lpszRegister as LPCSTR, byval as LPVOID) as UINT

#ifndef UNICODE
	declare function ImmEnumRegisterWord alias "ImmEnumRegisterWordA"(byval as HKL, byval as REGISTERWORDENUMPROCA, byval lpszReading as LPCSTR, byval as DWORD, byval lpszRegister as LPCSTR, byval as LPVOID) as UINT
#endif

declare function ImmEnumRegisterWordW(byval as HKL, byval as REGISTERWORDENUMPROCW, byval lpszReading as LPCWSTR, byval as DWORD, byval lpszRegister as LPCWSTR, byval as LPVOID) as UINT

#ifdef UNICODE
	declare function ImmEnumRegisterWord alias "ImmEnumRegisterWordW"(byval as HKL, byval as REGISTERWORDENUMPROCW, byval lpszReading as LPCWSTR, byval as DWORD, byval lpszRegister as LPCWSTR, byval as LPVOID) as UINT
#endif

declare function ImmDisableIME(byval as DWORD) as WINBOOL
declare function ImmEnumInputContext(byval idThread as DWORD, byval lpfn as IMCENUMPROC, byval lParam as LPARAM) as WINBOOL
declare function ImmGetImeMenuItemsA(byval as HIMC, byval as DWORD, byval as DWORD, byval as LPIMEMENUITEMINFOA, byval as LPIMEMENUITEMINFOA, byval as DWORD) as DWORD

#ifndef UNICODE
	declare function ImmGetImeMenuItems alias "ImmGetImeMenuItemsA"(byval as HIMC, byval as DWORD, byval as DWORD, byval as LPIMEMENUITEMINFOA, byval as LPIMEMENUITEMINFOA, byval as DWORD) as DWORD
#endif

declare function ImmGetImeMenuItemsW(byval as HIMC, byval as DWORD, byval as DWORD, byval as LPIMEMENUITEMINFOW, byval as LPIMEMENUITEMINFOW, byval as DWORD) as DWORD

#ifdef UNICODE
	declare function ImmGetImeMenuItems alias "ImmGetImeMenuItemsW"(byval as HIMC, byval as DWORD, byval as DWORD, byval as LPIMEMENUITEMINFOW, byval as LPIMEMENUITEMINFOW, byval as DWORD) as DWORD
#endif

declare function ImmDisableTextFrameService(byval idThread as DWORD) as WINBOOL
const IMC_GETCANDIDATEPOS = &h0007
const IMC_SETCANDIDATEPOS = &h0008
const IMC_GETCOMPOSITIONFONT = &h0009
const IMC_SETCOMPOSITIONFONT = &h000A
const IMC_GETCOMPOSITIONWINDOW = &h000B
const IMC_SETCOMPOSITIONWINDOW = &h000C
const IMC_GETSTATUSWINDOWPOS = &h000F
const IMC_SETSTATUSWINDOWPOS = &h0010
const IMC_CLOSESTATUSWINDOW = &h0021
const IMC_OPENSTATUSWINDOW = &h0022
const NI_OPENCANDIDATE = &h0010
const NI_CLOSECANDIDATE = &h0011
const NI_SELECTCANDIDATESTR = &h0012
const NI_CHANGECANDIDATELIST = &h0013
const NI_FINALIZECONVERSIONRESULT = &h0014
const NI_COMPOSITIONSTR = &h0015
const NI_SETCANDIDATE_PAGESTART = &h0016
const NI_SETCANDIDATE_PAGESIZE = &h0017
const NI_IMEMENUSELECTED = &h0018
const ISC_SHOWUICANDIDATEWINDOW = &h00000001
const ISC_SHOWUICOMPOSITIONWINDOW = &h80000000
const ISC_SHOWUIGUIDELINE = &h40000000
const ISC_SHOWUIALLCANDIDATEWINDOW = &h0000000F
const ISC_SHOWUIALL = &hC000000F
const CPS_COMPLETE = &h0001
const CPS_CONVERT = &h0002
const CPS_REVERT = &h0003
const CPS_CANCEL = &h0004
const MOD_ALT = &h0001
const MOD_CONTROL = &h0002
const MOD_SHIFT = &h0004
const MOD_LEFT = &h8000
const MOD_RIGHT = &h4000
const MOD_ON_KEYUP = &h0800
const MOD_IGNORE_ALL_MODIFIER = &h0400
const IME_CHOTKEY_IME_NONIME_TOGGLE = &h10
const IME_CHOTKEY_SHAPE_TOGGLE = &h11
const IME_CHOTKEY_SYMBOL_TOGGLE = &h12
const IME_JHOTKEY_CLOSE_OPEN = &h30
const IME_KHOTKEY_SHAPE_TOGGLE = &h50
const IME_KHOTKEY_HANJACONVERT = &h51
const IME_KHOTKEY_ENGLISH = &h52
const IME_THOTKEY_IME_NONIME_TOGGLE = &h70
const IME_THOTKEY_SHAPE_TOGGLE = &h71
const IME_THOTKEY_SYMBOL_TOGGLE = &h72
const IME_HOTKEY_DSWITCH_FIRST = &h100
const IME_HOTKEY_DSWITCH_LAST = &h11F
const IME_HOTKEY_PRIVATE_FIRST = &h200
const IME_ITHOTKEY_RESEND_RESULTSTR = &h200
const IME_ITHOTKEY_PREVIOUS_COMPOSITION = &h201
const IME_ITHOTKEY_UISTYLE_TOGGLE = &h202
const IME_ITHOTKEY_RECONVERTSTRING = &h203
const IME_HOTKEY_PRIVATE_LAST = &h21F
const GCS_COMPREADSTR = &h0001
const GCS_COMPREADATTR = &h0002
const GCS_COMPREADCLAUSE = &h0004
const GCS_COMPSTR = &h0008
const GCS_COMPATTR = &h0010
const GCS_COMPCLAUSE = &h0020
const GCS_CURSORPOS = &h0080
const GCS_DELTASTART = &h0100
const GCS_RESULTREADSTR = &h0200
const GCS_RESULTREADCLAUSE = &h0400
const GCS_RESULTSTR = &h0800
const GCS_RESULTCLAUSE = &h1000
const CS_INSERTCHAR = &h2000
const CS_NOMOVECARET = &h4000
const IMEVER_0310 = &h0003000A
const IMEVER_0400 = &h00040000
const IME_PROP_AT_CARET = &h00010000
const IME_PROP_SPECIAL_UI = &h00020000
const IME_PROP_CANDLIST_START_FROM_1 = &h00040000
const IME_PROP_UNICODE = &h00080000
const IME_PROP_COMPLETE_ON_UNSELECT = &h00100000
const UI_CAP_2700 = &h00000001
const UI_CAP_ROT90 = &h00000002
const UI_CAP_ROTANY = &h00000004
const SCS_CAP_COMPSTR = &h00000001
const SCS_CAP_MAKEREAD = &h00000002
const SCS_CAP_SETRECONVERTSTRING = &h00000004
const SELECT_CAP_CONVERSION = &h00000001
const SELECT_CAP_SENTENCE = &h00000002
const GGL_LEVEL = &h00000001
const GGL_INDEX = &h00000002
const GGL_STRING = &h00000003
const GGL_PRIVATE = &h00000004
const GL_LEVEL_NOGUIDELINE = &h00000000
const GL_LEVEL_FATAL = &h00000001
const GL_LEVEL_ERROR = &h00000002
const GL_LEVEL_WARNING = &h00000003
const GL_LEVEL_INFORMATION = &h00000004
const GL_ID_UNKNOWN = &h00000000
const GL_ID_NOMODULE = &h00000001
const GL_ID_NODICTIONARY = &h00000010
const GL_ID_CANNOTSAVE = &h00000011
const GL_ID_NOCONVERT = &h00000020
const GL_ID_TYPINGERROR = &h00000021
const GL_ID_TOOMANYSTROKE = &h00000022
const GL_ID_READINGCONFLICT = &h00000023
const GL_ID_INPUTREADING = &h00000024
const GL_ID_INPUTRADICAL = &h00000025
const GL_ID_INPUTCODE = &h00000026
const GL_ID_INPUTSYMBOL = &h00000027
const GL_ID_CHOOSECANDIDATE = &h00000028
const GL_ID_REVERSECONVERSION = &h00000029
const GL_ID_PRIVATE_FIRST = &h00008000
const GL_ID_PRIVATE_LAST = &h0000FFFF
const IGP_GETIMEVERSION = cast(DWORD, -4)
const IGP_PROPERTY = &h00000004
const IGP_CONVERSION = &h00000008
const IGP_SENTENCE = &h0000000c
const IGP_UI = &h00000010
const IGP_SETCOMPSTR = &h00000014
const IGP_SELECT = &h00000018
const SCS_SETSTR = GCS_COMPREADSTR or GCS_COMPSTR
const SCS_CHANGEATTR = GCS_COMPREADATTR or GCS_COMPATTR
const SCS_CHANGECLAUSE = GCS_COMPREADCLAUSE or GCS_COMPCLAUSE
const SCS_SETRECONVERTSTRING = &h00010000
const SCS_QUERYRECONVERTSTRING = &h00020000
const ATTR_INPUT = &h00
const ATTR_TARGET_CONVERTED = &h01
const ATTR_CONVERTED = &h02
const ATTR_TARGET_NOTCONVERTED = &h03
const ATTR_INPUT_ERROR = &h04
const ATTR_FIXEDCONVERTED = &h05
const CFS_DEFAULT = &h0000
const CFS_RECT = &h0001
const CFS_POINT = &h0002
const CFS_FORCE_POSITION = &h0020
const CFS_CANDIDATEPOS = &h0040
const CFS_EXCLUDE = &h0080
const GCL_CONVERSION = &h0001
const GCL_REVERSECONVERSION = &h0002
const GCL_REVERSE_LENGTH = &h0003
const IME_CMODE_ALPHANUMERIC = &h0000
const IME_CMODE_NATIVE = &h0001
const IME_CMODE_CHINESE = IME_CMODE_NATIVE
const IME_CMODE_HANGEUL = IME_CMODE_NATIVE
const IME_CMODE_HANGUL = IME_CMODE_NATIVE
const IME_CMODE_JAPANESE = IME_CMODE_NATIVE
const IME_CMODE_KATAKANA = &h0002
const IME_CMODE_LANGUAGE = &h0003
const IME_CMODE_FULLSHAPE = &h0008
const IME_CMODE_ROMAN = &h0010
const IME_CMODE_CHARCODE = &h0020
const IME_CMODE_HANJACONVERT = &h0040
const IME_CMODE_SOFTKBD = &h0080
const IME_CMODE_NOCONVERSION = &h0100
const IME_CMODE_EUDC = &h0200
const IME_CMODE_SYMBOL = &h0400
const IME_CMODE_FIXED = &h0800
const IME_CMODE_RESERVED = &hF0000000
const IME_SMODE_NONE = &h0000
const IME_SMODE_PLAURALCLAUSE = &h0001
const IME_SMODE_SINGLECONVERT = &h0002
const IME_SMODE_AUTOMATIC = &h0004
const IME_SMODE_PHRASEPREDICT = &h0008
const IME_SMODE_CONVERSATION = &h0010
const IME_SMODE_RESERVED = &h0000F000
const IME_CAND_UNKNOWN = &h0000
const IME_CAND_READ = &h0001
const IME_CAND_CODE = &h0002
const IME_CAND_MEANING = &h0003
const IME_CAND_RADICAL = &h0004
const IME_CAND_STROKE = &h0005
const IMN_CLOSESTATUSWINDOW = &h0001
const IMN_OPENSTATUSWINDOW = &h0002
const IMN_CHANGECANDIDATE = &h0003
const IMN_CLOSECANDIDATE = &h0004
const IMN_OPENCANDIDATE = &h0005
const IMN_SETCONVERSIONMODE = &h0006
const IMN_SETSENTENCEMODE = &h0007
const IMN_SETOPENSTATUS = &h0008
const IMN_SETCANDIDATEPOS = &h0009
const IMN_SETCOMPOSITIONFONT = &h000A
const IMN_SETCOMPOSITIONWINDOW = &h000B
const IMN_SETSTATUSWINDOWPOS = &h000C
const IMN_GUIDELINE = &h000D
const IMN_PRIVATE = &h000E
const IMR_COMPOSITIONWINDOW = &h0001
const IMR_CANDIDATEWINDOW = &h0002
const IMR_COMPOSITIONFONT = &h0003
const IMR_RECONVERTSTRING = &h0004
const IMR_CONFIRMRECONVERTSTRING = &h0005
const IMR_QUERYCHARPOSITION = &h0006
const IMR_DOCUMENTFEED = &h0007
const IMM_ERROR_NODATA = -1
const IMM_ERROR_GENERAL = -2
const IME_CONFIG_GENERAL = 1
const IME_CONFIG_REGISTERWORD = 2
const IME_CONFIG_SELECTDICTIONARY = 3
const IME_ESC_QUERY_SUPPORT = &h0003
const IME_ESC_RESERVED_FIRST = &h0004
const IME_ESC_RESERVED_LAST = &h07FF
const IME_ESC_PRIVATE_FIRST = &h0800
const IME_ESC_PRIVATE_LAST = &h0FFF
const IME_ESC_SEQUENCE_TO_INTERNAL = &h1001
const IME_ESC_GET_EUDC_DICTIONARY = &h1003
const IME_ESC_SET_EUDC_DICTIONARY = &h1004
const IME_ESC_MAX_KEY = &h1005
const IME_ESC_IME_NAME = &h1006
const IME_ESC_SYNC_HOTKEY = &h1007
const IME_ESC_HANJA_MODE = &h1008
const IME_ESC_AUTOMATA = &h1009
const IME_ESC_PRIVATE_HOTKEY = &h100a
const IME_ESC_GETHELPFILENAME = &h100b
const IME_REGWORD_STYLE_EUDC = &h00000001
const IME_REGWORD_STYLE_USER_FIRST = &h80000000
const IME_REGWORD_STYLE_USER_LAST = &hFFFFFFFF
const IACE_CHILDREN = &h0001
const IACE_DEFAULT = &h0010
const IACE_IGNORENOCONTEXT = &h0020
const IGIMIF_RIGHTMENU = &h0001
const IGIMII_CMODE = &h0001
const IGIMII_SMODE = &h0002
const IGIMII_CONFIGURE = &h0004
const IGIMII_TOOLS = &h0008
const IGIMII_HELP = &h0010
const IGIMII_OTHER = &h0020
const IGIMII_INPUTTOOLS = &h0040
const IMFT_RADIOCHECK = &h00001
const IMFT_SEPARATOR = &h00002
const IMFT_SUBMENU = &h00004
const IMFS_GRAYED = MFS_GRAYED
const IMFS_DISABLED = MFS_DISABLED
const IMFS_CHECKED = MFS_CHECKED
const IMFS_HILITE = MFS_HILITE
const IMFS_ENABLED = MFS_ENABLED
const IMFS_UNCHECKED = MFS_UNCHECKED
const IMFS_UNHILITE = MFS_UNHILITE
const IMFS_DEFAULT = MFS_DEFAULT
const SOFTKEYBOARD_TYPE_T1 = &h0001
const SOFTKEYBOARD_TYPE_C1 = &h0002

end extern
