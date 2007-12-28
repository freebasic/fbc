''
''
'' allegro\platform\alunix -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_platform_alunix_bi__
#define __allegro_platform_alunix_bi__

#define ALLEGRO_CONSOLE_OK
#define ALLEGRO_VRAM_SINGLE_SURFACE

extern __crt0_argc alias "__crt0_argc" as integer
extern __crt0_argv alias "__crt0_argv" as zstring ptr ptr

extern as any ptr _mangled_main_address alias "_mangled_main_address"

#ifndef USE_CONSOLE
 #define ALLEGRO_MAGIC_MAIN
 declare function main cdecl alias "main"( byval argc as integer, byval argv as zstring ptr ptr) as integer
 #undef END_OF_MAIN
 #define END_OF_MAIN() dim as any ptr _mangled_main_address = @main
#else
 #undef END_OF_MAIN
 #define END_OF_MAIN() dim as any ptr _mangled_main_address
#endif

#define TIMERDRV_UNIX_PTHREADS AL_ID(asc("P"),asc("T"),asc("H"),asc("R"))
#define DIGI_OSS AL_ID(asc("O"),asc("S"),asc("S"),asc("D"))
#define MIDI_OSS AL_ID(asc("O"),asc("S"),asc("S"),asc("M"))
#define DIGI_ESD AL_ID(asc("E"),asc("S"),asc("D"),asc("D"))
#define DIGI_ARTS AL_ID(asc("A"),asc("R"),asc("T"),asc("S"))
#define DIGI_ALSA AL_ID(asc("A"),asc("L"),asc("S"),asc("A"))
#define MIDI_ALSA AL_ID(asc("A"),asc("M"),asc("I"),asc("D"))
#define SYSTEM_XWINDOWS AL_ID(asc("X"),asc("W"),asc("I"),asc("N"))
#define GFX_XWINDOWS AL_ID(asc("X"),asc("W"),asc("I"),asc("N"))
#define GFX_XWINDOWS_FULLSCREEN AL_ID(asc("X"),asc("W"),asc("F"),asc("S"))
#define KEYBOARD_XWINDOWS AL_ID(asc("X"),asc("W"),asc("I"),asc("N"))
#define MOUSE_XWINDOWS AL_ID(asc("X"),asc("W"),asc("I"),asc("N"))
#define GFX_XDGA AL_ID(asc("X"),asc("D"),asc("G"),asc("A"))
#define GFX_XDGA_FULLSCREEN AL_ID(asc("X"),asc("D"),asc("F"),asc("S"))
#define GFX_XDGA2 AL_ID(asc("D"),asc("G"),asc("A"),asc("2"))
#define GFX_XDGA2_SOFT AL_ID(asc("D"),asc("G"),asc("A"),asc("S"))

extern timerdrv_unix_pthreads_ alias "timerdrv_unix_pthreads" as TIMER_DRIVER
extern digi_oss_ alias "digi_oss" as DIGI_DRIVER
extern midi_oss_ alias "midi_oss" as MIDI_DRIVER
extern digi_esd_ alias "digi_esd" as DIGI_DRIVER
extern digi_arts_ alias "digi_arts" as DIGI_DRIVER
extern digi_alsa_ alias "digi_alsa" as DIGI_DRIVER
extern midi_alsa_ alias "midi_alsa" as MIDI_DRIVER
extern system_xwin_ alias "system_xwin" as SYSTEM_DRIVER
extern gfx_xdga2_ alias "gfx_xdga2" as GFX_DRIVER
extern gfx_xdga2_soft_ alias "gfx_xdga2_soft" as GFX_DRIVER
extern system_linux_ alias "system_linux" as SYSTEM_DRIVER
extern gfx_vga_ alias "gfx_vga" as GFX_DRIVER
extern gfx_modex_ alias "gfx_modex" as GFX_DRIVER
extern gfx_fbcon_ alias "gfx_fbcon" as GFX_DRIVER
extern gfx_vbeaf_ alias "gfx_vbeaf" as GFX_DRIVER
extern gfx_svgalib_ alias "gfx_svgalib" as GFX_DRIVER

#ifdef ALLEGRO_LINUX
 #define SYSTEM_LINUX AL_ID(asc("L"),asc("N"),asc("X"),asc("C"))
 #define GFX_VGA AL_ID(asc("V"),asc("G"),asc("A"),asc(" "))
 #define GFX_MODEX AL_ID(asc("M"),asc("O"),asc("D"),asc("X"))
 #define GFX_FBCON AL_ID(asc("F"),asc("B"),asc(" "),asc(" "))
 #define GFX_VBEAF AL_ID(asc("V"),asc("B"),asc("A"),asc("F"))
 #define GFX_SVGALIB AL_ID(asc("S"),asc("V"),asc("G"),asc("A"))
 #define KEYDRV_LINUX AL_ID(asc("L"),asc("N"),asc("X"),asc("C"))
 #define MOUSEDRV_LINUX_PS2 AL_ID(asc("L"),asc("P"),asc("S"),asc("2"))
 #define MOUSEDRV_LINUX_IPS2 AL_ID(asc("L"),asc("I"),asc("P"),asc("S"))
 #define MOUSEDRV_LINUX_GPMDATA AL_ID(asc("G"),asc("P"),asc("M"),asc("D"))
 #define MOUSEDRV_LINUX_MS AL_ID(asc("M"),asc("S"),asc(" "),asc(" "))
 #define MOUSEDRV_LINUX_IMS AL_ID(asc("I"),asc("M"),asc("S"),asc(" "))
 #define JOY_TYPE_LINUX_ANALOGUE AL_ID(asc("L"),asc("N"),asc("X"),asc("A"))

extern keydrv_linux_console_ alias "keydrv_linux_console" as KEYBOARD_DRIVER
extern mousedrv_linux_ps2_ alias "mousedrv_linux_ps2" as MOUSE_DRIVER
extern mousedrv_linux_ips2_ alias "mousedrv_linux_ips2" as MOUSE_DRIVER
extern mousedrv_linux_gpmdata_ alias "mousedrv_linux_gpmdata" as MOUSE_DRIVER
extern mousedrv_linux_ms_ alias "mousedrv_linux_ms" as MOUSE_DRIVER
extern mousedrv_linux_ims_ alias "mousedrv_linux_ims" as MOUSE_DRIVER
extern joystick_linux_analogue_ alias "joystick_linux_analogue" as JOYSTICK_DRIVER

declare sub split_modex_screen cdecl alias "split_modex_screen" (byval line as integer)

private sub outportb cdecl alias "outportb" (byval port as ushort, byval value as ubyte)
	asm
		mov dx, [port]
		mov al, [value]
		out dx, al
	end asm
end sub

private sub outportw cdecl alias "outportw" (byval port as ushort, byval value as ushort)
	asm
		mov dx, [port]
		mov ax, [value]
		out dx, ax
	end asm
end sub

private sub outportl cdecl alias "outportl" (byval port as ushort, byval value as uinteger)
	asm
		mov dx, [port]
		mov eax, [value]
		out dx, eax
	end asm
end sub

private function inportb cdecl alias "inportb" (byval port as ushort) as ubyte
	asm
		mov dx, [port]
		in  al, dx
		mov [function], al
	end asm
end function

private function inportw cdecl alias "inportw" (byval port as ushort) as ushort
	asm
		mov dx, [port]
		in  ax, dx
		mov [function], ax
	end asm
end function

private function inportl cdecl alias "inportl" (byval port as ushort) as uinteger
	asm
		mov dx, [port]
		in  eax, dx
		mov [function], eax
	end asm
end function

#endif '' ALLEGRO_LINUX

#endif
