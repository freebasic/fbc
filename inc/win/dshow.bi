'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2002 Alexandre Julliard
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

#include once "windows.bi"
#include once "windowsx.bi"
#include once "olectl.bi"
#include once "ddraw.bi"
#include once "mmsystem.bi"
#include once "strsafe.bi"
#include once "strmif.bi"
#include once "amvideo.bi"
#include once "control.bi"
#include once "evcode.bi"
#include once "uuids.bi"
#include once "errors.bi"
#include once "audevcod.bi"

#define __DSHOW_INCLUDED__
#define AM_NOVTABLE
#define NO_SHLWAPI_STRFCNS
#define NUMELMS(array) (ubound(array) - lbound(array) + 1)
const OATRUE = -1
const OAFALSE = 0
