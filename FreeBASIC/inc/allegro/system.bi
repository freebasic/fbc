''
''
'' allegro\system -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_system_bi__
#define __allegro_system_bi__

#include once "allegro/base.bi"

type RGB_ as RGB
type BITMAP_ as BITMAP
type GFX_VTABLE_ as GFX_VTABLE

#define ALLEGRO_ERROR_SIZE 256
extern _AL_DLL __allegro_id alias "allegro_id" as byte
#define allegro_id *cast( zstring ptr , @__allegro_id )
extern _AL_DLL __allegro_error alias "allegro_error" as byte
#define allegro_error *cast( zstring ptr , @__allegro_error )

#define OSTYPE_UNKNOWN 0
#define OSTYPE_WIN3 AL_ID(asc("W"),asc("I"),asc("N"),asc("3"))
#define OSTYPE_WIN95 AL_ID(asc("W"),asc("9"),asc("5"),asc(" "))
#define OSTYPE_WIN98 AL_ID(asc("W"),asc("9"),asc("8"),asc(" "))
#define OSTYPE_WINME AL_ID(asc("W"),asc("M"),asc("E"),asc(" "))
#define OSTYPE_WINNT AL_ID(asc("W"),asc("N"),asc("T"),asc(" "))
#define OSTYPE_WIN2000 AL_ID(asc("W"),asc("2"),asc("K"),asc(" "))
#define OSTYPE_WINXP AL_ID(asc("W"),asc("X"),asc("P"),asc(" "))
#define OSTYPE_OS2 AL_ID(asc("O"),asc("S"),asc("2"),asc(" "))
#define OSTYPE_WARP AL_ID(asc("W"),asc("A"),asc("R"),asc("P"))
#define OSTYPE_DOSEMU AL_ID(asc("D"),asc("E"),asc("M"),asc("U"))
#define OSTYPE_OPENDOS AL_ID(asc("O"),asc("D"),asc("O"),asc("S"))
#define OSTYPE_LINUX AL_ID(asc("T"),asc("U"),asc("X"),asc(" "))
#define OSTYPE_SUNOS AL_ID(asc("S"),asc("U"),asc("N"),asc(" "))
#define OSTYPE_FREEBSD AL_ID(asc("F"),asc("B"),asc("S"),asc("D"))
#define OSTYPE_NETBSD AL_ID(asc("N"),asc("B"),asc("S"),asc("D"))
#define OSTYPE_IRIX AL_ID(asc("I"),asc("R"),asc("I"),asc("X"))
#define OSTYPE_QNX AL_ID(asc("Q"),asc("N"),asc("X"),asc(" "))
#define OSTYPE_UNIX AL_ID(asc("U"),asc("N"),asc("I"),asc("X"))
#define OSTYPE_BEOS AL_ID(asc("B"),asc("E"),asc("O"),asc("S"))
#define OSTYPE_MACOS AL_ID(asc("M"),asc("A"),asc("C"),asc(" "))

extern _AL_DLL os_type alias "os_type" as integer
extern _AL_DLL os_version alias "os_version" as integer
extern _AL_DLL os_revision alias "os_revision" as integer
extern _AL_DLL os_multitasking alias "os_multitasking" as integer

#define SYSTEM_AUTODETECT 0
#define SYSTEM_NONE AL_ID((asc("N"),asc("O"),asc("N"),asc("E"))

declare function install_allegro cdecl alias "install_allegro" (byval system_id as integer, byval errno_ptr as integer ptr, byval atexit_ptr as function cdecl(byval as sub cdecl()) as integer) as integer
#define allegro_init() install_allegro(SYSTEM_AUTODETECT, 0, @atexit)
declare sub allegro_exit cdecl alias "allegro_exit" ()
declare sub get_executable_name cdecl alias "get_executable_name" (byval output as zstring ptr, byval size as integer)
declare sub allegro_message cdecl alias "allegro_message" (byval msg as zstring ptr, ...)
declare sub check_cpu cdecl alias "check_cpu" ()

#define CPU_ID &h0001
#define CPU_FPU &h0002
#define CPU_MMX &h0004
#define CPU_MMXPLUS &h0008
#define CPU_SSE &h0010
#define CPU_SSE2 &h0020
#define CPU_3DNOW &h0040
#define CPU_ENH3DNOW &h0080
#define CPU_CMOV &h0100
extern _AL_DLL __cpu_vendor alias "cpu_vendor" as byte
#define cpu_vendor *cast( zstring ptr , @__cpu_vendor )
extern _AL_DLL cpu_family alias "cpu_family" as integer
extern _AL_DLL cpu_model alias "cpu_model" as integer
extern _AL_DLL cpu_capabilities alias "cpu_capabilities" as integer

type SYSTEM_DRIVER
	id as integer
	name as zstring ptr
	desc as zstring ptr
	ascii_name as zstring ptr
	init as function cdecl() as integer
	exit as sub cdecl()
	get_executable_name as sub cdecl(byval as zstring ptr, byval as integer)
	find_resource as function cdecl(byval as zstring ptr, byval as zstring ptr, byval as integer) as integer
	set_window_title as sub cdecl(byval as zstring ptr)
	set_window_close_button as function cdecl(byval as integer) as integer
	set_window_close_hook as sub cdecl(byval as sub cdecl())
	message as sub cdecl(byval as zstring ptr)
	assert as sub cdecl(byval as zstring ptr)
	save_console_state as sub cdecl()
	restore_console_state as sub cdecl()
	create_bitmap as function cdecl(byval as integer, byval as integer, byval as integer) as BITMAP_ ptr
	created_bitmap as sub cdecl(byval as BITMAP_ ptr)
	create_sub_bitmap as function cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer) as BITMAP_ ptr
	created_sub_bitmap as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr)
	destroy_bitmap as function cdecl(byval as BITMAP_ ptr) as integer
	read_hardware_palette as sub cdecl()
	set_palette_range as sub cdecl(byval as RGB_ ptr, byval as integer, byval as integer, byval as integer)
	get_vtable as function cdecl(byval as integer) as GFX_VTABLE_ ptr
	set_display_switch_mode as function cdecl(byval as integer) as integer
	set_display_switch_callback as function cdecl(byval as integer, byval as sub cdecl()) as integer
	remove_display_switch_callback as sub cdecl(byval as sub cdecl())
	display_switch_lock as sub cdecl(byval as integer, byval as integer)
	desktop_color_depth as function cdecl() as integer
	get_desktop_resolution as function cdecl(byval as integer ptr, byval as integer ptr) as integer
	yield_timeslice as sub cdecl()
	gfx_drivers as function cdecl() as _DRIVER_INFO ptr
	digi_drivers as function cdecl() as _DRIVER_INFO ptr
	midi_drivers as function cdecl() as _DRIVER_INFO ptr
	keyboard_drivers as function cdecl() as _DRIVER_INFO ptr
	mouse_drivers as function cdecl() as _DRIVER_INFO ptr
	joystick_drivers as function cdecl() as _DRIVER_INFO ptr
	timer_drivers as function cdecl() as _DRIVER_INFO ptr
end type

extern _AL_DLL system_none_ alias "system_none" as SYSTEM_DRIVER
extern _AL_DLL system_driver alias "system_driver" as SYSTEM_DRIVER ptr
extern _AL_DLL ___system_driver_list alias "_system_driver_list" as _DRIVER_INFO
#define _system_driver_list(x) *(@___system_driver_list + (x))

#include once "allegro/inline/system.bi"

#endif
