'' FreeBASIC binding for mingw-w64-v3.3.0

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

#ifdef UNICODE
	#define GetExpandedName GetExpandedNameW
	#define LZOpenFile LZOpenFileW
#else
	#define GetExpandedName GetExpandedNameA
	#define LZOpenFile LZOpenFileA
#endif

declare function LZStart() as INT_
declare sub LZDone()
declare function CopyLZFile(byval as INT_, byval as INT_) as LONG
declare function LZCopy(byval as INT_, byval as INT_) as LONG
declare function LZInit(byval as INT_) as INT_
declare function GetExpandedNameA(byval as LPSTR, byval as LPSTR) as INT_
declare function GetExpandedNameW(byval as LPWSTR, byval as LPWSTR) as INT_
declare function LZOpenFileA(byval as LPSTR, byval as LPOFSTRUCT, byval as WORD) as INT_
declare function LZOpenFileW(byval as LPWSTR, byval as LPOFSTRUCT, byval as WORD) as INT_
declare function LZSeek(byval as INT_, byval as LONG, byval as INT_) as LONG
declare function LZRead(byval as INT_, byval as LPSTR, byval as INT_) as INT_
declare sub LZClose(byval as INT_)

end extern
