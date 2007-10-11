''
''
'' rasdlg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_rasdlg_bi__
#define __win_rasdlg_bi__

#inclib "rasdlg"

#include once "win/ras.bi"

#define RASPBDEVENT_AddEntry 1
#define RASPBDEVENT_EditEntry 2
#define RASPBDEVENT_RemoveEntry 3
#define RASPBDEVENT_DialEntry 4
#define RASPBDEVENT_EditGlobals 5
#define RASPBDEVENT_NoUser 6
#define RASPBDEVENT_NoUserEdit 7
#define RASPBDFLAG_PositionDlg 1
#define RASPBDFLAG_ForceCloseOnDial 2
#define RASPBDFLAG_NoUser 16
#define RASEDFLAG_PositionDlg 1
#define RASEDFLAG_NewEntry 2
#define RASEDFLAG_CloneEntry 4
#define RASDDFLAG_PositionDlg 1

#ifndef UNICODE
type RASENTRYDLGA
	dwSize as DWORD
	hwndOwner as HWND
	dwFlags as DWORD
	xDlg as LONG
	yDlg as LONG
	szEntry as zstring * 256+1
	dwError as DWORD
	reserved as ULONG_PTR
	reserved2 as ULONG_PTR
end type

type LPRASENTRYDLGA as RASENTRYDLGA ptr

#else
type RASENTRYDLGW
	dwSize as DWORD
	hwndOwner as HWND
	dwFlags as DWORD
	xDlg as LONG
	yDlg as LONG
	szEntry as wstring * 256+1
	dwError as DWORD
	reserved as ULONG_PTR
	reserved2 as ULONG_PTR
end type

type LPRASENTRYDLGW as RASENTRYDLGW ptr
#endif

type RASDIALDLG
	dwSize as DWORD
	hwndOwner as HWND
	dwFlags as DWORD
	xDlg as LONG
	yDlg as LONG
	dwSubEntry as DWORD
	dwError as DWORD
	reserved as ULONG_PTR
	reserved2 as ULONG_PTR
end type

type LPRASDIALDLG as RASDIALDLG ptr

#ifndef UNICODE
type RASPBDLGFUNCA as sub (byval as DWORD, byval as DWORD, byval as LPSTR, byval as LPVOID)

type RASPBDLGA
	dwSize as DWORD
	hwndOwner as HWND
	dwFlags as DWORD
	xDlg as LONG
	yDlg as LONG
	dwCallbackId as ULONG_PTR
	pCallback as RASPBDLGFUNCA
	dwError as DWORD
	reserved as ULONG_PTR
	reserved2 as ULONG_PTR
end type

type LPRASPBDLGA as RASPBDLGA ptr

#else
type RASPBDLGFUNCW as sub (byval as DWORD, byval as DWORD, byval as LPWSTR, byval as LPVOID)

type RASPBDLGW
	dwSize as DWORD
	hwndOwner as HWND
	dwFlags as DWORD
	xDlg as LONG
	yDlg as LONG
	dwCallbackId as ULONG_PTR
	pCallback as RASPBDLGFUNCW
	dwError as DWORD
	reserved as ULONG_PTR
	reserved2 as ULONG_PTR
end type

type LPRASPBDLGW as RASPBDLGW ptr
#endif

#ifndef UNICODE
type RASNOUSERA
	dwSize as DWORD
	dwFlags as DWORD
	dwTimeoutMs as DWORD
	szUserName as zstring * 256+1
	szPassword as zstring * 256+1
	szDomain as zstring * 15+1
end type

type LPRASNOUSERA as RASNOUSERA ptr

#else
type RASNOUSERW
	dwSize as DWORD
	dwFlags as DWORD
	dwTimeoutMs as DWORD
	szUserName as wstring * 256+1
	szPassword as wstring * 256+1
	szDomain as wstring * 15+1
end type

type LPRASNOUSERW as RASNOUSERW ptr
#endif

#ifdef UNICODE
type RASENTRYDLG as RASENTRYDLGW
type LPRASENTRYDLG as RASENTRYDLGW ptr
type RASPBDLG as RASPBDLGW
type LPRASPBDLG as RASPBDLGW ptr
type RASNOUSER as RASNOUSERW
type LPRASNOUSER as RASNOUSERW ptr

declare function RasDialDlg alias "RasDialDlgW" (byval as LPWSTR, byval as LPWSTR, byval as LPWSTR, byval as LPRASDIALDLG) as BOOL
declare function RasEntryDlg alias "RasEntryDlgW" (byval as LPWSTR, byval as LPWSTR, byval as LPRASENTRYDLGW) as BOOL
declare function RasPhonebookDlg alias "RasPhonebookDlgW" (byval as LPWSTR, byval as LPWSTR, byval as LPRASPBDLGW) as BOOL

#else
type RASENTRYDLG as RASENTRYDLGA
type LPRASENTRYDLG as RASENTRYDLGA ptr
type RASPBDLG as RASPBDLGA
type LPRASPBDLG as RASPBDLGA ptr
type RASNOUSER as RASNOUSERA
type LPRASNOUSER as RASNOUSERA ptr

declare function RasDialDlg alias "RasDialDlgA" (byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as LPRASDIALDLG) as BOOL
declare function RasEntryDlg alias "RasEntryDlgA" (byval as LPSTR, byval as LPSTR, byval as LPRASENTRYDLGA) as BOOL
declare function RasPhonebookDlg alias "RasPhonebookDlgA" (byval as LPSTR, byval as LPSTR, byval as LPRASPBDLGA) as BOOL
#endif

#endif
