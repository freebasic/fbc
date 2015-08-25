'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2004 Robert Reif
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

#inclib "dxerr9"

#include once "_mingw_unicode.bi"
#include once "dxerr8.bi"

extern "Windows"

#define __WINE_DXERR9_H
declare function DXGetErrorString9A(byval hr as HRESULT) as const zstring ptr
declare function DXGetErrorString9W(byval hr as HRESULT) as const wstring ptr

#ifdef UNICODE
	declare function DXGetErrorString9 alias "DXGetErrorString9W"(byval hr as HRESULT) as const wstring ptr
#else
	declare function DXGetErrorString9 alias "DXGetErrorString9A"(byval hr as HRESULT) as const zstring ptr
#endif

declare function DXGetErrorDescription9A(byval hr as HRESULT) as const zstring ptr
declare function DXGetErrorDescription9W(byval hr as HRESULT) as const wstring ptr

#ifdef UNICODE
	declare function DXGetErrorDescription9 alias "DXGetErrorDescription9W"(byval hr as HRESULT) as const wstring ptr
#else
	declare function DXGetErrorDescription9 alias "DXGetErrorDescription9A"(byval hr as HRESULT) as const zstring ptr
#endif

end extern
