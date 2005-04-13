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
'      Mouse routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_MOUSE_H
#define ALLEGRO_MOUSE_H

#include "allegro/base.bi"

#define MOUSEDRV_AUTODETECT  -1
#define MOUSEDRV_NONE         0

Type MOUSE_DRIVER
	id As Integer
	name As ZString Ptr
	desc As ZString Ptr
	ascii_name As ZString Ptr
	init As Function CDecl() As Integer
	exit As Sub CDecl()
	poll As Sub CDecl()
	timer_poll As Sub CDecl()
	position As Sub CDecl(ByVal x As Integer, ByVal y As Integer)
	set_range As Sub CDecl(ByVal x1 As INteger, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
	set_speed As Sub CDecl(ByVal xspeed As Integer, ByVal yspeed As Integer)
	get_mickeys As Sub CDecl(ByVal mickeyx As Integer Ptr, ByVal mickeyy As Integer Ptr)
	analyse_data As Sub CDecl(ByVal buffer As Byte Ptr, ByVal size As Integer)
End Type

Extern Import _mousedrv_none Alias "mousedrv_none" As MOUSE_DRIVER
Extern Import mouse_driver Alias "mouse_driver" As mouSE_DRIVER Ptr
Extern Import _mouse_driver_list Alias "_mouse_driver_list" As _DRIVER_INFO Ptr

Declare Function install_mouse CDecl Alias "install_mouse" () As Integer
Declare Sub remove_mouse CDecl Alias "remove_mouse" ()

Declare Function poll_mouse CDecl Alias "poll_mouse" () As Integer
Declare Function mouse_needs_poll CDecl Alias "mouse_needs_poll" () As Integer

Extern Import mouse_sprite  Alias "mouse_sprite" As BITMAP Ptr
Extern Import mouse_x_focus Alias "mouse_x_focus" As Integer
Extern Import mouse_y_focus Alias "mouse_y_focus" As Integer

Extern Import mouse_x Alias "mouse_x" As Integer
Extern Import mouse_y Alias "mouse_y" As Integer
Extern Import mouse_z Alias "mouse_z" As Integer
Extern Import mouse_b Alias "mouse_b" As Integer
Extern Import mouse_pos Alias "mouse_pos" As Integer

Extern Import freeze_mouse_flag Alias "freeze_mouse_flag" As Integer

#define MOUSE_FLAG_MOVE             1
#define MOUSE_FLAG_LEFT_DOWN        2
#define MOUSE_FLAG_LEFT_UP          4
#define MOUSE_FLAG_RIGHT_DOWN       8
#define MOUSE_FLAG_RIGHT_UP         16
#define MOUSE_FLAG_MIDDLE_DOWN      32
#define MOUSE_FLAG_MIDDLE_UP        64
#define MOUSE_FLAG_MOVE_Z           128

Extern Import mouse_callback Alias "mouse_callback" As Sub(ByVal flags As Integer)

Declare Sub show_mouse CDecl Alias "show_mouse" (ByVal bmp As BITMAP Ptr)
Declare Sub scare_mouse CDecl Alias "scare_mouse" ()
Declare Sub scare_mouse_area CDecl Alias "scare_mouse_area" (ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer)
Declare Sub unscare_mouse CDecl Alias "unscare_mouse" ()
Declare Sub position_mouse CDecl Alias "position_mouse" (ByVal x As Integer, ByVal y As Integer)
Declare Sub position_mouse_z CDecl Alias "position_mouse_z" (ByVal z As Integer)
Declare Sub set_mouse_range CDecl Alias "set_mouse_range" (ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
Declare Sub set_mouse_speed CDecl Alias "set_mouse_speed" (ByVal xspeed As Integer, ByVal yspeed As Integer)
Declare Sub set_mouse_sprite CDecl Alias "set_mouse_sprite" (ByVal sprite As BITMAP Ptr)
Declare Sub set_mouse_sprite_focus CDecl Alias "set_mouse_sprite_focus" (ByVal x As Integer, ByVal y As Integer)
Declare Sub get_mouse_mickeys CDecl Alias "get_mouse_mickeys" (ByRef mickeyx As Integer, ByRef mickeyy As Integer)

#endif
