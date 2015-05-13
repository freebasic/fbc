#pragma once

#inclib "rasdlg"

#include once "_mingw_unicode.bi"
#include once "ras.bi"

extern "Windows"

#define _RASDLG_H_
type RASPBDLGFUNCW as sub(byval as ULONG_PTR, byval as DWORD, byval as LPWSTR, byval as LPVOID)
type RASPBDLGFUNCA as sub(byval as ULONG_PTR, byval as DWORD, byval as LPSTR, byval as LPVOID)
const RASPBDEVENT_AddEntry = 1
const RASPBDEVENT_EditEntry = 2
const RASPBDEVENT_RemoveEntry = 3
const RASPBDEVENT_DialEntry = 4
const RASPBDEVENT_EditGlobals = 5
const RASPBDEVENT_NoUser = 6
const RASPBDEVENT_NoUserEdit = 7
const RASNOUSER_SmartCard = &h00000001
#define RASNOUSERW tagRASNOUSERW

type tagRASNOUSERW field = 4
	dwSize as DWORD
	dwFlags as DWORD
	dwTimeoutMs as DWORD
	szUserName as wstring * 256 + 1
	szPassword as wstring * 256 + 1
	szDomain as wstring * 15 + 1
end type

#define RASNOUSERA tagRASNOUSERA

type tagRASNOUSERA field = 4
	dwSize as DWORD
	dwFlags as DWORD
	dwTimeoutMs as DWORD
	szUserName as zstring * 256 + 1
	szPassword as zstring * 256 + 1
	szDomain as zstring * 15 + 1
end type

#ifdef UNICODE
	#define RASNOUSER RASNOUSERW
#else
	#define RASNOUSER RASNOUSERA
#endif

#define LPRASNOUSERW RASNOUSERW ptr
#define LPRASNOUSERA RASNOUSERA ptr
#define LPRASNOUSER RASNOUSER ptr
const RASPBDFLAG_PositionDlg = &h00000001
const RASPBDFLAG_ForceCloseOnDial = &h00000002
const RASPBDFLAG_NoUser = &h00000010
const RASPBDFLAG_UpdateDefaults = &h80000000
#define RASPBDLGW tagRASPBDLGW

type tagRASPBDLGW field = 4
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

#define RASPBDLGA tagRASPBDLGA

type tagRASPBDLGA field = 4
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

#ifdef UNICODE
	#define RASPBDLG RASPBDLGW
	#define RASPBDLGFUNC RASPBDLGFUNCW
#else
	#define RASPBDLG RASPBDLGA
	#define RASPBDLGFUNC RASPBDLGFUNCA
#endif

#define LPRASPBDLGW RASPBDLGW ptr
#define LPRASPBDLGA RASPBDLGA ptr
#define LPRASPBDLG RASPBDLG ptr
const RASEDFLAG_PositionDlg = &h00000001
const RASEDFLAG_NewEntry = &h00000002
const RASEDFLAG_CloneEntry = &h00000004
const RASEDFLAG_NoRename = &h00000008
const RASEDFLAG_ShellOwned = &h40000000
const RASEDFLAG_NewPhoneEntry = &h00000010
const RASEDFLAG_NewTunnelEntry = &h00000020
const RASEDFLAG_NewDirectEntry = &h00000040
const RASEDFLAG_NewBroadbandEntry = &h00000080
const RASEDFLAG_InternetEntry = &h00000100
const RASEDFLAG_NAT = &h00000200
type RASENTRYDLGW as tagRASENTRYDLGW

type tagRASENTRYDLGW field = 4
	dwSize as DWORD
	hwndOwner as HWND
	dwFlags as DWORD
	xDlg as LONG
	yDlg as LONG
	szEntry as wstring * 256 + 1
	dwError as DWORD
	reserved as ULONG_PTR
	reserved2 as ULONG_PTR
end type

type RASENTRYDLGA as tagRASENTRYDLGA

type tagRASENTRYDLGA field = 4
	dwSize as DWORD
	hwndOwner as HWND
	dwFlags as DWORD
	xDlg as LONG
	yDlg as LONG
	szEntry as zstring * 256 + 1
	dwError as DWORD
	reserved as ULONG_PTR
	reserved2 as ULONG_PTR
