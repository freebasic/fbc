'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DirectMusic Buffer Format
''
''   Copyright (C) 2003-2004 Rok Mandeljc
''
''   This program is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This program is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "dmdls.bi"

#define __WINE_DMUSIC_BUFFER_H
#define QWORD_ALIGN(x) (((x) + 7) and (not 7))
#define DMUS_EVENT_SIZE(cb) QWORD_ALIGN(sizeof(DMUS_EVENTHEADER) + cb)
const DMUS_EVENT_STRUCTURED = &h1
type DMUS_EVENTHEADER as _DMUS_EVENTHEADER
type LPDMUS_EVENTHEADER as _DMUS_EVENTHEADER ptr

type _DMUS_EVENTHEADER field = 4
	cbEvent as DWORD
	dwChannelGroup as DWORD
	rtDelta as REFERENCE_TIME
	dwFlags as DWORD
end type
