''
''
'' custcntl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_custcntl_bi__
#define __win_custcntl_bi__

#define CCF_NOTEXT 1
#define CCHCCCLASS 32
#define CCHCCDESC 32
#define CCHCCTEXT 256

#ifndef UNICODE
type CCSTYLEA
	flStyle as DWORD
	flExtStyle as DWORD
	szText as zstring * 256
	lgid as LANGID
	wReserved1 as WORD
end type

type LPCCSTYLEA as CCSTYLEA ptr

#else
type CCSTYLEW
	flStyle as DWORD
	flExtStyle as DWORD
	szText as wstring * 256
	lgid as LANGID
	wReserved1 as WORD
end type

type LPCCSTYLEW as CCSTYLEW ptr
#endif

#ifndef UNICODE
type CCSTYLEFLAGA
	flStyle as DWORD
	flStyleMask as DWORD
	pszStyle as LPSTR
end type

type LPCCSTYLEFLAGA as CCSTYLEFLAGA ptr

#else
type CCSTYLEFLAGW
	flStyle as DWORD
	flStyleMask as DWORD
	pszStyle as LPWSTR
end type

type LPCCSTYLEFLAGW as CCSTYLEFLAGW ptr
#endif

#ifndef UNICODE
type LPFNCCSTYLEA as function(byval as HWND, byval as LPCCSTYLEA) as BOOL
type LPFNCCSIZETOTEXTA as function(byval as DWORD, byval as DWORD, byval as HFONT, byval as LPSTR) as INT_

type CCINFOA
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

type LPCCINFOA as CCINFOA ptr
type LPFNCCINFOA as function(byval as LPCCINFOA) as UINT

declare function CustomControlInfo alias "CustomControlInfoA" (byval acci as LPCCINFOA) as UINT

type CCSTYLE as CCSTYLEA
type LPCCSTYLE as CCSTYLEA ptr
type CCSTYLEFLAG as CCSTYLEFLAGA
type LPCCSTYLEFLAG as CCSTYLEFLAGA ptr
type CCINFO as CCINFOA
type LPCCINFO as CCINFOA ptr

#else
type LPFNCCSTYLEW as function(byval as HWND, byval as LPCCSTYLEW) as BOOL
type LPFNCCSIZETOTEXTW as function(byval as DWORD, byval as DWORD, byval as HFONT, byval as LPWSTR) as INT_

type CCINFOW
	szClass as wstring * 32
	flOptions as DWORD
	szDesc as wstring * 32
	cxDefault as UINT
	cyDefault as UINT
	flStyleDefault as DWORD
	flExtStyleDefault as DWORD
	flCtrlTypeMask as DWORD
	szTextDefault as wstring * 256
	cStyleFlags as INT_
	aStyleFlags as LPCCSTYLEFLAGW
	lpfnStyle as LPFNCCSTYLEW
	lpfnSizeToText as LPFNCCSIZETOTEXTW
	dwReserved1 as DWORD
	dwReserved2 as DWORD
end type

type LPCCINFOW as CCINFOW ptr
type LPFNCCINFOW as function(byval as LPCCINFOW) as UINT

declare function CustomControlInfo alias "CustomControlInfoW" (byval acci as LPCCINFOW) as UINT

type CCSTYLE as CCSTYLEW
type LPCCSTYLE as CCSTYLEW ptr
type CCSTYLEFLAG as CCSTYLEFLAGW
type LPCCSTYLEFLAG as CCSTYLEFLAGW ptr
type CCINFO as CCINFOW
type LPCCINFO as CCINFOW ptr

#endif

#endif
