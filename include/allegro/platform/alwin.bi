''
''
'' allegro\platform\alwin -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_platform_alwin_bi__
#define __allegro_platform_alwin_bi__

#define SYSTEM_DIRECTX AL_ID(asc("D"),asc("X"),asc(" "),asc(" "))
#define TIMER_WIN32_HIGH_PERF AL_ID(asc("W"),asc("3"),asc("2"),asc("H"))
#define TIMER_WIN32_LOW_PERF AL_ID(asc("W"),asc("3"),asc("2"),asc("L"))
#define KEYBOARD_DIRECTX AL_ID(asc("D"),asc("X"),asc(" "),asc(" "))
#define MOUSE_DIRECTX AL_ID(asc("D"),asc("X"),asc(" "),asc(" "))
#define GFX_DIRECTX AL_ID(asc("D"),asc("X"),asc("A"),asc("C"))
#define GFX_DIRECTX_ACCEL AL_ID(asc("D"),asc("X"),asc("A"),asc("C"))
#define GFX_DIRECTX_SAFE AL_ID(asc("D"),asc("X"),asc("S"),asc("A"))
#define GFX_DIRECTX_SOFT AL_ID(asc("D"),asc("X"),asc("S"),asc("O"))
#define GFX_DIRECTX_WIN AL_ID(asc("D"),asc("X"),asc("W"),asc("N"))
#define GFX_DIRECTX_OVL AL_ID(asc("D"),asc("X"),asc("O"),asc("V"))
#define GFX_GDI AL_ID(asc("G"),asc("D"),asc("I"),asc("B"))
#define DIGI_DIRECTX(n) AL_ID(asc("D"),asc("X"),asc("A")+(n),asc(" "))
#define DIGI_DIRECTAMX(n) AL_ID(asc("A"),asc("X"),asc("A")+(n),asc(" "))
#define DIGI_WAVOUTID(n) AL_ID(asc("W"),asc("O"),asc("A")+(n),asc(" "))
#define MIDI_WIN32MAPPER AL_ID(asc("W"),asc("3"),asc("2"),asc("M"))
#define MIDI_WIN32(n) AL_ID(asc("W"),asc("3"),asc("2"),asc("A")+(n))
#define JOY_TYPE_WIN32 AL_ID(asc("W"),asc("3"),asc("2"),asc(" "))

declare function _WinMain cdecl alias "_WinMain" (byval _main as any ptr, byval hInst as any ptr, byval hPrev as any ptr, byval Cmd as zstring ptr, byval nShow as integer) as integer

extern _AL_DLL system_directx_ alias "system_directx" as SYSTEM_DRIVER
extern _AL_DLL timer_win32_high_perf_ alias "timer_win32_high_perf" as TIMER_DRIVER
extern _AL_DLL timer_win32_low_perf_ alias "timer_win32_low_perf" as TIMER_DRIVER
extern _AL_DLL keyboard_directx_ alias "keyboard_directx" as KEYBOARD_DRIVER
extern _AL_DLL mouse_directx_ alias "mouse_directx" as MOUSE_DRIVER
extern _AL_DLL gfx_directx_accel_ alias "gfx_directx_accel" as GFX_DRIVER
extern _AL_DLL gfx_directx_safe_ alias "gfx_directx_safe" as GFX_DRIVER
extern _AL_DLL gfx_directx_soft_ alias "gfx_directx_soft" as GFX_DRIVER
extern _AL_DLL gfx_directx_win_ alias "gfx_directx_win" as GFX_DRIVER
extern _AL_DLL gfx_directx_ovl_ alias "gfx_directx_ovl" as GFX_DRIVER
extern _AL_DLL gfx_gdi_ alias "gfx_gdi" as GFX_DRIVER

#define GFX_SAFE_ID GFX_DIRECTX_SAFE
#define GFX_SAFE_DEPTH 8
#define GFX_SAFE_W 640
#define GFX_SAFE_H 480

extern _AL_DLL joystick_win32 alias "joystick_win32" as JOYSTICK_DRIVER

#endif
