'' FreeBASIC binding for lzo-2.09
''
'' based on the C header files:
''   lzodefs.h -- architecture, OS and compiler specific defines
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

#include once "crt/long.bi"

const __LZODEFS_H_INCLUDED = 1
const _CRT_NONSTDC_NO_DEPRECATE = 1
const _CRT_NONSTDC_NO_WARNINGS = 1
const _CRT_SECURE_NO_DEPRECATE = 1
const _CRT_SECURE_NO_WARNINGS = 1
const LZO_0xffffUL = cast(culong, 65535)
const LZO_0xffffffffUL = cast(culong, 4294967295)
const LZO_0xffffL = LZO_0xffffUL
const LZO_0xffffffffL = LZO_0xffffffffUL
#define LZO_PP_STRINGIZE(x) #x
#define LZO_PP_MACRO_EXPAND(x) LZO_PP_STRINGIZE(x)
#define LZO_PP_CONCAT0()
#define LZO_PP_CONCAT1(a) a
#define LZO_PP_CONCAT2(a, b) a##b
#define LZO_PP_CONCAT3(a, b, c) a##b##c
#define LZO_PP_CONCAT4(a, b, c, d) a##b##c##d
#define LZO_PP_CONCAT5(a, b, c, d, e) a##b##c##d##e
#define LZO_PP_CONCAT6(a, b, c, d, e, f) a##b##c##d##e##f
#define LZO_PP_CONCAT7(a, b, c, d, e, f, g) a##b##c##d##e##f##g
#define LZO_PP_ECONCAT0() LZO_PP_CONCAT0()
#define LZO_PP_ECONCAT1(a) LZO_PP_CONCAT1(a)
#define LZO_PP_ECONCAT2(a, b) LZO_PP_CONCAT2(a, b)
#define LZO_PP_ECONCAT3(a, b, c) LZO_PP_CONCAT3(a, b, c)
#define LZO_PP_ECONCAT4(a, b, c, d) LZO_PP_CONCAT4(a, b, c, d)
#define LZO_PP_ECONCAT5(a, b, c, d, e) LZO_PP_CONCAT5(a, b, c, d, e)
#define LZO_PP_ECONCAT6(a, b, c, d, e, f) LZO_PP_CONCAT6(a, b, c, d, e, f)
#define LZO_PP_ECONCAT7(a, b, c, d, e, f, g) LZO_PP_CONCAT7(a, b, c, d, e, f, g)
#define LZO_PP_EMPTY
#define LZO_PP_EMPTY0()
#define LZO_PP_EMPTY1(a)
#define LZO_PP_EMPTY2(a, b)
#define LZO_PP_EMPTY3(a, b, c)
#define LZO_PP_EMPTY4(a, b, c, d)
#define LZO_PP_EMPTY5(a, b, c, d, e)
#define LZO_PP_EMPTY6(a, b, c, d, e, f)
#define LZO_PP_EMPTY7(a, b, c, d, e, f, g)
#define LZO_CPP_STRINGIZE(x) #x
#define LZO_CPP_MACRO_EXPAND(x) LZO_CPP_STRINGIZE(x)
#define LZO_CPP_CONCAT2(a, b) a##b
#define LZO_CPP_CONCAT3(a, b, c) a##b##c
#define LZO_CPP_CONCAT4(a, b, c, d) a##b##c##d
#define LZO_CPP_CONCAT5(a, b, c, d, e) a##b##c##d##e
#define LZO_CPP_CONCAT6(a, b, c, d, e, f) a##b##c##d##e##f
#define LZO_CPP_CONCAT7(a, b, c, d, e, f, g) a##b##c##d##e##f##g
#define LZO_CPP_ECONCAT2(a, b) LZO_CPP_CONCAT2(a, b)
#define LZO_CPP_ECONCAT3(a, b, c) LZO_CPP_CONCAT3(a, b, c)
#define LZO_CPP_ECONCAT4(a, b, c, d) LZO_CPP_CONCAT4(a, b, c, d)
#define LZO_CPP_ECONCAT5(a, b, c, d, e) LZO_CPP_CONCAT5(a, b, c, d, e)
#define LZO_CPP_ECONCAT6(a, b, c, d, e, f) LZO_CPP_CONCAT6(a, b, c, d, e, f)
#define LZO_CPP_ECONCAT7(a, b, c, d, e, f, g) LZO_CPP_CONCAT7(a, b, c, d, e, f, g)
#define __LZO_MASK_GEN(o, b) (((((o) shl ((b) - (-(((b) = 0) = 0)))) - (o)) shl 1) + ((o) * (-(((b) = 0) = 0))))

#if defined(__FB_DARWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
	const LZO_OS_POSIX = 1
	#define LZO_INFO_OS "posix"
