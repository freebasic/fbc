''
''
'' cpl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_cpl_bi__
#define __win_cpl_bi__

#define WM_CPL_LAUNCH (1024+1000)
#define WM_CPL_LAUNCHED (1024+1001)
#define CPL_DYNAMIC_RES 0
#define CPL_INIT 1
#define CPL_GETCOUNT 2
#define CPL_INQUIRE 3
#define CPL_SELECT 4
#define CPL_DBLCLK 5
#define CPL_STOP 6
#define CPL_EXIT 7
#define CPL_NEWINQUIRE 8
#define CPL_STARTWPARMSA 9
#define CPL_STARTWPARMSW 10
#define CPL_SETUP 200

type APPLET_PROC as function(byval as HWND, byval as UINT, byval as LONG, byval as LONG) as LONG

type CPLINFO
	idIcon as integer
	idName as integer
	idInfo as integer
	lData as LONG
end type

type LPCPLINFO as CPLINFO ptr

#ifndef UNICODE
type NEWCPLINFOA
	dwSize as DWORD
	dwFlags as DWORD
	dwHelpContext as DWORD
	lData as LONG
	hIcon as HICON
	szName as zstring * 32
	szInfo as zstring * 64
	szHelpFile as zstring * 128
end type

type LPNEWCPLINFOA as NEWCPLINFOA ptr
type NEWCPLINFO as NEWCPLINFOA
type LPNEWCPLINFO as NEWCPLINFOA ptr

#else
type NEWCPLINFOW
	dwSize as DWORD
	dwFlags as DWORD
	dwHelpContext as DWORD
	lData as LONG
	hIcon as HICON
	szName as wstring * 32
	szInfo as wstring * 64
	szHelpFile as wstring * 128
end type

type LPNEWCPLINFOW as NEWCPLINFOW ptr
type NEWCPLINFO as NEWCPLINFOW
type LPNEWCPLINFO as NEWCPLINFOW ptr
#endif

#define CPL_STARTWPARMS 9


#endif
