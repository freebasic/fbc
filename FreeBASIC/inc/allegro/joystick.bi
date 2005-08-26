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
'      Joystick routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_JOYSTICK_H
#define ALLEGRO_JOYSTICK_H

#include "allegro/base.bi"

#define JOY_TYPE_AUTODETECT      -1
#define JOY_TYPE_NONE            0


#define MAX_JOYSTICKS            8
#define MAX_JOYSTICK_AXIS        3
#define MAX_JOYSTICK_STICKS      5
#define MAX_JOYSTICK_BUTTONS     16

Type JOYSTICK_AXIS_INFO				' information about a single joystick axis
	pos As Integer
	d1 As Integer
	d2 As Integer
	name As ZString Ptr
End Type

Type JOYSTICK_STICK_INFO			' information about one or more axis (a slider or directional control)
	flags As Integer
	num_axis As Integer
	axis(MAX_JOYSTICK_AXIS - 1) As JOYSTICK_AXIS_INFO
	name As ZString Ptr
End Type

Type JOYSTICK_BUTTON_INFO			' information about a joystick button
	b As Integer
	name As ZString Ptr
End Type

Type JOYSTICK_INFO				' information about an entire joystick
	flags As Integer
	num_sticks As Integer
	num_buttons As Integer
	stick(MAX_JOYSTICK_STICKS - 1) As JOYSTICK_STICK_INFO
	button(MAX_JOYSTICK_BUTTONS - 1) As JOYSTICK_BUTTON_INFO
End Type

' joystick status flags
#define JOYFLAG_DIGITAL             1
#define JOYFLAG_ANALOGUE            2
#define JOYFLAG_CALIB_DIGITAL       4
#define JOYFLAG_CALIB_ANALOGUE      8
#define JOYFLAG_CALIBRATE           16
#define JOYFLAG_SIGNED              32
#define JOYFLAG_UNSIGNED            64

' alternative spellings
#define JOYFLAG_ANALOG              JOYFLAG_ANALOGUE
#define JOYFLAG_CALIB_ANALOG        JOYFLAG_CALIB_ANALOGUE

' global joystick information
Extern Import al_joy Alias "joy" As JOYSTICK_INFO ''Ptr
#define joy	(@al_joy)

Extern Import num_joystick Alias "num_joysticks" As Integer

Type JOYSTICK_DRIVER         ' driver for reading joystick input
	id As Integer
	name As ZString Ptr
	desc As ZString Ptr
	ascii_name As ZString Ptr
	init As Function CDecl() As Integer
	exit As Sub CDecl()
	poll As Function CDecl() As Integer
	save_data As Function CDecl() As Integer
	load_data As Function CDecl() As Integer
	calibrate_name As Function CDecl(ByVal n As Integer) As ZString Ptr
	calibrate As Function CDecl(ByVal n As Integer) As Integer
End Type

Extern Import joystick_none Alias "joystick_none" As JOYSTICK_DRIVER
Extern Import joystick_driver Alias "joystick_driver" As JOYSTICK_DRIVER Ptr
Extern Import _joystick_driver_list Alias "_joystick_driver_list" As _DRIVER_INFO Ptr

Declare Function install_joystick CDecl Alias "install_joystick" (ByVal jtype As Integer) As Integer
Declare Sub remove_joystick CDecl Alias "remove_joystick" ()

Declare Function initialise_joystick CDecl Alias "initialise_joystick" () As Integer

Declare Function poll_joystick CDecl Alias "poll_joystick" () As Integer

Declare Function save_joystick_data CDecl Alias "save_joystick_data" (byval filename as zstring ptr) As Integer
Declare Function load_joystick_data CDecl Alias "load_joystick_data" (byval filename as zstring ptr) As Integer

Declare Function calibrate_joystick_name CDecl Alias "calibrate_joystick_name" (ByVal n As Integer) as zstring ptr
Declare Function calibrate_joystick CDecl Alias "calibrate_joystick" (ByVal n As Integer) As Integer

#endif
