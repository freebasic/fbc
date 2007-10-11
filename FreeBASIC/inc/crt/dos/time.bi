''
''
'' time -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_dos_time_bi__
#define __crt_dos_time_bi__

#define CLOCKS_PER_SEC 91

#include once "crt/sys/dos/types.bi"

#ifndef NULL
#define NULL 0
#endif

type clock_t as integer
type time_t as uinteger

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
	__tm_zone as zstring ptr
	__tm_gmtoff as integer
end type

#define CLK_TCK 91

extern tzname alias "tzname" as zstring * 2

declare sub tzset cdecl alias "tzset" ()

type timeval
	tv_sec as time_t
	tv_usec as integer
end type

type timezone
	tz_minuteswest as integer
	tz_dsttime as integer
end type

type uclock_t as longint

#define UCLOCKS_PER_SEC 1193180

declare function gettimeofday cdecl alias "gettimeofday" (byval _tp as timeval ptr, byval _tzp as timezone ptr) as integer
declare function rawclock cdecl alias "rawclock" () as uinteger
declare function select_ cdecl alias "select" (byval _nfds as integer, byval _readfds as fd_set ptr, byval _writefds as fd_set ptr, byval _exceptfds as fd_set ptr, byval _timeout as timeval ptr) as integer
declare function settimeofday cdecl alias "settimeofday" (byval _tp as timeval ptr, ...) as integer
declare sub tzsetwall cdecl alias "tzsetwall" ()
declare function uclock cdecl alias "uclock" () as uclock_t

#endif
