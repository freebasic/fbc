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

extern "c"
declare function btowc (byval as long) as wint_t
declare function mbrlen (byval as zstring ptr, byval as size_t, byval as mbstate_t ptr) as size_t
declare function mbrtowc (byval as wchar_t ptr, byval as zstring ptr, byval as size_t, byval as mbstate_t ptr) as size_t
declare function mbsrtowcs (byval as wchar_t ptr, byval as zstring ptr ptr, byval as size_t, byval as mbstate_t ptr) as size_t
declare function wcrtomb (byval as zstring ptr, byval as wchar_t, byval as mbstate_t ptr) as size_t
declare function wcsrtombs (byval as zstring ptr, byval as wchar_t ptr ptr, byval as size_t, byval as mbstate_t ptr) as size_t
declare function wctob (byval as wint_t) as integer
declare function fwide (byval stream as FILE ptr, byval mode as long) as long
declare function mbsinit (byval ps as mbstate_t ptr) as long
declare function wmemset (byval s as wchar_t ptr, byval c as wchar_t, byval n as size_t) as wchar_t ptr
declare function wmemchr (byval s as wchar_t ptr, byval c as wchar_t, byval n as size_t) as wchar_t ptr
declare function wmemcmp (byval s1 as wchar_t ptr, byval s2 as wchar_t ptr, byval n as size_t) as integer
declare function wmemmove (byval s1 as wchar_t ptr, byval s2 as wchar_t ptr, byval n as size_t) as wchar_t ptr
end extern

#endif
