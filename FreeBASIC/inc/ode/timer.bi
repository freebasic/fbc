''
''
'' timer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __timer_bi__
#define __timer_bi__

#include once "ode/config.bi"

type dStopwatch
	time as double
	cc(0 to 2-1) as uinteger ptr
end type

type dStopwatch as any

declare sub dStopwatchReset cdecl alias "dStopwatchReset" (byval as dStopwatch ptr)
declare sub dStopwatchStart cdecl alias "dStopwatchStart" (byval as dStopwatch ptr)
declare sub dStopwatchStop cdecl alias "dStopwatchStop" (byval as dStopwatch ptr)
declare function dStopwatchTime cdecl alias "dStopwatchTime" (byval as dStopwatch ptr) as double
declare sub dTimerStart cdecl alias "dTimerStart" (byval description as string)
declare sub dTimerNow cdecl alias "dTimerNow" (byval description as string)
declare sub dTimerEnd cdecl alias "dTimerEnd" ()
declare sub dTimerReport cdecl alias "dTimerReport" (byval fout as FILE ptr, byval average as integer)
declare function dTimerTicksPerSecond cdecl alias "dTimerTicksPerSecond" () as double
declare function dTimerResolution cdecl alias "dTimerResolution" () as double

#endif
