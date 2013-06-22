''
''
'' ffi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
' -----------------------------------------------------------------*-C-*-
'  libffi 3.0.10 - Copyright (c) 2011 Anthony Green
'                   - Copyright (c) 1996-2003, 2007, 2008 Red Hat, Inc.
'
'  Permission is hereby granted, free of charge, to any person
'  obtaining a copy of this software and associated documentation
'  files (the ``Software''), to deal in the Software without
'  restriction, including without limitation the rights to use, copy,
'  modify, merge, publish, distribute, sublicense, and/or sell copies
'  of the Software, and to permit persons to whom the Software is
'  furnished to do so, subject to the following conditions:

'  The above copyright notice and this permission notice shall be
'  included in all copies or substantial portions of the Software.

'  THE SOFTWARE IS PROVIDED ``AS IS'', WITHOUT WARRANTY OF ANY KIND,
'  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
'  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
'  NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
'  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
'  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
'  DEALINGS IN THE SOFTWARE.
'  -----------------------------------------------------------------------

#ifndef __ffi_bi__
#define __ffi_bi__

#inclib "ffi"

#define X86_ANY

type ffi_arg as uinteger
type ffi_sarg as integer

#if defined( __FB_WIN32__ ) and defined( __FB_64BIT__ )
	#define FFI_SIZEOF_ARG 8
	#define USE_BUILTIN_FFS 0
#endif

enum ffi_abi
	FFI_FIRST_ABI = 0
	#if defined( __FB_WIN32__ ) and defined( __FB_64BIT__ )
		FFI_WIN64
		FFI_LAST_ABI
		FFI_DEFAULT_ABI = FFI_WIN64
	#elseif defined( __FB_WIN32__ )
		FFI_SYSV
		FFI_STDCALL
		FFI_LAST_ABI
		FFI_DEFAULT_ABI = FFI_SYSV
	#else
		FFI_SYSV
		FFI_UNIX64
		FFI_LAST_ABI
		#ifdef __FB_64BIT__
			FFI_DEFAULT_ABI = FFI_UNIX64
		#else
			FFI_DEFAULT_ABI = FFI_SYSV
		#endif
	#endif
end enum

#define FFI_CLOSURES 1
#define FFI_TYPE_SMALL_STRUCT_1B (FFI_TYPE_LAST + 1)
#define FFI_TYPE_SMALL_STRUCT_2B (FFI_TYPE_LAST + 2)
#define FFI_TYPE_SMALL_STRUCT_4B (FFI_TYPE_LAST + 3)

#ifdef __FB_64BIT__
	#ifdef __FB_WIN32__
		#define FFI_TRAMPOLINE_SIZE 29
		#define FFI_NATIVE_RAW_API 0
		#define FFI_NO_RAW_API 1
	#else
		#define FFI_TRAMPOLINE_SIZE 24
		#define FFI_NATIVE_RAW_API 0
	#endif
#else
	#ifdef __FB_WIN32__
		#define FFI_TRAMPOLINE_SIZE 13
		#define FFI_NATIVE_RAW_API 1
	#else
		#define FFI_TRAMPOLINE_SIZE 10
		#define FFI_NATIVE_RAW_API 1
	#endif
#endif

#include "crt/stddef.bi"
#include "crt/limits.bi"

' ---- System configuration information --------------------------------- 
#define FFI_64_BIT_MAX 9223372036854775807
#ifdef LONG_LONG_MAX
# define FFI_LONG_LONG_MAX LONG_LONG_MAX
#endif

type _ffi_type
	size as size_t
	alignment as ushort
	type as ushort
	elements as _ffi_type ptr ptr
end type

#ifndef LIBFFI_HIDE_BASIC_TYPES
#if SCHAR_MAX = 127
# define ffi_type_uchar                ffi_type_uint8
# define ffi_type_schar                ffi_type_sint8
#else
 #error "char size not supported"
#endif

#if SHRT_MAX = 32767
# define ffi_type_ushort       ffi_type_uint16
# define ffi_type_sshort       ffi_type_sint16
#elseif SHRT_MAX = 2147483647
# define ffi_type_ushort       ffi_type_uint32
# define ffi_type_sshort       ffi_type_sint32
#else
 #error "short size not supported"
#endif

#if INT_MAX = 32767
# define ffi_type_uint         ffi_type_uint16
# define ffi_type_sint         ffi_type_sint16
#elseif INT_MAX = 2147483647
# define ffi_type_uint         ffi_type_uint32
# define ffi_type_sint         ffi_type_sint32
#elseif INT_MAX = 9223372036854775807
# define ffi_type_uint         ffi_type_uint64
# define ffi_type_sint         ffi_type_sint64
#else
 #error "int size not supported"
#endif

#if LONG_MAX = 2147483647
# if FFI_LONG_LONG_MAX <> FFI_64_BIT_MAX
 #error "no 64-bit data type supported"
# endif
#elseif LONG_MAX <> FFI_64_BIT_MAX
 #error "long size not supported"
#endif

