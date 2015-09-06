'' FreeBASIC binding for allegro-4.4.2
''
'' based on the C header files:
''     ______   ___    ___
''    /\  _  \ /\_ \  /\_ \
''    \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___ 
''     \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
''      \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
''       \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
''        \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
''                                       /\____/
''                                       \_/__/     Version 4.4.2
''
''
''                A game programming library.
''
''             By Shawn Hargreaves, May 19, 2011.
''
''   Allegro is gift-ware. It was created by a number of people working in 
''   cooperation, and is given to you freely as a gift. You may use, modify, 
''   redistribute, and generally hack it about in any way you like, and you do 
''   not have to give us anything in return. However, if you like this product 
''   you are encouraged to thank us by making a return gift to the Allegro 
''   community. This could be by writing an add-on package, providing a useful 
''   bug report, making an improvement to the library, or perhaps just 
''   releasing the sources of your program so that other people can learn from 
''   them. If you redistribute parts of this code or make a game using it, it 
''   would be nice if you mentioned Allegro somewhere in the credits, but you 
''   are not required to do this. We trust you not to abuse our generosity.
''
''   Disclaimer:
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
''   SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
''   FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
''   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#if defined(__FB_DOS__) or (defined(__FB_WIN32__) and (not defined(ALLEGRO_STATICLINK))) or defined(__FB_UNIX__)
	#inclib "alleg"
#endif

#ifdef __FB_UNIX__
	#inclib "X11"
	#inclib "Xext"
	#inclib "Xpm"
	#inclib "Xxf86vm"
	#inclib "Xcursor"
#elseif defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "alleg_s"
#endif

#undef screen
#undef circle
#undef line
#undef palette
#undef rgb

#include once "crt/long.bi"
#include once "crt/errno.bi"
#include once "crt/limits.bi"
#include once "crt/stdarg.bi"
#include once "crt/stddef.bi"
#include once "crt/stdlib.bi"
#include once "crt/time.bi"
#include once "crt/string.bi"

#ifdef __FB_WIN32__
	#include once "crt/stdint.bi"
#endif

'' The following symbols have been renamed:
''     #define MID => AL_MID
''     #define EMPTY_STRING => EMPTY_STRING_
''     #define SYSTEM_NONE => SYSTEM_NONE_
''     constant MOUSEDRV_NONE => MOUSEDRV_NONE_
''     constant DRAW_SPRITE_H_FLIP => DRAW_SPRITE_H_FLIP_
''     constant DRAW_SPRITE_V_FLIP => DRAW_SPRITE_V_FLIP_
''     constant DRAW_SPRITE_VH_FLIP => DRAW_SPRITE_VH_FLIP_
''     #define MIDI_DIGMID => MIDI_DIGMID_
''     #define EOF => EOF_
''     #define cpu_fpu => cpu_fpu_
''     #define cpu_mmx => cpu_mmx_
''     #define cpu_3dnow => cpu_3dnow_
''     #ifdef __FB_UNIX__
''         #define TIMERDRV_UNIX_PTHREADS => TIMERDRV_UNIX_PTHREADS_
''         #define SYSTEM_LINUX => SYSTEM_LINUX_
''     #elseif defined(__FB_DOS__)
''         #define SYSTEM_DOS => SYSTEM_DOS_
''         #define KEYDRV_PCDOS => KEYDRV_PCDOS_
''         #define TIMEDRV_FIXED_RATE => TIMEDRV_FIXED_RATE_
''         #define TIMEDRV_VARIABLE_RATE => TIMEDRV_VARIABLE_RATE_
''         #define MOUSEDRV_MICKEYS => MOUSEDRV_MICKEYS_
''         #define MOUSEDRV_INT33 => MOUSEDRV_INT33_
''         #define MOUSEDRV_POLLING => MOUSEDRV_POLLING_
''         #define MOUSEDRV_WINNT => MOUSEDRV_WINNT_
''         #define MOUSEDRV_WIN2K => MOUSEDRV_WIN2K_
''     #endif
''     #if defined(__FB_DOS__) or defined(__FB_UNIX__)
''         #define GFX_VGA => GFX_VGA_
''         #define GFX_MODEX => GFX_MODEX_
''         #define GFX_VBEAF => GFX_VBEAF_
''     #endif
''     #ifdef __FB_UNIX__
''         #define MOUSEDRV_LINUX_PS2 => MOUSEDRV_LINUX_PS2_
''         #define MOUSEDRV_LINUX_IPS2 => MOUSEDRV_LINUX_IPS2_
''         #define MOUSEDRV_LINUX_GPMDATA => MOUSEDRV_LINUX_GPMDATA_
''         #define MOUSEDRV_LINUX_MS => MOUSEDRV_LINUX_MS_
''         #define MOUSEDRV_LINUX_IMS => MOUSEDRV_LINUX_IMS_
''         #define MOUSEDRV_LINUX_EVDEV => MOUSEDRV_LINUX_EVDEV_
''     #elseif defined(__FB_WIN32__)
''         #define SYSTEM_DIRECTX => SYSTEM_DIRECTX_
''         #define GFX_DIRECTX_ACCEL => GFX_DIRECTX_ACCEL_
''         #define GFX_DIRECTX_SAFE => GFX_DIRECTX_SAFE_
''         #define GFX_DIRECTX_SOFT => GFX_DIRECTX_SOFT_
''         #define GFX_DIRECTX_WIN => GFX_DIRECTX_WIN_
''         #define GFX_DIRECTX_OVL => GFX_DIRECTX_OVL_
''         #define GFX_GDI => GFX_GDI_
''     #else
''         #define GFX_XTENDED => GFX_XTENDED_
''         #define DIGI_SB10 => DIGI_SB10_
''         #define DIGI_SB15 => DIGI_SB15_
''         #define DIGI_SB20 => DIGI_SB20_
''         #define DIGI_SBPRO => DIGI_SBPRO_
''         #define DIGI_SB16 => DIGI_SB16_
''         #define DIGI_AUDIODRIVE => DIGI_AUDIODRIVE_
''         #define DIGI_SOUNDSCAPE => DIGI_SOUNDSCAPE_
''         #define MIDI_OPL2 => MIDI_OPL2_
''         #define MIDI_2XOPL2 => MIDI_2XOPL2_
''         #define MIDI_OPL3 => MIDI_OPL3_
''         #define MIDI_SB_OUT => MIDI_SB_OUT_
''         #define MIDI_AWE32 => MIDI_AWE32_
''     #endif

extern "C"

#define ALLEGRO_H
#define ALLEGRO_BASE_H
#define ALLEGRO_COLOR8
#define ALLEGRO_COLOR16
#define ALLEGRO_COLOR24
#define ALLEGRO_COLOR32

#ifdef __FB_UNIX__
	const ALLEGRO_UNIX = 1
#elseif defined(__FB_WIN32__)
	const ALLEGRO_MINGW32 = 1
#else
	const ALLEGRO_DJGPP = 1
#endif

#if defined(__FB_WIN32__) and (not defined(ALLEGRO_STATICLINK))
	#define _AL_DLL import
#else
	#define _AL_DLL
#endif

#define ALLEGRO_NO_ASM
#define ALLEGRO_USE_C

#ifdef __FB_UNIX__
	#define ALLEGRO_PLATFORM_STR "Unix"
#elseif defined(__FB_DOS__)
	#define ALLEGRO_PLATFORM_STR "djgpp"
	#define ALLEGRO_DOS
	#define ALLEGRO_I386
	#define ALLEGRO_LITTLE_ENDIAN
	#define ALLEGRO_GUESS_INTTYPES_OK
#endif

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	#define ALLEGRO_CONSOLE_OK
	#define ALLEGRO_VRAM_SINGLE_SURFACE
#endif

#ifdef __FB_UNIX__
	#undef ALLEGRO_COLOR8
	#undef ALLEGRO_COLOR16
	#undef ALLEGRO_COLOR24
	#undef ALLEGRO_COLOR32

	const ALLEGRO_COLOR8 = 1
	const ALLEGRO_COLOR16 = 1
	const ALLEGRO_COLOR24 = 1
	const ALLEGRO_COLOR32 = 1
	const ALLEGRO_HAVE_INTTYPES_H = 1
#endif

#if defined(__FB_WIN32__) or defined(__FB_UNIX__)
	const ALLEGRO_HAVE_STDINT_H = 1
#endif

#ifdef __FB_UNIX__
	const ALLEGRO_HAVE_MEMCMP = 1
	const ALLEGRO_LITTLE_ENDIAN = 1
#elseif defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#define ALLEGRO_PLATFORM_STR "MinGW32.s"
#elseif defined(__FB_WIN32__) and (not defined(ALLEGRO_STATICLINK))
	#define ALLEGRO_PLATFORM_STR "MinGW32"
#endif

#ifdef __FB_WIN32__
	#define ALLEGRO_WINDOWS
	#define ALLEGRO_I386
	#define ALLEGRO_LITTLE_ENDIAN
#endif

#if defined(__FB_DOS__) or defined(__FB_WIN32__)
	#define ALLEGRO_USE_CONSTRUCTOR
#endif

#if defined(__FB_WIN32__) or defined(__FB_UNIX__)
	#define ALLEGRO_MULTITHREADED
#endif

#ifdef __FB_UNIX__
	#define ALLEGRO_NO_STRICMP
	#define ALLEGRO_NO_STRLWR
	#define ALLEGRO_NO_STRUPR
#elseif defined(__FB_DOS__)
	declare sub _unlock_dpmi_data(byval addr as any ptr, byval size as long)
	#define LOCK_DATA(d, s) _go32_dpmi_lock_data(cptr(any ptr, d), s)
	#define LOCK_CODE(c, s) _go32_dpmi_lock_code(cptr(any ptr, c), s)
	#define UNLOCK_DATA(d, s) _unlock_dpmi_data(cptr(any ptr, d), s)
	#define LOCK_VARIABLE(x) LOCK_DATA(cptr(any ptr, @x), sizeof(x))
	#define LOCK_FUNCTION(x) LOCK_CODE(cptr(any ptr, x), cint(x##_end) - cint(x))
	const ALLEGRO_LFN = 0
	#define _video_ds() _dos_ds
	#define bmp_select(bmp) _farsetsel((bmp)->seg)
	#define bmp_write8(addr, c) _farnspokeb(addr, c)
	#define bmp_write15(addr, c) _farnspokew(addr, c)
	#define bmp_write16(addr, c) _farnspokew(addr, c)
	#macro bmp_write24(addr, c)
		scope
			_farnspokew(addr, c and &hFFFF)
			_farnspokeb(addr + 2, c shr 16)
		end scope
	#endmacro
	#define bmp_write32(addr, c) _farnspokel(addr, c)
	#define bmp_read8(addr) _farnspeekb(addr)
	#define bmp_read15(addr) _farnspeekw(addr)
	#define bmp_read16(addr) _farnspeekw(addr)
	#define bmp_read32(addr) _farnspeekl(addr)
	#define bmp_read24(addr) (_farnspeekl(addr) and &hFFFFFF)
#endif

#if defined(__FB_DOS__) or defined(__FB_WIN32__)
	#define ALLEGRO_ASM_PREFIX "_"
#endif

#ifdef __FB_DOS__
	#define ALLEGRO_ASM_USE_FS
#endif

#define ASTDINT_H
#define ALLEGRO_GCC

#if defined(__FB_DOS__) or ((not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_WIN32__)))
	#define ALLEGRO_I386
#elseif defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_WIN32__))
	#define ALLEGRO_AMD64
#elseif (not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	#define ALLEGRO_ARM
#endif

#macro _AL_SINCOS(x, s, c)
	scope
		(c) = cos(x)
		(s) = sin(x)
	end scope
#endmacro
#define END_OF_MAIN()

#if defined(__FB_WIN32__) or defined(__FB_UNIX__)
	#define LOCK_DATA(d, s)
	#define LOCK_CODE(c, s)
	#define UNLOCK_DATA(d, s)
	#define LOCK_VARIABLE(x)
	#define LOCK_FUNCTION(x)
	const ALLEGRO_LFN = 1
#endif

#ifdef __FB_UNIX__
	#define OTHER_PATH_SEPARATOR asc("/")
	#define DEVICE_SEPARATOR asc(!"\0")
#else
	#define OTHER_PATH_SEPARATOR asc(!"\\")
	#define DEVICE_SEPARATOR asc(":")
#endif

const FA_RDONLY = 1
const FA_HIDDEN = 2
const FA_SYSTEM = 4
const FA_LABEL = 8
const FA_DIREC = 16
const FA_ARCH = 32
const FA_NONE = 0
const FA_ALL = not FA_NONE

#ifdef __FB_UNIX__
	declare function _alemu_stricmp(byval s1 as const zstring ptr, byval s2 as const zstring ptr) as long
	declare function stricmp alias "_alemu_stricmp"(byval s1 as const zstring ptr, byval s2 as const zstring ptr) as long
	declare function _alemu_strlwr(byval string as zstring ptr) as zstring ptr
	declare function strlwr alias "_alemu_strlwr"(byval string as zstring ptr) as zstring ptr
	declare function _alemu_strupr(byval string as zstring ptr) as zstring ptr
	declare function strupr alias "_alemu_strupr"(byval string as zstring ptr) as zstring ptr
#endif

#if defined(__FB_WIN32__) or defined(__FB_UNIX__)
	#define _video_ds() _default_ds()
	#define _farsetsel(seg)
	#define _farnspokeb(addr, val) scope : (*cptr(ubyte ptr, (addr))) = (val) : end scope
	#define _farnspokew(addr, val) scope : (*cptr(ushort ptr, (addr))) = (val) : end scope
	#define _farnspokel(addr, val) scope : (*cptr(ulong ptr, (addr))) = (val) : end scope
	#define _farnspeekb(addr) (*cptr(ubyte ptr, (addr)))
	#define _farnspeekw(addr) (*cptr(ushort ptr, (addr)))
	#define _farnspeekl(addr) (*cptr(ulong ptr, (addr)))
#endif

#define READ3BYTES(p) (((*cptr(ubyte ptr, (p))) or ((*(cptr(ubyte ptr, (p)) + 1)) shl 8)) or ((*(cptr(ubyte ptr, (p)) + 2)) shl 16))
#macro WRITE3BYTES(p, c)
	scope
		(*cptr(ubyte ptr, (p))) = (c)
		(*(cptr(ubyte ptr, (p)) + 1)) = (c) shr 8
		(*(cptr(ubyte ptr, (p)) + 2)) = (c) shr 16
	end scope
#endmacro

#if defined(__FB_WIN32__) or defined(__FB_UNIX__)
	#define bmp_select(bmp)
	#define bmp_write8(addr, c) scope : (*cptr(ubyte ptr, (addr))) = (c) : end scope
	#define bmp_write15(addr, c) scope : (*cptr(ushort ptr, (addr))) = (c) : end scope
	#define bmp_write16(addr, c) scope : (*cptr(ushort ptr, (addr))) = (c) : end scope
	#define bmp_write32(addr, c) scope : (*cptr(ulong ptr, (addr))) = (c) : end scope
	#define bmp_read8(addr) (*cptr(ubyte ptr, (addr)))
	#define bmp_read15(addr) (*cptr(ushort ptr, (addr)))
	#define bmp_read16(addr) (*cptr(ushort ptr, (addr)))
	#define bmp_read32(addr) (*cptr(ulong ptr, (addr)))
	declare function bmp_read24(byval addr as uinteger) as long
	declare sub bmp_write24(byval addr as uinteger, byval c as long)
#endif

#define AL_RAND() rand()

#ifdef __FB_WIN32__
	#define ALLEGRO_COLORCONV_ALIGNED_WIDTH
	#define ALLEGRO_NO_COLORCOPY
#endif

const ALLEGRO_VERSION = 4
const ALLEGRO_SUB_VERSION = 4
const ALLEGRO_WIP_VERSION = 2
#define ALLEGRO_VERSION_STR "4.4.2"
#define ALLEGRO_DATE_STR "2011"
const ALLEGRO_DATE = 20110519
#ifndef TRUE
	const TRUE = -1
#endif
#ifndef FALSE
	const FALSE = 0
#endif

#undef MIN
#undef MAX
#undef AL_MID

#define MIN(x, y) iif((x) < (y), (x), (y))
#define MAX(x, y) iif((x) > (y), (x), (y))
#define AL_MID(x, y, z) iif((x) > (y), iif((y) > (z), (y), iif((x) > (z), (z), (x))), iif((y) > (z), iif((z) > (x), (z), (x)), (y)))
#define CLAMP(x, y, z) MAX((x), MIN((y), (z)))
const AL_PI = 3.14159265358979323846
#define AL_ID(a, b, c, d) (((((a) shl 24) or ((b) shl 16)) or ((c) shl 8)) or (d))

extern _AL_DLL allegro_errno as long ptr

type _DRIVER_INFO
	id as long
	driver as any ptr
	autodetect as long
end type

#define ALLEGRO_SYSTEM_H
#define ALLEGRO_UNICODE__H
#define U_ASCII AL_ID(asc("A"), asc("S"), asc("C"), asc("8"))
#define U_ASCII_CP AL_ID(asc("A"), asc("S"), asc("C"), asc("P"))
#define U_UNICODE AL_ID(asc("U"), asc("N"), asc("I"), asc("C"))
#define U_UTF8 AL_ID(asc("U"), asc("T"), asc("F"), asc("8"))
#define U_CURRENT AL_ID(asc("c"), asc("u"), asc("r"), asc("."))

declare sub set_uformat(byval type as long)
declare function get_uformat() as long
declare sub register_uformat(byval type as long, byval u_getc as function(byval s as const zstring ptr) as long, byval u_getx as function(byval s as zstring ptr ptr) as long, byval u_setc as function(byval s as zstring ptr, byval c as long) as long, byval u_width as function(byval s as const zstring ptr) as long, byval u_cwidth as function(byval c as long) as long, byval u_isok as function(byval c as long) as long, byval u_width_max as long)
declare sub set_ucodepage(byval table as const ushort ptr, byval extras as const ushort ptr)
declare function need_uconvert(byval s as const zstring ptr, byval type as long, byval newtype as long) as long
declare function uconvert_size(byval s as const zstring ptr, byval type as long, byval newtype as long) as long
declare sub do_uconvert(byval s as const zstring ptr, byval type as long, byval buf as zstring ptr, byval newtype as long, byval size as long)
declare function uconvert(byval s as const zstring ptr, byval type as long, byval buf as zstring ptr, byval newtype as long, byval size as long) as zstring ptr
declare function uwidth_max(byval type as long) as long

#define uconvert_ascii(s, buf) uconvert(s, U_ASCII, buf, U_CURRENT, sizeof(buf))
#define uconvert_toascii(s, buf) uconvert(s, U_CURRENT, buf, U_ASCII, sizeof(buf))
#define EMPTY_STRING_ !"\0\0\0"
extern _AL_DLL empty_string as zstring * 4
extern _AL_DLL ugetc as function(byval s as const zstring ptr) as long
extern _AL_DLL ugetx as function(byval s as zstring ptr ptr) as long
extern _AL_DLL ugetxc as function(byval s as const zstring ptr ptr) as long
extern _AL_DLL usetc as function(byval s as zstring ptr, byval c as long) as long
extern _AL_DLL uwidth as function(byval s as const zstring ptr) as long
extern _AL_DLL ucwidth as function(byval c as long) as long
extern _AL_DLL uisok as function(byval c as long) as long

declare function uoffset(byval s as const zstring ptr, byval idx as long) as long
declare function ugetat(byval s as const zstring ptr, byval idx as long) as long
declare function usetat(byval s as zstring ptr, byval idx as long, byval c as long) as long
declare function uinsert(byval s as zstring ptr, byval idx as long, byval c as long) as long
declare function uremove(byval s as zstring ptr, byval idx as long) as long
declare function utolower(byval c as long) as long
declare function utoupper(byval c as long) as long
declare function uisspace(byval c as long) as long
declare function uisdigit(byval c as long) as long
declare function ustrsize(byval s as const zstring ptr) as long
declare function ustrsizez(byval s as const zstring ptr) as long
declare function _ustrdup(byval src as const zstring ptr, byval malloc_func as function(byval as uinteger) as any ptr) as zstring ptr
declare function ustrzcpy(byval dest as zstring ptr, byval size as long, byval src as const zstring ptr) as zstring ptr
declare function ustrzcat(byval dest as zstring ptr, byval size as long, byval src as const zstring ptr) as zstring ptr
declare function ustrlen(byval s as const zstring ptr) as long
declare function ustrcmp(byval s1 as const zstring ptr, byval s2 as const zstring ptr) as long
declare function ustrzncpy(byval dest as zstring ptr, byval size as long, byval src as const zstring ptr, byval n as long) as zstring ptr
declare function ustrzncat(byval dest as zstring ptr, byval size as long, byval src as const zstring ptr, byval n as long) as zstring ptr
declare function ustrncmp(byval s1 as const zstring ptr, byval s2 as const zstring ptr, byval n as long) as long
declare function ustricmp(byval s1 as const zstring ptr, byval s2 as const zstring ptr) as long
declare function ustrnicmp(byval s1 as const zstring ptr, byval s2 as const zstring ptr, byval n as long) as long
declare function ustrlwr(byval s as zstring ptr) as zstring ptr
declare function ustrupr(byval s as zstring ptr) as zstring ptr
declare function ustrchr(byval s as const zstring ptr, byval c as long) as zstring ptr
declare function ustrrchr(byval s as const zstring ptr, byval c as long) as zstring ptr
declare function ustrstr(byval s1 as const zstring ptr, byval s2 as const zstring ptr) as zstring ptr
declare function ustrpbrk(byval s as const zstring ptr, byval set as const zstring ptr) as zstring ptr
declare function ustrtok(byval s as zstring ptr, byval set as const zstring ptr) as zstring ptr
declare function ustrtok_r(byval s as zstring ptr, byval set as const zstring ptr, byval last as zstring ptr ptr) as zstring ptr
declare function uatof(byval s as const zstring ptr) as double
declare function ustrtol(byval s as const zstring ptr, byval endp as zstring ptr ptr, byval base as long) as clong
declare function ustrtod(byval s as const zstring ptr, byval endp as zstring ptr ptr) as double
declare function ustrerror(byval err as long) as const zstring ptr
declare function uszprintf(byval buf as zstring ptr, byval size as long, byval format as const zstring ptr, ...) as long
declare function uvszprintf(byval buf as zstring ptr, byval size as long, byval format as const zstring ptr, byval args as va_list) as long
declare function usprintf(byval buf as zstring ptr, byval format as const zstring ptr, ...) as long

#define ustrdup(src) _ustrdup(src, malloc)
#define ustrcpy(dest, src) ustrzcpy(dest, INT_MAX, src)
#define ustrcat(dest, src) ustrzcat(dest, INT_MAX, src)
#define ustrncpy(dest, src, n) ustrzncpy(dest, INT_MAX, src, n)
#define ustrncat(dest, src, n) ustrzncat(dest, INT_MAX, src, n)
#define uvsprintf(buf, format, args) uvszprintf(buf, INT_MAX, format, args)
#define ALLEGRO_CONFIG_H

