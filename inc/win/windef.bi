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

#include once "_mingw.bi"
#include once "winapifamily.bi"

'' The following symbols have been renamed:
''     constant TRUE => CTRUE
''     typedef BYTE => UBYTE
''     typedef INT => INT_

extern "Windows"

#define _WINDEF_
#define _MINWINDEF_
#define BASETYPES

type PULONG as ULONG ptr
type PUSHORT as USHORT ptr
type UCHAR as ubyte
type PUCHAR as UCHAR ptr
type PSZ as zstring ptr

#ifndef MAX_PATH
const MAX_PATH = 260
#endif
#ifndef NULL
	const NULL = 0
#endif
#ifndef FALSE
	const FALSE = 0
#endif
#ifndef CTRUE
	const CTRUE = 1
#endif
#ifndef TRUE
	const TRUE = 1
#endif
#define _DEF_WINBOOL_

type WINBOOL as long
type BOOL as long
type PBOOL as WINBOOL ptr
type LPBOOL as WINBOOL ptr
type WORD as ushort
type DWORD as ulong
type FLOAT as single
type PFLOAT as FLOAT ptr
type PBYTE as UBYTE ptr
type LPBYTE as UBYTE ptr
type PINT as long ptr
type LPINT as long ptr
type PWORD as WORD ptr
type LPWORD as WORD ptr
type LPLONG as long ptr
type PDWORD as DWORD ptr
type LPDWORD as DWORD ptr
type LPVOID as any ptr
#define _LPCVOID_DEFINED
type LPCVOID as const any ptr
type INT_ as long
type UINT as ulong
type PUINT as ulong ptr
type WPARAM as UINT_PTR
type LPARAM as LONG_PTR
type LRESULT as LONG_PTR

#define max(a, b) iif((a) > (b), (a), (b))
#define min(a, b) iif((a) < (b), (a), (b))
#define MAKEWORD(a, b) cast(WORD, cast(UBYTE, cast(DWORD_PTR, (a)) and &hff) or (cast(WORD, cast(UBYTE, cast(DWORD_PTR, (b)) and &hff)) shl 8))
#define MAKELONG(a, b) cast(LONG, cast(WORD, cast(DWORD_PTR, (a)) and &hffff) or (cast(DWORD, cast(WORD, cast(DWORD_PTR, (b)) and &hffff)) shl 16))

type SPHANDLE as HANDLE ptr
type LPHANDLE as HANDLE ptr
type HGLOBAL as HANDLE
type HLOCAL as HANDLE
type GLOBALHANDLE as HANDLE
type LOCALHANDLE as HANDLE

end extern

#include once "basetsd.bi"

extern "Windows"

#ifdef __FB_64BIT__
	type FARPROC as function() as INT_PTR
	type NEARPROC as function() as INT_PTR
	type PROC as function() as INT_PTR
#else
	type FARPROC as function() as long
	type NEARPROC as function() as long
	type PROC as function() as long
#endif

type ATOM as WORD
type HFILE as long

type HINSTANCE__
	unused as long
end type

type HINSTANCE as HINSTANCE__ ptr

type HKEY__
	unused as long
end type

type HKEY as HKEY__ ptr
type PHKEY as HKEY ptr

type HKL__
	unused as long
end type

type HKL as HKL__ ptr

type HLSURF__
	unused as long
end type

type HLSURF as HLSURF__ ptr

type HMETAFILE__
	unused as long
end type

type HMETAFILE as HMETAFILE__ ptr
type HMODULE as HINSTANCE

type HRGN__
	unused as long
end type

type HRGN as HRGN__ ptr

type HRSRC__
	unused as long
end type

type HRSRC as HRSRC__ ptr

type HSPRITE__
	unused as long
end type

type HSPRITE as HSPRITE__ ptr

type HSTR__
	unused as long
end type

type HSTR as HSTR__ ptr

type HTASK__
	unused as long
end type

type HTASK as HTASK__ ptr

type HWINSTA__
	unused as long
end type

type HWINSTA as HWINSTA__ ptr

type _FILETIME
	dwLowDateTime as DWORD
	dwHighDateTime as DWORD
end type

type FILETIME as _FILETIME
type PFILETIME as _FILETIME ptr
type LPFILETIME as _FILETIME ptr
#define _FILETIME_

