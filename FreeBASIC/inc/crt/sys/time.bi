''
''
'' sys\time -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __sys_time_bi__
#define __sys_time_bi__

#include once "crt/time.bi"

#ifndef timeval
type timeval
	tv_sec as integer
	tv_usec as integer
end type

#define timerisset(tvp)	 ((tvp)->tv_sec or (tvp)->tv_usec)
#define timercmp(tvp, uvp, cmp) iif((tvp)->tv_sec <> (uvp)->tv_sec, (tvp)->tv_sec cmp (uvp)->tv_sec, (tvp)->tv_usec cmp (uvp)->tv_usec)
#define timerclear(tvp)	(tvp)->tv_sec = 0: (tvp)->tv_usec = 0
#endif

#endif
