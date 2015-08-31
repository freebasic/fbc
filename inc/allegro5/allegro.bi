'' FreeBASIC binding for allegro-5.0.11
''
'' based on the C header files:
''   Copyright (c) 2004-2011 the Allegro 5 Development Team
''
''   This software is provided 'as-is', without any express or implied
''   warranty. In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''       1. The origin of this software must not be misrepresented; you must not
''       claim that you wrote the original software. If you use this software
''       in a product, an acknowledgment in the product documentation would be
''       appreciated but is not required.
''
''       2. Altered source versions must be plainly marked as such, and must not be
''       misrepresented as being the original software.
''
''       3. This notice may not be removed or altered from any source
''       distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __FB_UNIX__
	#inclib "allegro"
#elseif defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "allegro-5.0.10-static-md"
#else
	#inclib "allegro-5.0.10-md"
#endif

#include once "crt/errno.bi"
#include once "crt/limits.bi"
#include once "crt/stdarg.bi"
#include once "crt/stddef.bi"
#include once "crt/stdlib.bi"
#include once "crt/time.bi"
#include once "crt/string.bi"
#include once "crt/sys/types.bi"

'' The following symbols have been renamed:
''     #define EOF => EOF_

extern "C"

#define __al_included_allegro5_allegro_h
#define __al_included_allegro5_base_h

#if defined(__FB_WIN32__) and (not defined(ALLEGRO_STATICLINK))
	#define _AL_DLL import
#else
	#define _AL_DLL
#endif

#ifdef __FB_UNIX__
	const ALLEGRO_UNIX = 1
#else
	const ALLEGRO_MINGW32 = 1
#endif

const ALLEGRO_HAVE_DIRENT_H = 1
const ALLEGRO_HAVE_INTTYPES_H = 1

#ifdef __FB_LINUX__
	const ALLEGRO_HAVE_LINUX_AWE_VOICE_H = 1
	const ALLEGRO_HAVE_LINUX_INPUT_H = 1
	const ALLEGRO_HAVE_LINUX_JOYSTICK_H = 1
	const ALLEGRO_HAVE_LINUX_SOUNDCARD_H = 1
#endif

#ifdef __FB_UNIX__
	const ALLEGRO_HAVE_SOUNDCARD_H = 1
#endif

const ALLEGRO_HAVE_STDBOOL_H = 1
const ALLEGRO_HAVE_STDINT_H = 1

#ifdef __FB_UNIX__
	const ALLEGRO_HAVE_SV_PROCFS_H = 1
#endif

const ALLEGRO_HAVE_SYS_IO_H = 1

#ifdef __FB_UNIX__
	const ALLEGRO_HAVE_SYS_SOUNDCARD_H = 1
#endif

const ALLEGRO_HAVE_SYS_STAT_H = 1
const ALLEGRO_HAVE_SYS_TIME_H = 1
const ALLEGRO_HAVE_TIME_H = 1

#ifdef __FB_UNIX__
	const ALLEGRO_HAVE_SYS_UTSNAME_H = 1
#endif

const ALLEGRO_HAVE_SYS_TYPES_H = 1

#ifdef __FB_UNIX__
	const ALLEGRO_HAVE_OSATOMIC_H = 1
	const ALLEGRO_HAVE_SYS_INOTIFY_H = 1
	const ALLEGRO_HAVE_SYS_TIMERFD_H = 1
#endif

const ALLEGRO_HAVE_GETEXECNAME = 1
const ALLEGRO_HAVE_MKSTEMP = 1

#ifdef __FB_UNIX__
	const ALLEGRO_HAVE_MMAP = 1
	const ALLEGRO_HAVE_MPROTECT = 1
	const ALLEGRO_HAVE_SCHED_YIELD = 1
	const ALLEGRO_HAVE_SYSCONF = 1
#endif

const ALLEGRO_HAVE_FSEEKO = 1
const ALLEGRO_HAVE_FTELLO = 1
const ALLEGRO_HAVE_VA_COPY = 1
const ALLEGRO_LITTLE_ENDIAN = 1

#ifdef __FB_UNIX__
	const ALLEGRO_WITH_XWINDOWS = 1
	const ALLEGRO_XWINDOWS_WITH_XCURSOR = 1
	const ALLEGRO_XWINDOWS_WITH_XF86VIDMODE = 1
	const ALLEGRO_XWINDOWS_WITH_XINERAMA = 1
	const ALLEGRO_XWINDOWS_WITH_XRANDR = 1
	const ALLEGRO_XWINDOWS_WITH_XIM = 1
#endif

#ifdef __FB_LINUX__
	const ALLEGRO_LINUX = 1
#endif

#ifdef __FB_UNIX__
	#define ALLEGRO_PLATFORM_STR "Unix"
#elseif defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#define ALLEGRO_PLATFORM_STR "MinGW32.s"
#else
	#define ALLEGRO_PLATFORM_STR "MinGW32"
#endif

#ifdef __FB_WIN32__
	#define ALLEGRO_WINDOWS
	#define ALLEGRO_I386
#endif

#define __al_included_allegro5_astdint_h
#define __al_included_allegro5_astdbool_h
#define ALLEGRO_GCC

#if (not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_WIN32__))
	#define ALLEGRO_I386
#elseif defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_WIN32__))
	#define ALLEGRO_AMD64
#elseif (not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	#define ALLEGRO_ARM
#endif

#define READ3BYTES(p) (((*cptr(ubyte ptr, (p))) or ((*(cptr(ubyte ptr, (p)) + 1)) shl 8)) or ((*(cptr(ubyte ptr, (p)) + 2)) shl 16))
#macro WRITE3BYTES(p, c)
	scope
		(*cptr(ubyte ptr, (p))) = (c)
		(*(cptr(ubyte ptr, (p)) + 1)) = (c) shr 8
		(*(cptr(ubyte ptr, (p)) + 2)) = (c) shr 16
	end scope
#endmacro
#define bmp_write16(addr, c) scope : (*cptr(ushort ptr, (addr))) = (c) : end scope
#define bmp_write32(addr, c) scope : (*cptr(ulong ptr, (addr))) = (c) : end scope
#define bmp_read16(addr) (*cptr(ushort ptr, (addr)))
#define bmp_read32(addr) (*cptr(ulong ptr, (addr)))
#define AL_RAND() rand()
const ALLEGRO_VERSION = 5
const ALLEGRO_SUB_VERSION = 0
const ALLEGRO_WIP_VERSION = 11
const ALLEGRO_RELEASE_NUMBER = 1
#define ALLEGRO_VERSION_STR "5.0.11"
#define ALLEGRO_DATE_STR "2015"
const ALLEGRO_DATE = 20150111
const ALLEGRO_VERSION_INT = (((ALLEGRO_VERSION shl 24) or (ALLEGRO_SUB_VERSION shl 16)) or (ALLEGRO_WIP_VERSION shl 8)) or ALLEGRO_RELEASE_NUMBER
declare function al_get_allegro_version() as ulong
declare function al_run_main(byval argc as long, byval argv as zstring ptr ptr, byval as function(byval as long, byval as zstring ptr ptr) as long) as long
const ALLEGRO_PI = 3.14159265358979323846
#define AL_ID(a, b, c, d) (((((a) shl 24) or ((b) shl 16)) or ((c) shl 8)) or (d))
#define __al_included_allegro5_altime_h

type ALLEGRO_TIMEOUT
	__pad1__ as ulongint
	__pad2__ as ulongint
end type

declare function al_get_time() as double
declare sub al_rest(byval seconds as double)
declare sub al_init_timeout(byval timeout as ALLEGRO_TIMEOUT ptr, byval seconds as double)
#define __al_included_allegro5_bitmap_h
#define __al_included_allegro5_color_h

type ALLEGRO_COLOR
	r as single
	g as single
	b as single
	a as single
end type

type ALLEGRO_PIXEL_FORMAT as long
enum
	ALLEGRO_PIXEL_FORMAT_ANY = 0
	ALLEGRO_PIXEL_FORMAT_ANY_NO_ALPHA
	ALLEGRO_PIXEL_FORMAT_ANY_WITH_ALPHA
	ALLEGRO_PIXEL_FORMAT_ANY_15_NO_ALPHA
	ALLEGRO_PIXEL_FORMAT_ANY_16_NO_ALPHA
	ALLEGRO_PIXEL_FORMAT_ANY_16_WITH_ALPHA
	ALLEGRO_PIXEL_FORMAT_ANY_24_NO_ALPHA
	ALLEGRO_PIXEL_FORMAT_ANY_32_NO_ALPHA
	ALLEGRO_PIXEL_FORMAT_ANY_32_WITH_ALPHA
	ALLEGRO_PIXEL_FORMAT_ARGB_8888
	ALLEGRO_PIXEL_FORMAT_RGBA_8888
	ALLEGRO_PIXEL_FORMAT_ARGB_4444
	ALLEGRO_PIXEL_FORMAT_RGB_888
	ALLEGRO_PIXEL_FORMAT_RGB_565
	ALLEGRO_PIXEL_FORMAT_RGB_555
	ALLEGRO_PIXEL_FORMAT_RGBA_5551
	ALLEGRO_PIXEL_FORMAT_ARGB_1555
	ALLEGRO_PIXEL_FORMAT_ABGR_8888
	ALLEGRO_PIXEL_FORMAT_XBGR_8888
	ALLEGRO_PIXEL_FORMAT_BGR_888
	ALLEGRO_PIXEL_FORMAT_BGR_565
	ALLEGRO_PIXEL_FORMAT_BGR_555
	ALLEGRO_PIXEL_FORMAT_RGBX_8888
	ALLEGRO_PIXEL_FORMAT_XRGB_8888
	ALLEGRO_PIXEL_FORMAT_ABGR_F32
	ALLEGRO_PIXEL_FORMAT_ABGR_8888_LE
	ALLEGRO_PIXEL_FORMAT_RGBA_4444
	ALLEGRO_NUM_PIXEL_FORMATS
end enum

declare function al_map_rgb(byval r as ubyte, byval g as ubyte, byval b as ubyte) as ALLEGRO_COLOR
declare function al_map_rgba(byval r as ubyte, byval g as ubyte, byval b as ubyte, byval a as ubyte) as ALLEGRO_COLOR
declare function al_map_rgb_f(byval r as single, byval g as single, byval b as single) as ALLEGRO_COLOR
declare function al_map_rgba_f(byval r as single, byval g as single, byval b as single, byval a as single) as ALLEGRO_COLOR
declare sub al_unmap_rgb(byval color as ALLEGRO_COLOR, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr)
declare sub al_unmap_rgba(byval color as ALLEGRO_COLOR, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval a as ubyte ptr)
declare sub al_unmap_rgb_f(byval color as ALLEGRO_COLOR, byval r as single ptr, byval g as single ptr, byval b as single ptr)
declare sub al_unmap_rgba_f(byval color as ALLEGRO_COLOR, byval r as single ptr, byval g as single ptr, byval b as single ptr, byval a as single ptr)
declare function al_get_pixel_size(byval format as long) as long
declare function al_get_pixel_format_bits(byval format as long) as long

