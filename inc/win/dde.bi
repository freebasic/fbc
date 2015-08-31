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

#include once "windef.bi"

'' The following symbols have been renamed:
''     inside struct DDEUP:
''         field rgb => rgb_

extern "Windows"

#define _DDEHEADER_INCLUDED_
const WM_DDE_FIRST = &h03E0
const WM_DDE_INITIATE = WM_DDE_FIRST
const WM_DDE_TERMINATE = WM_DDE_FIRST + 1
const WM_DDE_ADVISE = WM_DDE_FIRST + 2
const WM_DDE_UNADVISE = WM_DDE_FIRST + 3
const WM_DDE_ACK = WM_DDE_FIRST + 4
const WM_DDE_DATA = WM_DDE_FIRST + 5
const WM_DDE_REQUEST = WM_DDE_FIRST + 6
const WM_DDE_POKE = WM_DDE_FIRST + 7
const WM_DDE_EXECUTE = WM_DDE_FIRST + 8
const WM_DDE_LAST = WM_DDE_FIRST + 8

type DDEACK
	bAppReturnCode : 8 as ushort
	reserved : 6 as ushort
	fBusy : 1 as ushort
	fAck : 1 as ushort
end type

type DDEADVISE
	reserved : 14 as ushort
	fDeferUpd : 1 as ushort
	fAckReq : 1 as ushort
	cfFormat as short
end type

type DDEDATA
	unused : 12 as ushort
	fResponse : 1 as ushort
	fRelease : 1 as ushort
	reserved : 1 as ushort
	fAckReq : 1 as ushort
	cfFormat as short
	Value(0 to 0) as UBYTE
end type

type DDEPOKE
	unused : 13 as ushort
	fRelease : 1 as ushort
	fReserved : 2 as ushort
	cfFormat as short
	Value(0 to 0) as UBYTE
end type

type DDELN
	unused : 13 as ushort
	fRelease : 1 as ushort
	fDeferUpd : 1 as ushort
	fAckReq : 1 as ushort
	cfFormat as short
end type

type DDEUP
	unused : 12 as ushort
	fAck : 1 as ushort
	fRelease : 1 as ushort
	fReserved : 1 as ushort
	fAckReq : 1 as ushort
	cfFormat as short
	rgb_(0 to 0) as UBYTE
end type

declare function DdeSetQualityOfService(byval hwndClient as HWND, byval pqosNew as const SECURITY_QUALITY_OF_SERVICE ptr, byval pqosPrev as PSECURITY_QUALITY_OF_SERVICE) as WINBOOL
declare function ImpersonateDdeClientWindow(byval hWndClient as HWND, byval hWndServer as HWND) as WINBOOL
declare function PackDDElParam(byval msg as UINT, byval uiLo as UINT_PTR, byval uiHi as UINT_PTR) as LPARAM
declare function UnpackDDElParam(byval msg as UINT, byval lParam as LPARAM, byval puiLo as PUINT_PTR, byval puiHi as PUINT_PTR) as WINBOOL
declare function FreeDDElParam(byval msg as UINT, byval lParam as LPARAM) as WINBOOL
declare function ReuseDDElParam(byval lParam as LPARAM, byval msgIn as UINT, byval msgOut as UINT, byval uiLo as UINT_PTR, byval uiHi as UINT_PTR) as LPARAM

end extern
