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

type clock_t as integer

type tm
	tm_sec as integer
	tm_min as integer
	tm_hour as integer
	tm_mday as integer
	tm_mon as integer
	tm_year as integer
	tm_wday as integer
	tm_yday as integer
	tm_isdst as integer
end type

declare function clock cdecl alias "clock" () as clock_t
declare function time_ cdecl alias "time" (byval as time_t ptr) as time_t
declare function difftime cdecl alias "difftime" (byval as time_t, byval as time_t) as double
declare function mktime cdecl alias "mktime" (byval as tm ptr) as time_t
declare function asctime cdecl alias "asctime" (byval as tm ptr) as zstring ptr
declare function ctime cdecl alias "ctime" (byval as time_t ptr) as zstring ptr
declare function gmtime cdecl alias "gmtime" (byval as time_t ptr) as tm ptr
declare function localtime cdecl alias "localtime" (byval as time_t ptr) as tm ptr
declare function strftime cdecl alias "strftime" (byval as zstring ptr, byval as size_t, byval as zstring ptr, byval as tm ptr) as size_t
declare function wcsftime cdecl alias "wcsftime" (byval as wchar_t ptr, byval as size_t, byval as wchar_t ptr, byval as tm ptr) as size_t
declare sub _tzset cdecl alias "_tzset" ()
declare function _strdate cdecl alias "_strdate" (byval as zstring ptr) as zstring ptr
declare function _strtime cdecl alias "_strtime" (byval as zstring ptr) as zstring ptr
declare function __p__daylight cdecl alias "__p__daylight" () as integer ptr
declare function __p__timezone cdecl alias "__p__timezone" () as integer ptr
declare function __p__tzname cdecl alias "__p__tzname" () as byte ptr ptr

extern import _daylight alias "_daylight" as integer
extern import _timezone alias "_timezone" as integer
extern import _tzname alias "_tzname" as zstring * 2

#endif