enum
	ALLEGRO_MEMORY_BITMAP = &h0001
	ALLEGRO_KEEP_BITMAP_FORMAT = &h0002
	ALLEGRO_FORCE_LOCKING = &h0004
	ALLEGRO_NO_PRESERVE_TEXTURE = &h0008
	ALLEGRO_ALPHA_TEST = &h0010
	_ALLEGRO_INTERNAL_OPENGL = &h0020
	ALLEGRO_MIN_LINEAR = &h0040
	ALLEGRO_MAG_LINEAR = &h0080
	ALLEGRO_MIPMAP = &h0100
	ALLEGRO_NO_PREMULTIPLIED_ALPHA = &h0200
	ALLEGRO_VIDEO_BITMAP = &h0400
end enum

declare sub al_set_new_bitmap_format(byval format as long)
declare sub al_set_new_bitmap_flags(byval flags as long)
declare function al_get_new_bitmap_format() as long
declare function al_get_new_bitmap_flags() as long
declare sub al_add_new_bitmap_flag(byval flag as long)
type ALLEGRO_BITMAP as ALLEGRO_BITMAP_
declare function al_get_bitmap_width(byval bitmap as ALLEGRO_BITMAP ptr) as long
declare function al_get_bitmap_height(byval bitmap as ALLEGRO_BITMAP ptr) as long
declare function al_get_bitmap_format(byval bitmap as ALLEGRO_BITMAP ptr) as long
declare function al_get_bitmap_flags(byval bitmap as ALLEGRO_BITMAP ptr) as long
declare function al_create_bitmap(byval w as long, byval h as long) as ALLEGRO_BITMAP ptr
declare sub al_destroy_bitmap(byval bitmap as ALLEGRO_BITMAP ptr)
declare sub al_put_pixel(byval x as long, byval y as long, byval color as ALLEGRO_COLOR)
declare sub al_put_blended_pixel(byval x as long, byval y as long, byval color as ALLEGRO_COLOR)
declare function al_get_pixel(byval bitmap as ALLEGRO_BITMAP ptr, byval x as long, byval y as long) as ALLEGRO_COLOR
declare sub al_convert_mask_to_alpha(byval bitmap as ALLEGRO_BITMAP ptr, byval mask_color as ALLEGRO_COLOR)
declare sub al_set_clipping_rectangle(byval x as long, byval y as long, byval width as long, byval height as long)
declare sub al_reset_clipping_rectangle()
declare sub al_get_clipping_rectangle(byval x as long ptr, byval y as long ptr, byval w as long ptr, byval h as long ptr)
declare function al_create_sub_bitmap(byval parent as ALLEGRO_BITMAP ptr, byval x as long, byval y as long, byval w as long, byval h as long) as ALLEGRO_BITMAP ptr
declare function al_is_sub_bitmap(byval bitmap as ALLEGRO_BITMAP ptr) as byte
declare function al_get_parent_bitmap(byval bitmap as ALLEGRO_BITMAP ptr) as ALLEGRO_BITMAP ptr
declare function al_clone_bitmap(byval bitmap as ALLEGRO_BITMAP ptr) as ALLEGRO_BITMAP ptr
#define __al_included_allegro5_bitmap_draw_h

enum
	ALLEGRO_FLIP_HORIZONTAL = &h00001
	ALLEGRO_FLIP_VERTICAL = &h00002
end enum

declare sub al_draw_bitmap(byval bitmap as ALLEGRO_BITMAP ptr, byval dx as single, byval dy as single, byval flags as long)
declare sub al_draw_bitmap_region(byval bitmap as ALLEGRO_BITMAP ptr, byval sx as single, byval sy as single, byval sw as single, byval sh as single, byval dx as single, byval dy as single, byval flags as long)
declare sub al_draw_scaled_bitmap(byval bitmap as ALLEGRO_BITMAP ptr, byval sx as single, byval sy as single, byval sw as single, byval sh as single, byval dx as single, byval dy as single, byval dw as single, byval dh as single, byval flags as long)
declare sub al_draw_rotated_bitmap(byval bitmap as ALLEGRO_BITMAP ptr, byval cx as single, byval cy as single, byval dx as single, byval dy as single, byval angle as single, byval flags as long)
declare sub al_draw_scaled_rotated_bitmap(byval bitmap as ALLEGRO_BITMAP ptr, byval cx as single, byval cy as single, byval dx as single, byval dy as single, byval xscale as single, byval yscale as single, byval angle as single, byval flags as long)
declare sub al_draw_tinted_bitmap(byval bitmap as ALLEGRO_BITMAP ptr, byval tint as ALLEGRO_COLOR, byval dx as single, byval dy as single, byval flags as long)
declare sub al_draw_tinted_bitmap_region(byval bitmap as ALLEGRO_BITMAP ptr, byval tint as ALLEGRO_COLOR, byval sx as single, byval sy as single, byval sw as single, byval sh as single, byval dx as single, byval dy as single, byval flags as long)
declare sub al_draw_tinted_scaled_bitmap(byval bitmap as ALLEGRO_BITMAP ptr, byval tint as ALLEGRO_COLOR, byval sx as single, byval sy as single, byval sw as single, byval sh as single, byval dx as single, byval dy as single, byval dw as single, byval dh as single, byval flags as long)
declare sub al_draw_tinted_rotated_bitmap(byval bitmap as ALLEGRO_BITMAP ptr, byval tint as ALLEGRO_COLOR, byval cx as single, byval cy as single, byval dx as single, byval dy as single, byval angle as single, byval flags as long)
declare sub al_draw_tinted_scaled_rotated_bitmap(byval bitmap as ALLEGRO_BITMAP ptr, byval tint as ALLEGRO_COLOR, byval cx as single, byval cy as single, byval dx as single, byval dy as single, byval xscale as single, byval yscale as single, byval angle as single, byval flags as long)
declare sub al_draw_tinted_scaled_rotated_bitmap_region(byval bitmap as ALLEGRO_BITMAP ptr, byval sx as single, byval sy as single, byval sw as single, byval sh as single, byval tint as ALLEGRO_COLOR, byval cx as single, byval cy as single, byval dx as single, byval dy as single, byval xscale as single, byval yscale as single, byval angle as single, byval flags as long)

#define __al_included_allegro5_bitmap_io_h
#define __al_included_allegro5_file_h
#define __al_included_allegro5_path_h

#ifdef __FB_UNIX__
	#define ALLEGRO_NATIVE_PATH_SEP asc("/")
	#define ALLEGRO_NATIVE_DRIVE_SEP asc(!"\0")
#else
	#define ALLEGRO_NATIVE_PATH_SEP asc(!"\\")
	#define ALLEGRO_NATIVE_DRIVE_SEP asc(":")
#endif

type ALLEGRO_PATH as ALLEGRO_PATH_
declare function al_create_path(byval str as const zstring ptr) as ALLEGRO_PATH ptr
declare function al_create_path_for_directory(byval str as const zstring ptr) as ALLEGRO_PATH ptr
declare function al_clone_path(byval path as const ALLEGRO_PATH ptr) as ALLEGRO_PATH ptr
declare function al_get_path_num_components(byval path as const ALLEGRO_PATH ptr) as long
declare function al_get_path_component(byval path as const ALLEGRO_PATH ptr, byval i as long) as const zstring ptr
declare sub al_replace_path_component(byval path as ALLEGRO_PATH ptr, byval i as long, byval s as const zstring ptr)
declare sub al_remove_path_component(byval path as ALLEGRO_PATH ptr, byval i as long)
declare sub al_insert_path_component(byval path as ALLEGRO_PATH ptr, byval i as long, byval s as const zstring ptr)
declare function al_get_path_tail(byval path as const ALLEGRO_PATH ptr) as const zstring ptr
declare sub al_drop_path_tail(byval path as ALLEGRO_PATH ptr)
declare sub al_append_path_component(byval path as ALLEGRO_PATH ptr, byval s as const zstring ptr)
declare function al_join_paths(byval path as ALLEGRO_PATH ptr, byval tail as const ALLEGRO_PATH ptr) as byte
declare function al_rebase_path(byval head as const ALLEGRO_PATH ptr, byval tail as ALLEGRO_PATH ptr) as byte
declare function al_path_cstr(byval path as const ALLEGRO_PATH ptr, byval delim as byte) as const zstring ptr
declare sub al_destroy_path(byval path as ALLEGRO_PATH ptr)
declare sub al_set_path_drive(byval path as ALLEGRO_PATH ptr, byval drive as const zstring ptr)
declare function al_get_path_drive(byval path as const ALLEGRO_PATH ptr) as const zstring ptr
declare sub al_set_path_filename(byval path as ALLEGRO_PATH ptr, byval filename as const zstring ptr)
declare function al_get_path_filename(byval path as const ALLEGRO_PATH ptr) as const zstring ptr
declare function al_get_path_extension(byval path as const ALLEGRO_PATH ptr) as const zstring ptr
declare function al_set_path_extension(byval path as ALLEGRO_PATH ptr, byval extension as const zstring ptr) as byte
declare function al_get_path_basename(byval path as const ALLEGRO_PATH ptr) as const zstring ptr
declare function al_make_path_canonical(byval path as ALLEGRO_PATH ptr) as byte
#define __al_included_allegro5_utf8_h
type ALLEGRO_USTR as _al_tagbstring
type ALLEGRO_USTR_INFO as _al_tagbstring
#define __al_tagbstring_defined

type _al_tagbstring
	mlen as long
	slen as long
	data as ubyte ptr
end type