#if LONG_MAX = 2147483647
# define ffi_type_ulong        ffi_type_uint32
# define ffi_type_slong        ffi_type_sint32
#elseif LONG_MAX = FFI_64_BIT_MAX
# define ffi_type_ulong        ffi_type_uint64
# define ffi_type_slong        ffi_type_sint64
#else
 #error "long size not supported"
#endif

type ffi_type as _ffi_type
extern ffi_type_void alias "ffi_type_void" as ffi_type
extern ffi_type_uint8 alias "ffi_type_uint8" as ffi_type
extern ffi_type_sint8 alias "ffi_type_sint8" as ffi_type
extern ffi_type_uint16 alias "ffi_type_uint16" as ffi_type
extern ffi_type_sint16 alias "ffi_type_sint16" as ffi_type
extern ffi_type_uint32 alias "ffi_type_uint32" as ffi_type
extern ffi_type_sint32 alias "ffi_type_sint32" as ffi_type
extern ffi_type_uint64 alias "ffi_type_uint64" as ffi_type
extern ffi_type_sint64 alias "ffi_type_sint64" as ffi_type
extern ffi_type_float alias "ffi_type_float" as ffi_type
extern ffi_type_double alias "ffi_type_double" as ffi_type
extern ffi_type_pointer alias "ffi_type_pointer" as ffi_type
extern ffi_type_longdouble alias "ffi_type_longdouble" as ffi_type

#if 1
extern ffi_type_longdouble alias "ffi_type_longdouble" as ffi_type
#else
#define ffi_type_longdouble ffi_type_double
#endif

#endif ' LIBFFI_HIDE_BASIC_TYPES 

enum ffi_status
	FFI_OK = 0
	FFI_BAD_TYPEDEF
	FFI_BAD_ABI
end enum

type __FFI_TYPE as uinteger

type ffi_cif
	abi as ffi_abi
	nargs as uinteger
	arg_types as ffi_type ptr ptr
	rtype as ffi_type ptr
	bytes as uinteger
	flags as uinteger
end type

' ---- Definitions for the raw API -------------------------------------- 

#ifndef FFI_SIZEOF_ARG
# if LONG_MAX = 2147483647
#  define FFI_SIZEOF_ARG        4
# elseif LONG_MAX = FFI_64_BIT_MAX
#  define FFI_SIZEOF_ARG        8
# endif
#endif

#ifndef FFI_SIZEOF_JAVA_RAW
#  define FFI_SIZEOF_JAVA_RAW FFI_SIZEOF_ARG
#endif

union ffi_raw
	sint as ffi_sarg
	uint as ffi_arg
	flt as single
	data as zstring * FFI_SIZEOF_ARG
	ptr as any ptr
end union

#if FFI_SIZEOF_JAVA_RAW = 4 and FFI_SIZEOF_ARG = 8
' This is a special case for mips64/n32 ABI (and perhaps others) where
' sizeof(void *) is 4 and FFI_SIZEOF_ARG is 8.
union ffi_java_raw
    sint as integer
    uint as uinteger
    flt  as single
    data as zstring * FFI_SIZEOF_ARG
    ptr as any ptr    
end union
#else
type ffi_java_raw as ffi_raw
#endif

declare sub ffi_raw_call cdecl alias "ffi_raw_call" (byval cif as ffi_cif ptr, byval fn as sub cdecl(), byval rvalue as any ptr, byval avalue as ffi_raw ptr)
declare sub ffi_ptrarray_to_raw cdecl alias "ffi_ptrarray_to_raw" (byval cif as ffi_cif ptr, byval args as any ptr ptr, byval raw as ffi_raw ptr)
declare sub ffi_raw_to_ptrarray cdecl alias "ffi_raw_to_ptrarray" (byval cif as ffi_cif ptr, byval raw as ffi_raw ptr, byval args as any ptr ptr)
declare function ffi_raw_size cdecl alias "ffi_raw_size" (byval cif as ffi_cif ptr) as size_t
declare sub ffi_java_raw_call cdecl alias "ffi_java_raw_call" (byval cif as ffi_cif ptr, byval fn as sub cdecl(), byval rvalue as any ptr, byval avalue as ffi_java_raw ptr)
declare sub ffi_java_ptrarray_to_raw cdecl alias "ffi_java_ptrarray_to_raw" (byval cif as ffi_cif ptr, byval args as any ptr ptr, byval raw as ffi_java_raw ptr)
declare sub ffi_java_raw_to_ptrarray cdecl alias "ffi_java_raw_to_ptrarray" (byval cif as ffi_cif ptr, byval raw as ffi_java_raw ptr, byval args as any ptr ptr)
declare function ffi_java_raw_size cdecl alias "ffi_java_raw_size" (byval cif as ffi_cif ptr) as size_t

' ---- Definitions for closures ----------------------------------------- 
#if FFI_CLOSURES
type ffi_closure field=8
    tramp as zstring*FFI_TRAMPOLINE_SIZE-1
    cif as ffi_cif ptr
    fun as sub cdecl (byval as ffi_cif ptr, byval as any ptr, byval as any ptr ptr, byval as any ptr)
    user_data as any ptr
