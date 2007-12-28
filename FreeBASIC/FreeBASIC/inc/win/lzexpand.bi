''
''
'' lzexpand -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_lzexpand_bi__
#define __win_lzexpand_bi__

#define LZERROR_BADINHANDLE (-1)
#define LZERROR_BADOUTHANDLE (-2)
#define LZERROR_READ (-3)
#define LZERROR_WRITE (-4)
#define LZERROR_GLOBALLOC (-5)
#define LZERROR_GLOBLOCK (-6)
#define LZERROR_BADVALUE (-7)
#define LZERROR_UNKNOWNALG (-8)

declare function CopyLZFile alias "CopyLZFile" (byval as INT_, byval as INT_) as LONG
declare sub LZClose alias "LZClose" (byval as INT_)
declare function LZCopy alias "LZCopy" (byval as INT_, byval as INT_) as LONG
declare sub LZDone alias "LZDone" ()
declare function LZInit alias "LZInit" (byval as INT_) as INT_
declare function LZRead alias "LZRead" (byval as INT_, byval as LPSTR, byval as INT_) as INT_
declare function LZSeek alias "LZSeek" (byval as INT_, byval as LONG, byval as INT_) as LONG
declare function LZStart alias "LZStart" () as INT_

#ifdef UNICODE
declare function LZOpenFile alias "LZOpenFileW" (byval as LPWSTR, byval as LPOFSTRUCT, byval as WORD) as INT_
declare function GetExpandedName alias "GetExpandedNameW" (byval as LPWSTR, byval as LPWSTR) as INT_
#else ''UNICODE
declare function LZOpenFile alias "LZOpenFileA" (byval as LPSTR, byval as LPOFSTRUCT, byval as WORD) as INT_
declare function GetExpandedName alias "GetExpandedNameA" (byval as LPSTR, byval as LPSTR) as INT_
#endif ''UNICODE

#endif