declare function al_ustr_new(byval s as const zstring ptr) as ALLEGRO_USTR ptr
declare function al_ustr_new_from_buffer(byval s as const zstring ptr, byval size as uinteger) as ALLEGRO_USTR ptr
declare function al_ustr_newf(byval fmt as const zstring ptr, ...) as ALLEGRO_USTR ptr
declare sub al_ustr_free(byval us as ALLEGRO_USTR ptr)
declare function al_cstr(byval us as const ALLEGRO_USTR ptr) as const zstring ptr
declare sub al_ustr_to_buffer(byval us as const ALLEGRO_USTR ptr, byval buffer as zstring ptr, byval size as long)
declare function al_cstr_dup(byval us as const ALLEGRO_USTR ptr) as zstring ptr
declare function al_ustr_dup(byval us as const ALLEGRO_USTR ptr) as ALLEGRO_USTR ptr
declare function al_ustr_dup_substr(byval us as const ALLEGRO_USTR ptr, byval start_pos as long, byval end_pos as long) as ALLEGRO_USTR ptr
declare function al_ustr_empty_string() as const ALLEGRO_USTR ptr
declare function al_ref_cstr(byval info as ALLEGRO_USTR_INFO ptr, byval s as const zstring ptr) as const ALLEGRO_USTR ptr
declare function al_ref_buffer(byval info as ALLEGRO_USTR_INFO ptr, byval s as const zstring ptr, byval size as uinteger) as const ALLEGRO_USTR ptr
declare function al_ref_ustr(byval info as ALLEGRO_USTR_INFO ptr, byval us as const ALLEGRO_USTR ptr, byval start_pos as long, byval end_pos as long) as const ALLEGRO_USTR ptr
declare function al_ustr_size(byval us as const ALLEGRO_USTR ptr) as uinteger
declare function al_ustr_length(byval us as const ALLEGRO_USTR ptr) as uinteger
declare function al_ustr_offset(byval us as const ALLEGRO_USTR ptr, byval index as long) as long
declare function al_ustr_next(byval us as const ALLEGRO_USTR ptr, byval pos as long ptr) as byte
declare function al_ustr_prev(byval us as const ALLEGRO_USTR ptr, byval pos as long ptr) as byte
declare function al_ustr_get(byval us as const ALLEGRO_USTR ptr, byval pos as long) as long
declare function al_ustr_get_next(byval us as const ALLEGRO_USTR ptr, byval pos as long ptr) as long
declare function al_ustr_prev_get(byval us as const ALLEGRO_USTR ptr, byval pos as long ptr) as long
declare function al_ustr_insert(byval us1 as ALLEGRO_USTR ptr, byval pos as long, byval us2 as const ALLEGRO_USTR ptr) as byte
declare function al_ustr_insert_cstr(byval us as ALLEGRO_USTR ptr, byval pos as long, byval us2 as const zstring ptr) as byte
declare function al_ustr_insert_chr(byval us as ALLEGRO_USTR ptr, byval pos as long, byval c as long) as uinteger
declare function al_ustr_append(byval us1 as ALLEGRO_USTR ptr, byval us2 as const ALLEGRO_USTR ptr) as byte
declare function al_ustr_append_cstr(byval us as ALLEGRO_USTR ptr, byval s as const zstring ptr) as byte
declare function al_ustr_append_chr(byval us as ALLEGRO_USTR ptr, byval c as long) as uinteger
declare function al_ustr_appendf(byval us as ALLEGRO_USTR ptr, byval fmt as const zstring ptr, ...) as byte
declare function al_ustr_vappendf(byval us as ALLEGRO_USTR ptr, byval fmt as const zstring ptr, byval ap as va_list) as byte
declare function al_ustr_remove_chr(byval us as ALLEGRO_USTR ptr, byval pos as long) as byte
declare function al_ustr_remove_range(byval us as ALLEGRO_USTR ptr, byval start_pos as long, byval end_pos as long) as byte
declare function al_ustr_truncate(byval us as ALLEGRO_USTR ptr, byval start_pos as long) as byte
declare function al_ustr_ltrim_ws(byval us as ALLEGRO_USTR ptr) as byte
declare function al_ustr_rtrim_ws(byval us as ALLEGRO_USTR ptr) as byte
declare function al_ustr_trim_ws(byval us as ALLEGRO_USTR ptr) as byte
declare function al_ustr_assign(byval us1 as ALLEGRO_USTR ptr, byval us2 as const ALLEGRO_USTR ptr) as byte
declare function al_ustr_assign_substr(byval us1 as ALLEGRO_USTR ptr, byval us2 as const ALLEGRO_USTR ptr, byval start_pos as long, byval end_pos as long) as byte
declare function al_ustr_assign_cstr(byval us1 as ALLEGRO_USTR ptr, byval s as const zstring ptr) as byte
declare function al_ustr_set_chr(byval us as ALLEGRO_USTR ptr, byval pos as long, byval c as long) as uinteger
declare function al_ustr_replace_range(byval us1 as ALLEGRO_USTR ptr, byval start_pos1 as long, byval end_pos1 as long, byval us2 as const ALLEGRO_USTR ptr) as byte
declare function al_ustr_find_chr(byval us as const ALLEGRO_USTR ptr, byval start_pos as long, byval c as long) as long
declare function al_ustr_rfind_chr(byval us as const ALLEGRO_USTR ptr, byval start_pos as long, byval c as long) as long
declare function al_ustr_find_set(byval us as const ALLEGRO_USTR ptr, byval start_pos as long, byval accept as const ALLEGRO_USTR ptr) as long
declare function al_ustr_find_set_cstr(byval us as const ALLEGRO_USTR ptr, byval start_pos as long, byval accept as const zstring ptr) as long
declare function al_ustr_find_cset(byval us as const ALLEGRO_USTR ptr, byval start_pos as long, byval reject as const ALLEGRO_USTR ptr) as long
declare function al_ustr_find_cset_cstr(byval us as const ALLEGRO_USTR ptr, byval start_pos as long, byval reject as const zstring ptr) as long
declare function al_ustr_find_str(byval haystack as const ALLEGRO_USTR ptr, byval start_pos as long, byval needle as const ALLEGRO_USTR ptr) as long
declare function al_ustr_find_cstr(byval haystack as const ALLEGRO_USTR ptr, byval start_pos as long, byval needle as const zstring ptr) as long
declare function al_ustr_rfind_str(byval haystack as const ALLEGRO_USTR ptr, byval start_pos as long, byval needle as const ALLEGRO_USTR ptr) as long
declare function al_ustr_rfind_cstr(byval haystack as const ALLEGRO_USTR ptr, byval start_pos as long, byval needle as const zstring ptr) as long
declare function al_ustr_find_replace(byval us as ALLEGRO_USTR ptr, byval start_pos as long, byval find as const ALLEGRO_USTR ptr, byval replace as const ALLEGRO_USTR ptr) as byte
declare function al_ustr_find_replace_cstr(byval us as ALLEGRO_USTR ptr, byval start_pos as long, byval find as const zstring ptr, byval replace as const zstring ptr) as byte
declare function al_ustr_equal(byval us1 as const ALLEGRO_USTR ptr, byval us2 as const ALLEGRO_USTR ptr) as byte
declare function al_ustr_compare(byval u as const ALLEGRO_USTR ptr, byval v as const ALLEGRO_USTR ptr) as long
declare function al_ustr_ncompare(byval us1 as const ALLEGRO_USTR ptr, byval us2 as const ALLEGRO_USTR ptr, byval n as long) as long
declare function al_ustr_has_prefix(byval u as const ALLEGRO_USTR ptr, byval v as const ALLEGRO_USTR ptr) as byte
declare function al_ustr_has_prefix_cstr(byval u as const ALLEGRO_USTR ptr, byval s as const zstring ptr) as byte
declare function al_ustr_has_suffix(byval u as const ALLEGRO_USTR ptr, byval v as const ALLEGRO_USTR ptr) as byte
declare function al_ustr_has_suffix_cstr(byval us1 as const ALLEGRO_USTR ptr, byval s as const zstring ptr) as byte
declare function al_utf8_width(byval c as long) as uinteger
declare function al_utf8_encode(byval s as zstring ptr, byval c as long) as uinteger
declare function al_ustr_new_from_utf16(byval s as const ushort ptr) as ALLEGRO_USTR ptr
declare function al_ustr_size_utf16(byval us as const ALLEGRO_USTR ptr) as uinteger
declare function al_ustr_encode_utf16(byval us as const ALLEGRO_USTR ptr, byval s as ushort ptr, byval n as uinteger) as uinteger
declare function al_utf16_width(byval c as long) as uinteger
declare function al_utf16_encode(byval s as ushort ptr, byval c as long) as uinteger
type ALLEGRO_FILE as ALLEGRO_FILE_

type ALLEGRO_FILE_INTERFACE
	fi_fopen as function(byval path as const zstring ptr, byval mode as const zstring ptr) as any ptr
	fi_fclose as sub(byval handle as ALLEGRO_FILE ptr)
	fi_fread as function(byval f as ALLEGRO_FILE ptr, byval ptr as any ptr, byval size as uinteger) as uinteger
	fi_fwrite as function(byval f as ALLEGRO_FILE ptr, byval ptr as const any ptr, byval size as uinteger) as uinteger
	fi_fflush as function(byval f as ALLEGRO_FILE ptr) as byte
	fi_ftell as function(byval f as ALLEGRO_FILE ptr) as longint
	fi_fseek as function(byval f as ALLEGRO_FILE ptr, byval offset as longint, byval whence as long) as byte
	fi_feof as function(byval f as ALLEGRO_FILE ptr) as byte
	fi_ferror as function(byval f as ALLEGRO_FILE ptr) as byte
	fi_fclearerr as sub(byval f as ALLEGRO_FILE ptr)
	fi_fungetc as function(byval f as ALLEGRO_FILE ptr, byval c as long) as long
	fi_fsize as function(byval f as ALLEGRO_FILE ptr) as off_t
end type

type ALLEGRO_SEEK as long
enum
	ALLEGRO_SEEK_SET = 0
	ALLEGRO_SEEK_CUR
	ALLEGRO_SEEK_END
end enum

declare function al_fopen(byval path as const zstring ptr, byval mode as const zstring ptr) as ALLEGRO_FILE ptr
declare function al_fopen_interface(byval vt as const ALLEGRO_FILE_INTERFACE ptr, byval path as const zstring ptr, byval mode as const zstring ptr) as ALLEGRO_FILE ptr
declare function al_create_file_handle(byval vt as const ALLEGRO_FILE_INTERFACE ptr, byval userdata as any ptr) as ALLEGRO_FILE ptr
declare sub al_fclose(byval f as ALLEGRO_FILE ptr)
declare function al_fread(byval f as ALLEGRO_FILE ptr, byval ptr as any ptr, byval size as uinteger) as uinteger
declare function al_fwrite(byval f as ALLEGRO_FILE ptr, byval ptr as const any ptr, byval size as uinteger) as uinteger
declare function al_fflush(byval f as ALLEGRO_FILE ptr) as byte
declare function al_ftell(byval f as ALLEGRO_FILE ptr) as longint
declare function al_fseek(byval f as ALLEGRO_FILE ptr, byval offset as longint, byval whence as long) as byte
declare function al_feof(byval f as ALLEGRO_FILE ptr) as byte
declare function al_ferror(byval f as ALLEGRO_FILE ptr) as byte
declare sub al_fclearerr(byval f as ALLEGRO_FILE ptr)
declare function al_fungetc(byval f as ALLEGRO_FILE ptr, byval c as long) as long
declare function al_fsize(byval f as ALLEGRO_FILE ptr) as longint
declare function al_fgetc(byval f as ALLEGRO_FILE ptr) as long
declare function al_fputc(byval f as ALLEGRO_FILE ptr, byval c as long) as long
declare function al_fread16le(byval f as ALLEGRO_FILE ptr) as short
declare function al_fread16be(byval f as ALLEGRO_FILE ptr) as short
declare function al_fwrite16le(byval f as ALLEGRO_FILE ptr, byval w as short) as uinteger
declare function al_fwrite16be(byval f as ALLEGRO_FILE ptr, byval w as short) as uinteger
declare function al_fread32le(byval f as ALLEGRO_FILE ptr) as long
declare function al_fread32be(byval f as ALLEGRO_FILE ptr) as long
declare function al_fwrite32le(byval f as ALLEGRO_FILE ptr, byval l as long) as uinteger
declare function al_fwrite32be(byval f as ALLEGRO_FILE ptr, byval l as long) as uinteger
declare function al_fgets(byval f as ALLEGRO_FILE ptr, byval p as zstring const ptr, byval max as uinteger) as zstring ptr
declare function al_fget_ustr(byval f as ALLEGRO_FILE ptr) as ALLEGRO_USTR ptr
declare function al_fputs(byval f as ALLEGRO_FILE ptr, byval p as const zstring ptr) as long
declare function al_fopen_fd(byval fd as long, byval mode as const zstring ptr) as ALLEGRO_FILE ptr
declare function al_make_temp_file(byval tmpl as const zstring ptr, byval ret_path as ALLEGRO_PATH ptr ptr) as ALLEGRO_FILE ptr
declare function al_fopen_slice(byval fp as ALLEGRO_FILE ptr, byval initial_size as uinteger, byval mode as const zstring ptr) as ALLEGRO_FILE ptr
declare function al_get_new_file_interface() as const ALLEGRO_FILE_INTERFACE ptr
declare sub al_set_new_file_interface(byval file_interface as const ALLEGRO_FILE_INTERFACE ptr)
declare sub al_set_standard_file_interface()
declare function al_get_file_userdata(byval f as ALLEGRO_FILE ptr) as any ptr

