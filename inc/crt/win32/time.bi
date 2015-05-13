''
''
'' time -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_win32_time_bi__
#define __crt_win32_time_bi__

#include once "crt/long.bi"

type clock_t as clong

type tm
	tm_sec as long
	tm_min as long
	tm_hour as long
	tm_mday as long
	tm_mon as long
	tm_year as long
	tm_wday as long
	tm_yday as long
	tm_isdst as long
end type

extern "c"

declare sub _tzset ()
declare function _strdate (byval as zstring ptr) as zstring ptr
declare function _strtime (byval as zstring ptr) as zstring ptr
#ifndef __FB_64BIT__
declare function __p__daylight () as long ptr
declare function __p__timezone () as long ptr
declare function __p__tzname () as byte ptr ptr
#endif

extern import _daylight as long
extern import _timezone as long
extern import _tzname as zstring * 2

end extern

#endif