declare sub set_config_file(byval filename as const zstring ptr)
declare sub set_config_data(byval data as const zstring ptr, byval length as long)
declare sub override_config_file(byval filename as const zstring ptr)
declare sub override_config_data(byval data as const zstring ptr, byval length as long)
declare sub flush_config_file()
declare sub reload_config_texts(byval new_language as const zstring ptr)
declare sub push_config_state()
declare sub pop_config_state()
declare sub hook_config_section(byval section as const zstring ptr, byval intgetter as function(byval as const zstring ptr, byval as long) as long, byval stringgetter as function(byval as const zstring ptr, byval as const zstring ptr) as const zstring ptr, byval stringsetter as sub(byval as const zstring ptr, byval as const zstring ptr))
declare function config_is_hooked(byval section as const zstring ptr) as long
declare function get_config_string(byval section as const zstring ptr, byval name as const zstring ptr, byval def as const zstring ptr) as const zstring ptr
declare function get_config_int(byval section as const zstring ptr, byval name as const zstring ptr, byval def as long) as long
declare function get_config_hex(byval section as const zstring ptr, byval name as const zstring ptr, byval def as long) as long
declare function get_config_float(byval section as const zstring ptr, byval name as const zstring ptr, byval def as single) as single
declare function get_config_id(byval section as const zstring ptr, byval name as const zstring ptr, byval def as long) as long
declare function get_config_argv(byval section as const zstring ptr, byval name as const zstring ptr, byval argc as long ptr) as zstring ptr ptr
declare function get_config_text(byval msg as const zstring ptr) as const zstring ptr
declare sub set_config_string(byval section as const zstring ptr, byval name as const zstring ptr, byval val as const zstring ptr)
declare sub set_config_int(byval section as const zstring ptr, byval name as const zstring ptr, byval val as long)
declare sub set_config_hex(byval section as const zstring ptr, byval name as const zstring ptr, byval val as long)
declare sub set_config_float(byval section as const zstring ptr, byval name as const zstring ptr, byval val as single)
declare sub set_config_id(byval section as const zstring ptr, byval name as const zstring ptr, byval val as long)
declare function list_config_entries(byval section as const zstring ptr, byval names as const zstring ptr ptr ptr) as long
declare function list_config_sections(byval names as const zstring ptr ptr ptr) as long
declare sub free_config_entries(byval names as const zstring ptr ptr ptr)
const ALLEGRO_ERROR_SIZE = 256

extern _AL_DLL __allegro_id alias "allegro_id" as byte
#define allegro_id (*cptr(zstring ptr, @__allegro_id))
extern _AL_DLL allegro_error as zstring * ALLEGRO_ERROR_SIZE

const OSTYPE_UNKNOWN = 0
#define OSTYPE_WIN3 AL_ID(asc("W"), asc("I"), asc("N"), asc("3"))
#define OSTYPE_WIN95 AL_ID(asc("W"), asc("9"), asc("5"), asc(" "))
#define OSTYPE_WIN98 AL_ID(asc("W"), asc("9"), asc("8"), asc(" "))
#define OSTYPE_WINME AL_ID(asc("W"), asc("M"), asc("E"), asc(" "))
#define OSTYPE_WINNT AL_ID(asc("W"), asc("N"), asc("T"), asc(" "))
#define OSTYPE_WIN2000 AL_ID(asc("W"), asc("2"), asc("K"), asc(" "))
#define OSTYPE_WINXP AL_ID(asc("W"), asc("X"), asc("P"), asc(" "))
#define OSTYPE_WIN2003 AL_ID(asc("W"), asc("2"), asc("K"), asc("3"))
#define OSTYPE_WINVISTA AL_ID(asc("W"), asc("V"), asc("S"), asc("T"))
#define OSTYPE_WIN7 AL_ID(asc("W"), asc("I"), asc("N"), asc("7"))
#define OSTYPE_OS2 AL_ID(asc("O"), asc("S"), asc("2"), asc(" "))
#define OSTYPE_WARP AL_ID(asc("W"), asc("A"), asc("R"), asc("P"))
#define OSTYPE_DOSEMU AL_ID(asc("D"), asc("E"), asc("M"), asc("U"))
#define OSTYPE_OPENDOS AL_ID(asc("O"), asc("D"), asc("O"), asc("S"))
#define OSTYPE_LINUX AL_ID(asc("T"), asc("U"), asc("X"), asc(" "))
#define OSTYPE_SUNOS AL_ID(asc("S"), asc("U"), asc("N"), asc(" "))
#define OSTYPE_FREEBSD AL_ID(asc("F"), asc("B"), asc("S"), asc("D"))
#define OSTYPE_NETBSD AL_ID(asc("N"), asc("B"), asc("S"), asc("D"))
#define OSTYPE_OPENBSD AL_ID(asc("O"), asc("B"), asc("S"), asc("D"))
#define OSTYPE_IRIX AL_ID(asc("I"), asc("R"), asc("I"), asc("X"))
#define OSTYPE_DARWIN AL_ID(asc("D"), asc("A"), asc("R"), asc("W"))
#define OSTYPE_QNX AL_ID(asc("Q"), asc("N"), asc("X"), asc(" "))
#define OSTYPE_UNIX AL_ID(asc("U"), asc("N"), asc("I"), asc("X"))
#define OSTYPE_BEOS AL_ID(asc("B"), asc("E"), asc("O"), asc("S"))
#define OSTYPE_HAIKU AL_ID(asc("H"), asc("A"), asc("I"), asc("K"))
#define OSTYPE_MACOS AL_ID(asc("M"), asc("A"), asc("C"), asc(" "))
#define OSTYPE_MACOSX AL_ID(asc("M"), asc("A"), asc("C"), asc("X"))
#define OSTYPE_PSP AL_ID(asc("K"), asc("P"), asc("S"), asc("P"))

extern _AL_DLL os_type as long
extern _AL_DLL os_version as long
extern _AL_DLL os_revision as long
extern _AL_DLL os_multitasking as long

const SYSTEM_AUTODETECT = 0
#define SYSTEM_NONE_ AL_ID(asc("N"), asc("O"), asc("N"), asc("E"))
#define MAKE_VERSION(a, b, c) ((((a) shl 16) or ((b) shl 8)) or (c))
declare function _install_allegro_version_check(byval system_id as long, byval errno_ptr as long ptr, byval atexit_ptr as function(byval func as sub()) as long, byval version as long) as long
declare function install_allegro(byval system_id as long, byval errno_ptr as long ptr, byval atexit_ptr as function(byval func as sub()) as long) as long
#define allegro_init() _install_allegro_version_check(SYSTEM_AUTODETECT, @errno, cptr(function cdecl(byval as sub cdecl()) as long, @atexit), MAKE_VERSION(ALLEGRO_VERSION, ALLEGRO_SUB_VERSION, ALLEGRO_WIP_VERSION))

declare sub allegro_exit()
declare sub allegro_message(byval msg as const zstring ptr, ...)
declare sub get_executable_name(byval output as zstring ptr, byval size as long)
declare function set_close_button_callback(byval proc as sub()) as long
declare sub check_cpu()

const CPU_ID = &h0001
const CPU_FPU = &h0002
const CPU_MMX = &h0004
const CPU_MMXPLUS = &h0008
const CPU_SSE = &h0010
const CPU_SSE2 = &h0020
const CPU_3DNOW = &h0040
const CPU_ENH3DNOW = &h0080
const CPU_CMOV = &h0100
const CPU_AMD64 = &h0200
const CPU_IA64 = &h0400
const CPU_SSE3 = &h0800
const CPU_SSSE3 = &h1000
const CPU_SSE41 = &h2000
const CPU_SSE42 = &h4000
const CPU_FAMILY_UNKNOWN = 0
const CPU_FAMILY_I386 = 3
const CPU_FAMILY_I486 = 4
const CPU_FAMILY_I586 = 5
const CPU_FAMILY_I686 = 6
const CPU_FAMILY_ITANIUM = 7
const CPU_FAMILY_EXTENDED = 15
const CPU_FAMILY_POWERPC = 18
const CPU_MODEL_I486DX = 0
const CPU_MODEL_I486DX50 = 1
const CPU_MODEL_I486SX = 2
const CPU_MODEL_I487SX = 3
const CPU_MODEL_I486SL = 4
const CPU_MODEL_I486SX2 = 5
const CPU_MODEL_I486DX2 = 7
const CPU_MODEL_I486DX4 = 8
const CPU_MODEL_PENTIUM = 1
const CPU_MODEL_PENTIUMP54C = 2
const CPU_MODEL_PENTIUMOVERDRIVE = 3
const CPU_MODEL_PENTIUMOVERDRIVEDX4 = 4
const CPU_MODEL_CYRIX = 14
const CPU_MODEL_UNKNOWN = 15
const CPU_MODEL_K5 = 0
const CPU_MODEL_K6 = 6
const CPU_MODEL_PENTIUMPROA = 0
const CPU_MODEL_PENTIUMPRO = 1
const CPU_MODEL_PENTIUMIIKLAMATH = 3
const CPU_MODEL_PENTIUMII = 5
const CPU_MODEL_CELERON = 6
const CPU_MODEL_PENTIUMIIIKATMAI = 7
const CPU_MODEL_PENTIUMIIICOPPERMINE = 8
const CPU_MODEL_PENTIUMIIIMOBILE = 9
const CPU_MODEL_ATHLON = 2
const CPU_MODEL_DURON = 3
const CPU_MODEL_PENTIUMIV = 0
const CPU_MODEL_XEON = 2
const CPU_MODEL_ATHLON64 = 4
const CPU_MODEL_OPTERON = 5
const CPU_MODEL_POWERPC_601 = 1
const CPU_MODEL_POWERPC_602 = 2
const CPU_MODEL_POWERPC_603 = 3
const CPU_MODEL_POWERPC_603e = 4
const CPU_MODEL_POWERPC_603ev = 5
const CPU_MODEL_POWERPC_604 = 6
const CPU_MODEL_POWERPC_604e = 7
const CPU_MODEL_POWERPC_620 = 8
const CPU_MODEL_POWERPC_750 = 9
const CPU_MODEL_POWERPC_7400 = 10
const CPU_MODEL_POWERPC_7450 = 11
const _AL_CPU_VENDOR_SIZE = 32
extern _AL_DLL cpu_vendor as zstring * _AL_CPU_VENDOR_SIZE
extern _AL_DLL cpu_family as long
extern _AL_DLL cpu_model as long
extern _AL_DLL cpu_capabilities as long

type BITMAP as BITMAP_
type RGB as RGB_
type GFX_VTABLE as GFX_VTABLE_
type GFX_MODE as GFX_MODE_

type SYSTEM_DRIVER
	id as long
	name as const zstring ptr
	desc as const zstring ptr
	ascii_name as const zstring ptr
	init as function() as long
	exit as sub()
	get_executable_name as sub(byval output as zstring ptr, byval size as long)
	find_resource as function(byval dest as zstring ptr, byval resource as const zstring ptr, byval size as long) as long
	set_window_title as sub(byval name as const zstring ptr)
	set_close_button_callback as function(byval proc as sub()) as long
	message as sub(byval msg as const zstring ptr)
	assert as sub(byval msg as const zstring ptr)
	save_console_state as sub()
	restore_console_state as sub()
	create_bitmap as function(byval color_depth as long, byval width as long, byval height as long) as BITMAP ptr
	created_bitmap as sub(byval bmp as BITMAP ptr)
	create_sub_bitmap as function(byval parent as BITMAP ptr, byval x as long, byval y as long, byval width as long, byval height as long) as BITMAP ptr
	created_sub_bitmap as sub(byval bmp as BITMAP ptr, byval parent as BITMAP ptr)
	destroy_bitmap as function(byval bitmap as BITMAP ptr) as long
	read_hardware_palette as sub()
	set_palette_range as sub(byval p as const RGB ptr, byval from as long, byval to as long, byval retracesync as long)
	get_vtable as function(byval color_depth as long) as GFX_VTABLE ptr
	set_display_switch_mode as function(byval mode as long) as long
	display_switch_lock as sub(byval lock as long, byval foreground as long)
	desktop_color_depth as function() as long
	get_desktop_resolution as function(byval width as long ptr, byval height as long ptr) as long
	get_gfx_safe_mode as sub(byval driver as long ptr, byval mode as GFX_MODE ptr)
	yield_timeslice as sub()
	create_mutex as function() as any ptr
	destroy_mutex as sub(byval handle as any ptr)
	lock_mutex as sub(byval handle as any ptr)
	unlock_mutex as sub(byval handle as any ptr)
	gfx_drivers as function() as _DRIVER_INFO ptr
	digi_drivers as function() as _DRIVER_INFO ptr
	midi_drivers as function() as _DRIVER_INFO ptr
	keyboard_drivers as function() as _DRIVER_INFO ptr
	mouse_drivers as function() as _DRIVER_INFO ptr
	joystick_drivers as function() as _DRIVER_INFO ptr
	timer_drivers as function() as _DRIVER_INFO ptr
end type

extern _AL_DLL system_none as SYSTEM_DRIVER
extern _AL_DLL system_driver as SYSTEM_DRIVER ptr
#define _system_driver_list(i) ((@___system_driver_list)[i])
extern _AL_DLL ___system_driver_list alias "_system_driver_list" as _DRIVER_INFO

#define ALLEGRO_SYSTEM_INL
#define ALLEGRO_DEBUG_H
declare sub al_assert(byval file as const zstring ptr, byval linenr as long)
declare sub al_trace(byval msg as const zstring ptr, ...)
declare sub register_assert_handler(byval handler as function(byval msg as const zstring ptr) as long)
declare sub register_trace_handler(byval handler as function(byval msg as const zstring ptr) as long)
declare sub set_window_title(byval name as const zstring ptr)
declare function desktop_color_depth() as long
declare function get_desktop_resolution(byval width as long ptr, byval height as long ptr) as long

#define ALLEGRO_MOUSE_H
const MOUSEDRV_AUTODETECT = -1
const MOUSEDRV_NONE_ = 0

type MOUSE_DRIVER
	id as long
	name as const zstring ptr
	desc as const zstring ptr
	ascii_name as const zstring ptr
	init as function() as long
	exit as sub()
	poll as sub()
	timer_poll as sub()
	position as sub(byval x as long, byval y as long)
	set_range as sub(byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long)
	set_speed as sub(byval xspeed as long, byval yspeed as long)
	get_mickeys as sub(byval mickeyx as long ptr, byval mickeyy as long ptr)
	analyse_data as function(byval buffer as const zstring ptr, byval size as long) as long
	enable_hardware_cursor as sub(byval mode as long)
	select_system_cursor as function(byval cursor as long) as long
end type

extern _AL_DLL mousedrv_none as MOUSE_DRIVER
extern _AL_DLL mouse_driver as MOUSE_DRIVER ptr
#define _mouse_driver_list(i) ((@___mouse_driver_list)[i])
extern _AL_DLL ___mouse_driver_list alias "_mouse_driver_list" as _DRIVER_INFO

declare function install_mouse() as long
declare sub remove_mouse()
declare function poll_mouse() as long
declare function mouse_needs_poll() as long
declare sub enable_hardware_cursor()
declare sub disable_hardware_cursor()

const MOUSE_CURSOR_NONE = 0
const MOUSE_CURSOR_ALLEGRO = 1
const MOUSE_CURSOR_ARROW = 2
const MOUSE_CURSOR_BUSY = 3
const MOUSE_CURSOR_QUESTION = 4
const MOUSE_CURSOR_EDIT = 5
const AL_NUM_MOUSE_CURSORS = 6

extern _AL_DLL mouse_sprite as BITMAP ptr
extern _AL_DLL mouse_x_focus as long
extern _AL_DLL mouse_y_focus as long
extern _AL_DLL mouse_x as long
extern _AL_DLL mouse_y as long
extern _AL_DLL mouse_z as long
extern _AL_DLL mouse_w as long
extern _AL_DLL mouse_b as long
extern _AL_DLL mouse_pos as long
extern _AL_DLL freeze_mouse_flag as long

const MOUSE_FLAG_MOVE = 1
const MOUSE_FLAG_LEFT_DOWN = 2
const MOUSE_FLAG_LEFT_UP = 4
const MOUSE_FLAG_RIGHT_DOWN = 8
const MOUSE_FLAG_RIGHT_UP = 16
const MOUSE_FLAG_MIDDLE_DOWN = 32
const MOUSE_FLAG_MIDDLE_UP = 64
const MOUSE_FLAG_MOVE_Z = 128
const MOUSE_FLAG_MOVE_W = 256

extern _AL_DLL mouse_callback as sub(byval flags as long)

declare sub show_mouse(byval bmp as BITMAP ptr)
declare sub scare_mouse()
declare sub scare_mouse_area(byval x as long, byval y as long, byval w as long, byval h as long)
declare sub unscare_mouse()
declare sub position_mouse(byval x as long, byval y as long)
declare sub position_mouse_z(byval z as long)
declare sub position_mouse_w(byval w as long)
declare sub set_mouse_range(byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long)
declare sub set_mouse_speed(byval xspeed as long, byval yspeed as long)
declare sub select_mouse_cursor(byval cursor as long)
declare sub set_mouse_cursor_bitmap(byval cursor as long, byval bmp as BITMAP ptr)
declare sub set_mouse_sprite_focus(byval x as long, byval y as long)
declare sub get_mouse_mickeys(byval mickeyx as long ptr, byval mickeyy as long ptr)
declare sub set_mouse_sprite(byval sprite as BITMAP ptr)
declare function show_os_cursor(byval cursor as long) as long
declare function mouse_on_screen() as long

#define ALLEGRO_TIMER_H
const TIMERS_PER_SECOND = cast(clong, 1193181)
#define SECS_TO_TIMER(x) (cast(clong, (x)) * TIMERS_PER_SECOND)
#define MSEC_TO_TIMER(x) (cast(clong, (x)) * (TIMERS_PER_SECOND / 1000))
#define BPS_TO_TIMER(x) (TIMERS_PER_SECOND / cast(clong, (x)))
#define BPM_TO_TIMER(x) ((60 * TIMERS_PER_SECOND) / cast(clong, (x)))

type TIMER_DRIVER
	id as long
	name as const zstring ptr
	desc as const zstring ptr
	ascii_name as const zstring ptr
	init as function() as long
	exit as sub()
	install_int as function(byval proc as sub(), byval speed as clong) as long
	remove_int as sub(byval proc as sub())
	install_param_int as function(byval proc as sub(byval param as any ptr), byval param as any ptr, byval speed as clong) as long
	remove_param_int as sub(byval proc as sub(byval param as any ptr), byval param as any ptr)
	can_simulate_retrace as function() as long
	simulate_retrace as sub(byval enable as long)
	rest as sub(byval tyme as ulong, byval callback as sub())
end type

extern _AL_DLL timer_driver as TIMER_DRIVER ptr
#define _timer_driver_list(i) ((@___timer_driver_list)[i])
extern _AL_DLL ___timer_driver_list alias "_timer_driver_list" as _DRIVER_INFO

declare function install_timer() as long
declare sub remove_timer()
declare function install_int_ex(byval proc as sub(), byval speed as clong) as long
declare function install_int(byval proc as sub(), byval speed as clong) as long
declare sub remove_int(byval proc as sub())
declare function install_param_int_ex(byval proc as sub(byval param as any ptr), byval param as any ptr, byval speed as clong) as long
declare function install_param_int(byval proc as sub(byval param as any ptr), byval param as any ptr, byval speed as clong) as long
declare sub remove_param_int(byval proc as sub(byval param as any ptr), byval param as any ptr)

extern _AL_DLL retrace_count as long

declare sub rest(byval tyme as ulong)
declare sub rest_callback(byval tyme as ulong, byval callback as sub())
#define ALLEGRO_KEYBOARD_H

type KEYBOARD_DRIVER
	id as long
	name as const zstring ptr
	desc as const zstring ptr
	ascii_name as const zstring ptr
	autorepeat as long
	init as function() as long
	exit as sub()
	poll as sub()
	set_leds as sub(byval leds as long)
	set_rate as sub(byval delay as long, byval rate as long)
	wait_for_input as sub()
	stop_waiting_for_input as sub()
	scancode_to_ascii as function(byval scancode as long) as long
	scancode_to_name as function(byval scancode as long) as const zstring ptr
end type

extern _AL_DLL keyboard_driver as KEYBOARD_DRIVER ptr
#define _keyboard_driver_list(i) ((@___keyboard_driver_list)[i])
extern _AL_DLL ___keyboard_driver_list alias "_keyboard_driver_list" as _DRIVER_INFO

declare function install_keyboard() as long
declare sub remove_keyboard()
declare function poll_keyboard() as long
declare function keyboard_needs_poll() as long

extern _AL_DLL keyboard_callback as function(byval key as long) as long
extern _AL_DLL keyboard_ucallback as function(byval key as long, byval scancode as long ptr) as long
extern _AL_DLL keyboard_lowlevel_callback as sub(byval scancode as long)

declare sub install_keyboard_hooks(byval keypressed as function() as long, byval readkey as function() as long)
#define key(i) ((@__key)[i])
extern _AL_DLL __key alias "key" as byte
extern _AL_DLL key_shifts as long
extern _AL_DLL three_finger_flag as long
extern _AL_DLL key_led_flag as long

declare function keypressed() as long
declare function readkey() as long
declare function ureadkey(byval scancode as long ptr) as long
declare sub simulate_keypress(byval keycode as long)
declare sub simulate_ukeypress(byval keycode as long, byval scancode as long)
declare sub clear_keybuf()
declare sub set_leds(byval leds as long)
declare sub set_keyboard_rate(byval delay as long, byval repeat as long)
declare function scancode_to_ascii(byval scancode as long) as long
declare function scancode_to_name(byval scancode as long) as const zstring ptr

enum
	__allegro_KB_SHIFT_FLAG = &h0001
	__allegro_KB_CTRL_FLAG = &h0002
	__allegro_KB_ALT_FLAG = &h0004
	__allegro_KB_LWIN_FLAG = &h0008
	__allegro_KB_RWIN_FLAG = &h0010
	__allegro_KB_MENU_FLAG = &h0020
	__allegro_KB_COMMAND_FLAG = &h0040
	__allegro_KB_SCROLOCK_FLAG = &h0100
	__allegro_KB_NUMLOCK_FLAG = &h0200
	__allegro_KB_CAPSLOCK_FLAG = &h0400
	__allegro_KB_INALTSEQ_FLAG = &h0800
	__allegro_KB_ACCENT1_FLAG = &h1000
	__allegro_KB_ACCENT2_FLAG = &h2000
	__allegro_KB_ACCENT3_FLAG = &h4000
	__allegro_KB_ACCENT4_FLAG = &h8000
end enum

