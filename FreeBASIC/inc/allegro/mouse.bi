''
''
'' allegro\mouse -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_mouse_bi__
#define __allegro_mouse_bi__

#include once "allegro/base.bi"

type BITMAP_ as BITMAP

#define MOUSEDRV_AUTODETECT -1
#define MOUSEDRV_NONE 0

type MOUSE_DRIVER
	id as integer
	name as zstring ptr
	desc as zstring ptr
	ascii_name as zstring ptr
	init as function cdecl() as integer
	exit as sub cdecl()
	poll as sub cdecl()
	timer_poll as sub cdecl()
	position as sub cdecl(byval as integer, byval as integer)
	set_range as sub cdecl(byval as integer, byval as integer, byval as integer, byval as integer)
	set_speed as sub cdecl(byval as integer, byval as integer)
	get_mickeys as sub cdecl(byval as integer ptr, byval as integer ptr)
	analyse_data as function cdecl(byval as zstring ptr, byval as integer) as integer
end type

extern _AL_DLL mousedrv_none_ alias "mousedrv_none" as MOUSE_DRIVER
extern _AL_DLL mouse_driver alias "mouse_driver" as MOUSE_DRIVER ptr
extern _AL_DLL ___mouse_driver_list alias "_mouse_driver_list" as _DRIVER_INFO
#define _mouse_driver_list(x) *(@___mouse_driver_list + (x))

declare function install_mouse cdecl alias "install_mouse" () as integer
declare sub remove_mouse cdecl alias "remove_mouse" ()
declare function poll_mouse cdecl alias "poll_mouse" () as integer
declare function mouse_needs_poll cdecl alias "mouse_needs_poll" () as integer

extern _AL_DLL mouse_sprite alias "mouse_sprite" as BITMAP_ ptr
extern _AL_DLL mouse_x_focus alias "mouse_x_focus" as integer
extern _AL_DLL mouse_y_focus alias "mouse_y_focus" as integer
extern _AL_DLL mouse_x alias "mouse_x" as integer
extern _AL_DLL mouse_y alias "mouse_y" as integer
extern _AL_DLL mouse_z alias "mouse_z" as integer
extern _AL_DLL mouse_b alias "mouse_b" as integer
extern _AL_DLL mouse_pos alias "mouse_pos" as integer
extern _AL_DLL freeze_mouse_flag alias "freeze_mouse_flag" as integer

#define MOUSE_FLAG_MOVE 1
#define MOUSE_FLAG_LEFT_DOWN 2
#define MOUSE_FLAG_LEFT_UP 4
#define MOUSE_FLAG_RIGHT_DOWN 8
#define MOUSE_FLAG_RIGHT_UP 16
#define MOUSE_FLAG_MIDDLE_DOWN 32
#define MOUSE_FLAG_MIDDLE_UP 64
#define MOUSE_FLAG_MOVE_Z 128

extern _AL_DLL mouse_callback alias "mouse_callback" as sub cdecl(byval as integer)

declare sub show_mouse cdecl alias "show_mouse" (byval bmp as BITMAP_ ptr)
declare sub scare_mouse cdecl alias "scare_mouse" ()
declare sub scare_mouse_area cdecl alias "scare_mouse_area" (byval x as integer, byval y as integer, byval w as integer, byval h as integer)
declare sub unscare_mouse cdecl alias "unscare_mouse" ()
declare sub position_mouse cdecl alias "position_mouse" (byval x as integer, byval y as integer)
declare sub position_mouse_z cdecl alias "position_mouse_z" (byval z as integer)
declare sub set_mouse_range cdecl alias "set_mouse_range" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub set_mouse_speed cdecl alias "set_mouse_speed" (byval xspeed as integer, byval yspeed as integer)
declare sub set_mouse_sprite cdecl alias "set_mouse_sprite" (byval sprite as BITMAP_ ptr)
declare sub set_mouse_sprite_focus cdecl alias "set_mouse_sprite_focus" (byval x as integer, byval y as integer)
declare sub get_mouse_mickeys cdecl alias "get_mouse_mickeys" (byval mickeyx as integer ptr, byval mickeyy as integer ptr)

#endif
