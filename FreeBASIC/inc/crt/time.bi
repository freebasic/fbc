''
''
'' time -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_time_bi__
#define __crt_time_bi__

#include once "crt/stddef.bi"
#include once "crt/sys/types.bi"

#if defined(__FB_WIN32__)
#include once "crt/win32/time.bi"
#elseif defined(__FB_DOS__)
#include once "crt/dos/time.bi"
#elseif defined(__FB_LINUX__)
#include once "crt/linux/time.bi"
#endif

extern "c"
declare function clock () as clock_t
declare function time_ alias "time" (byval as time_t ptr = NULL) as time_t
declare function difftime (byval as time_t, byval as time_t) as double
declare function mktime (byval as tm ptr) as time_t
declare function asctime (byval as tm ptr) as zstring ptr
declare function ctime (byval as time_t ptr) as zstring ptr
declare function gmtime (byval as time_t ptr) as tm ptr
declare function localtime (byval as time_t ptr) as tm ptr
declare function strftime (byval as zstring ptr, byval as size_t, byval as zstring ptr, byval as tm ptr) as size_t
declare function wcsftime (byval as wchar_t ptr, byval as size_t, byval as wchar_t ptr, byval as tm ptr) as size_t
end extern

#endif