enum
	__allegro_KEY_A = 1
	__allegro_KEY_B = 2
	__allegro_KEY_C = 3
	__allegro_KEY_D = 4
	__allegro_KEY_E = 5
	__allegro_KEY_F = 6
	__allegro_KEY_G = 7
	__allegro_KEY_H = 8
	__allegro_KEY_I = 9
	__allegro_KEY_J = 10
	__allegro_KEY_K = 11
	__allegro_KEY_L = 12
	__allegro_KEY_M = 13
	__allegro_KEY_N = 14
	__allegro_KEY_O = 15
	__allegro_KEY_P = 16
	__allegro_KEY_Q = 17
	__allegro_KEY_R = 18
	__allegro_KEY_S = 19
	__allegro_KEY_T = 20
	__allegro_KEY_U = 21
	__allegro_KEY_V = 22
	__allegro_KEY_W = 23
	__allegro_KEY_X = 24
	__allegro_KEY_Y = 25
	__allegro_KEY_Z = 26
	__allegro_KEY_0 = 27
	__allegro_KEY_1 = 28
	__allegro_KEY_2 = 29
	__allegro_KEY_3 = 30
	__allegro_KEY_4 = 31
	__allegro_KEY_5 = 32
	__allegro_KEY_6 = 33
	__allegro_KEY_7 = 34
	__allegro_KEY_8 = 35
	__allegro_KEY_9 = 36
	__allegro_KEY_0_PAD = 37
	__allegro_KEY_1_PAD = 38
	__allegro_KEY_2_PAD = 39
	__allegro_KEY_3_PAD = 40
	__allegro_KEY_4_PAD = 41
	__allegro_KEY_5_PAD = 42
	__allegro_KEY_6_PAD = 43
	__allegro_KEY_7_PAD = 44
	__allegro_KEY_8_PAD = 45
	__allegro_KEY_9_PAD = 46
	__allegro_KEY_F1 = 47
	__allegro_KEY_F2 = 48
	__allegro_KEY_F3 = 49
	__allegro_KEY_F4 = 50
	__allegro_KEY_F5 = 51
	__allegro_KEY_F6 = 52
	__allegro_KEY_F7 = 53
	__allegro_KEY_F8 = 54
	__allegro_KEY_F9 = 55
	__allegro_KEY_F10 = 56
	__allegro_KEY_F11 = 57
	__allegro_KEY_F12 = 58
	__allegro_KEY_ESC = 59
	__allegro_KEY_TILDE = 60
	__allegro_KEY_MINUS = 61
	__allegro_KEY_EQUALS = 62
	__allegro_KEY_BACKSPACE = 63
	__allegro_KEY_TAB = 64
	__allegro_KEY_OPENBRACE = 65
	__allegro_KEY_CLOSEBRACE = 66
	__allegro_KEY_ENTER = 67
	__allegro_KEY_COLON = 68
	__allegro_KEY_QUOTE = 69
	__allegro_KEY_BACKSLASH = 70
	__allegro_KEY_BACKSLASH2 = 71
	__allegro_KEY_COMMA = 72
	__allegro_KEY_STOP = 73
	__allegro_KEY_SLASH = 74
	__allegro_KEY_SPACE = 75
	__allegro_KEY_INSERT = 76
	__allegro_KEY_DEL = 77
	__allegro_KEY_HOME = 78
	__allegro_KEY_END = 79
	__allegro_KEY_PGUP = 80
	__allegro_KEY_PGDN = 81
	__allegro_KEY_LEFT = 82
	__allegro_KEY_RIGHT = 83
	__allegro_KEY_UP = 84
	__allegro_KEY_DOWN = 85
	__allegro_KEY_SLASH_PAD = 86
	__allegro_KEY_ASTERISK = 87
	__allegro_KEY_MINUS_PAD = 88
	__allegro_KEY_PLUS_PAD = 89
	__allegro_KEY_DEL_PAD = 90
	__allegro_KEY_ENTER_PAD = 91
	__allegro_KEY_PRTSCR = 92
	__allegro_KEY_PAUSE = 93
	__allegro_KEY_ABNT_C1 = 94
	__allegro_KEY_YEN = 95
	__allegro_KEY_KANA = 96
	__allegro_KEY_CONVERT = 97
	__allegro_KEY_NOCONVERT = 98
	__allegro_KEY_AT = 99
	__allegro_KEY_CIRCUMFLEX = 100
	__allegro_KEY_COLON2 = 101
	__allegro_KEY_KANJI = 102
	__allegro_KEY_EQUALS_PAD = 103
	__allegro_KEY_BACKQUOTE = 104
	__allegro_KEY_SEMICOLON = 105
	__allegro_KEY_COMMAND = 106
	__allegro_KEY_UNKNOWN1 = 107
	__allegro_KEY_UNKNOWN2 = 108
	__allegro_KEY_UNKNOWN3 = 109
	__allegro_KEY_UNKNOWN4 = 110
	__allegro_KEY_UNKNOWN5 = 111
	__allegro_KEY_UNKNOWN6 = 112
	__allegro_KEY_UNKNOWN7 = 113
	__allegro_KEY_UNKNOWN8 = 114
	__allegro_KEY_MODIFIERS = 115
	__allegro_KEY_LSHIFT = 115
	__allegro_KEY_RSHIFT = 116
	__allegro_KEY_LCONTROL = 117
	__allegro_KEY_RCONTROL = 118
	__allegro_KEY_ALT = 119
	__allegro_KEY_ALTGR = 120
	__allegro_KEY_LWIN = 121
	__allegro_KEY_RWIN = 122
	__allegro_KEY_MENU = 123
	__allegro_KEY_SCRLOCK = 124
	__allegro_KEY_NUMLOCK = 125
	__allegro_KEY_CAPSLOCK = 126
	__allegro_KEY_MAX = 127
end enum

const KB_SHIFT_FLAG = __allegro_KB_SHIFT_FLAG
const KB_CTRL_FLAG = __allegro_KB_CTRL_FLAG
const KB_ALT_FLAG = __allegro_KB_ALT_FLAG
const KB_LWIN_FLAG = __allegro_KB_LWIN_FLAG
const KB_RWIN_FLAG = __allegro_KB_RWIN_FLAG
const KB_MENU_FLAG = __allegro_KB_MENU_FLAG
const KB_COMMAND_FLAG = __allegro_KB_COMMAND_FLAG
const KB_SCROLOCK_FLAG = __allegro_KB_SCROLOCK_FLAG
const KB_NUMLOCK_FLAG = __allegro_KB_NUMLOCK_FLAG
const KB_CAPSLOCK_FLAG = __allegro_KB_CAPSLOCK_FLAG
const KB_INALTSEQ_FLAG = __allegro_KB_INALTSEQ_FLAG
const KB_ACCENT1_FLAG = __allegro_KB_ACCENT1_FLAG
const KB_ACCENT2_FLAG = __allegro_KB_ACCENT2_FLAG
const KB_ACCENT3_FLAG = __allegro_KB_ACCENT3_FLAG
const KB_ACCENT4_FLAG = __allegro_KB_ACCENT4_FLAG
const KEY_A = __allegro_KEY_A
const KEY_B = __allegro_KEY_B
const KEY_C = __allegro_KEY_C
const KEY_D = __allegro_KEY_D
const KEY_E = __allegro_KEY_E
const KEY_F = __allegro_KEY_F
const KEY_G = __allegro_KEY_G
const KEY_H = __allegro_KEY_H
const KEY_I = __allegro_KEY_I
const KEY_J = __allegro_KEY_J
const KEY_K = __allegro_KEY_K
const KEY_L = __allegro_KEY_L
const KEY_M = __allegro_KEY_M
const KEY_N = __allegro_KEY_N
const KEY_O = __allegro_KEY_O
const KEY_P = __allegro_KEY_P
const KEY_Q = __allegro_KEY_Q
const KEY_R = __allegro_KEY_R
const KEY_S = __allegro_KEY_S
const KEY_T = __allegro_KEY_T
const KEY_U = __allegro_KEY_U
const KEY_V = __allegro_KEY_V
const KEY_W = __allegro_KEY_W
const KEY_X = __allegro_KEY_X
const KEY_Y = __allegro_KEY_Y
const KEY_Z = __allegro_KEY_Z
const KEY_0 = __allegro_KEY_0
const KEY_1 = __allegro_KEY_1
const KEY_2 = __allegro_KEY_2
const KEY_3 = __allegro_KEY_3
const KEY_4 = __allegro_KEY_4
const KEY_5 = __allegro_KEY_5
const KEY_6 = __allegro_KEY_6
const KEY_7 = __allegro_KEY_7
const KEY_8 = __allegro_KEY_8
const KEY_9 = __allegro_KEY_9
const KEY_0_PAD = __allegro_KEY_0_PAD
const KEY_1_PAD = __allegro_KEY_1_PAD
const KEY_2_PAD = __allegro_KEY_2_PAD
const KEY_3_PAD = __allegro_KEY_3_PAD
const KEY_4_PAD = __allegro_KEY_4_PAD
const KEY_5_PAD = __allegro_KEY_5_PAD
const KEY_6_PAD = __allegro_KEY_6_PAD
const KEY_7_PAD = __allegro_KEY_7_PAD
const KEY_8_PAD = __allegro_KEY_8_PAD
const KEY_9_PAD = __allegro_KEY_9_PAD
const KEY_F1 = __allegro_KEY_F1
const KEY_F2 = __allegro_KEY_F2
const KEY_F3 = __allegro_KEY_F3
const KEY_F4 = __allegro_KEY_F4
const KEY_F5 = __allegro_KEY_F5
const KEY_F6 = __allegro_KEY_F6
const KEY_F7 = __allegro_KEY_F7
const KEY_F8 = __allegro_KEY_F8
const KEY_F9 = __allegro_KEY_F9
const KEY_F10 = __allegro_KEY_F10
const KEY_F11 = __allegro_KEY_F11
const KEY_F12 = __allegro_KEY_F12
const KEY_ESC = __allegro_KEY_ESC
const KEY_TILDE = __allegro_KEY_TILDE
const KEY_MINUS = __allegro_KEY_MINUS
const KEY_EQUALS = __allegro_KEY_EQUALS
const KEY_BACKSPACE = __allegro_KEY_BACKSPACE
const KEY_TAB = __allegro_KEY_TAB
const KEY_OPENBRACE = __allegro_KEY_OPENBRACE
const KEY_CLOSEBRACE = __allegro_KEY_CLOSEBRACE
const KEY_ENTER = __allegro_KEY_ENTER
const KEY_COLON = __allegro_KEY_COLON
const KEY_QUOTE = __allegro_KEY_QUOTE
const KEY_BACKSLASH = __allegro_KEY_BACKSLASH
const KEY_BACKSLASH2 = __allegro_KEY_BACKSLASH2
const KEY_COMMA = __allegro_KEY_COMMA
const KEY_STOP = __allegro_KEY_STOP
const KEY_SLASH = __allegro_KEY_SLASH
const KEY_SPACE = __allegro_KEY_SPACE
const KEY_INSERT = __allegro_KEY_INSERT
const KEY_DEL = __allegro_KEY_DEL
const KEY_HOME = __allegro_KEY_HOME
const KEY_END = __allegro_KEY_END
const KEY_PGUP = __allegro_KEY_PGUP
const KEY_PGDN = __allegro_KEY_PGDN
const KEY_LEFT = __allegro_KEY_LEFT
const KEY_RIGHT = __allegro_KEY_RIGHT
const KEY_UP = __allegro_KEY_UP
const KEY_DOWN = __allegro_KEY_DOWN
const KEY_SLASH_PAD = __allegro_KEY_SLASH_PAD
const KEY_ASTERISK = __allegro_KEY_ASTERISK
const KEY_MINUS_PAD = __allegro_KEY_MINUS_PAD
const KEY_PLUS_PAD = __allegro_KEY_PLUS_PAD
const KEY_DEL_PAD = __allegro_KEY_DEL_PAD
const KEY_ENTER_PAD = __allegro_KEY_ENTER_PAD
const KEY_PRTSCR = __allegro_KEY_PRTSCR
const KEY_PAUSE = __allegro_KEY_PAUSE
const KEY_ABNT_C1 = __allegro_KEY_ABNT_C1
const KEY_YEN = __allegro_KEY_YEN
const KEY_KANA = __allegro_KEY_KANA
const KEY_CONVERT = __allegro_KEY_CONVERT
const KEY_NOCONVERT = __allegro_KEY_NOCONVERT
const KEY_AT = __allegro_KEY_AT
const KEY_CIRCUMFLEX = __allegro_KEY_CIRCUMFLEX
const KEY_COLON2 = __allegro_KEY_COLON2
const KEY_KANJI = __allegro_KEY_KANJI
const KEY_EQUALS_PAD = __allegro_KEY_EQUALS_PAD
const KEY_BACKQUOTE = __allegro_KEY_BACKQUOTE
const KEY_SEMICOLON = __allegro_KEY_SEMICOLON
const KEY_COMMAND = __allegro_KEY_COMMAND
const KEY_UNKNOWN1 = __allegro_KEY_UNKNOWN1
const KEY_UNKNOWN2 = __allegro_KEY_UNKNOWN2
const KEY_UNKNOWN3 = __allegro_KEY_UNKNOWN3
const KEY_UNKNOWN4 = __allegro_KEY_UNKNOWN4
const KEY_UNKNOWN5 = __allegro_KEY_UNKNOWN5
const KEY_UNKNOWN6 = __allegro_KEY_UNKNOWN6
const KEY_UNKNOWN7 = __allegro_KEY_UNKNOWN7
const KEY_UNKNOWN8 = __allegro_KEY_UNKNOWN8
const KEY_MODIFIERS = __allegro_KEY_MODIFIERS
const KEY_LSHIFT = __allegro_KEY_LSHIFT
const KEY_RSHIFT = __allegro_KEY_RSHIFT
const KEY_LCONTROL = __allegro_KEY_LCONTROL
const KEY_RCONTROL = __allegro_KEY_RCONTROL
const KEY_ALT = __allegro_KEY_ALT
const KEY_ALTGR = __allegro_KEY_ALTGR
const KEY_LWIN = __allegro_KEY_LWIN
const KEY_RWIN = __allegro_KEY_RWIN
const KEY_MENU = __allegro_KEY_MENU
const KEY_SCRLOCK = __allegro_KEY_SCRLOCK
const KEY_NUMLOCK = __allegro_KEY_NUMLOCK
const KEY_CAPSLOCK = __allegro_KEY_CAPSLOCK
const KEY_MAX = __allegro_KEY_MAX
#define ALLEGRO_JOYSTICK_H
const JOY_TYPE_AUTODETECT = -1
const JOY_TYPE_NONE = 0
const MAX_JOYSTICKS = 8
const MAX_JOYSTICK_AXIS = 3
const MAX_JOYSTICK_STICKS = 5
const MAX_JOYSTICK_BUTTONS = 32

type JOYSTICK_AXIS_INFO
	pos as long
	d1 as long
	d2 as long
	name as const zstring ptr
end type

type JOYSTICK_STICK_INFO
	flags as long
	num_axis as long
	axis(0 to 2) as JOYSTICK_AXIS_INFO
	name as const zstring ptr
end type

type JOYSTICK_BUTTON_INFO
	b as long
	name as const zstring ptr
end type

type JOYSTICK_INFO
	flags as long
	num_sticks as long
	num_buttons as long
	stick(0 to 4) as JOYSTICK_STICK_INFO
	button(0 to 31) as JOYSTICK_BUTTON_INFO
end type

const JOYFLAG_DIGITAL = 1
const JOYFLAG_ANALOGUE = 2
const JOYFLAG_CALIB_DIGITAL = 4
const JOYFLAG_CALIB_ANALOGUE = 8
const JOYFLAG_CALIBRATE = 16
const JOYFLAG_SIGNED = 32
const JOYFLAG_UNSIGNED = 64
const JOYFLAG_ANALOG = JOYFLAG_ANALOGUE
const JOYFLAG_CALIB_ANALOG = JOYFLAG_CALIB_ANALOGUE

#define joy(i) ((@__joy)[i])
extern _AL_DLL __joy alias "joy" as JOYSTICK_INFO
extern _AL_DLL num_joysticks as long

type JOYSTICK_DRIVER
	id as long
	name as const zstring ptr
	desc as const zstring ptr
	ascii_name as const zstring ptr
	init as function() as long
	exit as sub()
	poll as function() as long
	save_data as function() as long
	load_data as function() as long
	calibrate_name as function(byval n as long) as const zstring ptr
	calibrate as function(byval n as long) as long
end type

extern _AL_DLL joystick_none as JOYSTICK_DRIVER
extern _AL_DLL joystick_driver as JOYSTICK_DRIVER ptr
#define _joystick_driver_list(i) ((@___joystick_driver_list)[i])
extern _AL_DLL ___joystick_driver_list alias "_joystick_driver_list" as _DRIVER_INFO
#define BEGIN_JOYSTICK_DRIVER_LIST dim as _DRIVER_INFO _joystick_driver_list(0 to ...) = {
#define END_JOYSTICK_DRIVER_LIST ( JOY_TYPE_NONE, @joystick_none, TRUE ), ( 0, NULL, 0 ) }
declare function install_joystick(byval type as long) as long
declare sub remove_joystick()
declare function poll_joystick() as long
declare function save_joystick_data(byval filename as const zstring ptr) as long
declare function load_joystick_data(byval filename as const zstring ptr) as long
declare function calibrate_joystick_name(byval n as long) as const zstring ptr
declare function calibrate_joystick(byval n as long) as long
#define ALLEGRO_PALETTE_H

type RGB_
	r as ubyte
	g as ubyte
	b as ubyte
	filler as ubyte
end type

const PAL_SIZE = 256
#define ALLEGRO_GFX_H
#define ALLEGRO_3D_H
#define ALLEGRO_FIXED_H
type fixed as long

extern _AL_DLL fixtorad_r as const fixed
extern _AL_DLL radtofix_r as const fixed

type V3D
	x as fixed
	y as fixed
	z as fixed
	u as fixed
	v as fixed
	c as long
end type

type V3D_f
	x as single
	y as single
	z as single
	u as single
	v as single
	c as long
end type

const POLYTYPE_FLAT = 0
const POLYTYPE_GCOL = 1
const POLYTYPE_GRGB = 2
const POLYTYPE_ATEX = 3
const POLYTYPE_PTEX = 4
const POLYTYPE_ATEX_MASK = 5
const POLYTYPE_PTEX_MASK = 6
const POLYTYPE_ATEX_LIT = 7
const POLYTYPE_PTEX_LIT = 8
const POLYTYPE_ATEX_MASK_LIT = 9
const POLYTYPE_PTEX_MASK_LIT = 10
const POLYTYPE_ATEX_TRANS = 11
const POLYTYPE_PTEX_TRANS = 12
const POLYTYPE_ATEX_MASK_TRANS = 13
const POLYTYPE_PTEX_MASK_TRANS = 14
const POLYTYPE_MAX = 15
const POLYTYPE_ZBUF = 16

extern _AL_DLL scene_gap as single

declare sub _soft_polygon3d(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval vc as long, byval vtx as V3D ptr ptr)
declare sub _soft_polygon3d_f(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval vc as long, byval vtx as V3D_f ptr ptr)
declare sub _soft_triangle3d(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D ptr, byval v2 as V3D ptr, byval v3 as V3D ptr)
declare sub _soft_triangle3d_f(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D_f ptr, byval v2 as V3D_f ptr, byval v3 as V3D_f ptr)
declare sub _soft_quad3d(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D ptr, byval v2 as V3D ptr, byval v3 as V3D ptr, byval v4 as V3D ptr)
declare sub _soft_quad3d_f(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D_f ptr, byval v2 as V3D_f ptr, byval v3 as V3D_f ptr, byval v4 as V3D_f ptr)
declare function clip3d(byval type as long, byval min_z as fixed, byval max_z as fixed, byval vc as long, byval vtx as const V3D ptr ptr, byval vout as V3D ptr ptr, byval vtmp as V3D ptr ptr, byval out as long ptr) as long
declare function clip3d_f(byval type as long, byval min_z as single, byval max_z as single, byval vc as long, byval vtx as const V3D_f ptr ptr, byval vout as V3D_f ptr ptr, byval vtmp as V3D_f ptr ptr, byval out as long ptr) as long
declare function polygon_z_normal(byval v1 as const V3D ptr, byval v2 as const V3D ptr, byval v3 as const V3D ptr) as fixed
declare function polygon_z_normal_f(byval v1 as const V3D_f ptr, byval v2 as const V3D_f ptr, byval v3 as const V3D_f ptr) as single
type ZBUFFER as BITMAP
declare function create_zbuffer(byval bmp as BITMAP ptr) as ZBUFFER ptr
declare function create_sub_zbuffer(byval parent as ZBUFFER ptr, byval x as long, byval y as long, byval width as long, byval height as long) as ZBUFFER ptr
declare sub set_zbuffer(byval zbuf as ZBUFFER ptr)
declare sub clear_zbuffer(byval zbuf as ZBUFFER ptr, byval z as single)
declare sub destroy_zbuffer(byval zbuf as ZBUFFER ptr)
declare function create_scene(byval nedge as long, byval npoly as long) as long
declare sub clear_scene(byval bmp as BITMAP ptr)
declare sub destroy_scene()
declare function scene_polygon3d(byval type as long, byval texture as BITMAP ptr, byval vx as long, byval vtx as V3D ptr ptr) as long
declare function scene_polygon3d_f(byval type as long, byval texture as BITMAP ptr, byval vx as long, byval vtx as V3D_f ptr ptr) as long
declare sub render_scene()

const GFX_TEXT = -1
const GFX_AUTODETECT = 0
const GFX_AUTODETECT_FULLSCREEN = 1
const GFX_AUTODETECT_WINDOWED = 2
#define GFX_SAFE AL_ID(asc("S"), asc("A"), asc("F"), asc("E"))
#define GFX_NONE AL_ID(asc("N"), asc("O"), asc("N"), asc("E"))
const DRAW_SPRITE_NORMAL = 0
const DRAW_SPRITE_LIT = 1
const DRAW_SPRITE_TRANS = 2
const DRAW_SPRITE_NO_FLIP = &h0
const DRAW_SPRITE_H_FLIP_ = &h1
const DRAW_SPRITE_V_FLIP_ = &h2
const DRAW_SPRITE_VH_FLIP_ = &h3
const blender_mode_none = 0
const blender_mode_trans = 1
const blender_mode_add = 2
const blender_mode_burn = 3
const blender_mode_color = 4
const blender_mode_difference = 5
const blender_mode_dissolve = 6
const blender_mode_dodge = 7
const blender_mode_hue = 8
const blender_mode_invert = 9
const blender_mode_luminance = 10
const blender_mode_multiply = 11
const blender_mode_saturation = 12
const blender_mode_screen = 13
const blender_mode_alpha = 14

type GFX_MODE_
	width as long
	height as long
	bpp as long
end type

type GFX_MODE_LIST
	num_modes as long
	mode as GFX_MODE ptr
end type

type GFX_DRIVER
	id as long
	name as const zstring ptr
	desc as const zstring ptr
	ascii_name as const zstring ptr
	init as function(byval w as long, byval h as long, byval v_w as long, byval v_h as long, byval color_depth as long) as BITMAP ptr
	exit as sub(byval b as BITMAP ptr)
	scroll as function(byval x as long, byval y as long) as long
	vsync as sub()
	set_palette as sub(byval p as const RGB ptr, byval from as long, byval to as long, byval retracesync as long)
	request_scroll as function(byval x as long, byval y as long) as long
	poll_scroll as function() as long
	enable_triple_buffer as sub()
	create_video_bitmap as function(byval width as long, byval height as long) as BITMAP ptr
	destroy_video_bitmap as sub(byval bitmap as BITMAP ptr)
	show_video_bitmap as function(byval bitmap as BITMAP ptr) as long
	request_video_bitmap as function(byval bitmap as BITMAP ptr) as long
	create_system_bitmap as function(byval width as long, byval height as long) as BITMAP ptr
	destroy_system_bitmap as sub(byval bitmap as BITMAP ptr)
	set_mouse_sprite as function(byval sprite as BITMAP ptr, byval xfocus as long, byval yfocus as long) as long
	show_mouse as function(byval bmp as BITMAP ptr, byval x as long, byval y as long) as long
	hide_mouse as sub()
	move_mouse as sub(byval x as long, byval y as long)
	drawing_mode as sub()
	save_video_state as sub()
	restore_video_state as sub()
	set_blender_mode as sub(byval mode as long, byval r as long, byval g as long, byval b as long, byval a as long)
	fetch_mode_list as function() as GFX_MODE_LIST ptr
	w as long
	h as long
	linear as long
	bank_size as clong
	bank_gran as clong
	vid_mem as clong
	vid_phys_base as clong
	windowed as long
