'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2006 Hans Leidekker
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "_mingw_unicode.bi"
#include once "vfwmsgs.bi"

extern "Windows"

#define __ERRORS__
#define AMOVIEAPI
const VFW_FIRST_CODE = &h200
const MAX_ERROR_TEXT_LEN = 160
type AMGETERRORTEXTPROCA as function(byval as HRESULT, byval as zstring ptr, byval as DWORD) as WINBOOL
type AMGETERRORTEXTPROCW as function(byval as HRESULT, byval as wstring ptr, byval as DWORD) as WINBOOL

#ifdef UNICODE
	type AMGETERRORTEXTPROC as AMGETERRORTEXTPROCW
#else
	type AMGETERRORTEXTPROC as AMGETERRORTEXTPROCA
#endif

declare function AMGetErrorTextA(byval as HRESULT, byval as LPSTR, byval as DWORD) as DWORD
declare function AMGetErrorTextW(byval as HRESULT, byval as LPWSTR, byval as DWORD) as DWORD

#ifdef UNICODE
	declare function AMGetErrorText alias "AMGetErrorTextW"(byval as HRESULT, byval as LPWSTR, byval as DWORD) as DWORD
#else
	declare function AMGetErrorText alias "AMGetErrorTextA"(byval as HRESULT, byval as LPSTR, byval as DWORD) as DWORD
#endif

end extern
