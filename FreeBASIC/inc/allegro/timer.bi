'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
'      Timer routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_TIMER_H
#define ALLEGRO_TIMER_H

#include "allegro/base.bi"

Const TIMERS_PER_SECOND%		= 1193181

#define SECS_TO_TIMER(secs) ((secs) * TIMERS_PER_SECOND)
#define MSEC_TO_TIMER(msec) ((msec) * (TIMERS_PER_SECOND / 1000))
#define BPS_TO_TIMER(bps) (TIMERS_PER_SECOND / (bps))
#define BPM_TO_TIMER(bpm) ((60 * TIMERS_PER_SECOND) / (bpm))

type TIMER_DRIVER
	id as integer
	name as byte ptr
	desc as byte ptr
	ascii_name as byte ptr
	init as function() as integer
	exit as sub()
	install_int as function(byval proc as sub(), byval speed as integer) as integer
	remove_int as sub(byval proc as sub())
	install_param_int as function(byval proc as sub(byval param as any ptr), byval _param as any ptr, byval speed as integer) as integer
	remove_param_int as sub(byval proc as sub(byval param as any ptr), byval _param as any ptr)
	can_simulate_retrace as function() as integer
	simulate_retrace as sub(byval enable as integer)
	rest as sub(byval time_ as integer, byval callback as sub())
end type

extern import timer_driver as TIMER_DRIVER ptr
extern import _timer_driver_list as _DRIVER_INFO Ptr

Declare Function install_timer CDecl Alias "install_timer" () As Integer
Declare Sub remove_timer CDecl Alias "remove_timer" ()

Declare Function install_int_ex CDecl Alias "install_int_ex" (ByVal proc As Sub(), ByVal speed As Integer) As Integer
Declare Function install_int CDecl Alias "install_int" (ByVal proc As Sub(), ByVal speed As Integer) As Integer
Declare Sub remove_int CDecl Alias "remove_int" (ByVal proc As Sub())

Declare Function install_param_int_ex CDecl Alias "install_param_int_ex" (ByVal proc As Sub(ByVal p As Integer), ByVal param As Integer, ByVal speed As Integer) As Integer
Declare Function install_param_int CDecl Alias "install_param_int" (ByVal proc As Sub(ByVal p As Integer), ByVal param As Integer, ByVal speed As Integer) As Integer
Declare Sub remove_param_int CDecl Alias "remove_param_int" (ByVal proc As Sub(ByVal p As Integer), ByVal param As Integer)

Extern Import retrace_count Alias "retrace_count" As Integer
Extern Import retrace_proc Alias "retrace_proc" As Sub()

Declare Function timer_can_simulate_retrace CDecl Alias "timer_can_simulate_retrace" () As Integer
Declare Sub timer_simulate_retrace CDecl Alias "timer_simulate_retrace" (ByVal enable As Integer)
Declare Function timer_is_using_retrace CDecl Alias "timer_is_using_retrace" () As Integer

Declare Sub rest CDecl Alias "rest" (ByVal time As Long)
Declare Sub rest_callback CDecl Alias "rest_callback" (ByVal time As Long, ByVal callback As Sub())

#endif