end type

extern _AL_DLL gfx_driver as GFX_DRIVER ptr
#define _gfx_driver_list(i) ((@___gfx_driver_list)[i])
extern _AL_DLL ___gfx_driver_list alias "_gfx_driver_list" as _DRIVER_INFO
#define BEGIN_GFX_DRIVER_LIST dim as _DRIVER_INFO _gfx_driver_list(0 to ...) = {
#define END_GFX_DRIVER_LIST ( 0, NULL, 0 ) }
const GFX_CAN_SCROLL = &h00000001
const GFX_CAN_TRIPLE_BUFFER = &h00000002
const GFX_HW_CURSOR = &h00000004
const GFX_HW_HLINE = &h00000008
const GFX_HW_HLINE_XOR = &h00000010
const GFX_HW_HLINE_SOLID_PATTERN = &h00000020
const GFX_HW_HLINE_COPY_PATTERN = &h00000040
const GFX_HW_FILL = &h00000080
const GFX_HW_FILL_XOR = &h00000100
const GFX_HW_FILL_SOLID_PATTERN = &h00000200
const GFX_HW_FILL_COPY_PATTERN = &h00000400
const GFX_HW_LINE = &h00000800
const GFX_HW_LINE_XOR = &h00001000
const GFX_HW_TRIANGLE = &h00002000
const GFX_HW_TRIANGLE_XOR = &h00004000
const GFX_HW_GLYPH = &h00008000
const GFX_HW_VRAM_BLIT = &h00010000
const GFX_HW_VRAM_BLIT_MASKED = &h00020000
const GFX_HW_MEM_BLIT = &h00040000
const GFX_HW_MEM_BLIT_MASKED = &h00080000
const GFX_HW_SYS_TO_VRAM_BLIT = &h00100000
const GFX_HW_SYS_TO_VRAM_BLIT_MASKED = &h00200000
const GFX_SYSTEM_CURSOR = &h00400000
const GFX_HW_VRAM_STRETCH_BLIT = &h00800000
const GFX_HW_VRAM_STRETCH_BLIT_MASKED = &h01000000
const GFX_HW_SYS_STRETCH_BLIT = &h02000000
const GFX_HW_SYS_STRETCH_BLIT_MASKED = &h04000000

extern _AL_DLL gfx_capabilities as long

type RLE_SPRITE as RLE_SPRITE_
type FONT_GLYPH as FONT_GLYPH_

type GFX_VTABLE_
	color_depth as long
	mask_color as long
	unwrite_bank as any ptr
	set_clip as sub(byval bmp as BITMAP ptr)
	acquire as sub(byval bmp as BITMAP ptr)
	release as sub(byval bmp as BITMAP ptr)
	create_sub_bitmap as function(byval parent as BITMAP ptr, byval x as long, byval y as long, byval width as long, byval height as long) as BITMAP ptr
	created_sub_bitmap as sub(byval bmp as BITMAP ptr, byval parent as BITMAP ptr)
	getpixel as function(byval bmp as BITMAP ptr, byval x as long, byval y as long) as long
	putpixel as sub(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval color as long)
	vline as sub(byval bmp as BITMAP ptr, byval x as long, byval y_1 as long, byval y2 as long, byval color as long)
	hline as sub(byval bmp as BITMAP ptr, byval x1 as long, byval y as long, byval x2 as long, byval color as long)
	hfill as sub(byval bmp as BITMAP ptr, byval x1 as long, byval y as long, byval x2 as long, byval color as long)
	line as sub(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval color as long)
	fastline as sub(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval color as long)
	rectfill as sub(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval color as long)
	triangle as sub(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval x3 as long, byval y3 as long, byval color as long)
	draw_sprite as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
	draw_256_sprite as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
	draw_sprite_v_flip as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
	draw_sprite_h_flip as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
	draw_sprite_vh_flip as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
	draw_trans_sprite as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
	draw_trans_rgba_sprite as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
	draw_lit_sprite as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval color as long)
	draw_rle_sprite as sub(byval bmp as BITMAP ptr, byval sprite as const RLE_SPRITE ptr, byval x as long, byval y as long)
	draw_trans_rle_sprite as sub(byval bmp as BITMAP ptr, byval sprite as const RLE_SPRITE ptr, byval x as long, byval y as long)
	draw_trans_rgba_rle_sprite as sub(byval bmp as BITMAP ptr, byval sprite as const RLE_SPRITE ptr, byval x as long, byval y as long)
	draw_lit_rle_sprite as sub(byval bmp as BITMAP ptr, byval sprite as const RLE_SPRITE ptr, byval x as long, byval y as long, byval color as long)
	draw_character as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval color as long, byval bg as long)
	draw_glyph as sub(byval bmp as BITMAP ptr, byval glyph as const FONT_GLYPH ptr, byval x as long, byval y as long, byval color as long, byval bg as long)
	blit_from_memory as sub(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long)
	blit_to_memory as sub(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long)
	blit_from_system as sub(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long)
	blit_to_system as sub(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long)
	blit_to_self as sub(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long)
	blit_to_self_forward as sub(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long)
	blit_to_self_backward as sub(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long)
	blit_between_formats as sub(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long)
	masked_blit as sub(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long)
	clear_to_color as sub(byval bitmap as BITMAP ptr, byval color as long)
	pivot_scaled_sprite_flip as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as fixed, byval y as fixed, byval cx as fixed, byval cy as fixed, byval angle as fixed, byval scale as fixed, byval v_flip as long)
	do_stretch_blit as sub(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval source_width as long, byval source_height as long, byval dest_x as long, byval dest_y as long, byval dest_width as long, byval dest_height as long, byval masked as long)
	draw_gouraud_sprite as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval c1 as long, byval c2 as long, byval c3 as long, byval c4 as long)
	draw_sprite_end as sub()
	blit_end as sub()
	polygon as sub(byval bmp as BITMAP ptr, byval vertices as long, byval points as const long ptr, byval color as long)
	rect as sub(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval color as long)
	circle as sub(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval radius as long, byval color as long)
	circlefill as sub(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval radius as long, byval color as long)
	ellipse as sub(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval rx as long, byval ry as long, byval color as long)
	ellipsefill as sub(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval rx as long, byval ry as long, byval color as long)
	arc as sub(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval ang1 as fixed, byval ang2 as fixed, byval r as long, byval color as long)
	spline as sub(byval bmp as BITMAP ptr, byval points as const long ptr, byval color as long)
	floodfill as sub(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval color as long)
	polygon3d as sub(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval vc as long, byval vtx as V3D ptr ptr)
	polygon3d_f as sub(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval vc as long, byval vtx as V3D_f ptr ptr)
	triangle3d as sub(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D ptr, byval v2 as V3D ptr, byval v3 as V3D ptr)
	triangle3d_f as sub(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D_f ptr, byval v2 as V3D_f ptr, byval v3 as V3D_f ptr)
	quad3d as sub(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D ptr, byval v2 as V3D ptr, byval v3 as V3D ptr, byval v4 as V3D ptr)
	quad3d_f as sub(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D_f ptr, byval v2 as V3D_f ptr, byval v3 as V3D_f ptr, byval v4 as V3D_f ptr)
	draw_sprite_ex as sub(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval mode as long, byval flip as long)
end type

extern _AL_DLL __linear_vtable8 as GFX_VTABLE
extern _AL_DLL __linear_vtable15 as GFX_VTABLE
extern _AL_DLL __linear_vtable16 as GFX_VTABLE
extern _AL_DLL __linear_vtable24 as GFX_VTABLE
extern _AL_DLL __linear_vtable32 as GFX_VTABLE

type _VTABLE_INFO
	color_depth as long
	vtable as GFX_VTABLE ptr
end type

#define _vtable_list(i) ((@___vtable_list)[i])
extern _AL_DLL ___vtable_list alias "_vtable_list" as _VTABLE_INFO
#define BEGIN_COLOR_DEPTH_LIST dim as _VTABLE_INFO _vtable_list(0 to ...) = {
#define END_COLOR_DEPTH_LIST ( 0, NULL ) }
#define COLOR_DEPTH_8 ( 8, @__linear_vtable8 ),
#define COLOR_DEPTH_15 ( 15, @__linear_vtable15 ),
#define COLOR_DEPTH_16 ( 16, @__linear_vtable16 ),
#define COLOR_DEPTH_24 ( 24, @__linear_vtable24 ),
#define COLOR_DEPTH_32 ( 32, @__linear_vtable32 ),

type BITMAP_
	w as long
	h as long
	clip as long
	cl as long
	cr as long
	ct as long
	cb as long
	vtable as GFX_VTABLE ptr
	write_bank as any ptr
	read_bank as any ptr
	dat as any ptr
	id as culong
	extra as any ptr
	x_ofs as long
	y_ofs as long
	seg as long
	line(0 to 1 - 1) as ubyte ptr
end type

const BMP_ID_VIDEO = &h80000000
const BMP_ID_SYSTEM = &h40000000
const BMP_ID_SUB = &h20000000
const BMP_ID_PLANAR = &h10000000
const BMP_ID_NOBLIT = &h08000000
const BMP_ID_LOCKED = &h04000000
const BMP_ID_AUTOLOCK = &h02000000
const BMP_ID_MASK = &h01FFFFFF

extern _AL_DLL screen as BITMAP ptr

#define SCREEN_W iif(gfx_driver, gfx_driver->w, 0)
#define SCREEN_H iif(gfx_driver, gfx_driver->h, 0)
#define VIRTUAL_W iif(screen, screen->w, 0)
#define VIRTUAL_H iif(screen, screen->h, 0)
const COLORCONV_NONE = 0
const COLORCONV_8_TO_15 = 1
const COLORCONV_8_TO_16 = 2
const COLORCONV_8_TO_24 = 4
const COLORCONV_8_TO_32 = 8
const COLORCONV_15_TO_8 = &h10
const COLORCONV_15_TO_16 = &h20
const COLORCONV_15_TO_24 = &h40
const COLORCONV_15_TO_32 = &h80
const COLORCONV_16_TO_8 = &h100
const COLORCONV_16_TO_15 = &h200
const COLORCONV_16_TO_24 = &h400
const COLORCONV_16_TO_32 = &h800
const COLORCONV_24_TO_8 = &h1000
const COLORCONV_24_TO_15 = &h2000
const COLORCONV_24_TO_16 = &h4000
const COLORCONV_24_TO_32 = &h8000
const COLORCONV_32_TO_8 = &h10000
const COLORCONV_32_TO_15 = &h20000
const COLORCONV_32_TO_16 = &h40000
const COLORCONV_32_TO_24 = &h80000
const COLORCONV_32A_TO_8 = &h100000
const COLORCONV_32A_TO_15 = &h200000
const COLORCONV_32A_TO_16 = &h400000
const COLORCONV_32A_TO_24 = &h800000
const COLORCONV_DITHER_PAL = &h1000000
const COLORCONV_DITHER_HI = &h2000000
const COLORCONV_KEEP_TRANS = &h4000000
const COLORCONV_DITHER = COLORCONV_DITHER_PAL or COLORCONV_DITHER_HI
const COLORCONV_EXPAND_256 = ((COLORCONV_8_TO_15 or COLORCONV_8_TO_16) or COLORCONV_8_TO_24) or COLORCONV_8_TO_32
const COLORCONV_REDUCE_TO_256 = (((COLORCONV_15_TO_8 or COLORCONV_16_TO_8) or COLORCONV_24_TO_8) or COLORCONV_32_TO_8) or COLORCONV_32A_TO_8
const COLORCONV_EXPAND_15_TO_16 = COLORCONV_15_TO_16
const COLORCONV_REDUCE_16_TO_15 = COLORCONV_16_TO_15
const COLORCONV_EXPAND_HI_TO_TRUE = ((COLORCONV_15_TO_24 or COLORCONV_15_TO_32) or COLORCONV_16_TO_24) or COLORCONV_16_TO_32
const COLORCONV_REDUCE_TRUE_TO_HI = ((COLORCONV_24_TO_15 or COLORCONV_24_TO_16) or COLORCONV_32_TO_15) or COLORCONV_32_TO_16
const COLORCONV_24_EQUALS_32 = COLORCONV_24_TO_32 or COLORCONV_32_TO_24
const COLORCONV_TOTAL = ((((((((COLORCONV_EXPAND_256 or COLORCONV_REDUCE_TO_256) or COLORCONV_EXPAND_15_TO_16) or COLORCONV_REDUCE_16_TO_15) or COLORCONV_EXPAND_HI_TO_TRUE) or COLORCONV_REDUCE_TRUE_TO_HI) or COLORCONV_24_EQUALS_32) or COLORCONV_32A_TO_15) or COLORCONV_32A_TO_16) or COLORCONV_32A_TO_24
const COLORCONV_PARTIAL = (COLORCONV_EXPAND_15_TO_16 or COLORCONV_REDUCE_16_TO_15) or COLORCONV_24_EQUALS_32
const COLORCONV_MOST = (((COLORCONV_EXPAND_15_TO_16 or COLORCONV_REDUCE_16_TO_15) or COLORCONV_EXPAND_HI_TO_TRUE) or COLORCONV_REDUCE_TRUE_TO_HI) or COLORCONV_24_EQUALS_32
const COLORCONV_KEEP_ALPHA = COLORCONV_TOTAL and (not (((COLORCONV_32A_TO_8 or COLORCONV_32A_TO_15) or COLORCONV_32A_TO_16) or COLORCONV_32A_TO_24))

declare function get_gfx_mode_list(byval card as long) as GFX_MODE_LIST ptr
declare sub destroy_gfx_mode_list(byval gfx_mode_list as GFX_MODE_LIST ptr)
declare sub set_color_depth(byval depth as long)
declare function get_color_depth() as long
declare sub set_color_conversion(byval mode as long)
declare function get_color_conversion() as long
declare sub request_refresh_rate(byval rate as long)
declare function get_refresh_rate() as long
declare function set_gfx_mode(byval card as long, byval w as long, byval h as long, byval v_w as long, byval v_h as long) as long
declare function scroll_screen(byval x as long, byval y as long) as long
declare function request_scroll(byval x as long, byval y as long) as long
declare function poll_scroll() as long
declare function show_video_bitmap(byval bitmap as BITMAP ptr) as long
declare function request_video_bitmap(byval bitmap as BITMAP ptr) as long
declare function enable_triple_buffer() as long
declare function create_bitmap(byval width as long, byval height as long) as BITMAP ptr
declare function create_bitmap_ex(byval color_depth as long, byval width as long, byval height as long) as BITMAP ptr
declare function create_sub_bitmap(byval parent as BITMAP ptr, byval x as long, byval y as long, byval width as long, byval height as long) as BITMAP ptr
declare function create_video_bitmap(byval width as long, byval height as long) as BITMAP ptr
declare function create_system_bitmap(byval width as long, byval height as long) as BITMAP ptr
declare sub destroy_bitmap(byval bitmap as BITMAP ptr)
declare sub set_clip_rect(byval bitmap as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long)
declare sub add_clip_rect(byval bitmap as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long)
declare sub clear_bitmap(byval bitmap as BITMAP ptr)
declare sub vsync()

const GFX_TYPE_UNKNOWN = 0
const GFX_TYPE_WINDOWED = 1
const GFX_TYPE_FULLSCREEN = 2
const GFX_TYPE_DEFINITE = 4
const GFX_TYPE_MAGIC = 8
declare function get_gfx_mode_type(byval graphics_card as long) as long
declare function get_gfx_mode() as long
const SWITCH_NONE = 0
const SWITCH_PAUSE = 1
const SWITCH_AMNESIA = 2
const SWITCH_BACKGROUND = 3
const SWITCH_BACKAMNESIA = 4
const SWITCH_IN = 0
const SWITCH_OUT = 1

declare function set_display_switch_mode(byval mode as long) as long
declare function get_display_switch_mode() as long
declare function set_display_switch_callback(byval dir as long, byval cb as sub()) as long
declare sub remove_display_switch_callback(byval cb as sub())
declare sub lock_bitmap(byval bmp as BITMAP ptr)

#define ALLEGRO_GFX_INL
#define ALLEGRO_IMPORT_GFX_ASM
#define ALLEGRO_USE_C
#undef ALLEGRO_IMPORT_GFX_ASM
declare function _default_ds() as long
type _BMP_BANK_SWITCHER as function(byval bmp as BITMAP ptr, byval lyne as long) as uinteger
type _BMP_UNBANK_SWITCHER as sub(byval bmp as BITMAP ptr)

declare function bmp_write_line(byval bmp as BITMAP ptr, byval lyne as long) as uinteger
declare function bmp_read_line(byval bmp as BITMAP ptr, byval lyne as long) as uinteger
declare sub bmp_unwrite_line(byval bmp as BITMAP ptr)
declare function is_windowed_mode() as long
declare sub clear_to_color(byval bitmap as BITMAP ptr, byval color as long)
declare function bitmap_color_depth(byval bmp as BITMAP ptr) as long
declare function bitmap_mask_color(byval bmp as BITMAP ptr) as long
declare function is_same_bitmap(byval bmp1 as BITMAP ptr, byval bmp2 as BITMAP ptr) as long
declare function is_linear_bitmap(byval bmp as BITMAP ptr) as long
declare function is_planar_bitmap(byval bmp as BITMAP ptr) as long
declare function is_memory_bitmap(byval bmp as BITMAP ptr) as long
declare function is_screen_bitmap(byval bmp as BITMAP ptr) as long
declare function is_video_bitmap(byval bmp as BITMAP ptr) as long
declare function is_system_bitmap(byval bmp as BITMAP ptr) as long
declare function is_sub_bitmap(byval bmp as BITMAP ptr) as long
declare sub acquire_bitmap(byval bmp as BITMAP ptr)
declare sub release_bitmap(byval bmp as BITMAP ptr)
declare sub acquire_screen()
declare sub release_screen()
declare function is_inside_bitmap(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval clip as long) as long
declare sub get_clip_rect(byval bitmap as BITMAP ptr, byval x1 as long ptr, byval y_1 as long ptr, byval x2 as long ptr, byval y2 as long ptr)
declare sub set_clip_state(byval bitmap as BITMAP ptr, byval state as long)
declare function get_clip_state(byval bitmap as BITMAP ptr) as long
#define ALLEGRO_COLOR_H

extern _AL_DLL black_palette(0 to 255) as RGB
extern _AL_DLL desktop_palette(0 to 255) as RGB
extern _AL_DLL default_palette(0 to 255) as RGB

type RGB_MAP
	data(0 to 31, 0 to 31, 0 to 31) as ubyte
end type

type COLOR_MAP
	data(0 to 255, 0 to 255) as ubyte
end type

extern _AL_DLL rgb_map as RGB_MAP ptr
extern _AL_DLL color_map as COLOR_MAP ptr
extern _AL_DLL _current_palette(0 to 255) as RGB
extern _AL_DLL _rgb_r_shift_15 as long
extern _AL_DLL _rgb_g_shift_15 as long
extern _AL_DLL _rgb_b_shift_15 as long
extern _AL_DLL _rgb_r_shift_16 as long
extern _AL_DLL _rgb_g_shift_16 as long
extern _AL_DLL _rgb_b_shift_16 as long
extern _AL_DLL _rgb_r_shift_24 as long
extern _AL_DLL _rgb_g_shift_24 as long
extern _AL_DLL _rgb_b_shift_24 as long
extern _AL_DLL _rgb_r_shift_32 as long
extern _AL_DLL _rgb_g_shift_32 as long
extern _AL_DLL _rgb_b_shift_32 as long
extern _AL_DLL _rgb_a_shift_32 as long
#define _rgb_scale_5(i) ((@___rgb_scale_5)[i])
extern _AL_DLL ___rgb_scale_5 alias "_rgb_scale_5" as long
#define _rgb_scale_6(i) ((@___rgb_scale_6)[i])
extern _AL_DLL ___rgb_scale_6 alias "_rgb_scale_6" as long

const MASK_COLOR_8 = 0
const MASK_COLOR_15 = &h7C1F
const MASK_COLOR_16 = &hF81F
const MASK_COLOR_24 = &hFF00FF
const MASK_COLOR_32 = &hFF00FF

extern _AL_DLL palette_color as long ptr

