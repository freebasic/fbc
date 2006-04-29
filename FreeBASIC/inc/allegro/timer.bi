''
''
'' allegro\timer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_timer_bi__
#define __allegro_timer_bi__

#include once "allegro/base.bi"

#define TIMERS_PER_SECOND 1193181L
#define SECS_TO_TIMER(x) (cint(x) * TIMERS_PER_SECOND)
#define MSEC_TO_TIMER(x) (cint(x) * (TIMERS_PER_SECOND \ 1000))
#define BPS_TO_TIMER(x) (TIMERS_PER_SECOND \ cint(x))
#define BPM_TO_TIMER(x) ((60 * TIMERS_PER_SECOND) \ cint(x))

type TIMER_DRIVER
	id as integer
	name as zstring ptr
	desc as zstring ptr
	ascii_name as zstring ptr
	init as function cdecl() as integer
	exit as sub cdecl()
	install_int as function cdecl(byval as sub cdecl(), byval as integer) as integer
	remove_int as sub cdecl(byval as sub cdecl())
	install_param_int as function cdecl(byval as sub cdecl(byval as any ptr), byval as any ptr, byval as integer) as integer
	remove_param_int as sub cdecl(byval as sub cdecl(byval as any ptr), byval as any ptr)
	can_simulate_retrace as function cdecl() as integer
	simulate_retrace as sub cdecl(byval as integer)
	rest as sub cdecl(byval as integer, byval as sub cdecl())
end type

extern _AL_DLL timer_driver alias "timer_driver" as TIMER_DRIVER ptr
extern _AL_DLL ___timer_driver_list alias "_timer_driver_list" as _DRIVER_INFO
#define _timer_driver_list(x) *(@___timer_driver_list + (x))

declare function install_timer cdecl alias "install_timer" () as integer
declare sub remove_timer cdecl alias "remove_timer" ()
declare function install_int_ex cdecl alias "install_int_ex" (byval proc as sub cdecl(), byval speed as integer) as integer
declare function install_int cdecl alias "install_int" (byval proc as sub cdecl(), byval speed as integer) as integer
declare sub remove_int cdecl alias "remove_int" (byval proc as sub cdecl())
declare function install_param_int_ex cdecl alias "install_param_int_ex" (byval proc as sub cdecl(byval as any ptr), byval param as any ptr, byval speed as integer) as integer
declare function install_param_int cdecl alias "install_param_int" (byval proc as sub cdecl(byval as any ptr), byval param as any ptr, byval speed as integer) as integer
declare sub remove_param_int cdecl alias "remove_param_int" (byval proc as sub cdecl(byval as any ptr), byval param as any ptr)

extern _AL_DLL retrace_count alias "retrace_count" as integer
extern _AL_DLL retrace_proc alias "retrace_proc" as sub cdecl()

declare function timer_can_simulate_retrace cdecl alias "timer_can_simulate_retrace" () as integer
declare sub timer_simulate_retrace cdecl alias "timer_simulate_retrace" (byval enable as integer)
declare function timer_is_using_retrace cdecl alias "timer_is_using_retrace" () as integer
declare sub rest cdecl alias "rest" (byval time as integer)
declare sub rest_callback cdecl alias "rest_callback" (byval time as integer, byval callback as sub cdecl())

#endif