type ALLEGRO_IIO_LOADER_FUNCTION as function(byval filename as const zstring ptr) as ALLEGRO_BITMAP ptr
type ALLEGRO_IIO_FS_LOADER_FUNCTION as function(byval fp as ALLEGRO_FILE ptr) as ALLEGRO_BITMAP ptr
type ALLEGRO_IIO_SAVER_FUNCTION as function(byval filename as const zstring ptr, byval bitmap as ALLEGRO_BITMAP ptr) as byte
type ALLEGRO_IIO_FS_SAVER_FUNCTION as function(byval fp as ALLEGRO_FILE ptr, byval bitmap as ALLEGRO_BITMAP ptr) as byte

declare function al_register_bitmap_loader(byval ext as const zstring ptr, byval loader as ALLEGRO_IIO_LOADER_FUNCTION) as byte
declare function al_register_bitmap_saver(byval ext as const zstring ptr, byval saver as ALLEGRO_IIO_SAVER_FUNCTION) as byte
declare function al_register_bitmap_loader_f(byval ext as const zstring ptr, byval fs_loader as ALLEGRO_IIO_FS_LOADER_FUNCTION) as byte
declare function al_register_bitmap_saver_f(byval ext as const zstring ptr, byval fs_saver as ALLEGRO_IIO_FS_SAVER_FUNCTION) as byte
declare function al_load_bitmap(byval filename as const zstring ptr) as ALLEGRO_BITMAP ptr
declare function al_load_bitmap_f(byval fp as ALLEGRO_FILE ptr, byval ident as const zstring ptr) as ALLEGRO_BITMAP ptr
declare function al_save_bitmap(byval filename as const zstring ptr, byval bitmap as ALLEGRO_BITMAP ptr) as byte
declare function al_save_bitmap_f(byval fp as ALLEGRO_FILE ptr, byval ident as const zstring ptr, byval bitmap as ALLEGRO_BITMAP ptr) as byte
#define __al_included_allegro5_bitmap_lock_h

enum
	ALLEGRO_LOCK_READWRITE = 0
	ALLEGRO_LOCK_READONLY = 1
	ALLEGRO_LOCK_WRITEONLY = 2
end enum

type ALLEGRO_LOCKED_REGION
	data as any ptr
	format as long
	pitch as long
	pixel_size as long
end type

declare function al_lock_bitmap(byval bitmap as ALLEGRO_BITMAP ptr, byval format as long, byval flags as long) as ALLEGRO_LOCKED_REGION ptr
declare function al_lock_bitmap_region(byval bitmap as ALLEGRO_BITMAP ptr, byval x as long, byval y as long, byval width as long, byval height as long, byval format as long, byval flags as long) as ALLEGRO_LOCKED_REGION ptr
declare sub al_unlock_bitmap(byval bitmap as ALLEGRO_BITMAP ptr)
declare function al_is_bitmap_locked(byval bitmap as ALLEGRO_BITMAP ptr) as byte
#define __al_included_allegro5_blender_h

type ALLEGRO_BLEND_MODE as long
enum
	ALLEGRO_ZERO = 0
	ALLEGRO_ONE = 1
	ALLEGRO_ALPHA = 2
	ALLEGRO_INVERSE_ALPHA = 3
	ALLEGRO_SRC_COLOR = 4
	ALLEGRO_DEST_COLOR = 5
	ALLEGRO_INVERSE_SRC_COLOR = 6
	ALLEGRO_INVERSE_DEST_COLOR = 7
	ALLEGRO_NUM_BLEND_MODES
end enum

type ALLEGRO_BLEND_OPERATIONS as long
enum
	ALLEGRO_ADD = 0
	ALLEGRO_SRC_MINUS_DEST = 1
	ALLEGRO_DEST_MINUS_SRC = 2
	ALLEGRO_NUM_BLEND_OPERATIONS
end enum

declare sub al_set_blender(byval op as long, byval source as long, byval dest as long)
declare sub al_get_blender(byval op as long ptr, byval source as long ptr, byval dest as long ptr)
declare sub al_set_separate_blender(byval op as long, byval source as long, byval dest as long, byval alpha_op as long, byval alpha_source as long, byval alpha_dest as long)
declare sub al_get_separate_blender(byval op as long ptr, byval source as long ptr, byval dest as long ptr, byval alpha_op as long ptr, byval alpha_src as long ptr, byval alpha_dest as long ptr)
#define __al_included_allegro5_config_h
type ALLEGRO_CONFIG as ALLEGRO_CONFIG_
declare function al_create_config() as ALLEGRO_CONFIG ptr
declare sub al_add_config_section(byval config as ALLEGRO_CONFIG ptr, byval name as const zstring ptr)
declare sub al_set_config_value(byval config as ALLEGRO_CONFIG ptr, byval section as const zstring ptr, byval key as const zstring ptr, byval value as const zstring ptr)
declare sub al_add_config_comment(byval config as ALLEGRO_CONFIG ptr, byval section as const zstring ptr, byval comment as const zstring ptr)
declare function al_get_config_value(byval config as const ALLEGRO_CONFIG ptr, byval section as const zstring ptr, byval key as const zstring ptr) as const zstring ptr
declare function al_load_config_file(byval filename as const zstring ptr) as ALLEGRO_CONFIG ptr
declare function al_load_config_file_f(byval filename as ALLEGRO_FILE ptr) as ALLEGRO_CONFIG ptr
declare function al_save_config_file(byval filename as const zstring ptr, byval config as const ALLEGRO_CONFIG ptr) as byte
declare function al_save_config_file_f(byval file as ALLEGRO_FILE ptr, byval config as const ALLEGRO_CONFIG ptr) as byte
declare sub al_merge_config_into(byval master as ALLEGRO_CONFIG ptr, byval add as const ALLEGRO_CONFIG ptr)
declare function al_merge_config(byval cfg1 as const ALLEGRO_CONFIG ptr, byval cfg2 as const ALLEGRO_CONFIG ptr) as ALLEGRO_CONFIG ptr
declare sub al_destroy_config(byval config as ALLEGRO_CONFIG ptr)
type ALLEGRO_CONFIG_SECTION as ALLEGRO_CONFIG_SECTION_
declare function al_get_first_config_section(byval config as const ALLEGRO_CONFIG ptr, byval iterator as ALLEGRO_CONFIG_SECTION ptr ptr) as const zstring ptr
declare function al_get_next_config_section(byval iterator as ALLEGRO_CONFIG_SECTION ptr ptr) as const zstring ptr
type ALLEGRO_CONFIG_ENTRY as ALLEGRO_CONFIG_ENTRY_
declare function al_get_first_config_entry(byval config as const ALLEGRO_CONFIG ptr, byval section as const zstring ptr, byval iterator as ALLEGRO_CONFIG_ENTRY ptr ptr) as const zstring ptr
declare function al_get_next_config_entry(byval iterator as ALLEGRO_CONFIG_ENTRY ptr ptr) as const zstring ptr
#define __al_included_allegro5_debug_h
declare function _al_trace_prefix(byval channel as const zstring ptr, byval level as long, byval file as const zstring ptr, byval line as long, byval function as const zstring ptr) as byte
declare sub _al_trace_suffix(byval msg as const zstring ptr, ...)

#define ALLEGRO_TRACE_CHANNEL_LEVEL(channel, x) iif(1, cast(any, 0), _al_trace_suffix)
#define ALLEGRO_DEBUG_CHANNEL(x)
#define ALLEGRO_TRACE_LEVEL(x) ALLEGRO_TRACE_CHANNEL_LEVEL(__al_debug_channel, x)
#define ALLEGRO_DEBUG ALLEGRO_TRACE_LEVEL(0)
#define ALLEGRO_INFO ALLEGRO_TRACE_LEVEL(1)
#define ALLEGRO_WARN ALLEGRO_TRACE_LEVEL(2)
#define ALLEGRO_ERROR ALLEGRO_TRACE_LEVEL(3)

extern _AL_DLL _al_user_assert_handler as sub(byval expr as const zstring ptr, byval file as const zstring ptr, byval line as long, byval func as const zstring ptr)

declare sub al_register_assert_handler(byval handler as sub(byval expr as const zstring ptr, byval file as const zstring ptr, byval line as long, byval func as const zstring ptr))
#define __al_included_allegro5_display_h
#define __al_included_allegro5_events_h
type ALLEGRO_EVENT_TYPE as ulong

enum
	ALLEGRO_EVENT_JOYSTICK_AXIS = 1
	ALLEGRO_EVENT_JOYSTICK_BUTTON_DOWN = 2
	ALLEGRO_EVENT_JOYSTICK_BUTTON_UP = 3
	ALLEGRO_EVENT_JOYSTICK_CONFIGURATION = 4
	ALLEGRO_EVENT_KEY_DOWN = 10
	ALLEGRO_EVENT_KEY_CHAR = 11
	ALLEGRO_EVENT_KEY_UP = 12
	ALLEGRO_EVENT_MOUSE_AXES = 20
	ALLEGRO_EVENT_MOUSE_BUTTON_DOWN = 21
	ALLEGRO_EVENT_MOUSE_BUTTON_UP = 22
	ALLEGRO_EVENT_MOUSE_ENTER_DISPLAY = 23
	ALLEGRO_EVENT_MOUSE_LEAVE_DISPLAY = 24
	ALLEGRO_EVENT_MOUSE_WARPED = 25
	ALLEGRO_EVENT_TIMER = 30
	ALLEGRO_EVENT_DISPLAY_EXPOSE = 40
	ALLEGRO_EVENT_DISPLAY_RESIZE = 41
	ALLEGRO_EVENT_DISPLAY_CLOSE = 42
	ALLEGRO_EVENT_DISPLAY_LOST = 43
	ALLEGRO_EVENT_DISPLAY_FOUND = 44
	ALLEGRO_EVENT_DISPLAY_SWITCH_IN = 45
	ALLEGRO_EVENT_DISPLAY_SWITCH_OUT = 46
	ALLEGRO_EVENT_DISPLAY_ORIENTATION = 47
end enum

#define ALLEGRO_EVENT_TYPE_IS_USER(t) ((t) >= 512)
#define ALLEGRO_GET_EVENT_TYPE(a, b, c, d) AL_ID(a, b, c, d)

type ALLEGRO_EVENT_SOURCE
	__pad(0 to 31) as long
end type

type ALLEGRO_ANY_EVENT
	as ALLEGRO_EVENT_TYPE type
	source as ALLEGRO_EVENT_SOURCE ptr
	timestamp as double
end type

type ALLEGRO_DISPLAY as ALLEGRO_DISPLAY_

type ALLEGRO_DISPLAY_EVENT
	as ALLEGRO_EVENT_TYPE type
	source as ALLEGRO_DISPLAY ptr
	timestamp as double
	x as long
	y as long
	width as long
	height as long
	orientation as long
end type

type ALLEGRO_JOYSTICK as ALLEGRO_JOYSTICK_

