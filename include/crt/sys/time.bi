''
''
'' sys\time -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_time_bi__
#define __crt_sys_time_bi__

#include once "crt/time.bi"

#if defined(__FB_WIN32__)
#include once "crt/sys/win32/time.bi"
#elseif defined(__FB_LINUX__)
#include once "crt/sys/linux/time.bi"
#elseif defined(__FB_DOS__)
#include once "crt/dos/time.bi"
#else
#error Unsupported platform
#endif

#ifndef timerisset
#define timerisset(tvp)	 (((tvp)->tv_sec <> 0) or ((tvp)->tv_usec <> 0))
#endif

#ifndef timercmp
#define timercmp(tvp, uvp, cmp) iif((tvp)->tv_sec <> (uvp)->tv_sec, (tvp)->tv_sec cmp (uvp)->tv_sec, (tvp)->tv_usec cmp (uvp)->tv_usec)
#endif

#ifndef timerclear
#define timerclear(tvp)	(tvp)->tv_sec = 0: (tvp)->tv_usec = 0
#endif

#endif
