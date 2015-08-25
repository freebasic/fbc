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

#include once "_mingw_unicode.bi"

extern "Windows"

#define _LZEXPAND_
const LZERROR_BADINHANDLE = -1
const LZERROR_BADOUTHANDLE = -2
const LZERROR_READ = -3
const LZERROR_WRITE = -4
const LZERROR_GLOBALLOC = -5
const LZERROR_GLOBLOCK = -6
const LZERROR_BADVALUE = -7
const LZERROR_UNKNOWNALG = -8

declare function LZStart() as INT_
declare sub LZDone()
declare function CopyLZFile(byval as INT_, byval as INT_) as LONG
declare function LZCopy(byval as INT_, byval as INT_) as LONG
declare function LZInit(byval as INT_) as INT_
declare function GetExpandedNameA(byval as LPSTR, byval as LPSTR) as INT_

#ifndef UNICODE
	declare function GetExpandedName alias "GetExpandedNameA"(byval as LPSTR, byval as LPSTR) as INT_
#endif

declare function GetExpandedNameW(byval as LPWSTR, byval as LPWSTR) as INT_

#ifdef UNICODE
	declare function GetExpandedName alias "GetExpandedNameW"(byval as LPWSTR, byval as LPWSTR) as INT_
#endif

declare function LZOpenFileA(byval as LPSTR, byval as LPOFSTRUCT, byval as WORD) as INT_

#ifndef UNICODE
	declare function LZOpenFile alias "LZOpenFileA"(byval as LPSTR, byval as LPOFSTRUCT, byval as WORD) as INT_
#endif

declare function LZOpenFileW(byval as LPWSTR, byval as LPOFSTRUCT, byval as WORD) as INT_

#ifdef UNICODE
	declare function LZOpenFile alias "LZOpenFileW"(byval as LPWSTR, byval as LPOFSTRUCT, byval as WORD) as INT_
#endif

declare function LZSeek(byval as INT_, byval as LONG, byval as INT_) as LONG
declare function LZRead(byval as INT_, byval as LPSTR, byval as INT_) as INT_
declare sub LZClose(byval as INT_)

end extern
