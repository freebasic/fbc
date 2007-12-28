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

extern "c"
declare sub _tzset ()
declare function _strdate (byval as zstring ptr) as zstring ptr
declare function _strtime (byval as zstring ptr) as zstring ptr
declare function __p__daylight () as integer ptr
declare function __p__timezone () as integer ptr
declare function __p__tzname () as byte ptr ptr
end extern

extern import _daylight alias "_daylight" as integer
extern import _timezone alias "_timezone" as integer
extern import _tzname alias "_tzname" as zstring * 2

#endif