#endif

#ifdef __FB_LINUX__
	const LZO_OS_POSIX_LINUX = 1
	#define LZO_INFO_OS_POSIX "linux"
#elseif defined(__FB_FREEBSD__)
	const LZO_OS_POSIX_FREEBSD = 1
	#define LZO_INFO_OS_POSIX "freebsd"
#elseif defined(__FB_OPENBSD__)
	const LZO_OS_POSIX_OPENBSD = 1
	#define LZO_INFO_OS_POSIX "openbsd"
#elseif defined(__FB_NETBSD__)
	const LZO_OS_POSIX_NETBSD = 1
	#define LZO_INFO_OS_POSIX "netbsd"
#elseif defined(__FB_DARWIN__)
	const LZO_OS_POSIX_DARWIN = 1
	#define LZO_INFO_OS_POSIX "darwin"
	const LZO_OS_POSIX_MACOSX = LZO_OS_POSIX_DARWIN
#elseif defined(__FB_WIN32__) and (not defined(__FB_64BIT__))
	const LZO_OS_WIN32 = 1
	#define LZO_INFO_OS "win32"
#elseif defined(__FB_WIN32__) and defined(__FB_64BIT__)
	const LZO_OS_WIN64 = 1
	#define LZO_INFO_OS "win64"
#elseif defined(__FB_CYGWIN__)
	const LZO_OS_CYGWIN = 1
	#define LZO_INFO_OS "cygwin"
#else
	const LZO_OS_DOS32 = 1
	#define LZO_INFO_OS "dos32"
#endif

const LZO_CC_UNKNOWN = 1
#define LZO_INFO_CC "unknown"
#define LZO_INFO_CCVER "unknown"

#if defined(__FB_DOS__) or ((not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))))
	const LZO_ARCH_I386 = 1
	const LZO_ARCH_IA32 = 1
	#define LZO_INFO_ARCH "i386"
	const LZO_ARCH_X86 = 1
#elseif defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
	const LZO_ARCH_AMD64 = 1
	#define LZO_INFO_ARCH "amd64"
	const LZO_ARCH_X64 = 1
	const LZO_TARGET_FEATURE_SSE2 = 1
#elseif (not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	const LZO_ARCH_ARM = 1
	#define LZO_INFO_ARCH "arm"
	const LZO_ARCH_ARM_THUMB2 = 1
#else
	const LZO_ARCH_ARM64 = 1
	#define LZO_INFO_ARCH "arm64"
	const LZO_ARCH_AARCH64 = 1
	const LZO_TARGET_FEATURE_NEON = 1
#endif

const LZO_MM_FLAT = 1
#define LZO_INFO_MM "flat"

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	const LZO_HAVE_WINDOWS_H = 1
#endif

const LZO_SIZEOF_SHORT = 2
const LZO_SIZEOF_INT = 4

#if defined(__FB_64BIT__) and defined(__FB_UNIX__)
	const LZO_SIZEOF_LONG = 8
#else
	const LZO_SIZEOF_LONG = 4
#endif

const LZO_SIZEOF_LONG_LONG = 8

#if defined(__FB_64BIT__) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))
	const LZO_SIZEOF_VOID_P = 8
	const LZO_SIZEOF_SIZE_T = 8
	const LZO_SIZEOF_PTRDIFF_T = 8
#else
	const LZO_SIZEOF_VOID_P = 4
	const LZO_SIZEOF_SIZE_T = 4
	const LZO_SIZEOF_PTRDIFF_T = 4
#endif

#define __LZO_LSR(x, b) (((x) + cast(culong, 0)) shr (b))

#if defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
	const LZO_WORDSIZE = 8
#else
	const LZO_WORDSIZE = LZO_SIZEOF_VOID_P
#endif

const LZO_ABI_LITTLE_ENDIAN = 1
#define LZO_INFO_ABI_ENDIAN "le"

#if defined(__FB_DOS__) or ((not defined(__FB_64BIT__)) and (defined(__FB_WIN32__) or defined(__FB_UNIX__)))
	const LZO_ABI_ILP32 = 1
	#define LZO_INFO_ABI_PM "ilp32"
#elseif defined(__FB_64BIT__) and defined(__FB_UNIX__)
	const LZO_ABI_LP64 = 1
	#define LZO_INFO_ABI_PM "lp64"
#else
	const LZO_ABI_LLP64 = 1
	#define LZO_INFO_ABI_PM "llp64"
#endif

const LZO_LIBC_DEFAULT = 1
#define LZO_INFO_LIBC "default"

#if defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
	const LZO_OPT_AVOID_INT_INDEX = 1
	const LZO_OPT_AVOID_UINT_INDEX = 1
#endif

