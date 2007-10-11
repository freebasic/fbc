''
''
'' gtimer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtimer_bi__
#define __gtimer_bi__

#include once "gtypes.bi"

type GTimer as _GTimer

#define G_USEC_PER_SEC 1000000

declare function g_timer_new () as GTimer ptr
declare sub g_timer_destroy (byval timer as GTimer ptr)
declare sub g_timer_start (byval timer as GTimer ptr)
declare sub g_timer_stop (byval timer as GTimer ptr)
declare sub g_timer_reset (byval timer as GTimer ptr)
declare sub g_timer_continue (byval timer as GTimer ptr)
declare function g_timer_elapsed (byval timer as GTimer ptr, byval microseconds as gulong ptr) as gdouble
declare sub g_usleep (byval microseconds as gulong)
declare sub g_time_val_add (byval time_ as GTimeVal ptr, byval microseconds as glong)

#endif
