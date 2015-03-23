#pragma once

#include once "_mingw_unicode.bi"

extern "Windows"

#define _INC_CUSTCNTL
const CCHCCCLASS = 32
const CCHCCDESC = 32
const CCHCCTEXT = 256

type tagCCSTYLEA
	flStyle as DWORD
	flExtStyle as DWORD
	szText as zstring * 256
	lgid as LANGID
	wReserved1 as WORD
end type

type CCSTYLEA as tagCCSTYLEA
type LPCCSTYLEA as tagCCSTYLEA ptr

type tagCCSTYLEW
	flStyle as DWORD
	flExtStyle as DWORD
	szText as wstring * 256
	lgid as LANGID
	wReserved1 as WORD
end type

type CCSTYLEW as tagCCSTYLEW
type LPCCSTYLEW as tagCCSTYLEW ptr

#ifdef UNICODE
	#define CCSTYLE CCSTYLEW
	#define LPCCSTYLE LPCCSTYLEW
	#define LPFNCCSTYLE LPFNCCSTYLEW
	#define LPFNCCSIZETOTEXT LPFNCCSIZETOTEXTW
	#define CCSTYLEFLAG CCSTYLEFLAGW
	#define LPCCSTYLEFLAG LPCCSTYLEFLAGW
	#define CCINFO CCINFOW
	#define LPCCINFO LPCCINFOW
	#define LPFNCCINFO LPFNCCINFOW
#else
	#define CCSTYLE CCSTYLEA
	#define LPCCSTYLE LPCCSTYLEA
	#define LPFNCCSTYLE LPFNCCSTYLEA
	#define LPFNCCSIZETOTEXT LPFNCCSIZETOTEXTA
	#define CCSTYLEFLAG CCSTYLEFLAGA
	#define LPCCSTYLEFLAG LPCCSTYLEFLAGA
	#define CCINFO CCINFOA
	#define LPCCINFO LPCCINFOA
	#define LPFNCCINFO LPFNCCINFOA
#endif

type LPFNCCSTYLEA as function(byval hwndParent as HWND, byval pccs as LPCCSTYLEA) as WINBOOL
type LPFNCCSTYLEW as function(byval hwndParent as HWND, byval pccs as LPCCSTYLEW) as WINBOOL
type LPFNCCSIZETOTEXTA as function(byval flStyle as DWORD, byval flExtStyle as DWORD, byval hfont as HFONT, byval pszText as LPSTR) as INT_
type LPFNCCSIZETOTEXTW as function(byval flStyle as DWORD, byval flExtStyle as DWORD, byval hfont as HFONT, byval pszText as LPWSTR) as INT_

type tagCCSTYLEFLAGA
	flStyle as DWORD
	flStyleMask as DWORD
	pszStyle as LPSTR
end type

type CCSTYLEFLAGA as tagCCSTYLEFLAGA
type LPCCSTYLEFLAGA as tagCCSTYLEFLAGA ptr

type tagCCSTYLEFLAGW
	flStyle as DWORD
	flStyleMask as DWORD
	pszStyle as LPWSTR
end type

type CCSTYLEFLAGW as tagCCSTYLEFLAGW
type LPCCSTYLEFLAGW as tagCCSTYLEFLAGW ptr
const CCF_NOTEXT = &h00000001

type tagCCINFOA
	szClass as zstring * 32
	flOptions as DWORD
	szDesc as zstring * 32
	cxDefault as UINT
	cyDefault as UINT
	flStyleDefault as DWORD
	flExtStyleDefault as DWORD
	flCtrlTypeMask as DWORD
	szTextDefault as zstring * 256
	cStyleFlags as INT_
	aStyleFlags as LPCCSTYLEFLAGA
	lpfnStyle as LPFNCCSTYLEA
	lpfnSizeToText as LPFNCCSIZETOTEXTA
	dwReserved1 as DWORD
	dwReserved2 as DWORD
end type

type CCINFOA as tagCCINFOA
type LPCCINFOA as tagCCINFOA ptr

type tagCCINFOW
	szClass as wstring * 32
	flOptions as DWORD
	szDesc as wstring * 32
	cxDefault as UINT
	cyDefault as UINT
	flStyleDefault as DWORD
	flExtStyleDefault as DWORD
	flCtrlTypeMask as DWORD
	cStyleFlags as INT_
	aStyleFlags as LPCCSTYLEFLAGW
	szTextDefault as wstring * 256
	lpfnStyle as LPFNCCSTYLEW
	lpfnSizeToText as LPFNCCSIZETOTEXTW
	dwReserved1 as DWORD
	dwReserved2 as DWORD
end type

type CCINFOW as tagCCINFOW
type LPCCINFOW as tagCCINFOW ptr
type LPFNCCINFOA as function(byval acci as LPCCINFOA) as UINT
type LPFNCCINFOW as function(byval acci as LPCCINFOW) as UINT

end extern
