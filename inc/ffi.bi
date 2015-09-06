'' FreeBASIC binding for libffi-3.2.1
''
'' based on the C header files:
''   -----------------------------------------------------------------*-C-*-
''   libffi 3.2.1 - Copyright (c) 2011, 2014 Anthony Green
''                    - Copyright (c) 1996-2003, 2007, 2008 Red Hat, Inc.
''
''   Permission is hereby granted, free of charge, to any person
''   obtaining a copy of this software and associated documentation
''   files (the ``Software''), to deal in the Software without
''   restriction, including without limitation the rights to use, copy,
''   modify, merge, publish, distribute, sublicense, and/or sell copies
''   of the Software, and to permit persons to whom the Software is
''   furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be
''   included in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED ``AS IS'', WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
''   NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
''   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
''   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
''   ----------------------------------------------------------------------- 
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "ffi"

#include once "crt/stddef.bi"
#include once "crt/limits.bi"

'' The following symbols have been renamed:
''     typedef FFI_TYPE => FFI_TYPE_
''     constant FFI_TYPE_VOID => FFI_TYPE_VOID_
''     constant FFI_TYPE_FLOAT => FFI_TYPE_FLOAT_
''     constant FFI_TYPE_DOUBLE => FFI_TYPE_DOUBLE_
''     constant FFI_TYPE_LONGDOUBLE => FFI_TYPE_LONGDOUBLE_
''     constant FFI_TYPE_UINT8 => FFI_TYPE_UINT8_
''     constant FFI_TYPE_SINT8 => FFI_TYPE_SINT8_
''     constant FFI_TYPE_UINT16 => FFI_TYPE_UINT16_
''     constant FFI_TYPE_SINT16 => FFI_TYPE_SINT16_
''     constant FFI_TYPE_UINT32 => FFI_TYPE_UINT32_
''     constant FFI_TYPE_SINT32 => FFI_TYPE_SINT32_
''     constant FFI_TYPE_UINT64 => FFI_TYPE_UINT64_
''     constant FFI_TYPE_SINT64 => FFI_TYPE_SINT64_
''     constant FFI_TYPE_POINTER => FFI_TYPE_POINTER_

extern "C"

#define LIBFFI_H

#if (not defined(__FB_64BIT__)) and (not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_NETBSD__))
	#define X86
#elseif defined(__FB_64BIT__) and (not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	#define X86_64
#elseif (not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	#define ARM
#elseif defined(__FB_64BIT__) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	#define AARCH64
#elseif (not defined(__FB_64BIT__)) and (not defined(__FB_ARM__)) and (defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__))
	#define X86_FREEBSD
#elseif defined(__FB_DARWIN__)
	#define X86_DARWIN
#elseif (not defined(__FB_64BIT__)) and (defined(__FB_WIN32__) or defined(__FB_CYGWIN__))
	#define X86_WIN32
#else
	#define X86_WIN64
#endif

#define LIBFFI_TARGET_H

type ffi_arg as uinteger
type ffi_sarg as integer

#if ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	#define X86_ANY
#endif

#if defined(__FB_64BIT__) and (defined(__FB_WIN32__) or defined(__FB_CYGWIN__))
	const FFI_SIZEOF_ARG = 8
	const USE_BUILTIN_FFS = 0
#endif

#if ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	#define FFI_TARGET_SPECIFIC_STACK_SPACE_ALLOCATION
	#define FFI_TARGET_HAS_COMPLEX_TYPE
#endif