const LZO_OPT_UNALIGNED16 = 1
const LZO_OPT_UNALIGNED32 = 1

#if defined(__FB_64BIT__) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))
	const LZO_OPT_UNALIGNED64 = 1
#endif

#define __LZO_INFOSTR_MM ""
#define __LZO_INFOSTR_PM "." LZO_INFO_ABI_PM
#define __LZO_INFOSTR_ENDIAN "." LZO_INFO_ABI_ENDIAN

#if defined(__FB_DOS__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	#define __LZO_INFOSTR_OSNAME LZO_INFO_OS
#else
	#define __LZO_INFOSTR_OSNAME LZO_INFO_OS "." LZO_INFO_OS_POSIX
#endif

#define __LZO_INFOSTR_LIBC "." LZO_INFO_LIBC
#define __LZO_INFOSTR_CCVER " " LZO_INFO_CCVER
#define LZO_INFO_STRING LZO_INFO_ARCH __LZO_INFOSTR_MM __LZO_INFOSTR_PM __LZO_INFOSTR_ENDIAN " " __LZO_INFOSTR_OSNAME __LZO_INFOSTR_LIBC " " LZO_INFO_CC __LZO_INFOSTR_CCVER
const LZO_TYPEOF_CHAR = 1u
const LZO_TYPEOF_SHORT = 2u
const LZO_TYPEOF_INT = 3u
const LZO_TYPEOF_LONG = 4u
const LZO_TYPEOF_LONG_LONG = 5u
const LZO_TYPEOF___INT8 = 17u
const LZO_TYPEOF___INT16 = 18u
const LZO_TYPEOF___INT32 = 19u
const LZO_TYPEOF___INT64 = 20u
const LZO_TYPEOF___INT128 = 21u
const LZO_TYPEOF___INT256 = 22u
const LZO_TYPEOF___MODE_QI = 33u
const LZO_TYPEOF___MODE_HI = 34u
const LZO_TYPEOF___MODE_SI = 35u
const LZO_TYPEOF___MODE_DI = 36u
const LZO_TYPEOF___MODE_TI = 37u
const LZO_TYPEOF_CHAR_P = 129u

type lzo_llong_t__ as longint
type lzo_ullong_t__ as ulongint
type lzo_llong_t as lzo_llong_t__
type lzo_ullong_t as lzo_ullong_t__
type lzo_int16e_t as short
type lzo_uint16e_t as ushort
const LZO_TYPEOF_LZO_INT16E_T = LZO_TYPEOF_SHORT
const LZO_SIZEOF_LZO_INT16E_T = 2

#if defined(__FB_64BIT__) and defined(__FB_UNIX__)
	type lzo_int32e_t as long
	type lzo_uint32e_t as ulong
	const LZO_TYPEOF_LZO_INT32E_T = LZO_TYPEOF_INT
#else
	type lzo_int32e_t as clong
	type lzo_uint32e_t as culong
	const LZO_TYPEOF_LZO_INT32E_T = LZO_TYPEOF_LONG
#endif

const LZO_SIZEOF_LZO_INT32E_T = 4

#if defined(__FB_64BIT__) and defined(__FB_UNIX__)
	type lzo_int64e_t as clong
	type lzo_uint64e_t as culong
	const LZO_TYPEOF_LZO_INT64E_T = LZO_TYPEOF_LONG
#else
	type lzo_int64e_t as lzo_llong_t
	type lzo_uint64e_t as lzo_ullong_t
	const LZO_TYPEOF_LZO_INT64E_T = LZO_TYPEOF_LONG_LONG
	#define LZO_INT64_C(c) c##LL
	#define LZO_UINT64_C(c) c##ULL
#endif

const LZO_SIZEOF_LZO_INT64E_T = 8
type lzo_int32l_t as lzo_int32e_t
type lzo_uint32l_t as lzo_uint32e_t
const LZO_SIZEOF_LZO_INT32L_T = LZO_SIZEOF_LZO_INT32E_T
const LZO_TYPEOF_LZO_INT32L_T = LZO_TYPEOF_LZO_INT32E_T
type lzo_int64l_t as lzo_int64e_t
type lzo_uint64l_t as lzo_uint64e_t
const LZO_SIZEOF_LZO_INT64L_T = LZO_SIZEOF_LZO_INT64E_T
const LZO_TYPEOF_LZO_INT64L_T = LZO_TYPEOF_LZO_INT64E_T

#if defined(__FB_64BIT__) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))
	type lzo_int32f_t as lzo_int64l_t
	type lzo_uint32f_t as lzo_uint64l_t
	const LZO_SIZEOF_LZO_INT32F_T = LZO_SIZEOF_LZO_INT64L_T
	const LZO_TYPEOF_LZO_INT32F_T = LZO_TYPEOF_LZO_INT64L_T
