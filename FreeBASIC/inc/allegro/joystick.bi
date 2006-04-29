''
''
'' allegro\joystick -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_joystick_bi__
#define __allegro_joystick_bi__

#include once "allegro/base.bi"

#define JOY_TYPE_AUTODETECT -1
#define JOY_TYPE_NONE 0
#define MAX_JOYSTICKS 8
#define MAX_JOYSTICK_AXIS 3
#define MAX_JOYSTICK_STICKS 5
#define MAX_JOYSTICK_BUTTONS 16

type JOYSTICK_AXIS_INFO
	pos as integer
	d1 as integer
	d2 as integer
	name as zstring ptr
end type

type JOYSTICK_STICK_INFO
	flags as integer
	num_axis as integer
	axis(0 to 3-1) as JOYSTICK_AXIS_INFO
	name as zstring ptr
end type

type JOYSTICK_BUTTON_INFO
	b as integer
	name as zstring ptr
end type

type JOYSTICK_INFO
	flags as integer
	num_sticks as integer
	num_buttons as integer
	stick(0 to 5-1) as JOYSTICK_STICK_INFO
	button(0 to 16-1) as JOYSTICK_BUTTON_INFO
end type

#define JOYFLAG_DIGITAL 1
#define JOYFLAG_ANALOGUE 2
#define JOYFLAG_CALIB_DIGITAL 4
#define JOYFLAG_CALIB_ANALOGUE 8
#define JOYFLAG_CALIBRATE 16
#define JOYFLAG_SIGNED 32
#define JOYFLAG_UNSIGNED 64
#define JOYFLAG_ANALOG 2
#define JOYFLAG_CALIB_ANALOG 8

extern _AL_DLL __joy alias "joy" as JOYSTICK_INFO
#define joy(x) *(@__joy + (x))
extern _AL_DLL num_joysticks alias "num_joysticks" as integer

type JOYSTICK_DRIVER
	id as integer
	name as zstring ptr
	desc as zstring ptr
	ascii_name as zstring ptr
	init as function cdecl() as integer
	exit as sub cdecl()
	poll as function cdecl() as integer
	save_data as function cdecl() as integer
	load_data as function cdecl() as integer
	calibrate_name as function cdecl(byval as integer) as byte ptr
	calibrate as function cdecl(byval as integer) as integer
end type

extern _AL_DLL joystick_none alias "joystick_none" as JOYSTICK_DRIVER
extern _AL_DLL joystick_driver alias "joystick_driver" as JOYSTICK_DRIVER ptr
extern _AL_DLL ___joystick_driver_list alias "_joystick_driver_list" as _DRIVER_INFO
#define _joystick_driver_list(x) *(@___joystick_driver_list + (x))

declare function install_joystick cdecl alias "install_joystick" (byval type as integer) as integer
declare sub remove_joystick cdecl alias "remove_joystick" ()
declare function initialise_joystick cdecl alias "initialise_joystick" () as integer
declare function poll_joystick cdecl alias "poll_joystick" () as integer
declare function save_joystick_data cdecl alias "save_joystick_data" (byval filename as zstring ptr) as integer
declare function load_joystick_data cdecl alias "load_joystick_data" (byval filename as zstring ptr) as integer
declare function calibrate_joystick_name cdecl alias "calibrate_joystick_name" (byval n as integer) as zstring ptr
declare function calibrate_joystick cdecl alias "calibrate_joystick" (byval n as integer) as integer

#endif