type ffi_abi as long
enum
	FFI_FIRST_ABI = 0

	#if (not defined(__FB_64BIT__)) or (defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))
		FFI_SYSV
	#endif

	#if ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_DARWIN__)
		FFI_UNIX64
	#elseif (not defined(__FB_64BIT__)) and (defined(__FB_WIN32__) or defined(__FB_CYGWIN__))
		FFI_STDCALL
	#endif

	#if (defined(__FB_DARWIN__) and defined(__FB_64BIT__)) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or ((not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__)))
		FFI_THISCALL
		FFI_FASTCALL
	#endif

	#if ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_DARWIN__)
		FFI_STDCALL
	#elseif (not defined(__FB_64BIT__)) and (defined(__FB_WIN32__) or defined(__FB_CYGWIN__))
		FFI_MS_CDECL
	#endif

	#if (defined(__FB_DARWIN__) and defined(__FB_64BIT__)) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or ((not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__)))
		FFI_PASCAL
		FFI_REGISTER
	#elseif (not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
		FFI_VFP
	#elseif defined(__FB_64BIT__) and (defined(__FB_WIN32__) or defined(__FB_CYGWIN__))
		FFI_WIN64
	#endif

	FFI_LAST_ABI

	#if ((not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))) or (defined(__FB_64BIT__) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))
		FFI_DEFAULT_ABI = FFI_SYSV
	#elseif defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
		FFI_DEFAULT_ABI = FFI_UNIX64
	#elseif (not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
		FFI_DEFAULT_ABI = FFI_VFP
	#else
		FFI_DEFAULT_ABI = FFI_WIN64
	#endif
end enum

#if (not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	#define FFI_TYPE_STRUCT_VFP_FLOAT (FFI_TYPE_LAST + 1)
	#define FFI_TYPE_STRUCT_VFP_DOUBLE (FFI_TYPE_LAST + 2)
	#define FFI_TARGET_SPECIFIC_VARIADIC
#endif

const FFI_CLOSURES = 1

#if ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	#define FFI_TYPE_SMALL_STRUCT_1B (FFI_TYPE_LAST + 1)
	#define FFI_TYPE_SMALL_STRUCT_2B (FFI_TYPE_LAST + 2)
	#define FFI_TYPE_SMALL_STRUCT_4B (FFI_TYPE_LAST + 3)
	#define FFI_TYPE_MS_STRUCT (FFI_TYPE_LAST + 4)
#endif

#ifndef __FB_64BIT__
	#if defined(__FB_DARWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))
		const FFI_TRAMPOLINE_SIZE = 10
	#elseif defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
		const FFI_TRAMPOLINE_SIZE = 52
	#endif
#endif

#if (not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
	const FFI_NATIVE_RAW_API = 1
#elseif defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
	const FFI_TRAMPOLINE_SIZE = 24
#elseif (not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	const FFI_TRAMPOLINE_SIZE = 20
#elseif defined(__FB_64BIT__) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	const FFI_TRAMPOLINE_SIZE = 36
#else
	const FFI_TRAMPOLINE_SIZE = 29
#endif

#if defined(__FB_64BIT__) or ((not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))
	const FFI_NATIVE_RAW_API = 0
#endif

#ifdef __FB_64BIT__
	#if defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
		const AARCH64_FFI_WITH_V_BIT = 0
		const AARCH64_N_XREG = 32
		const AARCH64_N_VREG = 32
		const AARCH64_CALL_CONTEXT_SIZE = (AARCH64_N_XREG * 8) + (AARCH64_N_VREG * 16)
	#elseif defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
		const FFI_NO_RAW_API = 1
	#endif
#endif

const FFI_64_BIT_MAX = 9223372036854775807
#define FFI_LONG_LONG_MAX LLONG_MAX

type _ffi_type
	size as uinteger
	alignment as ushort
	as ushort type
	elements as _ffi_type ptr ptr
end type

type ffi_type as _ffi_type
extern ffi_type_void as ffi_type
extern ffi_type_uint8 as ffi_type
extern ffi_type_uchar alias "ffi_type_uint8" as ffi_type
extern ffi_type_sint8 as ffi_type
extern ffi_type_schar alias "ffi_type_sint8" as ffi_type
extern ffi_type_uint16 as ffi_type
extern ffi_type_ushort alias "ffi_type_uint16" as ffi_type
extern ffi_type_sint16 as ffi_type
extern ffi_type_sshort alias "ffi_type_sint16" as ffi_type
extern ffi_type_uint32 as ffi_type
extern ffi_type_uint alias "ffi_type_uint32" as ffi_type

#if (defined(__FB_WIN32__) and defined(__FB_64BIT__)) or (not defined(__FB_64BIT__))
	extern ffi_type_ulong alias "ffi_type_uint32" as ffi_type
#endif

extern ffi_type_sint32 as ffi_type
extern ffi_type_sint alias "ffi_type_sint32" as ffi_type