end type

#ifdef UNICODE
	type RASENTRYDLG as RASENTRYDLGW
#else
	type RASENTRYDLG as RASENTRYDLGA
#endif

#define LPRASENTRYDLGW RASENTRYDLGW ptr
#define LPRASENTRYDLGA RASENTRYDLGA ptr
#define LPRASENTRYDLG RASENTRYDLG ptr
const RASDDFLAG_PositionDlg = &h00000001
const RASDDFLAG_NoPrompt = &h00000002
const RASDDFLAG_LinkFailure = &h80000000
#define RASDIALDLG tagRASDIALDLG

type tagRASDIALDLG field = 4
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

#define LPRASDIALDLG RASDIALDLG ptr
type RasCustomDialDlgFn as function(byval hInstDll as HINSTANCE, byval dwFlags as DWORD, byval lpszPhonebook as LPWSTR, byval lpszEntry as LPWSTR, byval lpszPhoneNumber as LPWSTR, byval lpInfo as tagRASDIALDLG ptr, byval pvInfo as PVOID) as WINBOOL

#ifdef UNICODE
	type RasCustomEntryDlgFn as function(byval hInstDll as HINSTANCE, byval lpszPhonebook as LPWSTR, byval lpszEntry as LPWSTR, byval lpInfo as tagRASENTRYDLGW ptr, byval dwFlags as DWORD) as WINBOOL
#else
	type RasCustomEntryDlgFn as function(byval hInstDll as HINSTANCE, byval lpszPhonebook as LPWSTR, byval lpszEntry as LPWSTR, byval lpInfo as tagRASENTRYDLGA ptr, byval dwFlags as DWORD) as WINBOOL
#endif

declare function RasPhonebookDlgA(byval lpszPhonebook as LPSTR, byval lpszEntry as LPSTR, byval lpInfo as tagRASPBDLGA ptr) as WINBOOL
declare function RasPhonebookDlgW(byval lpszPhonebook as LPWSTR, byval lpszEntry as LPWSTR, byval lpInfo as tagRASPBDLGW ptr) as WINBOOL
declare function RasEntryDlgA(byval lpszPhonebook as LPSTR, byval lpszEntry as LPSTR, byval lpInfo as tagRASENTRYDLGA ptr) as WINBOOL
declare function RasEntryDlgW(byval lpszPhonebook as LPWSTR, byval lpszEntry as LPWSTR, byval lpInfo as tagRASENTRYDLGW ptr) as WINBOOL
declare function RasDialDlgA(byval lpszPhonebook as LPSTR, byval lpszEntry as LPSTR, byval lpszPhoneNumber as LPSTR, byval lpInfo as tagRASDIALDLG ptr) as WINBOOL
declare function RasDialDlgW(byval lpszPhonebook as LPWSTR, byval lpszEntry as LPWSTR, byval lpszPhoneNumber as LPWSTR, byval lpInfo as tagRASDIALDLG ptr) as WINBOOL

#ifdef UNICODE
	#define RasPhonebookDlg RasPhonebookDlgW
	declare function RasEntryDlg alias "RasEntryDlgW"(byval lpszPhonebook as LPWSTR, byval lpszEntry as LPWSTR, byval lpInfo as tagRASENTRYDLGW ptr) as WINBOOL
	declare function RasDialDlg alias "RasDialDlgW"(byval lpszPhonebook as LPWSTR, byval lpszEntry as LPWSTR, byval lpszPhoneNumber as LPWSTR, byval lpInfo as tagRASDIALDLG ptr) as WINBOOL
#else
	#define RasPhonebookDlg RasPhonebookDlgA
	declare function RasEntryDlg alias "RasEntryDlgA"(byval lpszPhonebook as LPSTR, byval lpszEntry as LPSTR, byval lpInfo as tagRASENTRYDLGA ptr) as WINBOOL
	declare function RasDialDlg alias "RasDialDlgA"(byval lpszPhonebook as LPSTR, byval lpszEntry as LPSTR, byval lpszPhoneNumber as LPSTR, byval lpInfo as tagRASDIALDLG ptr) as WINBOOL
#endif

end extern