type ALLEGRO_JOYSTICK_EVENT
	as ALLEGRO_EVENT_TYPE type
	source as ALLEGRO_JOYSTICK ptr
	timestamp as double
	id as ALLEGRO_JOYSTICK ptr
	stick as long
	axis as long
	pos as single
	button as long
end type

type ALLEGRO_KEYBOARD as ALLEGRO_KEYBOARD_

type ALLEGRO_KEYBOARD_EVENT
	as ALLEGRO_EVENT_TYPE type
	source as ALLEGRO_KEYBOARD ptr
	timestamp as double
	display as ALLEGRO_DISPLAY ptr
	keycode as long
	unichar as long
	modifiers as ulong
	repeat as byte
end type

type ALLEGRO_MOUSE as ALLEGRO_MOUSE_

type ALLEGRO_MOUSE_EVENT
	as ALLEGRO_EVENT_TYPE type
	source as ALLEGRO_MOUSE ptr
	timestamp as double
	display as ALLEGRO_DISPLAY ptr
	x as long
	y as long
	z as long
	w as long
	dx as long
	dy as long
	dz as long
	dw as long
	button as ulong
	pressure as single
end type

type ALLEGRO_TIMER as ALLEGRO_TIMER_

type ALLEGRO_TIMER_EVENT
	as ALLEGRO_EVENT_TYPE type
	source as ALLEGRO_TIMER ptr
	timestamp as double
	count as longint
	error as double
end type

type ALLEGRO_USER_EVENT_DESCRIPTOR as ALLEGRO_USER_EVENT_DESCRIPTOR_

type ALLEGRO_USER_EVENT
	as ALLEGRO_EVENT_TYPE type
	source as ALLEGRO_EVENT_SOURCE ptr
	timestamp as double
	__internal__descr as ALLEGRO_USER_EVENT_DESCRIPTOR ptr
	data1 as integer
	data2 as integer
	data3 as integer
	data4 as integer
end type

union ALLEGRO_EVENT
	as ALLEGRO_EVENT_TYPE type
	any as ALLEGRO_ANY_EVENT
	display as ALLEGRO_DISPLAY_EVENT
	joystick as ALLEGRO_JOYSTICK_EVENT
	keyboard as ALLEGRO_KEYBOARD_EVENT
	mouse as ALLEGRO_MOUSE_EVENT
	timer as ALLEGRO_TIMER_EVENT
	user as ALLEGRO_USER_EVENT
end union

declare sub al_init_user_event_source(byval as ALLEGRO_EVENT_SOURCE ptr)
declare sub al_destroy_user_event_source(byval as ALLEGRO_EVENT_SOURCE ptr)
declare function al_emit_user_event(byval as ALLEGRO_EVENT_SOURCE ptr, byval as ALLEGRO_EVENT ptr, byval dtor as sub(byval as ALLEGRO_USER_EVENT ptr)) as byte
declare sub al_unref_user_event(byval as ALLEGRO_USER_EVENT ptr)
declare sub al_set_event_source_data(byval as ALLEGRO_EVENT_SOURCE ptr, byval data as integer)
declare function al_get_event_source_data(byval as const ALLEGRO_EVENT_SOURCE ptr) as integer
type ALLEGRO_EVENT_QUEUE as ALLEGRO_EVENT_QUEUE_
declare function al_create_event_queue() as ALLEGRO_EVENT_QUEUE ptr
declare sub al_destroy_event_queue(byval as ALLEGRO_EVENT_QUEUE ptr)
declare sub al_register_event_source(byval as ALLEGRO_EVENT_QUEUE ptr, byval as ALLEGRO_EVENT_SOURCE ptr)
declare sub al_unregister_event_source(byval as ALLEGRO_EVENT_QUEUE ptr, byval as ALLEGRO_EVENT_SOURCE ptr)
declare function al_is_event_queue_empty(byval as ALLEGRO_EVENT_QUEUE ptr) as byte
declare function al_get_next_event(byval as ALLEGRO_EVENT_QUEUE ptr, byval ret_event as ALLEGRO_EVENT ptr) as byte
declare function al_peek_next_event(byval as ALLEGRO_EVENT_QUEUE ptr, byval ret_event as ALLEGRO_EVENT ptr) as byte
declare function al_drop_next_event(byval as ALLEGRO_EVENT_QUEUE ptr) as byte
declare sub al_flush_event_queue(byval as ALLEGRO_EVENT_QUEUE ptr)
declare sub al_wait_for_event(byval as ALLEGRO_EVENT_QUEUE ptr, byval ret_event as ALLEGRO_EVENT ptr)
declare function al_wait_for_event_timed(byval as ALLEGRO_EVENT_QUEUE ptr, byval ret_event as ALLEGRO_EVENT ptr, byval secs as single) as byte
declare function al_wait_for_event_until(byval queue as ALLEGRO_EVENT_QUEUE ptr, byval ret_event as ALLEGRO_EVENT ptr, byval timeout as ALLEGRO_TIMEOUT ptr) as byte

enum
	ALLEGRO_WINDOWED = 1 shl 0
	ALLEGRO_FULLSCREEN = 1 shl 1
	ALLEGRO_OPENGL = 1 shl 2
	ALLEGRO_DIRECT3D_INTERNAL = 1 shl 3
	ALLEGRO_RESIZABLE = 1 shl 4
	ALLEGRO_FRAMELESS = 1 shl 5
	ALLEGRO_NOFRAME = ALLEGRO_FRAMELESS
	ALLEGRO_GENERATE_EXPOSE_EVENTS = 1 shl 6
	ALLEGRO_OPENGL_3_0 = 1 shl 7
	ALLEGRO_OPENGL_FORWARD_COMPATIBLE = 1 shl 8
	ALLEGRO_FULLSCREEN_WINDOW = 1 shl 9
	ALLEGRO_MINIMIZED = 1 shl 10
end enum

type ALLEGRO_DISPLAY_OPTIONS as long
enum
	ALLEGRO_RED_SIZE
	ALLEGRO_GREEN_SIZE
	ALLEGRO_BLUE_SIZE
	ALLEGRO_ALPHA_SIZE
	ALLEGRO_RED_SHIFT
	ALLEGRO_GREEN_SHIFT
	ALLEGRO_BLUE_SHIFT
	ALLEGRO_ALPHA_SHIFT
	ALLEGRO_ACC_RED_SIZE
	ALLEGRO_ACC_GREEN_SIZE
	ALLEGRO_ACC_BLUE_SIZE
	ALLEGRO_ACC_ALPHA_SIZE
	ALLEGRO_STEREO
	ALLEGRO_AUX_BUFFERS
	ALLEGRO_COLOR_SIZE
	ALLEGRO_DEPTH_SIZE
	ALLEGRO_STENCIL_SIZE
	ALLEGRO_SAMPLE_BUFFERS
	ALLEGRO_SAMPLES
	ALLEGRO_RENDER_METHOD
	ALLEGRO_FLOAT_COLOR
	ALLEGRO_FLOAT_DEPTH
	ALLEGRO_SINGLE_BUFFER
	ALLEGRO_SWAP_METHOD
	ALLEGRO_COMPATIBLE_DISPLAY
	ALLEGRO_UPDATE_DISPLAY_REGION
	ALLEGRO_VSYNC
	ALLEGRO_MAX_BITMAP_SIZE
	ALLEGRO_SUPPORT_NPOT_BITMAP
	ALLEGRO_CAN_DRAW_INTO_BITMAP
	ALLEGRO_SUPPORT_SEPARATE_ALPHA
	ALLEGRO_DISPLAY_OPTIONS_COUNT
end enum

enum
	ALLEGRO_DONTCARE
	ALLEGRO_REQUIRE
	ALLEGRO_SUGGEST
end enum

type ALLEGRO_DISPLAY_ORIENTATION as long
enum
	ALLEGRO_DISPLAY_ORIENTATION_0_DEGREES
	ALLEGRO_DISPLAY_ORIENTATION_90_DEGREES
	ALLEGRO_DISPLAY_ORIENTATION_180_DEGREES
	ALLEGRO_DISPLAY_ORIENTATION_270_DEGREES
	ALLEGRO_DISPLAY_ORIENTATION_FACE_UP
	ALLEGRO_DISPLAY_ORIENTATION_FACE_DOWN
end enum

declare sub al_set_new_display_refresh_rate(byval refresh_rate as long)
declare sub al_set_new_display_flags(byval flags as long)
declare function al_get_new_display_refresh_rate() as long
declare function al_get_new_display_flags() as long
declare function al_get_display_width(byval display as ALLEGRO_DISPLAY ptr) as long
declare function al_get_display_height(byval display as ALLEGRO_DISPLAY ptr) as long
declare function al_get_display_format(byval display as ALLEGRO_DISPLAY ptr) as long
declare function al_get_display_refresh_rate(byval display as ALLEGRO_DISPLAY ptr) as long
declare function al_get_display_flags(byval display as ALLEGRO_DISPLAY ptr) as long
declare function al_set_display_flag(byval display as ALLEGRO_DISPLAY ptr, byval flag as long, byval onoff as byte) as byte
declare function al_toggle_display_flag(byval display as ALLEGRO_DISPLAY ptr, byval flag as long, byval onoff as byte) as byte
declare function al_create_display(byval w as long, byval h as long) as ALLEGRO_DISPLAY ptr
declare sub al_destroy_display(byval display as ALLEGRO_DISPLAY ptr)
declare function al_get_current_display() as ALLEGRO_DISPLAY ptr
declare sub al_set_target_bitmap(byval bitmap as ALLEGRO_BITMAP ptr)
declare sub al_set_target_backbuffer(byval display as ALLEGRO_DISPLAY ptr)
declare function al_get_backbuffer(byval display as ALLEGRO_DISPLAY ptr) as ALLEGRO_BITMAP ptr
declare function al_get_target_bitmap() as ALLEGRO_BITMAP ptr
declare function al_acknowledge_resize(byval display as ALLEGRO_DISPLAY ptr) as byte
declare function al_resize_display(byval display as ALLEGRO_DISPLAY ptr, byval width as long, byval height as long) as byte
declare sub al_flip_display()
declare sub al_update_display_region(byval x as long, byval y as long, byval width as long, byval height as long)
declare function al_is_compatible_bitmap(byval bitmap as ALLEGRO_BITMAP ptr) as byte
declare function al_wait_for_vsync() as byte
declare function al_get_display_event_source(byval display as ALLEGRO_DISPLAY ptr) as ALLEGRO_EVENT_SOURCE ptr
declare sub al_set_display_icon(byval display as ALLEGRO_DISPLAY ptr, byval icon as ALLEGRO_BITMAP ptr)
declare sub al_set_display_icons(byval display as ALLEGRO_DISPLAY ptr, byval num_icons as long, byval icons as ALLEGRO_BITMAP ptr ptr)
declare function al_get_new_display_adapter() as long
declare sub al_set_new_display_adapter(byval adapter as long)
declare sub al_set_new_window_position(byval x as long, byval y as long)
declare sub al_get_new_window_position(byval x as long ptr, byval y as long ptr)
declare sub al_set_window_position(byval display as ALLEGRO_DISPLAY ptr, byval x as long, byval y as long)
declare sub al_get_window_position(byval display as ALLEGRO_DISPLAY ptr, byval x as long ptr, byval y as long ptr)
declare sub al_set_window_title(byval display as ALLEGRO_DISPLAY ptr, byval title as const zstring ptr)
declare sub al_set_new_display_option(byval option as long, byval value as long, byval importance as long)
declare function al_get_new_display_option(byval option as long, byval importance as long ptr) as long
declare sub al_reset_new_display_options()
declare function al_get_display_option(byval display as ALLEGRO_DISPLAY ptr, byval option as long) as long
declare sub al_hold_bitmap_drawing(byval hold as byte)
declare function al_is_bitmap_drawing_held() as byte
#define __al_included_allegro5_drawing_h
declare sub al_clear_to_color(byval color as ALLEGRO_COLOR)
declare sub al_draw_pixel(byval x as single, byval y as single, byval color as ALLEGRO_COLOR)
#define __al_included_allegro5_error_h
declare function al_get_errno() as long
declare sub al_set_errno(byval errnum as long)
#define __al_included_allegro5_fixed_h
type al_fixed as long

