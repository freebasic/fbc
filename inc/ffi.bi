'' FreeBASIC binding for libffi-3.1
''
'' based on the C header files:
''   -----------------------------------------------------------------*-C-*-
''   libffi 3.1 - Copyright (c) 2011 Anthony Green
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

#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
	#define X86_WIN64
#elseif defined(__FB_WIN32__) and (not defined(__FB_64BIT__))
	#define X86_WIN32
#else
	#define X86
#endif

#define LIBFFI_TARGET_H
#define X86_ANY

type ffi_arg as uinteger
type ffi_sarg as integer

#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
	const FFI_SIZEOF_ARG = 8
	const USE_BUILTIN_FFS = 0
#endif

type ffi_abi as long
enum
	FFI_FIRST_ABI = 0
	#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
		FFI_WIN64
		FFI_LAST_ABI
		FFI_DEFAULT_ABI = FFI_WIN64
	#elseif defined(__FB_WIN32__)
		FFI_SYSV
		FFI_STDCALL
		FFI_THISCALL
		FFI_FASTCALL
		FFI_MS_CDECL
		FFI_LAST_ABI
		FFI_DEFAULT_ABI = FFI_SYSV
	#else
		FFI_SYSV
		FFI_UNIX64
		FFI_THISCALL
		FFI_FASTCALL
		FFI_STDCALL
		FFI_LAST_ABI
		#ifdef __FB_64BIT__
			FFI_DEFAULT_ABI = FFI_UNIX64
		#else
			FFI_DEFAULT_ABI = FFI_SYSV
		#endif
	#endif
end enum

const FFI_CLOSURES = 1
#define FFI_TYPE_SMALL_STRUCT_1B (FFI_TYPE_LAST + 1)
#define FFI_TYPE_SMALL_STRUCT_2B (FFI_TYPE_LAST + 2)
#define FFI_TYPE_SMALL_STRUCT_4B (FFI_TYPE_LAST + 3)
#define FFI_TYPE_MS_STRUCT (FFI_TYPE_LAST + 4)

#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
	const FFI_TRAMPOLINE_SIZE = 29
	const FFI_NATIVE_RAW_API = 0
	const FFI_NO_RAW_API = 1
#elseif defined(__FB_WIN32__) and (not defined(__FB_64BIT__))
	const FFI_TRAMPOLINE_SIZE = 52
#else
	const FFI_TRAMPOLINE_SIZE = 10
#endif

#if (defined(__FB_LINUX__) and defined(__FB_64BIT__)) or (not defined(__FB_64BIT__))
	const FFI_NATIVE_RAW_API = 1
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
#define ffi_type_uchar ffi_type_uint8
#define ffi_type_schar ffi_type_sint8
#define ffi_type_ushort ffi_type_uint16
#define ffi_type_sshort ffi_type_sint16
#define ffi_type_uint ffi_type_uint32
#define ffi_type_sint ffi_type_sint32

#if (defined(__FB_LINUX__) and (not defined(__FB_64BIT__))) or defined(__FB_WIN32__)
	#define ffi_type_ulong ffi_type_uint32
	#define ffi_type_slong ffi_type_sint32
#else
	#define ffi_type_ulong ffi_type_uint64
	#define ffi_type_slong ffi_type_sint64
#endif

extern ffi_type_void as ffi_type
extern ffi_type_uint8 as ffi_type
extern ffi_type_sint8 as ffi_type
extern ffi_type_uint16 as ffi_type
extern ffi_type_sint16 as ffi_type
extern ffi_type_uint32 as ffi_type
extern ffi_type_sint32 as ffi_type
extern ffi_type_uint64 as ffi_type
extern ffi_type_sint64 as ffi_type
extern ffi_type_float as ffi_type
extern ffi_type_double as ffi_type
extern ffi_type_pointer as ffi_type
extern ffi_type_longdouble as ffi_type

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
end type

declare function ffi_prep_cif_core(byval cif as ffi_cif ptr, byval abi as ffi_abi, byval isvariadic as ulong, byval nfixedargs as ulong, byval ntotalargs as ulong, byval rtype as ffi_type ptr, byval atypes as ffi_type ptr ptr) as ffi_status

#ifndef __FB_64BIT__
	const FFI_SIZEOF_ARG = 4
#elseif defined(__FB_LINUX__) and defined(__FB_64BIT__)
	const FFI_SIZEOF_ARG = 8
#endif

#define FFI_SIZEOF_JAVA_RAW FFI_SIZEOF_ARG

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

	#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
		translate_args as sub(byval as ffi_cif ptr, byval as any ptr, byval as any ptr ptr, byval as any ptr)
		this_closure as any ptr
	#endif

	fun as sub(byval as ffi_cif ptr, byval as any ptr, byval as ffi_raw ptr, byval as any ptr)
	user_data as any ptr
end type

type ffi_java_raw_closure
	tramp as zstring * FFI_TRAMPOLINE_SIZE
	cif as ffi_cif ptr

	#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
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
#define FFI_TYPE_LAST FFI_TYPE_POINTER_

end extern