#if (defined(__FB_WIN32__) and defined(__FB_64BIT__)) or (not defined(__FB_64BIT__))
	extern ffi_type_slong alias "ffi_type_sint32" as ffi_type
#endif

extern ffi_type_uint64 as ffi_type

#if defined(__FB_64BIT__) and defined(__FB_UNIX__)
	extern ffi_type_ulong alias "ffi_type_uint64" as ffi_type
#endif

extern ffi_type_sint64 as ffi_type

#if defined(__FB_64BIT__) and defined(__FB_UNIX__)
	extern ffi_type_slong alias "ffi_type_sint64" as ffi_type
#endif

extern ffi_type_float as ffi_type
extern ffi_type_double as ffi_type
extern ffi_type_pointer as ffi_type
extern ffi_type_longdouble as ffi_type

#if ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	extern ffi_type_complex_float as ffi_type
	extern ffi_type_complex_double as ffi_type
	extern ffi_type_complex_longdouble as ffi_type
#endif

type ffi_status as long
enum
	FFI_OK = 0
	FFI_BAD_TYPEDEF
	FFI_BAD_ABI
end enum

type FFI_TYPE_ as ulong

type ffi_cif
	abi as ffi_abi
	nargs as ulong
	arg_types as ffi_type ptr ptr
	rtype as ffi_type ptr
	bytes as ulong
	flags as ulong

	#if (not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
		vfp_used as long
		vfp_reg_free as short
		vfp_nargs as short
		vfp_args(0 to 15) as byte
	#elseif defined(__FB_64BIT__) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
		aarch64_flags as ulong
	#endif
end type

declare function ffi_prep_cif_core(byval cif as ffi_cif ptr, byval abi as ffi_abi, byval isvariadic as ulong, byval nfixedargs as ulong, byval ntotalargs as ulong, byval rtype as ffi_type ptr, byval atypes as ffi_type ptr ptr) as ffi_status

#ifndef __FB_64BIT__
	const FFI_SIZEOF_ARG = 4
#elseif defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	const FFI_SIZEOF_ARG = 8
#endif

const FFI_SIZEOF_JAVA_RAW = FFI_SIZEOF_ARG

union ffi_raw
	sint as ffi_sarg
	uint as ffi_arg
	flt as single
	data as zstring * FFI_SIZEOF_ARG
	ptr as any ptr
end union

type ffi_java_raw as ffi_raw
declare sub ffi_raw_call(byval cif as ffi_cif ptr, byval fn as sub(), byval rvalue as any ptr, byval avalue as ffi_raw ptr)
declare sub ffi_ptrarray_to_raw(byval cif as ffi_cif ptr, byval args as any ptr ptr, byval raw as ffi_raw ptr)
declare sub ffi_raw_to_ptrarray(byval cif as ffi_cif ptr, byval raw as ffi_raw ptr, byval args as any ptr ptr)
declare function ffi_raw_size(byval cif as ffi_cif ptr) as uinteger
declare sub ffi_java_raw_call(byval cif as ffi_cif ptr, byval fn as sub(), byval rvalue as any ptr, byval avalue as ffi_java_raw ptr)
declare sub ffi_java_ptrarray_to_raw(byval cif as ffi_cif ptr, byval args as any ptr ptr, byval raw as ffi_java_raw ptr)
declare sub ffi_java_raw_to_ptrarray(byval cif as ffi_cif ptr, byval raw as ffi_java_raw ptr, byval args as any ptr ptr)
declare function ffi_java_raw_size(byval cif as ffi_cif ptr) as uinteger

type ffi_closure
	tramp as zstring * FFI_TRAMPOLINE_SIZE
	cif as ffi_cif ptr
	fun as sub(byval as ffi_cif ptr, byval as any ptr, byval as any ptr ptr, byval as any ptr)
	user_data as any ptr
end type

declare function ffi_closure_alloc(byval size as uinteger, byval code as any ptr ptr) as any ptr
declare sub ffi_closure_free(byval as any ptr)
declare function ffi_prep_closure(byval as ffi_closure ptr, byval as ffi_cif ptr, byval fun as sub(byval as ffi_cif ptr, byval as any ptr, byval as any ptr ptr, byval as any ptr), byval user_data as any ptr) as ffi_status
declare function ffi_prep_closure_loc(byval as ffi_closure ptr, byval as ffi_cif ptr, byval fun as sub(byval as ffi_cif ptr, byval as any ptr, byval as any ptr ptr, byval as any ptr), byval user_data as any ptr, byval codeloc as any ptr) as ffi_status