extern _AL_DLL al_fixtorad_r as const al_fixed
extern _AL_DLL al_radtofix_r as const al_fixed

#define __al_included_allegro5_fmaths_h
declare function al_fixsqrt(byval x as al_fixed) as al_fixed
declare function al_fixhypot(byval x as al_fixed, byval y as al_fixed) as al_fixed
declare function al_fixatan(byval x as al_fixed) as al_fixed
declare function al_fixatan2(byval y as al_fixed, byval x as al_fixed) as al_fixed

#define _al_fix_cos_tbl(i) ((@___al_fix_cos_tbl)[i])
extern _AL_DLL ___al_fix_cos_tbl alias "_al_fix_cos_tbl" as al_fixed
#define _al_fix_tan_tbl(i) ((@___al_fix_tan_tbl)[i])
extern _AL_DLL ___al_fix_tan_tbl alias "_al_fix_tan_tbl" as al_fixed
#define _al_fix_acos_tbl(i) ((@___al_fix_acos_tbl)[i])
extern _AL_DLL ___al_fix_acos_tbl alias "_al_fix_acos_tbl" as al_fixed

#define __al_included_allegro5_inline_fmaths_inl
declare function al_ftofix(byval x as double) as al_fixed
declare function al_fixtof(byval x as al_fixed) as double
declare function al_fixadd(byval x as al_fixed, byval y as al_fixed) as al_fixed
declare function al_fixsub(byval x as al_fixed, byval y as al_fixed) as al_fixed
declare function al_fixmul(byval x as al_fixed, byval y as al_fixed) as al_fixed
declare function al_fixdiv(byval x as al_fixed, byval y as al_fixed) as al_fixed
declare function al_fixfloor(byval x as al_fixed) as long
declare function al_fixceil(byval x as al_fixed) as long
declare function al_itofix(byval x as long) as al_fixed
declare function al_fixtoi(byval x as al_fixed) as long
declare function al_fixcos(byval x as al_fixed) as al_fixed
declare function al_fixsin(byval x as al_fixed) as al_fixed
declare function al_fixtan(byval x as al_fixed) as al_fixed
declare function al_fixacos(byval x as al_fixed) as al_fixed
declare function al_fixasin(byval x as al_fixed) as al_fixed
#define __al_included_allegro5_fshook_h
type ALLEGRO_FS_INTERFACE as ALLEGRO_FS_INTERFACE_

type ALLEGRO_FS_ENTRY
	vtable as const ALLEGRO_FS_INTERFACE ptr
end type

type ALLEGRO_FILE_MODE as long
enum
	ALLEGRO_FILEMODE_READ = 1
	ALLEGRO_FILEMODE_WRITE = 1 shl 1
	ALLEGRO_FILEMODE_EXECUTE = 1 shl 2
	ALLEGRO_FILEMODE_HIDDEN = 1 shl 3
	ALLEGRO_FILEMODE_ISFILE = 1 shl 4
	ALLEGRO_FILEMODE_ISDIR = 1 shl 5
end enum

#define EOF_ (-1)

type ALLEGRO_FS_INTERFACE_
	fs_create_entry as function(byval path as const zstring ptr) as ALLEGRO_FS_ENTRY ptr
	fs_destroy_entry as sub(byval e as ALLEGRO_FS_ENTRY ptr)
	fs_entry_name as function(byval e as ALLEGRO_FS_ENTRY ptr) as const zstring ptr
	fs_update_entry as function(byval e as ALLEGRO_FS_ENTRY ptr) as byte
	fs_entry_mode as function(byval e as ALLEGRO_FS_ENTRY ptr) as ulong
	fs_entry_atime as function(byval e as ALLEGRO_FS_ENTRY ptr) as time_t
	fs_entry_mtime as function(byval e as ALLEGRO_FS_ENTRY ptr) as time_t
	fs_entry_ctime as function(byval e as ALLEGRO_FS_ENTRY ptr) as time_t
	fs_entry_size as function(byval e as ALLEGRO_FS_ENTRY ptr) as off_t
	fs_entry_exists as function(byval e as ALLEGRO_FS_ENTRY ptr) as byte
	fs_remove_entry as function(byval e as ALLEGRO_FS_ENTRY ptr) as byte
	fs_open_directory as function(byval e as ALLEGRO_FS_ENTRY ptr) as byte
	fs_read_directory as function(byval e as ALLEGRO_FS_ENTRY ptr) as ALLEGRO_FS_ENTRY ptr
	fs_close_directory as function(byval e as ALLEGRO_FS_ENTRY ptr) as byte
	fs_filename_exists as function(byval path as const zstring ptr) as byte
	fs_remove_filename as function(byval path as const zstring ptr) as byte
	fs_get_current_directory as function() as zstring ptr
	fs_change_directory as function(byval path as const zstring ptr) as byte
	fs_make_directory as function(byval path as const zstring ptr) as byte
	fs_open_file as function(byval e as ALLEGRO_FS_ENTRY ptr, byval mode as const zstring ptr) as ALLEGRO_FILE ptr
end type

declare function al_create_fs_entry(byval path as const zstring ptr) as ALLEGRO_FS_ENTRY ptr
declare sub al_destroy_fs_entry(byval e as ALLEGRO_FS_ENTRY ptr)
declare function al_get_fs_entry_name(byval e as ALLEGRO_FS_ENTRY ptr) as const zstring ptr
declare function al_update_fs_entry(byval e as ALLEGRO_FS_ENTRY ptr) as byte
declare function al_get_fs_entry_mode(byval e as ALLEGRO_FS_ENTRY ptr) as ulong
declare function al_get_fs_entry_atime(byval e as ALLEGRO_FS_ENTRY ptr) as time_t
declare function al_get_fs_entry_mtime(byval e as ALLEGRO_FS_ENTRY ptr) as time_t
declare function al_get_fs_entry_ctime(byval e as ALLEGRO_FS_ENTRY ptr) as time_t
declare function al_get_fs_entry_size(byval e as ALLEGRO_FS_ENTRY ptr) as off_t
declare function al_fs_entry_exists(byval e as ALLEGRO_FS_ENTRY ptr) as byte
declare function al_remove_fs_entry(byval e as ALLEGRO_FS_ENTRY ptr) as byte
declare function al_open_directory(byval e as ALLEGRO_FS_ENTRY ptr) as byte
declare function al_read_directory(byval e as ALLEGRO_FS_ENTRY ptr) as ALLEGRO_FS_ENTRY ptr
declare function al_close_directory(byval e as ALLEGRO_FS_ENTRY ptr) as byte
declare function al_filename_exists(byval path as const zstring ptr) as byte
declare function al_remove_filename(byval path as const zstring ptr) as byte
declare function al_get_current_directory() as zstring ptr
declare function al_change_directory(byval path as const zstring ptr) as byte
declare function al_make_directory(byval path as const zstring ptr) as byte
declare function al_open_fs_entry(byval e as ALLEGRO_FS_ENTRY ptr, byval mode as const zstring ptr) as ALLEGRO_FILE ptr
declare function al_get_fs_interface() as const ALLEGRO_FS_INTERFACE ptr
declare sub al_set_fs_interface(byval vtable as const ALLEGRO_FS_INTERFACE ptr)
declare sub al_set_standard_fs_interface()
#define __al_included_allegro5_fullscreen_mode_h

type ALLEGRO_DISPLAY_MODE
	width as long
	height as long
	format as long
	refresh_rate as long
end type

declare function al_get_num_display_modes() as long
declare function al_get_display_mode(byval index as long, byval mode as ALLEGRO_DISPLAY_MODE ptr) as ALLEGRO_DISPLAY_MODE ptr
#define __al_included_allegro5_joystick_h
const _AL_MAX_JOYSTICK_AXES = 3
const _AL_MAX_JOYSTICK_STICKS = 8
const _AL_MAX_JOYSTICK_BUTTONS = 32

type ALLEGRO_JOYSTICK_STATE_stick
	axis(0 to 2) as single
end type

type ALLEGRO_JOYSTICK_STATE
	stick(0 to 7) as ALLEGRO_JOYSTICK_STATE_stick
	button(0 to 31) as long
end type

type ALLEGRO_JOYFLAGS as long
enum
	ALLEGRO_JOYFLAG_DIGITAL = &h01
	ALLEGRO_JOYFLAG_ANALOGUE = &h02
end enum

declare function al_install_joystick() as byte
declare sub al_uninstall_joystick()
declare function al_is_joystick_installed() as byte
declare function al_reconfigure_joysticks() as byte
declare function al_get_num_joysticks() as long
declare function al_get_joystick(byval joyn as long) as ALLEGRO_JOYSTICK ptr
declare sub al_release_joystick(byval as ALLEGRO_JOYSTICK ptr)
declare function al_get_joystick_active(byval as ALLEGRO_JOYSTICK ptr) as byte
declare function al_get_joystick_name(byval as ALLEGRO_JOYSTICK ptr) as const zstring ptr
declare function al_get_joystick_num_sticks(byval as ALLEGRO_JOYSTICK ptr) as long
declare function al_get_joystick_stick_flags(byval as ALLEGRO_JOYSTICK ptr, byval stick as long) as long
declare function al_get_joystick_stick_name(byval as ALLEGRO_JOYSTICK ptr, byval stick as long) as const zstring ptr
declare function al_get_joystick_num_axes(byval as ALLEGRO_JOYSTICK ptr, byval stick as long) as long
declare function al_get_joystick_axis_name(byval as ALLEGRO_JOYSTICK ptr, byval stick as long, byval axis as long) as const zstring ptr
declare function al_get_joystick_num_buttons(byval as ALLEGRO_JOYSTICK ptr) as long
declare function al_get_joystick_button_name(byval as ALLEGRO_JOYSTICK ptr, byval buttonn as long) as const zstring ptr
declare sub al_get_joystick_state(byval as ALLEGRO_JOYSTICK ptr, byval ret_state as ALLEGRO_JOYSTICK_STATE ptr)
declare function al_get_joystick_event_source() as ALLEGRO_EVENT_SOURCE ptr
#define __al_included_allegro5_keyboard_h
#define __al_included_allegro5_keycodes_h

