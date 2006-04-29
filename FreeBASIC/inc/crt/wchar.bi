''
''
'' wchar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_wchar_bi__
#define __crt_wchar_bi__

#include once "crt/stdio.bi"
#include once "crt/stdlib.bi"
#include once "crt/string.bi"
#include once "crt/time.bi"
#include once "crt/sys/types.bi"
#include once "crt/stddef.bi"

#if defined(__FB_WIN32__)
#include once "crt/win32/wchar.bi"
#elseif defined(__FB_LINUX__)
#include once "crt/linux/wchar.bi"
#elseif defined(__FB_DOS__)
#include once "crt/dos/wchar.bi"
#endif

declare function btowc cdecl alias "btowc" (byval as integer) as wint_t
declare function mbrlen cdecl alias "mbrlen" (byval as zstring ptr, byval as size_t, byval as mbstate_t ptr) as size_t
declare function mbrtowc cdecl alias "mbrtowc" (byval as wchar_t ptr, byval as zstring ptr, byval as size_t, byval as mbstate_t ptr) as size_t
declare function mbsrtowcs cdecl alias "mbsrtowcs" (byval as wchar_t ptr, byval as zstring ptr ptr, byval as size_t, byval as mbstate_t ptr) as size_t
declare function wcrtomb cdecl alias "wcrtomb" (byval as zstring ptr, byval as wchar_t, byval as mbstate_t ptr) as size_t
declare function wcsrtombs cdecl alias "wcsrtombs" (byval as zstring ptr, byval as wchar_t ptr ptr, byval as size_t, byval as mbstate_t ptr) as size_t
declare function wctob cdecl alias "wctob" (byval as wint_t) as integer
declare function fwide cdecl alias "fwide" (byval stream as FILE ptr, byval mode as integer) as integer
declare function mbsinit cdecl alias "mbsinit" (byval ps as mbstate_t ptr) as integer
declare function wmemset cdecl alias "wmemset" (byval s as wchar_t ptr, byval c as wchar_t, byval n as size_t) as wchar_t ptr
declare function wmemchr cdecl alias "wmemchr" (byval s as wchar_t ptr, byval c as wchar_t, byval n as size_t) as wchar_t ptr
declare function wmemcmp cdecl alias "wmemcmp" (byval s1 as wchar_t ptr, byval s2 as wchar_t ptr, byval n as size_t) as integer
declare function wmemmove cdecl alias "wmemmove" (byval s1 as wchar_t ptr, byval s2 as wchar_t ptr, byval n as size_t) as wchar_t ptr

#endif
