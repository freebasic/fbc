'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "rasdlg"

#include once "winapifamily.bi"
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

type tagRASNOUSERW field = 4
	dwSize as DWORD
	dwFlags as DWORD
	dwTimeoutMs as DWORD
	szUserName as wstring * 256 + 1
	szPassword as wstring * 256 + 1
	szDomain as wstring * 15 + 1
end type

type tagRASNOUSERA field = 4
	dwSize as DWORD
	dwFlags as DWORD
	dwTimeoutMs as DWORD
	szUserName as zstring * 256 + 1
	szPassword as zstring * 256 + 1
	szDomain as zstring * 15 + 1
end type

#ifdef UNICODE
	type RASNOUSER as RASNOUSERW
#else
	type RASNOUSER as RASNOUSERA
#endif

type RASNOUSERW as tagRASNOUSERW
type RASNOUSERA as tagRASNOUSERA
type LPRASNOUSERW as RASNOUSERW ptr
type LPRASNOUSERA as RASNOUSERA ptr
type LPRASNOUSER as RASNOUSER ptr

const RASPBDFLAG_PositionDlg = &h00000001
const RASPBDFLAG_ForceCloseOnDial = &h00000002
const RASPBDFLAG_NoUser = &h00000010
const RASPBDFLAG_UpdateDefaults = &h80000000

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
	type RASPBDLG as RASPBDLGW
	type RASPBDLGFUNC as RASPBDLGFUNCW
#else
	type RASPBDLG as RASPBDLGA
	type RASPBDLGFUNC as RASPBDLGFUNCA
#endif

type RASPBDLGW as tagRASPBDLGW
type RASPBDLGA as tagRASPBDLGA
type LPRASPBDLGW as RASPBDLGW ptr
type LPRASPBDLGA as RASPBDLGA ptr
type LPRASPBDLG as RASPBDLG ptr
const RASEDFLAG_PositionDlg = &h00000001
const RASEDFLAG_NewEntry = &h00000002

#if _WIN32_WINNT <= &h0502
	const RASEDFLAG_CloneEntry = &h00000004
#endif

const RASEDFLAG_NoRename = &h00000008
const RASEDFLAG_ShellOwned = &h40000000
const RASEDFLAG_NewPhoneEntry = &h00000010
const RASEDFLAG_NewTunnelEntry = &h00000020

#if _WIN32_WINNT <= &h0502
	const RASEDFLAG_NewDirectEntry = &h00000040
#endif

const RASEDFLAG_NewBroadbandEntry = &h00000080
const RASEDFLAG_InternetEntry = &h00000100
const RASEDFLAG_NAT = &h00000200

#if _WIN32_WINNT >= &h0600
	const RASEDFLAG_IncomingConnection = &h00000400
#endif

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

type RASENTRYDLGW as tagRASENTRYDLGW
type RASENTRYDLGA as tagRASENTRYDLGA
type LPRASENTRYDLGW as RASENTRYDLGW ptr
type LPRASENTRYDLGA as RASENTRYDLGA ptr
type LPRASENTRYDLG as RASENTRYDLG ptr

const RASDDFLAG_PositionDlg = &h00000001
const RASDDFLAG_NoPrompt = &h00000002
const RASDDFLAG_LinkFailure = &h80000000

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

type RASDIALDLG as tagRASDIALDLG
type LPRASDIALDLG as RASDIALDLG ptr
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
	declare function RasPhonebookDlg alias "RasPhonebookDlgW"(byval lpszPhonebook as LPWSTR, byval lpszEntry as LPWSTR, byval lpInfo as tagRASPBDLGW ptr) as WINBOOL
	declare function RasEntryDlg alias "RasEntryDlgW"(byval lpszPhonebook as LPWSTR, byval lpszEntry as LPWSTR, byval lpInfo as tagRASENTRYDLGW ptr) as WINBOOL
	declare function RasDialDlg alias "RasDialDlgW"(byval lpszPhonebook as LPWSTR, byval lpszEntry as LPWSTR, byval lpszPhoneNumber as LPWSTR, byval lpInfo as tagRASDIALDLG ptr) as WINBOOL
#else
	declare function RasPhonebookDlg alias "RasPhonebookDlgA"(byval lpszPhonebook as LPSTR, byval lpszEntry as LPSTR, byval lpInfo as tagRASPBDLGA ptr) as WINBOOL
	declare function RasEntryDlg alias "RasEntryDlgA"(byval lpszPhonebook as LPSTR, byval lpszEntry as LPSTR, byval lpInfo as tagRASENTRYDLGA ptr) as WINBOOL
	declare function RasDialDlg alias "RasDialDlgA"(byval lpszPhonebook as LPSTR, byval lpszEntry as LPSTR, byval lpszPhoneNumber as LPSTR, byval lpInfo as tagRASDIALDLG ptr) as WINBOOL
#endif

end extern