enum
	ALLEGRO_KEY_A = 1
	ALLEGRO_KEY_B = 2
	ALLEGRO_KEY_C = 3
	ALLEGRO_KEY_D = 4
	ALLEGRO_KEY_E = 5
	ALLEGRO_KEY_F = 6
	ALLEGRO_KEY_G = 7
	ALLEGRO_KEY_H = 8
	ALLEGRO_KEY_I = 9
	ALLEGRO_KEY_J = 10
	ALLEGRO_KEY_K = 11
	ALLEGRO_KEY_L = 12
	ALLEGRO_KEY_M = 13
	ALLEGRO_KEY_N = 14
	ALLEGRO_KEY_O = 15
	ALLEGRO_KEY_P = 16
	ALLEGRO_KEY_Q = 17
	ALLEGRO_KEY_R = 18
	ALLEGRO_KEY_S = 19
	ALLEGRO_KEY_T = 20
	ALLEGRO_KEY_U = 21
	ALLEGRO_KEY_V = 22
	ALLEGRO_KEY_W = 23
	ALLEGRO_KEY_X = 24
	ALLEGRO_KEY_Y = 25
	ALLEGRO_KEY_Z = 26
	ALLEGRO_KEY_0 = 27
	ALLEGRO_KEY_1 = 28
	ALLEGRO_KEY_2 = 29
	ALLEGRO_KEY_3 = 30
	ALLEGRO_KEY_4 = 31
	ALLEGRO_KEY_5 = 32
	ALLEGRO_KEY_6 = 33
	ALLEGRO_KEY_7 = 34
	ALLEGRO_KEY_8 = 35
	ALLEGRO_KEY_9 = 36
	ALLEGRO_KEY_PAD_0 = 37
	ALLEGRO_KEY_PAD_1 = 38
	ALLEGRO_KEY_PAD_2 = 39
	ALLEGRO_KEY_PAD_3 = 40
	ALLEGRO_KEY_PAD_4 = 41
	ALLEGRO_KEY_PAD_5 = 42
	ALLEGRO_KEY_PAD_6 = 43
	ALLEGRO_KEY_PAD_7 = 44
	ALLEGRO_KEY_PAD_8 = 45
	ALLEGRO_KEY_PAD_9 = 46
	ALLEGRO_KEY_F1 = 47
	ALLEGRO_KEY_F2 = 48
	ALLEGRO_KEY_F3 = 49
	ALLEGRO_KEY_F4 = 50
	ALLEGRO_KEY_F5 = 51
	ALLEGRO_KEY_F6 = 52
	ALLEGRO_KEY_F7 = 53
	ALLEGRO_KEY_F8 = 54
	ALLEGRO_KEY_F9 = 55
	ALLEGRO_KEY_F10 = 56
	ALLEGRO_KEY_F11 = 57
	ALLEGRO_KEY_F12 = 58
	ALLEGRO_KEY_ESCAPE = 59
	ALLEGRO_KEY_TILDE = 60
	ALLEGRO_KEY_MINUS = 61
	ALLEGRO_KEY_EQUALS = 62
	ALLEGRO_KEY_BACKSPACE = 63
	ALLEGRO_KEY_TAB = 64
	ALLEGRO_KEY_OPENBRACE = 65
	ALLEGRO_KEY_CLOSEBRACE = 66
	ALLEGRO_KEY_ENTER = 67
	ALLEGRO_KEY_SEMICOLON = 68
	ALLEGRO_KEY_QUOTE = 69
	ALLEGRO_KEY_BACKSLASH = 70
	ALLEGRO_KEY_BACKSLASH2 = 71
	ALLEGRO_KEY_COMMA = 72
	ALLEGRO_KEY_FULLSTOP = 73
	ALLEGRO_KEY_SLASH = 74
	ALLEGRO_KEY_SPACE = 75
	ALLEGRO_KEY_INSERT = 76
	ALLEGRO_KEY_DELETE = 77
	ALLEGRO_KEY_HOME = 78
	ALLEGRO_KEY_END = 79
	ALLEGRO_KEY_PGUP = 80
	ALLEGRO_KEY_PGDN = 81
	ALLEGRO_KEY_LEFT = 82
	ALLEGRO_KEY_RIGHT = 83
	ALLEGRO_KEY_UP = 84
	ALLEGRO_KEY_DOWN = 85
	ALLEGRO_KEY_PAD_SLASH = 86
	ALLEGRO_KEY_PAD_ASTERISK = 87
	ALLEGRO_KEY_PAD_MINUS = 88
	ALLEGRO_KEY_PAD_PLUS = 89
	ALLEGRO_KEY_PAD_DELETE = 90
	ALLEGRO_KEY_PAD_ENTER = 91
	ALLEGRO_KEY_PRINTSCREEN = 92
	ALLEGRO_KEY_PAUSE = 93
	ALLEGRO_KEY_ABNT_C1 = 94
	ALLEGRO_KEY_YEN = 95
	ALLEGRO_KEY_KANA = 96
	ALLEGRO_KEY_CONVERT = 97
	ALLEGRO_KEY_NOCONVERT = 98
	ALLEGRO_KEY_AT = 99
	ALLEGRO_KEY_CIRCUMFLEX = 100
	ALLEGRO_KEY_COLON2 = 101
	ALLEGRO_KEY_KANJI = 102
	ALLEGRO_KEY_PAD_EQUALS = 103
	ALLEGRO_KEY_BACKQUOTE = 104
	ALLEGRO_KEY_SEMICOLON2 = 105
	ALLEGRO_KEY_COMMAND = 106
	ALLEGRO_KEY_UNKNOWN = 107
	ALLEGRO_KEY_MODIFIERS = 215
	ALLEGRO_KEY_LSHIFT = 215
	ALLEGRO_KEY_RSHIFT = 216
	ALLEGRO_KEY_LCTRL = 217
	ALLEGRO_KEY_RCTRL = 218
	ALLEGRO_KEY_ALT = 219
	ALLEGRO_KEY_ALTGR = 220
	ALLEGRO_KEY_LWIN = 221
	ALLEGRO_KEY_RWIN = 222
	ALLEGRO_KEY_MENU = 223
	ALLEGRO_KEY_SCROLLLOCK = 224
	ALLEGRO_KEY_NUMLOCK = 225
	ALLEGRO_KEY_CAPSLOCK = 226
	ALLEGRO_KEY_MAX
end enum

enum
	ALLEGRO_KEYMOD_SHIFT = &h00001
	ALLEGRO_KEYMOD_CTRL = &h00002
	ALLEGRO_KEYMOD_ALT = &h00004
	ALLEGRO_KEYMOD_LWIN = &h00008
	ALLEGRO_KEYMOD_RWIN = &h00010
	ALLEGRO_KEYMOD_MENU = &h00020
	ALLEGRO_KEYMOD_ALTGR = &h00040
	ALLEGRO_KEYMOD_COMMAND = &h00080
	ALLEGRO_KEYMOD_SCROLLLOCK = &h00100
	ALLEGRO_KEYMOD_NUMLOCK = &h00200
	ALLEGRO_KEYMOD_CAPSLOCK = &h00400
	ALLEGRO_KEYMOD_INALTSEQ = &h00800
	ALLEGRO_KEYMOD_ACCENT1 = &h01000
	ALLEGRO_KEYMOD_ACCENT2 = &h02000
	ALLEGRO_KEYMOD_ACCENT3 = &h04000
	ALLEGRO_KEYMOD_ACCENT4 = &h08000
end enum

type ALLEGRO_KEYBOARD_STATE
	display as ALLEGRO_DISPLAY ptr
	__key_down__internal__(0 to ((ALLEGRO_KEY_MAX + 31) / 32) - 1) as ulong
end type

declare function al_is_keyboard_installed() as byte
declare function al_install_keyboard() as byte
declare sub al_uninstall_keyboard()
declare function al_set_keyboard_leds(byval leds as long) as byte
declare function al_keycode_to_name(byval keycode as long) as const zstring ptr
declare sub al_get_keyboard_state(byval ret_state as ALLEGRO_KEYBOARD_STATE ptr)
declare function al_key_down(byval as const ALLEGRO_KEYBOARD_STATE ptr, byval keycode as long) as byte
declare function al_get_keyboard_event_source() as ALLEGRO_EVENT_SOURCE ptr

extern _AL_DLL _al_three_finger_flag as byte
extern _AL_DLL _al_key_led_flag as byte

#define __al_included_allegro5_memory_h

type ALLEGRO_MEMORY_INTERFACE
	mi_malloc as function(byval n as uinteger, byval line as long, byval file as const zstring ptr, byval func as const zstring ptr) as any ptr
	mi_free as sub(byval ptr as any ptr, byval line as long, byval file as const zstring ptr, byval func as const zstring ptr)
	mi_realloc as function(byval ptr as any ptr, byval n as uinteger, byval line as long, byval file as const zstring ptr, byval func as const zstring ptr) as any ptr
	mi_calloc as function(byval count as uinteger, byval n as uinteger, byval line as long, byval file as const zstring ptr, byval func as const zstring ptr) as any ptr
end type

declare sub al_set_memory_interface(byval iface as ALLEGRO_MEMORY_INTERFACE ptr)
#define al_malloc(n) al_malloc_with_context((n), __LINE__, __FILE__, __func__)
#define al_free(p) al_free_with_context((p), __LINE__, __FILE__, __func__)
#define al_realloc(p, n) al_realloc_with_context((p), (n), __LINE__, __FILE__, __func__)
#define al_calloc(c, n) al_calloc_with_context((c), (n), __LINE__, __FILE__, __func__)

declare function al_malloc_with_context(byval n as uinteger, byval line as long, byval file as const zstring ptr, byval func as const zstring ptr) as any ptr
declare sub al_free_with_context(byval ptr as any ptr, byval line as long, byval file as const zstring ptr, byval func as const zstring ptr)
declare function al_realloc_with_context(byval ptr as any ptr, byval n as uinteger, byval line as long, byval file as const zstring ptr, byval func as const zstring ptr) as any ptr
declare function al_calloc_with_context(byval count as uinteger, byval n as uinteger, byval line as long, byval file as const zstring ptr, byval func as const zstring ptr) as any ptr
#define __al_included_allegro5_monitor_h

type ALLEGRO_MONITOR_INFO
	x1 as long
	y1 as long
	x2 as long
	y2 as long
end type

enum
	ALLEGRO_DEFAULT_DISPLAY_ADAPTER = -1
end enum

declare function al_get_num_video_adapters() as long
declare function al_get_monitor_info(byval adapter as long, byval info as ALLEGRO_MONITOR_INFO ptr) as byte
#define __al_included_allegro5_mouse_h
const ALLEGRO_MOUSE_MAX_EXTRA_AXES = 4

type ALLEGRO_MOUSE_STATE
	x as long
	y as long
	z as long
	w as long
	more_axes(0 to 3) as long
	buttons as long
	pressure as single
	display as ALLEGRO_DISPLAY ptr
end type

declare function al_is_mouse_installed() as byte
declare function al_install_mouse() as byte
declare sub al_uninstall_mouse()
declare function al_get_mouse_num_buttons() as ulong
declare function al_get_mouse_num_axes() as ulong
declare function al_set_mouse_xy(byval display as ALLEGRO_DISPLAY ptr, byval x as long, byval y as long) as byte
declare function al_set_mouse_z(byval z as long) as byte
declare function al_set_mouse_w(byval w as long) as byte
declare function al_set_mouse_axis(byval axis as long, byval value as long) as byte
declare sub al_get_mouse_state(byval ret_state as ALLEGRO_MOUSE_STATE ptr)
declare function al_mouse_button_down(byval state as const ALLEGRO_MOUSE_STATE ptr, byval button as long) as byte
declare function al_get_mouse_state_axis(byval state as const ALLEGRO_MOUSE_STATE ptr, byval axis as long) as long
declare function al_get_mouse_cursor_position(byval ret_x as long ptr, byval ret_y as long ptr) as byte
declare function al_grab_mouse(byval display as ALLEGRO_DISPLAY ptr) as byte
declare function al_ungrab_mouse() as byte
declare function al_get_mouse_event_source() as ALLEGRO_EVENT_SOURCE ptr
#define __al_included_allegro5_mouse_cursor_h

