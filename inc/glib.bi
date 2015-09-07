'' FreeBASIC binding for glib-2.44.1
''
'' based on the C header files:
''   GLIB - Library of useful routines for C programming
''   Copyright (C) 1995-1997  Peter Mattis, Spencer Kimball and Josh MacDonald
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, see <http://www.gnu.org/licenses/>.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "glib-2.0"

#ifdef __FB_WIN32__
	#inclib "gthread-2.0"
#endif

#include once "crt/long.bi"
#include once "crt/longdouble.bi"
#include once "glibconfig.bi"
#include once "crt/time.bi"
#include once "crt/stdarg.bi"

#ifdef __FB_UNIX__
	#include once "crt/sys/types.bi"
	#include once "crt/pthread.bi"
#endif

'' The following symbols have been renamed:
''     constant TRUE => CTRUE
''     procedure g_atomic_int_get => g_atomic_int_get_
''     procedure g_atomic_int_set => g_atomic_int_set_
''     procedure g_atomic_int_inc => g_atomic_int_inc_
''     procedure g_atomic_int_dec_and_test => g_atomic_int_dec_and_test_
''     procedure g_atomic_int_compare_and_exchange => g_atomic_int_compare_and_exchange_
''     procedure g_atomic_int_add => g_atomic_int_add_
''     procedure g_atomic_int_and => g_atomic_int_and_
''     procedure g_atomic_int_or => g_atomic_int_or_
''     procedure g_atomic_int_xor => g_atomic_int_xor_
''     procedure g_atomic_pointer_get => g_atomic_pointer_get_
''     procedure g_atomic_pointer_set => g_atomic_pointer_set_
''     procedure g_atomic_pointer_compare_and_exchange => g_atomic_pointer_compare_and_exchange_
''     procedure g_atomic_pointer_add => g_atomic_pointer_add_
''     procedure g_atomic_pointer_and => g_atomic_pointer_and_
''     procedure g_atomic_pointer_or => g_atomic_pointer_or_
''     procedure g_atomic_pointer_xor => g_atomic_pointer_xor_
''     #ifdef __FB_WIN32__
''         procedure g_atexit => g_atexit_
''         procedure g_filename_to_utf8 => g_filename_to_utf8_
''         procedure g_filename_from_utf8 => g_filename_from_utf8_
''         procedure g_filename_from_uri => g_filename_from_uri_
''         procedure g_filename_to_uri => g_filename_to_uri_
''     #endif
''     constant G_DATE_DAY => G_DATE_DAY_
''     constant G_DATE_MONTH => G_DATE_MONTH_
''     constant G_DATE_YEAR => G_DATE_YEAR_
''     #ifdef __FB_WIN32__
''         procedure g_dir_open => g_dir_open_
''         procedure g_dir_read_name => g_dir_read_name_
''         procedure g_getenv => g_getenv_
''         procedure g_setenv => g_setenv_
''         procedure g_unsetenv => g_unsetenv_
''         procedure g_file_test => g_file_test_
''         procedure g_file_get_contents => g_file_get_contents_
''         procedure g_mkstemp => g_mkstemp_
''         procedure g_file_open_tmp => g_file_open_tmp_
''         procedure g_get_current_dir => g_get_current_dir_
''     #endif
''     procedure g_steal_pointer => g_steal_pointer_
''     procedure g_source_remove => g_source_remove_
''     #ifdef __FB_WIN32__
''         procedure g_io_channel_new_file => g_io_channel_new_file_
''     #endif
''     #define G_QUEUE_INIT => G_QUEUE_INIT_
''     #define G_CSET_A_2_Z => G_CSET_A_2_Z_
''     #ifdef __FB_WIN32__
''         procedure g_spawn_async => g_spawn_async_
''         procedure g_spawn_async_with_pipes => g_spawn_async_with_pipes_
''         procedure g_spawn_sync => g_spawn_sync_
''         procedure g_spawn_command_line_sync => g_spawn_command_line_sync_
''         procedure g_spawn_command_line_async => g_spawn_command_line_async_
''     #endif
''     variable glib_major_version => glib_major_version_
''     variable glib_minor_version => glib_minor_version_
''     variable glib_micro_version => glib_micro_version_
''     procedure glib_check_version => glib_check_version_
''     #define G_STATIC_MUTEX_INIT => G_STATIC_MUTEX_INIT_
''     #define G_STATIC_REC_MUTEX_INIT => G_STATIC_REC_MUTEX_INIT_
''     #define G_STATIC_RW_LOCK_INIT => G_STATIC_RW_LOCK_INIT_
''     #define G_STATIC_PRIVATE_INIT => G_STATIC_PRIVATE_INIT_

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define __G_LIB_H__
#define __GLIB_H_INSIDE__
#define __G_ALLOCA_H__
#define __G_TYPES_H__
#define __G_MACROS_H__
#define G_GNUC_FUNCTION ""
#define G_GNUC_PRETTY_FUNCTION ""
#define G_STRINGIFY(macro_or_string) G_STRINGIFY_ARG(macro_or_string)
#define G_STRINGIFY_ARG(contents) #contents
#define G_PASTE_ARGS(identifier1, identifier2) identifier1##identifier2
#define G_PASTE(identifier1, identifier2) G_PASTE_ARGS(identifier1, identifier2)
#define G_STATIC_ASSERT(expr) #assert expr
#define G_STRLOC __FILE__ ":" G_STRINGIFY(__LINE__)
#define G_STRFUNC cptr(const zstring ptr, __func__)
#ifndef NULL
	const NULL = 0
#endif
#ifndef FALSE
	const FALSE = 0
#endif
#ifndef CTRUE
	const CTRUE = 1
#endif
#ifndef TRUE
	const TRUE = 1
#endif
#undef MAX
#define MAX(a, b) iif((a) > (b), (a), (b))
#undef MIN
#define MIN(a, b) iif((a) < (b), (a), (b))
#undef CLAMP
#define CLAMP(x, low, high) iif((x) > (high), (high), iif((x) < (low), (low), (x)))
#define G_N_ELEMENTS(arr) (ubound(arr)  - lbound(array) + 1)
#define GPOINTER_TO_SIZE(p) cast(gsize, (p))
#define GSIZE_TO_POINTER(s) cast(gpointer, cast(gsize, (s)))
#define G_STRUCT_OFFSET(struct_type, member) cast(glong, offsetof(struct_type, member))
#define G_STRUCT_MEMBER_P(struct_p, struct_offset) cast(gpointer, cptr(guint8 ptr, (struct_p)) + cast(glong, (struct_offset)))
#define G_STRUCT_MEMBER(member_type, struct_p, struct_offset) (*cptr(member_type ptr, G_STRUCT_MEMBER_P((struct_p), (struct_offset))))
#define G_LIKELY(expr) (expr)
#define G_UNLIKELY(expr) (expr)
#define _GLIB_AUTOPTR_FUNC_NAME(TypeName) glib_autoptr_cleanup_##TypeName
#define _GLIB_AUTOPTR_TYPENAME(TypeName) TypeName##_autoptr
#define _GLIB_AUTO_FUNC_NAME(TypeName) glib_auto_cleanup_##TypeName
#macro _GLIB_DEFINE_AUTOPTR_CHAINUP(ModuleObjName, ParentName)
	extern "C"
		type _GLIB_AUTOPTR_TYPENAME(ModuleObjName) as ModuleObjName ptr
		private sub _GLIB_AUTOPTR_FUNC_NAME(ModuleObjName)(byval _ptr as ModuleObjName ptr ptr)
			_GLIB_AUTOPTR_FUNC_NAME(ParentName)(cptr(ParentName ptr ptr, _ptr))
		end sub
	end extern
#endmacro
#macro G_DEFINE_AUTOPTR_CLEANUP_FUNC(TypeName, func)
	extern "C"
		type _GLIB_AUTOPTR_TYPENAME(TypeName) as TypeName ptr
		private sub _GLIB_AUTOPTR_FUNC_NAME(TypeName)(byval _ptr as TypeName ptr ptr)
			if *_ptr then
				func(*_ptr)
			end if
		end sub
	end extern
#endmacro
#macro G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(TypeName, func)
	extern "C"
		private sub _GLIB_AUTO_FUNC_NAME(TypeName)(byval _ptr as TypeName ptr)
			func(_ptr)
		end sub
	end extern
#endmacro
#macro G_DEFINE_AUTO_CLEANUP_FREE_FUNC(TypeName, func, none)
	extern "C"
		private sub _GLIB_AUTO_FUNC_NAME(TypeName)(byval _ptr as TypeName ptr)
			if *_ptr <> none
				func(*_ptr)
			end if
		end sub
	end extern
#endmacro
#define __G_VERSION_MACROS_H__
#define G_ENCODE_VERSION(major, minor) (((major) shl 16) or ((minor) shl 8))
#define GLIB_VERSION_2_26 G_ENCODE_VERSION(2, 26)
#define GLIB_VERSION_2_28 G_ENCODE_VERSION(2, 28)
#define GLIB_VERSION_2_30 G_ENCODE_VERSION(2, 30)
#define GLIB_VERSION_2_32 G_ENCODE_VERSION(2, 32)
#define GLIB_VERSION_2_34 G_ENCODE_VERSION(2, 34)
#define GLIB_VERSION_2_36 G_ENCODE_VERSION(2, 36)
#define GLIB_VERSION_2_38 G_ENCODE_VERSION(2, 38)
#define GLIB_VERSION_2_40 G_ENCODE_VERSION(2, 40)
#define GLIB_VERSION_2_42 G_ENCODE_VERSION(2, 42)
#define GLIB_VERSION_CUR_STABLE G_ENCODE_VERSION(GLIB_MAJOR_VERSION, GLIB_MINOR_VERSION)
#define GLIB_VERSION_PREV_STABLE G_ENCODE_VERSION(GLIB_MAJOR_VERSION, GLIB_MINOR_VERSION - 2)
#define GLIB_VERSION_2_44 G_ENCODE_VERSION(2, 44)
#define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_CUR_STABLE
#undef GLIB_VERSION_MAX_ALLOWED
#define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_CUR_STABLE
#define GLIB_AVAILABLE_IN_ALL _GLIB_EXTERN
#define GLIB_DEPRECATED_IN_2_44 GLIB_DEPRECATED
#define GLIB_DEPRECATED_IN_2_44_FOR(f) GLIB_DEPRECATED_FOR(f)
#define GLIB_AVAILABLE_IN_2_44 _GLIB_EXTERN

type gchar as zstring
type gshort as short
type glong as clong
type gint as long
type gboolean as gint
type guchar as ubyte
type gushort as ushort
type gulong as culong
type guint as ulong
type gfloat as single
type gdouble as double

const G_MININT8 = cast(gint8, &h80)
const G_MAXINT8 = cast(gint8, &h7f)
const G_MAXUINT8 = cast(guint8, &hff)
const G_MININT16 = cast(gint16, &h8000)
const G_MAXINT16 = cast(gint16, &h7fff)
const G_MAXUINT16 = cast(guint16, &hffff)
const G_MININT32 = cast(gint32, &h80000000)
const G_MAXINT32 = cast(gint32, &h7fffffff)
const G_MAXUINT32 = cast(guint32, &hffffffff)
#define G_MININT64 cast(gint64, G_GINT64_CONSTANT(&h8000000000000000))
#define G_MAXINT64 G_GINT64_CONSTANT(&h7fffffffffffffff)
#define G_MAXUINT64 G_GINT64_CONSTANT(&hffffffffffffffffu)

type gpointer as any ptr
type gconstpointer as const any ptr
type GCompareFunc as function(byval a as gconstpointer, byval b as gconstpointer) as gint
type GCompareDataFunc as function(byval a as gconstpointer, byval b as gconstpointer, byval user_data as gpointer) as gint
type GEqualFunc as function(byval a as gconstpointer, byval b as gconstpointer) as gboolean
type GDestroyNotify as sub(byval data as gpointer)
type GFunc as sub(byval data as gpointer, byval user_data as gpointer)
type GHashFunc as function(byval key as gconstpointer) as guint
type GHFunc as sub(byval key as gpointer, byval value as gpointer, byval user_data as gpointer)
type GFreeFunc as sub(byval data as gpointer)
type GTranslateFunc as function(byval str as const gchar ptr, byval data as gpointer) as const gchar ptr

const G_E = 2.7182818284590452353602874713526624977572470937000
const G_LN2 = 0.69314718055994530941723212145817656807550013436026
const G_LN10 = 2.3025850929940456840179914546843642076011014886288
const G_PI = 3.1415926535897932384626433832795028841971693993751
const G_PI_2 = 1.5707963267948966192313216916397514420985846996876
const G_PI_4 = 0.78539816339744830961566084581987572104929234984378
const G_SQRT2 = 1.4142135623730950488016887242096980785696718753769
const G_LITTLE_ENDIAN = 1234
const G_BYTE_ORDER = G_LITTLE_ENDIAN
const G_BIG_ENDIAN = 4321
const G_PDP_ENDIAN = 3412
#define GUINT16_SWAP_LE_BE_CONSTANT(val) cast(guint16, cast(guint16, cast(guint16, (val)) shr 8) or cast(guint16, cast(guint16, (val)) shl 8))
#define GUINT32_SWAP_LE_BE_CONSTANT(val) cast(guint32, ((((cast(guint32, (val)) and cast(guint32, &h000000ffu)) shl 24) or ((cast(guint32, (val)) and cast(guint32, &h0000ff00u)) shl 8)) or ((cast(guint32, (val)) and cast(guint32, &h00ff0000u)) shr 8)) or ((cast(guint32, (val)) and cast(guint32, &hff000000u)) shr 24))
#define GUINT64_SWAP_LE_BE_CONSTANT(val) cast(guint64, ((((((((cast(guint64, (val)) and cast(guint64, G_GINT64_CONSTANT(&h00000000000000ffu))) shl 56) or ((cast(guint64, (val)) and cast(guint64, G_GINT64_CONSTANT(&h000000000000ff00u))) shl 40)) or ((cast(guint64, (val)) and cast(guint64, G_GINT64_CONSTANT(&h0000000000ff0000u))) shl 24)) or ((cast(guint64, (val)) and cast(guint64, G_GINT64_CONSTANT(&h00000000ff000000u))) shl 8)) or ((cast(guint64, (val)) and cast(guint64, G_GINT64_CONSTANT(&h000000ff00000000u))) shr 8)) or ((cast(guint64, (val)) and cast(guint64, G_GINT64_CONSTANT(&h0000ff0000000000u))) shr 24)) or ((cast(guint64, (val)) and cast(guint64, G_GINT64_CONSTANT(&h00ff000000000000u))) shr 40)) or ((cast(guint64, (val)) and cast(guint64, G_GINT64_CONSTANT(&hff00000000000000u))) shr 56))
#define GUINT16_SWAP_LE_BE(val) GUINT16_SWAP_LE_BE_CONSTANT(val)
#define GUINT32_SWAP_LE_BE(val) GUINT32_SWAP_LE_BE_CONSTANT(val)
#define GUINT64_SWAP_LE_BE(val) GUINT64_SWAP_LE_BE_CONSTANT(val)
#define GUINT16_SWAP_LE_PDP(val) cast(guint16, (val))
#define GUINT16_SWAP_BE_PDP(val) GUINT16_SWAP_LE_BE(val)
#define GUINT32_SWAP_LE_PDP(val) cast(guint32, ((cast(guint32, (val)) and cast(guint32, &h0000ffffu)) shl 16) or ((cast(guint32, (val)) and cast(guint32, &hffff0000u)) shr 16))
#define GUINT32_SWAP_BE_PDP(val) cast(guint32, ((cast(guint32, (val)) and cast(guint32, &h00ff00ffu)) shl 8) or ((cast(guint32, (val)) and cast(guint32, &hff00ff00u)) shr 8))
#define GINT16_FROM_LE(val) GINT16_TO_LE(val)
#define GUINT16_FROM_LE(val) GUINT16_TO_LE(val)
#define GINT16_FROM_BE(val) GINT16_TO_BE(val)
#define GUINT16_FROM_BE(val) GUINT16_TO_BE(val)
#define GINT32_FROM_LE(val) GINT32_TO_LE(val)
#define GUINT32_FROM_LE(val) GUINT32_TO_LE(val)
#define GINT32_FROM_BE(val) GINT32_TO_BE(val)
#define GUINT32_FROM_BE(val) GUINT32_TO_BE(val)
#define GINT64_FROM_LE(val) GINT64_TO_LE(val)
#define GUINT64_FROM_LE(val) GUINT64_TO_LE(val)
#define GINT64_FROM_BE(val) GINT64_TO_BE(val)
#define GUINT64_FROM_BE(val) GUINT64_TO_BE(val)
#define GLONG_FROM_LE(val) GLONG_TO_LE(val)
#define GULONG_FROM_LE(val) GULONG_TO_LE(val)
#define GLONG_FROM_BE(val) GLONG_TO_BE(val)
#define GULONG_FROM_BE(val) GULONG_TO_BE(val)
#define GINT_FROM_LE(val) GINT_TO_LE(val)
#define GUINT_FROM_LE(val) GUINT_TO_LE(val)
#define GINT_FROM_BE(val) GINT_TO_BE(val)
#define GUINT_FROM_BE(val) GUINT_TO_BE(val)
#define GSIZE_FROM_LE(val) GSIZE_TO_LE(val)
#define GSSIZE_FROM_LE(val) GSSIZE_TO_LE(val)
#define GSIZE_FROM_BE(val) GSIZE_TO_BE(val)
#define GSSIZE_FROM_BE(val) GSSIZE_TO_BE(val)
#define g_ntohl(val) GUINT32_FROM_BE(val)
#define g_ntohs(val) GUINT16_FROM_BE(val)
#define g_htonl(val) GUINT32_TO_BE(val)
#define g_htons(val) GUINT16_TO_BE(val)
type GDoubleIEEE754 as _GDoubleIEEE754
type GFloatIEEE754 as _GFloatIEEE754
const G_IEEE754_FLOAT_BIAS = 127
const G_IEEE754_DOUBLE_BIAS = 1023
const G_LOG_2_BASE_10 = 0.30102999566398119521

type _GFloatIEEE754_mpn
	mantissa : 23 as guint
	biased_exponent : 8 as guint
	sign : 1 as guint
end type

union _GFloatIEEE754
	v_float as gfloat
	mpn as _GFloatIEEE754_mpn
end union

type _GDoubleIEEE754_mpn
	mantissa_low : 32 as guint
	mantissa_high : 20 as guint
	biased_exponent : 11 as guint
	sign : 1 as guint
end type

union _GDoubleIEEE754
	v_double as gdouble
	mpn as _GDoubleIEEE754_mpn
end union

type GTimeVal as _GTimeVal

type _GTimeVal
	tv_sec as glong
	tv_usec as glong
end type

#define g_alloca(size) alloca(size)
#define g_newa(struct_type, n_structs) cptr(struct_type ptr, g_alloca(sizeof(struct_type) * cast(gsize, (n_structs))))
#define __G_ARRAY_H__

type GBytes as _GBytes
type GArray as _GArray
type GByteArray as _GByteArray
type GPtrArray as _GPtrArray

type _GArray
	data as gchar ptr
	len as guint
end type

type _GByteArray
	data as guint8 ptr
	len as guint
end type

type _GPtrArray
	pdata as gpointer ptr
	len as guint
end type

#define g_array_append_val(a, v) g_array_append_vals(a, @(v), 1)
#define g_array_prepend_val(a, v) g_array_prepend_vals(a, @(v), 1)
#define g_array_insert_val(a, i, v) g_array_insert_vals(a, i, @(v), 1)
#define g_array_index(a, t, i) cptr(t ptr, cptr(any ptr, (a)->data))[(i)]

declare function g_array_new(byval zero_terminated as gboolean, byval clear_ as gboolean, byval element_size as guint) as GArray ptr
declare function g_array_sized_new(byval zero_terminated as gboolean, byval clear_ as gboolean, byval element_size as guint, byval reserved_size as guint) as GArray ptr
declare function g_array_free(byval array as GArray ptr, byval free_segment as gboolean) as gchar ptr
declare function g_array_ref(byval array as GArray ptr) as GArray ptr
declare sub g_array_unref(byval array as GArray ptr)
declare function g_array_get_element_size(byval array as GArray ptr) as guint
declare function g_array_append_vals(byval array as GArray ptr, byval data as gconstpointer, byval len as guint) as GArray ptr
declare function g_array_prepend_vals(byval array as GArray ptr, byval data as gconstpointer, byval len as guint) as GArray ptr
declare function g_array_insert_vals(byval array as GArray ptr, byval index_ as guint, byval data as gconstpointer, byval len as guint) as GArray ptr
declare function g_array_set_size(byval array as GArray ptr, byval length as guint) as GArray ptr
declare function g_array_remove_index(byval array as GArray ptr, byval index_ as guint) as GArray ptr
declare function g_array_remove_index_fast(byval array as GArray ptr, byval index_ as guint) as GArray ptr
declare function g_array_remove_range(byval array as GArray ptr, byval index_ as guint, byval length as guint) as GArray ptr
declare sub g_array_sort(byval array as GArray ptr, byval compare_func as GCompareFunc)
declare sub g_array_sort_with_data(byval array as GArray ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer)
declare sub g_array_set_clear_func(byval array as GArray ptr, byval clear_func as GDestroyNotify)
#define g_ptr_array_index(array, index_) (array)->pdata[index_]
declare function g_ptr_array_new() as GPtrArray ptr
declare function g_ptr_array_new_with_free_func(byval element_free_func as GDestroyNotify) as GPtrArray ptr
declare function g_ptr_array_sized_new(byval reserved_size as guint) as GPtrArray ptr
declare function g_ptr_array_new_full(byval reserved_size as guint, byval element_free_func as GDestroyNotify) as GPtrArray ptr
declare function g_ptr_array_free(byval array as GPtrArray ptr, byval free_seg as gboolean) as gpointer ptr
declare function g_ptr_array_ref(byval array as GPtrArray ptr) as GPtrArray ptr
declare sub g_ptr_array_unref(byval array as GPtrArray ptr)
declare sub g_ptr_array_set_free_func(byval array as GPtrArray ptr, byval element_free_func as GDestroyNotify)
declare sub g_ptr_array_set_size(byval array as GPtrArray ptr, byval length as gint)
declare function g_ptr_array_remove_index(byval array as GPtrArray ptr, byval index_ as guint) as gpointer
declare function g_ptr_array_remove_index_fast(byval array as GPtrArray ptr, byval index_ as guint) as gpointer
declare function g_ptr_array_remove(byval array as GPtrArray ptr, byval data as gpointer) as gboolean
declare function g_ptr_array_remove_fast(byval array as GPtrArray ptr, byval data as gpointer) as gboolean
declare function g_ptr_array_remove_range(byval array as GPtrArray ptr, byval index_ as guint, byval length as guint) as GPtrArray ptr
declare sub g_ptr_array_add(byval array as GPtrArray ptr, byval data as gpointer)
declare sub g_ptr_array_insert(byval array as GPtrArray ptr, byval index_ as gint, byval data as gpointer)
declare sub g_ptr_array_sort(byval array as GPtrArray ptr, byval compare_func as GCompareFunc)
declare sub g_ptr_array_sort_with_data(byval array as GPtrArray ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer)
declare sub g_ptr_array_foreach(byval array as GPtrArray ptr, byval func as GFunc, byval user_data as gpointer)
declare function g_byte_array_new() as GByteArray ptr
declare function g_byte_array_new_take(byval data as guint8 ptr, byval len as gsize) as GByteArray ptr
declare function g_byte_array_sized_new(byval reserved_size as guint) as GByteArray ptr
declare function g_byte_array_free(byval array as GByteArray ptr, byval free_segment as gboolean) as guint8 ptr
declare function g_byte_array_free_to_bytes(byval array as GByteArray ptr) as GBytes ptr
declare function g_byte_array_ref(byval array as GByteArray ptr) as GByteArray ptr
declare sub g_byte_array_unref(byval array as GByteArray ptr)
declare function g_byte_array_append(byval array as GByteArray ptr, byval data as const guint8 ptr, byval len as guint) as GByteArray ptr
declare function g_byte_array_prepend(byval array as GByteArray ptr, byval data as const guint8 ptr, byval len as guint) as GByteArray ptr
declare function g_byte_array_set_size(byval array as GByteArray ptr, byval length as guint) as GByteArray ptr
declare function g_byte_array_remove_index(byval array as GByteArray ptr, byval index_ as guint) as GByteArray ptr
declare function g_byte_array_remove_index_fast(byval array as GByteArray ptr, byval index_ as guint) as GByteArray ptr
declare function g_byte_array_remove_range(byval array as GByteArray ptr, byval index_ as guint, byval length as guint) as GByteArray ptr
declare sub g_byte_array_sort(byval array as GByteArray ptr, byval compare_func as GCompareFunc)
declare sub g_byte_array_sort_with_data(byval array as GByteArray ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer)

#define __G_ASYNCQUEUE_H__
#define __G_THREAD_H__
#define __G_ATOMIC_H__

declare function g_atomic_int_get_ alias "g_atomic_int_get"(byval atomic as const gint ptr) as gint
declare sub g_atomic_int_set_ alias "g_atomic_int_set"(byval atomic as gint ptr, byval newval as gint)
declare sub g_atomic_int_inc_ alias "g_atomic_int_inc"(byval atomic as gint ptr)
declare function g_atomic_int_dec_and_test_ alias "g_atomic_int_dec_and_test"(byval atomic as gint ptr) as gboolean
declare function g_atomic_int_compare_and_exchange_ alias "g_atomic_int_compare_and_exchange"(byval atomic as gint ptr, byval oldval as gint, byval newval as gint) as gboolean
declare function g_atomic_int_add_ alias "g_atomic_int_add"(byval atomic as gint ptr, byval val as gint) as gint
declare function g_atomic_int_and_ alias "g_atomic_int_and"(byval atomic as guint ptr, byval val as guint) as guint
declare function g_atomic_int_or_ alias "g_atomic_int_or"(byval atomic as guint ptr, byval val as guint) as guint
declare function g_atomic_int_xor_ alias "g_atomic_int_xor"(byval atomic as guint ptr, byval val as guint) as guint
declare function g_atomic_pointer_get_ alias "g_atomic_pointer_get"(byval atomic as const any ptr) as gpointer
declare sub g_atomic_pointer_set_ alias "g_atomic_pointer_set"(byval atomic as any ptr, byval newval as gpointer)
declare function g_atomic_pointer_compare_and_exchange_ alias "g_atomic_pointer_compare_and_exchange"(byval atomic as any ptr, byval oldval as gpointer, byval newval as gpointer) as gboolean
declare function g_atomic_pointer_add_ alias "g_atomic_pointer_add"(byval atomic as any ptr, byval val as gssize) as gssize
declare function g_atomic_pointer_and_ alias "g_atomic_pointer_and"(byval atomic as any ptr, byval val as gsize) as gsize
declare function g_atomic_pointer_or_ alias "g_atomic_pointer_or"(byval atomic as any ptr, byval val as gsize) as gsize
declare function g_atomic_pointer_xor_ alias "g_atomic_pointer_xor"(byval atomic as any ptr, byval val as gsize) as gsize
declare function g_atomic_int_exchange_and_add(byval atomic as gint ptr, byval val as gint) as gint

#define g_atomic_int_get(atomic) g_atomic_int_get_(cptr(gint ptr, (atomic)))
#define g_atomic_int_set(atomic, newval) g_atomic_int_set_(cptr(gint ptr, (atomic)), cast(gint, (newval)))
#define g_atomic_int_compare_and_exchange(atomic, oldval, newval) g_atomic_int_compare_and_exchange_(cptr(gint ptr, (atomic)), (oldval), (newval))
#define g_atomic_int_add(atomic, val) g_atomic_int_add_(cptr(gint ptr, (atomic)), (val))
#define g_atomic_int_and(atomic, val) g_atomic_int_and_(cptr(guint ptr, (atomic)), (val))
#define g_atomic_int_or(atomic, val) g_atomic_int_or_(cptr(guint ptr, (atomic)), (val))
#define g_atomic_int_xor(atomic, val) g_atomic_int_xor_(cptr(guint ptr, (atomic)), (val))
#define g_atomic_int_inc(atomic) g_atomic_int_inc_(cptr(gint ptr, (atomic)))
#define g_atomic_int_dec_and_test(atomic) g_atomic_int_dec_and_test_(cptr(gint ptr, (atomic)))
#define g_atomic_pointer_get(atomic) g_atomic_pointer_get_(atomic)
#define g_atomic_pointer_set(atomic, newval) g_atomic_pointer_set_((atomic), cast(gpointer, (newval)))
#define g_atomic_pointer_compare_and_exchange(atomic, oldval, newval) g_atomic_pointer_compare_and_exchange_((atomic), cast(gpointer, (oldval)), cast(gpointer, (newval)))
#define g_atomic_pointer_add(atomic, val) g_atomic_pointer_add_((atomic), cast(gssize, (val)))
#define g_atomic_pointer_and(atomic, val) g_atomic_pointer_and_((atomic), cast(gsize, (val)))
#define g_atomic_pointer_or(atomic, val) g_atomic_pointer_or_((atomic), cast(gsize, (val)))
#define g_atomic_pointer_xor(atomic, val) g_atomic_pointer_xor_((atomic), cast(gsize, (val)))
#define __G_ERROR_H__
#define __G_QUARK_H__
type GQuark as guint32

declare function g_quark_try_string(byval string as const gchar ptr) as GQuark
declare function g_quark_from_static_string(byval string as const gchar ptr) as GQuark
declare function g_quark_from_string(byval string as const gchar ptr) as GQuark
declare function g_quark_to_string(byval quark as GQuark) as const gchar ptr
declare function g_intern_string(byval string as const gchar ptr) as const gchar ptr
declare function g_intern_static_string(byval string as const gchar ptr) as const gchar ptr
type GError as _GError

type _GError
	domain as GQuark
	code as gint
	message as gchar ptr
end type

declare function g_error_new(byval domain as GQuark, byval code as gint, byval format as const gchar ptr, ...) as GError ptr
declare function g_error_new_literal(byval domain as GQuark, byval code as gint, byval message as const gchar ptr) as GError ptr
declare function g_error_new_valist(byval domain as GQuark, byval code as gint, byval format as const gchar ptr, byval args as va_list) as GError ptr
declare sub g_error_free(byval error as GError ptr)
declare function g_error_copy(byval error as const GError ptr) as GError ptr
declare function g_error_matches(byval error as const GError ptr, byval domain as GQuark, byval code as gint) as gboolean
declare sub g_set_error(byval err as GError ptr ptr, byval domain as GQuark, byval code as gint, byval format as const gchar ptr, ...)
declare sub g_set_error_literal(byval err as GError ptr ptr, byval domain as GQuark, byval code as gint, byval message as const gchar ptr)
declare sub g_propagate_error(byval dest as GError ptr ptr, byval src as GError ptr)
declare sub g_clear_error(byval err as GError ptr ptr)
declare sub g_prefix_error(byval err as GError ptr ptr, byval format as const gchar ptr, ...)
declare sub g_propagate_prefixed_error(byval dest as GError ptr ptr, byval src as GError ptr, byval format as const gchar ptr, ...)
#define __G_UTILS_H__
declare function g_get_user_name() as const gchar ptr
declare function g_get_real_name() as const gchar ptr
declare function g_get_home_dir() as const gchar ptr
declare function g_get_tmp_dir() as const gchar ptr
declare function g_get_host_name() as const gchar ptr
declare function g_get_prgname() as const gchar ptr
declare sub g_set_prgname(byval prgname as const gchar ptr)
declare function g_get_application_name() as const gchar ptr
declare sub g_set_application_name(byval application_name as const gchar ptr)
declare sub g_reload_user_special_dirs_cache()
declare function g_get_user_data_dir() as const gchar ptr
declare function g_get_user_config_dir() as const gchar ptr
declare function g_get_user_cache_dir() as const gchar ptr
declare function g_get_system_data_dirs() as const gchar const ptr ptr

#ifdef __FB_WIN32__
	declare function g_win32_get_system_data_dirs_for_module(byval address_of_function as sub()) as const gchar const ptr ptr
#endif

declare function g_get_system_config_dirs() as const gchar const ptr ptr
declare function g_get_user_runtime_dir() as const gchar ptr

type GUserDirectory as long
enum
	G_USER_DIRECTORY_DESKTOP
	G_USER_DIRECTORY_DOCUMENTS
	G_USER_DIRECTORY_DOWNLOAD
	G_USER_DIRECTORY_MUSIC
	G_USER_DIRECTORY_PICTURES
	G_USER_DIRECTORY_PUBLIC_SHARE
	G_USER_DIRECTORY_TEMPLATES
	G_USER_DIRECTORY_VIDEOS
	G_USER_N_DIRECTORIES
end enum

declare function g_get_user_special_dir(byval directory as GUserDirectory) as const gchar ptr
type GDebugKey as _GDebugKey

type _GDebugKey
	key as const gchar ptr
	value as guint
end type

declare function g_parse_debug_string(byval string as const gchar ptr, byval keys as const GDebugKey ptr, byval nkeys as guint) as guint
declare function g_snprintf(byval string as gchar ptr, byval n as gulong, byval format as const gchar ptr, ...) as gint
declare function g_vsnprintf(byval string as gchar ptr, byval n as gulong, byval format as const gchar ptr, byval args as va_list) as gint
declare sub g_nullify_pointer(byval nullify_location as gpointer ptr)

type GFormatSizeFlags as long
enum
	G_FORMAT_SIZE_DEFAULT = 0
	G_FORMAT_SIZE_LONG_FORMAT = 1 shl 0
	G_FORMAT_SIZE_IEC_UNITS = 1 shl 1
end enum

declare function g_format_size_full(byval size as guint64, byval flags as GFormatSizeFlags) as gchar ptr
declare function g_format_size(byval size as guint64) as gchar ptr
declare function g_format_size_for_display(byval size as goffset) as gchar ptr
type GVoidFunc as sub()

#ifdef __FB_UNIX__
	declare sub g_atexit(byval func as GVoidFunc)
#else
	declare sub g_atexit_ alias "g_atexit"(byval func as GVoidFunc)
	#define g_atexit(func) atexit(func)
#endif

declare function g_find_program_in_path(byval program as const gchar ptr) as gchar ptr
declare function g_bit_nth_lsf(byval mask as gulong, byval nth_bit as gint) as gint
declare function g_bit_nth_msf(byval mask as gulong, byval nth_bit as gint) as gint
declare function g_bit_storage(byval number as gulong) as guint

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	#macro G_WIN32_DLLMAIN_FOR_DLL_NAME(static, dll_name)
		dim shared dll_name as zstring ptr
		function DllMain stdcall alias "DllMain"(byval hinstDLL as HINSTANCE, byval fdwReason as DWORD, byval lpvReserved as LPVOID) as BOOL
			dim wcbfr as wstring * 1000
			dim tem as zstring ptr
			select case fdwReason
			case DLL_PROCESS_ATTACH
				GetModuleFileNameW(cast(HMODULE, hinstDLL), wcbfr, 1000)
				tem = g_utf16_to_utf8(wcbfr, -1, NULL, NULL, NULL)
				dll_name = g_path_get_basename(tem)
				g_free(tem)
			end select
			return CTRUE
		end function
	#endmacro
#else
	#define G_WIN32_DLLMAIN_FOR_DLL_NAME(static, dll_name)
#endif

#define G_THREAD_ERROR g_thread_error_quark()
declare function g_thread_error_quark() as GQuark

type GThreadError as long
enum
	G_THREAD_ERROR_AGAIN
end enum

type GThreadFunc as function(byval data as gpointer) as gpointer
type GThread as _GThread
type GMutex as _GMutex
type GRecMutex as _GRecMutex
type GRWLock as _GRWLock
type GCond as _GCond
type GPrivate as _GPrivate
type GOnce as _GOnce

union _GMutex
	p as gpointer
	i(0 to 1) as guint
end union

type _GRWLock
	p as gpointer
	i(0 to 1) as guint
end type

type _GCond
	p as gpointer
	i(0 to 1) as guint
end type

type _GRecMutex
	p as gpointer
	i(0 to 1) as guint
end type

#define G_PRIVATE_INIT(notify) (NULL, (notify), (NULL, NULL))

type _GPrivate
	p as gpointer
	notify as GDestroyNotify
	future(0 to 1) as gpointer
end type

type GOnceStatus as long
enum
	G_ONCE_STATUS_NOTCALLED
	G_ONCE_STATUS_PROGRESS
	G_ONCE_STATUS_READY
end enum

#define G_ONCE_INIT (G_ONCE_STATUS_NOTCALLED, NULL)

type _GOnce
	status as GOnceStatus
	retval as gpointer
end type

#define G_LOCK_NAME(name) g__##name##_lock
#define G_LOCK(name) g_mutex_lock(@G_LOCK_NAME(name))
#define G_UNLOCK(name) g_mutex_unlock(@G_LOCK_NAME(name))
#define G_TRYLOCK(name) g_mutex_trylock(@G_LOCK_NAME(name))