#else
	type lzo_int32f_t as lzo_int32l_t
	type lzo_uint32f_t as lzo_uint32l_t
	const LZO_SIZEOF_LZO_INT32F_T = LZO_SIZEOF_LZO_INT32L_T
	const LZO_TYPEOF_LZO_INT32F_T = LZO_TYPEOF_LZO_INT32L_T
#endif

type lzo_int64f_t as lzo_int64l_t
type lzo_uint64f_t as lzo_uint64l_t
const LZO_SIZEOF_LZO_INT64F_T = LZO_SIZEOF_LZO_INT64L_T
const LZO_TYPEOF_LZO_INT64F_T = LZO_TYPEOF_LZO_INT64L_T

#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
	type lzo_intptr_t as lzo_int64l_t
	type lzo_uintptr_t as lzo_uint64l_t
	const LZO_SIZEOF_LZO_INTPTR_T = LZO_SIZEOF_LZO_INT64L_T
	const LZO_TYPEOF_LZO_INTPTR_T = LZO_TYPEOF_LZO_INT64L_T
#else
	type lzo_intptr_t as clong
	type lzo_uintptr_t as culong
	const LZO_SIZEOF_LZO_INTPTR_T = LZO_SIZEOF_LONG
	const LZO_TYPEOF_LZO_INTPTR_T = LZO_TYPEOF_LONG
#endif

type lzo_word_t as lzo_uintptr_t
type lzo_sword_t as lzo_intptr_t
const LZO_SIZEOF_LZO_WORD_T = LZO_SIZEOF_LZO_INTPTR_T
const LZO_TYPEOF_LZO_WORD_T = LZO_TYPEOF_LZO_INTPTR_T
type lzo_int8_t as byte
type lzo_uint8_t as ubyte
const LZO_SIZEOF_LZO_INT8_T = 1
const LZO_TYPEOF_LZO_INT8_T = LZO_TYPEOF_CHAR
type lzo_int16_t as lzo_int16e_t
type lzo_uint16_t as lzo_uint16e_t
const LZO_SIZEOF_LZO_INT16_T = LZO_SIZEOF_LZO_INT16E_T
const LZO_TYPEOF_LZO_INT16_T = LZO_TYPEOF_LZO_INT16E_T
type lzo_int32_t as lzo_int32e_t
type lzo_uint32_t as lzo_uint32e_t
const LZO_SIZEOF_LZO_INT32_T = LZO_SIZEOF_LZO_INT32E_T
const LZO_TYPEOF_LZO_INT32_T = LZO_TYPEOF_LZO_INT32E_T
type lzo_int64_t as lzo_int64e_t
type lzo_uint64_t as lzo_uint64e_t
const LZO_SIZEOF_LZO_INT64_T = LZO_SIZEOF_LZO_INT64E_T
const LZO_TYPEOF_LZO_INT64_T = LZO_TYPEOF_LZO_INT64E_T
type lzo_int_least32_t as lzo_int32l_t
type lzo_uint_least32_t as lzo_uint32l_t
const LZO_SIZEOF_LZO_INT_LEAST32_T = LZO_SIZEOF_LZO_INT32L_T
const LZO_TYPEOF_LZO_INT_LEAST32_T = LZO_TYPEOF_LZO_INT32L_T
type lzo_int_least64_t as lzo_int64l_t
type lzo_uint_least64_t as lzo_uint64l_t
const LZO_SIZEOF_LZO_INT_LEAST64_T = LZO_SIZEOF_LZO_INT64L_T
const LZO_TYPEOF_LZO_INT_LEAST64_T = LZO_TYPEOF_LZO_INT64L_T
type lzo_int_fast32_t as lzo_int32f_t
type lzo_uint_fast32_t as lzo_uint32f_t
const LZO_SIZEOF_LZO_INT_FAST32_T = LZO_SIZEOF_LZO_INT32F_T
const LZO_TYPEOF_LZO_INT_FAST32_T = LZO_TYPEOF_LZO_INT32F_T
type lzo_int_fast64_t as lzo_int64f_t
type lzo_uint_fast64_t as lzo_uint64f_t
const LZO_SIZEOF_LZO_INT_FAST64_T = LZO_SIZEOF_LZO_INT64F_T
const LZO_TYPEOF_LZO_INT_FAST64_T = LZO_TYPEOF_LZO_INT64F_T
#define LZO_INT16_C(c) (c)
#define LZO_UINT16_C(c) c##U
#define LZO_INT32_C(c) (c)
#define LZO_UINT32_C(c) c##U

#if defined(__FB_64BIT__) and defined(__FB_UNIX__)
	#define LZO_INT64_C(c) c##L
	#define LZO_UINT64_C(c) c##UL
#endif
