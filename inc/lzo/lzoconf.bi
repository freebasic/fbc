'' FreeBASIC binding for lzo-2.09
''
'' based on the C header files:
''   lzoconf.h -- configuration of the LZO data compression library
''
''   This file is part of the LZO real-time data compression library.
''
''   Copyright (C) 1996-2015 Markus Franz Xaver Johannes Oberhumer
''   All Rights Reserved.
''
''   The LZO library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU General Public License as
''   published by the Free Software Foundation; either version 2 of
''   the License, or (at your option) any later version.
''
''   The LZO library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''   GNU General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with the LZO library; see the file COPYING.
''   If not, write to the Free Software Foundation, Inc.,
''   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
''
''   Markus F.X.J. Oberhumer
''   <markus@oberhumer.com>
''   http://www.oberhumer.com/opensource/lzo/
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "lzo2"

#include once "crt/long.bi"
#include once "crt/limits.bi"
#include once "crt/stddef.bi"
#include once "lzo/lzodefs.bi"

'' The following symbols have been renamed:
''     constant LZO_VERSION => LZO_VERSION_
''     #define LZO_VERSION_STRING => LZO_VERSION_STRING_
''     #define LZO_VERSION_DATE => LZO_VERSION_DATE_

extern "C"

const __LZOCONF_H_INCLUDED = 1
const LZO_VERSION_ = &h2090
#define LZO_VERSION_STRING_ "2.09"
#define LZO_VERSION_DATE_ "Feb 04 2015"

#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
	type lzo_uint as ulongint
	type lzo_int as longint
	const LZO_TYPEOF_LZO_INT = LZO_TYPEOF___INT64
	const LZO_SIZEOF_LZO_INT = 8
	const LZO_UINT_MAX = &hffffffffffffffffull
	const LZO_INT_MAX = 9223372036854775807ll
	const LZO_INT_MIN = (-1ll) - LZO_INT_MAX
#else
	type lzo_uint as culong
	type lzo_int as clong
	const LZO_SIZEOF_LZO_INT = LZO_SIZEOF_LONG
	const LZO_TYPEOF_LZO_INT = LZO_TYPEOF_LONG
	#define LZO_UINT_MAX ULONG_MAX
	#define LZO_INT_MAX LONG_MAX
	#define LZO_INT_MIN LONG_MIN
#endif