declare function g_thread_ref(byval thread as GThread ptr) as GThread ptr
declare sub g_thread_unref(byval thread as GThread ptr)
declare function g_thread_new(byval name as const gchar ptr, byval func as GThreadFunc, byval data as gpointer) as GThread ptr
declare function g_thread_try_new(byval name as const gchar ptr, byval func as GThreadFunc, byval data as gpointer, byval error as GError ptr ptr) as GThread ptr
declare function g_thread_self() as GThread ptr
declare sub g_thread_exit(byval retval as gpointer)
declare function g_thread_join(byval thread as GThread ptr) as gpointer
declare sub g_thread_yield()
declare sub g_mutex_init(byval mutex as GMutex ptr)
declare sub g_mutex_clear(byval mutex as GMutex ptr)
declare sub g_mutex_lock(byval mutex as GMutex ptr)
declare function g_mutex_trylock(byval mutex as GMutex ptr) as gboolean
declare sub g_mutex_unlock(byval mutex as GMutex ptr)
declare sub g_rw_lock_init(byval rw_lock as GRWLock ptr)
declare sub g_rw_lock_clear(byval rw_lock as GRWLock ptr)
declare sub g_rw_lock_writer_lock(byval rw_lock as GRWLock ptr)
declare function g_rw_lock_writer_trylock(byval rw_lock as GRWLock ptr) as gboolean
declare sub g_rw_lock_writer_unlock(byval rw_lock as GRWLock ptr)
declare sub g_rw_lock_reader_lock(byval rw_lock as GRWLock ptr)
declare function g_rw_lock_reader_trylock(byval rw_lock as GRWLock ptr) as gboolean
declare sub g_rw_lock_reader_unlock(byval rw_lock as GRWLock ptr)
declare sub g_rec_mutex_init(byval rec_mutex as GRecMutex ptr)
declare sub g_rec_mutex_clear(byval rec_mutex as GRecMutex ptr)
declare sub g_rec_mutex_lock(byval rec_mutex as GRecMutex ptr)
declare function g_rec_mutex_trylock(byval rec_mutex as GRecMutex ptr) as gboolean
declare sub g_rec_mutex_unlock(byval rec_mutex as GRecMutex ptr)
declare sub g_cond_init(byval cond as GCond ptr)
declare sub g_cond_clear(byval cond as GCond ptr)
declare sub g_cond_wait(byval cond as GCond ptr, byval mutex as GMutex ptr)
declare sub g_cond_signal(byval cond as GCond ptr)
declare sub g_cond_broadcast(byval cond as GCond ptr)
declare function g_cond_wait_until(byval cond as GCond ptr, byval mutex as GMutex ptr, byval end_time as gint64) as gboolean
declare function g_private_get(byval key as GPrivate ptr) as gpointer
declare sub g_private_set(byval key as GPrivate ptr, byval value as gpointer)
declare sub g_private_replace(byval key as GPrivate ptr, byval value as gpointer)
declare function g_once_impl(byval once as GOnce ptr, byval func as GThreadFunc, byval arg as gpointer) as gpointer
declare function g_once_init_enter(byval location as any ptr) as gboolean
declare sub g_once_init_leave(byval location as any ptr, byval result as gsize)
#define g_once(once, func, arg) iif((once)->status = G_ONCE_STATUS_READY, (once)->retval, g_once_impl((once), (func), (arg)))
declare function g_get_num_processors() as guint
type GMutexLocker as any

private function g_mutex_locker_new(byval mutex as GMutex ptr) as GMutexLocker ptr
	g_mutex_lock(mutex)
	return cptr(GMutexLocker ptr, mutex)
end function

private sub g_mutex_locker_free(byval locker as GMutexLocker ptr)
	g_mutex_unlock(cptr(GMutex ptr, locker))
end sub

type GAsyncQueue as _GAsyncQueue
declare function g_async_queue_new() as GAsyncQueue ptr
declare function g_async_queue_new_full(byval item_free_func as GDestroyNotify) as GAsyncQueue ptr
declare sub g_async_queue_lock(byval queue as GAsyncQueue ptr)
declare sub g_async_queue_unlock(byval queue as GAsyncQueue ptr)
declare function g_async_queue_ref(byval queue as GAsyncQueue ptr) as GAsyncQueue ptr
declare sub g_async_queue_unref(byval queue as GAsyncQueue ptr)
declare sub g_async_queue_ref_unlocked(byval queue as GAsyncQueue ptr)
declare sub g_async_queue_unref_and_unlock(byval queue as GAsyncQueue ptr)
declare sub g_async_queue_push(byval queue as GAsyncQueue ptr, byval data as gpointer)
declare sub g_async_queue_push_unlocked(byval queue as GAsyncQueue ptr, byval data as gpointer)
declare sub g_async_queue_push_sorted(byval queue as GAsyncQueue ptr, byval data as gpointer, byval func as GCompareDataFunc, byval user_data as gpointer)
declare sub g_async_queue_push_sorted_unlocked(byval queue as GAsyncQueue ptr, byval data as gpointer, byval func as GCompareDataFunc, byval user_data as gpointer)
declare function g_async_queue_pop(byval queue as GAsyncQueue ptr) as gpointer
declare function g_async_queue_pop_unlocked(byval queue as GAsyncQueue ptr) as gpointer
declare function g_async_queue_try_pop(byval queue as GAsyncQueue ptr) as gpointer
declare function g_async_queue_try_pop_unlocked(byval queue as GAsyncQueue ptr) as gpointer
declare function g_async_queue_timeout_pop(byval queue as GAsyncQueue ptr, byval timeout as guint64) as gpointer
declare function g_async_queue_timeout_pop_unlocked(byval queue as GAsyncQueue ptr, byval timeout as guint64) as gpointer
declare function g_async_queue_length(byval queue as GAsyncQueue ptr) as gint
declare function g_async_queue_length_unlocked(byval queue as GAsyncQueue ptr) as gint
declare sub g_async_queue_sort(byval queue as GAsyncQueue ptr, byval func as GCompareDataFunc, byval user_data as gpointer)
declare sub g_async_queue_sort_unlocked(byval queue as GAsyncQueue ptr, byval func as GCompareDataFunc, byval user_data as gpointer)
declare function g_async_queue_timed_pop(byval queue as GAsyncQueue ptr, byval end_time as GTimeVal ptr) as gpointer
declare function g_async_queue_timed_pop_unlocked(byval queue as GAsyncQueue ptr, byval end_time as GTimeVal ptr) as gpointer
#define __G_BACKTRACE_H__
declare sub g_on_error_query(byval prg_name as const gchar ptr)
declare sub g_on_error_stack_trace(byval prg_name as const gchar ptr)
#define __G_BASE64_H__
declare function g_base64_encode_step(byval in as const guchar ptr, byval len as gsize, byval break_lines as gboolean, byval out as gchar ptr, byval state as gint ptr, byval save as gint ptr) as gsize
declare function g_base64_encode_close(byval break_lines as gboolean, byval out as gchar ptr, byval state as gint ptr, byval save as gint ptr) as gsize
declare function g_base64_encode(byval data as const guchar ptr, byval len as gsize) as gchar ptr
declare function g_base64_decode_step(byval in as const gchar ptr, byval len as gsize, byval out as guchar ptr, byval state as gint ptr, byval save as guint ptr) as gsize
declare function g_base64_decode(byval text as const gchar ptr, byval out_len as gsize ptr) as guchar ptr
declare function g_base64_decode_inplace(byval text as gchar ptr, byval out_len as gsize ptr) as guchar ptr
#define __G_BITLOCK_H__
declare sub g_bit_lock(byval address as gint ptr, byval lock_bit as gint)
declare function g_bit_trylock(byval address as gint ptr, byval lock_bit as gint) as gboolean
declare sub g_bit_unlock(byval address as gint ptr, byval lock_bit as gint)
declare sub g_pointer_bit_lock(byval address as any ptr, byval lock_bit as gint)
declare function g_pointer_bit_trylock(byval address as any ptr, byval lock_bit as gint) as gboolean
declare sub g_pointer_bit_unlock(byval address as any ptr, byval lock_bit as gint)
#define __G_BOOKMARK_FILE_H__
#define G_BOOKMARK_FILE_ERROR g_bookmark_file_error_quark()

type GBookmarkFileError as long
enum
	G_BOOKMARK_FILE_ERROR_INVALID_URI
	G_BOOKMARK_FILE_ERROR_INVALID_VALUE
	G_BOOKMARK_FILE_ERROR_APP_NOT_REGISTERED
	G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND
	G_BOOKMARK_FILE_ERROR_READ
	G_BOOKMARK_FILE_ERROR_UNKNOWN_ENCODING
	G_BOOKMARK_FILE_ERROR_WRITE
	G_BOOKMARK_FILE_ERROR_FILE_NOT_FOUND
end enum

