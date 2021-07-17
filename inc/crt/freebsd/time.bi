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

#include once "crt/long.bi"

'' begin_include "bits/time.bi"

#define CLOCKS_PER_SEC 1000000l

extern "C"
declare function __sysconf (byval as long) as clong
end extern

'' end_include "bits/time.bi"

type clock_t as __clock_t
type time_t as __time_t

type timespec
	tv_sec as __time_t
	tv_nsec as clong
end type

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
	__tm_gmtoff as clong
	__tm_zone as zstring ptr
end type

extern "C"

declare function gmtime_r (byval __timer as time_t ptr, byval __tp as tm ptr) as tm ptr
declare function localtime_r (byval __timer as time_t ptr, byval __tp as tm ptr) as tm ptr
declare function asctime_r (byval __tp as tm ptr, byval __buf as zstring ptr) as zstring ptr
declare function ctime_r (byval __timer as time_t ptr, byval __buf as zstring ptr) as zstring ptr

extern __tzname as zstring * 2
extern __daylight as long
extern __timezone as clong

declare function timegm (byval __tp as tm ptr) as time_t
declare function timelocal (byval __tp as tm ptr) as time_t
declare function dysize (byval __year as long) as long

end extern

#endif