end type

declare function ffi_closure_alloc cdecl alias "ffi_closure_alloc" (byval size as size_t, byval code as any ptr ptr) as any ptr
declare sub ffi_closure_free cdecl alias "ffi_closure_free" (byval as any ptr)

' FB can't handle literal function ptr definitions in argument list
type closure_sub as sub cdecl(byval as ffi_cif ptr, byval as any ptr, byval as any ptr ptr, byval as any ptr)
type closure_raw as sub cdecl(byval as ffi_cif ptr, byval as any ptr, byval as ffi_raw ptr, byval as any ptr)
type closure_raw_java as sub cdecl(byval as ffi_cif ptr, byval as any ptr, byval as ffi_java_raw ptr, byval as any ptr)

declare function ffi_prep_closure cdecl alias "ffi_prep_closure" (byval as ffi_closure ptr, byval as ffi_cif ptr, byval as closure_sub, byval user_data as any ptr) as ffi_status

declare function ffi_prep_closure_loc cdecl alias "ffi_prep_closure_loc" (byval as ffi_closure ptr, byval as ffi_cif ptr, byval as closure_sub, byval user_data as any ptr, byval codeloc as any ptr) as ffi_status

type ffi_raw_closure field=8
    tramp as zstring*FFI_TRAMPOLINE_SIZE
    cif as ffi_cif ptr
#if not FFI_NATIVE_RAW_API
    ' if this is enabled, then a raw closure has the same layout 
    ' as a regular closure.  We use this to install an intermediate 
    ' handler to do the transaltion, any ptr ptr -> ffi_raw ptr. 
    translate_args as closure_sub
    this_closure as any ptr
#endif 
    fun as sub cdecl (byval as ffi_cif ptr, byval as any ptr, byval as ffi_raw ptr, byval as any ptr)
    user_data as any ptr
end type

type ffi_java_raw_closure
    tramp as zstring*FFI_TRAMPOLINE_SIZE
    cif as ffi_cif
#if not FFI_NATIVE_RAW_API
    ' if this is enabled, then a raw closure has the same layout 
    ' as a regular closure.  We use this to install an intermediate 
    ' handler to do the transaltion, void** -> ffi_raw*. */
    translate_args as closure_sub
    this_closure as any ptr
#endif 
    fun as sub cdecl ()
    user_data as any ptr
end type


declare function ffi_prep_raw_closure cdecl alias "ffi_prep_raw_closure" (byval as ffi_raw_closure ptr, byval cif as ffi_cif ptr, byval fun as closure_raw, byval user_data as any ptr) as ffi_status

declare function ffi_prep_raw_closure_loc cdecl alias "ffi_prep_raw_closure_loc" (byval as ffi_raw_closure ptr, byval cif as ffi_cif ptr, byval fun as closure_raw, byval user_data as any ptr, byval codeloc as any ptr) as ffi_status

declare function ffi_prep_java_raw_closure cdecl alias "ffi_prep_java_raw_closure" (byval as ffi_java_raw_closure ptr, byval cif as ffi_cif ptr, byval fun as closure_raw_java, byval user_data as any ptr) as ffi_status

declare function ffi_prep_java_raw_closure_loc cdecl alias "ffi_prep_java_raw_closure_loc" (byval as ffi_java_raw_closure ptr, byval cif as ffi_cif ptr, byval fun as closure_raw_java, byval user_data as any ptr, byval codeloc as any ptr) as ffi_status

#endif 'FFI CLOSURES

' ---- Public interface definition -------------------------------------- 
declare function ffi_prep_cif cdecl alias "ffi_prep_cif" (byval cif as ffi_cif ptr, byval abi as ffi_abi, byval nargs as uinteger, byval rtype as ffi_type ptr, byval atypes as ffi_type ptr ptr) as ffi_status
declare sub ffi_call cdecl alias "ffi_call" (byval cif as ffi_cif ptr, byval fn as sub cdecl(), byval rvalue as any ptr, byval avalue as any ptr ptr)

' Useful for eliminating compiler warnings 
#define FFI_FN(f) (cptr(sub cdecl(), f))

#define _FFI_TYPE_VOID 0
#define _FFI_TYPE_INT 1
#define _FFI_TYPE_FLOAT 2
#define _FFI_TYPE_DOUBLE 3
#define _FFI_TYPE_LONGDOUBLE 4
#define _FFI_TYPE_UINT8 5
#define _FFI_TYPE_SINT8 6
#define _FFI_TYPE_UINT16 7
#define _FFI_TYPE_SINT16 8
#define _FFI_TYPE_UINT32 9
#define _FFI_TYPE_SINT32 10
#define _FFI_TYPE_UINT64 11
#define _FFI_TYPE_SINT64 12
#define _FFI_TYPE_STRUCT 13
#define _FFI_TYPE_POINTER 14
#define FFI_TYPE_LAST FFI_TYPE_POINTER

#endif