type ALLEGRO_SYSTEM_MOUSE_CURSOR as long
enum
	ALLEGRO_SYSTEM_MOUSE_CURSOR_NONE = 0
	ALLEGRO_SYSTEM_MOUSE_CURSOR_DEFAULT = 1
	ALLEGRO_SYSTEM_MOUSE_CURSOR_ARROW = 2
	ALLEGRO_SYSTEM_MOUSE_CURSOR_BUSY = 3
	ALLEGRO_SYSTEM_MOUSE_CURSOR_QUESTION = 4
	ALLEGRO_SYSTEM_MOUSE_CURSOR_EDIT = 5
	ALLEGRO_SYSTEM_MOUSE_CURSOR_MOVE = 6
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_N = 7
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_W = 8
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_S = 9
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_E = 10
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NW = 11
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SW = 12
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SE = 13
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NE = 14
	ALLEGRO_SYSTEM_MOUSE_CURSOR_PROGRESS = 15
	ALLEGRO_SYSTEM_MOUSE_CURSOR_PRECISION = 16
	ALLEGRO_SYSTEM_MOUSE_CURSOR_LINK = 17
	ALLEGRO_SYSTEM_MOUSE_CURSOR_ALT_SELECT = 18
	ALLEGRO_SYSTEM_MOUSE_CURSOR_UNAVAILABLE = 19
	ALLEGRO_NUM_SYSTEM_MOUSE_CURSORS
end enum

type ALLEGRO_MOUSE_CURSOR as ALLEGRO_MOUSE_CURSOR_
declare function al_create_mouse_cursor(byval sprite as ALLEGRO_BITMAP ptr, byval xfocus as long, byval yfocus as long) as ALLEGRO_MOUSE_CURSOR ptr
declare sub al_destroy_mouse_cursor(byval as ALLEGRO_MOUSE_CURSOR ptr)
declare function al_set_mouse_cursor(byval display as ALLEGRO_DISPLAY ptr, byval cursor as ALLEGRO_MOUSE_CURSOR ptr) as byte
declare function al_set_system_mouse_cursor(byval display as ALLEGRO_DISPLAY ptr, byval cursor_id as ALLEGRO_SYSTEM_MOUSE_CURSOR) as byte
declare function al_show_mouse_cursor(byval display as ALLEGRO_DISPLAY ptr) as byte
declare function al_hide_mouse_cursor(byval display as ALLEGRO_DISPLAY ptr) as byte
#define __al_included_allegro5_system_h
#define al_init() al_install_system(ALLEGRO_VERSION_INT, @atexit)
declare function al_install_system(byval version as long, byval atexit_ptr as function(byval as sub()) as long) as byte
declare sub al_uninstall_system()
declare function al_is_system_installed() as byte
type ALLEGRO_SYSTEM as ALLEGRO_SYSTEM_
declare function al_get_system_driver() as ALLEGRO_SYSTEM ptr
declare function al_get_system_config() as ALLEGRO_CONFIG ptr

enum
	ALLEGRO_RESOURCES_PATH = 0
	ALLEGRO_TEMP_PATH
	ALLEGRO_USER_DATA_PATH
	ALLEGRO_USER_HOME_PATH
	ALLEGRO_USER_SETTINGS_PATH
	ALLEGRO_USER_DOCUMENTS_PATH
	ALLEGRO_EXENAME_PATH
	ALLEGRO_LAST_PATH
end enum

declare function al_get_standard_path(byval id as long) as ALLEGRO_PATH ptr
declare sub al_set_exe_name(byval path as const zstring ptr)
declare sub al_set_org_name(byval org_name as const zstring ptr)
declare sub al_set_app_name(byval app_name as const zstring ptr)
declare function al_get_org_name() as const zstring ptr
declare function al_get_app_name() as const zstring ptr
declare function al_inhibit_screensaver(byval inhibit as byte) as byte
#define __al_included_allegro5_threads_h
type ALLEGRO_THREAD as ALLEGRO_THREAD_
declare function al_create_thread(byval proc as function(byval thread as ALLEGRO_THREAD ptr, byval arg as any ptr) as any ptr, byval arg as any ptr) as ALLEGRO_THREAD ptr
declare sub al_start_thread(byval outer as ALLEGRO_THREAD ptr)
declare sub al_join_thread(byval outer as ALLEGRO_THREAD ptr, byval ret_value as any ptr ptr)
declare sub al_set_thread_should_stop(byval outer as ALLEGRO_THREAD ptr)
declare function al_get_thread_should_stop(byval outer as ALLEGRO_THREAD ptr) as byte
declare sub al_destroy_thread(byval thread as ALLEGRO_THREAD ptr)
declare sub al_run_detached_thread(byval proc as function(byval arg as any ptr) as any ptr, byval arg as any ptr)
type ALLEGRO_MUTEX as ALLEGRO_MUTEX_
declare function al_create_mutex() as ALLEGRO_MUTEX ptr
declare function al_create_mutex_recursive() as ALLEGRO_MUTEX ptr
declare sub al_lock_mutex(byval mutex as ALLEGRO_MUTEX ptr)
declare sub al_unlock_mutex(byval mutex as ALLEGRO_MUTEX ptr)
declare sub al_destroy_mutex(byval mutex as ALLEGRO_MUTEX ptr)
type ALLEGRO_COND as ALLEGRO_COND_
declare function al_create_cond() as ALLEGRO_COND ptr
declare sub al_destroy_cond(byval cond as ALLEGRO_COND ptr)
declare sub al_wait_cond(byval cond as ALLEGRO_COND ptr, byval mutex as ALLEGRO_MUTEX ptr)
declare function al_wait_cond_until(byval cond as ALLEGRO_COND ptr, byval mutex as ALLEGRO_MUTEX ptr, byval timeout as const ALLEGRO_TIMEOUT ptr) as long
declare sub al_broadcast_cond(byval cond as ALLEGRO_COND ptr)
declare sub al_signal_cond(byval cond as ALLEGRO_COND ptr)

#define __al_included_allegro5_timer_h
#define ALLEGRO_USECS_TO_SECS(x) ((x) / 1000000.0)
#define ALLEGRO_MSECS_TO_SECS(x) ((x) / 1000.0)
#define ALLEGRO_BPS_TO_SECS(x) (1.0 / (x))
#define ALLEGRO_BPM_TO_SECS(x) (60.0 / (x))

declare function al_create_timer(byval speed_secs as double) as ALLEGRO_TIMER ptr
declare sub al_destroy_timer(byval timer as ALLEGRO_TIMER ptr)
declare sub al_start_timer(byval timer as ALLEGRO_TIMER ptr)
declare sub al_stop_timer(byval timer as ALLEGRO_TIMER ptr)
declare function al_get_timer_started(byval timer as const ALLEGRO_TIMER ptr) as byte
declare function al_get_timer_speed(byval timer as const ALLEGRO_TIMER ptr) as double
declare sub al_set_timer_speed(byval timer as ALLEGRO_TIMER ptr, byval speed_secs as double)
declare function al_get_timer_count(byval timer as const ALLEGRO_TIMER ptr) as longint
declare sub al_set_timer_count(byval timer as ALLEGRO_TIMER ptr, byval count as longint)
declare sub al_add_timer_count(byval timer as ALLEGRO_TIMER ptr, byval diff as longint)
declare function al_get_timer_event_source(byval timer as ALLEGRO_TIMER ptr) as ALLEGRO_EVENT_SOURCE ptr
#define __al_included_allegro5_tls_h

type ALLEGRO_STATE_FLAGS as long
enum
	ALLEGRO_STATE_NEW_DISPLAY_PARAMETERS = &h0001
	ALLEGRO_STATE_NEW_BITMAP_PARAMETERS = &h0002
	ALLEGRO_STATE_DISPLAY = &h0004
	ALLEGRO_STATE_TARGET_BITMAP = &h0008
	ALLEGRO_STATE_BLENDER = &h0010
	ALLEGRO_STATE_NEW_FILE_INTERFACE = &h0020
	ALLEGRO_STATE_TRANSFORM = &h0040
	ALLEGRO_STATE_BITMAP = ALLEGRO_STATE_TARGET_BITMAP + ALLEGRO_STATE_NEW_BITMAP_PARAMETERS
	ALLEGRO_STATE_ALL = &hffff
end enum

type ALLEGRO_STATE
	_tls as zstring * 1024
end type

declare sub al_store_state(byval state as ALLEGRO_STATE ptr, byval flags as long)
declare sub al_restore_state(byval state as const ALLEGRO_STATE ptr)
#define __al_included_allegro5_transformations_h

type ALLEGRO_TRANSFORM
	m(0 to 3, 0 to 3) as single
end type

declare sub al_use_transform(byval trans as const ALLEGRO_TRANSFORM ptr)
declare sub al_copy_transform(byval dest as ALLEGRO_TRANSFORM ptr, byval src as const ALLEGRO_TRANSFORM ptr)
declare sub al_identity_transform(byval trans as ALLEGRO_TRANSFORM ptr)
declare sub al_build_transform(byval trans as ALLEGRO_TRANSFORM ptr, byval x as single, byval y as single, byval sx as single, byval sy as single, byval theta as single)
declare sub al_translate_transform(byval trans as ALLEGRO_TRANSFORM ptr, byval x as single, byval y as single)
declare sub al_rotate_transform(byval trans as ALLEGRO_TRANSFORM ptr, byval theta as single)
declare sub al_scale_transform(byval trans as ALLEGRO_TRANSFORM ptr, byval sx as single, byval sy as single)
declare sub al_transform_coordinates(byval trans as const ALLEGRO_TRANSFORM ptr, byval x as single ptr, byval y as single ptr)
declare sub al_compose_transform(byval trans as ALLEGRO_TRANSFORM ptr, byval other as const ALLEGRO_TRANSFORM ptr)
declare function al_get_current_transform() as const ALLEGRO_TRANSFORM ptr
declare sub al_invert_transform(byval trans as ALLEGRO_TRANSFORM ptr)
declare function al_check_inverse(byval trans as const ALLEGRO_TRANSFORM ptr, byval tol as single) as long

#define __al_included_allegro5_alcompat_h
const ALLEGRO_DST_COLOR = ALLEGRO_DEST_COLOR
const ALLEGRO_INVERSE_DST_COLOR = ALLEGRO_INVERSE_DEST_COLOR
#define al_current_time() al_get_time()
#define al_event_queue_is_empty(q) al_is_event_queue_empty(q)

#ifdef __FB_WIN32__
	declare function _WinMain(byval _main as any ptr, byval hInst as any ptr, byval hPrev as any ptr, byval Cmd as zstring ptr, byval nShow as long) as long
	#define AL_JOY_TYPE_DIRECTX AL_ID(asc("D"), asc("X"), asc(" "), asc(" "))
#endif

end extern
