''
''
'' time -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_linux_time_bi__
#define __crt_linux_time_bi__

'' begin_include "bits/time.bi"

#define CLOCKS_PER_SEC 1000000l

declare function __sysconf cdecl alias "__sysconf" (byval as integer) as integer

'' end_include "bits/time.bi"

type clock_t as __clock_t
type time_t as __time_t

type timespec
	tv_sec as __time_t
	tv_nsec as integer
end type

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
	__tm_gmtoff as integer
	__tm_zone as zstring ptr
end type

declare function gmtime_r cdecl alias "gmtime_r" (byval __timer as time_t ptr, byval __tp as tm ptr) as tm ptr
declare function localtime_r cdecl alias "localtime_r" (byval __timer as time_t ptr, byval __tp as tm ptr) as tm ptr
declare function asctime_r cdecl alias "asctime_r" (byval __tp as tm ptr, byval __buf as zstring ptr) as zstring ptr
declare function ctime_r cdecl alias "ctime_r" (byval __timer as time_t ptr, byval __buf as zstring ptr) as zstring ptr

extern __tzname alias "__tzname" as zstring * 2
extern __daylight alias "__daylight" as integer
extern __timezone alias "__timezone" as integer

declare function timegm cdecl alias "timegm" (byval __tp as tm ptr) as time_t
declare function timelocal cdecl alias "timelocal" (byval __tp as tm ptr) as time_t
declare function dysize cdecl alias "dysize" (byval __year as integer) as integer

#endif
