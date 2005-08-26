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
'      System level: initialization, cleanup, etc.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_SYSTEM_H
#define ALLEGRO_SYSTEM_H

#include "allegro/base.bi"

#define ALLEGRO_ERROR_SIZE 256

Extern Import allegro_id Alias "allegro_id" As Byte Ptr
'Extern Import fb_allegro_error Alias "allegro_error" As Byte
'private function allegro_error () as string
'	allegro_error = *(@fb_allegro_error)
'end function
Extern Import allegro_error Alias "allegro_error" As ZString Ptr

#define OSTYPE_UNKNOWN     0
#define OSTYPE_WIN3        AL_ID(asc("W"),asc("I"),asc("N"),asc("3"))
#define OSTYPE_WIN95       AL_ID(asc("W"),asc("9"),asc("5"),asc(" "))
#define OSTYPE_WIN98       AL_ID(asc("W"),asc("9"),asc("8"),asc(" "))
#define OSTYPE_WINME       AL_ID(asc("W"),asc("M"),asc("E"),asc(" "))
#define OSTYPE_WINNT       AL_ID(asc("W"),asc("N"),asc("T"),asc(" "))
#define OSTYPE_WIN2000     AL_ID(asc("W"),asc("2"),asc("K"),asc(" "))
#define OSTYPE_WINXP       AL_ID(asc("W"),asc("X"),asc("P"),asc(" "))
#define OSTYPE_OS2         AL_ID(asc("O"),asc("S"),asc("2"),asc(" "))
#define OSTYPE_WARP        AL_ID(asc("W"),asc("A"),asc("R"),asc("P"))
#define OSTYPE_DOSEMU      AL_ID(asc("D"),asc("E"),asc("M"),asc("U"))
#define OSTYPE_OPENDOS     AL_ID(asc("O"),asc("D"),asc("O"),asc("S"))
#define OSTYPE_LINUX       AL_ID(asc("T"),asc("U"),asc("X"),asc(" "))
#define OSTYPE_SUNOS       AL_ID(asc("S"),asc("U"),asc("N"),asc(" "))
#define OSTYPE_FREEBSD     AL_ID(asc("F"),asc("B"),asc("S"),asc("D"))
#define OSTYPE_NETBSD      AL_ID(asc("N"),asc("B"),asc("S"),asc("D"))
#define OSTYPE_IRIX        AL_ID(asc("I"),asc("R"),asc("I"),asc("X"))
#define OSTYPE_QNX         AL_ID(asc("Q"),asc("N"),asc("X"),asc(" "))
#define OSTYPE_UNIX        AL_ID(asc("U"),asc("N"),asc("I"),asc("X"))
#define OSTYPE_BEOS        AL_ID(asc("B"),asc("E"),asc("O"),asc("S"))
#define OSTYPE_MACOS       AL_ID(asc("M"),asc("A"),asc("C"),asc(" "))

Extern Import os_type Alias "os_type" As Integer
Extern Import os_version Alias "os_version" As Integer
Extern Import os_revision Alias "os_revision" As Integer
Extern Import os_multitasking Alias "os_multitasking" As Integer

Const SYSTEM_AUTODETECT% = 0
#define SYSTEM_NONE        AL_ID(asc("N"),asc("O"),asc("N"),asc("E"))

Declare Function install_allegro CDecl Alias "install_allegro" (ByVal system_id As Integer, ByVal errno_ptr As Integer Ptr, ByVal atexit_ptr as sub()) As Integer
#define allegro_init install_allegro(SYSTEM_AUTODETECT, @errno, @atexit)
Declare Sub allegro_exit CDecl Alias "allegro_exit" ()

Declare Sub get_executable_name CDecl Alias "get_executable_name" (ByVal output As ZString Ptr, ByVal size As Integer)
Declare Sub allegro_message CDecl Alias "allegro_message" (byval s as zstring ptr, ...)

Declare Sub check_cpu CDecl Alias "check_cpu" ()

' CPU Capabilities flags - set to 0 on non x86 capable chips
Const CPU_ID%				= &H0001
Const CPU_FPU%				= &H0002
Const CPU_MMX%				= &H0004
Const CPU_MMXPLUS%			= &H0008
Const CPU_SSE%				= &H0010
Const CPU_SSE2%				= &H0020
Const CPU_3DNOW%			= &H0040
Const CPU_ENH3DNOW%			= &H0080
Const CPU_CMOV%				= &H0100

Extern Import cpu_vendor Alias "cpu_vendor" As ZString Ptr
Extern Import cpu_family Alias "cpu_family" As Integer
Extern Import cpu_model Alias "cpu_model" As Integer
Extern Import cpu_capabilities Alias "cpu_capabilities" as Integer

Type SYSTEM_DRIVER
	id as integer
	name as byte ptr
	desc as byte ptr
	ascii_name as byte ptr
	init as function() as integer
	exit as sub()
	get_executable_name as sub(byval output as byte ptr, byval size as integer)
	find_resource as function(byval dest as byte ptr, byval resource as byte ptr, byval size as integer) as integer
	set_window_title as sub(byval name as byte ptr)
	set_window_close_button as function(byval enable as integer) as integer
	set_window_close_hook as sub(byval proc as sub())
	message as sub(byval msg as byte ptr)
	_assert as sub(byval msg as byte ptr)
	save_console_state as sub()
	restore_console_state as sub()
	create_bitmap as function(byval color_depth as integer, byval width as integer, byval height as integer) as BITMAP ptr
	created_bitmap as sub(byval bmp as BITMAP ptr)
	create_sub_bitmap as function(byval parent as BITMAP ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer) as BITMAP ptr
	created_sub_bitmap as sub(byval bmp as BITMAP ptr, byval parent as BITMAP ptr)
	destroy_bitmap as function(byval bmp as BITMAP ptr) as integer
	read_hardware_palette as sub()
	set_palette_range as sub(byval p as RGB ptr, byval _from as integer, byval _to as integer, byval retracesync as integer)
	get_vtable as function(byval color_depth as integer) as GFX_VTABLE ptr
	set_display_switch_mode as function(byval mode as integer) as integer
	set_display_switch_callback as function(byval _dir as integer, byval cb as sub()) as integer
	remove_display_switch_callback as sub(byval cb as sub())
	display_switch_lock as sub(byval _lock as integer, byval foreground as integer)
	desktop_color_depth as function() as integer
	get_desktop_resolution as function(byval width as integer ptr, byval height as integer ptr) as integer
	yield_timeslice as sub()
	gfx_drivers as function() as _DRIVER_INFO ptr
	digi_drivers as function() as _DRIVER_INFO ptr
	midi_drivers as function() as _DRIVER_INFO ptr
	keyboard_drivers as function() as _DRIVER_INFO ptr
	mouse_drivers as function() as _DRIVER_INFO ptr
	joystick_drivers as function() as _DRIVER_INFO ptr
	timer_drivers as function() as _DRIVER_INFO ptr
end type

extern import _system_none alias "system_none" as SYSTEM_DRIVER
extern import system_driver alias "system_driver" as SYSTEM_DRIVER ptr
extern import _system_driver_list alias "_system_driver_list" as _DRIVER_INFO Ptr

#include "allegro/inline/system.inl"

#endif
