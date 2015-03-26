#pragma once

#include once "crt/sys/types.bi"
#include once "crt/string.bi"
#include once "crt/time.bi"
#include once "X11/Xosdefs.bi"
#include once "X11/Xarch.bi"
#ifdef __FB_WIN32__
	#include once "crt/long.bi"
	#include once "X11/Xw32defs.bi"
#endif

#define _XOS_H_
#define index(s, c) strchr((s), (c))
#define rindex(s, c) strrchr((s), (c))

#ifdef __FB_WIN32__
	type timeval
		tv_sec as clong
		tv_usec as clong
	end type

	#define _TIMEVAL_DEFINED
	#macro gettimeofday(t)
		scope
			dim _gtodtmp as _timeb
			_ftime(@_gtodtmp)
			(t)->tv_sec = _gtodtmp.time
			(t)->tv_usec = _gtodtmp.millitm * 1000
		end scope
	#endmacro
	#define X_GETTIMEOFDAY(t) gettimeofday(t)
#else
	#define X_GETTIMEOFDAY(t) gettimeofday(t, cptr(timezone ptr, 0))
#endif