declare function g_bookmark_file_error_quark() as GQuark
type GBookmarkFile as _GBookmarkFile
declare function g_bookmark_file_new() as GBookmarkFile ptr
declare sub g_bookmark_file_free(byval bookmark as GBookmarkFile ptr)
declare function g_bookmark_file_load_from_file(byval bookmark as GBookmarkFile ptr, byval filename as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_bookmark_file_load_from_data(byval bookmark as GBookmarkFile ptr, byval data as const gchar ptr, byval length as gsize, byval error as GError ptr ptr) as gboolean
declare function g_bookmark_file_load_from_data_dirs(byval bookmark as GBookmarkFile ptr, byval file as const gchar ptr, byval full_path as gchar ptr ptr, byval error as GError ptr ptr) as gboolean
declare function g_bookmark_file_to_data(byval bookmark as GBookmarkFile ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_bookmark_file_to_file(byval bookmark as GBookmarkFile ptr, byval filename as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare sub g_bookmark_file_set_title(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval title as const gchar ptr)
declare function g_bookmark_file_get_title(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare sub g_bookmark_file_set_description(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval description as const gchar ptr)
declare function g_bookmark_file_get_description(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare sub g_bookmark_file_set_mime_type(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval mime_type as const gchar ptr)
declare function g_bookmark_file_get_mime_type(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare sub g_bookmark_file_set_groups(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval groups as const gchar ptr ptr, byval length as gsize)
declare sub g_bookmark_file_add_group(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval group as const gchar ptr)
declare function g_bookmark_file_has_group(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval group as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_bookmark_file_get_groups(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gchar ptr ptr
declare sub g_bookmark_file_add_application(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval name as const gchar ptr, byval exec as const gchar ptr)
declare function g_bookmark_file_has_application(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval name as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_bookmark_file_get_applications(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gchar ptr ptr
declare function g_bookmark_file_set_app_info(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval name as const gchar ptr, byval exec as const gchar ptr, byval count as gint, byval stamp as time_t, byval error as GError ptr ptr) as gboolean
declare function g_bookmark_file_get_app_info(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval name as const gchar ptr, byval exec as gchar ptr ptr, byval count as guint ptr, byval stamp as time_t ptr, byval error as GError ptr ptr) as gboolean
declare sub g_bookmark_file_set_is_private(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval is_private as gboolean)
declare function g_bookmark_file_get_is_private(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare sub g_bookmark_file_set_icon(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval href as const gchar ptr, byval mime_type as const gchar ptr)
declare function g_bookmark_file_get_icon(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval href as gchar ptr ptr, byval mime_type as gchar ptr ptr, byval error as GError ptr ptr) as gboolean
declare sub g_bookmark_file_set_added(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval added as time_t)
declare function g_bookmark_file_get_added(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as time_t
declare sub g_bookmark_file_set_modified(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval modified as time_t)
declare function g_bookmark_file_get_modified(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as time_t
declare sub g_bookmark_file_set_visited(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval visited as time_t)
declare function g_bookmark_file_get_visited(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as time_t
declare function g_bookmark_file_has_item(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr) as gboolean
declare function g_bookmark_file_get_size(byval bookmark as GBookmarkFile ptr) as gint
declare function g_bookmark_file_get_uris(byval bookmark as GBookmarkFile ptr, byval length as gsize ptr) as gchar ptr ptr
declare function g_bookmark_file_remove_group(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval group as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_bookmark_file_remove_application(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval name as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_bookmark_file_remove_item(byval bookmark as GBookmarkFile ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_bookmark_file_move_item(byval bookmark as GBookmarkFile ptr, byval old_uri as const gchar ptr, byval new_uri as const gchar ptr, byval error as GError ptr ptr) as gboolean
#define __G_BYTES_H__
declare function g_bytes_new(byval data as gconstpointer, byval size as gsize) as GBytes ptr
declare function g_bytes_new_take(byval data as gpointer, byval size as gsize) as GBytes ptr
declare function g_bytes_new_static(byval data as gconstpointer, byval size as gsize) as GBytes ptr
declare function g_bytes_new_with_free_func(byval data as gconstpointer, byval size as gsize, byval free_func as GDestroyNotify, byval user_data as gpointer) as GBytes ptr
declare function g_bytes_new_from_bytes(byval bytes as GBytes ptr, byval offset as gsize, byval length as gsize) as GBytes ptr
declare function g_bytes_get_data(byval bytes as GBytes ptr, byval size as gsize ptr) as gconstpointer
declare function g_bytes_get_size(byval bytes as GBytes ptr) as gsize
declare function g_bytes_ref(byval bytes as GBytes ptr) as GBytes ptr
declare sub g_bytes_unref(byval bytes as GBytes ptr)
declare function g_bytes_unref_to_data(byval bytes as GBytes ptr, byval size as gsize ptr) as gpointer
declare function g_bytes_unref_to_array(byval bytes as GBytes ptr) as GByteArray ptr
declare function g_bytes_hash(byval bytes as gconstpointer) as guint
declare function g_bytes_equal(byval bytes1 as gconstpointer, byval bytes2 as gconstpointer) as gboolean
declare function g_bytes_compare(byval bytes1 as gconstpointer, byval bytes2 as gconstpointer) as gint
#define __G_CHARSET_H__
declare function g_get_charset(byval charset as const zstring ptr ptr) as gboolean
declare function g_get_codeset() as gchar ptr
declare function g_get_language_names() as const gchar const ptr ptr
declare function g_get_locale_variants(byval locale as const gchar ptr) as gchar ptr ptr
#define __G_CHECKSUM_H__

type GChecksumType as long
enum
	G_CHECKSUM_MD5
	G_CHECKSUM_SHA1
	G_CHECKSUM_SHA256
	G_CHECKSUM_SHA512
end enum

type GChecksum as _GChecksum
declare function g_checksum_type_get_length(byval checksum_type as GChecksumType) as gssize
declare function g_checksum_new(byval checksum_type as GChecksumType) as GChecksum ptr
declare sub g_checksum_reset(byval checksum as GChecksum ptr)
declare function g_checksum_copy(byval checksum as const GChecksum ptr) as GChecksum ptr
declare sub g_checksum_free(byval checksum as GChecksum ptr)
declare sub g_checksum_update(byval checksum as GChecksum ptr, byval data as const guchar ptr, byval length as gssize)
declare function g_checksum_get_string(byval checksum as GChecksum ptr) as const gchar ptr
declare sub g_checksum_get_digest(byval checksum as GChecksum ptr, byval buffer as guint8 ptr, byval digest_len as gsize ptr)
declare function g_compute_checksum_for_data(byval checksum_type as GChecksumType, byval data as const guchar ptr, byval length as gsize) as gchar ptr
declare function g_compute_checksum_for_string(byval checksum_type as GChecksumType, byval str as const gchar ptr, byval length as gssize) as gchar ptr
declare function g_compute_checksum_for_bytes(byval checksum_type as GChecksumType, byval data as GBytes ptr) as gchar ptr
#define __G_CONVERT_H__

type GConvertError as long
enum
	G_CONVERT_ERROR_NO_CONVERSION
	G_CONVERT_ERROR_ILLEGAL_SEQUENCE
	G_CONVERT_ERROR_FAILED
	G_CONVERT_ERROR_PARTIAL_INPUT
	G_CONVERT_ERROR_BAD_URI
	G_CONVERT_ERROR_NOT_ABSOLUTE_PATH
	G_CONVERT_ERROR_NO_MEMORY
end enum

#define G_CONVERT_ERROR g_convert_error_quark()
declare function g_convert_error_quark() as GQuark
type GIConv as _GIConv ptr
declare function g_iconv_open(byval to_codeset as const gchar ptr, byval from_codeset as const gchar ptr) as GIConv
declare function g_iconv(byval converter as GIConv, byval inbuf as gchar ptr ptr, byval inbytes_left as gsize ptr, byval outbuf as gchar ptr ptr, byval outbytes_left as gsize ptr) as gsize
declare function g_iconv_close(byval converter as GIConv) as gint
declare function g_convert(byval str as const gchar ptr, byval len as gssize, byval to_codeset as const gchar ptr, byval from_codeset as const gchar ptr, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_convert_with_iconv(byval str as const gchar ptr, byval len as gssize, byval converter as GIConv, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_convert_with_fallback(byval str as const gchar ptr, byval len as gssize, byval to_codeset as const gchar ptr, byval from_codeset as const gchar ptr, byval fallback as const gchar ptr, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_locale_to_utf8(byval opsysstring as const gchar ptr, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_locale_from_utf8(byval utf8string as const gchar ptr, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr

#ifdef __FB_UNIX__
	declare function g_filename_to_utf8(byval opsysstring as const gchar ptr, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_from_utf8(byval utf8string as const gchar ptr, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_from_uri(byval uri as const gchar ptr, byval hostname as gchar ptr ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_to_uri(byval filename as const gchar ptr, byval hostname as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
#else
	declare function g_filename_to_utf8_ alias "g_filename_to_utf8"(byval opsysstring as const gchar ptr, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_from_utf8_ alias "g_filename_from_utf8"(byval utf8string as const gchar ptr, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_from_uri_ alias "g_filename_from_uri"(byval uri as const gchar ptr, byval hostname as gchar ptr ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_to_uri_ alias "g_filename_to_uri"(byval filename as const gchar ptr, byval hostname as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
#endif

declare function g_filename_display_name(byval filename as const gchar ptr) as gchar ptr
declare function g_get_filename_charsets(byval charsets as const gchar ptr ptr ptr) as gboolean
declare function g_filename_display_basename(byval filename as const gchar ptr) as gchar ptr
declare function g_uri_list_extract_uris(byval uri_list as const gchar ptr) as gchar ptr ptr

#ifdef __FB_WIN32__
	declare function g_filename_to_utf8_utf8(byval opsysstring as const gchar ptr, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_to_utf8 alias "g_filename_to_utf8_utf8"(byval opsysstring as const gchar ptr, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_from_utf8_utf8(byval utf8string as const gchar ptr, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_from_utf8 alias "g_filename_from_utf8_utf8"(byval utf8string as const gchar ptr, byval len as gssize, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_from_uri_utf8(byval uri as const gchar ptr, byval hostname as gchar ptr ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_from_uri alias "g_filename_from_uri_utf8"(byval uri as const gchar ptr, byval hostname as gchar ptr ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_to_uri_utf8(byval filename as const gchar ptr, byval hostname as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
	declare function g_filename_to_uri alias "g_filename_to_uri_utf8"(byval filename as const gchar ptr, byval hostname as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
#endif

#define __G_DATASET_H__
type GData as _GData
type GDataForeachFunc as sub(byval key_id as GQuark, byval data as gpointer, byval user_data as gpointer)
declare sub g_datalist_init(byval datalist as GData ptr ptr)
declare sub g_datalist_clear(byval datalist as GData ptr ptr)
declare function g_datalist_id_get_data(byval datalist as GData ptr ptr, byval key_id as GQuark) as gpointer
declare sub g_datalist_id_set_data_full(byval datalist as GData ptr ptr, byval key_id as GQuark, byval data as gpointer, byval destroy_func as GDestroyNotify)
type GDuplicateFunc as function(byval data as gpointer, byval user_data as gpointer) as gpointer
declare function g_datalist_id_dup_data(byval datalist as GData ptr ptr, byval key_id as GQuark, byval dup_func as GDuplicateFunc, byval user_data as gpointer) as gpointer
declare function g_datalist_id_replace_data(byval datalist as GData ptr ptr, byval key_id as GQuark, byval oldval as gpointer, byval newval as gpointer, byval destroy as GDestroyNotify, byval old_destroy as GDestroyNotify ptr) as gboolean
declare function g_datalist_id_remove_no_notify(byval datalist as GData ptr ptr, byval key_id as GQuark) as gpointer
declare sub g_datalist_foreach(byval datalist as GData ptr ptr, byval func as GDataForeachFunc, byval user_data as gpointer)
const G_DATALIST_FLAGS_MASK = &h3
declare sub g_datalist_set_flags(byval datalist as GData ptr ptr, byval flags as guint)
declare sub g_datalist_unset_flags(byval datalist as GData ptr ptr, byval flags as guint)
declare function g_datalist_get_flags(byval datalist as GData ptr ptr) as guint

#define g_datalist_id_set_data(dl, q, d) g_datalist_id_set_data_full((dl), (q), (d), NULL)
#define g_datalist_id_remove_data(dl, q) g_datalist_id_set_data((dl), (q), NULL)
#define g_datalist_set_data_full(dl, k, d, f) g_datalist_id_set_data_full((dl), g_quark_from_string(k), (d), (f))
#define g_datalist_remove_no_notify(dl, k) g_datalist_id_remove_no_notify((dl), g_quark_try_string(k))
#define g_datalist_set_data(dl, k, d) g_datalist_set_data_full((dl), (k), (d), NULL)
#define g_datalist_remove_data(dl, k) g_datalist_id_set_data((dl), g_quark_try_string(k), NULL)

declare sub g_dataset_destroy(byval dataset_location as gconstpointer)
declare function g_dataset_id_get_data(byval dataset_location as gconstpointer, byval key_id as GQuark) as gpointer
declare function g_datalist_get_data(byval datalist as GData ptr ptr, byval key as const gchar ptr) as gpointer
declare sub g_dataset_id_set_data_full(byval dataset_location as gconstpointer, byval key_id as GQuark, byval data as gpointer, byval destroy_func as GDestroyNotify)
declare function g_dataset_id_remove_no_notify(byval dataset_location as gconstpointer, byval key_id as GQuark) as gpointer
declare sub g_dataset_foreach(byval dataset_location as gconstpointer, byval func as GDataForeachFunc, byval user_data as gpointer)

#define g_dataset_id_set_data(l, k, d) g_dataset_id_set_data_full((l), (k), (d), NULL)
#define g_dataset_id_remove_data(l, k) g_dataset_id_set_data((l), (k), NULL)
#define g_dataset_get_data(l, k) g_dataset_id_get_data((l), g_quark_try_string(k))
#define g_dataset_set_data_full(l, k, d, f) g_dataset_id_set_data_full((l), g_quark_from_string(k), (d), (f))
#define g_dataset_remove_no_notify(l, k) g_dataset_id_remove_no_notify((l), g_quark_try_string(k))
#define g_dataset_set_data(l, k, d) g_dataset_set_data_full((l), (k), (d), NULL)
#define g_dataset_remove_data(l, k) g_dataset_id_set_data((l), g_quark_try_string(k), NULL)
#define __G_DATE_H__

type GTime as gint32
type GDateYear as guint16
type GDateDay as guint8
type GDate as _GDate

type GDateDMY as long
enum
	G_DATE_DAY_ = 0
	G_DATE_MONTH_ = 1
	G_DATE_YEAR_ = 2
end enum

type GDateWeekday as long
enum
	G_DATE_BAD_WEEKDAY = 0
	G_DATE_MONDAY = 1
	G_DATE_TUESDAY = 2
	G_DATE_WEDNESDAY = 3
	G_DATE_THURSDAY = 4
	G_DATE_FRIDAY = 5
	G_DATE_SATURDAY = 6
	G_DATE_SUNDAY = 7
end enum

type GDateMonth as long
enum
	G_DATE_BAD_MONTH = 0
	G_DATE_JANUARY = 1
	G_DATE_FEBRUARY = 2
	G_DATE_MARCH = 3
	G_DATE_APRIL = 4
	G_DATE_MAY = 5
	G_DATE_JUNE = 6
	G_DATE_JULY = 7
	G_DATE_AUGUST = 8
	G_DATE_SEPTEMBER = 9
	G_DATE_OCTOBER = 10
	G_DATE_NOVEMBER = 11
	G_DATE_DECEMBER = 12
end enum

const G_DATE_BAD_JULIAN = 0u
const G_DATE_BAD_DAY = 0u
const G_DATE_BAD_YEAR = 0u

type _GDate
	julian_days : 32 as guint
	julian : 1 as guint
	dmy : 1 as guint
	day : 6 as guint
	month : 4 as guint
	year : 16 as guint
end type

declare function g_date_new() as GDate ptr
declare function g_date_new_dmy(byval day as GDateDay, byval month as GDateMonth, byval year as GDateYear) as GDate ptr
declare function g_date_new_julian(byval julian_day as guint32) as GDate ptr
declare sub g_date_free(byval date as GDate ptr)
declare function g_date_valid(byval date as const GDate ptr) as gboolean
declare function g_date_valid_day(byval day as GDateDay) as gboolean
declare function g_date_valid_month(byval month as GDateMonth) as gboolean
declare function g_date_valid_year(byval year as GDateYear) as gboolean
declare function g_date_valid_weekday(byval weekday as GDateWeekday) as gboolean
declare function g_date_valid_julian(byval julian_date as guint32) as gboolean
declare function g_date_valid_dmy(byval day as GDateDay, byval month as GDateMonth, byval year as GDateYear) as gboolean
declare function g_date_get_weekday(byval date as const GDate ptr) as GDateWeekday
declare function g_date_get_month(byval date as const GDate ptr) as GDateMonth
declare function g_date_get_year(byval date as const GDate ptr) as GDateYear
declare function g_date_get_day(byval date as const GDate ptr) as GDateDay
declare function g_date_get_julian(byval date as const GDate ptr) as guint32
declare function g_date_get_day_of_year(byval date as const GDate ptr) as guint
declare function g_date_get_monday_week_of_year(byval date as const GDate ptr) as guint
declare function g_date_get_sunday_week_of_year(byval date as const GDate ptr) as guint
declare function g_date_get_iso8601_week_of_year(byval date as const GDate ptr) as guint
declare sub g_date_clear(byval date as GDate ptr, byval n_dates as guint)
declare sub g_date_set_parse(byval date as GDate ptr, byval str as const gchar ptr)
declare sub g_date_set_time_t(byval date as GDate ptr, byval timet as time_t)
declare sub g_date_set_time_val(byval date as GDate ptr, byval timeval as GTimeVal ptr)
declare sub g_date_set_time(byval date as GDate ptr, byval time_ as GTime)
declare sub g_date_set_month(byval date as GDate ptr, byval month as GDateMonth)
declare sub g_date_set_day(byval date as GDate ptr, byval day as GDateDay)
declare sub g_date_set_year(byval date as GDate ptr, byval year as GDateYear)
declare sub g_date_set_dmy(byval date as GDate ptr, byval day as GDateDay, byval month as GDateMonth, byval y as GDateYear)
declare sub g_date_set_julian(byval date as GDate ptr, byval julian_date as guint32)
declare function g_date_is_first_of_month(byval date as const GDate ptr) as gboolean
declare function g_date_is_last_of_month(byval date as const GDate ptr) as gboolean
declare sub g_date_add_days(byval date as GDate ptr, byval n_days as guint)
declare sub g_date_subtract_days(byval date as GDate ptr, byval n_days as guint)
declare sub g_date_add_months(byval date as GDate ptr, byval n_months as guint)
declare sub g_date_subtract_months(byval date as GDate ptr, byval n_months as guint)
declare sub g_date_add_years(byval date as GDate ptr, byval n_years as guint)
declare sub g_date_subtract_years(byval date as GDate ptr, byval n_years as guint)
declare function g_date_is_leap_year(byval year as GDateYear) as gboolean
declare function g_date_get_days_in_month(byval month as GDateMonth, byval year as GDateYear) as guint8
declare function g_date_get_monday_weeks_in_year(byval year as GDateYear) as guint8
declare function g_date_get_sunday_weeks_in_year(byval year as GDateYear) as guint8
declare function g_date_days_between(byval date1 as const GDate ptr, byval date2 as const GDate ptr) as gint
declare function g_date_compare(byval lhs as const GDate ptr, byval rhs as const GDate ptr) as gint
declare sub g_date_to_struct_tm(byval date as const GDate ptr, byval tm as tm ptr)
declare sub g_date_clamp(byval date as GDate ptr, byval min_date as const GDate ptr, byval max_date as const GDate ptr)
declare sub g_date_order(byval date1 as GDate ptr, byval date2 as GDate ptr)
declare function g_date_strftime(byval s as gchar ptr, byval slen as gsize, byval format as const gchar ptr, byval date as const GDate ptr) as gsize
declare function g_date_weekday alias "g_date_get_weekday"(byval date as const GDate ptr) as GDateWeekday
declare function g_date_month alias "g_date_get_month"(byval date as const GDate ptr) as GDateMonth
declare function g_date_year alias "g_date_get_year"(byval date as const GDate ptr) as GDateYear
declare function g_date_day alias "g_date_get_day"(byval date as const GDate ptr) as GDateDay
declare function g_date_julian alias "g_date_get_julian"(byval date as const GDate ptr) as guint32
declare function g_date_day_of_year alias "g_date_get_day_of_year"(byval date as const GDate ptr) as guint
declare function g_date_monday_week_of_year alias "g_date_get_monday_week_of_year"(byval date as const GDate ptr) as guint
declare function g_date_sunday_week_of_year alias "g_date_get_sunday_week_of_year"(byval date as const GDate ptr) as guint
declare function g_date_days_in_month alias "g_date_get_days_in_month"(byval month as GDateMonth, byval year as GDateYear) as guint8
declare function g_date_monday_weeks_in_year alias "g_date_get_monday_weeks_in_year"(byval year as GDateYear) as guint8
declare function g_date_sunday_weeks_in_year alias "g_date_get_sunday_weeks_in_year"(byval year as GDateYear) as guint8
#define __G_DATE_TIME_H__
#define __G_TIME_ZONE_H__
type GTimeZone as _GTimeZone

type GTimeType as long
enum
	G_TIME_TYPE_STANDARD
	G_TIME_TYPE_DAYLIGHT
	G_TIME_TYPE_UNIVERSAL
end enum

declare function g_time_zone_new(byval identifier as const gchar ptr) as GTimeZone ptr
declare function g_time_zone_new_utc() as GTimeZone ptr
declare function g_time_zone_new_local() as GTimeZone ptr
declare function g_time_zone_ref(byval tz as GTimeZone ptr) as GTimeZone ptr
declare sub g_time_zone_unref(byval tz as GTimeZone ptr)
declare function g_time_zone_find_interval(byval tz as GTimeZone ptr, byval type as GTimeType, byval time_ as gint64) as gint
declare function g_time_zone_adjust_time(byval tz as GTimeZone ptr, byval type as GTimeType, byval time_ as gint64 ptr) as gint
declare function g_time_zone_get_abbreviation(byval tz as GTimeZone ptr, byval interval as gint) as const gchar ptr
declare function g_time_zone_get_offset(byval tz as GTimeZone ptr, byval interval as gint) as gint32
declare function g_time_zone_is_dst(byval tz as GTimeZone ptr, byval interval as gint) as gboolean

#define G_TIME_SPAN_DAY G_GINT64_CONSTANT(86400000000)
#define G_TIME_SPAN_HOUR G_GINT64_CONSTANT(3600000000)
#define G_TIME_SPAN_MINUTE G_GINT64_CONSTANT(60000000)
#define G_TIME_SPAN_SECOND G_GINT64_CONSTANT(1000000)
#define G_TIME_SPAN_MILLISECOND G_GINT64_CONSTANT(1000)
type GTimeSpan as gint64
type GDateTime as _GDateTime

declare sub g_date_time_unref(byval datetime as GDateTime ptr)
declare function g_date_time_ref(byval datetime as GDateTime ptr) as GDateTime ptr
declare function g_date_time_new_now(byval tz as GTimeZone ptr) as GDateTime ptr
declare function g_date_time_new_now_local() as GDateTime ptr
declare function g_date_time_new_now_utc() as GDateTime ptr
declare function g_date_time_new_from_unix_local(byval t as gint64) as GDateTime ptr
declare function g_date_time_new_from_unix_utc(byval t as gint64) as GDateTime ptr
declare function g_date_time_new_from_timeval_local(byval tv as const GTimeVal ptr) as GDateTime ptr
declare function g_date_time_new_from_timeval_utc(byval tv as const GTimeVal ptr) as GDateTime ptr
declare function g_date_time_new(byval tz as GTimeZone ptr, byval year as gint, byval month as gint, byval day as gint, byval hour as gint, byval minute as gint, byval seconds as gdouble) as GDateTime ptr
declare function g_date_time_new_local(byval year as gint, byval month as gint, byval day as gint, byval hour as gint, byval minute as gint, byval seconds as gdouble) as GDateTime ptr
declare function g_date_time_new_utc(byval year as gint, byval month as gint, byval day as gint, byval hour as gint, byval minute as gint, byval seconds as gdouble) as GDateTime ptr
declare function g_date_time_add(byval datetime as GDateTime ptr, byval timespan as GTimeSpan) as GDateTime ptr
declare function g_date_time_add_years(byval datetime as GDateTime ptr, byval years as gint) as GDateTime ptr
declare function g_date_time_add_months(byval datetime as GDateTime ptr, byval months as gint) as GDateTime ptr
declare function g_date_time_add_weeks(byval datetime as GDateTime ptr, byval weeks as gint) as GDateTime ptr
declare function g_date_time_add_days(byval datetime as GDateTime ptr, byval days as gint) as GDateTime ptr
declare function g_date_time_add_hours(byval datetime as GDateTime ptr, byval hours as gint) as GDateTime ptr
declare function g_date_time_add_minutes(byval datetime as GDateTime ptr, byval minutes as gint) as GDateTime ptr
declare function g_date_time_add_seconds(byval datetime as GDateTime ptr, byval seconds as gdouble) as GDateTime ptr
declare function g_date_time_add_full(byval datetime as GDateTime ptr, byval years as gint, byval months as gint, byval days as gint, byval hours as gint, byval minutes as gint, byval seconds as gdouble) as GDateTime ptr
declare function g_date_time_compare(byval dt1 as gconstpointer, byval dt2 as gconstpointer) as gint
declare function g_date_time_difference(byval end as GDateTime ptr, byval begin as GDateTime ptr) as GTimeSpan
declare function g_date_time_hash(byval datetime as gconstpointer) as guint
declare function g_date_time_equal(byval dt1 as gconstpointer, byval dt2 as gconstpointer) as gboolean
declare sub g_date_time_get_ymd(byval datetime as GDateTime ptr, byval year as gint ptr, byval month as gint ptr, byval day as gint ptr)
declare function g_date_time_get_year(byval datetime as GDateTime ptr) as gint
declare function g_date_time_get_month(byval datetime as GDateTime ptr) as gint
declare function g_date_time_get_day_of_month(byval datetime as GDateTime ptr) as gint
declare function g_date_time_get_week_numbering_year(byval datetime as GDateTime ptr) as gint
declare function g_date_time_get_week_of_year(byval datetime as GDateTime ptr) as gint
declare function g_date_time_get_day_of_week(byval datetime as GDateTime ptr) as gint
declare function g_date_time_get_day_of_year(byval datetime as GDateTime ptr) as gint
declare function g_date_time_get_hour(byval datetime as GDateTime ptr) as gint
declare function g_date_time_get_minute(byval datetime as GDateTime ptr) as gint
declare function g_date_time_get_second(byval datetime as GDateTime ptr) as gint
declare function g_date_time_get_microsecond(byval datetime as GDateTime ptr) as gint
declare function g_date_time_get_seconds(byval datetime as GDateTime ptr) as gdouble
declare function g_date_time_to_unix(byval datetime as GDateTime ptr) as gint64
declare function g_date_time_to_timeval(byval datetime as GDateTime ptr, byval tv as GTimeVal ptr) as gboolean
declare function g_date_time_get_utc_offset(byval datetime as GDateTime ptr) as GTimeSpan
declare function g_date_time_get_timezone_abbreviation(byval datetime as GDateTime ptr) as const gchar ptr
declare function g_date_time_is_daylight_savings(byval datetime as GDateTime ptr) as gboolean
declare function g_date_time_to_timezone(byval datetime as GDateTime ptr, byval tz as GTimeZone ptr) as GDateTime ptr
declare function g_date_time_to_local(byval datetime as GDateTime ptr) as GDateTime ptr
declare function g_date_time_to_utc(byval datetime as GDateTime ptr) as GDateTime ptr
declare function g_date_time_format(byval datetime as GDateTime ptr, byval format as const gchar ptr) as gchar ptr
#define __G_DIR_H__
type GDir as _GDir

#ifdef __FB_UNIX__
	declare function g_dir_open(byval path as const gchar ptr, byval flags as guint, byval error as GError ptr ptr) as GDir ptr
	declare function g_dir_read_name(byval dir as GDir ptr) as const gchar ptr
#else
	declare function g_dir_open_ alias "g_dir_open"(byval path as const gchar ptr, byval flags as guint, byval error as GError ptr ptr) as GDir ptr
	declare function g_dir_read_name_ alias "g_dir_read_name"(byval dir as GDir ptr) as const gchar ptr
#endif

declare sub g_dir_rewind(byval dir as GDir ptr)
declare sub g_dir_close(byval dir as GDir ptr)

#ifdef __FB_WIN32__
	declare function g_dir_open_utf8(byval path as const gchar ptr, byval flags as guint, byval error as GError ptr ptr) as GDir ptr
	declare function g_dir_open alias "g_dir_open_utf8"(byval path as const gchar ptr, byval flags as guint, byval error as GError ptr ptr) as GDir ptr
	declare function g_dir_read_name_utf8(byval dir as GDir ptr) as const gchar ptr
	declare function g_dir_read_name alias "g_dir_read_name_utf8"(byval dir as GDir ptr) as const gchar ptr
#endif

#define __G_ENVIRON_H__

#ifdef __FB_UNIX__
	declare function g_getenv(byval variable as const gchar ptr) as const gchar ptr
	declare function g_setenv(byval variable as const gchar ptr, byval value as const gchar ptr, byval overwrite as gboolean) as gboolean
	declare sub g_unsetenv(byval variable as const gchar ptr)
#else
	declare function g_getenv_ alias "g_getenv"(byval variable as const gchar ptr) as const gchar ptr
	declare function g_setenv_ alias "g_setenv"(byval variable as const gchar ptr, byval value as const gchar ptr, byval overwrite as gboolean) as gboolean
	declare sub g_unsetenv_ alias "g_unsetenv"(byval variable as const gchar ptr)
#endif

declare function g_listenv() as gchar ptr ptr
declare function g_get_environ() as gchar ptr ptr
declare function g_environ_getenv(byval envp as gchar ptr ptr, byval variable as const gchar ptr) as const gchar ptr
declare function g_environ_setenv(byval envp as gchar ptr ptr, byval variable as const gchar ptr, byval value as const gchar ptr, byval overwrite as gboolean) as gchar ptr ptr
declare function g_environ_unsetenv(byval envp as gchar ptr ptr, byval variable as const gchar ptr) as gchar ptr ptr

#ifdef __FB_WIN32__
	declare function g_getenv_utf8(byval variable as const gchar ptr) as const gchar ptr
	declare function g_getenv alias "g_getenv_utf8"(byval variable as const gchar ptr) as const gchar ptr
	declare function g_setenv_utf8(byval variable as const gchar ptr, byval value as const gchar ptr, byval overwrite as gboolean) as gboolean
	declare function g_setenv alias "g_setenv_utf8"(byval variable as const gchar ptr, byval value as const gchar ptr, byval overwrite as gboolean) as gboolean
	declare sub g_unsetenv_utf8(byval variable as const gchar ptr)
	declare sub g_unsetenv alias "g_unsetenv_utf8"(byval variable as const gchar ptr)
#endif

#define __G_FILEUTILS_H__
#define G_FILE_ERROR g_file_error_quark()

type GFileError as long
enum
	G_FILE_ERROR_EXIST
	G_FILE_ERROR_ISDIR
	G_FILE_ERROR_ACCES
	G_FILE_ERROR_NAMETOOLONG
	G_FILE_ERROR_NOENT
	G_FILE_ERROR_NOTDIR
	G_FILE_ERROR_NXIO
	G_FILE_ERROR_NODEV
	G_FILE_ERROR_ROFS
	G_FILE_ERROR_TXTBSY
	G_FILE_ERROR_FAULT
	G_FILE_ERROR_LOOP
	G_FILE_ERROR_NOSPC
	G_FILE_ERROR_NOMEM
	G_FILE_ERROR_MFILE
	G_FILE_ERROR_NFILE
	G_FILE_ERROR_BADF
	G_FILE_ERROR_INVAL
	G_FILE_ERROR_PIPE
	G_FILE_ERROR_AGAIN
	G_FILE_ERROR_INTR
	G_FILE_ERROR_IO
	G_FILE_ERROR_PERM
	G_FILE_ERROR_NOSYS
	G_FILE_ERROR_FAILED
end enum

type GFileTest as long
enum
	G_FILE_TEST_IS_REGULAR = 1 shl 0
	G_FILE_TEST_IS_SYMLINK = 1 shl 1
	G_FILE_TEST_IS_DIR = 1 shl 2
	G_FILE_TEST_IS_EXECUTABLE = 1 shl 3
	G_FILE_TEST_EXISTS = 1 shl 4
end enum

declare function g_file_error_quark() as GQuark
declare function g_file_error_from_errno(byval err_no as gint) as GFileError

#ifdef __FB_UNIX__
	declare function g_file_test(byval filename as const gchar ptr, byval test as GFileTest) as gboolean
	declare function g_file_get_contents(byval filename as const gchar ptr, byval contents as gchar ptr ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gboolean
#else
	declare function g_file_test_ alias "g_file_test"(byval filename as const gchar ptr, byval test as GFileTest) as gboolean
	declare function g_file_get_contents_ alias "g_file_get_contents"(byval filename as const gchar ptr, byval contents as gchar ptr ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gboolean
#endif

declare function g_file_set_contents(byval filename as const gchar ptr, byval contents as const gchar ptr, byval length as gssize, byval error as GError ptr ptr) as gboolean
declare function g_file_read_link(byval filename as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_mkdtemp(byval tmpl as gchar ptr) as gchar ptr
declare function g_mkdtemp_full(byval tmpl as gchar ptr, byval mode as gint) as gchar ptr

#ifdef __FB_UNIX__
	declare function g_mkstemp(byval tmpl as gchar ptr) as gint
#else
	declare function g_mkstemp_ alias "g_mkstemp"(byval tmpl as gchar ptr) as gint
#endif

declare function g_mkstemp_full(byval tmpl as gchar ptr, byval flags as gint, byval mode as gint) as gint

#ifdef __FB_UNIX__
	declare function g_file_open_tmp(byval tmpl as const gchar ptr, byval name_used as gchar ptr ptr, byval error as GError ptr ptr) as gint
#else
	declare function g_file_open_tmp_ alias "g_file_open_tmp"(byval tmpl as const gchar ptr, byval name_used as gchar ptr ptr, byval error as GError ptr ptr) as gint
#endif

declare function g_dir_make_tmp(byval tmpl as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_build_path(byval separator as const gchar ptr, byval first_element as const gchar ptr, ...) as gchar ptr
declare function g_build_pathv(byval separator as const gchar ptr, byval args as gchar ptr ptr) as gchar ptr
declare function g_build_filename(byval first_element as const gchar ptr, ...) as gchar ptr
declare function g_build_filenamev(byval args as gchar ptr ptr) as gchar ptr
declare function g_mkdir_with_parents(byval pathname as const gchar ptr, byval mode as gint) as gint

#ifdef __FB_UNIX__
	#define G_DIR_SEPARATOR asc("/")
	#define G_DIR_SEPARATOR_S "/"
	#define G_IS_DIR_SEPARATOR(c) ((c) = G_DIR_SEPARATOR)
	#define G_SEARCHPATH_SEPARATOR asc(":")
	#define G_SEARCHPATH_SEPARATOR_S ":"
#else
	#define G_DIR_SEPARATOR asc(!"\\")
	#define G_DIR_SEPARATOR_S !"\\"
	#define G_IS_DIR_SEPARATOR(c) (((c) = G_DIR_SEPARATOR) orelse ((c) = asc("/")))
	#define G_SEARCHPATH_SEPARATOR asc(";")
	#define G_SEARCHPATH_SEPARATOR_S ";"
#endif

declare function g_path_is_absolute(byval file_name as const gchar ptr) as gboolean
declare function g_path_skip_root(byval file_name as const gchar ptr) as const gchar ptr
declare function g_basename(byval file_name as const gchar ptr) as const gchar ptr

#ifdef __FB_UNIX__
	declare function g_get_current_dir() as gchar ptr
#else
	declare function g_get_current_dir_ alias "g_get_current_dir"() as gchar ptr
#endif

declare function g_path_get_basename(byval file_name as const gchar ptr) as gchar ptr
declare function g_path_get_dirname(byval file_name as const gchar ptr) as gchar ptr
declare function g_dirname alias "g_path_get_dirname"(byval file_name as const gchar ptr) as gchar ptr

#ifdef __FB_WIN32__
	declare function g_file_test_utf8(byval filename as const gchar ptr, byval test as GFileTest) as gboolean
	declare function g_file_test alias "g_file_test_utf8"(byval filename as const gchar ptr, byval test as GFileTest) as gboolean
	declare function g_file_get_contents_utf8(byval filename as const gchar ptr, byval contents as gchar ptr ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gboolean
	declare function g_file_get_contents alias "g_file_get_contents_utf8"(byval filename as const gchar ptr, byval contents as gchar ptr ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gboolean
	declare function g_mkstemp_utf8(byval tmpl as gchar ptr) as gint
	declare function g_mkstemp alias "g_mkstemp_utf8"(byval tmpl as gchar ptr) as gint
	declare function g_file_open_tmp_utf8(byval tmpl as const gchar ptr, byval name_used as gchar ptr ptr, byval error as GError ptr ptr) as gint
	declare function g_file_open_tmp alias "g_file_open_tmp_utf8"(byval tmpl as const gchar ptr, byval name_used as gchar ptr ptr, byval error as GError ptr ptr) as gint
	declare function g_get_current_dir_utf8() as gchar ptr
	declare function g_get_current_dir alias "g_get_current_dir_utf8"() as gchar ptr
#endif

#define __G_GETTEXT_H__
declare function g_strip_context(byval msgid as const gchar ptr, byval msgval as const gchar ptr) as const gchar ptr
declare function g_dgettext(byval domain as const gchar ptr, byval msgid as const gchar ptr) as const gchar ptr
declare function g_dcgettext(byval domain as const gchar ptr, byval msgid as const gchar ptr, byval category as gint) as const gchar ptr
declare function g_dngettext(byval domain as const gchar ptr, byval msgid as const gchar ptr, byval msgid_plural as const gchar ptr, byval n as gulong) as const gchar ptr
declare function g_dpgettext(byval domain as const gchar ptr, byval msgctxtid as const gchar ptr, byval msgidoffset as gsize) as const gchar ptr
declare function g_dpgettext2(byval domain as const gchar ptr, byval context as const gchar ptr, byval msgid as const gchar ptr) as const gchar ptr

#define __G_HASH_H__
#define __G_LIST_H__
#define __G_MEM_H__
type GMemVTable as _GMemVTable

#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
	const G_MEM_ALIGN = GLIB_SIZEOF_VOID_P
#else
	const G_MEM_ALIGN = GLIB_SIZEOF_LONG
#endif

declare sub g_free(byval mem as gpointer)
declare sub g_clear_pointer(byval pp as gpointer ptr, byval destroy as GDestroyNotify)
declare function g_malloc(byval n_bytes as gsize) as gpointer
declare function g_malloc0(byval n_bytes as gsize) as gpointer
declare function g_realloc(byval mem as gpointer, byval n_bytes as gsize) as gpointer
declare function g_try_malloc(byval n_bytes as gsize) as gpointer
declare function g_try_malloc0(byval n_bytes as gsize) as gpointer
declare function g_try_realloc(byval mem as gpointer, byval n_bytes as gsize) as gpointer
declare function g_malloc_n(byval n_blocks as gsize, byval n_block_bytes as gsize) as gpointer
declare function g_malloc0_n(byval n_blocks as gsize, byval n_block_bytes as gsize) as gpointer
declare function g_realloc_n(byval mem as gpointer, byval n_blocks as gsize, byval n_block_bytes as gsize) as gpointer
declare function g_try_malloc_n(byval n_blocks as gsize, byval n_block_bytes as gsize) as gpointer
declare function g_try_malloc0_n(byval n_blocks as gsize, byval n_block_bytes as gsize) as gpointer
declare function g_try_realloc_n(byval mem as gpointer, byval n_blocks as gsize, byval n_block_bytes as gsize) as gpointer

private function g_steal_pointer_ alias "g_steal_pointer"(byval pp as gpointer) as gpointer
	dim ptr_ as gpointer ptr = cptr(gpointer ptr, pp)
	dim ref as gpointer
	ref = *ptr_
	(*ptr_) = cptr(any ptr, 0)
	return ref
end function

#define g_steal_pointer(pp) iif(0, *(pp), g_steal_pointer_(pp))
#define _G_NEW(struct_type, n_structs, func) cptr(struct_type ptr, g_##func##_n((n_structs), sizeof(struct_type)))
#define _G_RENEW(struct_type, mem, n_structs, func) cptr(struct_type ptr, g_##func##_n(mem, (n_structs), sizeof(struct_type)))
#define g_new(struct_type, n_structs) _G_NEW(struct_type, n_structs, malloc)
#define g_new0(struct_type, n_structs) _G_NEW(struct_type, n_structs, malloc0)
#define g_renew(struct_type, mem, n_structs) _G_RENEW(struct_type, mem, n_structs, realloc)
#define g_try_new(struct_type, n_structs) _G_NEW(struct_type, n_structs, try_malloc)
#define g_try_new0(struct_type, n_structs) _G_NEW(struct_type, n_structs, try_malloc0)
#define g_try_renew(struct_type, mem, n_structs) _G_RENEW(struct_type, mem, n_structs, try_realloc)

type _GMemVTable
	malloc as function(byval n_bytes as gsize) as gpointer
	realloc as function(byval mem as gpointer, byval n_bytes as gsize) as gpointer
	free as sub(byval mem as gpointer)
	calloc as function(byval n_blocks as gsize, byval n_block_bytes as gsize) as gpointer
	try_malloc as function(byval n_bytes as gsize) as gpointer
	try_realloc as function(byval mem as gpointer, byval n_bytes as gsize) as gpointer
end type

declare sub g_mem_set_vtable(byval vtable as GMemVTable ptr)
declare function g_mem_is_system_malloc() as gboolean

#if (defined(__FB_WIN32__) and (not defined(GLIB_STATIC_COMPILATION))) or defined(__FB_CYGWIN__)
	extern import g_mem_gc_friendly as gboolean
	extern import glib_mem_profiler_table as GMemVTable ptr
#else
	extern g_mem_gc_friendly as gboolean
	extern glib_mem_profiler_table as GMemVTable ptr
#endif

declare sub g_mem_profile()
#define __G_NODE_H__
type GNode as _GNode

type GTraverseFlags as long
enum
	G_TRAVERSE_LEAVES = 1 shl 0
	G_TRAVERSE_NON_LEAVES = 1 shl 1
	G_TRAVERSE_ALL = G_TRAVERSE_LEAVES or G_TRAVERSE_NON_LEAVES
	G_TRAVERSE_MASK = &h03
	G_TRAVERSE_LEAFS = G_TRAVERSE_LEAVES
	G_TRAVERSE_NON_LEAFS = G_TRAVERSE_NON_LEAVES
end enum

type GTraverseType as long
enum
	G_IN_ORDER
	G_PRE_ORDER
	G_POST_ORDER
	G_LEVEL_ORDER
end enum

type GNodeTraverseFunc as function(byval node as GNode ptr, byval data as gpointer) as gboolean
type GNodeForeachFunc as sub(byval node as GNode ptr, byval data as gpointer)
type GCopyFunc as function(byval src as gconstpointer, byval data as gpointer) as gpointer

type _GNode
	data as gpointer
	next as GNode ptr
	prev as GNode ptr
	parent as GNode ptr
	children as GNode ptr
end type

#define G_NODE_IS_ROOT(node) (((cptr(GNode ptr, (node))->parent = NULL) andalso (cptr(GNode ptr, (node))->prev = NULL)) andalso (cptr(GNode ptr, (node))->next = NULL))
#define G_NODE_IS_LEAF(node) (cptr(GNode ptr, (node))->children = NULL)
declare function g_node_new(byval data as gpointer) as GNode ptr
declare sub g_node_destroy(byval root as GNode ptr)
declare sub g_node_unlink(byval node as GNode ptr)
declare function g_node_copy_deep(byval node as GNode ptr, byval copy_func as GCopyFunc, byval data as gpointer) as GNode ptr
declare function g_node_copy(byval node as GNode ptr) as GNode ptr
declare function g_node_insert(byval parent as GNode ptr, byval position as gint, byval node as GNode ptr) as GNode ptr
declare function g_node_insert_before(byval parent as GNode ptr, byval sibling as GNode ptr, byval node as GNode ptr) as GNode ptr
declare function g_node_insert_after(byval parent as GNode ptr, byval sibling as GNode ptr, byval node as GNode ptr) as GNode ptr
declare function g_node_prepend(byval parent as GNode ptr, byval node as GNode ptr) as GNode ptr
declare function g_node_n_nodes(byval root as GNode ptr, byval flags as GTraverseFlags) as guint
declare function g_node_get_root(byval node as GNode ptr) as GNode ptr
declare function g_node_is_ancestor(byval node as GNode ptr, byval descendant as GNode ptr) as gboolean
declare function g_node_depth(byval node as GNode ptr) as guint
declare function g_node_find(byval root as GNode ptr, byval order as GTraverseType, byval flags as GTraverseFlags, byval data as gpointer) as GNode ptr

#define g_node_append(parent, node) g_node_insert_before((parent), NULL, (node))
#define g_node_insert_data(parent, position, data) g_node_insert((parent), (position), g_node_new(data))
#define g_node_insert_data_after(parent, sibling, data) g_node_insert_after((parent), (sibling), g_node_new(data))
#define g_node_insert_data_before(parent, sibling, data) g_node_insert_before((parent), (sibling), g_node_new(data))
#define g_node_prepend_data(parent, data) g_node_prepend((parent), g_node_new(data))
#define g_node_append_data(parent, data) g_node_insert_before((parent), NULL, g_node_new(data))

declare sub g_node_traverse(byval root as GNode ptr, byval order as GTraverseType, byval flags as GTraverseFlags, byval max_depth as gint, byval func as GNodeTraverseFunc, byval data as gpointer)
declare function g_node_max_height(byval root as GNode ptr) as guint
declare sub g_node_children_foreach(byval node as GNode ptr, byval flags as GTraverseFlags, byval func as GNodeForeachFunc, byval data as gpointer)
declare sub g_node_reverse_children(byval node as GNode ptr)
declare function g_node_n_children(byval node as GNode ptr) as guint
declare function g_node_nth_child(byval node as GNode ptr, byval n as guint) as GNode ptr
declare function g_node_last_child(byval node as GNode ptr) as GNode ptr
declare function g_node_find_child(byval node as GNode ptr, byval flags as GTraverseFlags, byval data as gpointer) as GNode ptr
declare function g_node_child_position(byval node as GNode ptr, byval child as GNode ptr) as gint
declare function g_node_child_index(byval node as GNode ptr, byval data as gpointer) as gint
declare function g_node_first_sibling(byval node as GNode ptr) as GNode ptr
declare function g_node_last_sibling(byval node as GNode ptr) as GNode ptr

#define g_node_prev_sibling(node) iif((node), cptr(GNode ptr, (node))->prev, NULL)
#define g_node_next_sibling(node) iif((node), cptr(GNode ptr, (node))->next, NULL)
#define g_node_first_child(node) iif((node), cptr(GNode ptr, (node))->children, NULL)
type GList as _GList

type _GList
	data as gpointer
	next as GList ptr
	prev as GList ptr
end type

declare function g_list_alloc() as GList ptr
declare sub g_list_free(byval list as GList ptr)
declare sub g_list_free_1(byval list as GList ptr)
declare sub g_list_free1 alias "g_list_free_1"(byval list as GList ptr)
declare sub g_list_free_full(byval list as GList ptr, byval free_func as GDestroyNotify)
declare function g_list_append(byval list as GList ptr, byval data as gpointer) as GList ptr
declare function g_list_prepend(byval list as GList ptr, byval data as gpointer) as GList ptr
declare function g_list_insert(byval list as GList ptr, byval data as gpointer, byval position as gint) as GList ptr
declare function g_list_insert_sorted(byval list as GList ptr, byval data as gpointer, byval func as GCompareFunc) as GList ptr
declare function g_list_insert_sorted_with_data(byval list as GList ptr, byval data as gpointer, byval func as GCompareDataFunc, byval user_data as gpointer) as GList ptr
declare function g_list_insert_before(byval list as GList ptr, byval sibling as GList ptr, byval data as gpointer) as GList ptr
declare function g_list_concat(byval list1 as GList ptr, byval list2 as GList ptr) as GList ptr
declare function g_list_remove(byval list as GList ptr, byval data as gconstpointer) as GList ptr
declare function g_list_remove_all(byval list as GList ptr, byval data as gconstpointer) as GList ptr
declare function g_list_remove_link(byval list as GList ptr, byval llink as GList ptr) as GList ptr
declare function g_list_delete_link(byval list as GList ptr, byval link_ as GList ptr) as GList ptr
declare function g_list_reverse(byval list as GList ptr) as GList ptr
declare function g_list_copy(byval list as GList ptr) as GList ptr
declare function g_list_copy_deep(byval list as GList ptr, byval func as GCopyFunc, byval user_data as gpointer) as GList ptr
declare function g_list_nth(byval list as GList ptr, byval n as guint) as GList ptr
declare function g_list_nth_prev(byval list as GList ptr, byval n as guint) as GList ptr
declare function g_list_find(byval list as GList ptr, byval data as gconstpointer) as GList ptr
declare function g_list_find_custom(byval list as GList ptr, byval data as gconstpointer, byval func as GCompareFunc) as GList ptr
declare function g_list_position(byval list as GList ptr, byval llink as GList ptr) as gint
declare function g_list_index(byval list as GList ptr, byval data as gconstpointer) as gint
declare function g_list_last(byval list as GList ptr) as GList ptr
declare function g_list_first(byval list as GList ptr) as GList ptr
declare function g_list_length(byval list as GList ptr) as guint
declare sub g_list_foreach(byval list as GList ptr, byval func as GFunc, byval user_data as gpointer)
declare function g_list_sort(byval list as GList ptr, byval compare_func as GCompareFunc) as GList ptr
declare function g_list_sort_with_data(byval list as GList ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer) as GList ptr
declare function g_list_nth_data(byval list as GList ptr, byval n as guint) as gpointer
#define g_list_previous(list) iif((list), cptr(GList ptr, (list))->prev, NULL)
#define g_list_next(list) iif((list), cptr(GList ptr, (list))->next, NULL)

type GHashTable as _GHashTable
type GHRFunc as function(byval key as gpointer, byval value as gpointer, byval user_data as gpointer) as gboolean
type GHashTableIter as _GHashTableIter

type _GHashTableIter
	dummy1 as gpointer
	dummy2 as gpointer
	dummy3 as gpointer
	dummy4 as long
	dummy5 as gboolean
	dummy6 as gpointer
end type

declare function g_hash_table_new(byval hash_func as GHashFunc, byval key_equal_func as GEqualFunc) as GHashTable ptr
declare function g_hash_table_new_full(byval hash_func as GHashFunc, byval key_equal_func as GEqualFunc, byval key_destroy_func as GDestroyNotify, byval value_destroy_func as GDestroyNotify) as GHashTable ptr
declare sub g_hash_table_destroy(byval hash_table as GHashTable ptr)
declare function g_hash_table_insert(byval hash_table as GHashTable ptr, byval key as gpointer, byval value as gpointer) as gboolean
declare function g_hash_table_replace(byval hash_table as GHashTable ptr, byval key as gpointer, byval value as gpointer) as gboolean
declare function g_hash_table_add(byval hash_table as GHashTable ptr, byval key as gpointer) as gboolean
declare function g_hash_table_remove(byval hash_table as GHashTable ptr, byval key as gconstpointer) as gboolean
declare sub g_hash_table_remove_all(byval hash_table as GHashTable ptr)
declare function g_hash_table_steal(byval hash_table as GHashTable ptr, byval key as gconstpointer) as gboolean
declare sub g_hash_table_steal_all(byval hash_table as GHashTable ptr)
declare function g_hash_table_lookup(byval hash_table as GHashTable ptr, byval key as gconstpointer) as gpointer
declare function g_hash_table_contains(byval hash_table as GHashTable ptr, byval key as gconstpointer) as gboolean
declare function g_hash_table_lookup_extended(byval hash_table as GHashTable ptr, byval lookup_key as gconstpointer, byval orig_key as gpointer ptr, byval value as gpointer ptr) as gboolean
declare sub g_hash_table_foreach(byval hash_table as GHashTable ptr, byval func as GHFunc, byval user_data as gpointer)
declare function g_hash_table_find(byval hash_table as GHashTable ptr, byval predicate as GHRFunc, byval user_data as gpointer) as gpointer
declare function g_hash_table_foreach_remove(byval hash_table as GHashTable ptr, byval func as GHRFunc, byval user_data as gpointer) as guint
declare function g_hash_table_foreach_steal(byval hash_table as GHashTable ptr, byval func as GHRFunc, byval user_data as gpointer) as guint
declare function g_hash_table_size(byval hash_table as GHashTable ptr) as guint
declare function g_hash_table_get_keys(byval hash_table as GHashTable ptr) as GList ptr
declare function g_hash_table_get_values(byval hash_table as GHashTable ptr) as GList ptr
declare function g_hash_table_get_keys_as_array(byval hash_table as GHashTable ptr, byval length as guint ptr) as gpointer ptr
declare sub g_hash_table_iter_init(byval iter as GHashTableIter ptr, byval hash_table as GHashTable ptr)
declare function g_hash_table_iter_next(byval iter as GHashTableIter ptr, byval key as gpointer ptr, byval value as gpointer ptr) as gboolean
declare function g_hash_table_iter_get_hash_table(byval iter as GHashTableIter ptr) as GHashTable ptr
declare sub g_hash_table_iter_remove(byval iter as GHashTableIter ptr)
declare sub g_hash_table_iter_replace(byval iter as GHashTableIter ptr, byval value as gpointer)
declare sub g_hash_table_iter_steal(byval iter as GHashTableIter ptr)
declare function g_hash_table_ref(byval hash_table as GHashTable ptr) as GHashTable ptr
declare sub g_hash_table_unref(byval hash_table as GHashTable ptr)
#define g_hash_table_freeze(hash_table) 0
#define g_hash_table_thaw(hash_table) 0
declare function g_str_equal(byval v1 as gconstpointer, byval v2 as gconstpointer) as gboolean
declare function g_str_hash(byval v as gconstpointer) as guint
declare function g_int_equal(byval v1 as gconstpointer, byval v2 as gconstpointer) as gboolean
declare function g_int_hash(byval v as gconstpointer) as guint
declare function g_int64_equal(byval v1 as gconstpointer, byval v2 as gconstpointer) as gboolean
declare function g_int64_hash(byval v as gconstpointer) as guint
declare function g_double_equal(byval v1 as gconstpointer, byval v2 as gconstpointer) as gboolean
declare function g_double_hash(byval v as gconstpointer) as guint
declare function g_direct_hash(byval v as gconstpointer) as guint
declare function g_direct_equal(byval v1 as gconstpointer, byval v2 as gconstpointer) as gboolean
#define __G_HMAC_H__
type GHmac as _GHmac
declare function g_hmac_new(byval digest_type as GChecksumType, byval key as const guchar ptr, byval key_len as gsize) as GHmac ptr
declare function g_hmac_copy(byval hmac as const GHmac ptr) as GHmac ptr
declare function g_hmac_ref(byval hmac as GHmac ptr) as GHmac ptr
declare sub g_hmac_unref(byval hmac as GHmac ptr)
declare sub g_hmac_update(byval hmac as GHmac ptr, byval data as const guchar ptr, byval length as gssize)
declare function g_hmac_get_string(byval hmac as GHmac ptr) as const gchar ptr
declare sub g_hmac_get_digest(byval hmac as GHmac ptr, byval buffer as guint8 ptr, byval digest_len as gsize ptr)
declare function g_compute_hmac_for_data(byval digest_type as GChecksumType, byval key as const guchar ptr, byval key_len as gsize, byval data as const guchar ptr, byval length as gsize) as gchar ptr
declare function g_compute_hmac_for_string(byval digest_type as GChecksumType, byval key as const guchar ptr, byval key_len as gsize, byval str as const gchar ptr, byval length as gssize) as gchar ptr
#define __G_HOOK_H__

type GHook as _GHook
type GHookList as _GHookList
type GHookCompareFunc as function(byval new_hook as GHook ptr, byval sibling as GHook ptr) as gint
type GHookFindFunc as function(byval hook as GHook ptr, byval data as gpointer) as gboolean
type GHookMarshaller as sub(byval hook as GHook ptr, byval marshal_data as gpointer)
type GHookCheckMarshaller as function(byval hook as GHook ptr, byval marshal_data as gpointer) as gboolean
type GHookFunc as sub(byval data as gpointer)
type GHookCheckFunc as function(byval data as gpointer) as gboolean
type GHookFinalizeFunc as sub(byval hook_list as GHookList ptr, byval hook as GHook ptr)

type GHookFlagMask as long
enum
	G_HOOK_FLAG_ACTIVE = 1 shl 0
	G_HOOK_FLAG_IN_CALL = 1 shl 1
	G_HOOK_FLAG_MASK = &h0f
end enum

const G_HOOK_FLAG_USER_SHIFT = 4

type _GHookList
	seq_id as gulong
	hook_size : 16 as guint
	is_setup : 1 as guint
	hooks as GHook ptr
	dummy3 as gpointer
	finalize_hook as GHookFinalizeFunc
	dummy(0 to 1) as gpointer
end type

type _GHook
	data as gpointer
	next as GHook ptr
	prev as GHook ptr
	ref_count as guint
	hook_id as gulong
	flags as guint
	func as gpointer
	destroy as GDestroyNotify
end type

#define G_HOOK(hook) cptr(GHook ptr, (hook))
#define G_HOOK_FLAGS(hook) G_HOOK(hook)->flags
#define G_HOOK_ACTIVE(hook) ((G_HOOK_FLAGS(hook) and G_HOOK_FLAG_ACTIVE) <> 0)
#define G_HOOK_IN_CALL(hook) ((G_HOOK_FLAGS(hook) and G_HOOK_FLAG_IN_CALL) <> 0)
#define G_HOOK_IS_VALID(hook) ((G_HOOK(hook)->hook_id <> 0) andalso (G_HOOK_FLAGS(hook) and G_HOOK_FLAG_ACTIVE))
#define G_HOOK_IS_UNLINKED(hook) ((((G_HOOK(hook)->next = NULL) andalso (G_HOOK(hook)->prev = NULL)) andalso (G_HOOK(hook)->hook_id = 0)) andalso (G_HOOK(hook)->ref_count = 0))

declare sub g_hook_list_init(byval hook_list as GHookList ptr, byval hook_size as guint)
declare sub g_hook_list_clear(byval hook_list as GHookList ptr)
declare function g_hook_alloc(byval hook_list as GHookList ptr) as GHook ptr
declare sub g_hook_free(byval hook_list as GHookList ptr, byval hook as GHook ptr)
declare function g_hook_ref(byval hook_list as GHookList ptr, byval hook as GHook ptr) as GHook ptr
declare sub g_hook_unref(byval hook_list as GHookList ptr, byval hook as GHook ptr)
declare function g_hook_destroy(byval hook_list as GHookList ptr, byval hook_id as gulong) as gboolean
declare sub g_hook_destroy_link(byval hook_list as GHookList ptr, byval hook as GHook ptr)
declare sub g_hook_prepend(byval hook_list as GHookList ptr, byval hook as GHook ptr)
declare sub g_hook_insert_before(byval hook_list as GHookList ptr, byval sibling as GHook ptr, byval hook as GHook ptr)
declare sub g_hook_insert_sorted(byval hook_list as GHookList ptr, byval hook as GHook ptr, byval func as GHookCompareFunc)
declare function g_hook_get(byval hook_list as GHookList ptr, byval hook_id as gulong) as GHook ptr
declare function g_hook_find(byval hook_list as GHookList ptr, byval need_valids as gboolean, byval func as GHookFindFunc, byval data as gpointer) as GHook ptr
declare function g_hook_find_data(byval hook_list as GHookList ptr, byval need_valids as gboolean, byval data as gpointer) as GHook ptr
declare function g_hook_find_func(byval hook_list as GHookList ptr, byval need_valids as gboolean, byval func as gpointer) as GHook ptr
declare function g_hook_find_func_data(byval hook_list as GHookList ptr, byval need_valids as gboolean, byval func as gpointer, byval data as gpointer) as GHook ptr
declare function g_hook_first_valid(byval hook_list as GHookList ptr, byval may_be_in_call as gboolean) as GHook ptr
declare function g_hook_next_valid(byval hook_list as GHookList ptr, byval hook as GHook ptr, byval may_be_in_call as gboolean) as GHook ptr
declare function g_hook_compare_ids(byval new_hook as GHook ptr, byval sibling as GHook ptr) as gint
#define g_hook_append(hook_list, hook) g_hook_insert_before((hook_list), NULL, (hook))
declare sub g_hook_list_invoke(byval hook_list as GHookList ptr, byval may_recurse as gboolean)
declare sub g_hook_list_invoke_check(byval hook_list as GHookList ptr, byval may_recurse as gboolean)
declare sub g_hook_list_marshal(byval hook_list as GHookList ptr, byval may_recurse as gboolean, byval marshaller as GHookMarshaller, byval marshal_data as gpointer)
declare sub g_hook_list_marshal_check(byval hook_list as GHookList ptr, byval may_recurse as gboolean, byval marshaller as GHookCheckMarshaller, byval marshal_data as gpointer)
#define __G_HOST_UTILS_H__
declare function g_hostname_is_non_ascii(byval hostname as const gchar ptr) as gboolean
declare function g_hostname_is_ascii_encoded(byval hostname as const gchar ptr) as gboolean
declare function g_hostname_is_ip_address(byval hostname as const gchar ptr) as gboolean
declare function g_hostname_to_ascii(byval hostname as const gchar ptr) as gchar ptr
declare function g_hostname_to_unicode(byval hostname as const gchar ptr) as gchar ptr

#define __G_IOCHANNEL_H__
#define __G_MAIN_H__
#define __G_POLL_H__
type GPollFD as _GPollFD
type GPollFunc as function(byval ufds as GPollFD ptr, byval nfsd as guint, byval timeout_ as gint) as gint

type _GPollFD
	#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
		fd as gint64
	#else
		fd as gint
	#endif

	events as gushort
	revents as gushort
end type

#ifdef __FB_UNIX__
	#define G_POLLFD_FORMAT "%d"
#elseif defined(__FB_WIN32__) and (not defined(__FB_64BIT__))
	#define G_POLLFD_FORMAT "%#x"
#else
	#define G_POLLFD_FORMAT "%#I64x"
#endif

declare function g_poll(byval fds as GPollFD ptr, byval nfds as guint, byval timeout as gint) as gint
#define __G_SLIST_H__
type GSList as _GSList

type _GSList
	data as gpointer
	next as GSList ptr
end type

declare function g_slist_alloc() as GSList ptr
declare sub g_slist_free(byval list as GSList ptr)
declare sub g_slist_free_1(byval list as GSList ptr)
declare sub g_slist_free1 alias "g_slist_free_1"(byval list as GSList ptr)
declare sub g_slist_free_full(byval list as GSList ptr, byval free_func as GDestroyNotify)
declare function g_slist_append(byval list as GSList ptr, byval data as gpointer) as GSList ptr
declare function g_slist_prepend(byval list as GSList ptr, byval data as gpointer) as GSList ptr
declare function g_slist_insert(byval list as GSList ptr, byval data as gpointer, byval position as gint) as GSList ptr
declare function g_slist_insert_sorted(byval list as GSList ptr, byval data as gpointer, byval func as GCompareFunc) as GSList ptr
declare function g_slist_insert_sorted_with_data(byval list as GSList ptr, byval data as gpointer, byval func as GCompareDataFunc, byval user_data as gpointer) as GSList ptr
declare function g_slist_insert_before(byval slist as GSList ptr, byval sibling as GSList ptr, byval data as gpointer) as GSList ptr
declare function g_slist_concat(byval list1 as GSList ptr, byval list2 as GSList ptr) as GSList ptr
declare function g_slist_remove(byval list as GSList ptr, byval data as gconstpointer) as GSList ptr
declare function g_slist_remove_all(byval list as GSList ptr, byval data as gconstpointer) as GSList ptr
declare function g_slist_remove_link(byval list as GSList ptr, byval link_ as GSList ptr) as GSList ptr
declare function g_slist_delete_link(byval list as GSList ptr, byval link_ as GSList ptr) as GSList ptr
declare function g_slist_reverse(byval list as GSList ptr) as GSList ptr
declare function g_slist_copy(byval list as GSList ptr) as GSList ptr
declare function g_slist_copy_deep(byval list as GSList ptr, byval func as GCopyFunc, byval user_data as gpointer) as GSList ptr
declare function g_slist_nth(byval list as GSList ptr, byval n as guint) as GSList ptr
declare function g_slist_find(byval list as GSList ptr, byval data as gconstpointer) as GSList ptr
declare function g_slist_find_custom(byval list as GSList ptr, byval data as gconstpointer, byval func as GCompareFunc) as GSList ptr
declare function g_slist_position(byval list as GSList ptr, byval llink as GSList ptr) as gint
declare function g_slist_index(byval list as GSList ptr, byval data as gconstpointer) as gint
declare function g_slist_last(byval list as GSList ptr) as GSList ptr
declare function g_slist_length(byval list as GSList ptr) as guint
declare sub g_slist_foreach(byval list as GSList ptr, byval func as GFunc, byval user_data as gpointer)
declare function g_slist_sort(byval list as GSList ptr, byval compare_func as GCompareFunc) as GSList ptr
declare function g_slist_sort_with_data(byval list as GSList ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer) as GSList ptr
declare function g_slist_nth_data(byval list as GSList ptr, byval n as guint) as gpointer
#define g_slist_next(slist) iif((slist), cptr(GSList ptr, (slist))->next, NULL)

type GIOCondition as long
enum
	G_IO_IN = 1
	G_IO_OUT = 4
	G_IO_PRI = 2
	G_IO_ERR = 8
	G_IO_HUP = 16
	G_IO_NVAL = 32
end enum

type GMainContext as _GMainContext
type GMainLoop as _GMainLoop
type GSource as _GSource
type GSourcePrivate as _GSourcePrivate
type GSourceCallbackFuncs as _GSourceCallbackFuncs
type GSourceFuncs as _GSourceFuncs
type GSourceFunc as function(byval user_data as gpointer) as gboolean
type GChildWatchFunc as sub(byval pid as GPid, byval status as gint, byval user_data as gpointer)

type _GSource
	callback_data as gpointer
	callback_funcs as GSourceCallbackFuncs ptr
	source_funcs as const GSourceFuncs ptr
	ref_count as guint
	context as GMainContext ptr
	priority as gint
	flags as guint
	source_id as guint
	poll_fds as GSList ptr
	prev as GSource ptr
	next as GSource ptr
	name as zstring ptr
	priv as GSourcePrivate ptr
end type

type _GSourceCallbackFuncs
	ref as sub(byval cb_data as gpointer)
	unref as sub(byval cb_data as gpointer)
	get as sub(byval cb_data as gpointer, byval source as GSource ptr, byval func as GSourceFunc ptr, byval data as gpointer ptr)
end type

type GSourceDummyMarshal as sub()

type _GSourceFuncs
	prepare as function(byval source as GSource ptr, byval timeout_ as gint ptr) as gboolean
	check as function(byval source as GSource ptr) as gboolean
	dispatch as function(byval source as GSource ptr, byval callback as GSourceFunc, byval user_data as gpointer) as gboolean
	finalize as sub(byval source as GSource ptr)
	closure_callback as GSourceFunc
	closure_marshal as GSourceDummyMarshal
end type

const G_PRIORITY_HIGH = -100
const G_PRIORITY_DEFAULT = 0
const G_PRIORITY_HIGH_IDLE = 100
const G_PRIORITY_DEFAULT_IDLE = 200
const G_PRIORITY_LOW = 300
const G_SOURCE_REMOVE = FALSE
const G_SOURCE_CONTINUE = CTRUE

declare function g_main_context_new() as GMainContext ptr
declare function g_main_context_ref(byval context as GMainContext ptr) as GMainContext ptr
declare sub g_main_context_unref(byval context as GMainContext ptr)
declare function g_main_context_default() as GMainContext ptr
declare function g_main_context_iteration(byval context as GMainContext ptr, byval may_block as gboolean) as gboolean
declare function g_main_context_pending(byval context as GMainContext ptr) as gboolean
declare function g_main_context_find_source_by_id(byval context as GMainContext ptr, byval source_id as guint) as GSource ptr
declare function g_main_context_find_source_by_user_data(byval context as GMainContext ptr, byval user_data as gpointer) as GSource ptr
declare function g_main_context_find_source_by_funcs_user_data(byval context as GMainContext ptr, byval funcs as GSourceFuncs ptr, byval user_data as gpointer) as GSource ptr
declare sub g_main_context_wakeup(byval context as GMainContext ptr)
declare function g_main_context_acquire(byval context as GMainContext ptr) as gboolean
declare sub g_main_context_release(byval context as GMainContext ptr)
declare function g_main_context_is_owner(byval context as GMainContext ptr) as gboolean
declare function g_main_context_wait(byval context as GMainContext ptr, byval cond as GCond ptr, byval mutex as GMutex ptr) as gboolean
declare function g_main_context_prepare(byval context as GMainContext ptr, byval priority as gint ptr) as gboolean
declare function g_main_context_query(byval context as GMainContext ptr, byval max_priority as gint, byval timeout_ as gint ptr, byval fds as GPollFD ptr, byval n_fds as gint) as gint
declare function g_main_context_check(byval context as GMainContext ptr, byval max_priority as gint, byval fds as GPollFD ptr, byval n_fds as gint) as gint
declare sub g_main_context_dispatch(byval context as GMainContext ptr)
declare sub g_main_context_set_poll_func(byval context as GMainContext ptr, byval func as GPollFunc)
declare function g_main_context_get_poll_func(byval context as GMainContext ptr) as GPollFunc
declare sub g_main_context_add_poll(byval context as GMainContext ptr, byval fd as GPollFD ptr, byval priority as gint)
declare sub g_main_context_remove_poll(byval context as GMainContext ptr, byval fd as GPollFD ptr)
declare function g_main_depth() as gint
declare function g_main_current_source() as GSource ptr
declare sub g_main_context_push_thread_default(byval context as GMainContext ptr)
declare sub g_main_context_pop_thread_default(byval context as GMainContext ptr)
declare function g_main_context_get_thread_default() as GMainContext ptr
declare function g_main_context_ref_thread_default() as GMainContext ptr
declare function g_main_loop_new(byval context as GMainContext ptr, byval is_running as gboolean) as GMainLoop ptr
declare sub g_main_loop_run(byval loop as GMainLoop ptr)
declare sub g_main_loop_quit(byval loop as GMainLoop ptr)
declare function g_main_loop_ref(byval loop as GMainLoop ptr) as GMainLoop ptr
declare sub g_main_loop_unref(byval loop as GMainLoop ptr)
declare function g_main_loop_is_running(byval loop as GMainLoop ptr) as gboolean
declare function g_main_loop_get_context(byval loop as GMainLoop ptr) as GMainContext ptr
declare function g_source_new(byval source_funcs as GSourceFuncs ptr, byval struct_size as guint) as GSource ptr
declare function g_source_ref(byval source as GSource ptr) as GSource ptr
declare sub g_source_unref(byval source as GSource ptr)
declare function g_source_attach(byval source as GSource ptr, byval context as GMainContext ptr) as guint
declare sub g_source_destroy(byval source as GSource ptr)
declare sub g_source_set_priority(byval source as GSource ptr, byval priority as gint)
declare function g_source_get_priority(byval source as GSource ptr) as gint
declare sub g_source_set_can_recurse(byval source as GSource ptr, byval can_recurse as gboolean)
declare function g_source_get_can_recurse(byval source as GSource ptr) as gboolean
declare function g_source_get_id(byval source as GSource ptr) as guint
declare function g_source_get_context(byval source as GSource ptr) as GMainContext ptr
declare sub g_source_set_callback(byval source as GSource ptr, byval func as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify)
declare sub g_source_set_funcs(byval source as GSource ptr, byval funcs as GSourceFuncs ptr)
declare function g_source_is_destroyed(byval source as GSource ptr) as gboolean
declare sub g_source_set_name(byval source as GSource ptr, byval name as const zstring ptr)
declare function g_source_get_name(byval source as GSource ptr) as const zstring ptr
declare sub g_source_set_name_by_id(byval tag as guint, byval name as const zstring ptr)
declare sub g_source_set_ready_time(byval source as GSource ptr, byval ready_time as gint64)
declare function g_source_get_ready_time(byval source as GSource ptr) as gint64

#ifdef __FB_UNIX__
	declare function g_source_add_unix_fd(byval source as GSource ptr, byval fd as gint, byval events as GIOCondition) as gpointer
	declare sub g_source_modify_unix_fd(byval source as GSource ptr, byval tag as gpointer, byval new_events as GIOCondition)
	declare sub g_source_remove_unix_fd(byval source as GSource ptr, byval tag as gpointer)
	declare function g_source_query_unix_fd(byval source as GSource ptr, byval tag as gpointer) as GIOCondition
#endif

declare sub g_source_set_callback_indirect(byval source as GSource ptr, byval callback_data as gpointer, byval callback_funcs as GSourceCallbackFuncs ptr)
declare sub g_source_add_poll(byval source as GSource ptr, byval fd as GPollFD ptr)
declare sub g_source_remove_poll(byval source as GSource ptr, byval fd as GPollFD ptr)
declare sub g_source_add_child_source(byval source as GSource ptr, byval child_source as GSource ptr)
declare sub g_source_remove_child_source(byval source as GSource ptr, byval child_source as GSource ptr)
declare sub g_source_get_current_time(byval source as GSource ptr, byval timeval as GTimeVal ptr)
declare function g_source_get_time(byval source as GSource ptr) as gint64
declare function g_idle_source_new() as GSource ptr
declare function g_child_watch_source_new(byval pid as GPid) as GSource ptr
declare function g_timeout_source_new(byval interval as guint) as GSource ptr
declare function g_timeout_source_new_seconds(byval interval as guint) as GSource ptr
declare sub g_get_current_time(byval result as GTimeVal ptr)
declare function g_get_monotonic_time() as gint64
declare function g_get_real_time() as gint64
declare function g_source_remove_ alias "g_source_remove"(byval tag as guint) as gboolean
declare function g_source_remove_by_user_data(byval user_data as gpointer) as gboolean
declare function g_source_remove_by_funcs_user_data(byval funcs as GSourceFuncs ptr, byval user_data as gpointer) as gboolean
declare function g_timeout_add_full(byval priority as gint, byval interval as guint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function g_timeout_add(byval interval as guint, byval function as GSourceFunc, byval data as gpointer) as guint
declare function g_timeout_add_seconds_full(byval priority as gint, byval interval as guint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function g_timeout_add_seconds(byval interval as guint, byval function as GSourceFunc, byval data as gpointer) as guint
declare function g_child_watch_add_full(byval priority as gint, byval pid as GPid, byval function as GChildWatchFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function g_child_watch_add(byval pid as GPid, byval function as GChildWatchFunc, byval data as gpointer) as guint
declare function g_idle_add(byval function as GSourceFunc, byval data as gpointer) as guint
declare function g_idle_add_full(byval priority as gint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function g_idle_remove_by_data(byval data as gpointer) as gboolean
declare sub g_main_context_invoke_full(byval context as GMainContext ptr, byval priority as gint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify)
declare sub g_main_context_invoke(byval context as GMainContext ptr, byval function as GSourceFunc, byval data as gpointer)

#if defined(__FB_DARWIN__) or (defined(__FB_WIN32__) and defined(GLIB_STATIC_COMPILATION)) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
	extern g_timeout_funcs as GSourceFuncs
	extern g_child_watch_funcs as GSourceFuncs
	extern g_idle_funcs as GSourceFuncs
#endif

#if defined(__FB_DARWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
	extern g_unix_signal_funcs as GSourceFuncs
	extern g_unix_fd_source_funcs as GSourceFuncs
#elseif (defined(__FB_WIN32__) and (not defined(GLIB_STATIC_COMPILATION))) or defined(__FB_CYGWIN__)
	extern import g_timeout_funcs as GSourceFuncs
	extern import g_child_watch_funcs as GSourceFuncs
	extern import g_idle_funcs as GSourceFuncs
#endif

#ifdef __FB_CYGWIN__
	extern import g_unix_signal_funcs as GSourceFuncs
	extern import g_unix_fd_source_funcs as GSourceFuncs
#endif

#define __G_STRING_H__
#define __G_UNICODE_H__
type gunichar as guint32
type gunichar2 as guint16

type GUnicodeType as long
enum
	G_UNICODE_CONTROL
	G_UNICODE_FORMAT
	G_UNICODE_UNASSIGNED
	G_UNICODE_PRIVATE_USE
	G_UNICODE_SURROGATE
	G_UNICODE_LOWERCASE_LETTER
	G_UNICODE_MODIFIER_LETTER
	G_UNICODE_OTHER_LETTER
	G_UNICODE_TITLECASE_LETTER
	G_UNICODE_UPPERCASE_LETTER
	G_UNICODE_SPACING_MARK
	G_UNICODE_ENCLOSING_MARK
	G_UNICODE_NON_SPACING_MARK
	G_UNICODE_DECIMAL_NUMBER
	G_UNICODE_LETTER_NUMBER
	G_UNICODE_OTHER_NUMBER
	G_UNICODE_CONNECT_PUNCTUATION
	G_UNICODE_DASH_PUNCTUATION
	G_UNICODE_CLOSE_PUNCTUATION
	G_UNICODE_FINAL_PUNCTUATION
	G_UNICODE_INITIAL_PUNCTUATION
	G_UNICODE_OTHER_PUNCTUATION
	G_UNICODE_OPEN_PUNCTUATION
	G_UNICODE_CURRENCY_SYMBOL
	G_UNICODE_MODIFIER_SYMBOL
	G_UNICODE_MATH_SYMBOL
	G_UNICODE_OTHER_SYMBOL
	G_UNICODE_LINE_SEPARATOR
	G_UNICODE_PARAGRAPH_SEPARATOR
	G_UNICODE_SPACE_SEPARATOR
end enum

const G_UNICODE_COMBINING_MARK = G_UNICODE_SPACING_MARK

type GUnicodeBreakType as long
enum
	G_UNICODE_BREAK_MANDATORY
	G_UNICODE_BREAK_CARRIAGE_RETURN
	G_UNICODE_BREAK_LINE_FEED
	G_UNICODE_BREAK_COMBINING_MARK
	G_UNICODE_BREAK_SURROGATE
	G_UNICODE_BREAK_ZERO_WIDTH_SPACE
	G_UNICODE_BREAK_INSEPARABLE
	G_UNICODE_BREAK_NON_BREAKING_GLUE
	G_UNICODE_BREAK_CONTINGENT
	G_UNICODE_BREAK_SPACE
	G_UNICODE_BREAK_AFTER
	G_UNICODE_BREAK_BEFORE
	G_UNICODE_BREAK_BEFORE_AND_AFTER
	G_UNICODE_BREAK_HYPHEN
	G_UNICODE_BREAK_NON_STARTER
	G_UNICODE_BREAK_OPEN_PUNCTUATION
	G_UNICODE_BREAK_CLOSE_PUNCTUATION
	G_UNICODE_BREAK_QUOTATION
	G_UNICODE_BREAK_EXCLAMATION
	G_UNICODE_BREAK_IDEOGRAPHIC
	G_UNICODE_BREAK_NUMERIC
	G_UNICODE_BREAK_INFIX_SEPARATOR
	G_UNICODE_BREAK_SYMBOL
	G_UNICODE_BREAK_ALPHABETIC
	G_UNICODE_BREAK_PREFIX
	G_UNICODE_BREAK_POSTFIX
	G_UNICODE_BREAK_COMPLEX_CONTEXT
	G_UNICODE_BREAK_AMBIGUOUS
	G_UNICODE_BREAK_UNKNOWN
	G_UNICODE_BREAK_NEXT_LINE
	G_UNICODE_BREAK_WORD_JOINER
	G_UNICODE_BREAK_HANGUL_L_JAMO
	G_UNICODE_BREAK_HANGUL_V_JAMO
	G_UNICODE_BREAK_HANGUL_T_JAMO
	G_UNICODE_BREAK_HANGUL_LV_SYLLABLE
	G_UNICODE_BREAK_HANGUL_LVT_SYLLABLE
	G_UNICODE_BREAK_CLOSE_PARANTHESIS
	G_UNICODE_BREAK_CONDITIONAL_JAPANESE_STARTER
	G_UNICODE_BREAK_HEBREW_LETTER
	G_UNICODE_BREAK_REGIONAL_INDICATOR
end enum

type GUnicodeScript as long
enum
	G_UNICODE_SCRIPT_INVALID_CODE = -1
	G_UNICODE_SCRIPT_COMMON = 0
	G_UNICODE_SCRIPT_INHERITED
	G_UNICODE_SCRIPT_ARABIC
	G_UNICODE_SCRIPT_ARMENIAN
	G_UNICODE_SCRIPT_BENGALI
	G_UNICODE_SCRIPT_BOPOMOFO
	G_UNICODE_SCRIPT_CHEROKEE
	G_UNICODE_SCRIPT_COPTIC
	G_UNICODE_SCRIPT_CYRILLIC
	G_UNICODE_SCRIPT_DESERET
	G_UNICODE_SCRIPT_DEVANAGARI
	G_UNICODE_SCRIPT_ETHIOPIC
	G_UNICODE_SCRIPT_GEORGIAN
	G_UNICODE_SCRIPT_GOTHIC
	G_UNICODE_SCRIPT_GREEK
	G_UNICODE_SCRIPT_GUJARATI
	G_UNICODE_SCRIPT_GURMUKHI
	G_UNICODE_SCRIPT_HAN
	G_UNICODE_SCRIPT_HANGUL
	G_UNICODE_SCRIPT_HEBREW
	G_UNICODE_SCRIPT_HIRAGANA
	G_UNICODE_SCRIPT_KANNADA
	G_UNICODE_SCRIPT_KATAKANA
	G_UNICODE_SCRIPT_KHMER
	G_UNICODE_SCRIPT_LAO
	G_UNICODE_SCRIPT_LATIN
	G_UNICODE_SCRIPT_MALAYALAM
	G_UNICODE_SCRIPT_MONGOLIAN
	G_UNICODE_SCRIPT_MYANMAR
	G_UNICODE_SCRIPT_OGHAM
	G_UNICODE_SCRIPT_OLD_ITALIC
	G_UNICODE_SCRIPT_ORIYA
	G_UNICODE_SCRIPT_RUNIC
	G_UNICODE_SCRIPT_SINHALA
	G_UNICODE_SCRIPT_SYRIAC
	G_UNICODE_SCRIPT_TAMIL
	G_UNICODE_SCRIPT_TELUGU
	G_UNICODE_SCRIPT_THAANA
	G_UNICODE_SCRIPT_THAI
	G_UNICODE_SCRIPT_TIBETAN
	G_UNICODE_SCRIPT_CANADIAN_ABORIGINAL
	G_UNICODE_SCRIPT_YI
	G_UNICODE_SCRIPT_TAGALOG
	G_UNICODE_SCRIPT_HANUNOO
	G_UNICODE_SCRIPT_BUHID
	G_UNICODE_SCRIPT_TAGBANWA
	G_UNICODE_SCRIPT_BRAILLE
	G_UNICODE_SCRIPT_CYPRIOT
	G_UNICODE_SCRIPT_LIMBU
	G_UNICODE_SCRIPT_OSMANYA
	G_UNICODE_SCRIPT_SHAVIAN
	G_UNICODE_SCRIPT_LINEAR_B
	G_UNICODE_SCRIPT_TAI_LE
	G_UNICODE_SCRIPT_UGARITIC
	G_UNICODE_SCRIPT_NEW_TAI_LUE
	G_UNICODE_SCRIPT_BUGINESE
	G_UNICODE_SCRIPT_GLAGOLITIC
	G_UNICODE_SCRIPT_TIFINAGH
	G_UNICODE_SCRIPT_SYLOTI_NAGRI
	G_UNICODE_SCRIPT_OLD_PERSIAN
	G_UNICODE_SCRIPT_KHAROSHTHI
	G_UNICODE_SCRIPT_UNKNOWN
	G_UNICODE_SCRIPT_BALINESE
	G_UNICODE_SCRIPT_CUNEIFORM
	G_UNICODE_SCRIPT_PHOENICIAN
	G_UNICODE_SCRIPT_PHAGS_PA
	G_UNICODE_SCRIPT_NKO
	G_UNICODE_SCRIPT_KAYAH_LI
	G_UNICODE_SCRIPT_LEPCHA
	G_UNICODE_SCRIPT_REJANG
	G_UNICODE_SCRIPT_SUNDANESE
	G_UNICODE_SCRIPT_SAURASHTRA
	G_UNICODE_SCRIPT_CHAM
	G_UNICODE_SCRIPT_OL_CHIKI
	G_UNICODE_SCRIPT_VAI
	G_UNICODE_SCRIPT_CARIAN
	G_UNICODE_SCRIPT_LYCIAN
	G_UNICODE_SCRIPT_LYDIAN
	G_UNICODE_SCRIPT_AVESTAN
	G_UNICODE_SCRIPT_BAMUM
	G_UNICODE_SCRIPT_EGYPTIAN_HIEROGLYPHS
	G_UNICODE_SCRIPT_IMPERIAL_ARAMAIC
	G_UNICODE_SCRIPT_INSCRIPTIONAL_PAHLAVI
	G_UNICODE_SCRIPT_INSCRIPTIONAL_PARTHIAN
	G_UNICODE_SCRIPT_JAVANESE
	G_UNICODE_SCRIPT_KAITHI
	G_UNICODE_SCRIPT_LISU
	G_UNICODE_SCRIPT_MEETEI_MAYEK
	G_UNICODE_SCRIPT_OLD_SOUTH_ARABIAN
	G_UNICODE_SCRIPT_OLD_TURKIC
	G_UNICODE_SCRIPT_SAMARITAN
	G_UNICODE_SCRIPT_TAI_THAM
	G_UNICODE_SCRIPT_TAI_VIET
	G_UNICODE_SCRIPT_BATAK
	G_UNICODE_SCRIPT_BRAHMI
	G_UNICODE_SCRIPT_MANDAIC
	G_UNICODE_SCRIPT_CHAKMA
	G_UNICODE_SCRIPT_MEROITIC_CURSIVE
	G_UNICODE_SCRIPT_MEROITIC_HIEROGLYPHS
	G_UNICODE_SCRIPT_MIAO
	G_UNICODE_SCRIPT_SHARADA
	G_UNICODE_SCRIPT_SORA_SOMPENG
	G_UNICODE_SCRIPT_TAKRI
	G_UNICODE_SCRIPT_BASSA_VAH
	G_UNICODE_SCRIPT_CAUCASIAN_ALBANIAN
	G_UNICODE_SCRIPT_DUPLOYAN
	G_UNICODE_SCRIPT_ELBASAN
	G_UNICODE_SCRIPT_GRANTHA
	G_UNICODE_SCRIPT_KHOJKI
	G_UNICODE_SCRIPT_KHUDAWADI
	G_UNICODE_SCRIPT_LINEAR_A
	G_UNICODE_SCRIPT_MAHAJANI
	G_UNICODE_SCRIPT_MANICHAEAN
	G_UNICODE_SCRIPT_MENDE_KIKAKUI
	G_UNICODE_SCRIPT_MODI
	G_UNICODE_SCRIPT_MRO
	G_UNICODE_SCRIPT_NABATAEAN
	G_UNICODE_SCRIPT_OLD_NORTH_ARABIAN
	G_UNICODE_SCRIPT_OLD_PERMIC
	G_UNICODE_SCRIPT_PAHAWH_HMONG
	G_UNICODE_SCRIPT_PALMYRENE
	G_UNICODE_SCRIPT_PAU_CIN_HAU
	G_UNICODE_SCRIPT_PSALTER_PAHLAVI
	G_UNICODE_SCRIPT_SIDDHAM
	G_UNICODE_SCRIPT_TIRHUTA
	G_UNICODE_SCRIPT_WARANG_CITI
end enum

declare function g_unicode_script_to_iso15924(byval script as GUnicodeScript) as guint32
declare function g_unicode_script_from_iso15924(byval iso15924 as guint32) as GUnicodeScript
declare function g_unichar_isalnum(byval c as gunichar) as gboolean
declare function g_unichar_isalpha(byval c as gunichar) as gboolean
declare function g_unichar_iscntrl(byval c as gunichar) as gboolean
declare function g_unichar_isdigit(byval c as gunichar) as gboolean
declare function g_unichar_isgraph(byval c as gunichar) as gboolean
declare function g_unichar_islower(byval c as gunichar) as gboolean
declare function g_unichar_isprint(byval c as gunichar) as gboolean
declare function g_unichar_ispunct(byval c as gunichar) as gboolean
declare function g_unichar_isspace(byval c as gunichar) as gboolean
declare function g_unichar_isupper(byval c as gunichar) as gboolean
declare function g_unichar_isxdigit(byval c as gunichar) as gboolean
declare function g_unichar_istitle(byval c as gunichar) as gboolean
declare function g_unichar_isdefined(byval c as gunichar) as gboolean
declare function g_unichar_iswide(byval c as gunichar) as gboolean
declare function g_unichar_iswide_cjk(byval c as gunichar) as gboolean
declare function g_unichar_iszerowidth(byval c as gunichar) as gboolean
declare function g_unichar_ismark(byval c as gunichar) as gboolean
declare function g_unichar_toupper(byval c as gunichar) as gunichar
declare function g_unichar_tolower(byval c as gunichar) as gunichar
declare function g_unichar_totitle(byval c as gunichar) as gunichar
declare function g_unichar_digit_value(byval c as gunichar) as gint
declare function g_unichar_xdigit_value(byval c as gunichar) as gint
declare function g_unichar_type(byval c as gunichar) as GUnicodeType
declare function g_unichar_break_type(byval c as gunichar) as GUnicodeBreakType
declare function g_unichar_combining_class(byval uc as gunichar) as gint
declare function g_unichar_get_mirror_char(byval ch as gunichar, byval mirrored_ch as gunichar ptr) as gboolean
declare function g_unichar_get_script(byval ch as gunichar) as GUnicodeScript
declare function g_unichar_validate(byval ch as gunichar) as gboolean
declare function g_unichar_compose(byval a as gunichar, byval b as gunichar, byval ch as gunichar ptr) as gboolean
declare function g_unichar_decompose(byval ch as gunichar, byval a as gunichar ptr, byval b as gunichar ptr) as gboolean
declare function g_unichar_fully_decompose(byval ch as gunichar, byval compat as gboolean, byval result as gunichar ptr, byval result_len as gsize) as gsize
const G_UNICHAR_MAX_DECOMPOSITION_LENGTH = 18
declare sub g_unicode_canonical_ordering(byval string as gunichar ptr, byval len as gsize)
declare function g_unicode_canonical_decomposition(byval ch as gunichar, byval result_len as gsize ptr) as gunichar ptr

#if (defined(__FB_WIN32__) and (not defined(GLIB_STATIC_COMPILATION))) or defined(__FB_CYGWIN__)
	extern import g_utf8_skip as const gchar const ptr
#else
	extern g_utf8_skip as const gchar const ptr
#endif

#define g_utf8_next_char(p) cptr(zstring ptr, (p) + g_utf8_skip[(*cptr(const guchar ptr, (p)))])
declare function g_utf8_get_char(byval p as const gchar ptr) as gunichar
declare function g_utf8_get_char_validated(byval p as const gchar ptr, byval max_len as gssize) as gunichar
declare function g_utf8_offset_to_pointer(byval str as const gchar ptr, byval offset as glong) as gchar ptr
declare function g_utf8_pointer_to_offset(byval str as const gchar ptr, byval pos as const gchar ptr) as glong
declare function g_utf8_prev_char(byval p as const gchar ptr) as gchar ptr
declare function g_utf8_find_next_char(byval p as const gchar ptr, byval end as const gchar ptr) as gchar ptr
declare function g_utf8_find_prev_char(byval str as const gchar ptr, byval p as const gchar ptr) as gchar ptr
declare function g_utf8_strlen(byval p as const gchar ptr, byval max as gssize) as glong
declare function g_utf8_substring(byval str as const gchar ptr, byval start_pos as glong, byval end_pos as glong) as gchar ptr
declare function g_utf8_strncpy(byval dest as gchar ptr, byval src as const gchar ptr, byval n as gsize) as gchar ptr
declare function g_utf8_strchr(byval p as const gchar ptr, byval len as gssize, byval c as gunichar) as gchar ptr
declare function g_utf8_strrchr(byval p as const gchar ptr, byval len as gssize, byval c as gunichar) as gchar ptr
declare function g_utf8_strreverse(byval str as const gchar ptr, byval len as gssize) as gchar ptr
declare function g_utf8_to_utf16(byval str as const gchar ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar2 ptr
declare function g_utf8_to_ucs4(byval str as const gchar ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar ptr
declare function g_utf8_to_ucs4_fast(byval str as const gchar ptr, byval len as glong, byval items_written as glong ptr) as gunichar ptr
declare function g_utf16_to_ucs4(byval str as const gunichar2 ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar ptr
declare function g_utf16_to_utf8(byval str as const gunichar2 ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_ucs4_to_utf16(byval str as const gunichar ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gunichar2 ptr
declare function g_ucs4_to_utf8(byval str as const gunichar ptr, byval len as glong, byval items_read as glong ptr, byval items_written as glong ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_unichar_to_utf8(byval c as gunichar, byval outbuf as gchar ptr) as gint
declare function g_utf8_validate(byval str as const gchar ptr, byval max_len as gssize, byval end as const gchar ptr ptr) as gboolean
declare function g_utf8_strup(byval str as const gchar ptr, byval len as gssize) as gchar ptr
declare function g_utf8_strdown(byval str as const gchar ptr, byval len as gssize) as gchar ptr
declare function g_utf8_casefold(byval str as const gchar ptr, byval len as gssize) as gchar ptr

type GNormalizeMode as long
enum
	G_NORMALIZE_DEFAULT
	G_NORMALIZE_NFD = G_NORMALIZE_DEFAULT
	G_NORMALIZE_DEFAULT_COMPOSE
	G_NORMALIZE_NFC = G_NORMALIZE_DEFAULT_COMPOSE
	G_NORMALIZE_ALL
	G_NORMALIZE_NFKD = G_NORMALIZE_ALL
	G_NORMALIZE_ALL_COMPOSE
	G_NORMALIZE_NFKC = G_NORMALIZE_ALL_COMPOSE
end enum

declare function g_utf8_normalize(byval str as const gchar ptr, byval len as gssize, byval mode as GNormalizeMode) as gchar ptr
declare function g_utf8_collate(byval str1 as const gchar ptr, byval str2 as const gchar ptr) as gint
declare function g_utf8_collate_key(byval str as const gchar ptr, byval len as gssize) as gchar ptr
declare function g_utf8_collate_key_for_filename(byval str as const gchar ptr, byval len as gssize) as gchar ptr
declare function _g_utf8_make_valid(byval name as const gchar ptr) as gchar ptr
type GString as _GString

type _GString
	str as gchar ptr
	len as gsize
	allocated_len as gsize
end type

declare function g_string_new(byval init as const gchar ptr) as GString ptr
declare function g_string_new_len(byval init as const gchar ptr, byval len as gssize) as GString ptr
declare function g_string_sized_new(byval dfl_size as gsize) as GString ptr
declare function g_string_free(byval string as GString ptr, byval free_segment as gboolean) as gchar ptr
declare function g_string_free_to_bytes(byval string as GString ptr) as GBytes ptr
declare function g_string_equal(byval v as const GString ptr, byval v2 as const GString ptr) as gboolean
declare function g_string_hash(byval str as const GString ptr) as guint
declare function g_string_assign(byval string as GString ptr, byval rval as const gchar ptr) as GString ptr
declare function g_string_truncate(byval string as GString ptr, byval len as gsize) as GString ptr
declare function g_string_set_size(byval string as GString ptr, byval len as gsize) as GString ptr
declare function g_string_insert_len(byval string as GString ptr, byval pos as gssize, byval val as const gchar ptr, byval len as gssize) as GString ptr
declare function g_string_append(byval string as GString ptr, byval val as const gchar ptr) as GString ptr
declare function g_string_append_len(byval string as GString ptr, byval val as const gchar ptr, byval len as gssize) as GString ptr
declare function g_string_append_c(byval string as GString ptr, byval c as byte) as GString ptr
declare function g_string_append_unichar(byval string as GString ptr, byval wc as gunichar) as GString ptr
declare function g_string_prepend(byval string as GString ptr, byval val as const gchar ptr) as GString ptr
declare function g_string_prepend_c(byval string as GString ptr, byval c as byte) as GString ptr
declare function g_string_prepend_unichar(byval string as GString ptr, byval wc as gunichar) as GString ptr
declare function g_string_prepend_len(byval string as GString ptr, byval val as const gchar ptr, byval len as gssize) as GString ptr
declare function g_string_insert(byval string as GString ptr, byval pos as gssize, byval val as const gchar ptr) as GString ptr
declare function g_string_insert_c(byval string as GString ptr, byval pos as gssize, byval c as byte) as GString ptr
declare function g_string_insert_unichar(byval string as GString ptr, byval pos as gssize, byval wc as gunichar) as GString ptr
declare function g_string_overwrite(byval string as GString ptr, byval pos as gsize, byval val as const gchar ptr) as GString ptr
declare function g_string_overwrite_len(byval string as GString ptr, byval pos as gsize, byval val as const gchar ptr, byval len as gssize) as GString ptr
declare function g_string_erase(byval string as GString ptr, byval pos as gssize, byval len as gssize) as GString ptr
declare function g_string_ascii_down(byval string as GString ptr) as GString ptr
declare function g_string_ascii_up(byval string as GString ptr) as GString ptr
declare sub g_string_vprintf(byval string as GString ptr, byval format as const gchar ptr, byval args as va_list)
declare sub g_string_printf(byval string as GString ptr, byval format as const gchar ptr, ...)
declare sub g_string_append_vprintf(byval string as GString ptr, byval format as const gchar ptr, byval args as va_list)
declare sub g_string_append_printf(byval string as GString ptr, byval format as const gchar ptr, ...)
declare function g_string_append_uri_escaped(byval string as GString ptr, byval unescaped as const gchar ptr, byval reserved_chars_allowed as const gchar ptr, byval allow_utf8 as gboolean) as GString ptr
declare function g_string_down(byval string as GString ptr) as GString ptr
declare function g_string_up(byval string as GString ptr) as GString ptr
declare sub g_string_sprintf alias "g_string_printf"(byval string as GString ptr, byval format as const gchar ptr, ...)
declare sub g_string_sprintfa alias "g_string_append_printf"(byval string as GString ptr, byval format as const gchar ptr, ...)
type GIOChannel as _GIOChannel
type GIOFuncs as _GIOFuncs

type GIOError as long
enum
	G_IO_ERROR_NONE
	G_IO_ERROR_AGAIN
	G_IO_ERROR_INVAL
	G_IO_ERROR_UNKNOWN
end enum

#define G_IO_CHANNEL_ERROR g_io_channel_error_quark()

type GIOChannelError as long
enum
	G_IO_CHANNEL_ERROR_FBIG
	G_IO_CHANNEL_ERROR_INVAL
	G_IO_CHANNEL_ERROR_IO
	G_IO_CHANNEL_ERROR_ISDIR
	G_IO_CHANNEL_ERROR_NOSPC
	G_IO_CHANNEL_ERROR_NXIO
	G_IO_CHANNEL_ERROR_OVERFLOW
	G_IO_CHANNEL_ERROR_PIPE
	G_IO_CHANNEL_ERROR_FAILED
end enum

type GIOStatus as long
enum
	G_IO_STATUS_ERROR
	G_IO_STATUS_NORMAL
	G_IO_STATUS_EOF
	G_IO_STATUS_AGAIN
end enum

type GSeekType as long
enum
	G_SEEK_CUR
	G_SEEK_SET
	G_SEEK_END
end enum

type GIOFlags as long
enum
	G_IO_FLAG_APPEND = 1 shl 0
	G_IO_FLAG_NONBLOCK = 1 shl 1
	G_IO_FLAG_IS_READABLE = 1 shl 2
	G_IO_FLAG_IS_WRITABLE = 1 shl 3
	G_IO_FLAG_IS_WRITEABLE = 1 shl 3
	G_IO_FLAG_IS_SEEKABLE = 1 shl 4
	G_IO_FLAG_MASK = (1 shl 5) - 1
	G_IO_FLAG_GET_MASK = G_IO_FLAG_MASK
	G_IO_FLAG_SET_MASK = G_IO_FLAG_APPEND or G_IO_FLAG_NONBLOCK
end enum

type _GIOChannel
	ref_count as gint
	funcs as GIOFuncs ptr
	encoding as gchar ptr
	read_cd as GIConv
	write_cd as GIConv
	line_term as gchar ptr
	line_term_len as guint
	buf_size as gsize
	read_buf as GString ptr
	encoded_read_buf as GString ptr
	write_buf as GString ptr
	partial_write_buf as zstring * 6
	use_buffer : 1 as guint
	do_encode : 1 as guint
	close_on_unref : 1 as guint
	is_readable : 1 as guint
	is_writeable : 1 as guint
	is_seekable : 1 as guint
	reserved1 as gpointer
	reserved2 as gpointer
end type

type GIOFunc as function(byval source as GIOChannel ptr, byval condition as GIOCondition, byval data as gpointer) as gboolean

type _GIOFuncs
	io_read as function(byval channel as GIOChannel ptr, byval buf as gchar ptr, byval count as gsize, byval bytes_read as gsize ptr, byval err as GError ptr ptr) as GIOStatus
	io_write as function(byval channel as GIOChannel ptr, byval buf as const gchar ptr, byval count as gsize, byval bytes_written as gsize ptr, byval err as GError ptr ptr) as GIOStatus
	io_seek as function(byval channel as GIOChannel ptr, byval offset as gint64, byval type as GSeekType, byval err as GError ptr ptr) as GIOStatus
	io_close as function(byval channel as GIOChannel ptr, byval err as GError ptr ptr) as GIOStatus
	io_create_watch as function(byval channel as GIOChannel ptr, byval condition as GIOCondition) as GSource ptr
	io_free as sub(byval channel as GIOChannel ptr)
	io_set_flags as function(byval channel as GIOChannel ptr, byval flags as GIOFlags, byval err as GError ptr ptr) as GIOStatus
	io_get_flags as function(byval channel as GIOChannel ptr) as GIOFlags
end type

declare sub g_io_channel_init(byval channel as GIOChannel ptr)
declare function g_io_channel_ref(byval channel as GIOChannel ptr) as GIOChannel ptr
declare sub g_io_channel_unref(byval channel as GIOChannel ptr)
declare function g_io_channel_read(byval channel as GIOChannel ptr, byval buf as gchar ptr, byval count as gsize, byval bytes_read as gsize ptr) as GIOError
declare function g_io_channel_write(byval channel as GIOChannel ptr, byval buf as const gchar ptr, byval count as gsize, byval bytes_written as gsize ptr) as GIOError
declare function g_io_channel_seek(byval channel as GIOChannel ptr, byval offset as gint64, byval type as GSeekType) as GIOError
declare sub g_io_channel_close(byval channel as GIOChannel ptr)
declare function g_io_channel_shutdown(byval channel as GIOChannel ptr, byval flush as gboolean, byval err as GError ptr ptr) as GIOStatus
declare function g_io_add_watch_full(byval channel as GIOChannel ptr, byval priority as gint, byval condition as GIOCondition, byval func as GIOFunc, byval user_data as gpointer, byval notify as GDestroyNotify) as guint
declare function g_io_create_watch(byval channel as GIOChannel ptr, byval condition as GIOCondition) as GSource ptr
declare function g_io_add_watch(byval channel as GIOChannel ptr, byval condition as GIOCondition, byval func as GIOFunc, byval user_data as gpointer) as guint
declare sub g_io_channel_set_buffer_size(byval channel as GIOChannel ptr, byval size as gsize)
declare function g_io_channel_get_buffer_size(byval channel as GIOChannel ptr) as gsize
declare function g_io_channel_get_buffer_condition(byval channel as GIOChannel ptr) as GIOCondition
declare function g_io_channel_set_flags(byval channel as GIOChannel ptr, byval flags as GIOFlags, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_get_flags(byval channel as GIOChannel ptr) as GIOFlags
declare sub g_io_channel_set_line_term(byval channel as GIOChannel ptr, byval line_term as const gchar ptr, byval length as gint)
declare function g_io_channel_get_line_term(byval channel as GIOChannel ptr, byval length as gint ptr) as const gchar ptr
declare sub g_io_channel_set_buffered(byval channel as GIOChannel ptr, byval buffered as gboolean)
declare function g_io_channel_get_buffered(byval channel as GIOChannel ptr) as gboolean
declare function g_io_channel_set_encoding(byval channel as GIOChannel ptr, byval encoding as const gchar ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_get_encoding(byval channel as GIOChannel ptr) as const gchar ptr
declare sub g_io_channel_set_close_on_unref(byval channel as GIOChannel ptr, byval do_close as gboolean)
declare function g_io_channel_get_close_on_unref(byval channel as GIOChannel ptr) as gboolean
declare function g_io_channel_flush(byval channel as GIOChannel ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_read_line(byval channel as GIOChannel ptr, byval str_return as gchar ptr ptr, byval length as gsize ptr, byval terminator_pos as gsize ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_read_line_string(byval channel as GIOChannel ptr, byval buffer as GString ptr, byval terminator_pos as gsize ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_read_to_end(byval channel as GIOChannel ptr, byval str_return as gchar ptr ptr, byval length as gsize ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_read_chars(byval channel as GIOChannel ptr, byval buf as gchar ptr, byval count as gsize, byval bytes_read as gsize ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_read_unichar(byval channel as GIOChannel ptr, byval thechar as gunichar ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_write_chars(byval channel as GIOChannel ptr, byval buf as const gchar ptr, byval count as gssize, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_write_unichar(byval channel as GIOChannel ptr, byval thechar as gunichar, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_seek_position(byval channel as GIOChannel ptr, byval offset as gint64, byval type as GSeekType, byval error as GError ptr ptr) as GIOStatus

#ifdef __FB_UNIX__
	declare function g_io_channel_new_file(byval filename as const gchar ptr, byval mode as const gchar ptr, byval error as GError ptr ptr) as GIOChannel ptr
#else
	declare function g_io_channel_new_file_ alias "g_io_channel_new_file"(byval filename as const gchar ptr, byval mode as const gchar ptr, byval error as GError ptr ptr) as GIOChannel ptr
#endif

declare function g_io_channel_error_quark() as GQuark
declare function g_io_channel_error_from_errno(byval en as gint) as GIOChannelError
declare function g_io_channel_unix_new(byval fd as long) as GIOChannel ptr
declare function g_io_channel_unix_get_fd(byval channel as GIOChannel ptr) as gint

#if (defined(__FB_WIN32__) and (not defined(GLIB_STATIC_COMPILATION))) or defined(__FB_CYGWIN__)
	extern import g_io_watch_funcs as GSourceFuncs
#else
	extern g_io_watch_funcs as GSourceFuncs
#endif

#ifdef __FB_WIN32__
	const G_WIN32_MSG_HANDLE = 19981206
	declare sub g_io_channel_win32_make_pollfd(byval channel as GIOChannel ptr, byval condition as GIOCondition, byval fd as GPollFD ptr)
	declare function g_io_channel_win32_poll(byval fds as GPollFD ptr, byval n_fds as gint, byval timeout_ as gint) as gint

	#ifdef __FB_64BIT__
		declare function g_io_channel_win32_new_messages(byval hwnd as gsize) as GIOChannel ptr
	#else
		declare function g_io_channel_win32_new_messages(byval hwnd as guint) as GIOChannel ptr
	#endif

	declare function g_io_channel_win32_new_fd(byval fd as gint) as GIOChannel ptr
	declare function g_io_channel_win32_get_fd(byval channel as GIOChannel ptr) as gint
	declare function g_io_channel_win32_new_socket(byval socket as gint) as GIOChannel ptr
	declare function g_io_channel_win32_new_stream_socket(byval socket as gint) as GIOChannel ptr
	declare sub g_io_channel_win32_set_debug(byval channel as GIOChannel ptr, byval flag as gboolean)
	declare function g_io_channel_new_file_utf8(byval filename as const gchar ptr, byval mode as const gchar ptr, byval error as GError ptr ptr) as GIOChannel ptr
	declare function g_io_channel_new_file alias "g_io_channel_new_file_utf8"(byval filename as const gchar ptr, byval mode as const gchar ptr, byval error as GError ptr ptr) as GIOChannel ptr
#endif

#define __G_KEY_FILE_H__

type GKeyFileError as long
enum
	G_KEY_FILE_ERROR_UNKNOWN_ENCODING
	G_KEY_FILE_ERROR_PARSE
	G_KEY_FILE_ERROR_NOT_FOUND
	G_KEY_FILE_ERROR_KEY_NOT_FOUND
	G_KEY_FILE_ERROR_GROUP_NOT_FOUND
	G_KEY_FILE_ERROR_INVALID_VALUE
end enum

#define G_KEY_FILE_ERROR g_key_file_error_quark()
declare function g_key_file_error_quark() as GQuark
type GKeyFile as _GKeyFile

type GKeyFileFlags as long
enum
	G_KEY_FILE_NONE = 0
	G_KEY_FILE_KEEP_COMMENTS = 1 shl 0
	G_KEY_FILE_KEEP_TRANSLATIONS = 1 shl 1
end enum

declare function g_key_file_new() as GKeyFile ptr
declare function g_key_file_ref(byval key_file as GKeyFile ptr) as GKeyFile ptr
declare sub g_key_file_unref(byval key_file as GKeyFile ptr)
declare sub g_key_file_free(byval key_file as GKeyFile ptr)
declare sub g_key_file_set_list_separator(byval key_file as GKeyFile ptr, byval separator as byte)
declare function g_key_file_load_from_file(byval key_file as GKeyFile ptr, byval file as const gchar ptr, byval flags as GKeyFileFlags, byval error as GError ptr ptr) as gboolean
declare function g_key_file_load_from_data(byval key_file as GKeyFile ptr, byval data as const gchar ptr, byval length as gsize, byval flags as GKeyFileFlags, byval error as GError ptr ptr) as gboolean
declare function g_key_file_load_from_dirs(byval key_file as GKeyFile ptr, byval file as const gchar ptr, byval search_dirs as const gchar ptr ptr, byval full_path as gchar ptr ptr, byval flags as GKeyFileFlags, byval error as GError ptr ptr) as gboolean
declare function g_key_file_load_from_data_dirs(byval key_file as GKeyFile ptr, byval file as const gchar ptr, byval full_path as gchar ptr ptr, byval flags as GKeyFileFlags, byval error as GError ptr ptr) as gboolean
declare function g_key_file_to_data(byval key_file as GKeyFile ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_key_file_save_to_file(byval key_file as GKeyFile ptr, byval filename as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_key_file_get_start_group(byval key_file as GKeyFile ptr) as gchar ptr
declare function g_key_file_get_groups(byval key_file as GKeyFile ptr, byval length as gsize ptr) as gchar ptr ptr
declare function g_key_file_get_keys(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gchar ptr ptr
declare function g_key_file_has_group(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr) as gboolean
declare function g_key_file_has_key(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_key_file_get_value(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare sub g_key_file_set_value(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval value as const gchar ptr)
declare function g_key_file_get_string(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare sub g_key_file_set_string(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval string as const gchar ptr)
declare function g_key_file_get_locale_string(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval locale as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare sub g_key_file_set_locale_string(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval locale as const gchar ptr, byval string as const gchar ptr)
declare function g_key_file_get_boolean(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare sub g_key_file_set_boolean(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval value as gboolean)
declare function g_key_file_get_integer(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval error as GError ptr ptr) as gint
declare sub g_key_file_set_integer(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval value as gint)
declare function g_key_file_get_int64(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval error as GError ptr ptr) as gint64
declare sub g_key_file_set_int64(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval value as gint64)
declare function g_key_file_get_uint64(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval error as GError ptr ptr) as guint64
declare sub g_key_file_set_uint64(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval value as guint64)
declare function g_key_file_get_double(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval error as GError ptr ptr) as gdouble
declare sub g_key_file_set_double(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval value as gdouble)
declare function g_key_file_get_string_list(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gchar ptr ptr
declare sub g_key_file_set_string_list(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval list as const gchar const ptr ptr, byval length as gsize)
declare function g_key_file_get_locale_string_list(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval locale as const gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gchar ptr ptr
declare sub g_key_file_set_locale_string_list(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval locale as const gchar ptr, byval list as const gchar const ptr ptr, byval length as gsize)
declare function g_key_file_get_boolean_list(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gboolean ptr
declare sub g_key_file_set_boolean_list(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval list as gboolean ptr, byval length as gsize)
declare function g_key_file_get_integer_list(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gint ptr
declare sub g_key_file_set_double_list(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval list as gdouble ptr, byval length as gsize)
declare function g_key_file_get_double_list(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval length as gsize ptr, byval error as GError ptr ptr) as gdouble ptr
declare sub g_key_file_set_integer_list(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval list as gint ptr, byval length as gsize)
declare function g_key_file_set_comment(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval comment as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_key_file_get_comment(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_key_file_remove_comment(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_key_file_remove_key(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval key as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_key_file_remove_group(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval error as GError ptr ptr) as gboolean

#define G_KEY_FILE_DESKTOP_GROUP "Desktop Entry"
#define G_KEY_FILE_DESKTOP_KEY_TYPE "Type"
#define G_KEY_FILE_DESKTOP_KEY_VERSION "Version"
#define G_KEY_FILE_DESKTOP_KEY_NAME "Name"
#define G_KEY_FILE_DESKTOP_KEY_GENERIC_NAME "GenericName"
#define G_KEY_FILE_DESKTOP_KEY_NO_DISPLAY "NoDisplay"
#define G_KEY_FILE_DESKTOP_KEY_COMMENT "Comment"
#define G_KEY_FILE_DESKTOP_KEY_ICON "Icon"
#define G_KEY_FILE_DESKTOP_KEY_HIDDEN "Hidden"
#define G_KEY_FILE_DESKTOP_KEY_ONLY_SHOW_IN "OnlyShowIn"
#define G_KEY_FILE_DESKTOP_KEY_NOT_SHOW_IN "NotShowIn"
#define G_KEY_FILE_DESKTOP_KEY_TRY_EXEC "TryExec"
#define G_KEY_FILE_DESKTOP_KEY_EXEC "Exec"
#define G_KEY_FILE_DESKTOP_KEY_PATH "Path"
#define G_KEY_FILE_DESKTOP_KEY_TERMINAL "Terminal"
#define G_KEY_FILE_DESKTOP_KEY_MIME_TYPE "MimeType"
#define G_KEY_FILE_DESKTOP_KEY_CATEGORIES "Categories"
#define G_KEY_FILE_DESKTOP_KEY_STARTUP_NOTIFY "StartupNotify"
#define G_KEY_FILE_DESKTOP_KEY_STARTUP_WM_CLASS "StartupWMClass"
#define G_KEY_FILE_DESKTOP_KEY_URL "URL"
#define G_KEY_FILE_DESKTOP_KEY_DBUS_ACTIVATABLE "DBusActivatable"
#define G_KEY_FILE_DESKTOP_KEY_ACTIONS "Actions"
#define G_KEY_FILE_DESKTOP_TYPE_APPLICATION "Application"
#define G_KEY_FILE_DESKTOP_TYPE_LINK "Link"
#define G_KEY_FILE_DESKTOP_TYPE_DIRECTORY "Directory"
#define __G_MAPPED_FILE_H__
type GMappedFile as _GMappedFile

declare function g_mapped_file_new(byval filename as const gchar ptr, byval writable as gboolean, byval error as GError ptr ptr) as GMappedFile ptr
declare function g_mapped_file_new_from_fd(byval fd as gint, byval writable as gboolean, byval error as GError ptr ptr) as GMappedFile ptr
declare function g_mapped_file_get_length(byval file as GMappedFile ptr) as gsize
declare function g_mapped_file_get_contents(byval file as GMappedFile ptr) as gchar ptr
declare function g_mapped_file_get_bytes(byval file as GMappedFile ptr) as GBytes ptr
declare function g_mapped_file_ref(byval file as GMappedFile ptr) as GMappedFile ptr
declare sub g_mapped_file_unref(byval file as GMappedFile ptr)
declare sub g_mapped_file_free(byval file as GMappedFile ptr)
#define __G_MARKUP_H__

type GMarkupError as long
enum
	G_MARKUP_ERROR_BAD_UTF8
	G_MARKUP_ERROR_EMPTY
	G_MARKUP_ERROR_PARSE
	G_MARKUP_ERROR_UNKNOWN_ELEMENT
	G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE
	G_MARKUP_ERROR_INVALID_CONTENT
	G_MARKUP_ERROR_MISSING_ATTRIBUTE
end enum

#define G_MARKUP_ERROR g_markup_error_quark()
declare function g_markup_error_quark() as GQuark

type GMarkupParseFlags as long
enum
	G_MARKUP_DO_NOT_USE_THIS_UNSUPPORTED_FLAG = 1 shl 0
	G_MARKUP_TREAT_CDATA_AS_TEXT = 1 shl 1
	G_MARKUP_PREFIX_ERROR_POSITION = 1 shl 2
	G_MARKUP_IGNORE_QUALIFIED = 1 shl 3
end enum

type GMarkupParseContext as _GMarkupParseContext
type GMarkupParser as _GMarkupParser

type _GMarkupParser
	start_element as sub(byval context as GMarkupParseContext ptr, byval element_name as const gchar ptr, byval attribute_names as const gchar ptr ptr, byval attribute_values as const gchar ptr ptr, byval user_data as gpointer, byval error as GError ptr ptr)
	end_element as sub(byval context as GMarkupParseContext ptr, byval element_name as const gchar ptr, byval user_data as gpointer, byval error as GError ptr ptr)
	text as sub(byval context as GMarkupParseContext ptr, byval text as const gchar ptr, byval text_len as gsize, byval user_data as gpointer, byval error as GError ptr ptr)
	passthrough as sub(byval context as GMarkupParseContext ptr, byval passthrough_text as const gchar ptr, byval text_len as gsize, byval user_data as gpointer, byval error as GError ptr ptr)
	error as sub(byval context as GMarkupParseContext ptr, byval error as GError ptr, byval user_data as gpointer)
end type

declare function g_markup_parse_context_new(byval parser as const GMarkupParser ptr, byval flags as GMarkupParseFlags, byval user_data as gpointer, byval user_data_dnotify as GDestroyNotify) as GMarkupParseContext ptr
declare function g_markup_parse_context_ref(byval context as GMarkupParseContext ptr) as GMarkupParseContext ptr
declare sub g_markup_parse_context_unref(byval context as GMarkupParseContext ptr)
declare sub g_markup_parse_context_free(byval context as GMarkupParseContext ptr)
declare function g_markup_parse_context_parse(byval context as GMarkupParseContext ptr, byval text as const gchar ptr, byval text_len as gssize, byval error as GError ptr ptr) as gboolean
declare sub g_markup_parse_context_push(byval context as GMarkupParseContext ptr, byval parser as const GMarkupParser ptr, byval user_data as gpointer)
declare function g_markup_parse_context_pop(byval context as GMarkupParseContext ptr) as gpointer
declare function g_markup_parse_context_end_parse(byval context as GMarkupParseContext ptr, byval error as GError ptr ptr) as gboolean
declare function g_markup_parse_context_get_element(byval context as GMarkupParseContext ptr) as const gchar ptr
declare function g_markup_parse_context_get_element_stack(byval context as GMarkupParseContext ptr) as const GSList ptr
declare sub g_markup_parse_context_get_position(byval context as GMarkupParseContext ptr, byval line_number as gint ptr, byval char_number as gint ptr)
declare function g_markup_parse_context_get_user_data(byval context as GMarkupParseContext ptr) as gpointer
declare function g_markup_escape_text(byval text as const gchar ptr, byval length as gssize) as gchar ptr
declare function g_markup_printf_escaped(byval format as const zstring ptr, ...) as gchar ptr
declare function g_markup_vprintf_escaped(byval format as const zstring ptr, byval args as va_list) as gchar ptr

type GMarkupCollectType as long
enum
	G_MARKUP_COLLECT_INVALID
	G_MARKUP_COLLECT_STRING
	G_MARKUP_COLLECT_STRDUP
	G_MARKUP_COLLECT_BOOLEAN
	G_MARKUP_COLLECT_TRISTATE
	G_MARKUP_COLLECT_OPTIONAL = 1 shl 16
end enum

declare function g_markup_collect_attributes(byval element_name as const gchar ptr, byval attribute_names as const gchar ptr ptr, byval attribute_values as const gchar ptr ptr, byval error as GError ptr ptr, byval first_type as GMarkupCollectType, byval first_attr as const gchar ptr, ...) as gboolean
#define __G_MESSAGES_H__
declare function g_printf_string_upper_bound(byval format as const gchar ptr, byval args as va_list) as gsize
const G_LOG_LEVEL_USER_SHIFT = 8

type GLogLevelFlags as long
enum
	G_LOG_FLAG_RECURSION = 1 shl 0
	G_LOG_FLAG_FATAL = 1 shl 1
	G_LOG_LEVEL_ERROR = 1 shl 2
	G_LOG_LEVEL_CRITICAL = 1 shl 3
	G_LOG_LEVEL_WARNING = 1 shl 4
	G_LOG_LEVEL_MESSAGE = 1 shl 5
	G_LOG_LEVEL_INFO = 1 shl 6
	G_LOG_LEVEL_DEBUG = 1 shl 7
	G_LOG_LEVEL_MASK = not (G_LOG_FLAG_RECURSION or G_LOG_FLAG_FATAL)
end enum

const G_LOG_FATAL_MASK = G_LOG_FLAG_RECURSION or G_LOG_LEVEL_ERROR
type GLogFunc as sub(byval log_domain as const gchar ptr, byval log_level as GLogLevelFlags, byval message as const gchar ptr, byval user_data as gpointer)
declare function g_log_set_handler(byval log_domain as const gchar ptr, byval log_levels as GLogLevelFlags, byval log_func as GLogFunc, byval user_data as gpointer) as guint
declare sub g_log_remove_handler(byval log_domain as const gchar ptr, byval handler_id as guint)
declare sub g_log_default_handler(byval log_domain as const gchar ptr, byval log_level as GLogLevelFlags, byval message as const gchar ptr, byval unused_data as gpointer)
declare function g_log_set_default_handler(byval log_func as GLogFunc, byval user_data as gpointer) as GLogFunc
declare sub g_log(byval log_domain as const gchar ptr, byval log_level as GLogLevelFlags, byval format as const gchar ptr, ...)
declare sub g_logv(byval log_domain as const gchar ptr, byval log_level as GLogLevelFlags, byval format as const gchar ptr, byval args as va_list)
declare function g_log_set_fatal_mask(byval log_domain as const gchar ptr, byval fatal_mask as GLogLevelFlags) as GLogLevelFlags
declare function g_log_set_always_fatal(byval fatal_mask as GLogLevelFlags) as GLogLevelFlags
declare sub _g_log_fallback_handler(byval log_domain as const gchar ptr, byval log_level as GLogLevelFlags, byval message as const gchar ptr, byval unused_data as gpointer)
declare sub g_return_if_fail_warning(byval log_domain as const zstring ptr, byval pretty_function as const zstring ptr, byval expression as const zstring ptr)
declare sub g_warn_message(byval domain as const zstring ptr, byval file as const zstring ptr, byval line as long, byval func as const zstring ptr, byval warnexpr as const zstring ptr)
declare sub g_assert_warning(byval log_domain as const zstring ptr, byval file as const zstring ptr, byval line as const long, byval pretty_function as const zstring ptr, byval expression as const zstring ptr)

const G_LOG_DOMAIN = cptr(gchar ptr, 0)
#define g_error(__VA_ARGS__...) scope : g_log(G_LOG_DOMAIN, G_LOG_LEVEL_ERROR, __VA_ARGS__) : end scope
#define g_message(__VA_ARGS__...) g_log(G_LOG_DOMAIN, G_LOG_LEVEL_MESSAGE, __VA_ARGS__)
#define g_critical(__VA_ARGS__...) g_log(G_LOG_DOMAIN, G_LOG_LEVEL_CRITICAL, __VA_ARGS__)
#define g_warning(__VA_ARGS__...) g_log(G_LOG_DOMAIN, G_LOG_LEVEL_WARNING, __VA_ARGS__)
#define g_info(__VA_ARGS__...) g_log(G_LOG_DOMAIN, G_LOG_LEVEL_INFO, __VA_ARGS__)
#define g_debug(__VA_ARGS__...) g_log(G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG, __VA_ARGS__)
type GPrintFunc as sub(byval string as const gchar ptr)

declare sub g_print(byval format as const gchar ptr, ...)
declare function g_set_print_handler(byval func as GPrintFunc) as GPrintFunc
declare sub g_printerr(byval format as const gchar ptr, ...)
declare function g_set_printerr_handler(byval func as GPrintFunc) as GPrintFunc

#define g_warn_if_reached() scope : g_warn_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, NULL) : end scope
#macro g_warn_if_fail(expr)
	if G_LIKELY(expr) then
	else
		g_warn_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #expr)
	end if
#endmacro
#macro g_return_if_fail(expr)
	if G_LIKELY(expr) then
	else
		g_return_if_fail_warning(G_LOG_DOMAIN, G_STRFUNC, #expr)
		return
	end if
#endmacro
#macro g_return_val_if_fail(expr, val)
	if G_LIKELY(expr) then
	else
		g_return_if_fail_warning(G_LOG_DOMAIN, G_STRFUNC, #expr)
		return (val)
	end if
#endmacro
#macro g_return_if_reached()
	scope
		g_log(G_LOG_DOMAIN, G_LOG_LEVEL_CRITICAL, "file %s: line %d (%s): should not be reached", __FILE__, __LINE__, G_STRFUNC)
		return
	end scope
#endmacro
#macro g_return_val_if_reached(val)
	scope
		g_log(G_LOG_DOMAIN, G_LOG_LEVEL_CRITICAL, "file %s: line %d (%s): should not be reached", __FILE__, __LINE__, G_STRFUNC)
		return (val)
	end scope
#endmacro
#define __G_OPTION_H__

type GOptionContext as _GOptionContext
type GOptionGroup as _GOptionGroup
type GOptionEntry as _GOptionEntry

type GOptionFlags as long
enum
	G_OPTION_FLAG_NONE = 0
	G_OPTION_FLAG_HIDDEN = 1 shl 0
	G_OPTION_FLAG_IN_MAIN = 1 shl 1
	G_OPTION_FLAG_REVERSE = 1 shl 2
	G_OPTION_FLAG_NO_ARG = 1 shl 3
	G_OPTION_FLAG_FILENAME = 1 shl 4
	G_OPTION_FLAG_OPTIONAL_ARG = 1 shl 5
	G_OPTION_FLAG_NOALIAS = 1 shl 6
end enum

type GOptionArg as long
enum
	G_OPTION_ARG_NONE
	G_OPTION_ARG_STRING
	G_OPTION_ARG_INT
	G_OPTION_ARG_CALLBACK
	G_OPTION_ARG_FILENAME
	G_OPTION_ARG_STRING_ARRAY
	G_OPTION_ARG_FILENAME_ARRAY
	G_OPTION_ARG_DOUBLE
	G_OPTION_ARG_INT64
end enum

type GOptionArgFunc as function(byval option_name as const gchar ptr, byval value as const gchar ptr, byval data as gpointer, byval error as GError ptr ptr) as gboolean
type GOptionParseFunc as function(byval context as GOptionContext ptr, byval group as GOptionGroup ptr, byval data as gpointer, byval error as GError ptr ptr) as gboolean
type GOptionErrorFunc as sub(byval context as GOptionContext ptr, byval group as GOptionGroup ptr, byval data as gpointer, byval error as GError ptr ptr)
#define G_OPTION_ERROR g_option_error_quark()

type GOptionError as long
enum
	G_OPTION_ERROR_UNKNOWN_OPTION
	G_OPTION_ERROR_BAD_VALUE
	G_OPTION_ERROR_FAILED
end enum

declare function g_option_error_quark() as GQuark

type _GOptionEntry
	long_name as const gchar ptr
	short_name as byte
	flags as gint
	arg as GOptionArg
	arg_data as gpointer
	description as const gchar ptr
	arg_description as const gchar ptr
end type

#define G_OPTION_REMAINING ""
declare function g_option_context_new(byval parameter_string as const gchar ptr) as GOptionContext ptr
declare sub g_option_context_set_summary(byval context as GOptionContext ptr, byval summary as const gchar ptr)
declare function g_option_context_get_summary(byval context as GOptionContext ptr) as const gchar ptr
declare sub g_option_context_set_description(byval context as GOptionContext ptr, byval description as const gchar ptr)
declare function g_option_context_get_description(byval context as GOptionContext ptr) as const gchar ptr
declare sub g_option_context_free(byval context as GOptionContext ptr)
declare sub g_option_context_set_help_enabled(byval context as GOptionContext ptr, byval help_enabled as gboolean)
declare function g_option_context_get_help_enabled(byval context as GOptionContext ptr) as gboolean
declare sub g_option_context_set_ignore_unknown_options(byval context as GOptionContext ptr, byval ignore_unknown as gboolean)
declare function g_option_context_get_ignore_unknown_options(byval context as GOptionContext ptr) as gboolean
declare sub g_option_context_set_strict_posix(byval context as GOptionContext ptr, byval strict_posix as gboolean)
declare function g_option_context_get_strict_posix(byval context as GOptionContext ptr) as gboolean
declare sub g_option_context_add_main_entries(byval context as GOptionContext ptr, byval entries as const GOptionEntry ptr, byval translation_domain as const gchar ptr)
declare function g_option_context_parse(byval context as GOptionContext ptr, byval argc as gint ptr, byval argv as gchar ptr ptr ptr, byval error as GError ptr ptr) as gboolean
declare function g_option_context_parse_strv(byval context as GOptionContext ptr, byval arguments as gchar ptr ptr ptr, byval error as GError ptr ptr) as gboolean
declare sub g_option_context_set_translate_func(byval context as GOptionContext ptr, byval func as GTranslateFunc, byval data as gpointer, byval destroy_notify as GDestroyNotify)
declare sub g_option_context_set_translation_domain(byval context as GOptionContext ptr, byval domain as const gchar ptr)
declare sub g_option_context_add_group(byval context as GOptionContext ptr, byval group as GOptionGroup ptr)
declare sub g_option_context_set_main_group(byval context as GOptionContext ptr, byval group as GOptionGroup ptr)
declare function g_option_context_get_main_group(byval context as GOptionContext ptr) as GOptionGroup ptr
declare function g_option_context_get_help(byval context as GOptionContext ptr, byval main_help as gboolean, byval group as GOptionGroup ptr) as gchar ptr
declare function g_option_group_new(byval name as const gchar ptr, byval description as const gchar ptr, byval help_description as const gchar ptr, byval user_data as gpointer, byval destroy as GDestroyNotify) as GOptionGroup ptr
declare sub g_option_group_set_parse_hooks(byval group as GOptionGroup ptr, byval pre_parse_func as GOptionParseFunc, byval post_parse_func as GOptionParseFunc)
declare sub g_option_group_set_error_hook(byval group as GOptionGroup ptr, byval error_func as GOptionErrorFunc)
declare sub g_option_group_free(byval group as GOptionGroup ptr)
declare function g_option_group_ref(byval group as GOptionGroup ptr) as GOptionGroup ptr
declare sub g_option_group_unref(byval group as GOptionGroup ptr)
declare sub g_option_group_add_entries(byval group as GOptionGroup ptr, byval entries as const GOptionEntry ptr)
declare sub g_option_group_set_translate_func(byval group as GOptionGroup ptr, byval func as GTranslateFunc, byval data as gpointer, byval destroy_notify as GDestroyNotify)
declare sub g_option_group_set_translation_domain(byval group as GOptionGroup ptr, byval domain as const gchar ptr)
#define __G_PATTERN_H__
type GPatternSpec as _GPatternSpec
declare function g_pattern_spec_new(byval pattern as const gchar ptr) as GPatternSpec ptr
declare sub g_pattern_spec_free(byval pspec as GPatternSpec ptr)
declare function g_pattern_spec_equal(byval pspec1 as GPatternSpec ptr, byval pspec2 as GPatternSpec ptr) as gboolean
declare function g_pattern_match(byval pspec as GPatternSpec ptr, byval string_length as guint, byval string as const gchar ptr, byval string_reversed as const gchar ptr) as gboolean
declare function g_pattern_match_string(byval pspec as GPatternSpec ptr, byval string as const gchar ptr) as gboolean
declare function g_pattern_match_simple(byval pattern as const gchar ptr, byval string as const gchar ptr) as gboolean
#define __G_PRIMES_H__
declare function g_spaced_primes_closest(byval num as guint) as guint
#define __G_QSORT_H__
declare sub g_qsort_with_data(byval pbase as gconstpointer, byval total_elems as gint, byval size as gsize, byval compare_func as GCompareDataFunc, byval user_data as gpointer)
#define __G_QUEUE_H__
type GQueue as _GQueue

type _GQueue
	head as GList ptr
	tail as GList ptr
	length as guint
end type

#define G_QUEUE_INIT_ (NULL, NULL, 0)
declare function g_queue_new() as GQueue ptr
declare sub g_queue_free(byval queue as GQueue ptr)
declare sub g_queue_free_full(byval queue as GQueue ptr, byval free_func as GDestroyNotify)
declare sub g_queue_init(byval queue as GQueue ptr)
declare sub g_queue_clear(byval queue as GQueue ptr)
declare function g_queue_is_empty(byval queue as GQueue ptr) as gboolean
declare function g_queue_get_length(byval queue as GQueue ptr) as guint
declare sub g_queue_reverse(byval queue as GQueue ptr)
declare function g_queue_copy(byval queue as GQueue ptr) as GQueue ptr
declare sub g_queue_foreach(byval queue as GQueue ptr, byval func as GFunc, byval user_data as gpointer)
declare function g_queue_find(byval queue as GQueue ptr, byval data as gconstpointer) as GList ptr
declare function g_queue_find_custom(byval queue as GQueue ptr, byval data as gconstpointer, byval func as GCompareFunc) as GList ptr
declare sub g_queue_sort(byval queue as GQueue ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer)
declare sub g_queue_push_head(byval queue as GQueue ptr, byval data as gpointer)
declare sub g_queue_push_tail(byval queue as GQueue ptr, byval data as gpointer)
declare sub g_queue_push_nth(byval queue as GQueue ptr, byval data as gpointer, byval n as gint)
declare function g_queue_pop_head(byval queue as GQueue ptr) as gpointer
declare function g_queue_pop_tail(byval queue as GQueue ptr) as gpointer
declare function g_queue_pop_nth(byval queue as GQueue ptr, byval n as guint) as gpointer
declare function g_queue_peek_head(byval queue as GQueue ptr) as gpointer
declare function g_queue_peek_tail(byval queue as GQueue ptr) as gpointer
declare function g_queue_peek_nth(byval queue as GQueue ptr, byval n as guint) as gpointer
declare function g_queue_index(byval queue as GQueue ptr, byval data as gconstpointer) as gint
declare function g_queue_remove(byval queue as GQueue ptr, byval data as gconstpointer) as gboolean
declare function g_queue_remove_all(byval queue as GQueue ptr, byval data as gconstpointer) as guint
declare sub g_queue_insert_before(byval queue as GQueue ptr, byval sibling as GList ptr, byval data as gpointer)
declare sub g_queue_insert_after(byval queue as GQueue ptr, byval sibling as GList ptr, byval data as gpointer)
declare sub g_queue_insert_sorted(byval queue as GQueue ptr, byval data as gpointer, byval func as GCompareDataFunc, byval user_data as gpointer)
declare sub g_queue_push_head_link(byval queue as GQueue ptr, byval link_ as GList ptr)
declare sub g_queue_push_tail_link(byval queue as GQueue ptr, byval link_ as GList ptr)
declare sub g_queue_push_nth_link(byval queue as GQueue ptr, byval n as gint, byval link_ as GList ptr)
declare function g_queue_pop_head_link(byval queue as GQueue ptr) as GList ptr
declare function g_queue_pop_tail_link(byval queue as GQueue ptr) as GList ptr
declare function g_queue_pop_nth_link(byval queue as GQueue ptr, byval n as guint) as GList ptr
declare function g_queue_peek_head_link(byval queue as GQueue ptr) as GList ptr
declare function g_queue_peek_tail_link(byval queue as GQueue ptr) as GList ptr
declare function g_queue_peek_nth_link(byval queue as GQueue ptr, byval n as guint) as GList ptr
declare function g_queue_link_index(byval queue as GQueue ptr, byval link_ as GList ptr) as gint
declare sub g_queue_unlink(byval queue as GQueue ptr, byval link_ as GList ptr)
declare sub g_queue_delete_link(byval queue as GQueue ptr, byval link_ as GList ptr)
#define __G_RAND_H__
type GRand as _GRand
declare function g_rand_new_with_seed(byval seed as guint32) as GRand ptr
declare function g_rand_new_with_seed_array(byval seed as const guint32 ptr, byval seed_length as guint) as GRand ptr
declare function g_rand_new() as GRand ptr
declare sub g_rand_free(byval rand_ as GRand ptr)
declare function g_rand_copy(byval rand_ as GRand ptr) as GRand ptr
declare sub g_rand_set_seed(byval rand_ as GRand ptr, byval seed as guint32)
declare sub g_rand_set_seed_array(byval rand_ as GRand ptr, byval seed as const guint32 ptr, byval seed_length as guint)
#define g_rand_boolean(rand_) ((g_rand_int(rand_) and (1 shl 15)) <> 0)
declare function g_rand_int(byval rand_ as GRand ptr) as guint32
declare function g_rand_int_range(byval rand_ as GRand ptr, byval begin as gint32, byval end as gint32) as gint32
declare function g_rand_double(byval rand_ as GRand ptr) as gdouble
declare function g_rand_double_range(byval rand_ as GRand ptr, byval begin as gdouble, byval end as gdouble) as gdouble
declare sub g_random_set_seed(byval seed as guint32)
#define g_random_boolean() ((g_random_int() and (1 shl 15)) <> 0)
declare function g_random_int() as guint32
declare function g_random_int_range(byval begin as gint32, byval end as gint32) as gint32
declare function g_random_double() as gdouble
declare function g_random_double_range(byval begin as gdouble, byval end as gdouble) as gdouble
#define __G_REGEX_H__

type GRegexError as long
enum
	G_REGEX_ERROR_COMPILE
	G_REGEX_ERROR_OPTIMIZE
	G_REGEX_ERROR_REPLACE
	G_REGEX_ERROR_MATCH
	G_REGEX_ERROR_INTERNAL
	G_REGEX_ERROR_STRAY_BACKSLASH = 101
	G_REGEX_ERROR_MISSING_CONTROL_CHAR = 102
	G_REGEX_ERROR_UNRECOGNIZED_ESCAPE = 103
	G_REGEX_ERROR_QUANTIFIERS_OUT_OF_ORDER = 104
	G_REGEX_ERROR_QUANTIFIER_TOO_BIG = 105
	G_REGEX_ERROR_UNTERMINATED_CHARACTER_CLASS = 106
	G_REGEX_ERROR_INVALID_ESCAPE_IN_CHARACTER_CLASS = 107
	G_REGEX_ERROR_RANGE_OUT_OF_ORDER = 108
	G_REGEX_ERROR_NOTHING_TO_REPEAT = 109
	G_REGEX_ERROR_UNRECOGNIZED_CHARACTER = 112
	G_REGEX_ERROR_POSIX_NAMED_CLASS_OUTSIDE_CLASS = 113
	G_REGEX_ERROR_UNMATCHED_PARENTHESIS = 114
	G_REGEX_ERROR_INEXISTENT_SUBPATTERN_REFERENCE = 115
	G_REGEX_ERROR_UNTERMINATED_COMMENT = 118
	G_REGEX_ERROR_EXPRESSION_TOO_LARGE = 120
	G_REGEX_ERROR_MEMORY_ERROR = 121
	G_REGEX_ERROR_VARIABLE_LENGTH_LOOKBEHIND = 125
	G_REGEX_ERROR_MALFORMED_CONDITION = 126
	G_REGEX_ERROR_TOO_MANY_CONDITIONAL_BRANCHES = 127
	G_REGEX_ERROR_ASSERTION_EXPECTED = 128
	G_REGEX_ERROR_UNKNOWN_POSIX_CLASS_NAME = 130
	G_REGEX_ERROR_POSIX_COLLATING_ELEMENTS_NOT_SUPPORTED = 131
	G_REGEX_ERROR_HEX_CODE_TOO_LARGE = 134
	G_REGEX_ERROR_INVALID_CONDITION = 135
	G_REGEX_ERROR_SINGLE_BYTE_MATCH_IN_LOOKBEHIND = 136
	G_REGEX_ERROR_INFINITE_LOOP = 140
	G_REGEX_ERROR_MISSING_SUBPATTERN_NAME_TERMINATOR = 142
	G_REGEX_ERROR_DUPLICATE_SUBPATTERN_NAME = 143
	G_REGEX_ERROR_MALFORMED_PROPERTY = 146
	G_REGEX_ERROR_UNKNOWN_PROPERTY = 147
	G_REGEX_ERROR_SUBPATTERN_NAME_TOO_LONG = 148
	G_REGEX_ERROR_TOO_MANY_SUBPATTERNS = 149
	G_REGEX_ERROR_INVALID_OCTAL_VALUE = 151
	G_REGEX_ERROR_TOO_MANY_BRANCHES_IN_DEFINE = 154
	G_REGEX_ERROR_DEFINE_REPETION = 155
	G_REGEX_ERROR_INCONSISTENT_NEWLINE_OPTIONS = 156
	G_REGEX_ERROR_MISSING_BACK_REFERENCE = 157
	G_REGEX_ERROR_INVALID_RELATIVE_REFERENCE = 158
	G_REGEX_ERROR_BACKTRACKING_CONTROL_VERB_ARGUMENT_FORBIDDEN = 159
	G_REGEX_ERROR_UNKNOWN_BACKTRACKING_CONTROL_VERB = 160
	G_REGEX_ERROR_NUMBER_TOO_BIG = 161
	G_REGEX_ERROR_MISSING_SUBPATTERN_NAME = 162
	G_REGEX_ERROR_MISSING_DIGIT = 163
	G_REGEX_ERROR_INVALID_DATA_CHARACTER = 164
	G_REGEX_ERROR_EXTRA_SUBPATTERN_NAME = 165
	G_REGEX_ERROR_BACKTRACKING_CONTROL_VERB_ARGUMENT_REQUIRED = 166
	G_REGEX_ERROR_INVALID_CONTROL_CHAR = 168
	G_REGEX_ERROR_MISSING_NAME = 169
	G_REGEX_ERROR_NOT_SUPPORTED_IN_CLASS = 171
	G_REGEX_ERROR_TOO_MANY_FORWARD_REFERENCES = 172
	G_REGEX_ERROR_NAME_TOO_LONG = 175
	G_REGEX_ERROR_CHARACTER_VALUE_TOO_LARGE = 176
end enum

#define G_REGEX_ERROR g_regex_error_quark()
declare function g_regex_error_quark() as GQuark

type GRegexCompileFlags as long
enum
	G_REGEX_CASELESS = 1 shl 0
	G_REGEX_MULTILINE = 1 shl 1
	G_REGEX_DOTALL = 1 shl 2
	G_REGEX_EXTENDED = 1 shl 3
	G_REGEX_ANCHORED = 1 shl 4
	G_REGEX_DOLLAR_ENDONLY = 1 shl 5
	G_REGEX_UNGREEDY = 1 shl 9
	G_REGEX_RAW = 1 shl 11
	G_REGEX_NO_AUTO_CAPTURE = 1 shl 12
	G_REGEX_OPTIMIZE = 1 shl 13
	G_REGEX_FIRSTLINE = 1 shl 18
	G_REGEX_DUPNAMES = 1 shl 19
	G_REGEX_NEWLINE_CR = 1 shl 20
	G_REGEX_NEWLINE_LF = 1 shl 21
	G_REGEX_NEWLINE_CRLF = G_REGEX_NEWLINE_CR or G_REGEX_NEWLINE_LF
	G_REGEX_NEWLINE_ANYCRLF = G_REGEX_NEWLINE_CR or (1 shl 22)
	G_REGEX_BSR_ANYCRLF = 1 shl 23
	G_REGEX_JAVASCRIPT_COMPAT = 1 shl 25
end enum

type GRegexMatchFlags as long
enum
	G_REGEX_MATCH_ANCHORED = 1 shl 4
	G_REGEX_MATCH_NOTBOL = 1 shl 7
	G_REGEX_MATCH_NOTEOL = 1 shl 8
	G_REGEX_MATCH_NOTEMPTY = 1 shl 10
	G_REGEX_MATCH_PARTIAL = 1 shl 15
	G_REGEX_MATCH_NEWLINE_CR = 1 shl 20
	G_REGEX_MATCH_NEWLINE_LF = 1 shl 21
	G_REGEX_MATCH_NEWLINE_CRLF = G_REGEX_MATCH_NEWLINE_CR or G_REGEX_MATCH_NEWLINE_LF
	G_REGEX_MATCH_NEWLINE_ANY = 1 shl 22
	G_REGEX_MATCH_NEWLINE_ANYCRLF = G_REGEX_MATCH_NEWLINE_CR or G_REGEX_MATCH_NEWLINE_ANY
	G_REGEX_MATCH_BSR_ANYCRLF = 1 shl 23
	G_REGEX_MATCH_BSR_ANY = 1 shl 24
	G_REGEX_MATCH_PARTIAL_SOFT = G_REGEX_MATCH_PARTIAL
	G_REGEX_MATCH_PARTIAL_HARD = 1 shl 27
	G_REGEX_MATCH_NOTEMPTY_ATSTART = 1 shl 28
end enum

type GRegex as _GRegex
type GMatchInfo as _GMatchInfo
type GRegexEvalCallback as function(byval match_info as const GMatchInfo ptr, byval result as GString ptr, byval user_data as gpointer) as gboolean

declare function g_regex_new(byval pattern as const gchar ptr, byval compile_options as GRegexCompileFlags, byval match_options as GRegexMatchFlags, byval error as GError ptr ptr) as GRegex ptr
declare function g_regex_ref(byval regex as GRegex ptr) as GRegex ptr
declare sub g_regex_unref(byval regex as GRegex ptr)
declare function g_regex_get_pattern(byval regex as const GRegex ptr) as const gchar ptr
declare function g_regex_get_max_backref(byval regex as const GRegex ptr) as gint
declare function g_regex_get_capture_count(byval regex as const GRegex ptr) as gint
declare function g_regex_get_has_cr_or_lf(byval regex as const GRegex ptr) as gboolean
declare function g_regex_get_max_lookbehind(byval regex as const GRegex ptr) as gint
declare function g_regex_get_string_number(byval regex as const GRegex ptr, byval name as const gchar ptr) as gint
declare function g_regex_escape_string(byval string as const gchar ptr, byval length as gint) as gchar ptr
declare function g_regex_escape_nul(byval string as const gchar ptr, byval length as gint) as gchar ptr
declare function g_regex_get_compile_flags(byval regex as const GRegex ptr) as GRegexCompileFlags
declare function g_regex_get_match_flags(byval regex as const GRegex ptr) as GRegexMatchFlags
declare function g_regex_match_simple(byval pattern as const gchar ptr, byval string as const gchar ptr, byval compile_options as GRegexCompileFlags, byval match_options as GRegexMatchFlags) as gboolean
declare function g_regex_match(byval regex as const GRegex ptr, byval string as const gchar ptr, byval match_options as GRegexMatchFlags, byval match_info as GMatchInfo ptr ptr) as gboolean
declare function g_regex_match_full(byval regex as const GRegex ptr, byval string as const gchar ptr, byval string_len as gssize, byval start_position as gint, byval match_options as GRegexMatchFlags, byval match_info as GMatchInfo ptr ptr, byval error as GError ptr ptr) as gboolean
declare function g_regex_match_all(byval regex as const GRegex ptr, byval string as const gchar ptr, byval match_options as GRegexMatchFlags, byval match_info as GMatchInfo ptr ptr) as gboolean
declare function g_regex_match_all_full(byval regex as const GRegex ptr, byval string as const gchar ptr, byval string_len as gssize, byval start_position as gint, byval match_options as GRegexMatchFlags, byval match_info as GMatchInfo ptr ptr, byval error as GError ptr ptr) as gboolean
declare function g_regex_split_simple(byval pattern as const gchar ptr, byval string as const gchar ptr, byval compile_options as GRegexCompileFlags, byval match_options as GRegexMatchFlags) as gchar ptr ptr
declare function g_regex_split(byval regex as const GRegex ptr, byval string as const gchar ptr, byval match_options as GRegexMatchFlags) as gchar ptr ptr
declare function g_regex_split_full(byval regex as const GRegex ptr, byval string as const gchar ptr, byval string_len as gssize, byval start_position as gint, byval match_options as GRegexMatchFlags, byval max_tokens as gint, byval error as GError ptr ptr) as gchar ptr ptr
declare function g_regex_replace(byval regex as const GRegex ptr, byval string as const gchar ptr, byval string_len as gssize, byval start_position as gint, byval replacement as const gchar ptr, byval match_options as GRegexMatchFlags, byval error as GError ptr ptr) as gchar ptr
declare function g_regex_replace_literal(byval regex as const GRegex ptr, byval string as const gchar ptr, byval string_len as gssize, byval start_position as gint, byval replacement as const gchar ptr, byval match_options as GRegexMatchFlags, byval error as GError ptr ptr) as gchar ptr
declare function g_regex_replace_eval(byval regex as const GRegex ptr, byval string as const gchar ptr, byval string_len as gssize, byval start_position as gint, byval match_options as GRegexMatchFlags, byval eval as GRegexEvalCallback, byval user_data as gpointer, byval error as GError ptr ptr) as gchar ptr
declare function g_regex_check_replacement(byval replacement as const gchar ptr, byval has_references as gboolean ptr, byval error as GError ptr ptr) as gboolean
declare function g_match_info_get_regex(byval match_info as const GMatchInfo ptr) as GRegex ptr
declare function g_match_info_get_string(byval match_info as const GMatchInfo ptr) as const gchar ptr
declare function g_match_info_ref(byval match_info as GMatchInfo ptr) as GMatchInfo ptr
declare sub g_match_info_unref(byval match_info as GMatchInfo ptr)
declare sub g_match_info_free(byval match_info as GMatchInfo ptr)
declare function g_match_info_next(byval match_info as GMatchInfo ptr, byval error as GError ptr ptr) as gboolean
declare function g_match_info_matches(byval match_info as const GMatchInfo ptr) as gboolean
declare function g_match_info_get_match_count(byval match_info as const GMatchInfo ptr) as gint
declare function g_match_info_is_partial_match(byval match_info as const GMatchInfo ptr) as gboolean
declare function g_match_info_expand_references(byval match_info as const GMatchInfo ptr, byval string_to_expand as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_match_info_fetch(byval match_info as const GMatchInfo ptr, byval match_num as gint) as gchar ptr
declare function g_match_info_fetch_pos(byval match_info as const GMatchInfo ptr, byval match_num as gint, byval start_pos as gint ptr, byval end_pos as gint ptr) as gboolean
declare function g_match_info_fetch_named(byval match_info as const GMatchInfo ptr, byval name as const gchar ptr) as gchar ptr
declare function g_match_info_fetch_named_pos(byval match_info as const GMatchInfo ptr, byval name as const gchar ptr, byval start_pos as gint ptr, byval end_pos as gint ptr) as gboolean
declare function g_match_info_fetch_all(byval match_info as const GMatchInfo ptr) as gchar ptr ptr
#define __G_SCANNER_H__

type GScanner as _GScanner
type GScannerConfig as _GScannerConfig
type GTokenValue as _GTokenValue
type GScannerMsgFunc as sub(byval scanner as GScanner ptr, byval message as gchar ptr, byval error as gboolean)

#define G_CSET_A_2_Z_ "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define G_CSET_a_2_z "abcdefghijklmnopqrstuvwxyz"
#define G_CSET_DIGITS "0123456789"
#define G_CSET_LATINC !"\192\193\194\195\196\197\198" !"\199\200\201\202\203\204\205\206\207\208" !"\209\210\211\212\213\214" !"\216\217\218\219\220\221\222"
#define G_CSET_LATINS !"\223\224\225\226\227\228\229\230" !"\231\232\233\234\235\236\237\238\239\240" !"\241\242\243\244\245\246" !"\248\249\250\251\252\253\254\255"

type GErrorType as long
enum
	G_ERR_UNKNOWN
	G_ERR_UNEXP_EOF
	G_ERR_UNEXP_EOF_IN_STRING
	G_ERR_UNEXP_EOF_IN_COMMENT
	G_ERR_NON_DIGIT_IN_CONST
	G_ERR_DIGIT_RADIX
	G_ERR_FLOAT_RADIX
	G_ERR_FLOAT_MALFORMED
end enum

type GTokenType as long
enum
	G_TOKEN_EOF = 0
	G_TOKEN_LEFT_PAREN = asc("(")
	G_TOKEN_RIGHT_PAREN = asc(")")
	G_TOKEN_LEFT_CURLY = asc("{")
	G_TOKEN_RIGHT_CURLY = asc("}")
	G_TOKEN_LEFT_BRACE = asc("[")
	G_TOKEN_RIGHT_BRACE = asc("]")
	G_TOKEN_EQUAL_SIGN = asc("=")
	G_TOKEN_COMMA = asc(",")
	G_TOKEN_NONE = 256
	G_TOKEN_ERROR
	G_TOKEN_CHAR
	G_TOKEN_BINARY
	G_TOKEN_OCTAL
	G_TOKEN_INT
	G_TOKEN_HEX
	G_TOKEN_FLOAT
	G_TOKEN_STRING
	G_TOKEN_SYMBOL
	G_TOKEN_IDENTIFIER
	G_TOKEN_IDENTIFIER_NULL
	G_TOKEN_COMMENT_SINGLE
	G_TOKEN_COMMENT_MULTI
	G_TOKEN_LAST
end enum

union _GTokenValue
	v_symbol as gpointer
	v_identifier as gchar ptr
	v_binary as gulong
	v_octal as gulong
	v_int as gulong
	v_int64 as guint64
	v_float as gdouble
	v_hex as gulong
	v_string as gchar ptr
	v_comment as gchar ptr
	v_char as guchar
	v_error as guint
end union

type _GScannerConfig
	cset_skip_characters as gchar ptr
	cset_identifier_first as gchar ptr
	cset_identifier_nth as gchar ptr
	cpair_comment_single as gchar ptr
	case_sensitive : 1 as guint
	skip_comment_multi : 1 as guint
	skip_comment_single : 1 as guint
	scan_comment_multi : 1 as guint
	scan_identifier : 1 as guint
	scan_identifier_1char : 1 as guint
	scan_identifier_NULL : 1 as guint
	scan_symbols : 1 as guint
	scan_binary : 1 as guint
	scan_octal : 1 as guint
	scan_float : 1 as guint
	scan_hex : 1 as guint
	scan_hex_dollar : 1 as guint
	scan_string_sq : 1 as guint
	scan_string_dq : 1 as guint
	numbers_2_int : 1 as guint
	int_2_float : 1 as guint
	identifier_2_string : 1 as guint
	char_2_token : 1 as guint
	symbol_2_token : 1 as guint
	scope_0_fallback : 1 as guint
	store_int64 : 1 as guint
	padding_dummy as guint
end type

type _GScanner
	user_data as gpointer
	max_parse_errors as guint
	parse_errors as guint
	input_name as const gchar ptr
	qdata as GData ptr
	config as GScannerConfig ptr
	token as GTokenType
	value as GTokenValue
	line as guint
	position as guint
	next_token as GTokenType
	next_value as GTokenValue
	next_line as guint
	next_position as guint
	symbol_table as GHashTable ptr
	input_fd as gint
	text as const gchar ptr
	text_end as const gchar ptr
	buffer as gchar ptr
	scope_id as guint
	msg_handler as GScannerMsgFunc
end type

declare function g_scanner_new(byval config_templ as const GScannerConfig ptr) as GScanner ptr
declare sub g_scanner_destroy(byval scanner as GScanner ptr)
declare sub g_scanner_input_file(byval scanner as GScanner ptr, byval input_fd as gint)
declare sub g_scanner_sync_file_offset(byval scanner as GScanner ptr)
declare sub g_scanner_input_text(byval scanner as GScanner ptr, byval text as const gchar ptr, byval text_len as guint)
declare function g_scanner_get_next_token(byval scanner as GScanner ptr) as GTokenType
declare function g_scanner_peek_next_token(byval scanner as GScanner ptr) as GTokenType
declare function g_scanner_cur_token(byval scanner as GScanner ptr) as GTokenType
declare function g_scanner_cur_value(byval scanner as GScanner ptr) as GTokenValue
declare function g_scanner_cur_line(byval scanner as GScanner ptr) as guint
declare function g_scanner_cur_position(byval scanner as GScanner ptr) as guint
declare function g_scanner_eof(byval scanner as GScanner ptr) as gboolean
declare function g_scanner_set_scope(byval scanner as GScanner ptr, byval scope_id as guint) as guint
declare sub g_scanner_scope_add_symbol(byval scanner as GScanner ptr, byval scope_id as guint, byval symbol as const gchar ptr, byval value as gpointer)
declare sub g_scanner_scope_remove_symbol(byval scanner as GScanner ptr, byval scope_id as guint, byval symbol as const gchar ptr)
declare function g_scanner_scope_lookup_symbol(byval scanner as GScanner ptr, byval scope_id as guint, byval symbol as const gchar ptr) as gpointer
declare sub g_scanner_scope_foreach_symbol(byval scanner as GScanner ptr, byval scope_id as guint, byval func as GHFunc, byval user_data as gpointer)
declare function g_scanner_lookup_symbol(byval scanner as GScanner ptr, byval symbol as const gchar ptr) as gpointer
declare sub g_scanner_unexp_token(byval scanner as GScanner ptr, byval expected_token as GTokenType, byval identifier_spec as const gchar ptr, byval symbol_spec as const gchar ptr, byval symbol_name as const gchar ptr, byval message as const gchar ptr, byval is_error as gint)
declare sub g_scanner_error(byval scanner as GScanner ptr, byval format as const gchar ptr, ...)
declare sub g_scanner_warn(byval scanner as GScanner ptr, byval format as const gchar ptr, ...)

#define g_scanner_add_symbol(scanner, symbol, value) scope : g_scanner_scope_add_symbol((scanner), 0, (symbol), (value)) : end scope
#define g_scanner_remove_symbol(scanner, symbol) scope : g_scanner_scope_remove_symbol((scanner), 0, (symbol)) : end scope
#define g_scanner_foreach_symbol(scanner, func, data) scope : g_scanner_scope_foreach_symbol((scanner), 0, (func), (data)) : end scope
#define g_scanner_freeze_symbol_table(scanner) 0
#define g_scanner_thaw_symbol_table(scanner) 0
#define __G_SEQUENCE_H__

type GSequence as _GSequence
type GSequenceIter as _GSequenceNode
type GSequenceIterCompareFunc as function(byval a as GSequenceIter ptr, byval b as GSequenceIter ptr, byval data as gpointer) as gint

declare function g_sequence_new(byval data_destroy as GDestroyNotify) as GSequence ptr
declare sub g_sequence_free(byval seq as GSequence ptr)
declare function g_sequence_get_length(byval seq as GSequence ptr) as gint
declare sub g_sequence_foreach(byval seq as GSequence ptr, byval func as GFunc, byval user_data as gpointer)
declare sub g_sequence_foreach_range(byval begin as GSequenceIter ptr, byval end as GSequenceIter ptr, byval func as GFunc, byval user_data as gpointer)
declare sub g_sequence_sort(byval seq as GSequence ptr, byval cmp_func as GCompareDataFunc, byval cmp_data as gpointer)
declare sub g_sequence_sort_iter(byval seq as GSequence ptr, byval cmp_func as GSequenceIterCompareFunc, byval cmp_data as gpointer)
declare function g_sequence_get_begin_iter(byval seq as GSequence ptr) as GSequenceIter ptr
declare function g_sequence_get_end_iter(byval seq as GSequence ptr) as GSequenceIter ptr
declare function g_sequence_get_iter_at_pos(byval seq as GSequence ptr, byval pos as gint) as GSequenceIter ptr
declare function g_sequence_append(byval seq as GSequence ptr, byval data as gpointer) as GSequenceIter ptr
declare function g_sequence_prepend(byval seq as GSequence ptr, byval data as gpointer) as GSequenceIter ptr
declare function g_sequence_insert_before(byval iter as GSequenceIter ptr, byval data as gpointer) as GSequenceIter ptr
declare sub g_sequence_move(byval src as GSequenceIter ptr, byval dest as GSequenceIter ptr)
declare sub g_sequence_swap(byval a as GSequenceIter ptr, byval b as GSequenceIter ptr)
declare function g_sequence_insert_sorted(byval seq as GSequence ptr, byval data as gpointer, byval cmp_func as GCompareDataFunc, byval cmp_data as gpointer) as GSequenceIter ptr
declare function g_sequence_insert_sorted_iter(byval seq as GSequence ptr, byval data as gpointer, byval iter_cmp as GSequenceIterCompareFunc, byval cmp_data as gpointer) as GSequenceIter ptr
declare sub g_sequence_sort_changed(byval iter as GSequenceIter ptr, byval cmp_func as GCompareDataFunc, byval cmp_data as gpointer)
declare sub g_sequence_sort_changed_iter(byval iter as GSequenceIter ptr, byval iter_cmp as GSequenceIterCompareFunc, byval cmp_data as gpointer)
declare sub g_sequence_remove(byval iter as GSequenceIter ptr)
declare sub g_sequence_remove_range(byval begin as GSequenceIter ptr, byval end as GSequenceIter ptr)
declare sub g_sequence_move_range(byval dest as GSequenceIter ptr, byval begin as GSequenceIter ptr, byval end as GSequenceIter ptr)
declare function g_sequence_search(byval seq as GSequence ptr, byval data as gpointer, byval cmp_func as GCompareDataFunc, byval cmp_data as gpointer) as GSequenceIter ptr
declare function g_sequence_search_iter(byval seq as GSequence ptr, byval data as gpointer, byval iter_cmp as GSequenceIterCompareFunc, byval cmp_data as gpointer) as GSequenceIter ptr
declare function g_sequence_lookup(byval seq as GSequence ptr, byval data as gpointer, byval cmp_func as GCompareDataFunc, byval cmp_data as gpointer) as GSequenceIter ptr
declare function g_sequence_lookup_iter(byval seq as GSequence ptr, byval data as gpointer, byval iter_cmp as GSequenceIterCompareFunc, byval cmp_data as gpointer) as GSequenceIter ptr
declare function g_sequence_get(byval iter as GSequenceIter ptr) as gpointer
declare sub g_sequence_set(byval iter as GSequenceIter ptr, byval data as gpointer)
declare function g_sequence_iter_is_begin(byval iter as GSequenceIter ptr) as gboolean
declare function g_sequence_iter_is_end(byval iter as GSequenceIter ptr) as gboolean
declare function g_sequence_iter_next(byval iter as GSequenceIter ptr) as GSequenceIter ptr
declare function g_sequence_iter_prev(byval iter as GSequenceIter ptr) as GSequenceIter ptr
declare function g_sequence_iter_get_position(byval iter as GSequenceIter ptr) as gint
declare function g_sequence_iter_move(byval iter as GSequenceIter ptr, byval delta as gint) as GSequenceIter ptr
declare function g_sequence_iter_get_sequence(byval iter as GSequenceIter ptr) as GSequence ptr
declare function g_sequence_iter_compare(byval a as GSequenceIter ptr, byval b as GSequenceIter ptr) as gint
declare function g_sequence_range_get_midpoint(byval begin as GSequenceIter ptr, byval end as GSequenceIter ptr) as GSequenceIter ptr
#define __G_SHELL_H__
#define G_SHELL_ERROR g_shell_error_quark()

type GShellError as long
enum
	G_SHELL_ERROR_BAD_QUOTING
	G_SHELL_ERROR_EMPTY_STRING
	G_SHELL_ERROR_FAILED
end enum

declare function g_shell_error_quark() as GQuark
declare function g_shell_quote(byval unquoted_string as const gchar ptr) as gchar ptr
declare function g_shell_unquote(byval quoted_string as const gchar ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_shell_parse_argv(byval command_line as const gchar ptr, byval argcp as gint ptr, byval argvp as gchar ptr ptr ptr, byval error as GError ptr ptr) as gboolean
#define __G_SLICE_H__
declare function g_slice_alloc(byval block_size as gsize) as gpointer
declare function g_slice_alloc0(byval block_size as gsize) as gpointer
declare function g_slice_copy(byval block_size as gsize, byval mem_block as gconstpointer) as gpointer
declare sub g_slice_free1(byval block_size as gsize, byval mem_block as gpointer)
declare sub g_slice_free_chain_with_offset(byval block_size as gsize, byval mem_chain as gpointer, byval next_offset as gsize)

#define g_slice_new(type) cptr(type ptr, g_slice_alloc(sizeof(type)))
#define g_slice_new0(type) cptr(type ptr, g_slice_alloc0(sizeof(type)))
#define g_slice_dup(type, mem) cptr(type ptr, g_slice_copy(sizeof(type), (mem)))
#define g_slice_free(type, mem) scope : g_slice_free1(sizeof(type), (mem)) : end scope
#define g_slice_free_chain(type, mem_chain, next) scope : g_slice_free_chain_with_offset(sizeof(type), (mem_chain), G_STRUCT_OFFSET(type, next)) : end scope

type GSliceConfig as long
enum
	G_SLICE_CONFIG_ALWAYS_MALLOC = 1
	G_SLICE_CONFIG_BYPASS_MAGAZINES
	G_SLICE_CONFIG_WORKING_SET_MSECS
	G_SLICE_CONFIG_COLOR_INCREMENT
	G_SLICE_CONFIG_CHUNK_SIZES
	G_SLICE_CONFIG_CONTENTION_COUNTER
end enum

declare sub g_slice_set_config(byval ckey as GSliceConfig, byval value as gint64)
declare function g_slice_get_config(byval ckey as GSliceConfig) as gint64
declare function g_slice_get_config_state(byval ckey as GSliceConfig, byval address as gint64, byval n_values as guint ptr) as gint64 ptr
#define __G_SPAWN_H__
#define G_SPAWN_ERROR g_spawn_error_quark()

type GSpawnError as long
enum
	G_SPAWN_ERROR_FORK
	G_SPAWN_ERROR_READ
	G_SPAWN_ERROR_CHDIR
	G_SPAWN_ERROR_ACCES
	G_SPAWN_ERROR_PERM
	G_SPAWN_ERROR_TOO_BIG
	G_SPAWN_ERROR_2BIG = G_SPAWN_ERROR_TOO_BIG
	G_SPAWN_ERROR_NOEXEC
	G_SPAWN_ERROR_NAMETOOLONG
	G_SPAWN_ERROR_NOENT
	G_SPAWN_ERROR_NOMEM
	G_SPAWN_ERROR_NOTDIR
	G_SPAWN_ERROR_LOOP
	G_SPAWN_ERROR_TXTBUSY
	G_SPAWN_ERROR_IO
	G_SPAWN_ERROR_NFILE
	G_SPAWN_ERROR_MFILE
	G_SPAWN_ERROR_INVAL
	G_SPAWN_ERROR_ISDIR
	G_SPAWN_ERROR_LIBBAD
	G_SPAWN_ERROR_FAILED
end enum

#define G_SPAWN_EXIT_ERROR g_spawn_exit_error_quark()
type GSpawnChildSetupFunc as sub(byval user_data as gpointer)

type GSpawnFlags as long
enum
	G_SPAWN_DEFAULT = 0
	G_SPAWN_LEAVE_DESCRIPTORS_OPEN = 1 shl 0
	G_SPAWN_DO_NOT_REAP_CHILD = 1 shl 1
	G_SPAWN_SEARCH_PATH = 1 shl 2
	G_SPAWN_STDOUT_TO_DEV_NULL = 1 shl 3
	G_SPAWN_STDERR_TO_DEV_NULL = 1 shl 4
	G_SPAWN_CHILD_INHERITS_STDIN = 1 shl 5
	G_SPAWN_FILE_AND_ARGV_ZERO = 1 shl 6
	G_SPAWN_SEARCH_PATH_FROM_ENVP = 1 shl 7
	G_SPAWN_CLOEXEC_PIPES = 1 shl 8
end enum

declare function g_spawn_error_quark() as GQuark
declare function g_spawn_exit_error_quark() as GQuark

#ifdef __FB_UNIX__
	declare function g_spawn_async(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as GPid ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_async_with_pipes(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as GPid ptr, byval standard_input as gint ptr, byval standard_output as gint ptr, byval standard_error as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_sync(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval standard_output as gchar ptr ptr, byval standard_error as gchar ptr ptr, byval exit_status as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_command_line_sync(byval command_line as const gchar ptr, byval standard_output as gchar ptr ptr, byval standard_error as gchar ptr ptr, byval exit_status as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_command_line_async(byval command_line as const gchar ptr, byval error as GError ptr ptr) as gboolean
#else
	declare function g_spawn_async_ alias "g_spawn_async"(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as GPid ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_async_with_pipes_ alias "g_spawn_async_with_pipes"(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as GPid ptr, byval standard_input as gint ptr, byval standard_output as gint ptr, byval standard_error as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_sync_ alias "g_spawn_sync"(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval standard_output as gchar ptr ptr, byval standard_error as gchar ptr ptr, byval exit_status as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_command_line_sync_ alias "g_spawn_command_line_sync"(byval command_line as const gchar ptr, byval standard_output as gchar ptr ptr, byval standard_error as gchar ptr ptr, byval exit_status as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_command_line_async_ alias "g_spawn_command_line_async"(byval command_line as const gchar ptr, byval error as GError ptr ptr) as gboolean
#endif

declare function g_spawn_check_exit_status(byval exit_status as gint, byval error as GError ptr ptr) as gboolean
declare sub g_spawn_close_pid(byval pid as GPid)

#ifdef __FB_WIN32__
	declare function g_spawn_async_utf8(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as GPid ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_async alias "g_spawn_async_utf8"(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as GPid ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_async_with_pipes_utf8(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as GPid ptr, byval standard_input as gint ptr, byval standard_output as gint ptr, byval standard_error as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_async_with_pipes alias "g_spawn_async_with_pipes_utf8"(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as GPid ptr, byval standard_input as gint ptr, byval standard_output as gint ptr, byval standard_error as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_sync_utf8(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval standard_output as gchar ptr ptr, byval standard_error as gchar ptr ptr, byval exit_status as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_sync alias "g_spawn_sync_utf8"(byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval standard_output as gchar ptr ptr, byval standard_error as gchar ptr ptr, byval exit_status as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_command_line_sync_utf8(byval command_line as const gchar ptr, byval standard_output as gchar ptr ptr, byval standard_error as gchar ptr ptr, byval exit_status as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_command_line_sync alias "g_spawn_command_line_sync_utf8"(byval command_line as const gchar ptr, byval standard_output as gchar ptr ptr, byval standard_error as gchar ptr ptr, byval exit_status as gint ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_command_line_async_utf8(byval command_line as const gchar ptr, byval error as GError ptr ptr) as gboolean
	declare function g_spawn_command_line_async alias "g_spawn_command_line_async_utf8"(byval command_line as const gchar ptr, byval error as GError ptr ptr) as gboolean
#endif

#define __G_STRFUNCS_H__

type GAsciiType as long
enum
	G_ASCII_ALNUM = 1 shl 0
	G_ASCII_ALPHA = 1 shl 1
	G_ASCII_CNTRL = 1 shl 2
	G_ASCII_DIGIT = 1 shl 3
	G_ASCII_GRAPH = 1 shl 4
	G_ASCII_LOWER = 1 shl 5
	G_ASCII_PRINT = 1 shl 6
	G_ASCII_PUNCT = 1 shl 7
	G_ASCII_SPACE = 1 shl 8
	G_ASCII_UPPER = 1 shl 9
	G_ASCII_XDIGIT = 1 shl 10
end enum

#if (defined(__FB_WIN32__) and (not defined(GLIB_STATIC_COMPILATION))) or defined(__FB_CYGWIN__)
	extern import g_ascii_table as const guint16 const ptr
#else
	extern g_ascii_table as const guint16 const ptr
#endif

#define g_ascii_isalnum(c) ((g_ascii_table[cast(guchar, (c))] and G_ASCII_ALNUM) <> 0)
#define g_ascii_isalpha(c) ((g_ascii_table[cast(guchar, (c))] and G_ASCII_ALPHA) <> 0)
#define g_ascii_iscntrl(c) ((g_ascii_table[cast(guchar, (c))] and G_ASCII_CNTRL) <> 0)
#define g_ascii_isdigit(c) ((g_ascii_table[cast(guchar, (c))] and G_ASCII_DIGIT) <> 0)
#define g_ascii_isgraph(c) ((g_ascii_table[cast(guchar, (c))] and G_ASCII_GRAPH) <> 0)
#define g_ascii_islower(c) ((g_ascii_table[cast(guchar, (c))] and G_ASCII_LOWER) <> 0)
#define g_ascii_isprint(c) ((g_ascii_table[cast(guchar, (c))] and G_ASCII_PRINT) <> 0)
#define g_ascii_ispunct(c) ((g_ascii_table[cast(guchar, (c))] and G_ASCII_PUNCT) <> 0)
#define g_ascii_isspace(c) ((g_ascii_table[cast(guchar, (c))] and G_ASCII_SPACE) <> 0)
#define g_ascii_isupper(c) ((g_ascii_table[cast(guchar, (c))] and G_ASCII_UPPER) <> 0)
#define g_ascii_isxdigit(c) ((g_ascii_table[cast(guchar, (c))] and G_ASCII_XDIGIT) <> 0)

declare function g_ascii_tolower(byval c as byte) as byte
declare function g_ascii_toupper(byval c as byte) as byte
declare function g_ascii_digit_value(byval c as byte) as gint
declare function g_ascii_xdigit_value(byval c as byte) as gint
#define G_STR_DELIMITERS "_-|> <."
declare function g_strdelimit(byval string as gchar ptr, byval delimiters as const gchar ptr, byval new_delimiter as byte) as gchar ptr
declare function g_strcanon(byval string as gchar ptr, byval valid_chars as const gchar ptr, byval substitutor as byte) as gchar ptr
declare function g_strerror(byval errnum as gint) as const gchar ptr
declare function g_strsignal(byval signum as gint) as const gchar ptr
declare function g_strreverse(byval string as gchar ptr) as gchar ptr
declare function g_strlcpy(byval dest as gchar ptr, byval src as const gchar ptr, byval dest_size as gsize) as gsize
declare function g_strlcat(byval dest as gchar ptr, byval src as const gchar ptr, byval dest_size as gsize) as gsize
declare function g_strstr_len(byval haystack as const gchar ptr, byval haystack_len as gssize, byval needle as const gchar ptr) as gchar ptr
declare function g_strrstr(byval haystack as const gchar ptr, byval needle as const gchar ptr) as gchar ptr
declare function g_strrstr_len(byval haystack as const gchar ptr, byval haystack_len as gssize, byval needle as const gchar ptr) as gchar ptr
declare function g_str_has_suffix(byval str as const gchar ptr, byval suffix as const gchar ptr) as gboolean
declare function g_str_has_prefix(byval str as const gchar ptr, byval prefix as const gchar ptr) as gboolean
declare function g_strtod(byval nptr as const gchar ptr, byval endptr as gchar ptr ptr) as gdouble
declare function g_ascii_strtod(byval nptr as const gchar ptr, byval endptr as gchar ptr ptr) as gdouble
declare function g_ascii_strtoull(byval nptr as const gchar ptr, byval endptr as gchar ptr ptr, byval base as guint) as guint64
declare function g_ascii_strtoll(byval nptr as const gchar ptr, byval endptr as gchar ptr ptr, byval base as guint) as gint64
const G_ASCII_DTOSTR_BUF_SIZE = 29 + 10
declare function g_ascii_dtostr(byval buffer as gchar ptr, byval buf_len as gint, byval d as gdouble) as gchar ptr
declare function g_ascii_formatd(byval buffer as gchar ptr, byval buf_len as gint, byval format as const gchar ptr, byval d as gdouble) as gchar ptr
declare function g_strchug(byval string as gchar ptr) as gchar ptr
declare function g_strchomp(byval string as gchar ptr) as gchar ptr
#define g_strstrip(string) g_strchomp(g_strchug(string))
declare function g_ascii_strcasecmp(byval s1 as const gchar ptr, byval s2 as const gchar ptr) as gint
declare function g_ascii_strncasecmp(byval s1 as const gchar ptr, byval s2 as const gchar ptr, byval n as gsize) as gint
declare function g_ascii_strdown(byval str as const gchar ptr, byval len as gssize) as gchar ptr
declare function g_ascii_strup(byval str as const gchar ptr, byval len as gssize) as gchar ptr
declare function g_str_is_ascii(byval str as const gchar ptr) as gboolean
declare function g_strcasecmp(byval s1 as const gchar ptr, byval s2 as const gchar ptr) as gint
declare function g_strncasecmp(byval s1 as const gchar ptr, byval s2 as const gchar ptr, byval n as guint) as gint
declare function g_strdown(byval string as gchar ptr) as gchar ptr
declare function g_strup(byval string as gchar ptr) as gchar ptr
declare function g_strdup(byval str as const gchar ptr) as gchar ptr
declare function g_strdup_printf(byval format as const gchar ptr, ...) as gchar ptr
declare function g_strdup_vprintf(byval format as const gchar ptr, byval args as va_list) as gchar ptr
declare function g_strndup(byval str as const gchar ptr, byval n as gsize) as gchar ptr
declare function g_strnfill(byval length as gsize, byval fill_char as byte) as gchar ptr
declare function g_strconcat(byval string1 as const gchar ptr, ...) as gchar ptr
declare function g_strjoin(byval separator as const gchar ptr, ...) as gchar ptr
declare function g_strcompress(byval source as const gchar ptr) as gchar ptr
declare function g_strescape(byval source as const gchar ptr, byval exceptions as const gchar ptr) as gchar ptr
declare function g_memdup(byval mem as gconstpointer, byval byte_size as guint) as gpointer
declare function g_strsplit(byval string as const gchar ptr, byval delimiter as const gchar ptr, byval max_tokens as gint) as gchar ptr ptr
declare function g_strsplit_set(byval string as const gchar ptr, byval delimiters as const gchar ptr, byval max_tokens as gint) as gchar ptr ptr
declare function g_strjoinv(byval separator as const gchar ptr, byval str_array as gchar ptr ptr) as gchar ptr
declare sub g_strfreev(byval str_array as gchar ptr ptr)
declare function g_strdupv(byval str_array as gchar ptr ptr) as gchar ptr ptr
declare function g_strv_length(byval str_array as gchar ptr ptr) as guint
declare function g_stpcpy(byval dest as gchar ptr, byval src as const zstring ptr) as gchar ptr
declare function g_str_to_ascii(byval str as const gchar ptr, byval from_locale as const gchar ptr) as gchar ptr
declare function g_str_tokenize_and_fold(byval string as const gchar ptr, byval translit_locale as const gchar ptr, byval ascii_alternates as gchar ptr ptr ptr) as gchar ptr ptr
declare function g_str_match_string(byval search_term as const gchar ptr, byval potential_hit as const gchar ptr, byval accept_alternates as gboolean) as gboolean
declare function g_strv_contains(byval strv as const gchar const ptr ptr, byval str as const gchar ptr) as gboolean
#define __G_STRINGCHUNK_H__
type GStringChunk as _GStringChunk
declare function g_string_chunk_new(byval size as gsize) as GStringChunk ptr
declare sub g_string_chunk_free(byval chunk as GStringChunk ptr)
declare sub g_string_chunk_clear(byval chunk as GStringChunk ptr)
declare function g_string_chunk_insert(byval chunk as GStringChunk ptr, byval string as const gchar ptr) as gchar ptr
declare function g_string_chunk_insert_len(byval chunk as GStringChunk ptr, byval string as const gchar ptr, byval len as gssize) as gchar ptr
declare function g_string_chunk_insert_const(byval chunk as GStringChunk ptr, byval string as const gchar ptr) as gchar ptr
#define __G_TEST_UTILS_H__

type GTestFunc as sub()
type GTestDataFunc as sub(byval user_data as gconstpointer)
type GTestFixtureFunc as sub(byval fixture as gpointer, byval user_data as gconstpointer)
#macro g_assert_cmpstr(s1, cmp, s2)
	scope
		dim as const zstring ptr __s1 = (s1), __s2 = (s2)
		if g_strcmp0(__s1, __s2) cmp 0 then
		else
			g_assertion_message_cmpstr(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #s1 " " #cmp " " #s2, __s1, #cmp, __s2)
		end if
	end scope
#endmacro
#macro g_assert_cmpint(n1, cmp, n2)
	scope
		dim as gint64 __n1 = (n1), __n2 = (n2)
		if __n1 cmp __n2 then
		else
			g_assertion_message_cmpnum(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #n1 " " #cmp " " #n2, __n1, #cmp, __n2, 'i')
		end if
	end scope
#endmacro
#macro g_assert_cmpuint(n1, cmp, n2)
	scope
		dim as guint64 __n1 = (n1), __n2 = (n2)
		if __n1 cmp __n2
		else
			g_assertion_message_cmpnum(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #n1 " " #cmp " " #n2, __n1, #cmp, __n2, 'i')
		end if
	end scope
#endmacro
#macro g_assert_cmphex(n1, cmp, n2)
	scope
		dim as guint64 __n1 = (n1), __n2 = (n2)
		if __n1 cmp __n2 then
		else
			g_assertion_message_cmpnum(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #n1 " " #cmp " " #n2, __n1, #cmp, __n2, 'x')
		end if
	end scope
#endmacro
#macro g_assert_cmpfloat(n1, cmp, n2)
	scope
		dim as double __n1 = (n1), __n2 = (n2)
		if __n1 cmp __n2 then
		else
			g_assertion_message_cmpnum(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #n1 " " #cmp " " #n2, __n1, #cmp, __n2, 'f')
		end if
	end scope
#endmacro

#macro g_assert_no_error(err)
	if err then
		g_assertion_message_error(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #err, err, 0, 0)
	end if
#endmacro
#macro g_assert_error(err, dom, c)
	if ((err = 0) orelse ((err)->domain <> dom)) orelse ((err)->code <> c) then
		g_assertion_message_error(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #err, err, dom, c)
	end if
#endmacro
#macro g_assert_true(expr)
	if G_LIKELY(expr) then
	else
		g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, "'" #expr "' should be TRUE")
	end if
#endmacro
#macro g_assert_false(expr)
	if G_LIKELY(-((expr) = 0)) then
	else
		g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, "'" #expr "' should be FALSE")
	end if
#endmacro
#macro g_assert_null(expr)
	if G_LIKELY(-((expr) = NULL)) then
	else
		g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, "'" #expr "' should be NULL")
	end if
#endmacro
#macro g_assert_nonnull(expr)
	if G_LIKELY(-((expr) <> NULL)) then
	else
		g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, "'" #expr "' should not be NULL")
	end if
#endmacro
#define g_assert_not_reached() scope : g_assertion_message_expr(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, NULL) : end scope
#macro g_assert(expr)
	if G_LIKELY(expr) then
	else
		g_assertion_message_expr(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #expr)
	end if
#endmacro

declare function g_strcmp0(byval str1 as const zstring ptr, byval str2 as const zstring ptr) as long
declare sub g_test_minimized_result(byval minimized_quantity as double, byval format as const zstring ptr, ...)
declare sub g_test_maximized_result(byval maximized_quantity as double, byval format as const zstring ptr, ...)
declare sub g_test_init(byval argc as long ptr, byval argv as zstring ptr ptr ptr, ...)

#define g_test_initialized() g_test_config_vars->test_initialized
#define g_test_quick() g_test_config_vars->test_quick
#define g_test_slow() (g_test_config_vars->test_quick = 0)
#define g_test_thorough() (g_test_config_vars->test_quick = 0)
#define g_test_perf() g_test_config_vars->test_perf
#define g_test_verbose() g_test_config_vars->test_verbose
#define g_test_quiet() g_test_config_vars->test_quiet
#define g_test_undefined() g_test_config_vars->test_undefined

declare function g_test_subprocess() as gboolean
declare function g_test_run() as long
declare sub g_test_add_func(byval testpath as const zstring ptr, byval test_func as GTestFunc)
declare sub g_test_add_data_func(byval testpath as const zstring ptr, byval test_data as gconstpointer, byval test_func as GTestDataFunc)
declare sub g_test_add_data_func_full(byval testpath as const zstring ptr, byval test_data as gpointer, byval test_func as GTestDataFunc, byval data_free_func as GDestroyNotify)
declare sub g_test_fail()
declare sub g_test_incomplete(byval msg as const gchar ptr)
declare sub g_test_skip(byval msg as const gchar ptr)
declare function g_test_failed() as gboolean
declare sub g_test_set_nonfatal_assertions()
#macro g_test_add(testpath, Fixture, tdata, fsetup, ftest, fteardown)
	scope
		dim add_vtable as sub cdecl(byval as const zstring ptr, byval as gsize, byval as gconstpointer, byval as sub cdecl(byval as Fixture ptr, byval as gconstpointer), byval as sub cdecl(byval as Fixture ptr, byval as gconstpointer), byval as sub cdecl(byval as Fixture ptr, byval as gconstpointer)) = cptr(sub cdecl(byval as const gchar ptr, byval as gsize, byval as gconstpointer, byval as sub cdecl(byval as Fixture ptr, byval as gconstpointer), byval as sub cdecl(byval as Fixture ptr, byval as gconstpointer), byval as sub cdecl(byval as Fixture ptr, byval as gconstpointer)), @g_test_add_vtable)
		add_vtable(testpath, sizeof(Fixture), tdata, fsetup, ftest, fteardown)
	end scope
#endmacro
declare sub g_test_message(byval format as const zstring ptr, ...)
declare sub g_test_bug_base(byval uri_pattern as const zstring ptr)
declare sub g_test_bug(byval bug_uri_snippet as const zstring ptr)
declare sub g_test_timer_start()
declare function g_test_timer_elapsed() as double
declare function g_test_timer_last() as double
declare sub g_test_queue_free(byval gfree_pointer as gpointer)
declare sub g_test_queue_destroy(byval destroy_func as GDestroyNotify, byval destroy_data as gpointer)
#define g_test_queue_unref(gobject) g_test_queue_destroy(g_object_unref, gobject)

type GTestTrapFlags as long
enum
	G_TEST_TRAP_SILENCE_STDOUT = 1 shl 7
	G_TEST_TRAP_SILENCE_STDERR = 1 shl 8
	G_TEST_TRAP_INHERIT_STDIN = 1 shl 9
end enum

declare function g_test_trap_fork(byval usec_timeout as guint64, byval test_trap_flags as GTestTrapFlags) as gboolean

type GTestSubprocessFlags as long
enum
	G_TEST_SUBPROCESS_INHERIT_STDIN = 1 shl 0
	G_TEST_SUBPROCESS_INHERIT_STDOUT = 1 shl 1
	G_TEST_SUBPROCESS_INHERIT_STDERR = 1 shl 2
end enum

declare sub g_test_trap_subprocess(byval test_path as const zstring ptr, byval usec_timeout as guint64, byval test_flags as GTestSubprocessFlags)
declare function g_test_trap_has_passed() as gboolean
declare function g_test_trap_reached_timeout() as gboolean

#define g_test_trap_assert_passed() g_test_trap_assertions(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 0, 0)
#define g_test_trap_assert_failed() g_test_trap_assertions(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 1, 0)
#define g_test_trap_assert_stdout(soutpattern) g_test_trap_assertions(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 2, soutpattern)
#define g_test_trap_assert_stdout_unmatched(soutpattern) g_test_trap_assertions(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 3, soutpattern)
#define g_test_trap_assert_stderr(serrpattern) g_test_trap_assertions(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 4, serrpattern)
#define g_test_trap_assert_stderr_unmatched(serrpattern) g_test_trap_assertions(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 5, serrpattern)
#define g_test_rand_bit() (0 <> (g_test_rand_int() and (1 shl 15)))

declare function g_test_rand_int() as gint32
declare function g_test_rand_int_range(byval begin as gint32, byval end as gint32) as gint32
declare function g_test_rand_double() as double
declare function g_test_rand_double_range(byval range_start as double, byval range_end as double) as double
type GTestCase as GTestCase_
declare function g_test_create_case(byval test_name as const zstring ptr, byval data_size as gsize, byval test_data as gconstpointer, byval data_setup as GTestFixtureFunc, byval data_test as GTestFixtureFunc, byval data_teardown as GTestFixtureFunc) as GTestCase ptr
type GTestSuite as GTestSuite_
declare function g_test_create_suite(byval suite_name as const zstring ptr) as GTestSuite ptr
declare function g_test_get_root() as GTestSuite ptr
declare sub g_test_suite_add(byval suite as GTestSuite ptr, byval test_case as GTestCase ptr)
declare sub g_test_suite_add_suite(byval suite as GTestSuite ptr, byval nestedsuite as GTestSuite ptr)
declare function g_test_run_suite(byval suite as GTestSuite ptr) as long
declare sub g_test_trap_assertions(byval domain as const zstring ptr, byval file as const zstring ptr, byval line as long, byval func as const zstring ptr, byval assertion_flags as guint64, byval pattern as const zstring ptr)
declare sub g_assertion_message(byval domain as const zstring ptr, byval file as const zstring ptr, byval line as long, byval func as const zstring ptr, byval message as const zstring ptr)
declare sub g_assertion_message_expr(byval domain as const zstring ptr, byval file as const zstring ptr, byval line as long, byval func as const zstring ptr, byval expr as const zstring ptr)
declare sub g_assertion_message_cmpstr(byval domain as const zstring ptr, byval file as const zstring ptr, byval line as long, byval func as const zstring ptr, byval expr as const zstring ptr, byval arg1 as const zstring ptr, byval cmp as const zstring ptr, byval arg2 as const zstring ptr)
declare sub g_assertion_message_cmpnum(byval domain as const zstring ptr, byval file as const zstring ptr, byval line as long, byval func as const zstring ptr, byval expr as const zstring ptr, byval arg1 as clongdouble, byval cmp as const zstring ptr, byval arg2 as clongdouble, byval numtype as byte)
declare sub g_assertion_message_error(byval domain as const zstring ptr, byval file as const zstring ptr, byval line as long, byval func as const zstring ptr, byval expr as const zstring ptr, byval error as const GError ptr, byval error_domain as GQuark, byval error_code as long)
declare sub g_test_add_vtable(byval testpath as const zstring ptr, byval data_size as gsize, byval test_data as gconstpointer, byval data_setup as GTestFixtureFunc, byval data_test as GTestFixtureFunc, byval data_teardown as GTestFixtureFunc)

type GTestConfig
	test_initialized as gboolean
	test_quick as gboolean
	test_perf as gboolean
	test_verbose as gboolean
	test_quiet as gboolean
	test_undefined as gboolean
end type

#if (defined(__FB_WIN32__) and (not defined(GLIB_STATIC_COMPILATION))) or defined(__FB_CYGWIN__)
	extern import g_test_config_vars as const GTestConfig const ptr
#else
	extern g_test_config_vars as const GTestConfig const ptr
#endif

type GTestLogType as long
enum
	G_TEST_LOG_NONE
	G_TEST_LOG_ERROR
	G_TEST_LOG_START_BINARY
	G_TEST_LOG_LIST_CASE
	G_TEST_LOG_SKIP_CASE
	G_TEST_LOG_START_CASE
	G_TEST_LOG_STOP_CASE
	G_TEST_LOG_MIN_RESULT
	G_TEST_LOG_MAX_RESULT
	G_TEST_LOG_MESSAGE
	G_TEST_LOG_START_SUITE
	G_TEST_LOG_STOP_SUITE
end enum

type GTestLogMsg
	log_type as GTestLogType
	n_strings as guint
	strings as gchar ptr ptr
	n_nums as guint
	nums as clongdouble ptr
end type

type GTestLogBuffer
	data as GString ptr
	msgs as GSList ptr
end type

declare function g_test_log_type_name(byval log_type as GTestLogType) as const zstring ptr
declare function g_test_log_buffer_new() as GTestLogBuffer ptr
declare sub g_test_log_buffer_free(byval tbuffer as GTestLogBuffer ptr)
declare sub g_test_log_buffer_push(byval tbuffer as GTestLogBuffer ptr, byval n_bytes as guint, byval bytes as const guint8 ptr)
declare function g_test_log_buffer_pop(byval tbuffer as GTestLogBuffer ptr) as GTestLogMsg ptr
declare sub g_test_log_msg_free(byval tmsg as GTestLogMsg ptr)
type GTestLogFatalFunc as function(byval log_domain as const gchar ptr, byval log_level as GLogLevelFlags, byval message as const gchar ptr, byval user_data as gpointer) as gboolean
declare sub g_test_log_set_fatal_handler(byval log_func as GTestLogFatalFunc, byval user_data as gpointer)
declare sub g_test_expect_message(byval log_domain as const gchar ptr, byval log_level as GLogLevelFlags, byval pattern as const gchar ptr)
declare sub g_test_assert_expected_messages_internal(byval domain as const zstring ptr, byval file as const zstring ptr, byval line as long, byval func as const zstring ptr)

type GTestFileType as long
enum
	G_TEST_DIST
	G_TEST_BUILT
end enum

declare function g_test_build_filename(byval file_type as GTestFileType, byval first_path as const gchar ptr, ...) as gchar ptr
declare function g_test_get_dir(byval file_type as GTestFileType) as const gchar ptr
declare function g_test_get_filename(byval file_type as GTestFileType, byval first_path as const gchar ptr, ...) as const gchar ptr
#define g_test_assert_expected_messages() g_test_assert_expected_messages_internal(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC)
#define __G_THREADPOOL_H__
type GThreadPool as _GThreadPool

type _GThreadPool
	func as GFunc
	user_data as gpointer
	exclusive as gboolean
end type

declare function g_thread_pool_new(byval func as GFunc, byval user_data as gpointer, byval max_threads as gint, byval exclusive as gboolean, byval error as GError ptr ptr) as GThreadPool ptr
declare sub g_thread_pool_free(byval pool as GThreadPool ptr, byval immediate as gboolean, byval wait_ as gboolean)
declare function g_thread_pool_push(byval pool as GThreadPool ptr, byval data as gpointer, byval error as GError ptr ptr) as gboolean
declare function g_thread_pool_unprocessed(byval pool as GThreadPool ptr) as guint
declare sub g_thread_pool_set_sort_function(byval pool as GThreadPool ptr, byval func as GCompareDataFunc, byval user_data as gpointer)
declare function g_thread_pool_set_max_threads(byval pool as GThreadPool ptr, byval max_threads as gint, byval error as GError ptr ptr) as gboolean
declare function g_thread_pool_get_max_threads(byval pool as GThreadPool ptr) as gint
declare function g_thread_pool_get_num_threads(byval pool as GThreadPool ptr) as guint
declare sub g_thread_pool_set_max_unused_threads(byval max_threads as gint)
declare function g_thread_pool_get_max_unused_threads() as gint
declare function g_thread_pool_get_num_unused_threads() as guint
declare sub g_thread_pool_stop_unused_threads()
declare sub g_thread_pool_set_max_idle_time(byval interval as guint)
declare function g_thread_pool_get_max_idle_time() as guint
#define __G_TIMER_H__
type GTimer as _GTimer
const G_USEC_PER_SEC = 1000000
declare function g_timer_new() as GTimer ptr
declare sub g_timer_destroy(byval timer as GTimer ptr)
declare sub g_timer_start(byval timer as GTimer ptr)
declare sub g_timer_stop(byval timer as GTimer ptr)
declare sub g_timer_reset(byval timer as GTimer ptr)
declare sub g_timer_continue(byval timer as GTimer ptr)
declare function g_timer_elapsed(byval timer as GTimer ptr, byval microseconds as gulong ptr) as gdouble
declare sub g_usleep(byval microseconds as gulong)
declare sub g_time_val_add(byval time_ as GTimeVal ptr, byval microseconds as glong)
declare function g_time_val_from_iso8601(byval iso_date as const gchar ptr, byval time_ as GTimeVal ptr) as gboolean
declare function g_time_val_to_iso8601(byval time_ as GTimeVal ptr) as gchar ptr
#define __G_TRASH_STACK_H__
type GTrashStack as _GTrashStack

type _GTrashStack
	next as GTrashStack ptr
end type

declare sub g_trash_stack_push(byval stack_p as GTrashStack ptr ptr, byval data_p as gpointer)
declare function g_trash_stack_pop(byval stack_p as GTrashStack ptr ptr) as gpointer
declare function g_trash_stack_peek(byval stack_p as GTrashStack ptr ptr) as gpointer
declare function g_trash_stack_height(byval stack_p as GTrashStack ptr ptr) as guint
#define __G_TREE_H__
type GTree as _GTree
type GTraverseFunc as function(byval key as gpointer, byval value as gpointer, byval data as gpointer) as gboolean
declare function g_tree_new(byval key_compare_func as GCompareFunc) as GTree ptr
declare function g_tree_new_with_data(byval key_compare_func as GCompareDataFunc, byval key_compare_data as gpointer) as GTree ptr
declare function g_tree_new_full(byval key_compare_func as GCompareDataFunc, byval key_compare_data as gpointer, byval key_destroy_func as GDestroyNotify, byval value_destroy_func as GDestroyNotify) as GTree ptr
declare function g_tree_ref(byval tree as GTree ptr) as GTree ptr
declare sub g_tree_unref(byval tree as GTree ptr)
declare sub g_tree_destroy(byval tree as GTree ptr)
declare sub g_tree_insert(byval tree as GTree ptr, byval key as gpointer, byval value as gpointer)
declare sub g_tree_replace(byval tree as GTree ptr, byval key as gpointer, byval value as gpointer)
declare function g_tree_remove(byval tree as GTree ptr, byval key as gconstpointer) as gboolean
declare function g_tree_steal(byval tree as GTree ptr, byval key as gconstpointer) as gboolean
declare function g_tree_lookup(byval tree as GTree ptr, byval key as gconstpointer) as gpointer
declare function g_tree_lookup_extended(byval tree as GTree ptr, byval lookup_key as gconstpointer, byval orig_key as gpointer ptr, byval value as gpointer ptr) as gboolean
declare sub g_tree_foreach(byval tree as GTree ptr, byval func as GTraverseFunc, byval user_data as gpointer)
declare sub g_tree_traverse(byval tree as GTree ptr, byval traverse_func as GTraverseFunc, byval traverse_type as GTraverseType, byval user_data as gpointer)
declare function g_tree_search(byval tree as GTree ptr, byval search_func as GCompareFunc, byval user_data as gconstpointer) as gpointer
declare function g_tree_height(byval tree as GTree ptr) as gint
declare function g_tree_nnodes(byval tree as GTree ptr) as gint

#define __G_URI_FUNCS_H__
#define G_URI_RESERVED_CHARS_GENERIC_DELIMITERS ":/?#[]@"
#define G_URI_RESERVED_CHARS_SUBCOMPONENT_DELIMITERS "!$&'()*+,;="
#define G_URI_RESERVED_CHARS_ALLOWED_IN_PATH_ELEMENT G_URI_RESERVED_CHARS_SUBCOMPONENT_DELIMITERS ":@"
#define G_URI_RESERVED_CHARS_ALLOWED_IN_PATH G_URI_RESERVED_CHARS_ALLOWED_IN_PATH_ELEMENT "/"
#define G_URI_RESERVED_CHARS_ALLOWED_IN_USERINFO G_URI_RESERVED_CHARS_SUBCOMPONENT_DELIMITERS ":"

declare function g_uri_unescape_string(byval escaped_string as const zstring ptr, byval illegal_characters as const zstring ptr) as zstring ptr
declare function g_uri_unescape_segment(byval escaped_string as const zstring ptr, byval escaped_string_end as const zstring ptr, byval illegal_characters as const zstring ptr) as zstring ptr
declare function g_uri_parse_scheme(byval uri as const zstring ptr) as zstring ptr
declare function g_uri_escape_string(byval unescaped as const zstring ptr, byval reserved_chars_allowed as const zstring ptr, byval allow_utf8 as gboolean) as zstring ptr
#define __G_VARIANT_TYPE_H__
type GVariantType as _GVariantType

#define G_VARIANT_TYPE_BOOLEAN cptr(const GVariantType ptr, @"b")
#define G_VARIANT_TYPE_BYTE cptr(const GVariantType ptr, @"y")
#define G_VARIANT_TYPE_INT16 cptr(const GVariantType ptr, @"n")
#define G_VARIANT_TYPE_UINT16 cptr(const GVariantType ptr, @"q")
#define G_VARIANT_TYPE_INT32 cptr(const GVariantType ptr, @"i")
#define G_VARIANT_TYPE_UINT32 cptr(const GVariantType ptr, @"u")
#define G_VARIANT_TYPE_INT64 cptr(const GVariantType ptr, @"x")
#define G_VARIANT_TYPE_UINT64 cptr(const GVariantType ptr, @"t")
#define G_VARIANT_TYPE_DOUBLE cptr(const GVariantType ptr, @"d")
#define G_VARIANT_TYPE_STRING cptr(const GVariantType ptr, @"s")
#define G_VARIANT_TYPE_OBJECT_PATH cptr(const GVariantType ptr, @"o")
#define G_VARIANT_TYPE_SIGNATURE cptr(const GVariantType ptr, @"g")
#define G_VARIANT_TYPE_VARIANT cptr(const GVariantType ptr, @"v")
#define G_VARIANT_TYPE_HANDLE cptr(const GVariantType ptr, @"h")
#define G_VARIANT_TYPE_UNIT cptr(const GVariantType ptr, @"()")
#define G_VARIANT_TYPE_ANY cptr(const GVariantType ptr, @"*")
#define G_VARIANT_TYPE_BASIC cptr(const GVariantType ptr, @"?")
#define G_VARIANT_TYPE_MAYBE cptr(const GVariantType ptr, @"m*")
#define G_VARIANT_TYPE_ARRAY cptr(const GVariantType ptr, @"a*")
#define G_VARIANT_TYPE_TUPLE cptr(const GVariantType ptr, @"r")
#define G_VARIANT_TYPE_DICT_ENTRY cptr(const GVariantType ptr, @"{?*}")
#define G_VARIANT_TYPE_DICTIONARY cptr(const GVariantType ptr, @"a{?*}")
#define G_VARIANT_TYPE_STRING_ARRAY cptr(const GVariantType ptr, @"as")
#define G_VARIANT_TYPE_OBJECT_PATH_ARRAY cptr(const GVariantType ptr, @"ao")
#define G_VARIANT_TYPE_BYTESTRING cptr(const GVariantType ptr, @"ay")
#define G_VARIANT_TYPE_BYTESTRING_ARRAY cptr(const GVariantType ptr, @"aay")
#define G_VARIANT_TYPE_VARDICT cptr(const GVariantType ptr, @"a{sv}")
#define G_VARIANT_TYPE(type_string) g_variant_type_checked_((type_string))

declare function g_variant_type_string_is_valid(byval type_string as const gchar ptr) as gboolean
declare function g_variant_type_string_scan(byval string as const gchar ptr, byval limit as const gchar ptr, byval endptr as const gchar ptr ptr) as gboolean
declare sub g_variant_type_free(byval type as GVariantType ptr)
declare function g_variant_type_copy(byval type as const GVariantType ptr) as GVariantType ptr
declare function g_variant_type_new(byval type_string as const gchar ptr) as GVariantType ptr
declare function g_variant_type_get_string_length(byval type as const GVariantType ptr) as gsize
declare function g_variant_type_peek_string(byval type as const GVariantType ptr) as const gchar ptr
declare function g_variant_type_dup_string(byval type as const GVariantType ptr) as gchar ptr
declare function g_variant_type_is_definite(byval type as const GVariantType ptr) as gboolean
declare function g_variant_type_is_container(byval type as const GVariantType ptr) as gboolean
declare function g_variant_type_is_basic(byval type as const GVariantType ptr) as gboolean
declare function g_variant_type_is_maybe(byval type as const GVariantType ptr) as gboolean
declare function g_variant_type_is_array(byval type as const GVariantType ptr) as gboolean
declare function g_variant_type_is_tuple(byval type as const GVariantType ptr) as gboolean
declare function g_variant_type_is_dict_entry(byval type as const GVariantType ptr) as gboolean
declare function g_variant_type_is_variant(byval type as const GVariantType ptr) as gboolean
declare function g_variant_type_hash(byval type as gconstpointer) as guint
declare function g_variant_type_equal(byval type1 as gconstpointer, byval type2 as gconstpointer) as gboolean
declare function g_variant_type_is_subtype_of(byval type as const GVariantType ptr, byval supertype as const GVariantType ptr) as gboolean
declare function g_variant_type_element(byval type as const GVariantType ptr) as const GVariantType ptr
declare function g_variant_type_first(byval type as const GVariantType ptr) as const GVariantType ptr
declare function g_variant_type_next(byval type as const GVariantType ptr) as const GVariantType ptr
declare function g_variant_type_n_items(byval type as const GVariantType ptr) as gsize
declare function g_variant_type_key(byval type as const GVariantType ptr) as const GVariantType ptr
declare function g_variant_type_value(byval type as const GVariantType ptr) as const GVariantType ptr
declare function g_variant_type_new_array(byval element as const GVariantType ptr) as GVariantType ptr
declare function g_variant_type_new_maybe(byval element as const GVariantType ptr) as GVariantType ptr
declare function g_variant_type_new_tuple(byval items as const GVariantType const ptr ptr, byval length as gint) as GVariantType ptr
declare function g_variant_type_new_dict_entry(byval key as const GVariantType ptr, byval value as const GVariantType ptr) as GVariantType ptr
declare function g_variant_type_checked_(byval as const gchar ptr) as const GVariantType ptr
#define __G_VARIANT_H__
type GVariant as _GVariant

type GVariantClass as long
enum
	G_VARIANT_CLASS_BOOLEAN = asc("b")
	G_VARIANT_CLASS_BYTE = asc("y")
	G_VARIANT_CLASS_INT16 = asc("n")
	G_VARIANT_CLASS_UINT16 = asc("q")
	G_VARIANT_CLASS_INT32 = asc("i")
	G_VARIANT_CLASS_UINT32 = asc("u")
	G_VARIANT_CLASS_INT64 = asc("x")
	G_VARIANT_CLASS_UINT64 = asc("t")
	G_VARIANT_CLASS_HANDLE = asc("h")
	G_VARIANT_CLASS_DOUBLE = asc("d")
	G_VARIANT_CLASS_STRING = asc("s")
	G_VARIANT_CLASS_OBJECT_PATH = asc("o")
	G_VARIANT_CLASS_SIGNATURE = asc("g")
	G_VARIANT_CLASS_VARIANT = asc("v")
	G_VARIANT_CLASS_MAYBE = asc("m")
	G_VARIANT_CLASS_ARRAY = asc("a")
	G_VARIANT_CLASS_TUPLE = asc("(")
	G_VARIANT_CLASS_DICT_ENTRY = asc("{")
end enum

declare sub g_variant_unref(byval value as GVariant ptr)
declare function g_variant_ref(byval value as GVariant ptr) as GVariant ptr
declare function g_variant_ref_sink(byval value as GVariant ptr) as GVariant ptr
declare function g_variant_is_floating(byval value as GVariant ptr) as gboolean
declare function g_variant_take_ref(byval value as GVariant ptr) as GVariant ptr
declare function g_variant_get_type(byval value as GVariant ptr) as const GVariantType ptr
declare function g_variant_get_type_string(byval value as GVariant ptr) as const gchar ptr
declare function g_variant_is_of_type(byval value as GVariant ptr, byval type as const GVariantType ptr) as gboolean
declare function g_variant_is_container(byval value as GVariant ptr) as gboolean
declare function g_variant_classify(byval value as GVariant ptr) as GVariantClass
declare function g_variant_new_boolean(byval value as gboolean) as GVariant ptr
declare function g_variant_new_byte(byval value as guchar) as GVariant ptr
declare function g_variant_new_int16(byval value as gint16) as GVariant ptr
declare function g_variant_new_uint16(byval value as guint16) as GVariant ptr
declare function g_variant_new_int32(byval value as gint32) as GVariant ptr
declare function g_variant_new_uint32(byval value as guint32) as GVariant ptr
declare function g_variant_new_int64(byval value as gint64) as GVariant ptr
declare function g_variant_new_uint64(byval value as guint64) as GVariant ptr
declare function g_variant_new_handle(byval value as gint32) as GVariant ptr
declare function g_variant_new_double(byval value as gdouble) as GVariant ptr
declare function g_variant_new_string(byval string as const gchar ptr) as GVariant ptr
declare function g_variant_new_take_string(byval string as gchar ptr) as GVariant ptr
declare function g_variant_new_printf(byval format_string as const gchar ptr, ...) as GVariant ptr
declare function g_variant_new_object_path(byval object_path as const gchar ptr) as GVariant ptr
declare function g_variant_is_object_path(byval string as const gchar ptr) as gboolean
declare function g_variant_new_signature(byval signature as const gchar ptr) as GVariant ptr
declare function g_variant_is_signature(byval string as const gchar ptr) as gboolean
declare function g_variant_new_variant(byval value as GVariant ptr) as GVariant ptr
declare function g_variant_new_strv(byval strv as const gchar const ptr ptr, byval length as gssize) as GVariant ptr
declare function g_variant_new_objv(byval strv as const gchar const ptr ptr, byval length as gssize) as GVariant ptr
declare function g_variant_new_bytestring(byval string as const gchar ptr) as GVariant ptr
declare function g_variant_new_bytestring_array(byval strv as const gchar const ptr ptr, byval length as gssize) as GVariant ptr
declare function g_variant_new_fixed_array(byval element_type as const GVariantType ptr, byval elements as gconstpointer, byval n_elements as gsize, byval element_size as gsize) as GVariant ptr
declare function g_variant_get_boolean(byval value as GVariant ptr) as gboolean
declare function g_variant_get_byte(byval value as GVariant ptr) as guchar
declare function g_variant_get_int16(byval value as GVariant ptr) as gint16
declare function g_variant_get_uint16(byval value as GVariant ptr) as guint16
declare function g_variant_get_int32(byval value as GVariant ptr) as gint32
declare function g_variant_get_uint32(byval value as GVariant ptr) as guint32
declare function g_variant_get_int64(byval value as GVariant ptr) as gint64
declare function g_variant_get_uint64(byval value as GVariant ptr) as guint64
declare function g_variant_get_handle(byval value as GVariant ptr) as gint32
declare function g_variant_get_double(byval value as GVariant ptr) as gdouble
declare function g_variant_get_variant(byval value as GVariant ptr) as GVariant ptr
declare function g_variant_get_string(byval value as GVariant ptr, byval length as gsize ptr) as const gchar ptr
declare function g_variant_dup_string(byval value as GVariant ptr, byval length as gsize ptr) as gchar ptr
declare function g_variant_get_strv(byval value as GVariant ptr, byval length as gsize ptr) as const gchar ptr ptr
declare function g_variant_dup_strv(byval value as GVariant ptr, byval length as gsize ptr) as gchar ptr ptr
declare function g_variant_get_objv(byval value as GVariant ptr, byval length as gsize ptr) as const gchar ptr ptr
declare function g_variant_dup_objv(byval value as GVariant ptr, byval length as gsize ptr) as gchar ptr ptr
declare function g_variant_get_bytestring(byval value as GVariant ptr) as const gchar ptr
declare function g_variant_dup_bytestring(byval value as GVariant ptr, byval length as gsize ptr) as gchar ptr
declare function g_variant_get_bytestring_array(byval value as GVariant ptr, byval length as gsize ptr) as const gchar ptr ptr
declare function g_variant_dup_bytestring_array(byval value as GVariant ptr, byval length as gsize ptr) as gchar ptr ptr
declare function g_variant_new_maybe(byval child_type as const GVariantType ptr, byval child as GVariant ptr) as GVariant ptr
declare function g_variant_new_array(byval child_type as const GVariantType ptr, byval children as GVariant const ptr ptr, byval n_children as gsize) as GVariant ptr
declare function g_variant_new_tuple(byval children as GVariant const ptr ptr, byval n_children as gsize) as GVariant ptr
declare function g_variant_new_dict_entry(byval key as GVariant ptr, byval value as GVariant ptr) as GVariant ptr
declare function g_variant_get_maybe(byval value as GVariant ptr) as GVariant ptr
declare function g_variant_n_children(byval value as GVariant ptr) as gsize
declare sub g_variant_get_child(byval value as GVariant ptr, byval index_ as gsize, byval format_string as const gchar ptr, ...)
declare function g_variant_get_child_value(byval value as GVariant ptr, byval index_ as gsize) as GVariant ptr
declare function g_variant_lookup(byval dictionary as GVariant ptr, byval key as const gchar ptr, byval format_string as const gchar ptr, ...) as gboolean
declare function g_variant_lookup_value(byval dictionary as GVariant ptr, byval key as const gchar ptr, byval expected_type as const GVariantType ptr) as GVariant ptr
declare function g_variant_get_fixed_array(byval value as GVariant ptr, byval n_elements as gsize ptr, byval element_size as gsize) as gconstpointer
declare function g_variant_get_size(byval value as GVariant ptr) as gsize
declare function g_variant_get_data(byval value as GVariant ptr) as gconstpointer
declare function g_variant_get_data_as_bytes(byval value as GVariant ptr) as GBytes ptr
declare sub g_variant_store(byval value as GVariant ptr, byval data as gpointer)
declare function g_variant_print(byval value as GVariant ptr, byval type_annotate as gboolean) as gchar ptr
declare function g_variant_print_string(byval value as GVariant ptr, byval string as GString ptr, byval type_annotate as gboolean) as GString ptr
declare function g_variant_hash(byval value as gconstpointer) as guint
declare function g_variant_equal(byval one as gconstpointer, byval two as gconstpointer) as gboolean
declare function g_variant_get_normal_form(byval value as GVariant ptr) as GVariant ptr
declare function g_variant_is_normal_form(byval value as GVariant ptr) as gboolean
declare function g_variant_byteswap(byval value as GVariant ptr) as GVariant ptr
declare function g_variant_new_from_bytes(byval type as const GVariantType ptr, byval bytes as GBytes ptr, byval trusted as gboolean) as GVariant ptr
declare function g_variant_new_from_data(byval type as const GVariantType ptr, byval data as gconstpointer, byval size as gsize, byval trusted as gboolean, byval notify as GDestroyNotify, byval user_data as gpointer) as GVariant ptr
type GVariantIter as _GVariantIter

type _GVariantIter
	x(0 to 15) as gsize
end type

declare function g_variant_iter_new(byval value as GVariant ptr) as GVariantIter ptr
declare function g_variant_iter_init(byval iter as GVariantIter ptr, byval value as GVariant ptr) as gsize
declare function g_variant_iter_copy(byval iter as GVariantIter ptr) as GVariantIter ptr
declare function g_variant_iter_n_children(byval iter as GVariantIter ptr) as gsize
declare sub g_variant_iter_free(byval iter as GVariantIter ptr)
declare function g_variant_iter_next_value(byval iter as GVariantIter ptr) as GVariant ptr
declare function g_variant_iter_next(byval iter as GVariantIter ptr, byval format_string as const gchar ptr, ...) as gboolean
declare function g_variant_iter_loop(byval iter as GVariantIter ptr, byval format_string as const gchar ptr, ...) as gboolean
type GVariantBuilder as _GVariantBuilder

type _GVariantBuilder
	x(0 to 15) as gsize
end type

type GVariantParseError as long
enum
	G_VARIANT_PARSE_ERROR_FAILED
	G_VARIANT_PARSE_ERROR_BASIC_TYPE_EXPECTED
	G_VARIANT_PARSE_ERROR_CANNOT_INFER_TYPE
	G_VARIANT_PARSE_ERROR_DEFINITE_TYPE_EXPECTED
	G_VARIANT_PARSE_ERROR_INPUT_NOT_AT_END
	G_VARIANT_PARSE_ERROR_INVALID_CHARACTER
	G_VARIANT_PARSE_ERROR_INVALID_FORMAT_STRING
	G_VARIANT_PARSE_ERROR_INVALID_OBJECT_PATH
	G_VARIANT_PARSE_ERROR_INVALID_SIGNATURE
	G_VARIANT_PARSE_ERROR_INVALID_TYPE_STRING
	G_VARIANT_PARSE_ERROR_NO_COMMON_TYPE
	G_VARIANT_PARSE_ERROR_NUMBER_OUT_OF_RANGE
	G_VARIANT_PARSE_ERROR_NUMBER_TOO_BIG
	G_VARIANT_PARSE_ERROR_TYPE_ERROR
	G_VARIANT_PARSE_ERROR_UNEXPECTED_TOKEN
	G_VARIANT_PARSE_ERROR_UNKNOWN_KEYWORD
	G_VARIANT_PARSE_ERROR_UNTERMINATED_STRING_CONSTANT
	G_VARIANT_PARSE_ERROR_VALUE_EXPECTED
end enum

#define G_VARIANT_PARSE_ERROR g_variant_parse_error_quark()
declare function g_variant_parser_get_error_quark() as GQuark
declare function g_variant_parse_error_quark() as GQuark
declare function g_variant_builder_new(byval type as const GVariantType ptr) as GVariantBuilder ptr
declare sub g_variant_builder_unref(byval builder as GVariantBuilder ptr)
declare function g_variant_builder_ref(byval builder as GVariantBuilder ptr) as GVariantBuilder ptr
declare sub g_variant_builder_init(byval builder as GVariantBuilder ptr, byval type as const GVariantType ptr)
declare function g_variant_builder_end(byval builder as GVariantBuilder ptr) as GVariant ptr
declare sub g_variant_builder_clear(byval builder as GVariantBuilder ptr)
declare sub g_variant_builder_open(byval builder as GVariantBuilder ptr, byval type as const GVariantType ptr)
declare sub g_variant_builder_close(byval builder as GVariantBuilder ptr)
declare sub g_variant_builder_add_value(byval builder as GVariantBuilder ptr, byval value as GVariant ptr)
declare sub g_variant_builder_add(byval builder as GVariantBuilder ptr, byval format_string as const gchar ptr, ...)
declare sub g_variant_builder_add_parsed(byval builder as GVariantBuilder ptr, byval format as const gchar ptr, ...)
declare function g_variant_new(byval format_string as const gchar ptr, ...) as GVariant ptr
declare sub g_variant_get(byval value as GVariant ptr, byval format_string as const gchar ptr, ...)
declare function g_variant_new_va(byval format_string as const gchar ptr, byval endptr as const gchar ptr ptr, byval app as va_list ptr) as GVariant ptr
declare sub g_variant_get_va(byval value as GVariant ptr, byval format_string as const gchar ptr, byval endptr as const gchar ptr ptr, byval app as va_list ptr)
declare function g_variant_check_format_string(byval value as GVariant ptr, byval format_string as const gchar ptr, byval copy_only as gboolean) as gboolean
declare function g_variant_parse(byval type as const GVariantType ptr, byval text as const gchar ptr, byval limit as const gchar ptr, byval endptr as const gchar ptr ptr, byval error as GError ptr ptr) as GVariant ptr
declare function g_variant_new_parsed(byval format as const gchar ptr, ...) as GVariant ptr
declare function g_variant_new_parsed_va(byval format as const gchar ptr, byval app as va_list ptr) as GVariant ptr
declare function g_variant_parse_error_print_context(byval error as GError ptr, byval source_str as const gchar ptr) as gchar ptr
declare function g_variant_compare(byval one as gconstpointer, byval two as gconstpointer) as gint
type GVariantDict as _GVariantDict

type _GVariantDict
	x(0 to 15) as gsize
end type

declare function g_variant_dict_new(byval from_asv as GVariant ptr) as GVariantDict ptr
declare sub g_variant_dict_init(byval dict as GVariantDict ptr, byval from_asv as GVariant ptr)
declare function g_variant_dict_lookup(byval dict as GVariantDict ptr, byval key as const gchar ptr, byval format_string as const gchar ptr, ...) as gboolean
declare function g_variant_dict_lookup_value(byval dict as GVariantDict ptr, byval key as const gchar ptr, byval expected_type as const GVariantType ptr) as GVariant ptr
declare function g_variant_dict_contains(byval dict as GVariantDict ptr, byval key as const gchar ptr) as gboolean
declare sub g_variant_dict_insert(byval dict as GVariantDict ptr, byval key as const gchar ptr, byval format_string as const gchar ptr, ...)
declare sub g_variant_dict_insert_value(byval dict as GVariantDict ptr, byval key as const gchar ptr, byval value as GVariant ptr)
declare function g_variant_dict_remove(byval dict as GVariantDict ptr, byval key as const gchar ptr) as gboolean
declare sub g_variant_dict_clear(byval dict as GVariantDict ptr)
declare function g_variant_dict_end(byval dict as GVariantDict ptr) as GVariant ptr
declare function g_variant_dict_ref(byval dict as GVariantDict ptr) as GVariantDict ptr
declare sub g_variant_dict_unref(byval dict as GVariantDict ptr)
#define __G_VERSION_H__

#if (defined(__FB_WIN32__) and (not defined(GLIB_STATIC_COMPILATION))) or defined(__FB_CYGWIN__)
	extern import glib_major_version_ alias "glib_major_version" as const guint
	extern import glib_minor_version_ alias "glib_minor_version" as const guint
	extern import glib_micro_version_ alias "glib_micro_version" as const guint
	extern import glib_interface_age as const guint
	extern import glib_binary_age as const guint
#else
	extern glib_major_version_ alias "glib_major_version" as const guint
	extern glib_minor_version_ alias "glib_minor_version" as const guint
	extern glib_micro_version_ alias "glib_micro_version" as const guint
	extern glib_interface_age as const guint
	extern glib_binary_age as const guint
#endif

declare function glib_check_version_ alias "glib_check_version"(byval required_major as guint, byval required_minor as guint, byval required_micro as guint) as const gchar ptr
#define GLIB_CHECK_VERSION(major, minor, micro) (((GLIB_MAJOR_VERSION > (major)) orelse ((GLIB_MAJOR_VERSION = (major)) andalso (GLIB_MINOR_VERSION > (minor)))) orelse (((GLIB_MAJOR_VERSION = (major)) andalso (GLIB_MINOR_VERSION = (minor))) andalso (GLIB_MICRO_VERSION >= (micro))))

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	#define __G_WIN32_H__
	const MAXPATHLEN = 1024
#endif

#ifdef __FB_WIN32__
	declare function g_win32_ftruncate(byval f as gint, byval size as guint) as gint
#endif

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	declare function g_win32_getlocale() as gchar ptr
	declare function g_win32_error_message(byval error as gint) as gchar ptr
#endif

#if (defined(__FB_CYGWIN__) and defined(__FB_64BIT__)) or ((not defined(__FB_64BIT__)) and (defined(__FB_CYGWIN__) or defined(__FB_WIN32__)))
	declare function g_win32_get_package_installation_directory(byval package as const gchar ptr, byval dll_name as const gchar ptr) as gchar ptr
	declare function g_win32_get_package_installation_subdirectory(byval package as const gchar ptr, byval dll_name as const gchar ptr, byval subdir as const gchar ptr) as gchar ptr
#endif

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	declare function g_win32_get_package_installation_directory_of_module(byval hmodule as gpointer) as gchar ptr
	declare function g_win32_get_windows_version() as guint
	declare function g_win32_locale_filename_from_utf8(byval utf8filename as const gchar ptr) as gchar ptr
	declare function g_win32_get_command_line() as gchar ptr ptr
	#define G_WIN32_IS_NT_BASED() CTRUE
	#define G_WIN32_HAVE_WIDECHAR_API() CTRUE
#endif

#ifdef __FB_WIN32__
	declare function g_win32_get_package_installation_directory_utf8(byval package as const gchar ptr, byval dll_name as const gchar ptr) as gchar ptr

	#ifdef __FB_64BIT__
		declare function g_win32_get_package_installation_directory alias "g_win32_get_package_installation_directory_utf8"(byval package as const gchar ptr, byval dll_name as const gchar ptr) as gchar ptr
	#endif

	declare function g_win32_get_package_installation_subdirectory_utf8(byval package as const gchar ptr, byval dll_name as const gchar ptr, byval subdir as const gchar ptr) as gchar ptr

	#ifdef __FB_64BIT__
		declare function g_win32_get_package_installation_subdirectory alias "g_win32_get_package_installation_subdirectory_utf8"(byval package as const gchar ptr, byval dll_name as const gchar ptr, byval subdir as const gchar ptr) as gchar ptr
	#endif
#endif

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	type GWin32OSType as long
	enum
		G_WIN32_OS_ANY
		G_WIN32_OS_WORKSTATION
		G_WIN32_OS_SERVER
	end enum

	declare function g_win32_check_windows_version(byval major as const gint, byval minor as const gint, byval spver as const gint, byval os_type as const GWin32OSType) as gboolean
#endif

#define __G_ALLOCATOR_H__
type GAllocator as _GAllocator
type GMemChunk as _GMemChunk
const G_ALLOC_ONLY = 1
const G_ALLOC_AND_FREE = 2
const G_ALLOCATOR_LIST = 1
const G_ALLOCATOR_SLIST = 2
const G_ALLOCATOR_NODE = 3
#define g_chunk_new(type, chunk) cptr(type ptr, g_mem_chunk_alloc(chunk))
#define g_chunk_new0(type, chunk) cptr(type ptr, g_mem_chunk_alloc0(chunk))
#define g_chunk_free(mem, mem_chunk) g_mem_chunk_free(mem_chunk, mem)
#define g_mem_chunk_create(type, x, y) g_mem_chunk_new(NULL, sizeof(type), 0, 0)

declare function g_mem_chunk_new(byval name as const gchar ptr, byval atom_size as gint, byval area_size as gsize, byval type as gint) as GMemChunk ptr
declare sub g_mem_chunk_destroy(byval mem_chunk as GMemChunk ptr)
declare function g_mem_chunk_alloc(byval mem_chunk as GMemChunk ptr) as gpointer
declare function g_mem_chunk_alloc0(byval mem_chunk as GMemChunk ptr) as gpointer
declare sub g_mem_chunk_free(byval mem_chunk as GMemChunk ptr, byval mem as gpointer)
declare sub g_mem_chunk_clean(byval mem_chunk as GMemChunk ptr)
declare sub g_mem_chunk_reset(byval mem_chunk as GMemChunk ptr)
declare sub g_mem_chunk_print(byval mem_chunk as GMemChunk ptr)
declare sub g_mem_chunk_info()
declare sub g_blow_chunks()
declare function g_allocator_new(byval name as const gchar ptr, byval n_preallocs as guint) as GAllocator ptr
declare sub g_allocator_free(byval allocator as GAllocator ptr)
declare sub g_list_push_allocator(byval allocator as GAllocator ptr)
declare sub g_list_pop_allocator()
declare sub g_slist_push_allocator(byval allocator as GAllocator ptr)
declare sub g_slist_pop_allocator()
declare sub g_node_push_allocator(byval allocator as GAllocator ptr)
declare sub g_node_pop_allocator()
#define __G_CACHE_H__

type GCache as _GCache
type GCacheNewFunc as function(byval key as gpointer) as gpointer
type GCacheDupFunc as function(byval value as gpointer) as gpointer
type GCacheDestroyFunc as sub(byval value as gpointer)

declare function g_cache_new(byval value_new_func as GCacheNewFunc, byval value_destroy_func as GCacheDestroyFunc, byval key_dup_func as GCacheDupFunc, byval key_destroy_func as GCacheDestroyFunc, byval hash_key_func as GHashFunc, byval hash_value_func as GHashFunc, byval key_equal_func as GEqualFunc) as GCache ptr
declare sub g_cache_destroy(byval cache as GCache ptr)
declare function g_cache_insert(byval cache as GCache ptr, byval key as gpointer) as gpointer
declare sub g_cache_remove(byval cache as GCache ptr, byval value as gconstpointer)
declare sub g_cache_key_foreach(byval cache as GCache ptr, byval func as GHFunc, byval user_data as gpointer)
declare sub g_cache_value_foreach(byval cache as GCache ptr, byval func as GHFunc, byval user_data as gpointer)
#define __G_COMPLETION_H__

type GCompletion as _GCompletion
type GCompletionFunc as function(byval as gpointer) as gchar ptr
type GCompletionStrncmpFunc as function(byval s1 as const gchar ptr, byval s2 as const gchar ptr, byval n as gsize) as gint

type _GCompletion
	items as GList ptr
	func as GCompletionFunc
	prefix as gchar ptr
	cache as GList ptr
	strncmp_func as GCompletionStrncmpFunc
end type

declare function g_completion_new(byval func as GCompletionFunc) as GCompletion ptr
declare sub g_completion_add_items(byval cmp as GCompletion ptr, byval items as GList ptr)
declare sub g_completion_remove_items(byval cmp as GCompletion ptr, byval items as GList ptr)
declare sub g_completion_clear_items(byval cmp as GCompletion ptr)
declare function g_completion_complete(byval cmp as GCompletion ptr, byval prefix as const gchar ptr, byval new_prefix as gchar ptr ptr) as GList ptr
declare function g_completion_complete_utf8(byval cmp as GCompletion ptr, byval prefix as const gchar ptr, byval new_prefix as gchar ptr ptr) as GList ptr
declare sub g_completion_set_compare(byval cmp as GCompletion ptr, byval strncmp_func as GCompletionStrncmpFunc)
declare sub g_completion_free(byval cmp as GCompletion ptr)

#define __G_DEPRECATED_MAIN_H__
#define g_main_new(is_running) g_main_loop_new(NULL, is_running)
#define g_main_run(loop) g_main_loop_run(loop)
#define g_main_quit(loop) g_main_loop_quit(loop)
#define g_main_destroy(loop) g_main_loop_unref(loop)
#define g_main_is_running(loop) g_main_loop_is_running(loop)
#define g_main_iteration(may_block) g_main_context_iteration(NULL, may_block)
#define g_main_pending() g_main_context_pending(NULL)
#define g_main_set_poll_func(func) g_main_context_set_poll_func(NULL, func)
#define __G_REL_H__
type GRelation as _GRelation
type GTuples as _GTuples

type _GTuples
	len as guint
end type

declare function g_relation_new(byval fields as gint) as GRelation ptr
declare sub g_relation_destroy(byval relation as GRelation ptr)
declare sub g_relation_index(byval relation as GRelation ptr, byval field as gint, byval hash_func as GHashFunc, byval key_equal_func as GEqualFunc)
declare sub g_relation_insert(byval relation as GRelation ptr, ...)
declare function g_relation_delete(byval relation as GRelation ptr, byval key as gconstpointer, byval field as gint) as gint
declare function g_relation_select(byval relation as GRelation ptr, byval key as gconstpointer, byval field as gint) as GTuples ptr
declare function g_relation_count(byval relation as GRelation ptr, byval key as gconstpointer, byval field as gint) as gint
declare function g_relation_exists(byval relation as GRelation ptr, ...) as gboolean
declare sub g_relation_print(byval relation as GRelation ptr)
declare sub g_tuples_destroy(byval tuples as GTuples ptr)
declare function g_tuples_index(byval tuples as GTuples ptr, byval index_ as gint, byval field as gint) as gpointer
#define __G_DEPRECATED_THREAD_H__

type GThreadPriority as long
enum
	G_THREAD_PRIORITY_LOW
	G_THREAD_PRIORITY_NORMAL
	G_THREAD_PRIORITY_HIGH
	G_THREAD_PRIORITY_URGENT
end enum

type _GThread
	func as GThreadFunc
	data as gpointer
	joinable as gboolean
	priority as GThreadPriority
end type

type GThreadFunctions as _GThreadFunctions

type _GThreadFunctions
	mutex_new as function() as GMutex ptr
	mutex_lock as sub(byval mutex as GMutex ptr)
	mutex_trylock as function(byval mutex as GMutex ptr) as gboolean
	mutex_unlock as sub(byval mutex as GMutex ptr)
	mutex_free as sub(byval mutex as GMutex ptr)
	cond_new as function() as GCond ptr
	cond_signal as sub(byval cond as GCond ptr)
	cond_broadcast as sub(byval cond as GCond ptr)
	cond_wait as sub(byval cond as GCond ptr, byval mutex as GMutex ptr)
	cond_timed_wait as function(byval cond as GCond ptr, byval mutex as GMutex ptr, byval end_time as GTimeVal ptr) as gboolean
	cond_free as sub(byval cond as GCond ptr)
	private_new as function(byval destructor as GDestroyNotify) as GPrivate ptr
	private_get as function(byval private_key as GPrivate ptr) as gpointer
	private_set as sub(byval private_key as GPrivate ptr, byval data as gpointer)
	thread_create as sub(byval func as GThreadFunc, byval data as gpointer, byval stack_size as gulong, byval joinable as gboolean, byval bound as gboolean, byval priority as GThreadPriority, byval thread as gpointer, byval error as GError ptr ptr)
	thread_yield as sub()
	thread_join as sub(byval thread as gpointer)
	thread_exit as sub()
	thread_set_priority as sub(byval thread as gpointer, byval priority as GThreadPriority)
	thread_self as sub(byval thread as gpointer)
	thread_equal as function(byval thread1 as gpointer, byval thread2 as gpointer) as gboolean
end type

#if (defined(__FB_WIN32__) and (not defined(GLIB_STATIC_COMPILATION))) or defined(__FB_CYGWIN__)
	extern import g_thread_functions_for_glib_use as GThreadFunctions
	extern import g_thread_use_default_impl as gboolean
	extern import g_thread_gettime as function() as guint64
#else
	extern g_thread_functions_for_glib_use as GThreadFunctions
	extern g_thread_use_default_impl as gboolean
	extern g_thread_gettime as function() as guint64
#endif

declare function g_thread_create(byval func as GThreadFunc, byval data as gpointer, byval joinable as gboolean, byval error as GError ptr ptr) as GThread ptr
declare function g_thread_create_full(byval func as GThreadFunc, byval data as gpointer, byval stack_size as gulong, byval joinable as gboolean, byval bound as gboolean, byval priority as GThreadPriority, byval error as GError ptr ptr) as GThread ptr
declare sub g_thread_set_priority(byval thread as GThread ptr, byval priority as GThreadPriority)
declare sub g_thread_foreach(byval thread_func as GFunc, byval user_data as gpointer)
#define G_STATIC_MUTEX_INIT_ (NULL)

type GStaticMutex
	mutex as GMutex ptr

	#ifdef __FB_UNIX__
		unused as pthread_mutex_t
	#endif
end type

#define g_static_mutex_lock(mutex) g_mutex_lock(g_static_mutex_get_mutex(mutex))
#define g_static_mutex_trylock(mutex) g_mutex_trylock(g_static_mutex_get_mutex(mutex))
#define g_static_mutex_unlock(mutex) g_mutex_unlock(g_static_mutex_get_mutex(mutex))

declare sub g_static_mutex_init(byval mutex as GStaticMutex ptr)
declare sub g_static_mutex_free(byval mutex as GStaticMutex ptr)
declare function g_static_mutex_get_mutex_impl(byval mutex as GStaticMutex ptr) as GMutex ptr
declare function g_static_mutex_get_mutex alias "g_static_mutex_get_mutex_impl"(byval mutex as GStaticMutex ptr) as GMutex ptr
type GStaticRecMutex as _GStaticRecMutex

union _GStaticRecMutex_unused
	#ifdef __FB_UNIX__
		owner as pthread_t
	#else
		owner as any ptr
	#endif

	dummy as gdouble
end union

type _GStaticRecMutex
	mutex as GStaticMutex
	depth as guint
	unused as _GStaticRecMutex_unused
end type

#define G_STATIC_REC_MUTEX_INIT_ (G_STATIC_MUTEX_INIT_)
declare sub g_static_rec_mutex_init(byval mutex as GStaticRecMutex ptr)
declare sub g_static_rec_mutex_lock(byval mutex as GStaticRecMutex ptr)
declare function g_static_rec_mutex_trylock(byval mutex as GStaticRecMutex ptr) as gboolean
declare sub g_static_rec_mutex_unlock(byval mutex as GStaticRecMutex ptr)
declare sub g_static_rec_mutex_lock_full(byval mutex as GStaticRecMutex ptr, byval depth as guint)
declare function g_static_rec_mutex_unlock_full(byval mutex as GStaticRecMutex ptr) as guint
declare sub g_static_rec_mutex_free(byval mutex as GStaticRecMutex ptr)
type GStaticRWLock as _GStaticRWLock

type _GStaticRWLock
	mutex as GStaticMutex
	read_cond as GCond ptr
	write_cond as GCond ptr
	read_counter as guint
	have_writer as gboolean
	want_to_read as guint
	want_to_write as guint
end type

#define G_STATIC_RW_LOCK_INIT_ (G_STATIC_MUTEX_INIT_, NULL, NULL, 0, FALSE, 0, 0)
declare sub g_static_rw_lock_init(byval lock as GStaticRWLock ptr)
declare sub g_static_rw_lock_reader_lock(byval lock as GStaticRWLock ptr)
declare function g_static_rw_lock_reader_trylock(byval lock as GStaticRWLock ptr) as gboolean
declare sub g_static_rw_lock_reader_unlock(byval lock as GStaticRWLock ptr)
declare sub g_static_rw_lock_writer_lock(byval lock as GStaticRWLock ptr)
declare function g_static_rw_lock_writer_trylock(byval lock as GStaticRWLock ptr) as gboolean
declare sub g_static_rw_lock_writer_unlock(byval lock as GStaticRWLock ptr)
declare sub g_static_rw_lock_free(byval lock as GStaticRWLock ptr)
declare function g_private_new(byval notify as GDestroyNotify) as GPrivate ptr
type GStaticPrivate as _GStaticPrivate

type _GStaticPrivate
	index as guint
end type

#define G_STATIC_PRIVATE_INIT_ (0)
declare sub g_static_private_init(byval private_key as GStaticPrivate ptr)
declare function g_static_private_get(byval private_key as GStaticPrivate ptr) as gpointer
declare sub g_static_private_set(byval private_key as GStaticPrivate ptr, byval data as gpointer, byval notify as GDestroyNotify)
declare sub g_static_private_free(byval private_key as GStaticPrivate ptr)
declare function g_once_init_enter_impl(byval location as gsize ptr) as gboolean
declare sub g_thread_init(byval vtable as gpointer)
declare sub g_thread_init_with_errorcheck_mutexes(byval vtable as gpointer)
declare function g_thread_get_initialized() as gboolean

#if (defined(__FB_WIN32__) and (not defined(GLIB_STATIC_COMPILATION))) or defined(__FB_CYGWIN__)
	extern import g_threads_got_initialized as gboolean
#else
	extern g_threads_got_initialized as gboolean
#endif

#define g_thread_supported() 1
declare function g_mutex_new() as GMutex ptr
declare sub g_mutex_free(byval mutex as GMutex ptr)
declare function g_cond_new() as GCond ptr
declare sub g_cond_free(byval cond as GCond ptr)
declare function g_cond_timed_wait(byval cond as GCond ptr, byval mutex as GMutex ptr, byval timeval as GTimeVal ptr) as gboolean

private sub g_autoptr_cleanup_generic_gfree(byval p as any ptr)
	dim pp as any ptr ptr = cptr(any ptr ptr, p)
	if *pp then
		g_free(*pp)
	end if
end sub

type GAsyncQueue_autoptr as GAsyncQueue ptr

private sub glib_autoptr_cleanup_GAsyncQueue(byval _ptr as GAsyncQueue ptr ptr)
	if *_ptr then
		g_async_queue_unref(*_ptr)
	end if
end sub

type GBookmarkFile_autoptr as GBookmarkFile ptr

private sub glib_autoptr_cleanup_GBookmarkFile(byval _ptr as GBookmarkFile ptr ptr)
	if *_ptr then
		g_bookmark_file_free(*_ptr)
	end if
end sub

type GBytes_autoptr as GBytes ptr

private sub glib_autoptr_cleanup_GBytes(byval _ptr as GBytes ptr ptr)
	if *_ptr then
		g_bytes_unref(*_ptr)
	end if
end sub

type GChecksum_autoptr as GChecksum ptr

private sub glib_autoptr_cleanup_GChecksum(byval _ptr as GChecksum ptr ptr)
	if *_ptr then
		g_checksum_free(*_ptr)
	end if
end sub

type GDateTime_autoptr as GDateTime ptr

private sub glib_autoptr_cleanup_GDateTime(byval _ptr as GDateTime ptr ptr)
	if *_ptr then
		g_date_time_unref(*_ptr)
	end if
end sub

type GDir_autoptr as GDir ptr

private sub glib_autoptr_cleanup_GDir(byval _ptr as GDir ptr ptr)
	if *_ptr then
		g_dir_close(*_ptr)
	end if
end sub

type GError_autoptr as GError ptr

private sub glib_autoptr_cleanup_GError(byval _ptr as GError ptr ptr)
	if *_ptr then
		g_error_free(*_ptr)
	end if
end sub

type GHashTable_autoptr as GHashTable ptr

private sub glib_autoptr_cleanup_GHashTable(byval _ptr as GHashTable ptr ptr)
	if *_ptr then
		g_hash_table_unref(*_ptr)
	end if
end sub

type GHmac_autoptr as GHmac ptr

private sub glib_autoptr_cleanup_GHmac(byval _ptr as GHmac ptr ptr)
	if *_ptr then
		g_hmac_unref(*_ptr)
	end if
end sub

type GIOChannel_autoptr as GIOChannel ptr

private sub glib_autoptr_cleanup_GIOChannel(byval _ptr as GIOChannel ptr ptr)
	if *_ptr then
		g_io_channel_unref(*_ptr)
	end if
end sub

type GKeyFile_autoptr as GKeyFile ptr

private sub glib_autoptr_cleanup_GKeyFile(byval _ptr as GKeyFile ptr ptr)
	if *_ptr then
		g_key_file_unref(*_ptr)
	end if
end sub

type GList_autoptr as GList ptr

private sub glib_autoptr_cleanup_GList(byval _ptr as GList ptr ptr)
	if *_ptr then
		g_list_free(*_ptr)
	end if
end sub

type GArray_autoptr as GArray ptr

private sub glib_autoptr_cleanup_GArray(byval _ptr as GArray ptr ptr)
	if *_ptr then
		g_array_unref(*_ptr)
	end if
end sub

type GPtrArray_autoptr as GPtrArray ptr

private sub glib_autoptr_cleanup_GPtrArray(byval _ptr as GPtrArray ptr ptr)
	if *_ptr then
		g_ptr_array_unref(*_ptr)
	end if
end sub

type GByteArray_autoptr as GByteArray ptr

private sub glib_autoptr_cleanup_GByteArray(byval _ptr as GByteArray ptr ptr)
	if *_ptr then
		g_byte_array_unref(*_ptr)
	end if
end sub

type GMainContext_autoptr as GMainContext ptr

private sub glib_autoptr_cleanup_GMainContext(byval _ptr as GMainContext ptr ptr)
	if *_ptr then
		g_main_context_unref(*_ptr)
	end if
end sub

type GMainLoop_autoptr as GMainLoop ptr

private sub glib_autoptr_cleanup_GMainLoop(byval _ptr as GMainLoop ptr ptr)
	if *_ptr then
		g_main_loop_unref(*_ptr)
	end if
end sub

type GSource_autoptr as GSource ptr

private sub glib_autoptr_cleanup_GSource(byval _ptr as GSource ptr ptr)
	if *_ptr then
		g_source_unref(*_ptr)
	end if
end sub

type GMappedFile_autoptr as GMappedFile ptr

private sub glib_autoptr_cleanup_GMappedFile(byval _ptr as GMappedFile ptr ptr)
	if *_ptr then
		g_mapped_file_unref(*_ptr)
	end if
end sub

type GMarkupParseContext_autoptr as GMarkupParseContext ptr

private sub glib_autoptr_cleanup_GMarkupParseContext(byval _ptr as GMarkupParseContext ptr ptr)
	if *_ptr then
		g_markup_parse_context_unref(*_ptr)
	end if
end sub

type GNode_autoptr as GNode ptr

private sub glib_autoptr_cleanup_GNode(byval _ptr as GNode ptr ptr)
	if *_ptr then
		g_node_destroy(*_ptr)
	end if
end sub

type GOptionContext_autoptr as GOptionContext ptr

private sub glib_autoptr_cleanup_GOptionContext(byval _ptr as GOptionContext ptr ptr)
	if *_ptr then
		g_option_context_free(*_ptr)
	end if
end sub

type GOptionGroup_autoptr as GOptionGroup ptr

private sub glib_autoptr_cleanup_GOptionGroup(byval _ptr as GOptionGroup ptr ptr)
	if *_ptr then
		g_option_group_unref(*_ptr)
	end if
end sub

type GPatternSpec_autoptr as GPatternSpec ptr

private sub glib_autoptr_cleanup_GPatternSpec(byval _ptr as GPatternSpec ptr ptr)
	if *_ptr then
		g_pattern_spec_free(*_ptr)
	end if
end sub

type GQueue_autoptr as GQueue ptr

private sub glib_autoptr_cleanup_GQueue(byval _ptr as GQueue ptr ptr)
	if *_ptr then
		g_queue_free(*_ptr)
	end if
end sub

private sub glib_auto_cleanup_GQueue(byval _ptr as GQueue ptr)
	g_queue_clear(_ptr)
end sub

type GRand_autoptr as GRand ptr

private sub glib_autoptr_cleanup_GRand(byval _ptr as GRand ptr ptr)
	if *_ptr then
		g_rand_free(*_ptr)
	end if
end sub

type GRegex_autoptr as GRegex ptr

private sub glib_autoptr_cleanup_GRegex(byval _ptr as GRegex ptr ptr)
	if *_ptr then
		g_regex_unref(*_ptr)
	end if
end sub

type GMatchInfo_autoptr as GMatchInfo ptr

private sub glib_autoptr_cleanup_GMatchInfo(byval _ptr as GMatchInfo ptr ptr)
	if *_ptr then
		g_match_info_unref(*_ptr)
	end if
end sub

type GScanner_autoptr as GScanner ptr

private sub glib_autoptr_cleanup_GScanner(byval _ptr as GScanner ptr ptr)
	if *_ptr then
		g_scanner_destroy(*_ptr)
	end if
end sub

type GSequence_autoptr as GSequence ptr

private sub glib_autoptr_cleanup_GSequence(byval _ptr as GSequence ptr ptr)
	if *_ptr then
		g_sequence_free(*_ptr)
	end if
end sub

type GSList_autoptr as GSList ptr

private sub glib_autoptr_cleanup_GSList(byval _ptr as GSList ptr ptr)
	if *_ptr then
		g_slist_free(*_ptr)
	end if
end sub

type GStringChunk_autoptr as GStringChunk ptr

private sub glib_autoptr_cleanup_GStringChunk(byval _ptr as GStringChunk ptr ptr)
	if *_ptr then
		g_string_chunk_free(*_ptr)
	end if
end sub

type GThread_autoptr as GThread ptr

private sub glib_autoptr_cleanup_GThread(byval _ptr as GThread ptr ptr)
	if *_ptr then
		g_thread_unref(*_ptr)
	end if
end sub

private sub glib_auto_cleanup_GMutex(byval _ptr as GMutex ptr)
	g_mutex_clear(_ptr)
end sub

type GMutexLocker_autoptr as GMutexLocker ptr

private sub glib_autoptr_cleanup_GMutexLocker(byval _ptr as GMutexLocker ptr ptr)
	if *_ptr then
		g_mutex_locker_free(*_ptr)
	end if
end sub

private sub glib_auto_cleanup_GCond(byval _ptr as GCond ptr)
	g_cond_clear(_ptr)
end sub

type GTimer_autoptr as GTimer ptr

private sub glib_autoptr_cleanup_GTimer(byval _ptr as GTimer ptr ptr)
	if *_ptr then
		g_timer_destroy(*_ptr)
	end if
end sub

type GTimeZone_autoptr as GTimeZone ptr

private sub glib_autoptr_cleanup_GTimeZone(byval _ptr as GTimeZone ptr ptr)
	if *_ptr then
		g_time_zone_unref(*_ptr)
	end if
end sub

type GTree_autoptr as GTree ptr

private sub glib_autoptr_cleanup_GTree(byval _ptr as GTree ptr ptr)
	if *_ptr then
		g_tree_unref(*_ptr)
	end if
end sub

type GVariant_autoptr as GVariant ptr

private sub glib_autoptr_cleanup_GVariant(byval _ptr as GVariant ptr ptr)
	if *_ptr then
		g_variant_unref(*_ptr)
	end if
end sub

type GVariantBuilder_autoptr as GVariantBuilder ptr

private sub glib_autoptr_cleanup_GVariantBuilder(byval _ptr as GVariantBuilder ptr ptr)
	if *_ptr then
		g_variant_builder_unref(*_ptr)
	end if
end sub

private sub glib_auto_cleanup_GVariantBuilder(byval _ptr as GVariantBuilder ptr)
	g_variant_builder_clear(_ptr)
end sub

type GVariantIter_autoptr as GVariantIter ptr

private sub glib_autoptr_cleanup_GVariantIter(byval _ptr as GVariantIter ptr ptr)
	if *_ptr then
		g_variant_iter_free(*_ptr)
	end if
end sub

type GVariantDict_autoptr as GVariantDict ptr

private sub glib_autoptr_cleanup_GVariantDict(byval _ptr as GVariantDict ptr ptr)
	if *_ptr then
		g_variant_dict_unref(*_ptr)
	end if
end sub

private sub glib_auto_cleanup_GVariantDict(byval _ptr as GVariantDict ptr)
	g_variant_dict_clear(_ptr)
end sub

type GVariantType_autoptr as GVariantType ptr

private sub glib_autoptr_cleanup_GVariantType(byval _ptr as GVariantType ptr ptr)
	if *_ptr then
		g_variant_type_free(*_ptr)
	end if
end sub

#undef __GLIB_H_INSIDE__

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