declare sub set_color(byval idx as long, byval p as const RGB ptr)
declare sub set_palette(byval p as const RGB ptr)
declare sub set_palette_range(byval p as const RGB ptr, byval from as long, byval to as long, byval retracesync as long)
declare sub get_color(byval idx as long, byval p as RGB ptr)
declare sub get_palette(byval p as RGB ptr)
declare sub get_palette_range(byval p as RGB ptr, byval from as long, byval to as long)
declare sub fade_interpolate(byval source as const RGB ptr, byval dest as const RGB ptr, byval output as RGB ptr, byval pos as long, byval from as long, byval to as long)
declare sub fade_from_range(byval source as const RGB ptr, byval dest as const RGB ptr, byval speed as long, byval from as long, byval to as long)
declare sub fade_in_range(byval p as const RGB ptr, byval speed as long, byval from as long, byval to as long)
declare sub fade_out_range(byval speed as long, byval from as long, byval to as long)
declare sub fade_from(byval source as const RGB ptr, byval dest as const RGB ptr, byval speed as long)
declare sub fade_in(byval p as const RGB ptr, byval speed as long)
declare sub fade_out(byval speed as long)
declare sub select_palette(byval p as const RGB ptr)
declare sub unselect_palette()
declare sub generate_332_palette(byval pal as RGB ptr)
declare function generate_optimized_palette(byval image as BITMAP ptr, byval pal as RGB ptr, byval rsvdcols as const byte ptr) as long
declare sub create_rgb_table(byval table as RGB_MAP ptr, byval pal as const RGB ptr, byval callback as sub(byval pos as long))
declare sub create_light_table(byval table as COLOR_MAP ptr, byval pal as const RGB ptr, byval r as long, byval g as long, byval b as long, byval callback as sub(byval pos as long))
declare sub create_trans_table(byval table as COLOR_MAP ptr, byval pal as const RGB ptr, byval r as long, byval g as long, byval b as long, byval callback as sub(byval pos as long))
declare sub create_color_table(byval table as COLOR_MAP ptr, byval pal as const RGB ptr, byval blend as sub(byval pal as const RGB ptr, byval x as long, byval y as long, byval rgb as RGB ptr), byval callback as sub(byval pos as long))
declare sub create_blender_table(byval table as COLOR_MAP ptr, byval pal as const RGB ptr, byval callback as sub(byval pos as long))
type BLENDER_FUNC as function(byval x as culong, byval y as culong, byval n as culong) as culong
declare sub set_blender_mode(byval b15 as BLENDER_FUNC, byval b16 as BLENDER_FUNC, byval b24 as BLENDER_FUNC, byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_blender_mode_ex(byval b15 as BLENDER_FUNC, byval b16 as BLENDER_FUNC, byval b24 as BLENDER_FUNC, byval b32 as BLENDER_FUNC, byval b15x as BLENDER_FUNC, byval b16x as BLENDER_FUNC, byval b24x as BLENDER_FUNC, byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_alpha_blender()
declare sub set_write_alpha_blender()
declare sub set_trans_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_add_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_burn_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_color_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_difference_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_dissolve_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_dodge_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_hue_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_invert_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_luminance_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_multiply_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_saturation_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub set_screen_blender(byval r as long, byval g as long, byval b as long, byval a as long)
declare sub hsv_to_rgb(byval h as single, byval s as single, byval v as single, byval r as long ptr, byval g as long ptr, byval b as long ptr)
declare sub rgb_to_hsv(byval r as long, byval g as long, byval b as long, byval h as single ptr, byval s as single ptr, byval v as single ptr)
declare function bestfit_color(byval pal as const RGB ptr, byval r as long, byval g as long, byval b as long) as long
declare function makecol(byval r as long, byval g as long, byval b as long) as long
declare function makecol8(byval r as long, byval g as long, byval b as long) as long
declare function makecol_depth(byval color_depth as long, byval r as long, byval g as long, byval b as long) as long
declare function makeacol(byval r as long, byval g as long, byval b as long, byval a as long) as long
declare function makeacol_depth(byval color_depth as long, byval r as long, byval g as long, byval b as long, byval a as long) as long
declare function makecol15_dither(byval r as long, byval g as long, byval b as long, byval x as long, byval y as long) as long
declare function makecol16_dither(byval r as long, byval g as long, byval b as long, byval x as long, byval y as long) as long
declare function getr(byval c as long) as long
declare function getg(byval c as long) as long
declare function getb(byval c as long) as long
declare function geta(byval c as long) as long
declare function getr_depth(byval color_depth as long, byval c as long) as long
declare function getg_depth(byval color_depth as long, byval c as long) as long
declare function getb_depth(byval color_depth as long, byval c as long) as long
declare function geta_depth(byval color_depth as long, byval c as long) as long
#define ALLEGRO_COLOR_INL
declare function makecol15(byval r as long, byval g as long, byval b as long) as long
declare function makecol16(byval r as long, byval g as long, byval b as long) as long
declare function makecol24(byval r as long, byval g as long, byval b as long) as long
declare function makecol32(byval r as long, byval g as long, byval b as long) as long
declare function makeacol32(byval r as long, byval g as long, byval b as long, byval a as long) as long
declare function getr8(byval c as long) as long
declare function getg8(byval c as long) as long
declare function getb8(byval c as long) as long
declare function getr15(byval c as long) as long
declare function getg15(byval c as long) as long
declare function getb15(byval c as long) as long
declare function getr16(byval c as long) as long
declare function getg16(byval c as long) as long
declare function getb16(byval c as long) as long
declare function getr24(byval c as long) as long
declare function getg24(byval c as long) as long
declare function getb24(byval c as long) as long
declare function getr32(byval c as long) as long
declare function getg32(byval c as long) as long
declare function getb32(byval c as long) as long
declare function geta32(byval c as long) as long

#if defined(__FB_WIN32__) or defined(__FB_UNIX__)
	declare sub _set_color(byval idx as long, byval p as const RGB ptr)
#endif

#define ALLEGRO_DRAW_H
const DRAW_MODE_SOLID = 0
const DRAW_MODE_XOR = 1
const DRAW_MODE_COPY_PATTERN = 2
const DRAW_MODE_SOLID_PATTERN = 3
const DRAW_MODE_MASKED_PATTERN = 4
const DRAW_MODE_TRANS = 5

declare sub drawing_mode(byval mode as long, byval pattern as BITMAP ptr, byval x_anchor as long, byval y_anchor as long)
declare sub xor_mode(byval on as long)
declare sub solid_mode()
declare sub do_line(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval d as long, byval proc as sub(byval as BITMAP ptr, byval as long, byval as long, byval as long))
declare sub _soft_triangle(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval x3 as long, byval y3 as long, byval color as long)
declare sub _soft_polygon(byval bmp as BITMAP ptr, byval vertices as long, byval points as const long ptr, byval color as long)
declare sub _soft_rect(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval color as long)
declare sub do_circle(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval radius as long, byval d as long, byval proc as sub(byval as BITMAP ptr, byval as long, byval as long, byval as long))
declare sub _soft_circle(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval radius as long, byval color as long)
declare sub _soft_circlefill(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval radius as long, byval color as long)
declare sub do_ellipse(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval rx as long, byval ry as long, byval d as long, byval proc as sub(byval as BITMAP ptr, byval as long, byval as long, byval as long))
declare sub _soft_ellipse(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval rx as long, byval ry as long, byval color as long)
declare sub _soft_ellipsefill(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval rx as long, byval ry as long, byval color as long)
declare sub do_arc(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval ang1 as fixed, byval ang2 as fixed, byval r as long, byval d as long, byval proc as sub(byval as BITMAP ptr, byval as long, byval as long, byval as long))
declare sub _soft_arc(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval ang1 as fixed, byval ang2 as fixed, byval r as long, byval color as long)
declare sub calc_spline(byval points as const long ptr, byval npts as long, byval x as long ptr, byval y as long ptr)
declare sub _soft_spline(byval bmp as BITMAP ptr, byval points as const long ptr, byval color as long)
declare sub _soft_floodfill(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval color as long)
declare sub blit(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long)
declare sub masked_blit(byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as long, byval source_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long)
declare sub stretch_blit(byval s as BITMAP ptr, byval d as BITMAP ptr, byval s_x as long, byval s_y as long, byval s_w as long, byval s_h as long, byval d_x as long, byval d_y as long, byval d_w as long, byval d_h as long)
declare sub masked_stretch_blit(byval s as BITMAP ptr, byval d as BITMAP ptr, byval s_x as long, byval s_y as long, byval s_w as long, byval s_h as long, byval d_x as long, byval d_y as long, byval d_w as long, byval d_h as long)
declare sub stretch_sprite(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval w as long, byval h as long)
declare sub _soft_draw_gouraud_sprite(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval c1 as long, byval c2 as long, byval c3 as long, byval c4 as long)
declare sub rotate_sprite_trans(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed)
declare sub rotate_sprite_v_flip_trans(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed)
declare sub rotate_scaled_sprite_trans(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed, byval scale as fixed)
declare sub rotate_scaled_sprite_v_flip_trans(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed, byval scale as fixed)
declare sub pivot_sprite_trans(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed)
declare sub pivot_sprite_v_flip_trans(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed)
declare sub pivot_scaled_sprite_trans(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed, byval scale as fixed)
declare sub pivot_scaled_sprite_v_flip_trans(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed, byval scale as fixed)
declare sub rotate_sprite_lit(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed, byval color as long)
declare sub rotate_sprite_v_flip_lit(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed, byval color as long)
declare sub rotate_scaled_sprite_lit(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed, byval scale as fixed, byval color as long)
declare sub rotate_scaled_sprite_v_flip_lit(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed, byval scale as fixed, byval color as long)
declare sub pivot_sprite_lit(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed, byval color as long)
declare sub pivot_sprite_v_flip_lit(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed, byval color as long)
declare sub pivot_scaled_sprite_lit(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed, byval scale as fixed, byval color as long)
declare sub pivot_scaled_sprite_v_flip_lit(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed, byval scale as fixed, byval color as long)
#define ALLEGRO_DRAW_INL
declare function getpixel(byval bmp as BITMAP ptr, byval x as long, byval y as long) as long
declare sub putpixel(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval color as long)
declare sub _allegro_vline(byval bmp as BITMAP ptr, byval x as long, byval y_1 as long, byval y2 as long, byval color as long)
declare sub _allegro_hline(byval bmp as BITMAP ptr, byval x1 as long, byval y as long, byval x2 as long, byval color as long)
declare sub vline(byval bmp as BITMAP ptr, byval x as long, byval y_1 as long, byval y2 as long, byval color as long)
declare sub hline(byval bmp as BITMAP ptr, byval x1 as long, byval y as long, byval x2 as long, byval color as long)
declare sub line(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval color as long)
declare sub fastline(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval color as long)
declare sub rectfill(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval color as long)
declare sub triangle(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval x3 as long, byval y3 as long, byval color as long)
declare sub polygon(byval bmp as BITMAP ptr, byval vertices as long, byval points as const long ptr, byval color as long)
declare sub rect(byval bmp as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long, byval color as long)
declare sub circle(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval radius as long, byval color as long)
declare sub circlefill(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval radius as long, byval color as long)
declare sub ellipse(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval rx as long, byval ry as long, byval color as long)
declare sub ellipsefill(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval rx as long, byval ry as long, byval color as long)
declare sub arc(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval ang1 as fixed, byval ang2 as fixed, byval r as long, byval color as long)
declare sub spline(byval bmp as BITMAP ptr, byval points as const long ptr, byval color as long)
declare sub floodfill(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval color as long)
declare sub polygon3d(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval vc as long, byval vtx as V3D ptr ptr)
declare sub polygon3d_f(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval vc as long, byval vtx as V3D_f ptr ptr)
declare sub triangle3d(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D ptr, byval v2 as V3D ptr, byval v3 as V3D ptr)
declare sub triangle3d_f(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D_f ptr, byval v2 as V3D_f ptr, byval v3 as V3D_f ptr)
declare sub quad3d(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D ptr, byval v2 as V3D ptr, byval v3 as V3D ptr, byval v4 as V3D ptr)
declare sub quad3d_f(byval bmp as BITMAP ptr, byval type as long, byval texture as BITMAP ptr, byval v1 as V3D_f ptr, byval v2 as V3D_f ptr, byval v3 as V3D_f ptr, byval v4 as V3D_f ptr)
declare sub draw_sprite(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
declare sub draw_sprite_ex(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval mode as long, byval flip as long)
declare sub draw_sprite_v_flip(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
declare sub draw_sprite_h_flip(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
declare sub draw_sprite_vh_flip(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
declare sub draw_trans_sprite(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long)
declare sub draw_lit_sprite(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval color as long)
declare sub draw_gouraud_sprite(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval c1 as long, byval c2 as long, byval c3 as long, byval c4 as long)
declare sub draw_character_ex(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval color as long, byval bg as long)
declare sub rotate_sprite(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed)
declare sub rotate_sprite_v_flip(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed)
declare sub rotate_scaled_sprite(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed, byval scale as fixed)
declare sub rotate_scaled_sprite_v_flip(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval angle as fixed, byval scale as fixed)
declare sub pivot_sprite(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed)
declare sub pivot_sprite_v_flip(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed)
declare sub pivot_scaled_sprite(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed, byval scale as fixed)
declare sub pivot_scaled_sprite_v_flip(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval angle as fixed, byval scale as fixed)
declare sub _putpixel(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval color as long)
declare function _getpixel(byval bmp as BITMAP ptr, byval x as long, byval y as long) as long
declare sub _putpixel15(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval color as long)
declare function _getpixel15(byval bmp as BITMAP ptr, byval x as long, byval y as long) as long
declare sub _putpixel16(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval color as long)
declare function _getpixel16(byval bmp as BITMAP ptr, byval x as long, byval y as long) as long
declare sub _putpixel24(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval color as long)
declare function _getpixel24(byval bmp as BITMAP ptr, byval x as long, byval y as long) as long
declare sub _putpixel32(byval bmp as BITMAP ptr, byval x as long, byval y as long, byval color as long)
declare function _getpixel32(byval bmp as BITMAP ptr, byval x as long, byval y as long) as long
#define ALLEGRO_RLE_H

type RLE_SPRITE_
	w as long
	h as long
	color_depth as long
	size as long
	dat(0 to 1 - 1) as byte
end type

declare function get_rle_sprite(byval bitmap as BITMAP ptr) as RLE_SPRITE ptr
declare sub destroy_rle_sprite(byval sprite as RLE_SPRITE ptr)
#define ALLEGRO_RLE_INL
declare sub draw_rle_sprite(byval bmp as BITMAP ptr, byval sprite as const RLE_SPRITE ptr, byval x as long, byval y as long)
declare sub draw_trans_rle_sprite(byval bmp as BITMAP ptr, byval sprite as const RLE_SPRITE ptr, byval x as long, byval y as long)
declare sub draw_lit_rle_sprite(byval bmp as BITMAP ptr, byval sprite as const RLE_SPRITE ptr, byval x as long, byval y as long, byval color as long)
#define ALLEGRO_COMPILED_H
type COMPILED_SPRITE as RLE_SPRITE
declare function get_compiled_sprite(byval bitmap as BITMAP ptr, byval planar as long) as COMPILED_SPRITE ptr
declare sub destroy_compiled_sprite(byval sprite as COMPILED_SPRITE ptr)
declare sub draw_compiled_sprite(byval bmp as BITMAP ptr, byval sprite as const COMPILED_SPRITE ptr, byval x as long, byval y as long)
#define ALLEGRO_TEXT_H
type FONT as FONT_

extern _AL_DLL font as FONT ptr
extern _AL_DLL allegro_404_char as long

declare sub textout_ex(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval str as const zstring ptr, byval x as long, byval y as long, byval color as long, byval bg as long)
declare sub textout_centre_ex(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval str as const zstring ptr, byval x as long, byval y as long, byval color as long, byval bg as long)
declare sub textout_right_ex(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval str as const zstring ptr, byval x as long, byval y as long, byval color as long, byval bg as long)
declare sub textout_justify_ex(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval str as const zstring ptr, byval x1 as long, byval x2 as long, byval y as long, byval diff as long, byval color as long, byval bg as long)
declare sub textprintf_ex(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval x as long, byval y as long, byval color as long, byval bg as long, byval format as const zstring ptr, ...)
declare sub textprintf_centre_ex(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval x as long, byval y as long, byval color as long, byval bg as long, byval format as const zstring ptr, ...)
declare sub textprintf_right_ex(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval x as long, byval y as long, byval color as long, byval bg as long, byval format as const zstring ptr, ...)
declare sub textprintf_justify_ex(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval x1 as long, byval x2 as long, byval y as long, byval diff as long, byval color as long, byval bg as long, byval format as const zstring ptr, ...)
declare function text_length(byval f as const FONT ptr, byval str as const zstring ptr) as long
declare function text_height(byval f as const FONT ptr) as long
declare sub destroy_font(byval f as FONT ptr)
#define ALLEGRO_FONT_H

type FONT_GLYPH_
	w as short
	h as short
	dat(0 to 1 - 1) as ubyte
end type

type FONT_VTABLE as FONT_VTABLE_

type FONT_
	data as any ptr
	height as long
	vtable as FONT_VTABLE ptr
end type

declare function font_has_alpha(byval f as FONT ptr) as long
declare sub make_trans_font(byval f as FONT ptr)
declare function is_trans_font(byval f as FONT ptr) as long
declare function is_color_font(byval f as FONT ptr) as long
declare function is_mono_font(byval f as FONT ptr) as long
declare function is_compatible_font(byval f1 as FONT ptr, byval f2 as FONT ptr) as long
declare sub register_font_file_type(byval ext as const zstring ptr, byval load as function(byval filename as const zstring ptr, byval pal as RGB ptr, byval param as any ptr) as FONT ptr)
declare function load_font(byval filename as const zstring ptr, byval pal as RGB ptr, byval param as any ptr) as FONT ptr
declare function load_dat_font(byval filename as const zstring ptr, byval pal as RGB ptr, byval param as any ptr) as FONT ptr
declare function load_bios_font(byval filename as const zstring ptr, byval pal as RGB ptr, byval param as any ptr) as FONT ptr
declare function load_grx_font(byval filename as const zstring ptr, byval pal as RGB ptr, byval param as any ptr) as FONT ptr
declare function load_grx_or_bios_font(byval filename as const zstring ptr, byval pal as RGB ptr, byval param as any ptr) as FONT ptr
declare function load_bitmap_font(byval fname as const zstring ptr, byval pal as RGB ptr, byval param as any ptr) as FONT ptr
declare function load_txt_font(byval fname as const zstring ptr, byval pal as RGB ptr, byval param as any ptr) as FONT ptr
declare function grab_font_from_bitmap(byval bmp as BITMAP ptr) as FONT ptr
declare function get_font_ranges(byval f as FONT ptr) as long
declare function get_font_range_begin(byval f as FONT ptr, byval range as long) as long
declare function get_font_range_end(byval f as FONT ptr, byval range as long) as long
declare function extract_font_range(byval f as FONT ptr, byval begin as long, byval end as long) as FONT ptr
declare function merge_fonts(byval f1 as FONT ptr, byval f2 as FONT ptr) as FONT ptr
declare function transpose_font(byval f as FONT ptr, byval drange as long) as long

#define ALLEGRO_FLI_H
const FLI_OK = 0
const FLI_EOF = -1
const FLI_ERROR = -2
const FLI_NOT_OPEN = -3

declare function play_fli(byval filename as const zstring ptr, byval bmp as BITMAP ptr, byval loop as long, byval callback as function() as long) as long
declare function play_memory_fli(byval fli_data as any ptr, byval bmp as BITMAP ptr, byval loop as long, byval callback as function() as long) as long
declare function open_fli(byval filename as const zstring ptr) as long
declare function open_memory_fli(byval fli_data as any ptr) as long
declare sub close_fli()
declare function next_fli_frame(byval loop as long) as long
declare sub reset_fli_variables()

extern _AL_DLL fli_bitmap as BITMAP ptr
extern _AL_DLL fli_palette(0 to 255) as RGB
extern _AL_DLL fli_bmp_dirty_from as long
extern _AL_DLL fli_bmp_dirty_to as long
extern _AL_DLL fli_pal_dirty_from as long
extern _AL_DLL fli_pal_dirty_to as long
extern _AL_DLL fli_frame as long
extern _AL_DLL fli_timer as long

#define ALLEGRO_GUI_H
type DIALOG as DIALOG_
type DIALOG_PROC as function(byval msg as long, byval d as DIALOG ptr, byval c as long) as long

type DIALOG_
	proc as DIALOG_PROC
	x as long
	y as long
	w as long
	h as long
	fg as long
	bg as long
	key as long
	flags as long
	d1 as long
	d2 as long
	dp as any ptr
	dp2 as any ptr
	dp3 as any ptr
end type

type MENU
	text as zstring ptr
	proc as function() as long
	child as MENU ptr
	flags as long
	dp as any ptr
end type

type DIALOG_PLAYER
	obj as long
	res as long
	mouse_obj as long
	focus_obj as long
	joy_on as long
	click_wait as long
	mouse_ox as long
	mouse_oy as long
	mouse_oz as long
	mouse_b as long
	dialog as DIALOG ptr
end type

type MENU_PLAYER
	menu as MENU ptr
	bar as long
	size as long
	sel as long
	x as long
	y as long
	w as long
	h as long
	proc as function() as long
	saved as BITMAP ptr
	mouse_button_was_pressed as long
	back_from_child as long
	timestamp as long
	mouse_sel as long
	redraw as long
	auto_open as long
	ret as long
	dialog as DIALOG ptr
	parent as MENU_PLAYER ptr
	child as MENU_PLAYER ptr
end type

const D_EXIT = 1
const D_SELECTED = 2
const D_GOTFOCUS = 4
const D_GOTMOUSE = 8
const D_HIDDEN = 16
const D_DISABLED = 32
const D_DIRTY = 64
const D_INTERNAL = 128
const D_USER = 256
const D_O_K = 0
const D_CLOSE = 1
const D_REDRAW = 2
const D_REDRAWME = 4
const D_WANTFOCUS = 8
const D_USED_CHAR = 16
const D_REDRAW_ALL = 32
const D_DONTWANTMOUSE = 64
const MSG_START = 1
const MSG_END = 2
const MSG_DRAW = 3
const MSG_CLICK = 4
const MSG_DCLICK = 5
const MSG_KEY = 6
const MSG_CHAR = 7
const MSG_UCHAR = 8
const MSG_XCHAR = 9
const MSG_WANTFOCUS = 10
const MSG_GOTFOCUS = 11
const MSG_LOSTFOCUS = 12
const MSG_GOTMOUSE = 13
const MSG_LOSTMOUSE = 14
const MSG_IDLE = 15
const MSG_RADIO = 16
const MSG_WHEEL = 17
const MSG_LPRESS = 18
const MSG_LRELEASE = 19
const MSG_MPRESS = 20
const MSG_MRELEASE = 21
const MSG_RPRESS = 22
const MSG_RRELEASE = 23
const MSG_WANTMOUSE = 24
const MSG_USER = 25

declare function d_yield_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_clear_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_box_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_shadow_box_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_bitmap_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_text_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_ctext_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_rtext_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_button_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_check_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_radio_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_icon_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_keyboard_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_edit_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_list_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_text_list_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_textbox_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_slider_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long
declare function d_menu_proc(byval msg as long, byval d as DIALOG ptr, byval c as long) as long

extern _AL_DLL gui_shadow_box_proc as DIALOG_PROC
extern _AL_DLL gui_ctext_proc as DIALOG_PROC
extern _AL_DLL gui_button_proc as DIALOG_PROC
extern _AL_DLL gui_edit_proc as DIALOG_PROC
extern _AL_DLL gui_list_proc as DIALOG_PROC
extern _AL_DLL gui_text_list_proc as DIALOG_PROC
extern _AL_DLL gui_menu_draw_menu as sub(byval x as long, byval y as long, byval w as long, byval h as long)
extern _AL_DLL gui_menu_draw_menu_item as sub(byval m as MENU ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval bar as long, byval sel as long)
extern _AL_DLL active_dialog as DIALOG ptr
extern _AL_DLL active_menu as MENU ptr
extern _AL_DLL gui_mouse_focus as long
extern _AL_DLL gui_fg_color as long
extern _AL_DLL gui_mg_color as long
extern _AL_DLL gui_bg_color as long
extern _AL_DLL gui_font_baseline as long
extern _AL_DLL gui_mouse_x as function() as long
extern _AL_DLL gui_mouse_y as function() as long
extern _AL_DLL gui_mouse_z as function() as long
extern _AL_DLL gui_mouse_b as function() as long

declare sub gui_set_screen(byval bmp as BITMAP ptr)
declare function gui_get_screen() as BITMAP ptr
declare function gui_textout_ex(byval bmp as BITMAP ptr, byval s as const zstring ptr, byval x as long, byval y as long, byval color as long, byval bg as long, byval centre as long) as long
declare function gui_strlen(byval s as const zstring ptr) as long
declare sub position_dialog(byval dialog as DIALOG ptr, byval x as long, byval y as long)
declare sub centre_dialog(byval dialog as DIALOG ptr)
declare sub set_dialog_color(byval dialog as DIALOG ptr, byval fg as long, byval bg as long)
declare function find_dialog_focus(byval dialog as DIALOG ptr) as long
declare function offer_focus(byval dialog as DIALOG ptr, byval obj as long, byval focus_obj as long ptr, byval force as long) as long
declare function object_message(byval dialog as DIALOG ptr, byval msg as long, byval c as long) as long
declare function dialog_message(byval dialog as DIALOG ptr, byval msg as long, byval c as long, byval obj as long ptr) as long
declare function broadcast_dialog_message(byval msg as long, byval c as long) as long
declare function do_dialog(byval dialog as DIALOG ptr, byval focus_obj as long) as long
declare function popup_dialog(byval dialog as DIALOG ptr, byval focus_obj as long) as long
declare function init_dialog(byval dialog as DIALOG ptr, byval focus_obj as long) as DIALOG_PLAYER ptr
declare function update_dialog(byval player as DIALOG_PLAYER ptr) as long
declare function shutdown_dialog(byval player as DIALOG_PLAYER ptr) as long
declare function do_menu(byval menu as MENU ptr, byval x as long, byval y as long) as long
declare function init_menu(byval menu as MENU ptr, byval x as long, byval y as long) as MENU_PLAYER ptr
declare function update_menu(byval player as MENU_PLAYER ptr) as long
declare function shutdown_menu(byval player as MENU_PLAYER ptr) as long
declare function alert(byval s1 as const zstring ptr, byval s2 as const zstring ptr, byval s3 as const zstring ptr, byval b1 as const zstring ptr, byval b2 as const zstring ptr, byval c1 as long, byval c2 as long) as long
declare function alert3(byval s1 as const zstring ptr, byval s2 as const zstring ptr, byval s3 as const zstring ptr, byval b1 as const zstring ptr, byval b2 as const zstring ptr, byval b3 as const zstring ptr, byval c1 as long, byval c2 as long, byval c3 as long) as long
declare function file_select_ex(byval message as const zstring ptr, byval path as zstring ptr, byval ext as const zstring ptr, byval size as long, byval w as long, byval h as long) as long
declare function gfx_mode_select(byval card as long ptr, byval w as long ptr, byval h as long ptr) as long
declare function gfx_mode_select_ex(byval card as long ptr, byval w as long ptr, byval h as long ptr, byval color_depth as long ptr) as long
declare function gfx_mode_select_filter(byval card as long ptr, byval w as long ptr, byval h as long ptr, byval color_depth as long ptr, byval filter as function(byval as long, byval as long, byval as long, byval as long) as long) as long

#define ALLEGRO_SOUND_H
#define ALLEGRO_DIGI_H
const DIGI_VOICES = 64

type SAMPLE
	bits as long
	stereo as long
	freq as long
	priority as long
	len as culong
	loop_start as culong
	loop_end as culong
	param as culong
	data as any ptr
end type

const DIGI_AUTODETECT = -1
const DIGI_NONE = 0

type DIGI_DRIVER
	id as long
	name as const zstring ptr
	desc as const zstring ptr
	ascii_name as const zstring ptr
	voices as long
	basevoice as long
	max_voices as long
	def_voices as long
	detect as function(byval input as long) as long
	init as function(byval input as long, byval voices as long) as long
	exit as sub(byval input as long)
	set_mixer_volume as function(byval volume as long) as long
	get_mixer_volume as function() as long
	lock_voice as function(byval voice as long, byval start as long, byval end as long) as any ptr
	unlock_voice as sub(byval voice as long)
	buffer_size as function() as long
	init_voice as sub(byval voice as long, byval sample as const SAMPLE ptr)
	release_voice as sub(byval voice as long)
	start_voice as sub(byval voice as long)
	stop_voice as sub(byval voice as long)
	loop_voice as sub(byval voice as long, byval playmode as long)
	get_position as function(byval voice as long) as long
	set_position as sub(byval voice as long, byval position as long)
	get_volume as function(byval voice as long) as long
	set_volume as sub(byval voice as long, byval volume as long)
	ramp_volume as sub(byval voice as long, byval tyme as long, byval endvol as long)
	stop_volume_ramp as sub(byval voice as long)
	get_frequency as function(byval voice as long) as long
	set_frequency as sub(byval voice as long, byval frequency as long)
	sweep_frequency as sub(byval voice as long, byval tyme as long, byval endfreq as long)
	stop_frequency_sweep as sub(byval voice as long)
	get_pan as function(byval voice as long) as long
	set_pan as sub(byval voice as long, byval pan as long)
	sweep_pan as sub(byval voice as long, byval tyme as long, byval endpan as long)
	stop_pan_sweep as sub(byval voice as long)
	set_echo as sub(byval voice as long, byval strength as long, byval delay as long)
	set_tremolo as sub(byval voice as long, byval rate as long, byval depth as long)
	set_vibrato as sub(byval voice as long, byval rate as long, byval depth as long)
	rec_cap_bits as long
	rec_cap_stereo as long
	rec_cap_rate as function(byval bits as long, byval stereo as long) as long
	rec_cap_parm as function(byval rate as long, byval bits as long, byval stereo as long) as long
	rec_source as function(byval source as long) as long
	rec_start as function(byval rate as long, byval bits as long, byval stereo as long) as long
	rec_stop as sub()
	rec_read as function(byval buf as any ptr) as long
end type

#define _digi_driver_list(i) ((@___digi_driver_list)[i])
extern _AL_DLL ___digi_driver_list alias "_digi_driver_list" as _DRIVER_INFO
#define BEGIN_DIGI_DRIVER_LIST dim as _DRIVER_INFO _digi_driver_list(0 to ...) = {
#define END_DIGI_DRIVER_LIST ( 0, NULL, 0 ) }

extern _AL_DLL digi_driver as DIGI_DRIVER ptr
extern _AL_DLL digi_input_driver as DIGI_DRIVER ptr
extern _AL_DLL digi_card as long
extern _AL_DLL digi_input_card as long

declare function detect_digi_driver(byval driver_id as long) as long
declare function load_sample(byval filename as const zstring ptr) as SAMPLE ptr
declare function load_wav(byval filename as const zstring ptr) as SAMPLE ptr
type PACKFILE as PACKFILE_
declare function load_wav_pf(byval f as PACKFILE ptr) as SAMPLE ptr
declare function load_voc(byval filename as const zstring ptr) as SAMPLE ptr
declare function load_voc_pf(byval f as PACKFILE ptr) as SAMPLE ptr
declare function save_sample(byval filename as const zstring ptr, byval spl as SAMPLE ptr) as long
declare function create_sample(byval bits as long, byval stereo as long, byval freq as long, byval len as long) as SAMPLE ptr
declare sub destroy_sample(byval spl as SAMPLE ptr)
declare function play_sample(byval spl as const SAMPLE ptr, byval vol as long, byval pan as long, byval freq as long, byval loop as long) as long
declare sub stop_sample(byval spl as const SAMPLE ptr)
declare sub adjust_sample(byval spl as const SAMPLE ptr, byval vol as long, byval pan as long, byval freq as long, byval loop as long)
declare function allocate_voice(byval spl as const SAMPLE ptr) as long
declare sub deallocate_voice(byval voice as long)
declare sub reallocate_voice(byval voice as long, byval spl as const SAMPLE ptr)
declare sub release_voice(byval voice as long)
declare sub voice_start(byval voice as long)
declare sub voice_stop(byval voice as long)
declare sub voice_set_priority(byval voice as long, byval priority as long)
declare function voice_check(byval voice as long) as SAMPLE ptr

const PLAYMODE_PLAY = 0
const PLAYMODE_LOOP = 1
const PLAYMODE_FORWARD = 0
const PLAYMODE_BACKWARD = 2
const PLAYMODE_BIDIR = 4

declare sub voice_set_playmode(byval voice as long, byval playmode as long)
declare function voice_get_position(byval voice as long) as long
declare sub voice_set_position(byval voice as long, byval position as long)
declare function voice_get_volume(byval voice as long) as long
declare sub voice_set_volume(byval voice as long, byval volume as long)
declare sub voice_ramp_volume(byval voice as long, byval tyme as long, byval endvol as long)
declare sub voice_stop_volumeramp(byval voice as long)
declare function voice_get_frequency(byval voice as long) as long
declare sub voice_set_frequency(byval voice as long, byval frequency as long)
declare sub voice_sweep_frequency(byval voice as long, byval tyme as long, byval endfreq as long)
declare sub voice_stop_frequency_sweep(byval voice as long)
declare function voice_get_pan(byval voice as long) as long
declare sub voice_set_pan(byval voice as long, byval pan as long)
declare sub voice_sweep_pan(byval voice as long, byval tyme as long, byval endpan as long)
declare sub voice_stop_pan_sweep(byval voice as long)
declare sub voice_set_echo(byval voice as long, byval strength as long, byval delay as long)
declare sub voice_set_tremolo(byval voice as long, byval rate as long, byval depth as long)
declare sub voice_set_vibrato(byval voice as long, byval rate as long, byval depth as long)

const SOUND_INPUT_MIC = 1
const SOUND_INPUT_LINE = 2
const SOUND_INPUT_CD = 3

declare function get_sound_input_cap_bits() as long
declare function get_sound_input_cap_stereo() as long
declare function get_sound_input_cap_rate(byval bits as long, byval stereo as long) as long
declare function get_sound_input_cap_parm(byval rate as long, byval bits as long, byval stereo as long) as long
declare function set_sound_input_source(byval source as long) as long
declare function start_sound_input(byval rate as long, byval bits as long, byval stereo as long) as long
declare sub stop_sound_input()
declare function read_sound_input(byval buffer as any ptr) as long

extern _AL_DLL digi_recorder as sub()

declare sub lock_sample(byval spl as SAMPLE ptr)
declare sub register_sample_file_type(byval ext as const zstring ptr, byval load as function(byval filename as const zstring ptr) as SAMPLE ptr, byval save as function(byval filename as const zstring ptr, byval spl as SAMPLE ptr) as long)
#define ALLEGRO_STREAM_H

type AUDIOSTREAM
	voice as long
	samp as SAMPLE ptr
	len as long
	bufcount as long
	bufnum as long
	active as long
	locked as any ptr
end type

declare function play_audio_stream(byval len as long, byval bits as long, byval stereo as long, byval freq as long, byval vol as long, byval pan as long) as AUDIOSTREAM ptr
declare sub stop_audio_stream(byval stream as AUDIOSTREAM ptr)
declare function get_audio_stream_buffer(byval stream as AUDIOSTREAM ptr) as any ptr
declare sub free_audio_stream_buffer(byval stream as AUDIOSTREAM ptr)

#define ALLEGRO_MIDI_H
const MIDI_VOICES = 64
const MIDI_TRACKS = 32

type MIDI_track
	data as ubyte ptr
	len as long
end type

type MIDI
	divisions as long
	track(0 to 31) as MIDI_track
end type

const MIDI_AUTODETECT = -1
const MIDI_NONE = 0
#define MIDI_DIGMID_ AL_ID(asc("D"), asc("I"), asc("G"), asc("I"))

type MIDI_DRIVER
	id as long
	name as const zstring ptr
	desc as const zstring ptr
	ascii_name as const zstring ptr
	voices as long
	basevoice as long
	max_voices as long
	def_voices as long
	xmin as long
	xmax as long
	detect as function(byval input as long) as long
	init as function(byval input as long, byval voices as long) as long
	exit as sub(byval input as long)
	set_mixer_volume as function(byval volume as long) as long
	get_mixer_volume as function() as long
	raw_midi as sub(byval data as long)
	load_patches as function(byval patches as const zstring ptr, byval drums as const zstring ptr) as long
	adjust_patches as sub(byval patches as const zstring ptr, byval drums as const zstring ptr)
	key_on as sub(byval inst as long, byval note as long, byval bend as long, byval vol as long, byval pan as long)
	key_off as sub(byval voice as long)
	set_volume as sub(byval voice as long, byval vol as long)
	set_pitch as sub(byval voice as long, byval note as long, byval bend as long)
	set_pan as sub(byval voice as long, byval pan as long)
	set_vibrato as sub(byval voice as long, byval amount as long)
end type

extern _AL_DLL midi_digmid as MIDI_DRIVER
#define _midi_driver_list(i) ((@___midi_driver_list)[i])
extern _AL_DLL ___midi_driver_list alias "_midi_driver_list" as _DRIVER_INFO
#define BEGIN_MIDI_DRIVER_LIST dim as _DRIVER_INFO _midi_driver_list(0 to ...) = {
#define END_MIDI_DRIVER_LIST ( 0, NULL, 0 ) }
#define MIDI_DRIVER_DIGMID ( MIDI_DIGMID, @midi_digmid, TRUE ),

extern _AL_DLL midi_driver as MIDI_DRIVER ptr
extern _AL_DLL midi_input_driver as MIDI_DRIVER ptr
extern _AL_DLL midi_card as long
extern _AL_DLL midi_input_card as long
extern _AL_DLL midi_pos as clong
extern _AL_DLL midi_time as clong
extern _AL_DLL midi_loop_start as clong
extern _AL_DLL midi_loop_end as clong

declare function detect_midi_driver(byval driver_id as long) as long
declare function load_midi(byval filename as const zstring ptr) as MIDI ptr
declare sub destroy_midi(byval midi as MIDI ptr)
declare function play_midi(byval midi as MIDI ptr, byval loop as long) as long
declare function play_looped_midi(byval midi as MIDI ptr, byval loop_start as long, byval loop_end as long) as long
declare sub stop_midi()
declare sub midi_pause()
declare sub midi_resume()
declare function midi_seek(byval target as long) as long
declare function get_midi_length(byval midi as MIDI ptr) as long
declare sub midi_out(byval data as ubyte ptr, byval length as long)
declare function load_midi_patches() as long

extern _AL_DLL midi_msg_callback as sub(byval msg as long, byval byte1 as long, byval byte2 as long)
extern _AL_DLL midi_meta_callback as sub(byval type as long, byval data as const ubyte ptr, byval length as long)
extern _AL_DLL midi_sysex_callback as sub(byval data as const ubyte ptr, byval length as long)
extern _AL_DLL midi_recorder as sub(byval data as ubyte)

declare sub lock_midi(byval midi as MIDI ptr)
declare sub reserve_voices(byval digi_voices_ as long, byval midi_voices_ as long)
declare sub set_volume_per_voice(byval scale as long)
declare function install_sound(byval digi as long, byval midi as long, byval cfg_path as const zstring ptr) as long
declare sub remove_sound()
declare function install_sound_input(byval digi as long, byval midi as long) as long
declare sub remove_sound_input()
declare sub set_volume(byval digi_volume as long, byval midi_volume as long)
declare sub set_hardware_volume(byval digi_volume as long, byval midi_volume as long)
declare sub get_volume(byval digi_volume as long ptr, byval midi_volume as long ptr)
declare sub get_hardware_volume(byval digi_volume as long ptr, byval midi_volume as long ptr)
declare sub set_mixer_quality(byval quality as long)
declare function get_mixer_quality() as long
declare function get_mixer_frequency() as long
declare function get_mixer_bits() as long
declare function get_mixer_channels() as long
declare function get_mixer_voices() as long
declare function get_mixer_buffer_length() as long
#define ALLEGRO_FILE_H
declare function fix_filename_case(byval path as zstring ptr) as zstring ptr
declare function fix_filename_slashes(byval path as zstring ptr) as zstring ptr
declare function canonicalize_filename(byval dest as zstring ptr, byval filename as const zstring ptr, byval size as long) as zstring ptr
declare function make_absolute_filename(byval dest as zstring ptr, byval path as const zstring ptr, byval filename as const zstring ptr, byval size as long) as zstring ptr
declare function make_relative_filename(byval dest as zstring ptr, byval path as const zstring ptr, byval filename as const zstring ptr, byval size as long) as zstring ptr
declare function is_relative_filename(byval filename as const zstring ptr) as long
declare function replace_filename(byval dest as zstring ptr, byval path as const zstring ptr, byval filename as const zstring ptr, byval size as long) as zstring ptr
declare function replace_extension(byval dest as zstring ptr, byval filename as const zstring ptr, byval ext as const zstring ptr, byval size as long) as zstring ptr
declare function append_filename(byval dest as zstring ptr, byval path as const zstring ptr, byval filename as const zstring ptr, byval size as long) as zstring ptr
declare function get_filename(byval path as const zstring ptr) as zstring ptr
declare function get_extension(byval filename as const zstring ptr) as zstring ptr
declare sub put_backslash(byval filename as zstring ptr)
declare function file_exists(byval filename as const zstring ptr, byval attrib as long, byval aret as long ptr) as long
declare function exists(byval filename as const zstring ptr) as long
declare function file_size_ex(byval filename as const zstring ptr) as ulongint
declare function file_time(byval filename as const zstring ptr) as time_t
declare function delete_file(byval filename as const zstring ptr) as long
declare function for_each_file_ex(byval name as const zstring ptr, byval in_attrib as long, byval out_attrib as long, byval callback as function(byval filename as const zstring ptr, byval attrib as long, byval param as any ptr) as long, byval param as any ptr) as long
declare function set_allegro_resource_path(byval priority as long, byval path as const zstring ptr) as long
declare function find_allegro_resource(byval dest as zstring ptr, byval resource as const zstring ptr, byval ext as const zstring ptr, byval datafile as const zstring ptr, byval objectname as const zstring ptr, byval envvar as const zstring ptr, byval subdir as const zstring ptr, byval size as long) as long

type al_ffblk
	attrib as long
	time as time_t
	size as clong
	name as zstring * 512
	ff_data as any ptr
end type

declare function al_ffblk_get_size(byval info as al_ffblk ptr) as ulongint
declare function al_findfirst(byval pattern as const zstring ptr, byval info as al_ffblk ptr, byval attrib as long) as long
declare function al_findnext(byval info as al_ffblk ptr) as long
declare sub al_findclose(byval info as al_ffblk ptr)

#define EOF_ (-1)
#define F_READ "r"
#define F_WRITE "w"
#define F_READ_PACKED "rp"
#define F_WRITE_PACKED "wp"
#define F_WRITE_NOPACK "w!"
const F_BUF_SIZE = 4096
const F_PACK_MAGIC = cast(clong, &h736C6821)
const F_NOPACK_MAGIC = cast(clong, &h736C682E)
const F_EXE_MAGIC = cast(clong, &h736C682B)
const PACKFILE_FLAG_WRITE = 1
const PACKFILE_FLAG_PACK = 2
const PACKFILE_FLAG_CHUNK = 4
const PACKFILE_FLAG_EOF = 8
const PACKFILE_FLAG_ERROR = 16
const PACKFILE_FLAG_OLD_CRYPT = 32
const PACKFILE_FLAG_EXEDAT = 64
type LZSS_PACK_DATA as LZSS_PACK_DATA_
type LZSS_UNPACK_DATA as LZSS_UNPACK_DATA_

type _al_normal_packfile_details
	hndl as long
	flags as long
	buf_pos as ubyte ptr
	buf_size as long
	todo as clong
	parent as PACKFILE ptr
	pack_data as LZSS_PACK_DATA ptr
	unpack_data as LZSS_UNPACK_DATA ptr
	filename as zstring ptr
	passdata as zstring ptr
	passpos as zstring ptr
	buf(0 to 4095) as ubyte
end type

type PACKFILE_VTABLE as PACKFILE_VTABLE_

type PACKFILE_
	vtable as const PACKFILE_VTABLE ptr
	userdata as any ptr
	is_normal_packfile as long
	normal as _al_normal_packfile_details
end type

type PACKFILE_VTABLE_
	pf_fclose as function(byval userdata as any ptr) as long
	pf_getc as function(byval userdata as any ptr) as long
	pf_ungetc as function(byval c as long, byval userdata as any ptr) as long
	pf_fread as function(byval p as any ptr, byval n as clong, byval userdata as any ptr) as clong
	pf_putc as function(byval c as long, byval userdata as any ptr) as long
	pf_fwrite as function(byval p as const any ptr, byval n as clong, byval userdata as any ptr) as clong
	pf_fseek as function(byval userdata as any ptr, byval offset as long) as long
	pf_feof as function(byval userdata as any ptr) as long
	pf_ferror as function(byval userdata as any ptr) as long
end type

#define uconvert_tofilename(s, buf) uconvert(s, U_CURRENT, buf, get_filename_encoding(), sizeof(buf))
declare sub set_filename_encoding(byval encoding as long)
declare function get_filename_encoding() as long
declare sub packfile_password(byval password as const zstring ptr)
declare function pack_fopen(byval filename as const zstring ptr, byval mode as const zstring ptr) as PACKFILE ptr
declare function pack_fopen_vtable(byval vtable as const PACKFILE_VTABLE ptr, byval userdata as any ptr) as PACKFILE ptr
declare function pack_fclose(byval f as PACKFILE ptr) as long
declare function pack_fseek(byval f as PACKFILE ptr, byval offset as long) as long
declare function pack_fopen_chunk(byval f as PACKFILE ptr, byval pack as long) as PACKFILE ptr
declare function pack_fclose_chunk(byval f as PACKFILE ptr) as PACKFILE ptr
declare function pack_getc(byval f as PACKFILE ptr) as long
declare function pack_putc(byval c as long, byval f as PACKFILE ptr) as long
declare function pack_feof(byval f as PACKFILE ptr) as long
declare function pack_ferror(byval f as PACKFILE ptr) as long
declare function pack_igetw(byval f as PACKFILE ptr) as long
declare function pack_igetl(byval f as PACKFILE ptr) as clong
declare function pack_iputw(byval w as long, byval f as PACKFILE ptr) as long
declare function pack_iputl(byval l as clong, byval f as PACKFILE ptr) as clong
declare function pack_mgetw(byval f as PACKFILE ptr) as long
declare function pack_mgetl(byval f as PACKFILE ptr) as clong
declare function pack_mputw(byval w as long, byval f as PACKFILE ptr) as long
declare function pack_mputl(byval l as clong, byval f as PACKFILE ptr) as clong
declare function pack_fread(byval p as any ptr, byval n as clong, byval f as PACKFILE ptr) as clong
declare function pack_fwrite(byval p as const any ptr, byval n as clong, byval f as PACKFILE ptr) as clong
declare function pack_ungetc(byval c as long, byval f as PACKFILE ptr) as long
declare function pack_fgets(byval p as zstring ptr, byval max as long, byval f as PACKFILE ptr) as zstring ptr
declare function pack_fputs(byval p as const zstring ptr, byval f as PACKFILE ptr) as long
declare function pack_get_userdata(byval f as PACKFILE ptr) as any ptr
#define ALLEGRO_LZSS_H
declare function create_lzss_pack_data() as LZSS_PACK_DATA ptr
declare sub free_lzss_pack_data(byval dat as LZSS_PACK_DATA ptr)
declare function lzss_write(byval file as PACKFILE ptr, byval dat as LZSS_PACK_DATA ptr, byval size as long, byval buf as ubyte ptr, byval last as long) as long
declare function create_lzss_unpack_data() as LZSS_UNPACK_DATA ptr
declare sub free_lzss_unpack_data(byval dat as LZSS_UNPACK_DATA ptr)
declare function lzss_read(byval file as PACKFILE ptr, byval dat as LZSS_UNPACK_DATA ptr, byval s as long, byval buf as ubyte ptr) as long

#define ALLEGRO_DATAFILE_H
#define DAT_ID(a, b, c, d) AL_ID(a, b, c, d)
#define DAT_MAGIC DAT_ID(asc("A"), asc("L"), asc("L"), asc("."))
#define DAT_FILE DAT_ID(asc("F"), asc("I"), asc("L"), asc("E"))
#define DAT_DATA DAT_ID(asc("D"), asc("A"), asc("T"), asc("A"))
#define DAT_FONT DAT_ID(asc("F"), asc("O"), asc("N"), asc("T"))
#define DAT_SAMPLE DAT_ID(asc("S"), asc("A"), asc("M"), asc("P"))
#define DAT_MIDI DAT_ID(asc("M"), asc("I"), asc("D"), asc("I"))
#define DAT_PATCH DAT_ID(asc("P"), asc("A"), asc("T"), asc(" "))
#define DAT_FLI DAT_ID(asc("F"), asc("L"), asc("I"), asc("C"))
#define DAT_BITMAP DAT_ID(asc("B"), asc("M"), asc("P"), asc(" "))
#define DAT_RLE_SPRITE DAT_ID(asc("R"), asc("L"), asc("E"), asc(" "))
#define DAT_C_SPRITE DAT_ID(asc("C"), asc("M"), asc("P"), asc(" "))
#define DAT_XC_SPRITE DAT_ID(asc("X"), asc("C"), asc("M"), asc("P"))
#define DAT_PALETTE DAT_ID(asc("P"), asc("A"), asc("L"), asc(" "))
#define DAT_PROPERTY DAT_ID(asc("p"), asc("r"), asc("o"), asc("p"))
#define DAT_NAME DAT_ID(asc("N"), asc("A"), asc("M"), asc("E"))
const DAT_END = -1

type DATAFILE_PROPERTY
	dat as zstring ptr
	as long type
end type

type DATAFILE
	dat as any ptr
	as long type
	size as clong
	prop as DATAFILE_PROPERTY ptr
end type

type DATAFILE_INDEX
	filename as zstring ptr
	offset as clong ptr
end type

declare function load_datafile(byval filename as const zstring ptr) as DATAFILE ptr
declare function load_datafile_callback(byval filename as const zstring ptr, byval callback as sub(byval as DATAFILE ptr)) as DATAFILE ptr
declare function create_datafile_index(byval filename as const zstring ptr) as DATAFILE_INDEX ptr
declare sub unload_datafile(byval dat as DATAFILE ptr)
declare sub destroy_datafile_index(byval index as DATAFILE_INDEX ptr)
declare function load_datafile_object(byval filename as const zstring ptr, byval objectname as const zstring ptr) as DATAFILE ptr
declare function load_datafile_object_indexed(byval index as const DATAFILE_INDEX ptr, byval item as long) as DATAFILE ptr
declare sub unload_datafile_object(byval dat as DATAFILE ptr)
declare function find_datafile_object(byval dat as const DATAFILE ptr, byval objectname as const zstring ptr) as DATAFILE ptr
declare function get_datafile_property(byval dat as const DATAFILE ptr, byval type as long) as const zstring ptr
declare sub register_datafile_object(byval id_ as long, byval load as function(byval f as PACKFILE ptr, byval size as clong) as any ptr, byval destroy as sub(byval data as any ptr))
declare sub fixup_datafile(byval data as DATAFILE ptr)
declare function load_bitmap(byval filename as const zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_bmp(byval filename as const zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_bmp_pf(byval f as PACKFILE ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_lbm(byval filename as const zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_pcx(byval filename as const zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_pcx_pf(byval f as PACKFILE ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_tga(byval filename as const zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_tga_pf(byval f as PACKFILE ptr, byval pal as RGB ptr) as BITMAP ptr
declare function save_bitmap(byval filename as const zstring ptr, byval bmp as BITMAP ptr, byval pal as const RGB ptr) as long
declare function save_bmp(byval filename as const zstring ptr, byval bmp as BITMAP ptr, byval pal as const RGB ptr) as long
declare function save_bmp_pf(byval f as PACKFILE ptr, byval bmp as BITMAP ptr, byval pal as const RGB ptr) as long
declare function save_pcx(byval filename as const zstring ptr, byval bmp as BITMAP ptr, byval pal as const RGB ptr) as long
declare function save_pcx_pf(byval f as PACKFILE ptr, byval bmp as BITMAP ptr, byval pal as const RGB ptr) as long
declare function save_tga(byval filename as const zstring ptr, byval bmp as BITMAP ptr, byval pal as const RGB ptr) as long
declare function save_tga_pf(byval f as PACKFILE ptr, byval bmp as BITMAP ptr, byval pal as const RGB ptr) as long
declare sub register_bitmap_file_type(byval ext as const zstring ptr, byval load as function(byval filename as const zstring ptr, byval pal as RGB ptr) as BITMAP ptr, byval save as function(byval filename as const zstring ptr, byval bmp as BITMAP ptr, byval pal as const RGB ptr) as long)
#define ALLEGRO_FMATH_H
declare function fixsqrt(byval x as fixed) as fixed
declare function fixhypot(byval x as fixed, byval y as fixed) as fixed
declare function fixatan(byval x as fixed) as fixed
declare function fixatan2(byval y as fixed, byval x as fixed) as fixed

#define _cos_tbl(i) ((@___cos_tbl)[i])
extern _AL_DLL ___cos_tbl alias "_cos_tbl" as fixed
#define _tan_tbl(i) ((@___tan_tbl)[i])
extern _AL_DLL ___tan_tbl alias "_tan_tbl" as fixed
#define _acos_tbl(i) ((@___acos_tbl)[i])
extern _AL_DLL ___acos_tbl alias "_acos_tbl" as fixed

#define ALLEGRO_FMATHS_INL
#define ALLEGRO_IMPORT_MATH_ASM
#define ALLEGRO_USE_C
#undef ALLEGRO_IMPORT_MATH_ASM

declare function ftofix(byval x as double) as fixed
declare function fixtof(byval x as fixed) as double
declare function fixadd(byval x as fixed, byval y as fixed) as fixed
declare function fixsub(byval x as fixed, byval y as fixed) as fixed
declare function fixmul(byval x as fixed, byval y as fixed) as fixed
declare function fixdiv(byval x as fixed, byval y as fixed) as fixed
declare function fixfloor(byval x as fixed) as long
declare function fixceil(byval x as fixed) as long
declare function itofix(byval x as long) as fixed
declare function fixtoi(byval x as fixed) as long
declare function fixcos(byval x as fixed) as fixed
declare function fixsin(byval x as fixed) as fixed
declare function fixtan(byval x as fixed) as fixed
declare function fixacos(byval x as fixed) as fixed
declare function fixasin(byval x as fixed) as fixed
#define ALLEGRO_MATRIX_H

type MATRIX
	v(0 to 2, 0 to 2) as fixed
	t(0 to 2) as fixed
end type

type MATRIX_f
	v(0 to 2, 0 to 2) as single
	t(0 to 2) as single
end type

extern _AL_DLL identity_matrix as MATRIX
extern _AL_DLL identity_matrix_f as MATRIX_f

declare sub get_translation_matrix(byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed)
declare sub get_translation_matrix_f(byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single)
declare sub get_scaling_matrix(byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed)
declare sub get_scaling_matrix_f(byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single)
declare sub get_x_rotate_matrix(byval m as MATRIX ptr, byval r as fixed)
declare sub get_x_rotate_matrix_f(byval m as MATRIX_f ptr, byval r as single)
declare sub get_y_rotate_matrix(byval m as MATRIX ptr, byval r as fixed)
declare sub get_y_rotate_matrix_f(byval m as MATRIX_f ptr, byval r as single)
declare sub get_z_rotate_matrix(byval m as MATRIX ptr, byval r as fixed)
declare sub get_z_rotate_matrix_f(byval m as MATRIX_f ptr, byval r as single)
declare sub get_rotation_matrix(byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed)
declare sub get_rotation_matrix_f(byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single)
declare sub get_align_matrix(byval m as MATRIX ptr, byval xfront as fixed, byval yfront as fixed, byval zfront as fixed, byval xup as fixed, byval yup as fixed, byval zup as fixed)
declare sub get_align_matrix_f(byval m as MATRIX_f ptr, byval xfront as single, byval yfront as single, byval zfront as single, byval xup as single, byval yup as single, byval zup as single)
declare sub get_vector_rotation_matrix(byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed, byval a as fixed)
declare sub get_vector_rotation_matrix_f(byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single, byval a as single)
declare sub get_transformation_matrix(byval m as MATRIX ptr, byval scale as fixed, byval xrot as fixed, byval yrot as fixed, byval zrot as fixed, byval x as fixed, byval y as fixed, byval z as fixed)
declare sub get_transformation_matrix_f(byval m as MATRIX_f ptr, byval scale as single, byval xrot as single, byval yrot as single, byval zrot as single, byval x as single, byval y as single, byval z as single)
declare sub get_camera_matrix(byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed, byval xfront as fixed, byval yfront as fixed, byval zfront as fixed, byval xup as fixed, byval yup as fixed, byval zup as fixed, byval fov as fixed, byval aspect as fixed)
declare sub get_camera_matrix_f(byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single, byval xfront as single, byval yfront as single, byval zfront as single, byval xup as single, byval yup as single, byval zup as single, byval fov as single, byval aspect as single)
declare sub qtranslate_matrix(byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed)
declare sub qtranslate_matrix_f(byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single)
declare sub qscale_matrix(byval m as MATRIX ptr, byval scale as fixed)
declare sub qscale_matrix_f(byval m as MATRIX_f ptr, byval scale as single)
declare sub matrix_mul(byval m1 as const MATRIX ptr, byval m2 as const MATRIX ptr, byval out as MATRIX ptr)
declare sub matrix_mul_f(byval m1 as const MATRIX_f ptr, byval m2 as const MATRIX_f ptr, byval out as MATRIX_f ptr)
declare sub apply_matrix_f(byval m as const MATRIX_f ptr, byval x as single, byval y as single, byval z as single, byval xout as single ptr, byval yout as single ptr, byval zout as single ptr)
#define ALLEGRO_MATRIX_INL
declare sub apply_matrix(byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed, byval xout as fixed ptr, byval yout as fixed ptr, byval zout as fixed ptr)
#define ALLEGRO_QUAT_H

type QUAT
	w as single
	x as single
	y as single
	z as single
end type

extern _AL_DLL identity_quat as QUAT

declare sub quat_mul(byval p as const QUAT ptr, byval q as const QUAT ptr, byval out as QUAT ptr)
declare sub get_x_rotate_quat(byval q as QUAT ptr, byval r as single)
declare sub get_y_rotate_quat(byval q as QUAT ptr, byval r as single)
declare sub get_z_rotate_quat(byval q as QUAT ptr, byval r as single)
declare sub get_rotation_quat(byval q as QUAT ptr, byval x as single, byval y as single, byval z as single)
declare sub get_vector_rotation_quat(byval q as QUAT ptr, byval x as single, byval y as single, byval z as single, byval a as single)
declare sub apply_quat(byval q as const QUAT ptr, byval x as single, byval y as single, byval z as single, byval xout as single ptr, byval yout as single ptr, byval zout as single ptr)
declare sub quat_slerp(byval from as const QUAT ptr, byval to as const QUAT ptr, byval t as single, byval out as QUAT ptr, byval how as long)

const QUAT_SHORT = 0
const QUAT_LONG = 1
const QUAT_CW = 2
const QUAT_CCW = 3
const QUAT_USER = 4
#define quat_interpolate(from, to, t, out) quat_slerp((from), (to), (t), (out), QUAT_SHORT)
#define ALLEGRO_3DMATHS_H

declare function vector_length(byval x as fixed, byval y as fixed, byval z as fixed) as fixed
declare function vector_length_f(byval x as single, byval y as single, byval z as single) as single
declare sub normalize_vector(byval x as fixed ptr, byval y as fixed ptr, byval z as fixed ptr)
declare sub normalize_vector_f(byval x as single ptr, byval y as single ptr, byval z as single ptr)
declare sub cross_product(byval x1 as fixed, byval y_1 as fixed, byval z1 as fixed, byval x2 as fixed, byval y2 as fixed, byval z2 as fixed, byval xout as fixed ptr, byval yout as fixed ptr, byval zout as fixed ptr)
declare sub cross_product_f(byval x1 as single, byval y_1 as single, byval z1 as single, byval x2 as single, byval y2 as single, byval z2 as single, byval xout as single ptr, byval yout as single ptr, byval zout as single ptr)

extern _AL_DLL _persp_xscale as fixed
extern _AL_DLL _persp_yscale as fixed
extern _AL_DLL _persp_xoffset as fixed
extern _AL_DLL _persp_yoffset as fixed
extern _AL_DLL _persp_xscale_f as single
extern _AL_DLL _persp_yscale_f as single
extern _AL_DLL _persp_xoffset_f as single
extern _AL_DLL _persp_yoffset_f as single

declare sub set_projection_viewport(byval x as long, byval y as long, byval w as long, byval h as long)
declare sub quat_to_matrix(byval q as const QUAT ptr, byval m as MATRIX_f ptr)
declare sub matrix_to_quat(byval m as const MATRIX_f ptr, byval q as QUAT ptr)
#define ALLEGRO_3DMATHS_INL
declare function dot_product(byval x1 as fixed, byval y_1 as fixed, byval z1 as fixed, byval x2 as fixed, byval y2 as fixed, byval z2 as fixed) as fixed
declare function dot_product_f(byval x1 as single, byval y_1 as single, byval z1 as single, byval x2 as single, byval y2 as single, byval z2 as single) as single
declare sub persp_project(byval x as fixed, byval y as fixed, byval z as fixed, byval xout as fixed ptr, byval yout as fixed ptr)
declare sub persp_project_f(byval x as single, byval y as single, byval z as single, byval xout as single ptr, byval yout as single ptr)

#define ALLEGRO_COMPAT_H
const KB_NORMAL = 1
const KB_EXTENDED = 2
declare function SEND_MESSAGE alias "object_message"(byval dialog as DIALOG ptr, byval msg as long, byval c as long) as long
#define cpu_fpu_ (cpu_capabilities and CPU_FPU)
#define cpu_mmx_ (cpu_capabilities and CPU_MMX)
#define cpu_3dnow_ (cpu_capabilities and CPU_3DNOW)
#define cpu_cpuid (cpu_capabilities and CPU_ID)
#define joy_x joy[0].stick[0].axis[0].pos
#define joy_y joy[0].stick[0].axis[1].pos
#define joy_left joy[0].stick[0].axis[0].d1
#define joy_right joy[0].stick[0].axis[0].d2
#define joy_up joy[0].stick[0].axis[1].d1
#define joy_down joy[0].stick[0].axis[1].d2
#define joy_b1 joy[0].button[0].b
#define joy_b2 joy[0].button[1].b
#define joy_b3 joy[0].button[2].b
#define joy_b4 joy[0].button[3].b
#define joy_b5 joy[0].button[4].b
#define joy_b6 joy[0].button[5].b
#define joy_b7 joy[0].button[6].b
#define joy_b8 joy[0].button[7].b
#define joy2_x joy[1].stick[0].axis[0].pos
#define joy2_y joy[1].stick[0].axis[1].pos
#define joy2_left joy[1].stick[0].axis[0].d1
#define joy2_right joy[1].stick[0].axis[0].d2
#define joy2_up joy[1].stick[0].axis[1].d1
#define joy2_down joy[1].stick[0].axis[1].d2
#define joy2_b1 joy[1].button[0].b
#define joy2_b2 joy[1].button[1].b
#define joy_throttle joy[0].stick[2].axis[0].pos
#define joy_hat iif(joy[0].stick[1].axis[0].d1, 1, iif(joy[0].stick[1].axis[0].d2, 3, iif(joy[0].stick[1].axis[1].d1, 4, iif(joy[0].stick[1].axis[1].d2, 2, 0))))
const JOY_HAT_CENTRE = 0
const JOY_HAT_CENTER = 0
const JOY_HAT_LEFT = 1
const JOY_HAT_DOWN = 2
const JOY_HAT_RIGHT = 3
const JOY_HAT_UP = 4
declare function initialise_joystick() as long

#if defined(__FB_WIN32__) and (not defined(ALLEGRO_STATICLINK))
	extern import black_pallete(0 to 255) alias "black_palette" as RGB
	extern import desktop_pallete(0 to 255) alias "desktop_palette" as RGB
#else
	extern black_pallete(0 to 255) alias "black_palette" as RGB
	extern desktop_pallete(0 to 255) alias "desktop_palette" as RGB
#endif

declare sub set_pallete alias "set_palette"(byval p as const RGB ptr)
declare sub get_pallete alias "get_palette"(byval p as RGB ptr)
declare sub set_pallete_range alias "set_palette_range"(byval p as const RGB ptr, byval from as long, byval to as long, byval retracesync as long)
declare sub get_pallete_range alias "get_palette_range"(byval p as RGB ptr, byval from as long, byval to as long)

#if defined(__FB_WIN32__) and (not defined(ALLEGRO_STATICLINK))
	extern import fli_pallete(0 to 255) alias "fli_palette" as RGB
	extern import pallete_color alias "palette_color" as long ptr
#else
	extern fli_pallete(0 to 255) alias "fli_palette" as RGB
	extern pallete_color alias "palette_color" as long ptr
#endif

#define DAT_PALLETE DAT_PALETTE
declare sub select_pallete alias "select_palette"(byval p as const RGB ptr)
declare sub unselect_pallete alias "unselect_palette"()
declare sub generate_332_pallete alias "generate_332_palette"(byval pal as RGB ptr)
#define generate_optimised_pallete generate_optimised_palette
declare function fix_filename_path alias "canonicalize_filename"(byval dest as zstring ptr, byval filename as const zstring ptr, byval size as long) as zstring ptr
const OLD_FILESEL_WIDTH = -1
const OLD_FILESEL_HEIGHT = -1
declare function file_select(byval message as const zstring ptr, byval path as zstring ptr, byval ext as const zstring ptr) as long
declare function for_each_file(byval name as const zstring ptr, byval attrib as long, byval callback as sub(byval filename as const zstring ptr, byval attrib as long, byval param as long), byval param as long) as long
declare function file_size(byval filename as const zstring ptr) as clong

extern _AL_DLL _textmode as long

declare function text_mode(byval mode as long) as long
declare sub textout(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval str as const zstring ptr, byval x as long, byval y as long, byval color as long)
declare sub textout_centre(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval str as const zstring ptr, byval x as long, byval y as long, byval color as long)
declare sub textout_right(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval str as const zstring ptr, byval x as long, byval y as long, byval color as long)
declare sub textout_justify(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval str as const zstring ptr, byval x1 as long, byval x2 as long, byval y as long, byval diff as long, byval color as long)
declare sub textprintf(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval x as long, byval y as long, byval color as long, byval format as const zstring ptr, ...)
declare sub textprintf_centre(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval x as long, byval y as long, byval color as long, byval format as const zstring ptr, ...)
declare sub textprintf_right(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval x as long, byval y as long, byval color as long, byval format as const zstring ptr, ...)
declare sub textprintf_justify(byval bmp as BITMAP ptr, byval f as const FONT ptr, byval x1 as long, byval x2 as long, byval y as long, byval diff as long, byval color as long, byval format as const zstring ptr, ...)
declare sub draw_character(byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as long, byval y as long, byval color as long)
declare function gui_textout(byval bmp as BITMAP ptr, byval s as const zstring ptr, byval x as long, byval y as long, byval color as long, byval centre as long) as long
declare function set_window_close_button(byval enable as long) as long
declare sub set_window_close_hook(byval proc as sub())
declare sub set_clip(byval bitmap as BITMAP ptr, byval x1 as long, byval y_1 as long, byval x2 as long, byval y2 as long)
declare sub yield_timeslice()

extern _AL_DLL retrace_proc as sub()

declare sub set_file_encoding(byval encoding as long)
declare function get_file_encoding() as long
declare function timer_can_simulate_retrace() as long
declare sub timer_simulate_retrace(byval enable as long)
declare function timer_is_using_retrace() as long

#ifdef __FB_UNIX__
	extern __crt0_argc as long
	extern __crt0_argv as zstring ptr ptr
	#define TIMERDRV_UNIX_PTHREADS_ AL_ID(asc("P"), asc("T"), asc("H"), asc("R"))
	#define TIMERDRV_UNIX_SIGALRM AL_ID(asc("A"), asc("L"), asc("R"), asc("M"))
	extern timerdrv_unix_pthreads as TIMER_DRIVER
	#define DIGI_OSS AL_ID(asc("O"), asc("S"), asc("S"), asc("D"))
	#define MIDI_OSS AL_ID(asc("O"), asc("S"), asc("S"), asc("M"))
	#define DIGI_ESD AL_ID(asc("E"), asc("S"), asc("D"), asc("D"))
	#define DIGI_ARTS AL_ID(asc("A"), asc("R"), asc("T"), asc("S"))
	#define DIGI_SGIAL AL_ID(asc("S"), asc("G"), asc("I"), asc("A"))
	#define DIGI_ALSA AL_ID(asc("A"), asc("L"), asc("S"), asc("A"))
	#define MIDI_ALSA AL_ID(asc("A"), asc("M"), asc("I"), asc("D"))
	#define DIGI_JACK AL_ID(asc("J"), asc("A"), asc("C"), asc("K"))
	#define SYSTEM_XWINDOWS AL_ID(asc("X"), asc("W"), asc("I"), asc("N"))
	#define KEYBOARD_XWINDOWS AL_ID(asc("X"), asc("W"), asc("I"), asc("N"))
	#define MOUSE_XWINDOWS AL_ID(asc("X"), asc("W"), asc("I"), asc("N"))
	#define GFX_XWINDOWS AL_ID(asc("X"), asc("W"), asc("I"), asc("N"))
	#define GFX_XWINDOWS_FULLSCREEN AL_ID(asc("X"), asc("W"), asc("F"), asc("S"))
	#define GFX_XDGA AL_ID(asc("X"), asc("D"), asc("G"), asc("A"))
	#define GFX_XDGA_FULLSCREEN AL_ID(asc("X"), asc("D"), asc("F"), asc("S"))
	#define GFX_XDGA2 AL_ID(asc("D"), asc("G"), asc("A"), asc("2"))
	#define GFX_XDGA2_SOFT AL_ID(asc("D"), asc("G"), asc("A"), asc("S"))
	#define SYSTEM_LINUX_ AL_ID(asc("L"), asc("N"), asc("X"), asc("C"))
#elseif defined(__FB_DOS__)
	#define SYSTEM_DOS_ AL_ID(asc("D"), asc("O"), asc("S"), asc(" "))
	extern system_dos as SYSTEM_DRIVER
	extern i_love_bill as long
	#define KEYDRV_PCDOS_ AL_ID(asc("P"), asc("C"), asc("K"), asc("B"))
	extern keydrv_pcdos as KEYBOARD_DRIVER
	#define TIMEDRV_FIXED_RATE_ AL_ID(asc("F"), asc("I"), asc("X"), asc("T"))
	#define TIMEDRV_VARIABLE_RATE_ AL_ID(asc("V"), asc("A"), asc("R"), asc("T"))
	extern timedrv_fixed_rate as TIMER_DRIVER
	extern timedrv_variable_rate as TIMER_DRIVER
	#define MOUSEDRV_MICKEYS_ AL_ID(asc("M"), asc("I"), asc("C"), asc("K"))
	#define MOUSEDRV_INT33_ AL_ID(asc("I"), asc("3"), asc("3"), asc(" "))
	#define MOUSEDRV_POLLING_ AL_ID(asc("P"), asc("O"), asc("L"), asc("L"))
	#define MOUSEDRV_WINNT_ AL_ID(asc("W"), asc("N"), asc("T"), asc(" "))
	#define MOUSEDRV_WIN2K_ AL_ID(asc("W"), asc("2"), asc("K"), asc(" "))
	extern mousedrv_mickeys as MOUSE_DRIVER
	extern mousedrv_int33 as MOUSE_DRIVER
	extern mousedrv_polling as MOUSE_DRIVER
	extern mousedrv_winnt as MOUSE_DRIVER
	extern mousedrv_win2k as MOUSE_DRIVER
	#define JOY_TYPE_STANDARD AL_ID(asc("S"), asc("T"), asc("D"), asc(" "))
	#define JOY_TYPE_2PADS AL_ID(asc("2"), asc("P"), asc("A"), asc("D"))
	#define JOY_TYPE_4BUTTON AL_ID(asc("4"), asc("B"), asc("U"), asc("T"))
	#define JOY_TYPE_6BUTTON AL_ID(asc("6"), asc("B"), asc("U"), asc("T"))
	#define JOY_TYPE_8BUTTON AL_ID(asc("8"), asc("B"), asc("U"), asc("T"))
	#define JOY_TYPE_FSPRO AL_ID(asc("F"), asc("P"), asc("R"), asc("O"))
	#define JOY_TYPE_WINGEX AL_ID(asc("W"), asc("I"), asc("N"), asc("G"))
	#define JOY_TYPE_SIDEWINDER AL_ID(asc("S"), asc("W"), asc(" "), asc(" "))
	#define JOY_TYPE_SIDEWINDER_AG AL_ID(asc("S"), asc("W"), asc("A"), asc("G"))
	#define JOY_TYPE_SIDEWINDER_PP AL_ID(asc("S"), asc("W"), asc("P"), asc("P"))
	#define JOY_TYPE_GAMEPAD_PRO AL_ID(asc("G"), asc("P"), asc("R"), asc("O"))
	#define JOY_TYPE_GRIP AL_ID(asc("G"), asc("R"), asc("I"), asc("P"))
	#define JOY_TYPE_GRIP4 AL_ID(asc("G"), asc("R"), asc("I"), asc("4"))
	#define JOY_TYPE_SNESPAD_LPT1 AL_ID(asc("S"), asc("N"), asc("E"), asc("1"))
	#define JOY_TYPE_SNESPAD_LPT2 AL_ID(asc("S"), asc("N"), asc("E"), asc("2"))
	#define JOY_TYPE_SNESPAD_LPT3 AL_ID(asc("S"), asc("N"), asc("E"), asc("3"))
	#define JOY_TYPE_PSXPAD_LPT1 AL_ID(asc("P"), asc("S"), asc("X"), asc("1"))
	#define JOY_TYPE_PSXPAD_LPT2 AL_ID(asc("P"), asc("S"), asc("X"), asc("2"))
	#define JOY_TYPE_PSXPAD_LPT3 AL_ID(asc("P"), asc("S"), asc("X"), asc("3"))
	#define JOY_TYPE_N64PAD_LPT1 AL_ID(asc("N"), asc("6"), asc("4"), asc("1"))
	#define JOY_TYPE_N64PAD_LPT2 AL_ID(asc("N"), asc("6"), asc("4"), asc("2"))
	#define JOY_TYPE_N64PAD_LPT3 AL_ID(asc("N"), asc("6"), asc("4"), asc("3"))
	#define JOY_TYPE_DB9_LPT1 AL_ID(asc("D"), asc("B"), asc("9"), asc("1"))
	#define JOY_TYPE_DB9_LPT2 AL_ID(asc("D"), asc("B"), asc("9"), asc("2"))
	#define JOY_TYPE_DB9_LPT3 AL_ID(asc("D"), asc("B"), asc("9"), asc("3"))
	#define JOY_TYPE_TURBOGRAFX_LPT1 AL_ID(asc("T"), asc("G"), asc("X"), asc("1"))
	#define JOY_TYPE_TURBOGRAFX_LPT2 AL_ID(asc("T"), asc("G"), asc("X"), asc("2"))
	#define JOY_TYPE_TURBOGRAFX_LPT3 AL_ID(asc("T"), asc("G"), asc("X"), asc("3"))
	#define JOY_TYPE_IFSEGA_ISA AL_ID(asc("S"), asc("E"), asc("G"), asc("I"))
	#define JOY_TYPE_IFSEGA_PCI AL_ID(asc("S"), asc("E"), asc("G"), asc("P"))
	#define JOY_TYPE_IFSEGA_PCI_FAST AL_ID(asc("S"), asc("G"), asc("P"), asc("F"))
	#define JOY_TYPE_WINGWARRIOR AL_ID(asc("W"), asc("W"), asc("A"), asc("R"))
	extern joystick_standard as JOYSTICK_DRIVER
	extern joystick_2pads as JOYSTICK_DRIVER
	extern joystick_4button as JOYSTICK_DRIVER
	extern joystick_6button as JOYSTICK_DRIVER
	extern joystick_8button as JOYSTICK_DRIVER
	extern joystick_fspro as JOYSTICK_DRIVER
	extern joystick_wingex as JOYSTICK_DRIVER
	extern joystick_sw as JOYSTICK_DRIVER
	extern joystick_sw_ag as JOYSTICK_DRIVER
	extern joystick_sw_pp as JOYSTICK_DRIVER
	extern joystick_gpro as JOYSTICK_DRIVER
	extern joystick_grip as JOYSTICK_DRIVER
	extern joystick_grip4 as JOYSTICK_DRIVER
	extern joystick_sp1 as JOYSTICK_DRIVER
	extern joystick_sp2 as JOYSTICK_DRIVER
	extern joystick_sp3 as JOYSTICK_DRIVER
	extern joystick_psx1 as JOYSTICK_DRIVER
	extern joystick_psx2 as JOYSTICK_DRIVER
	extern joystick_psx3 as JOYSTICK_DRIVER
	extern joystick_n641 as JOYSTICK_DRIVER
	extern joystick_n642 as JOYSTICK_DRIVER
	extern joystick_n643 as JOYSTICK_DRIVER
	extern joystick_db91 as JOYSTICK_DRIVER
	extern joystick_db92 as JOYSTICK_DRIVER
	extern joystick_db93 as JOYSTICK_DRIVER
	extern joystick_tgx1 as JOYSTICK_DRIVER
	extern joystick_tgx2 as JOYSTICK_DRIVER
	extern joystick_tgx3 as JOYSTICK_DRIVER
	extern joystick_sg1 as JOYSTICK_DRIVER
	extern joystick_sg2 as JOYSTICK_DRIVER
	extern joystick_sg2f as JOYSTICK_DRIVER
	extern joystick_ww as JOYSTICK_DRIVER
	#define JOYSTICK_DRIVER_STANDARD ( JOY_TYPE_STANDARD, @joystick_standard, TRUE ), ( JOY_TYPE_2PADS, @joystick_2pads, FALSE ), ( JOY_TYPE_4BUTTON, @joystick_4button, FALSE ), ( JOY_TYPE_6BUTTON, @joystick_6button, FALSE ), ( JOY_TYPE_8BUTTON, @joystick_8button, FALSE ), ( JOY_TYPE_FSPRO, @joystick_fspro, FALSE ), ( JOY_TYPE_WINGEX, @joystick_wingex, FALSE ),
	#define JOYSTICK_DRIVER_SIDEWINDER ( JOY_TYPE_SIDEWINDER, @joystick_sw, TRUE ), ( JOY_TYPE_SIDEWINDER_AG, @joystick_sw_ag, TRUE ), ( JOY_TYPE_SIDEWINDER_PP, @joystick_sw_pp, TRUE ),
	#define JOYSTICK_DRIVER_GAMEPAD_PRO ( JOY_TYPE_GAMEPAD_PRO, @joystick_gpro, TRUE ),
	#define JOYSTICK_DRIVER_GRIP ( JOY_TYPE_GRIP, @joystick_grip, TRUE ), ( JOY_TYPE_GRIP4, @joystick_grip4, TRUE ),
	#define JOYSTICK_DRIVER_SNESPAD ( JOY_TYPE_SNESPAD_LPT1, @joystick_sp1, FALSE ), ( JOY_TYPE_SNESPAD_LPT2, @joystick_sp2, FALSE ), ( JOY_TYPE_SNESPAD_LPT3, @joystick_sp3, FALSE ),
	#define JOYSTICK_DRIVER_PSXPAD ( JOY_TYPE_PSXPAD_LPT1, @joystick_psx1, FALSE ), ( JOY_TYPE_PSXPAD_LPT2, @joystick_psx2, FALSE ), ( JOY_TYPE_PSXPAD_LPT3, @joystick_psx3, FALSE ),
	#define JOYSTICK_DRIVER_N64PAD ( JOY_TYPE_N64PAD_LPT1, @joystick_n641, FALSE ), ( JOY_TYPE_N64PAD_LPT2, @joystick_n642, FALSE ), ( JOY_TYPE_N64PAD_LPT3, @joystick_n643, FALSE ),
	#define JOYSTICK_DRIVER_DB9 ( JOY_TYPE_DB9_LPT1, @joystick_db91, FALSE ), ( JOY_TYPE_DB9_LPT2, @joystick_db92, FALSE ), ( JOY_TYPE_DB9_LPT3, @joystick_db93, FALSE ),
	#define JOYSTICK_DRIVER_TURBOGRAFX ( JOY_TYPE_TURBOGRAFX_LPT1,@joystick_tgx1, FALSE ), ( JOY_TYPE_TURBOGRAFX_LPT2,@joystick_tgx2, FALSE ), ( JOY_TYPE_TURBOGRAFX_LPT3,@joystick_tgx3, FALSE ),
	#define JOYSTICK_DRIVER_IFSEGA_ISA ( JOY_TYPE_IFSEGA_ISA, @joystick_sg1, FALSE ),
	#define JOYSTICK_DRIVER_IFSEGA_PCI ( JOY_TYPE_IFSEGA_PCI, @joystick_sg2, FALSE ),
	#define JOYSTICK_DRIVER_IFSEGA_PCI_FAST ( JOY_TYPE_IFSEGA_PCI_FAST,@joystick_sg2f, FALSE ),
	#define JOYSTICK_DRIVER_WINGWARRIOR ( JOY_TYPE_WINGWARRIOR, @joystick_ww, TRUE ),
	#define joy_FSPRO_trigger joy_b1
	#define joy_FSPRO_butleft joy_b2
	#define joy_FSPRO_butright joy_b3
	#define joy_FSPRO_butmiddle joy_b4
	#define joy_WINGEX_trigger joy_b1
	#define joy_WINGEX_buttop joy_b2
	#define joy_WINGEX_butthumb joy_b3
	#define joy_WINGEX_butmiddle joy_b4
	declare function calibrate_joystick_tl() as long
	declare function calibrate_joystick_br() as long
	declare function calibrate_joystick_throttle_min() as long
	declare function calibrate_joystick_throttle_max() as long
	declare function calibrate_joystick_hat(byval direction as long) as long
	#define ALLEGRO_GFX_HAS_VGA
	#define ALLEGRO_GFX_HAS_VBEAF
#endif

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	#define GFX_VGA_ AL_ID(asc("V"), asc("G"), asc("A"), asc(" "))
	#define GFX_MODEX_ AL_ID(asc("M"), asc("O"), asc("D"), asc("X"))
#endif

#ifdef __FB_UNIX__
	#define GFX_FBCON AL_ID(asc("F"), asc("B"), asc(" "), asc(" "))
#elseif defined(__FB_DOS__)
	#define GFX_VESA1 AL_ID(asc("V"), asc("B"), asc("E"), asc("1"))
	#define GFX_VESA2B AL_ID(asc("V"), asc("B"), asc("2"), asc("B"))
	#define GFX_VESA2L AL_ID(asc("V"), asc("B"), asc("2"), asc("L"))
	#define GFX_VESA3 AL_ID(asc("V"), asc("B"), asc("E"), asc("3"))
#endif

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	#define GFX_VBEAF_ AL_ID(asc("V"), asc("B"), asc("A"), asc("F"))
#endif

#ifdef __FB_UNIX__
	#define GFX_SVGALIB AL_ID(asc("S"), asc("V"), asc("G"), asc("A"))
	#define KEYDRV_LINUX AL_ID(asc("L"), asc("N"), asc("X"), asc("C"))
	#define MOUSEDRV_LINUX_PS2_ AL_ID(asc("L"), asc("P"), asc("S"), asc("2"))
	#define MOUSEDRV_LINUX_IPS2_ AL_ID(asc("L"), asc("I"), asc("P"), asc("S"))
	#define MOUSEDRV_LINUX_GPMDATA_ AL_ID(asc("G"), asc("P"), asc("M"), asc("D"))
	#define MOUSEDRV_LINUX_MS_ AL_ID(asc("M"), asc("S"), asc(" "), asc(" "))
	#define MOUSEDRV_LINUX_IMS_ AL_ID(asc("I"), asc("M"), asc("S"), asc(" "))
	#define MOUSEDRV_LINUX_EVDEV_ AL_ID(asc("E"), asc("V"), asc(" "), asc(" "))
	#define JOY_TYPE_LINUX_ANALOGUE AL_ID(asc("L"), asc("N"), asc("X"), asc("A"))
#endif

#ifdef __FB_LINUX__
	extern system_linux as SYSTEM_DRIVER
	extern mousedrv_linux_ps2 as MOUSE_DRIVER
	extern mousedrv_linux_ips2 as MOUSE_DRIVER
	extern mousedrv_linux_gpmdata as MOUSE_DRIVER
	extern mousedrv_linux_ms as MOUSE_DRIVER
	extern mousedrv_linux_ims as MOUSE_DRIVER
	extern mousedrv_linux_evdev as MOUSE_DRIVER
#elseif defined(__FB_DOS__)
	#define GFX_XTENDED_ AL_ID(asc("X"), asc("T"), asc("N"), asc("D"))
	extern gfx_vga as GFX_DRIVER
	extern gfx_modex as GFX_DRIVER
	extern gfx_vesa_1 as GFX_DRIVER
	extern gfx_vesa_2b as GFX_DRIVER
	extern gfx_vesa_2l as GFX_DRIVER
	extern gfx_vesa_3 as GFX_DRIVER
	extern gfx_vbeaf as GFX_DRIVER
	extern gfx_xtended as GFX_DRIVER
	#define GFX_DRIVER_VGA ( GFX_VGA, @gfx_vga, TRUE ),
	#define GFX_DRIVER_MODEX ( GFX_MODEX, @gfx_modex, TRUE ),
	#define GFX_DRIVER_VBEAF ( GFX_VBEAF, @gfx_vbeaf, TRUE ),
	#define GFX_DRIVER_VESA3 ( GFX_VESA3, @gfx_vesa_3, TRUE ),
	#define GFX_DRIVER_VESA2L ( GFX_VESA2L, @gfx_vesa_2l, TRUE ),
	#define GFX_DRIVER_VESA2B ( GFX_VESA2B, @gfx_vesa_2b, TRUE ),
	#define GFX_DRIVER_XTENDED ( GFX_XTENDED, @gfx_xtended, FALSE ),
	#define GFX_DRIVER_VESA1 ( GFX_VESA1, @gfx_vesa_1, TRUE ),
#endif

#if defined(__FB_DOS__) or defined(__FB_LINUX__)
	declare sub split_modex_screen(byval lyne as long)
#elseif defined(__FB_WIN32__)
	declare function _WinMain(byval _main as any ptr, byval hInst as any ptr, byval hPrev as any ptr, byval Cmd as zstring ptr, byval nShow as long) as long
	#define SYSTEM_DIRECTX_ AL_ID(asc("D"), asc("X"), asc(" "), asc(" "))
	extern _AL_DLL system_directx as SYSTEM_DRIVER
	#define TIMER_WIN32_HIGH_PERF AL_ID(asc("W"), asc("3"), asc("2"), asc("H"))
	#define TIMER_WIN32_LOW_PERF AL_ID(asc("W"), asc("3"), asc("2"), asc("L"))
	#define KEYBOARD_DIRECTX AL_ID(asc("D"), asc("X"), asc(" "), asc(" "))
	#define MOUSE_DIRECTX AL_ID(asc("D"), asc("X"), asc(" "), asc(" "))
	#define GFX_DIRECTX AL_ID(asc("D"), asc("X"), asc("A"), asc("C"))
	#define GFX_DIRECTX_ACCEL_ AL_ID(asc("D"), asc("X"), asc("A"), asc("C"))
	#define GFX_DIRECTX_SAFE_ AL_ID(asc("D"), asc("X"), asc("S"), asc("A"))
	#define GFX_DIRECTX_SOFT_ AL_ID(asc("D"), asc("X"), asc("S"), asc("O"))
	#define GFX_DIRECTX_WIN_ AL_ID(asc("D"), asc("X"), asc("W"), asc("N"))
	#define GFX_DIRECTX_OVL_ AL_ID(asc("D"), asc("X"), asc("O"), asc("V"))
	#define GFX_GDI_ AL_ID(asc("G"), asc("D"), asc("I"), asc("B"))
	extern _AL_DLL gfx_directx_accel as GFX_DRIVER
	extern _AL_DLL gfx_directx_safe as GFX_DRIVER
	extern _AL_DLL gfx_directx_soft as GFX_DRIVER
	extern _AL_DLL gfx_directx_win as GFX_DRIVER
	extern _AL_DLL gfx_directx_ovl as GFX_DRIVER
	extern _AL_DLL gfx_gdi as GFX_DRIVER
	#define GFX_DRIVER_DIRECTX ( GFX_DIRECTX_ACCEL, @gfx_directx_accel, TRUE ), ( GFX_DIRECTX_SOFT, @gfx_directx_soft, TRUE ), ( GFX_DIRECTX_SAFE, @gfx_directx_safe, TRUE ), ( GFX_DIRECTX_WIN, @gfx_directx_win, TRUE ), ( GFX_DIRECTX_OVL, @gfx_directx_ovl, TRUE ), ( GFX_GDI, @gfx_gdi, FALSE ),
	#define DIGI_DIRECTX(n) AL_ID(asc("D"), asc("X"), asc("A") + (n), asc(" "))
	#define DIGI_DIRECTAMX(n) AL_ID(asc("A"), asc("X"), asc("A") + (n), asc(" "))
	#define DIGI_WAVOUTID(n) AL_ID(asc("W"), asc("O"), asc("A") + (n), asc(" "))
	#define MIDI_WIN32MAPPER AL_ID(asc("W"), asc("3"), asc("2"), asc("M"))
	#define MIDI_WIN32(n) AL_ID(asc("W"), asc("3"), asc("2"), asc("A") + (n))
	#define MIDI_WIN32_IN(n) AL_ID(asc("W"), asc("3"), asc("2"), asc("A") + (n))
	#define JOY_TYPE_DIRECTX AL_ID(asc("D"), asc("X"), asc(" "), asc(" "))
	#define JOY_TYPE_WIN32 AL_ID(asc("W"), asc("3"), asc("2"), asc(" "))
	extern _AL_DLL joystick_directx as JOYSTICK_DRIVER
	extern _AL_DLL joystick_win32 as JOYSTICK_DRIVER
	#define JOYSTICK_DRIVER_DIRECTX ( JOY_TYPE_DIRECTX, @joystick_directx, TRUE ),
	#define JOYSTICK_DRIVER_WIN32 ( JOY_TYPE_WIN32, @joystick_win32, TRUE ),
#elseif defined(__FB_DOS__)
	declare sub _set_color(byval index as long, byval p as const RGB ptr)
	#define DIGI_SB10_ AL_ID(asc("S"), asc("B"), asc("1"), asc("0"))
	#define DIGI_SB15_ AL_ID(asc("S"), asc("B"), asc("1"), asc("5"))
	#define DIGI_SB20_ AL_ID(asc("S"), asc("B"), asc("2"), asc("0"))
	#define DIGI_SBPRO_ AL_ID(asc("S"), asc("B"), asc("P"), asc(" "))
	#define DIGI_SB16_ AL_ID(asc("S"), asc("B"), asc("1"), asc("6"))
	#define DIGI_AUDIODRIVE_ AL_ID(asc("E"), asc("S"), asc("S"), asc(" "))
	#define DIGI_SOUNDSCAPE_ AL_ID(asc("E"), asc("S"), asc("C"), asc(" "))
	#define DIGI_WINSOUNDSYS AL_ID(asc("W"), asc("S"), asc("S"), asc(" "))
	#define MIDI_OPL2_ AL_ID(asc("O"), asc("P"), asc("L"), asc("2"))
	#define MIDI_2XOPL2_ AL_ID(asc("O"), asc("P"), asc("L"), asc("X"))
	#define MIDI_OPL3_ AL_ID(asc("O"), asc("P"), asc("L"), asc("3"))
	#define MIDI_SB_OUT_ AL_ID(asc("S"), asc("B"), asc(" "), asc(" "))
	#define MIDI_MPU AL_ID(asc("M"), asc("P"), asc("U"), asc(" "))
	#define MIDI_AWE32_ AL_ID(asc("A"), asc("W"), asc("E"), asc(" "))
	extern digi_sb10 as DIGI_DRIVER
	extern digi_sb15 as DIGI_DRIVER
	extern digi_sb20 as DIGI_DRIVER
	extern digi_sbpro as DIGI_DRIVER
	extern digi_sb16 as DIGI_DRIVER
	extern digi_audiodrive as DIGI_DRIVER
	extern digi_soundscape as DIGI_DRIVER
	extern digi_wss as DIGI_DRIVER
	extern midi_opl2 as MIDI_DRIVER
	extern midi_2xopl2 as MIDI_DRIVER
	extern midi_opl3 as MIDI_DRIVER
	extern midi_sb_out as MIDI_DRIVER
	extern midi_mpu401 as MIDI_DRIVER
	extern midi_awe32 as MIDI_DRIVER
	#define DIGI_DRIVER_WINSOUNDSYS ( DIGI_WINSOUNDSYS, @digi_wss, FALSE ),
	#define DIGI_DRIVER_AUDIODRIVE ( DIGI_AUDIODRIVE, @digi_audiodrive, TRUE ),
	#define DIGI_DRIVER_SOUNDSCAPE ( DIGI_SOUNDSCAPE, @digi_soundscape, TRUE ),
	#define DIGI_DRIVER_SB ( DIGI_SB16, @digi_sb16, TRUE ), ( DIGI_SBPRO, @digi_sbpro, TRUE ), ( DIGI_SB20, @digi_sb20, TRUE ), ( DIGI_SB15, @digi_sb15, TRUE ), ( DIGI_SB10, @digi_sb10, TRUE ),
	#define MIDI_DRIVER_AWE32 ( MIDI_AWE32, @midi_awe32, TRUE ),
	#define MIDI_DRIVER_ADLIB ( MIDI_OPL3, @midi_opl3, TRUE ), ( MIDI_2XOPL2, @midi_2xopl2, TRUE ), ( MIDI_OPL2, @midi_opl2, TRUE ),
	#define MIDI_DRIVER_SB_OUT ( MIDI_SB_OUT, @midi_sb_out, FALSE ),
	#define MIDI_DRIVER_MPU ( MIDI_MPU, @midi_mpu401, FALSE ),
	declare function load_ibk(byval filename as const zstring ptr, byval drums as long) as long
#endif

end extern
