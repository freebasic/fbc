'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#include once "_mingw_unicode.bi"

extern "Windows"

#define _INC_CPL
#define WM_CPL_LAUNCH (WM_USER + 1000)
#define WM_CPL_LAUNCHED (WM_USER + 1001)
const CPL_DYNAMIC_RES = 0
const CPL_INIT = 1
const CPL_GETCOUNT = 2
const CPL_INQUIRE = 3
const CPL_SELECT = 4
const CPL_DBLCLK = 5
const CPL_STOP = 6
const CPL_EXIT = 7
const CPL_NEWINQUIRE = 8
const CPL_STARTWPARMSA = 9
const CPL_STARTWPARMSW = 10
type APPLET_PROC as function(byval hwndCpl as HWND, byval msg as UINT, byval lParam1 as LPARAM, byval lParam2 as LPARAM) as LONG

type tagCPLINFO field = 1
	idIcon as long
	idName as long
	idInfo as long
	lData as LONG_PTR
end type

type CPLINFO as tagCPLINFO
type LPCPLINFO as tagCPLINFO ptr

type tagNEWCPLINFOA field = 1
	dwSize as DWORD
	dwFlags as DWORD
	dwHelpContext as DWORD
	lData as LONG_PTR
	hIcon as HICON
	szName as zstring * 32
	szInfo as zstring * 64
	szHelpFile as zstring * 128
end type

type NEWCPLINFOA as tagNEWCPLINFOA
type LPNEWCPLINFOA as tagNEWCPLINFOA ptr

type tagNEWCPLINFOW field = 1
	dwSize as DWORD
	dwFlags as DWORD
	dwHelpContext as DWORD
	lData as LONG_PTR
	hIcon as HICON
	szName as wstring * 32
	szInfo as wstring * 64
	szHelpFile as wstring * 128
end type

type NEWCPLINFOW as tagNEWCPLINFOW
type LPNEWCPLINFOW as tagNEWCPLINFOW ptr

#ifdef UNICODE
	type NEWCPLINFO as NEWCPLINFOW
	type LPNEWCPLINFO as LPNEWCPLINFOW
	#define CPL_STARTWPARMS CPL_STARTWPARMSW
#else
	type NEWCPLINFO as NEWCPLINFOA
	type LPNEWCPLINFO as LPNEWCPLINFOA
	#define CPL_STARTWPARMS CPL_STARTWPARMSA
#endif

const CPL_SETUP = 200

end extern