type lzo_xint as lzo_uint
type lzo_bool as long
type lzo_bytep as ubyte ptr
type lzo_charp as zstring ptr
type lzo_voidp as any ptr
type lzo_shortp as short ptr
type lzo_ushortp as ushort ptr
type lzo_intp as lzo_int ptr
type lzo_uintp as lzo_uint ptr
type lzo_xintp as lzo_xint ptr
type lzo_voidpp as lzo_voidp ptr
type lzo_bytepp as lzo_bytep ptr
type lzo_int8_tp as lzo_int8_t ptr
type lzo_uint8_tp as lzo_uint8_t ptr
type lzo_int16_tp as lzo_int16_t ptr
type lzo_uint16_tp as lzo_uint16_t ptr
type lzo_int32_tp as lzo_int32_t ptr
type lzo_uint32_tp as lzo_uint32_t ptr
type lzo_int64_tp as lzo_int64_t ptr
type lzo_uint64_tp as lzo_uint64_t ptr
type lzo_compress_t as function(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
type lzo_decompress_t as function(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
type lzo_optimize_t as function(byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
type lzo_compress_dict_t as function(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp, byval dict as const lzo_bytep, byval dict_len as lzo_uint) as long
type lzo_decompress_dict_t as function(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp, byval dict as const lzo_bytep, byval dict_len as lzo_uint) as long
type lzo_callback_t as lzo_callback_t_
type lzo_callback_p as lzo_callback_t ptr
type lzo_alloc_func_t as function(byval self as lzo_callback_t ptr, byval items as lzo_uint, byval size as lzo_uint) as lzo_voidp
type lzo_free_func_t as sub(byval self as lzo_callback_t ptr, byval ptr as lzo_voidp)
type lzo_progress_func_t as sub(byval as lzo_callback_t ptr, byval as lzo_uint, byval as lzo_uint, byval as long)

type lzo_callback_t_
	nalloc as lzo_alloc_func_t
	nfree as lzo_free_func_t
	nprogress as lzo_progress_func_t
	user1 as lzo_voidp
	user2 as lzo_xint
	user3 as lzo_xint
end type

const LZO_E_OK = 0
const LZO_E_ERROR = -1
const LZO_E_OUT_OF_MEMORY = -2
const LZO_E_NOT_COMPRESSIBLE = -3
const LZO_E_INPUT_OVERRUN = -4
const LZO_E_OUTPUT_OVERRUN = -5
const LZO_E_LOOKBEHIND_OVERRUN = -6
const LZO_E_EOF_NOT_FOUND = -7
const LZO_E_INPUT_NOT_CONSUMED = -8
const LZO_E_NOT_YET_IMPLEMENTED = -9
const LZO_E_INVALID_ARGUMENT = -10
const LZO_E_INVALID_ALIGNMENT = -11
const LZO_E_OUTPUT_NOT_CONSUMED = -12
const LZO_E_INTERNAL_ERROR = -99
#define lzo_sizeof_dict_t culng(sizeof(lzo_bytep))
#define lzo_init() __lzo_init_v2(LZO_VERSION_, clng(sizeof(short)), clng(sizeof(long)), clng(sizeof(clong)), clng(sizeof(lzo_uint32_t)), clng(sizeof(lzo_uint)), clng(lzo_sizeof_dict_t), clng(sizeof(zstring ptr)), clng(sizeof(lzo_voidp)), clng(sizeof(lzo_callback_t)))

declare function __lzo_init_v2(byval as ulong, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function lzo_version() as ulong
declare function lzo_version_string() as const zstring ptr
declare function lzo_version_date() as const zstring ptr
declare function _lzo_version_string() as const zstring ptr
declare function _lzo_version_date() as const zstring ptr
declare function lzo_memcmp(byval a as const lzo_voidp, byval b as const lzo_voidp, byval len as lzo_uint) as long
declare function lzo_memcpy(byval dst as lzo_voidp, byval src as const lzo_voidp, byval len as lzo_uint) as lzo_voidp
declare function lzo_memmove(byval dst as lzo_voidp, byval src as const lzo_voidp, byval len as lzo_uint) as lzo_voidp
declare function lzo_memset(byval buf as lzo_voidp, byval c as long, byval len as lzo_uint) as lzo_voidp
declare function lzo_adler32(byval c as lzo_uint32_t, byval buf as const lzo_bytep, byval len as lzo_uint) as lzo_uint32_t
declare function lzo_crc32(byval c as lzo_uint32_t, byval buf as const lzo_bytep, byval len as lzo_uint) as lzo_uint32_t
declare function lzo_get_crc32_table() as const lzo_uint32_t ptr
declare function _lzo_config_check() as long

union lzo_align_t
	a00 as lzo_voidp
	a01 as lzo_bytep
	a02 as lzo_uint
	a03 as lzo_xint
	a04 as lzo_uintptr_t
	a05 as any ptr
	a06 as ubyte ptr
	a07 as culong
	a08 as uinteger
	a09 as integer
	a10 as lzo_uint64_t
end union

declare function __lzo_align_gap(byval p as const lzo_voidp, byval size as lzo_uint) as ulong
#define LZO_PTR_ALIGN_UP(p, size) ((p) + cast(lzo_uint, __lzo_align_gap(cast(const lzo_voidp, (p)), cast(lzo_uint, (size)))))
type lzo_byte as ubyte
type lzo_int32 as lzo_int32_t
type lzo_uint32 as lzo_uint32_t
type lzo_int32p as lzo_int32_t ptr
type lzo_uint32p as lzo_uint32_t ptr
#define LZO_INT32_MAX LZO_INT32_C(2147483647)
#define LZO_UINT32_MAX LZO_UINT32_C(4294967295)
type lzo_int64 as lzo_int64_t
type lzo_uint64 as lzo_uint64_t
type lzo_int64p as lzo_int64_t ptr
type lzo_uint64p as lzo_uint64_t ptr
#define LZO_INT64_MAX LZO_INT64_C(9223372036854775807)
#define LZO_UINT64_MAX LZO_UINT64_C(18446744073709551615)

union __lzo_pu_u
	a as lzo_bytep
	b as lzo_uint
end union

union __lzo_pu32_u
	a as lzo_bytep
	b as lzo_uint32_t
end union

const LZO_SIZEOF_LZO_UINT = LZO_SIZEOF_LZO_INT

end extern