type HWND__
	unused as long
end type

type HWND as HWND__ ptr

type HHOOK__
	unused as long
end type

type HHOOK as HHOOK__ ptr
type HGDIOBJ as any ptr

type HACCEL__
	unused as long
end type

type HACCEL as HACCEL__ ptr

type HBITMAP__
	unused as long
end type

type HBITMAP as HBITMAP__ ptr

type HBRUSH__
	unused as long
end type

type HBRUSH as HBRUSH__ ptr

type HCOLORSPACE__
	unused as long
end type

type HCOLORSPACE as HCOLORSPACE__ ptr

type HDC__
	unused as long
end type

type HDC as HDC__ ptr

type HGLRC__
	unused as long
end type

type HGLRC as HGLRC__ ptr

type HDESK__
	unused as long
end type

type HDESK as HDESK__ ptr

type HENHMETAFILE__
	unused as long
end type

type HENHMETAFILE as HENHMETAFILE__ ptr

type HFONT__
	unused as long
end type

type HFONT as HFONT__ ptr

type HICON__
	unused as long
end type

type HICON as HICON__ ptr

type HMENU__
	unused as long
end type

type HMENU as HMENU__ ptr

type HPALETTE__
	unused as long
end type

type HPALETTE as HPALETTE__ ptr

type HPEN__
	unused as long
end type

type HPEN as HPEN__ ptr

type HMONITOR__
	unused as long
end type

type HMONITOR as HMONITOR__ ptr

type HWINEVENTHOOK__
	unused as long
end type

type HWINEVENTHOOK as HWINEVENTHOOK__ ptr
type HCURSOR as HICON
type COLORREF as DWORD

type HUMPD__
	unused as long
end type

type HUMPD as HUMPD__ ptr
type LPCOLORREF as DWORD ptr
const HFILE_ERROR = cast(HFILE, -1)

type tagRECT
	left as LONG
	top as LONG
	right as LONG
	bottom as LONG
end type

type RECT as tagRECT
type PRECT as tagRECT ptr
type NPRECT as tagRECT ptr
type LPRECT as tagRECT ptr
type LPCRECT as const RECT ptr

type _RECTL
	left as LONG
	top as LONG
	right as LONG
	bottom as LONG
end type

type RECTL as _RECTL
type PRECTL as _RECTL ptr
type LPRECTL as _RECTL ptr
type LPCRECTL as const RECTL ptr

type tagPOINT
	x as LONG
	y as LONG
end type

type POINT as tagPOINT
type PPOINT as tagPOINT ptr
type NPPOINT as tagPOINT ptr
type LPPOINT as tagPOINT ptr

type _POINTL
	x as LONG
	y as LONG
end type

type POINTL as _POINTL
type PPOINTL as _POINTL ptr

type tagSIZE
	cx as LONG
	cy as LONG
end type

type SIZE as tagSIZE
type PSIZE as tagSIZE ptr
type LPSIZE as tagSIZE ptr
type SIZEL as SIZE
type PSIZEL as SIZE ptr
type LPSIZEL as SIZE ptr

type tagPOINTS
	x as SHORT
	y as SHORT
end type

type POINTS as tagPOINTS
type PPOINTS as tagPOINTS ptr
type LPPOINTS as tagPOINTS ptr

const DM_UPDATE = 1
const DM_COPY = 2
const DM_PROMPT = 4
const DM_MODIFY = 8
#define DM_IN_BUFFER DM_MODIFY
#define DM_IN_PROMPT DM_PROMPT
#define DM_OUT_BUFFER DM_COPY
#define DM_OUT_DEFAULT DM_UPDATE
const DC_FIELDS = 1
const DC_PAPERS = 2
const DC_PAPERSIZE = 3
const DC_MINEXTENT = 4
const DC_MAXEXTENT = 5
const DC_BINS = 6
const DC_DUPLEX = 7
const DC_SIZE = 8
const DC_EXTRA = 9
const DC_VERSION = 10
const DC_DRIVER = 11
const DC_BINNAMES = 12
const DC_ENUMRESOLUTIONS = 13
const DC_FILEDEPENDENCIES = 14
const DC_TRUETYPE = 15
const DC_PAPERNAMES = 16
const DC_ORIENTATION = 17
const DC_COPIES = 18

end extern

#include once "winnt.bi"