type ffi_raw_closure
	tramp as zstring * FFI_TRAMPOLINE_SIZE
	cif as ffi_cif ptr

	#if defined(__FB_64BIT__) or ((not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))
		translate_args as sub(byval as ffi_cif ptr, byval as any ptr, byval as any ptr ptr, byval as any ptr)
		this_closure as any ptr
	#endif

	fun as sub(byval as ffi_cif ptr, byval as any ptr, byval as ffi_raw ptr, byval as any ptr)
	user_data as any ptr
end type

type ffi_java_raw_closure
	tramp as zstring * FFI_TRAMPOLINE_SIZE
	cif as ffi_cif ptr

	#if defined(__FB_64BIT__) or ((not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))
		translate_args as sub(byval as ffi_cif ptr, byval as any ptr, byval as any ptr ptr, byval as any ptr)
		this_closure as any ptr
	#endif

	fun as sub(byval as ffi_cif ptr, byval as any ptr, byval as ffi_java_raw ptr, byval as any ptr)
	user_data as any ptr
end type

declare function ffi_prep_raw_closure(byval as ffi_raw_closure ptr, byval cif as ffi_cif ptr, byval fun as sub(byval as ffi_cif ptr, byval as any ptr, byval as ffi_raw ptr, byval as any ptr), byval user_data as any ptr) as ffi_status
declare function ffi_prep_raw_closure_loc(byval as ffi_raw_closure ptr, byval cif as ffi_cif ptr, byval fun as sub(byval as ffi_cif ptr, byval as any ptr, byval as ffi_raw ptr, byval as any ptr), byval user_data as any ptr, byval codeloc as any ptr) as ffi_status
declare function ffi_prep_java_raw_closure(byval as ffi_java_raw_closure ptr, byval cif as ffi_cif ptr, byval fun as sub(byval as ffi_cif ptr, byval as any ptr, byval as ffi_java_raw ptr, byval as any ptr), byval user_data as any ptr) as ffi_status
declare function ffi_prep_java_raw_closure_loc(byval as ffi_java_raw_closure ptr, byval cif as ffi_cif ptr, byval fun as sub(byval as ffi_cif ptr, byval as any ptr, byval as ffi_java_raw ptr, byval as any ptr), byval user_data as any ptr, byval codeloc as any ptr) as ffi_status
declare function ffi_prep_cif(byval cif as ffi_cif ptr, byval abi as ffi_abi, byval nargs as ulong, byval rtype as ffi_type ptr, byval atypes as ffi_type ptr ptr) as ffi_status
declare function ffi_prep_cif_var(byval cif as ffi_cif ptr, byval abi as ffi_abi, byval nfixedargs as ulong, byval ntotalargs as ulong, byval rtype as ffi_type ptr, byval atypes as ffi_type ptr ptr) as ffi_status
declare sub ffi_call(byval cif as ffi_cif ptr, byval fn as sub(), byval rvalue as any ptr, byval avalue as any ptr ptr)

#define FFI_FN(f) cptr(sub cdecl(), f)
const FFI_TYPE_VOID_ = 0
const FFI_TYPE_INT = 1
const FFI_TYPE_FLOAT_ = 2
const FFI_TYPE_DOUBLE_ = 3
const FFI_TYPE_LONGDOUBLE_ = 4
const FFI_TYPE_UINT8_ = 5
const FFI_TYPE_SINT8_ = 6
const FFI_TYPE_UINT16_ = 7
const FFI_TYPE_SINT16_ = 8
const FFI_TYPE_UINT32_ = 9
const FFI_TYPE_SINT32_ = 10
const FFI_TYPE_UINT64_ = 11
const FFI_TYPE_SINT64_ = 12
const FFI_TYPE_STRUCT = 13
const FFI_TYPE_POINTER_ = 14
const FFI_TYPE_COMPLEX = 15
const FFI_TYPE_LAST = FFI_TYPE_COMPLEX

end extern
