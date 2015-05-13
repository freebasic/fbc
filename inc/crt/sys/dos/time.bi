''
''
'' sys\time -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_dos_time_bi__
#define __crt_sys_dos_time_bi__

#include "crt/time.bi"

type itimerval
	it_interval as timeval
	it_value as timeval
end type

extern "c"
extern __djgpp_clock_tick_interval as long
declare function getitimer  (byval as integer, byval as itimerval ptr) as integer
declare function setitimer (byval as integer, byval as itimerval ptr, byval as itimerval ptr) as integer
declare function utimes(byval as zstring ptr, byval as timeval ptr) as integer
end extern

#endif
