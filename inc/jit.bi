'' FreeBASIC binding for libjit-0.1.4
''
'' based on the C header files:
''   Copyright (C) 2004  Southern Storm Software, Pty Ltd.
''
''   The libjit library is free software: you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public License
''   as published by the Free Software Foundation, either version 2.1 of
''   the License, or (at your option) any later version.
''
''   The libjit library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with the libjit library.  If not, see
''   <http://www.gnu.org/licenses/>.
''
'' translated to FreeBASIC by:
''   Copyright © 2021 FreeBASIC development team

#pragma once

#inclib "jit"

#include once "crt/stdio.bi"
#include once "crt/longdouble.bi"

'' The following symbols have been renamed:
''     constant JIT_TYPE_VOID => JIT_TYPE_VOID_
''     constant JIT_TYPE_SBYTE => JIT_TYPE_SBYTE_
''     constant JIT_TYPE_UBYTE => JIT_TYPE_UBYTE_
''     constant JIT_TYPE_SHORT => JIT_TYPE_SHORT_
''     constant JIT_TYPE_USHORT => JIT_TYPE_USHORT_
''     constant JIT_TYPE_INT => JIT_TYPE_INT_
''     constant JIT_TYPE_UINT => JIT_TYPE_UINT_
''     constant JIT_TYPE_NINT => JIT_TYPE_NINT_
''     constant JIT_TYPE_NUINT => JIT_TYPE_NUINT_
''     constant JIT_TYPE_LONG => JIT_TYPE_LONG_
''     constant JIT_TYPE_ULONG => JIT_TYPE_ULONG_
''     constant JIT_TYPE_FLOAT32 => JIT_TYPE_FLOAT32_
''     constant JIT_TYPE_FLOAT64 => JIT_TYPE_FLOAT64_
''     constant JIT_TYPE_NFLOAT => JIT_TYPE_NFLOAT_

extern "C"

#define _JIT_H
#define _JIT_DEFS_H
type jit_sbyte as byte
type jit_ubyte as ubyte
type jit_short as short
type jit_ushort as ushort
type jit_int as long
type jit_uint as ulong
type jit_nint as integer
type jit_nuint as uinteger
type jit_long as longint
type jit_ulong as ulongint
type jit_float32 as single
type jit_float64 as double
#ifdef __FB_WIN32__
	type jit_nfloat as double
#else
	type jit_nfloat as clongdouble
#endif
type jit_ptr as any ptr

#define JIT_NOTHROW
#define jit_min_int clng(cast(jit_int, 1) shl ((sizeof(jit_int) * 8) - 1))
#define jit_max_int cast(jit_int, not jit_min_int)
const jit_max_uint = cast(jit_uint, not cast(jit_uint, 0))
#define jit_min_long (cast(jit_long, 1) shl ((sizeof(jit_long) * 8) - 1))
#define jit_max_long cast(jit_long, not jit_min_long)
const jit_max_ulong = cast(jit_ulong, not cast(jit_ulong, 0))
#define _JIT_COMMON_H

type jit_context_t as _jit_context ptr
type jit_function_t as _jit_function ptr
type jit_block_t as _jit_block ptr
type jit_insn_t as _jit_insn ptr
type jit_value_t as _jit_value ptr
type jit_type_t as _jit_type ptr
type jit_stack_trace_t as jit_stack_trace ptr
type jit_label_t as jit_nuint
const jit_label_undefined = cast(jit_label_t, culng(not cast(jit_uint, 0)))
const JIT_NO_OFFSET = culng(not culng(0))
type jit_meta_free_func as sub(byval data as any ptr)
type jit_on_demand_func as function(byval func as jit_function_t) as long
type jit_on_demand_driver_func as function(byval func as jit_function_t) as any ptr

#define _JIT_CONTEXT_H
#define _JIT_MEMORY_H
const JIT_MEMORY_OK = 0
const JIT_MEMORY_RESTART = 1
const JIT_MEMORY_TOO_BIG = 2
const JIT_MEMORY_ERROR = 3

type jit_size_t as ulong
type jit_memory_context_t as any ptr
type jit_function_info_t as any ptr
type jit_memory_manager_t as const jit_memory_manager ptr

type jit_memory_manager
	create as function(byval context as jit_context_t) as jit_memory_context_t
	destroy as sub(byval memctx as jit_memory_context_t)
	find_function_info as function(byval memctx as jit_memory_context_t, byval pc as any ptr) as jit_function_info_t
	get_function as function(byval memctx as jit_memory_context_t, byval info as jit_function_info_t) as jit_function_t
	get_function_start as function(byval memctx as jit_memory_context_t, byval info as jit_function_info_t) as any ptr
	get_function_end as function(byval memctx as jit_memory_context_t, byval info as jit_function_info_t) as any ptr
	alloc_function as function(byval memctx as jit_memory_context_t) as jit_function_t
	free_function as sub(byval memctx as jit_memory_context_t, byval func as jit_function_t)
	start_function as function(byval memctx as jit_memory_context_t, byval func as jit_function_t) as long
	end_function as function(byval memctx as jit_memory_context_t, byval result as long) as long
	extend_limit as function(byval memctx as jit_memory_context_t, byval count as long) as long
	get_limit as function(byval memctx as jit_memory_context_t) as any ptr
	get_break as function(byval memctx as jit_memory_context_t) as any ptr
	set_break as sub(byval memctx as jit_memory_context_t, byval brk as any ptr)
	alloc_trampoline as function(byval memctx as jit_memory_context_t) as any ptr
	free_trampoline as sub(byval memctx as jit_memory_context_t, byval ptr as any ptr)
	alloc_closure as function(byval memctx as jit_memory_context_t) as any ptr
	free_closure as sub(byval memctx as jit_memory_context_t, byval ptr as any ptr)
	alloc_data as function(byval memctx as jit_memory_context_t, byval size as jit_size_t, byval align as jit_size_t) as any ptr
end type

declare function jit_default_memory_manager() as jit_memory_manager_t
declare function jit_context_create() as jit_context_t
declare sub jit_context_destroy(byval context as jit_context_t)
declare sub jit_context_build_start(byval context as jit_context_t)
declare sub jit_context_build_end(byval context as jit_context_t)
declare sub jit_context_set_on_demand_driver(byval context as jit_context_t, byval driver as jit_on_demand_driver_func)
declare sub jit_context_set_memory_manager(byval context as jit_context_t, byval manager as jit_memory_manager_t)
declare function jit_context_set_meta(byval context as jit_context_t, byval type as long, byval data as any ptr, byval free_data as jit_meta_free_func) as long
declare function jit_context_set_meta_numeric(byval context as jit_context_t, byval type as long, byval data as jit_nuint) as long
declare function jit_context_get_meta(byval context as jit_context_t, byval type as long) as any ptr
declare function jit_context_get_meta_numeric(byval context as jit_context_t, byval type as long) as jit_nuint
declare sub jit_context_free_meta(byval context as jit_context_t, byval type as long)

const JIT_OPTION_CACHE_LIMIT = 10000
const JIT_OPTION_CACHE_PAGE_SIZE = 10001
const JIT_OPTION_PRE_COMPILE = 10002
const JIT_OPTION_DONT_FOLD = 10003
const JIT_OPTION_POSITION_INDEPENDENT = 10004
const JIT_OPTION_CACHE_MAX_PAGE_FACTOR = 10005
#define _JIT_APPLY_H
#define _JIT_TYPE_H

extern jit_type_void as const jit_type_t
extern jit_type_sbyte as const jit_type_t
extern jit_type_ubyte as const jit_type_t
extern jit_type_short as const jit_type_t
extern jit_type_ushort as const jit_type_t
extern jit_type_int as const jit_type_t
extern jit_type_uint as const jit_type_t
extern jit_type_nint as const jit_type_t
extern jit_type_nuint as const jit_type_t
extern jit_type_long as const jit_type_t
extern jit_type_ulong as const jit_type_t
extern jit_type_float32 as const jit_type_t
extern jit_type_float64 as const jit_type_t
extern jit_type_nfloat as const jit_type_t
extern jit_type_void_ptr as const jit_type_t
extern jit_type_sys_bool as const jit_type_t
extern jit_type_sys_char as const jit_type_t
extern jit_type_sys_schar as const jit_type_t
extern jit_type_sys_uchar as const jit_type_t
extern jit_type_sys_short as const jit_type_t
extern jit_type_sys_ushort as const jit_type_t
extern jit_type_sys_int as const jit_type_t
extern jit_type_sys_uint as const jit_type_t
extern jit_type_sys_long as const jit_type_t
extern jit_type_sys_ulong as const jit_type_t
extern jit_type_sys_longlong as const jit_type_t
extern jit_type_sys_ulonglong as const jit_type_t
extern jit_type_sys_float as const jit_type_t
extern jit_type_sys_double as const jit_type_t
extern jit_type_sys_long_double as const jit_type_t

const JIT_TYPE_INVALID = -1
const JIT_TYPE_VOID_ = 0
const JIT_TYPE_SBYTE_ = 1
const JIT_TYPE_UBYTE_ = 2
const JIT_TYPE_SHORT_ = 3
const JIT_TYPE_USHORT_ = 4
const JIT_TYPE_INT_ = 5
const JIT_TYPE_UINT_ = 6
const JIT_TYPE_NINT_ = 7
const JIT_TYPE_NUINT_ = 8
const JIT_TYPE_LONG_ = 9
const JIT_TYPE_ULONG_ = 10
const JIT_TYPE_FLOAT32_ = 11
const JIT_TYPE_FLOAT64_ = 12
const JIT_TYPE_NFLOAT_ = 13
const JIT_TYPE_MAX_PRIMITIVE = JIT_TYPE_NFLOAT_
const JIT_TYPE_STRUCT = 14
const JIT_TYPE_UNION = 15
const JIT_TYPE_SIGNATURE = 16
const JIT_TYPE_PTR = 17
const JIT_TYPE_FIRST_TAGGED = 32
const JIT_TYPETAG_NAME = 10000
const JIT_TYPETAG_STRUCT_NAME = 10001
const JIT_TYPETAG_UNION_NAME = 10002
const JIT_TYPETAG_ENUM_NAME = 10003
const JIT_TYPETAG_CONST = 10004
const JIT_TYPETAG_VOLATILE = 10005
const JIT_TYPETAG_REFERENCE = 10006
const JIT_TYPETAG_OUTPUT = 10007
const JIT_TYPETAG_RESTRICT = 10008
const JIT_TYPETAG_SYS_BOOL = 10009
const JIT_TYPETAG_SYS_CHAR = 10010
const JIT_TYPETAG_SYS_SCHAR = 10011
const JIT_TYPETAG_SYS_UCHAR = 10012
const JIT_TYPETAG_SYS_SHORT = 10013
const JIT_TYPETAG_SYS_USHORT = 10014
const JIT_TYPETAG_SYS_INT = 10015
const JIT_TYPETAG_SYS_UINT = 10016
const JIT_TYPETAG_SYS_LONG = 10017
const JIT_TYPETAG_SYS_ULONG = 10018
const JIT_TYPETAG_SYS_LONGLONG = 10019
const JIT_TYPETAG_SYS_ULONGLONG = 10020
const JIT_TYPETAG_SYS_FLOAT = 10021
const JIT_TYPETAG_SYS_DOUBLE = 10022
const JIT_TYPETAG_SYS_LONGDOUBLE = 10023

type jit_abi_t as long
enum
	jit_abi_cdecl
	jit_abi_vararg
	jit_abi_stdcall
	jit_abi_fastcall
end enum

const JIT_INVALID_NAME = culng(not culng(0))
declare function jit_type_copy(byval type as jit_type_t) as jit_type_t
declare sub jit_type_free(byval type as jit_type_t)
declare function jit_type_create_struct(byval fields as jit_type_t ptr, byval num_fields as ulong, byval incref as long) as jit_type_t
declare function jit_type_create_union(byval fields as jit_type_t ptr, byval num_fields as ulong, byval incref as long) as jit_type_t
declare function jit_type_create_signature(byval abi as jit_abi_t, byval return_type as jit_type_t, byval params as jit_type_t ptr, byval num_params as ulong, byval incref as long) as jit_type_t
declare function jit_type_create_pointer(byval type as jit_type_t, byval incref as long) as jit_type_t
declare function jit_type_create_tagged(byval type as jit_type_t, byval kind as long, byval data as any ptr, byval free_func as jit_meta_free_func, byval incref as long) as jit_type_t
declare function jit_type_set_names(byval type as jit_type_t, byval names as zstring ptr ptr, byval num_names as ulong) as long
declare sub jit_type_set_size_and_alignment(byval type as jit_type_t, byval size as jit_nint, byval alignment as jit_nint)
declare sub jit_type_set_offset(byval type as jit_type_t, byval field_index as ulong, byval offset as jit_nuint)
declare function jit_type_get_kind(byval type as jit_type_t) as long
declare function jit_type_get_size(byval type as jit_type_t) as jit_nuint
declare function jit_type_get_alignment(byval type as jit_type_t) as jit_nuint
declare function jit_type_best_alignment() as jit_nuint
declare function jit_type_num_fields(byval type as jit_type_t) as ulong
declare function jit_type_get_field(byval type as jit_type_t, byval field_index as ulong) as jit_type_t
declare function jit_type_get_offset(byval type as jit_type_t, byval field_index as ulong) as jit_nuint
declare function jit_type_get_name(byval type as jit_type_t, byval index as ulong) as const zstring ptr
declare function jit_type_find_name(byval type as jit_type_t, byval name as const zstring ptr) as ulong
declare function jit_type_num_params(byval type as jit_type_t) as ulong
declare function jit_type_get_return(byval type as jit_type_t) as jit_type_t
declare function jit_type_get_param(byval type as jit_type_t, byval param_index as ulong) as jit_type_t
declare function jit_type_get_abi(byval type as jit_type_t) as jit_abi_t
declare function jit_type_get_ref(byval type as jit_type_t) as jit_type_t
declare function jit_type_get_tagged_type(byval type as jit_type_t) as jit_type_t
declare sub jit_type_set_tagged_type(byval type as jit_type_t, byval underlying as jit_type_t, byval incref as long)
declare function jit_type_get_tagged_kind(byval type as jit_type_t) as long
declare function jit_type_get_tagged_data(byval type as jit_type_t) as any ptr
declare sub jit_type_set_tagged_data(byval type as jit_type_t, byval data as any ptr, byval free_func as jit_meta_free_func)
declare function jit_type_is_primitive(byval type as jit_type_t) as long
declare function jit_type_is_struct(byval type as jit_type_t) as long
declare function jit_type_is_union(byval type as jit_type_t) as long
declare function jit_type_is_signature(byval type as jit_type_t) as long
declare function jit_type_is_pointer(byval type as jit_type_t) as long
declare function jit_type_is_tagged(byval type as jit_type_t) as long
declare function jit_type_remove_tags(byval type as jit_type_t) as jit_type_t
declare function jit_type_normalize(byval type as jit_type_t) as jit_type_t
declare function jit_type_promote_int(byval type as jit_type_t) as jit_type_t
declare function jit_type_return_via_pointer(byval type as jit_type_t) as long
declare function jit_type_has_tag(byval type as jit_type_t, byval kind as long) as long
type jit_closure_func as sub(byval signature as jit_type_t, byval result as any ptr, byval args as any ptr ptr, byval user_data as any ptr)
type jit_closure_va_list_t as jit_closure_va_list ptr
declare sub jit_apply(byval signature as jit_type_t, byval func as any ptr, byval args as any ptr ptr, byval num_fixed_args as ulong, byval return_value as any ptr)
declare sub jit_apply_raw(byval signature as jit_type_t, byval func as any ptr, byval args as any ptr, byval return_value as any ptr)
declare function jit_raw_supported(byval signature as jit_type_t) as long
declare function jit_closure_create(byval context as jit_context_t, byval signature as jit_type_t, byval func as jit_closure_func, byval user_data as any ptr) as any ptr
declare function jit_closure_va_get_nint(byval va as jit_closure_va_list_t) as jit_nint
declare function jit_closure_va_get_nuint(byval va as jit_closure_va_list_t) as jit_nuint
declare function jit_closure_va_get_long(byval va as jit_closure_va_list_t) as jit_long
declare function jit_closure_va_get_ulong(byval va as jit_closure_va_list_t) as jit_ulong
declare function jit_closure_va_get_float32(byval va as jit_closure_va_list_t) as jit_float32
declare function jit_closure_va_get_float64(byval va as jit_closure_va_list_t) as jit_float64
declare function jit_closure_va_get_nfloat(byval va as jit_closure_va_list_t) as jit_nfloat
declare function jit_closure_va_get_ptr(byval va as jit_closure_va_list_t) as any ptr
declare sub jit_closure_va_get_struct(byval va as jit_closure_va_list_t, byval buf as any ptr, byval type as jit_type_t)
#define _JIT_BLOCK_H
declare function jit_block_get_function(byval block as jit_block_t) as jit_function_t
declare function jit_block_get_context(byval block as jit_block_t) as jit_context_t
declare function jit_block_get_label(byval block as jit_block_t) as jit_label_t
declare function jit_block_get_next_label(byval block as jit_block_t, byval label as jit_label_t) as jit_label_t
declare function jit_block_next(byval func as jit_function_t, byval previous as jit_block_t) as jit_block_t
declare function jit_block_previous(byval func as jit_function_t, byval previous as jit_block_t) as jit_block_t
declare function jit_block_from_label(byval func as jit_function_t, byval label as jit_label_t) as jit_block_t
declare function jit_block_set_meta(byval block as jit_block_t, byval type as long, byval data as any ptr, byval free_data as jit_meta_free_func) as long
declare function jit_block_get_meta(byval block as jit_block_t, byval type as long) as any ptr
declare sub jit_block_free_meta(byval block as jit_block_t, byval type as long)
declare function jit_block_is_reachable(byval block as jit_block_t) as long
declare function jit_block_ends_in_dead(byval block as jit_block_t) as long
declare function jit_block_current_is_dead(byval func as jit_function_t) as long
#define _JIT_DEBUGGER_H

type jit_debugger_t as jit_debugger ptr
type jit_debugger_thread_id_t as jit_nint
type jit_debugger_breakpoint_id_t as jit_nint

type jit_debugger_event
	as long type
	thread as jit_debugger_thread_id_t
	function as jit_function_t
	data1 as jit_nint
	data2 as jit_nint
	id as jit_debugger_breakpoint_id_t
	trace as jit_stack_trace_t
end type

type jit_debugger_event_t as jit_debugger_event
const JIT_DEBUGGER_TYPE_QUIT = 0
const JIT_DEBUGGER_TYPE_HARD_BREAKPOINT = 1
const JIT_DEBUGGER_TYPE_SOFT_BREAKPOINT = 2
const JIT_DEBUGGER_TYPE_USER_BREAKPOINT = 3
const JIT_DEBUGGER_TYPE_ATTACH_THREAD = 4
const JIT_DEBUGGER_TYPE_DETACH_THREAD = 5

type jit_debugger_breakpoint_info
	flags as long
	thread as jit_debugger_thread_id_t
	function as jit_function_t
	data1 as jit_nint
	data2 as jit_nint
end type

type jit_debugger_breakpoint_info_t as jit_debugger_breakpoint_info ptr
const JIT_DEBUGGER_FLAG_THREAD = 1 shl 0
const JIT_DEBUGGER_FLAG_FUNCTION = 1 shl 1
const JIT_DEBUGGER_FLAG_DATA1 = 1 shl 2
const JIT_DEBUGGER_FLAG_DATA2 = 1 shl 3
const JIT_DEBUGGER_DATA1_FIRST = 10000
const JIT_DEBUGGER_DATA1_LINE = 10000
const JIT_DEBUGGER_DATA1_ENTER = 10001
const JIT_DEBUGGER_DATA1_LEAVE = 10002
const JIT_DEBUGGER_DATA1_THROW = 10003
type jit_debugger_hook_func as sub(byval func as jit_function_t, byval data1 as jit_nint, byval data2 as jit_nint)

declare function jit_debugging_possible() as long
declare function jit_debugger_create(byval context as jit_context_t) as jit_debugger_t
declare sub jit_debugger_destroy(byval dbg as jit_debugger_t)
declare function jit_debugger_get_context(byval dbg as jit_debugger_t) as jit_context_t
declare function jit_debugger_from_context(byval context as jit_context_t) as jit_debugger_t
declare function jit_debugger_get_self(byval dbg as jit_debugger_t) as jit_debugger_thread_id_t
declare function jit_debugger_get_thread(byval dbg as jit_debugger_t, byval native_thread as const any ptr) as jit_debugger_thread_id_t
declare function jit_debugger_get_native_thread(byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t, byval native_thread as any ptr) as long
declare sub jit_debugger_set_breakable(byval dbg as jit_debugger_t, byval native_thread as const any ptr, byval flag as long)
declare sub jit_debugger_attach_self(byval dbg as jit_debugger_t, byval stop_immediately as long)
declare sub jit_debugger_detach_self(byval dbg as jit_debugger_t)
declare function jit_debugger_wait_event(byval dbg as jit_debugger_t, byval event as jit_debugger_event_t ptr, byval timeout as jit_int) as long
declare function jit_debugger_add_breakpoint(byval dbg as jit_debugger_t, byval info as jit_debugger_breakpoint_info_t) as jit_debugger_breakpoint_id_t
declare sub jit_debugger_remove_breakpoint(byval dbg as jit_debugger_t, byval id as jit_debugger_breakpoint_id_t)
declare sub jit_debugger_remove_all_breakpoints(byval dbg as jit_debugger_t)
declare function jit_debugger_is_alive(byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t) as long
declare function jit_debugger_is_running(byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t) as long
declare sub jit_debugger_run(byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t)
declare sub jit_debugger_step(byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t)
declare sub jit_debugger_next(byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t)
declare sub jit_debugger_finish(byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t)
declare sub jit_debugger_break(byval dbg as jit_debugger_t)
declare sub jit_debugger_quit(byval dbg as jit_debugger_t)
declare function jit_debugger_set_hook(byval context as jit_context_t, byval hook as jit_debugger_hook_func) as jit_debugger_hook_func
#define _JIT_ELF_H
type jit_readelf_t as jit_readelf ptr
type jit_writeelf_t as jit_writeelf ptr

const JIT_READELF_FLAG_FORCE = 1 shl 0
const JIT_READELF_FLAG_DEBUG = 1 shl 1
const JIT_READELF_OK = 0
const JIT_READELF_CANNOT_OPEN = 1
const JIT_READELF_NOT_ELF = 2
const JIT_READELF_WRONG_ARCH = 3
const JIT_READELF_BAD_FORMAT = 4
const JIT_READELF_MEMORY = 5

declare function jit_readelf_open(byval readelf as jit_readelf_t ptr, byval filename as const zstring ptr, byval flags as long) as long
declare sub jit_readelf_close(byval readelf as jit_readelf_t)
declare function jit_readelf_get_name(byval readelf as jit_readelf_t) as const zstring ptr
declare function jit_readelf_get_symbol(byval readelf as jit_readelf_t, byval name as const zstring ptr) as any ptr
declare function jit_readelf_get_section(byval readelf as jit_readelf_t, byval name as const zstring ptr, byval size as jit_nuint ptr) as any ptr
declare function jit_readelf_get_section_by_type(byval readelf as jit_readelf_t, byval type as jit_int, byval size as jit_nuint ptr) as any ptr
declare function jit_readelf_map_vaddr(byval readelf as jit_readelf_t, byval vaddr as jit_nuint) as any ptr
declare function jit_readelf_num_needed(byval readelf as jit_readelf_t) as ulong
declare function jit_readelf_get_needed(byval readelf as jit_readelf_t, byval index as ulong) as const zstring ptr
declare sub jit_readelf_add_to_context(byval readelf as jit_readelf_t, byval context as jit_context_t)
declare function jit_readelf_resolve_all(byval context as jit_context_t, byval print_failures as long) as long
declare function jit_readelf_register_symbol(byval context as jit_context_t, byval name as const zstring ptr, byval value as any ptr, byval after as long) as long
declare function jit_writeelf_create(byval library_name as const zstring ptr) as jit_writeelf_t
declare sub jit_writeelf_destroy(byval writeelf as jit_writeelf_t)
declare function jit_writeelf_write(byval writeelf as jit_writeelf_t, byval filename as const zstring ptr) as long
declare function jit_writeelf_add_function(byval writeelf as jit_writeelf_t, byval func as jit_function_t, byval name as const zstring ptr) as long
declare function jit_writeelf_add_needed(byval writeelf as jit_writeelf_t, byval library_name as const zstring ptr) as long
declare function jit_writeelf_write_section(byval writeelf as jit_writeelf_t, byval name as const zstring ptr, byval type as jit_int, byval buf as const any ptr, byval len as ulong, byval discardable as long) as long

#define _JIT_EXCEPT_H
const JIT_RESULT_OK = 1
const JIT_RESULT_OVERFLOW = 0
const JIT_RESULT_ARITHMETIC = -1
const JIT_RESULT_DIVISION_BY_ZERO = -2
const JIT_RESULT_COMPILE_ERROR = -3
const JIT_RESULT_OUT_OF_MEMORY = -4
const JIT_RESULT_NULL_REFERENCE = -5
const JIT_RESULT_NULL_FUNCTION = -6
const JIT_RESULT_CALLED_NESTED = -7
const JIT_RESULT_OUT_OF_BOUNDS = -8
const JIT_RESULT_UNDEFINED_LABEL = -9
const JIT_RESULT_MEMORY_FULL = -10000
type jit_exception_func as function(byval exception_type as long) as any ptr

declare function jit_exception_get_last() as any ptr
declare function jit_exception_get_last_and_clear() as any ptr
declare sub jit_exception_set_last(byval object as any ptr)
declare sub jit_exception_clear_last()
declare sub jit_exception_throw(byval object as any ptr)
declare sub jit_exception_builtin(byval exception_type as long)
declare function jit_exception_set_handler(byval handler as jit_exception_func) as jit_exception_func
declare function jit_exception_get_handler() as jit_exception_func
declare function jit_exception_get_stack_trace() as jit_stack_trace_t
declare function jit_stack_trace_get_size(byval trace as jit_stack_trace_t) as ulong
declare function jit_stack_trace_get_function(byval context as jit_context_t, byval trace as jit_stack_trace_t, byval posn as ulong) as jit_function_t
declare function jit_stack_trace_get_pc(byval trace as jit_stack_trace_t, byval posn as ulong) as any ptr
declare function jit_stack_trace_get_offset(byval context as jit_context_t, byval trace as jit_stack_trace_t, byval posn as ulong) as ulong
declare sub jit_stack_trace_free(byval trace as jit_stack_trace_t)

#define _JIT_FUNCTION_H
const JIT_OPTLEVEL_NONE = 0
const JIT_OPTLEVEL_NORMAL = 1

declare function jit_function_create(byval context as jit_context_t, byval signature as jit_type_t) as jit_function_t
declare function jit_function_create_nested(byval context as jit_context_t, byval signature as jit_type_t, byval parent as jit_function_t) as jit_function_t
declare sub jit_function_abandon(byval func as jit_function_t)
declare function jit_function_get_context(byval func as jit_function_t) as jit_context_t
declare function jit_function_get_signature(byval func as jit_function_t) as jit_type_t
declare function jit_function_set_meta(byval func as jit_function_t, byval type as long, byval data as any ptr, byval free_data as jit_meta_free_func, byval build_only as long) as long
declare function jit_function_get_meta(byval func as jit_function_t, byval type as long) as any ptr
declare sub jit_function_free_meta(byval func as jit_function_t, byval type as long)
declare function jit_function_next(byval context as jit_context_t, byval prev as jit_function_t) as jit_function_t
declare function jit_function_previous(byval context as jit_context_t, byval prev as jit_function_t) as jit_function_t
declare function jit_function_get_entry(byval func as jit_function_t) as jit_block_t
declare function jit_function_get_current(byval func as jit_function_t) as jit_block_t
declare function jit_function_get_nested_parent(byval func as jit_function_t) as jit_function_t
declare function jit_function_compile(byval func as jit_function_t) as long
declare function jit_function_is_compiled(byval func as jit_function_t) as long
declare sub jit_function_set_recompilable(byval func as jit_function_t)
declare sub jit_function_clear_recompilable(byval func as jit_function_t)
declare function jit_function_is_recompilable(byval func as jit_function_t) as long
declare function jit_function_compile_entry(byval func as jit_function_t, byval entry_point as any ptr ptr) as long
declare sub jit_function_setup_entry(byval func as jit_function_t, byval entry_point as any ptr)
declare function jit_function_to_closure(byval func as jit_function_t) as any ptr
declare function jit_function_from_closure(byval context as jit_context_t, byval closure as any ptr) as jit_function_t
declare function jit_function_from_pc(byval context as jit_context_t, byval pc as any ptr, byval handler as any ptr ptr) as jit_function_t
declare function jit_function_to_vtable_pointer(byval func as jit_function_t) as any ptr
declare function jit_function_from_vtable_pointer(byval context as jit_context_t, byval vtable_pointer as any ptr) as jit_function_t
declare sub jit_function_set_on_demand_compiler(byval func as jit_function_t, byval on_demand as jit_on_demand_func)
declare function jit_function_get_on_demand_compiler(byval func as jit_function_t) as jit_on_demand_func
declare function jit_function_apply(byval func as jit_function_t, byval args as any ptr ptr, byval return_area as any ptr) as long
declare function jit_function_apply_vararg(byval func as jit_function_t, byval signature as jit_type_t, byval args as any ptr ptr, byval return_area as any ptr) as long
declare sub jit_function_set_optimization_level(byval func as jit_function_t, byval level as ulong)
declare function jit_function_get_optimization_level(byval func as jit_function_t) as ulong
declare function jit_function_get_max_optimization_level() as ulong
declare function jit_function_reserve_label(byval func as jit_function_t) as jit_label_t
declare function jit_function_labels_equal(byval func as jit_function_t, byval label as jit_label_t, byval label2 as jit_label_t) as long
#define _JIT_INIT_H
declare sub jit_init()
declare function jit_uses_interpreter() as long
declare function jit_supports_threads() as long
declare function jit_supports_virtual_memory() as long
declare function jit_supports_closures() as long
declare function jit_get_closure_size() as ulong
declare function jit_get_closure_alignment() as ulong
declare function jit_get_trampoline_size() as ulong
declare function jit_get_trampoline_alignment() as ulong
#define _JIT_INSN_H

type jit_intrinsic_descr_t
	return_type as jit_type_t
	ptr_result_type as jit_type_t
	arg1_type as jit_type_t
	arg2_type as jit_type_t
end type

type jit_insn_iter_t
	block as jit_block_t
	posn as long
end type

const JIT_CALL_NOTHROW = 1 shl 0
const JIT_CALL_NORETURN = 1 shl 1
const JIT_CALL_TAIL = 1 shl 2

declare function jit_insn_get_opcode(byval insn as jit_insn_t) as long
declare function jit_insn_get_dest(byval insn as jit_insn_t) as jit_value_t
declare function jit_insn_get_value1(byval insn as jit_insn_t) as jit_value_t
declare function jit_insn_get_value2(byval insn as jit_insn_t) as jit_value_t
declare function jit_insn_get_label(byval insn as jit_insn_t) as jit_label_t
declare function jit_insn_get_function(byval insn as jit_insn_t) as jit_function_t
declare function jit_insn_get_native(byval insn as jit_insn_t) as any ptr
declare function jit_insn_get_name(byval insn as jit_insn_t) as const zstring ptr
declare function jit_insn_get_signature(byval insn as jit_insn_t) as jit_type_t
declare function jit_insn_dest_is_value(byval insn as jit_insn_t) as long
declare function jit_insn_label(byval func as jit_function_t, byval label as jit_label_t ptr) as long
declare function jit_insn_label_tight(byval func as jit_function_t, byval label as jit_label_t ptr) as long
declare function jit_insn_new_block(byval func as jit_function_t) as long
declare function jit_insn_load(byval func as jit_function_t, byval value as jit_value_t) as jit_value_t
declare function jit_insn_dup(byval func as jit_function_t, byval value as jit_value_t) as jit_value_t
declare function jit_insn_store(byval func as jit_function_t, byval dest as jit_value_t, byval value as jit_value_t) as long
declare function jit_insn_load_relative(byval func as jit_function_t, byval value as jit_value_t, byval offset as jit_nint, byval type as jit_type_t) as jit_value_t
declare function jit_insn_store_relative(byval func as jit_function_t, byval dest as jit_value_t, byval offset as jit_nint, byval value as jit_value_t) as long
declare function jit_insn_add_relative(byval func as jit_function_t, byval value as jit_value_t, byval offset as jit_nint) as jit_value_t
declare function jit_insn_load_elem(byval func as jit_function_t, byval base_addr as jit_value_t, byval index as jit_value_t, byval elem_type as jit_type_t) as jit_value_t
declare function jit_insn_load_elem_address(byval func as jit_function_t, byval base_addr as jit_value_t, byval index as jit_value_t, byval elem_type as jit_type_t) as jit_value_t
declare function jit_insn_store_elem(byval func as jit_function_t, byval base_addr as jit_value_t, byval index as jit_value_t, byval value as jit_value_t) as long
declare function jit_insn_check_null(byval func as jit_function_t, byval value as jit_value_t) as long
declare function jit_insn_nop(byval func as jit_function_t) as long
declare function jit_insn_add(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_add_ovf(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_sub(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_sub_ovf(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_mul(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_mul_ovf(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_div(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_rem(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_rem_ieee(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_neg(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_and(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_or(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_xor(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_not(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_shl(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_shr(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_ushr(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_sshr(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_eq(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_ne(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_lt(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_le(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_gt(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_ge(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_cmpl(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_cmpg(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_to_bool(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_to_not_bool(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_acos(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_asin(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_atan(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_atan2(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_ceil(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_cos(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_cosh(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_exp(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_floor(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_log(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_log10(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_pow(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_rint(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_round(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_sin(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_sinh(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_sqrt(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_tan(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_tanh(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_trunc(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_is_nan(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_is_finite(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_is_inf(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_abs(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_min(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_max(byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_sign(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_branch(byval func as jit_function_t, byval label as jit_label_t ptr) as long
declare function jit_insn_branch_if(byval func as jit_function_t, byval value as jit_value_t, byval label as jit_label_t ptr) as long
declare function jit_insn_branch_if_not(byval func as jit_function_t, byval value as jit_value_t, byval label as jit_label_t ptr) as long
declare function jit_insn_jump_table(byval func as jit_function_t, byval value as jit_value_t, byval labels as jit_label_t ptr, byval num_labels as ulong) as long
declare function jit_insn_address_of(byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_address_of_label(byval func as jit_function_t, byval label as jit_label_t ptr) as jit_value_t
declare function jit_insn_convert(byval func as jit_function_t, byval value as jit_value_t, byval type as jit_type_t, byval overflow_check as long) as jit_value_t
declare function jit_insn_call(byval func as jit_function_t, byval name as const zstring ptr, byval jit_func as jit_function_t, byval signature as jit_type_t, byval args as jit_value_t ptr, byval num_args as ulong, byval flags as long) as jit_value_t
declare function jit_insn_call_indirect(byval func as jit_function_t, byval value as jit_value_t, byval signature as jit_type_t, byval args as jit_value_t ptr, byval num_args as ulong, byval flags as long) as jit_value_t
declare function jit_insn_call_indirect_vtable(byval func as jit_function_t, byval value as jit_value_t, byval signature as jit_type_t, byval args as jit_value_t ptr, byval num_args as ulong, byval flags as long) as jit_value_t
declare function jit_insn_call_native(byval func as jit_function_t, byval name as const zstring ptr, byval native_func as any ptr, byval signature as jit_type_t, byval args as jit_value_t ptr, byval num_args as ulong, byval flags as long) as jit_value_t
declare function jit_insn_call_intrinsic(byval func as jit_function_t, byval name as const zstring ptr, byval intrinsic_func as any ptr, byval descriptor as const jit_intrinsic_descr_t ptr, byval arg1 as jit_value_t, byval arg2 as jit_value_t) as jit_value_t
declare function jit_insn_incoming_reg(byval func as jit_function_t, byval value as jit_value_t, byval reg as long) as long
declare function jit_insn_incoming_frame_posn(byval func as jit_function_t, byval value as jit_value_t, byval frame_offset as jit_nint) as long
declare function jit_insn_outgoing_reg(byval func as jit_function_t, byval value as jit_value_t, byval reg as long) as long
declare function jit_insn_outgoing_frame_posn(byval func as jit_function_t, byval value as jit_value_t, byval frame_offset as jit_nint) as long
declare function jit_insn_return_reg(byval func as jit_function_t, byval value as jit_value_t, byval reg as long) as long
declare function jit_insn_setup_for_nested(byval func as jit_function_t, byval nested_level as long, byval reg as long) as long
declare function jit_insn_flush_struct(byval func as jit_function_t, byval value as jit_value_t) as long
declare function jit_insn_import(byval func as jit_function_t, byval value as jit_value_t) as jit_value_t
declare function jit_insn_push(byval func as jit_function_t, byval value as jit_value_t) as long
declare function jit_insn_push_ptr(byval func as jit_function_t, byval value as jit_value_t, byval type as jit_type_t) as long
declare function jit_insn_set_param(byval func as jit_function_t, byval value as jit_value_t, byval offset as jit_nint) as long
declare function jit_insn_set_param_ptr(byval func as jit_function_t, byval value as jit_value_t, byval type as jit_type_t, byval offset as jit_nint) as long
declare function jit_insn_push_return_area_ptr(byval func as jit_function_t) as long
declare function jit_insn_pop_stack(byval func as jit_function_t, byval num_items as jit_nint) as long
declare function jit_insn_defer_pop_stack(byval func as jit_function_t, byval num_items as jit_nint) as long
declare function jit_insn_flush_defer_pop(byval func as jit_function_t, byval num_items as jit_nint) as long
declare function jit_insn_return(byval func as jit_function_t, byval value as jit_value_t) as long
declare function jit_insn_return_ptr(byval func as jit_function_t, byval value as jit_value_t, byval type as jit_type_t) as long
declare function jit_insn_default_return(byval func as jit_function_t) as long
declare function jit_insn_throw(byval func as jit_function_t, byval value as jit_value_t) as long
declare function jit_insn_get_call_stack(byval func as jit_function_t) as jit_value_t
declare function jit_insn_thrown_exception(byval func as jit_function_t) as jit_value_t
declare function jit_insn_uses_catcher(byval func as jit_function_t) as long
declare function jit_insn_start_catcher(byval func as jit_function_t) as jit_value_t
declare function jit_insn_branch_if_pc_not_in_range(byval func as jit_function_t, byval start_label as jit_label_t, byval end_label as jit_label_t, byval label as jit_label_t ptr) as long
declare function jit_insn_rethrow_unhandled(byval func as jit_function_t) as long
declare function jit_insn_start_finally(byval func as jit_function_t, byval finally_label as jit_label_t ptr) as long
declare function jit_insn_return_from_finally(byval func as jit_function_t) as long
declare function jit_insn_call_finally(byval func as jit_function_t, byval finally_label as jit_label_t ptr) as long
declare function jit_insn_start_filter(byval func as jit_function_t, byval label as jit_label_t ptr, byval type as jit_type_t) as jit_value_t
declare function jit_insn_return_from_filter(byval func as jit_function_t, byval value as jit_value_t) as long
declare function jit_insn_call_filter(byval func as jit_function_t, byval label as jit_label_t ptr, byval value as jit_value_t, byval type as jit_type_t) as jit_value_t
declare function jit_insn_memcpy(byval func as jit_function_t, byval dest as jit_value_t, byval src as jit_value_t, byval size as jit_value_t) as long
declare function jit_insn_memmove(byval func as jit_function_t, byval dest as jit_value_t, byval src as jit_value_t, byval size as jit_value_t) as long
declare function jit_insn_memset(byval func as jit_function_t, byval dest as jit_value_t, byval value as jit_value_t, byval size as jit_value_t) as long
declare function jit_insn_alloca(byval func as jit_function_t, byval size as jit_value_t) as jit_value_t
declare function jit_insn_move_blocks_to_end(byval func as jit_function_t, byval from_label as jit_label_t, byval to_label as jit_label_t) as long
declare function jit_insn_move_blocks_to_start(byval func as jit_function_t, byval from_label as jit_label_t, byval to_label as jit_label_t) as long
declare function jit_insn_mark_offset(byval func as jit_function_t, byval offset as jit_int) as long
declare function jit_insn_mark_breakpoint(byval func as jit_function_t, byval data1 as jit_nint, byval data2 as jit_nint) as long
declare function jit_insn_mark_breakpoint_variable(byval func as jit_function_t, byval data1 as jit_value_t, byval data2 as jit_value_t) as long
declare sub jit_insn_iter_init(byval iter as jit_insn_iter_t ptr, byval block as jit_block_t)
declare sub jit_insn_iter_init_last(byval iter as jit_insn_iter_t ptr, byval block as jit_block_t)
declare function jit_insn_iter_next(byval iter as jit_insn_iter_t ptr) as jit_insn_t
declare function jit_insn_iter_previous(byval iter as jit_insn_iter_t ptr) as jit_insn_t
#define _JIT_INTRINSIC_H
declare function jit_int_add(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_sub(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_mul(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_div(byval result as jit_int ptr, byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_rem(byval result as jit_int ptr, byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_add_ovf(byval result as jit_int ptr, byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_sub_ovf(byval result as jit_int ptr, byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_mul_ovf(byval result as jit_int ptr, byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_neg(byval value1 as jit_int) as jit_int
declare function jit_int_and(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_or(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_xor(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_not(byval value1 as jit_int) as jit_int
declare function jit_int_shl(byval value1 as jit_int, byval value2 as jit_uint) as jit_int
declare function jit_int_shr(byval value1 as jit_int, byval value2 as jit_uint) as jit_int
declare function jit_int_eq(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_ne(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_lt(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_le(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_gt(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_ge(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_cmp(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_abs(byval value1 as jit_int) as jit_int
declare function jit_int_min(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_max(byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_sign(byval value1 as jit_int) as jit_int
declare function jit_uint_add(byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_sub(byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_mul(byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_div(byval result as jit_uint ptr, byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_rem(byval result as jit_uint ptr, byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_add_ovf(byval result as jit_uint ptr, byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_sub_ovf(byval result as jit_uint ptr, byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_mul_ovf(byval result as jit_uint ptr, byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_neg(byval value1 as jit_uint) as jit_uint
declare function jit_uint_and(byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_or(byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_xor(byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_not(byval value1 as jit_uint) as jit_uint
declare function jit_uint_shl(byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_shr(byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_eq(byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_ne(byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_lt(byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_le(byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_gt(byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_ge(byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_cmp(byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_min(byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_max(byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_long_add(byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_sub(byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_mul(byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_div(byval result as jit_long ptr, byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_rem(byval result as jit_long ptr, byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_add_ovf(byval result as jit_long ptr, byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_sub_ovf(byval result as jit_long ptr, byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_mul_ovf(byval result as jit_long ptr, byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_neg(byval value1 as jit_long) as jit_long
declare function jit_long_and(byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_or(byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_xor(byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_not(byval value1 as jit_long) as jit_long
declare function jit_long_shl(byval value1 as jit_long, byval value2 as jit_uint) as jit_long
declare function jit_long_shr(byval value1 as jit_long, byval value2 as jit_uint) as jit_long
declare function jit_long_eq(byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_ne(byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_lt(byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_le(byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_gt(byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_ge(byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_cmp(byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_abs(byval value1 as jit_long) as jit_long
declare function jit_long_min(byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_max(byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_sign(byval value1 as jit_long) as jit_int
declare function jit_ulong_add(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_sub(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_mul(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_div(byval result as jit_ulong ptr, byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_rem(byval result as jit_ulong ptr, byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_add_ovf(byval result as jit_ulong ptr, byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_sub_ovf(byval result as jit_ulong ptr, byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_mul_ovf(byval result as jit_ulong ptr, byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_neg(byval value1 as jit_ulong) as jit_ulong
declare function jit_ulong_and(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_or(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_xor(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_not(byval value1 as jit_ulong) as jit_ulong
declare function jit_ulong_shl(byval value1 as jit_ulong, byval value2 as jit_uint) as jit_ulong
declare function jit_ulong_shr(byval value1 as jit_ulong, byval value2 as jit_uint) as jit_ulong
declare function jit_ulong_eq(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_ne(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_lt(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_le(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_gt(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_ge(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_cmp(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_min(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_max(byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_float32_add(byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_sub(byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_mul(byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_div(byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_rem(byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_ieee_rem(byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_neg(byval value1 as jit_float32) as jit_float32
declare function jit_float32_eq(byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_ne(byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_lt(byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_le(byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_gt(byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_ge(byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_cmpl(byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_cmpg(byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_acos(byval value1 as jit_float32) as jit_float32
declare function jit_float32_asin(byval value1 as jit_float32) as jit_float32
declare function jit_float32_atan(byval value1 as jit_float32) as jit_float32
declare function jit_float32_atan2(byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_ceil(byval value1 as jit_float32) as jit_float32
declare function jit_float32_cos(byval value1 as jit_float32) as jit_float32
declare function jit_float32_cosh(byval value1 as jit_float32) as jit_float32
declare function jit_float32_exp(byval value1 as jit_float32) as jit_float32
declare function jit_float32_floor(byval value1 as jit_float32) as jit_float32
declare function jit_float32_log(byval value1 as jit_float32) as jit_float32
declare function jit_float32_log10(byval value1 as jit_float32) as jit_float32
declare function jit_float32_pow(byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_rint(byval value1 as jit_float32) as jit_float32
declare function jit_float32_round(byval value1 as jit_float32) as jit_float32
declare function jit_float32_sin(byval value1 as jit_float32) as jit_float32
declare function jit_float32_sinh(byval value1 as jit_float32) as jit_float32
declare function jit_float32_sqrt(byval value1 as jit_float32) as jit_float32
declare function jit_float32_tan(byval value1 as jit_float32) as jit_float32
declare function jit_float32_tanh(byval value1 as jit_float32) as jit_float32
declare function jit_float32_trunc(byval value1 as jit_float32) as jit_float32
declare function jit_float32_is_finite(byval value as jit_float32) as jit_int
declare function jit_float32_is_nan(byval value as jit_float32) as jit_int
declare function jit_float32_is_inf(byval value as jit_float32) as jit_int
declare function jit_float32_abs(byval value1 as jit_float32) as jit_float32
declare function jit_float32_min(byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_max(byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_sign(byval value1 as jit_float32) as jit_int
declare function jit_float64_add(byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_sub(byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_mul(byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_div(byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_rem(byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_ieee_rem(byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_neg(byval value1 as jit_float64) as jit_float64
declare function jit_float64_eq(byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_ne(byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_lt(byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_le(byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_gt(byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_ge(byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_cmpl(byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_cmpg(byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_acos(byval value1 as jit_float64) as jit_float64
declare function jit_float64_asin(byval value1 as jit_float64) as jit_float64
declare function jit_float64_atan(byval value1 as jit_float64) as jit_float64
declare function jit_float64_atan2(byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_ceil(byval value1 as jit_float64) as jit_float64
declare function jit_float64_cos(byval value1 as jit_float64) as jit_float64
declare function jit_float64_cosh(byval value1 as jit_float64) as jit_float64
declare function jit_float64_exp(byval value1 as jit_float64) as jit_float64
declare function jit_float64_floor(byval value1 as jit_float64) as jit_float64
declare function jit_float64_log(byval value1 as jit_float64) as jit_float64
declare function jit_float64_log10(byval value1 as jit_float64) as jit_float64
declare function jit_float64_pow(byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_rint(byval value1 as jit_float64) as jit_float64
declare function jit_float64_round(byval value1 as jit_float64) as jit_float64
declare function jit_float64_sin(byval value1 as jit_float64) as jit_float64
declare function jit_float64_sinh(byval value1 as jit_float64) as jit_float64
declare function jit_float64_sqrt(byval value1 as jit_float64) as jit_float64
declare function jit_float64_tan(byval value1 as jit_float64) as jit_float64
declare function jit_float64_tanh(byval value1 as jit_float64) as jit_float64
declare function jit_float64_trunc(byval value1 as jit_float64) as jit_float64
declare function jit_float64_is_finite(byval value as jit_float64) as jit_int
declare function jit_float64_is_nan(byval value as jit_float64) as jit_int
declare function jit_float64_is_inf(byval value as jit_float64) as jit_int
declare function jit_float64_abs(byval value1 as jit_float64) as jit_float64
declare function jit_float64_min(byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_max(byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_sign(byval value1 as jit_float64) as jit_int
declare function jit_nfloat_add(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_sub(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_mul(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_div(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_rem(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_ieee_rem(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_neg(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_eq(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_ne(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_lt(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_le(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_gt(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_ge(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_cmpl(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_cmpg(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_acos(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_asin(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_atan(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_atan2(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_ceil(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_cos(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_cosh(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_exp(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_floor(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_log(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_log10(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_pow(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_rint(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_round(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_sin(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_sinh(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_sqrt(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_tan(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_tanh(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_trunc(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_is_finite(byval value as jit_nfloat) as jit_int
declare function jit_nfloat_is_nan(byval value as jit_nfloat) as jit_int
declare function jit_nfloat_is_inf(byval value as jit_nfloat) as jit_int
declare function jit_nfloat_abs(byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_min(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_max(byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_sign(byval value1 as jit_nfloat) as jit_int
declare function jit_int_to_sbyte(byval value as jit_int) as jit_int
declare function jit_int_to_ubyte(byval value as jit_int) as jit_int
declare function jit_int_to_short(byval value as jit_int) as jit_int
declare function jit_int_to_ushort(byval value as jit_int) as jit_int
declare function jit_int_to_int(byval value as jit_int) as jit_int
declare function jit_int_to_uint(byval value as jit_int) as jit_uint
declare function jit_int_to_long(byval value as jit_int) as jit_long
declare function jit_int_to_ulong(byval value as jit_int) as jit_ulong
declare function jit_uint_to_int(byval value as jit_uint) as jit_int
declare function jit_uint_to_uint(byval value as jit_uint) as jit_uint
declare function jit_uint_to_long(byval value as jit_uint) as jit_long
declare function jit_uint_to_ulong(byval value as jit_uint) as jit_ulong
declare function jit_long_to_int(byval value as jit_long) as jit_int
declare function jit_long_to_uint(byval value as jit_long) as jit_uint
declare function jit_long_to_long(byval value as jit_long) as jit_long
declare function jit_long_to_ulong(byval value as jit_long) as jit_ulong
declare function jit_ulong_to_int(byval value as jit_ulong) as jit_int
declare function jit_ulong_to_uint(byval value as jit_ulong) as jit_uint
declare function jit_ulong_to_long(byval value as jit_ulong) as jit_long
declare function jit_ulong_to_ulong(byval value as jit_ulong) as jit_ulong
declare function jit_int_to_sbyte_ovf(byval result as jit_int ptr, byval value as jit_int) as jit_int
declare function jit_int_to_ubyte_ovf(byval result as jit_int ptr, byval value as jit_int) as jit_int
declare function jit_int_to_short_ovf(byval result as jit_int ptr, byval value as jit_int) as jit_int
declare function jit_int_to_ushort_ovf(byval result as jit_int ptr, byval value as jit_int) as jit_int
declare function jit_int_to_int_ovf(byval result as jit_int ptr, byval value as jit_int) as jit_int
declare function jit_int_to_uint_ovf(byval result as jit_uint ptr, byval value as jit_int) as jit_int
declare function jit_int_to_long_ovf(byval result as jit_long ptr, byval value as jit_int) as jit_int
declare function jit_int_to_ulong_ovf(byval result as jit_ulong ptr, byval value as jit_int) as jit_int
declare function jit_uint_to_int_ovf(byval result as jit_int ptr, byval value as jit_uint) as jit_int
declare function jit_uint_to_uint_ovf(byval result as jit_uint ptr, byval value as jit_uint) as jit_int
declare function jit_uint_to_long_ovf(byval result as jit_long ptr, byval value as jit_uint) as jit_int
declare function jit_uint_to_ulong_ovf(byval result as jit_ulong ptr, byval value as jit_uint) as jit_int
declare function jit_long_to_int_ovf(byval result as jit_int ptr, byval value as jit_long) as jit_int
declare function jit_long_to_uint_ovf(byval result as jit_uint ptr, byval value as jit_long) as jit_int
declare function jit_long_to_long_ovf(byval result as jit_long ptr, byval value as jit_long) as jit_int
declare function jit_long_to_ulong_ovf(byval result as jit_ulong ptr, byval value as jit_long) as jit_int
declare function jit_ulong_to_int_ovf(byval result as jit_int ptr, byval value as jit_ulong) as jit_int
declare function jit_ulong_to_uint_ovf(byval result as jit_uint ptr, byval value as jit_ulong) as jit_int
declare function jit_ulong_to_long_ovf(byval result as jit_long ptr, byval value as jit_ulong) as jit_int
declare function jit_ulong_to_ulong_ovf(byval result as jit_ulong ptr, byval value as jit_ulong) as jit_int
declare function jit_float32_to_int(byval value as jit_float32) as jit_int
declare function jit_float32_to_uint(byval value as jit_float32) as jit_uint
declare function jit_float32_to_long(byval value as jit_float32) as jit_long
declare function jit_float32_to_ulong(byval value as jit_float32) as jit_ulong
declare function jit_float32_to_int_ovf(byval result as jit_int ptr, byval value as jit_float32) as jit_int
declare function jit_float32_to_uint_ovf(byval result as jit_uint ptr, byval value as jit_float32) as jit_int
declare function jit_float32_to_long_ovf(byval result as jit_long ptr, byval value as jit_float32) as jit_int
declare function jit_float32_to_ulong_ovf(byval result as jit_ulong ptr, byval value as jit_float32) as jit_int
declare function jit_float64_to_int(byval value as jit_float64) as jit_int
declare function jit_float64_to_uint(byval value as jit_float64) as jit_uint
declare function jit_float64_to_long(byval value as jit_float64) as jit_long
declare function jit_float64_to_ulong(byval value as jit_float64) as jit_ulong
declare function jit_float64_to_int_ovf(byval result as jit_int ptr, byval value as jit_float64) as jit_int
declare function jit_float64_to_uint_ovf(byval result as jit_uint ptr, byval value as jit_float64) as jit_int
declare function jit_float64_to_long_ovf(byval result as jit_long ptr, byval value as jit_float64) as jit_int
declare function jit_float64_to_ulong_ovf(byval result as jit_ulong ptr, byval value as jit_float64) as jit_int
declare function jit_nfloat_to_int(byval value as jit_nfloat) as jit_int
declare function jit_nfloat_to_uint(byval value as jit_nfloat) as jit_uint
declare function jit_nfloat_to_long(byval value as jit_nfloat) as jit_long
declare function jit_nfloat_to_ulong(byval value as jit_nfloat) as jit_ulong
declare function jit_nfloat_to_int_ovf(byval result as jit_int ptr, byval value as jit_nfloat) as jit_int
declare function jit_nfloat_to_uint_ovf(byval result as jit_uint ptr, byval value as jit_nfloat) as jit_int
declare function jit_nfloat_to_long_ovf(byval result as jit_long ptr, byval value as jit_nfloat) as jit_int
declare function jit_nfloat_to_ulong_ovf(byval result as jit_ulong ptr, byval value as jit_nfloat) as jit_int
declare function jit_int_to_float32(byval value as jit_int) as jit_float32
declare function jit_int_to_float64(byval value as jit_int) as jit_float64
declare function jit_int_to_nfloat(byval value as jit_int) as jit_nfloat
declare function jit_uint_to_float32(byval value as jit_uint) as jit_float32
declare function jit_uint_to_float64(byval value as jit_uint) as jit_float64
declare function jit_uint_to_nfloat(byval value as jit_uint) as jit_nfloat
declare function jit_long_to_float32(byval value as jit_long) as jit_float32
declare function jit_long_to_float64(byval value as jit_long) as jit_float64
declare function jit_long_to_nfloat(byval value as jit_long) as jit_nfloat
declare function jit_ulong_to_float32(byval value as jit_ulong) as jit_float32
declare function jit_ulong_to_float64(byval value as jit_ulong) as jit_float64
declare function jit_ulong_to_nfloat(byval value as jit_ulong) as jit_nfloat
declare function jit_float32_to_float64(byval value as jit_float32) as jit_float64
declare function jit_float32_to_nfloat(byval value as jit_float32) as jit_nfloat
declare function jit_float64_to_float32(byval value as jit_float64) as jit_float32
declare function jit_float64_to_nfloat(byval value as jit_float64) as jit_nfloat
declare function jit_nfloat_to_float32(byval value as jit_nfloat) as jit_float32
declare function jit_nfloat_to_float64(byval value as jit_nfloat) as jit_float64
#define _JIT_META_H
type jit_meta_t as _jit_meta ptr
declare function jit_meta_set(byval list as jit_meta_t ptr, byval type as long, byval data as any ptr, byval free_data as jit_meta_free_func, byval pool_owner as jit_function_t) as long
declare function jit_meta_get(byval list as jit_meta_t, byval type as long) as any ptr
declare sub jit_meta_free(byval list as jit_meta_t ptr, byval type as long)
declare sub jit_meta_destroy(byval list as jit_meta_t ptr)
#define _JIT_OBJMODEL_H

type jit_objmodel_t as jit_objmodel ptr
type jitom_class_t as jitom_class ptr
type jitom_field_t as jitom_field ptr
type jitom_method_t as jitom_method ptr

const JITOM_MODIFIER_ACCESS_MASK = &h0007
const JITOM_MODIFIER_PUBLIC = &h0000
const JITOM_MODIFIER_PRIVATE = &h0001
const JITOM_MODIFIER_PROTECTED = &h0002
const JITOM_MODIFIER_PACKAGE = &h0003
const JITOM_MODIFIER_PACKAGE_OR_PROTECTED = &h0004
const JITOM_MODIFIER_PACKAGE_AND_PROTECTED = &h0005
const JITOM_MODIFIER_OTHER1 = &h0006
const JITOM_MODIFIER_OTHER2 = &h0007
const JITOM_MODIFIER_STATIC = &h0008
const JITOM_MODIFIER_VIRTUAL = &h0010
const JITOM_MODIFIER_NEW_SLOT = &h0020
const JITOM_MODIFIER_ABSTRACT = &h0040
const JITOM_MODIFIER_LITERAL = &h0080
const JITOM_MODIFIER_CTOR = &h0100
const JITOM_MODIFIER_STATIC_CTOR = &h0200
const JITOM_MODIFIER_DTOR = &h0400
const JITOM_MODIFIER_INTERFACE = &h0800
const JITOM_MODIFIER_VALUE = &h1000
const JITOM_MODIFIER_FINAL = &h2000
const JITOM_MODIFIER_DELETE = &h4000
const JITOM_MODIFIER_REFERENCE_COUNTED = &h8000
const JITOM_TYPETAG_CLASS = 11000
const JITOM_TYPETAG_VALUE = 11001

declare sub jitom_destroy_model(byval model as jit_objmodel_t)
declare function jitom_get_class_by_name(byval model as jit_objmodel_t, byval name as const zstring ptr) as jitom_class_t
declare function jitom_class_get_name(byval model as jit_objmodel_t, byval klass as jitom_class_t) as zstring ptr
declare function jitom_class_get_modifiers(byval model as jit_objmodel_t, byval klass as jitom_class_t) as long
declare function jitom_class_get_type(byval model as jit_objmodel_t, byval klass as jitom_class_t) as jit_type_t
declare function jitom_class_get_value_type(byval model as jit_objmodel_t, byval klass as jitom_class_t) as jit_type_t
declare function jitom_class_get_primary_super(byval model as jit_objmodel_t, byval klass as jitom_class_t) as jitom_class_t
declare function jitom_class_get_all_supers(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval num as ulong ptr) as jitom_class_t ptr
declare function jitom_class_get_interfaces(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval num as ulong ptr) as jitom_class_t ptr
declare function jitom_class_get_fields(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval num as ulong ptr) as jitom_field_t ptr
declare function jitom_class_get_methods(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval num as ulong ptr) as jitom_method_t ptr
declare function jitom_class_new(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval ctor as jitom_method_t, byval func as jit_function_t, byval args as jit_value_t ptr, byval num_args as ulong, byval flags as long) as jit_value_t
declare function jitom_class_new_value(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval ctor as jitom_method_t, byval func as jit_function_t, byval args as jit_value_t ptr, byval num_args as ulong, byval flags as long) as jit_value_t
declare function jitom_class_delete(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval obj_value as jit_value_t) as long
declare function jitom_class_add_ref(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval obj_value as jit_value_t) as long
declare function jitom_field_get_name(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t) as zstring ptr
declare function jitom_field_get_type(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t) as jit_type_t
declare function jitom_field_get_modifiers(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t) as long
declare function jitom_field_load(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t, byval func as jit_function_t, byval obj_value as jit_value_t) as jit_value_t
declare function jitom_field_load_address(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t, byval func as jit_function_t, byval obj_value as jit_value_t) as jit_value_t
declare function jitom_field_store(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t, byval func as jit_function_t, byval obj_value as jit_value_t, byval value as jit_value_t) as long
declare function jitom_method_get_name(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval method as jitom_method_t) as zstring ptr
declare function jitom_method_get_type(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval method as jitom_method_t) as jit_type_t
declare function jitom_method_get_modifiers(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval method as jitom_method_t) as long
declare function jitom_method_invoke(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval method as jitom_method_t, byval func as jit_function_t, byval args as jit_value_t ptr, byval num_args as ulong, byval flags as long) as jit_value_t
declare function jitom_method_invoke_virtual(byval model as jit_objmodel_t, byval klass as jitom_class_t, byval method as jitom_method_t, byval func as jit_function_t, byval args as jit_value_t ptr, byval num_args as ulong, byval flags as long) as jit_value_t
declare function jitom_type_tag_as_class(byval type as jit_type_t, byval model as jit_objmodel_t, byval klass as jitom_class_t, byval incref as long) as jit_type_t
declare function jitom_type_tag_as_value(byval type as jit_type_t, byval model as jit_objmodel_t, byval klass as jitom_class_t, byval incref as long) as jit_type_t
declare function jitom_type_is_class(byval type as jit_type_t) as long
declare function jitom_type_is_value(byval type as jit_type_t) as long
declare function jitom_type_get_model(byval type as jit_type_t) as jit_objmodel_t
declare function jitom_type_get_class(byval type as jit_type_t) as jitom_class_t

#define _JIT_OPCODE_H
const JIT_OP_NOP = &h0000
const JIT_OP_TRUNC_SBYTE = &h0001
const JIT_OP_TRUNC_UBYTE = &h0002
const JIT_OP_TRUNC_SHORT = &h0003
const JIT_OP_TRUNC_USHORT = &h0004
const JIT_OP_TRUNC_INT = &h0005
const JIT_OP_TRUNC_UINT = &h0006
const JIT_OP_CHECK_SBYTE = &h0007
const JIT_OP_CHECK_UBYTE = &h0008
const JIT_OP_CHECK_SHORT = &h0009
const JIT_OP_CHECK_USHORT = &h000A
const JIT_OP_CHECK_INT = &h000B
const JIT_OP_CHECK_UINT = &h000C
const JIT_OP_LOW_WORD = &h000D
const JIT_OP_EXPAND_INT = &h000E
const JIT_OP_EXPAND_UINT = &h000F
const JIT_OP_CHECK_LOW_WORD = &h0010
const JIT_OP_CHECK_SIGNED_LOW_WORD = &h0011
const JIT_OP_CHECK_LONG = &h0012
const JIT_OP_CHECK_ULONG = &h0013
const JIT_OP_FLOAT32_TO_INT = &h0014
const JIT_OP_FLOAT32_TO_UINT = &h0015
const JIT_OP_FLOAT32_TO_LONG = &h0016
const JIT_OP_FLOAT32_TO_ULONG = &h0017
const JIT_OP_CHECK_FLOAT32_TO_INT = &h0018
const JIT_OP_CHECK_FLOAT32_TO_UINT = &h0019
const JIT_OP_CHECK_FLOAT32_TO_LONG = &h001A
const JIT_OP_CHECK_FLOAT32_TO_ULONG = &h001B
const JIT_OP_INT_TO_FLOAT32 = &h001C
const JIT_OP_UINT_TO_FLOAT32 = &h001D
const JIT_OP_LONG_TO_FLOAT32 = &h001E
const JIT_OP_ULONG_TO_FLOAT32 = &h001F
const JIT_OP_FLOAT32_TO_FLOAT64 = &h0020
const JIT_OP_FLOAT64_TO_INT = &h0021
const JIT_OP_FLOAT64_TO_UINT = &h0022
const JIT_OP_FLOAT64_TO_LONG = &h0023
const JIT_OP_FLOAT64_TO_ULONG = &h0024
const JIT_OP_CHECK_FLOAT64_TO_INT = &h0025
const JIT_OP_CHECK_FLOAT64_TO_UINT = &h0026
const JIT_OP_CHECK_FLOAT64_TO_LONG = &h0027
const JIT_OP_CHECK_FLOAT64_TO_ULONG = &h0028
const JIT_OP_INT_TO_FLOAT64 = &h0029
const JIT_OP_UINT_TO_FLOAT64 = &h002A
const JIT_OP_LONG_TO_FLOAT64 = &h002B
const JIT_OP_ULONG_TO_FLOAT64 = &h002C
const JIT_OP_FLOAT64_TO_FLOAT32 = &h002D
const JIT_OP_NFLOAT_TO_INT = &h002E
const JIT_OP_NFLOAT_TO_UINT = &h002F
const JIT_OP_NFLOAT_TO_LONG = &h0030
const JIT_OP_NFLOAT_TO_ULONG = &h0031
const JIT_OP_CHECK_NFLOAT_TO_INT = &h0032
const JIT_OP_CHECK_NFLOAT_TO_UINT = &h0033
const JIT_OP_CHECK_NFLOAT_TO_LONG = &h0034
const JIT_OP_CHECK_NFLOAT_TO_ULONG = &h0035
const JIT_OP_INT_TO_NFLOAT = &h0036
const JIT_OP_UINT_TO_NFLOAT = &h0037
const JIT_OP_LONG_TO_NFLOAT = &h0038
const JIT_OP_ULONG_TO_NFLOAT = &h0039
const JIT_OP_NFLOAT_TO_FLOAT32 = &h003A
const JIT_OP_NFLOAT_TO_FLOAT64 = &h003B
const JIT_OP_FLOAT32_TO_NFLOAT = &h003C
const JIT_OP_FLOAT64_TO_NFLOAT = &h003D
const JIT_OP_IADD = &h003E
const JIT_OP_IADD_OVF = &h003F
const JIT_OP_IADD_OVF_UN = &h0040
const JIT_OP_ISUB = &h0041
const JIT_OP_ISUB_OVF = &h0042
const JIT_OP_ISUB_OVF_UN = &h0043
const JIT_OP_IMUL = &h0044
const JIT_OP_IMUL_OVF = &h0045
const JIT_OP_IMUL_OVF_UN = &h0046
const JIT_OP_IDIV = &h0047
const JIT_OP_IDIV_UN = &h0048
const JIT_OP_IREM = &h0049
const JIT_OP_IREM_UN = &h004A
const JIT_OP_INEG = &h004B
const JIT_OP_LADD = &h004C
const JIT_OP_LADD_OVF = &h004D
const JIT_OP_LADD_OVF_UN = &h004E
const JIT_OP_LSUB = &h004F
const JIT_OP_LSUB_OVF = &h0050
const JIT_OP_LSUB_OVF_UN = &h0051
const JIT_OP_LMUL = &h0052
const JIT_OP_LMUL_OVF = &h0053
const JIT_OP_LMUL_OVF_UN = &h0054
const JIT_OP_LDIV = &h0055
const JIT_OP_LDIV_UN = &h0056
const JIT_OP_LREM = &h0057
const JIT_OP_LREM_UN = &h0058
const JIT_OP_LNEG = &h0059
const JIT_OP_FADD = &h005A
const JIT_OP_FSUB = &h005B
const JIT_OP_FMUL = &h005C
const JIT_OP_FDIV = &h005D
const JIT_OP_FREM = &h005E
const JIT_OP_FREM_IEEE = &h005F
const JIT_OP_FNEG = &h0060
const JIT_OP_DADD = &h0061
const JIT_OP_DSUB = &h0062
const JIT_OP_DMUL = &h0063
const JIT_OP_DDIV = &h0064
const JIT_OP_DREM = &h0065
const JIT_OP_DREM_IEEE = &h0066
const JIT_OP_DNEG = &h0067
const JIT_OP_NFADD = &h0068
const JIT_OP_NFSUB = &h0069
const JIT_OP_NFMUL = &h006A
const JIT_OP_NFDIV = &h006B
const JIT_OP_NFREM = &h006C
const JIT_OP_NFREM_IEEE = &h006D
const JIT_OP_NFNEG = &h006E
const JIT_OP_IAND = &h006F
const JIT_OP_IOR = &h0070
const JIT_OP_IXOR = &h0071
const JIT_OP_INOT = &h0072
const JIT_OP_ISHL = &h0073
const JIT_OP_ISHR = &h0074
const JIT_OP_ISHR_UN = &h0075
const JIT_OP_LAND = &h0076
const JIT_OP_LOR = &h0077
const JIT_OP_LXOR = &h0078
const JIT_OP_LNOT = &h0079
const JIT_OP_LSHL = &h007A
const JIT_OP_LSHR = &h007B
const JIT_OP_LSHR_UN = &h007C
const JIT_OP_BR = &h007D
const JIT_OP_BR_IFALSE = &h007E
const JIT_OP_BR_ITRUE = &h007F
const JIT_OP_BR_IEQ = &h0080
const JIT_OP_BR_INE = &h0081
const JIT_OP_BR_ILT = &h0082
const JIT_OP_BR_ILT_UN = &h0083
const JIT_OP_BR_ILE = &h0084
const JIT_OP_BR_ILE_UN = &h0085
const JIT_OP_BR_IGT = &h0086
const JIT_OP_BR_IGT_UN = &h0087
const JIT_OP_BR_IGE = &h0088
const JIT_OP_BR_IGE_UN = &h0089
const JIT_OP_BR_LFALSE = &h008A
const JIT_OP_BR_LTRUE = &h008B
const JIT_OP_BR_LEQ = &h008C
const JIT_OP_BR_LNE = &h008D
const JIT_OP_BR_LLT = &h008E
const JIT_OP_BR_LLT_UN = &h008F
const JIT_OP_BR_LLE = &h0090
const JIT_OP_BR_LLE_UN = &h0091
const JIT_OP_BR_LGT = &h0092
const JIT_OP_BR_LGT_UN = &h0093
const JIT_OP_BR_LGE = &h0094
const JIT_OP_BR_LGE_UN = &h0095
const JIT_OP_BR_FEQ = &h0096
const JIT_OP_BR_FNE = &h0097
const JIT_OP_BR_FLT = &h0098
const JIT_OP_BR_FLE = &h0099
const JIT_OP_BR_FGT = &h009A
const JIT_OP_BR_FGE = &h009B
const JIT_OP_BR_FLT_INV = &h009C
const JIT_OP_BR_FLE_INV = &h009D
const JIT_OP_BR_FGT_INV = &h009E
const JIT_OP_BR_FGE_INV = &h009F
const JIT_OP_BR_DEQ = &h00A0
const JIT_OP_BR_DNE = &h00A1
const JIT_OP_BR_DLT = &h00A2
const JIT_OP_BR_DLE = &h00A3
const JIT_OP_BR_DGT = &h00A4
const JIT_OP_BR_DGE = &h00A5
const JIT_OP_BR_DLT_INV = &h00A6
const JIT_OP_BR_DLE_INV = &h00A7
const JIT_OP_BR_DGT_INV = &h00A8
const JIT_OP_BR_DGE_INV = &h00A9
const JIT_OP_BR_NFEQ = &h00AA
const JIT_OP_BR_NFNE = &h00AB
const JIT_OP_BR_NFLT = &h00AC
const JIT_OP_BR_NFLE = &h00AD
const JIT_OP_BR_NFGT = &h00AE
const JIT_OP_BR_NFGE = &h00AF
const JIT_OP_BR_NFLT_INV = &h00B0
const JIT_OP_BR_NFLE_INV = &h00B1
const JIT_OP_BR_NFGT_INV = &h00B2
const JIT_OP_BR_NFGE_INV = &h00B3
const JIT_OP_ICMP = &h00B4
const JIT_OP_ICMP_UN = &h00B5
const JIT_OP_LCMP = &h00B6
const JIT_OP_LCMP_UN = &h00B7
const JIT_OP_FCMPL = &h00B8
const JIT_OP_FCMPG = &h00B9
const JIT_OP_DCMPL = &h00BA
const JIT_OP_DCMPG = &h00BB
const JIT_OP_NFCMPL = &h00BC
const JIT_OP_NFCMPG = &h00BD
const JIT_OP_IEQ = &h00BE
const JIT_OP_INE = &h00BF
const JIT_OP_ILT = &h00C0
const JIT_OP_ILT_UN = &h00C1
const JIT_OP_ILE = &h00C2
const JIT_OP_ILE_UN = &h00C3
const JIT_OP_IGT = &h00C4
const JIT_OP_IGT_UN = &h00C5
const JIT_OP_IGE = &h00C6
const JIT_OP_IGE_UN = &h00C7
const JIT_OP_LEQ = &h00C8
const JIT_OP_LNE = &h00C9
const JIT_OP_LLT = &h00CA
const JIT_OP_LLT_UN = &h00CB
const JIT_OP_LLE = &h00CC
const JIT_OP_LLE_UN = &h00CD
const JIT_OP_LGT = &h00CE
const JIT_OP_LGT_UN = &h00CF
const JIT_OP_LGE = &h00D0
const JIT_OP_LGE_UN = &h00D1
const JIT_OP_FEQ = &h00D2
const JIT_OP_FNE = &h00D3
const JIT_OP_FLT = &h00D4
const JIT_OP_FLE = &h00D5
const JIT_OP_FGT = &h00D6
const JIT_OP_FGE = &h00D7
const JIT_OP_FLT_INV = &h00D8
const JIT_OP_FLE_INV = &h00D9
const JIT_OP_FGT_INV = &h00DA
const JIT_OP_FGE_INV = &h00DB
const JIT_OP_DEQ = &h00DC
const JIT_OP_DNE = &h00DD
const JIT_OP_DLT = &h00DE
const JIT_OP_DLE = &h00DF
const JIT_OP_DGT = &h00E0
const JIT_OP_DGE = &h00E1
const JIT_OP_DLT_INV = &h00E2
const JIT_OP_DLE_INV = &h00E3
const JIT_OP_DGT_INV = &h00E4
const JIT_OP_DGE_INV = &h00E5
const JIT_OP_NFEQ = &h00E6
const JIT_OP_NFNE = &h00E7
const JIT_OP_NFLT = &h00E8
const JIT_OP_NFLE = &h00E9
const JIT_OP_NFGT = &h00EA
const JIT_OP_NFGE = &h00EB
const JIT_OP_NFLT_INV = &h00EC
const JIT_OP_NFLE_INV = &h00ED
const JIT_OP_NFGT_INV = &h00EE
const JIT_OP_NFGE_INV = &h00EF
const JIT_OP_IS_FNAN = &h00F0
const JIT_OP_IS_FINF = &h00F1
const JIT_OP_IS_FFINITE = &h00F2
const JIT_OP_IS_DNAN = &h00F3
const JIT_OP_IS_DINF = &h00F4
const JIT_OP_IS_DFINITE = &h00F5
const JIT_OP_IS_NFNAN = &h00F6
const JIT_OP_IS_NFINF = &h00F7
const JIT_OP_IS_NFFINITE = &h00F8
const JIT_OP_FACOS = &h00F9
const JIT_OP_FASIN = &h00FA
const JIT_OP_FATAN = &h00FB
const JIT_OP_FATAN2 = &h00FC
const JIT_OP_FCEIL = &h00FD
const JIT_OP_FCOS = &h00FE
const JIT_OP_FCOSH = &h00FF
const JIT_OP_FEXP = &h0100
const JIT_OP_FFLOOR = &h0101
const JIT_OP_FLOG = &h0102
const JIT_OP_FLOG10 = &h0103
const JIT_OP_FPOW = &h0104
const JIT_OP_FRINT = &h0105
const JIT_OP_FROUND = &h0106
const JIT_OP_FSIN = &h0107
const JIT_OP_FSINH = &h0108
const JIT_OP_FSQRT = &h0109
const JIT_OP_FTAN = &h010A
const JIT_OP_FTANH = &h010B
const JIT_OP_FTRUNC = &h010C
const JIT_OP_DACOS = &h010D
const JIT_OP_DASIN = &h010E
const JIT_OP_DATAN = &h010F
const JIT_OP_DATAN2 = &h0110
const JIT_OP_DCEIL = &h0111
const JIT_OP_DCOS = &h0112
const JIT_OP_DCOSH = &h0113
const JIT_OP_DEXP = &h0114
const JIT_OP_DFLOOR = &h0115
const JIT_OP_DLOG = &h0116
const JIT_OP_DLOG10 = &h0117
const JIT_OP_DPOW = &h0118
const JIT_OP_DRINT = &h0119
const JIT_OP_DROUND = &h011A
const JIT_OP_DSIN = &h011B
const JIT_OP_DSINH = &h011C
const JIT_OP_DSQRT = &h011D
const JIT_OP_DTAN = &h011E
const JIT_OP_DTANH = &h011F
const JIT_OP_DTRUNC = &h0120
const JIT_OP_NFACOS = &h0121
const JIT_OP_NFASIN = &h0122
const JIT_OP_NFATAN = &h0123
const JIT_OP_NFATAN2 = &h0124
const JIT_OP_NFCEIL = &h0125
const JIT_OP_NFCOS = &h0126
const JIT_OP_NFCOSH = &h0127
const JIT_OP_NFEXP = &h0128
const JIT_OP_NFFLOOR = &h0129
const JIT_OP_NFLOG = &h012A
const JIT_OP_NFLOG10 = &h012B
const JIT_OP_NFPOW = &h012C
const JIT_OP_NFRINT = &h012D
const JIT_OP_NFROUND = &h012E
const JIT_OP_NFSIN = &h012F
const JIT_OP_NFSINH = &h0130
const JIT_OP_NFSQRT = &h0131
const JIT_OP_NFTAN = &h0132
const JIT_OP_NFTANH = &h0133
const JIT_OP_NFTRUNC = &h0134
const JIT_OP_IABS = &h0135
const JIT_OP_LABS = &h0136
const JIT_OP_FABS = &h0137
const JIT_OP_DABS = &h0138
const JIT_OP_NFABS = &h0139
const JIT_OP_IMIN = &h013A
const JIT_OP_IMIN_UN = &h013B
const JIT_OP_LMIN = &h013C
const JIT_OP_LMIN_UN = &h013D
const JIT_OP_FMIN = &h013E
const JIT_OP_DMIN = &h013F
const JIT_OP_NFMIN = &h0140
const JIT_OP_IMAX = &h0141
const JIT_OP_IMAX_UN = &h0142
const JIT_OP_LMAX = &h0143
const JIT_OP_LMAX_UN = &h0144
const JIT_OP_FMAX = &h0145
const JIT_OP_DMAX = &h0146
const JIT_OP_NFMAX = &h0147
const JIT_OP_ISIGN = &h0148
const JIT_OP_LSIGN = &h0149
const JIT_OP_FSIGN = &h014A
const JIT_OP_DSIGN = &h014B
const JIT_OP_NFSIGN = &h014C
const JIT_OP_CHECK_NULL = &h014D
const JIT_OP_CALL = &h014E
const JIT_OP_CALL_TAIL = &h014F
const JIT_OP_CALL_INDIRECT = &h0150
const JIT_OP_CALL_INDIRECT_TAIL = &h0151
const JIT_OP_CALL_VTABLE_PTR = &h0152
const JIT_OP_CALL_VTABLE_PTR_TAIL = &h0153
const JIT_OP_CALL_EXTERNAL = &h0154
const JIT_OP_CALL_EXTERNAL_TAIL = &h0155
const JIT_OP_RETURN = &h0156
const JIT_OP_RETURN_INT = &h0157
const JIT_OP_RETURN_LONG = &h0158
const JIT_OP_RETURN_FLOAT32 = &h0159
const JIT_OP_RETURN_FLOAT64 = &h015A
const JIT_OP_RETURN_NFLOAT = &h015B
const JIT_OP_RETURN_SMALL_STRUCT = &h015C
const JIT_OP_SETUP_FOR_NESTED = &h015D
const JIT_OP_SETUP_FOR_SIBLING = &h015E
const JIT_OP_IMPORT = &h015F
const JIT_OP_THROW = &h0160
const JIT_OP_RETHROW = &h0161
const JIT_OP_LOAD_PC = &h0162
const JIT_OP_LOAD_EXCEPTION_PC = &h0163
const JIT_OP_ENTER_FINALLY = &h0164
const JIT_OP_LEAVE_FINALLY = &h0165
const JIT_OP_CALL_FINALLY = &h0166
const JIT_OP_ENTER_FILTER = &h0167
const JIT_OP_LEAVE_FILTER = &h0168
const JIT_OP_CALL_FILTER = &h0169
const JIT_OP_CALL_FILTER_RETURN = &h016A
const JIT_OP_ADDRESS_OF_LABEL = &h016B
const JIT_OP_COPY_LOAD_SBYTE = &h016C
const JIT_OP_COPY_LOAD_UBYTE = &h016D
const JIT_OP_COPY_LOAD_SHORT = &h016E
const JIT_OP_COPY_LOAD_USHORT = &h016F
const JIT_OP_COPY_INT = &h0170
const JIT_OP_COPY_LONG = &h0171
const JIT_OP_COPY_FLOAT32 = &h0172
const JIT_OP_COPY_FLOAT64 = &h0173
const JIT_OP_COPY_NFLOAT = &h0174
const JIT_OP_COPY_STRUCT = &h0175
const JIT_OP_COPY_STORE_BYTE = &h0176
const JIT_OP_COPY_STORE_SHORT = &h0177
const JIT_OP_ADDRESS_OF = &h0178
const JIT_OP_INCOMING_REG = &h0179
const JIT_OP_INCOMING_FRAME_POSN = &h017A
const JIT_OP_OUTGOING_REG = &h017B
const JIT_OP_OUTGOING_FRAME_POSN = &h017C
const JIT_OP_RETURN_REG = &h017D
const JIT_OP_PUSH_INT = &h017E
const JIT_OP_PUSH_LONG = &h017F
const JIT_OP_PUSH_FLOAT32 = &h0180
const JIT_OP_PUSH_FLOAT64 = &h0181
const JIT_OP_PUSH_NFLOAT = &h0182
const JIT_OP_PUSH_STRUCT = &h0183
const JIT_OP_POP_STACK = &h0184
const JIT_OP_FLUSH_SMALL_STRUCT = &h0185
const JIT_OP_SET_PARAM_INT = &h0186
const JIT_OP_SET_PARAM_LONG = &h0187
const JIT_OP_SET_PARAM_FLOAT32 = &h0188
const JIT_OP_SET_PARAM_FLOAT64 = &h0189
const JIT_OP_SET_PARAM_NFLOAT = &h018A
const JIT_OP_SET_PARAM_STRUCT = &h018B
const JIT_OP_PUSH_RETURN_AREA_PTR = &h018C
const JIT_OP_LOAD_RELATIVE_SBYTE = &h018D
const JIT_OP_LOAD_RELATIVE_UBYTE = &h018E
const JIT_OP_LOAD_RELATIVE_SHORT = &h018F
const JIT_OP_LOAD_RELATIVE_USHORT = &h0190
const JIT_OP_LOAD_RELATIVE_INT = &h0191
const JIT_OP_LOAD_RELATIVE_LONG = &h0192
const JIT_OP_LOAD_RELATIVE_FLOAT32 = &h0193
const JIT_OP_LOAD_RELATIVE_FLOAT64 = &h0194
const JIT_OP_LOAD_RELATIVE_NFLOAT = &h0195
const JIT_OP_LOAD_RELATIVE_STRUCT = &h0196
const JIT_OP_STORE_RELATIVE_BYTE = &h0197
const JIT_OP_STORE_RELATIVE_SHORT = &h0198
const JIT_OP_STORE_RELATIVE_INT = &h0199
const JIT_OP_STORE_RELATIVE_LONG = &h019A
const JIT_OP_STORE_RELATIVE_FLOAT32 = &h019B
const JIT_OP_STORE_RELATIVE_FLOAT64 = &h019C
const JIT_OP_STORE_RELATIVE_NFLOAT = &h019D
const JIT_OP_STORE_RELATIVE_STRUCT = &h019E
const JIT_OP_ADD_RELATIVE = &h019F
const JIT_OP_LOAD_ELEMENT_SBYTE = &h01A0
const JIT_OP_LOAD_ELEMENT_UBYTE = &h01A1
const JIT_OP_LOAD_ELEMENT_SHORT = &h01A2
const JIT_OP_LOAD_ELEMENT_USHORT = &h01A3
const JIT_OP_LOAD_ELEMENT_INT = &h01A4
const JIT_OP_LOAD_ELEMENT_LONG = &h01A5
const JIT_OP_LOAD_ELEMENT_FLOAT32 = &h01A6
const JIT_OP_LOAD_ELEMENT_FLOAT64 = &h01A7
const JIT_OP_LOAD_ELEMENT_NFLOAT = &h01A8
const JIT_OP_STORE_ELEMENT_BYTE = &h01A9
const JIT_OP_STORE_ELEMENT_SHORT = &h01AA
const JIT_OP_STORE_ELEMENT_INT = &h01AB
const JIT_OP_STORE_ELEMENT_LONG = &h01AC
const JIT_OP_STORE_ELEMENT_FLOAT32 = &h01AD
const JIT_OP_STORE_ELEMENT_FLOAT64 = &h01AE
const JIT_OP_STORE_ELEMENT_NFLOAT = &h01AF
const JIT_OP_MEMCPY = &h01B0
const JIT_OP_MEMMOVE = &h01B1
const JIT_OP_MEMSET = &h01B2
const JIT_OP_ALLOCA = &h01B3
const JIT_OP_MARK_OFFSET = &h01B4
const JIT_OP_MARK_BREAKPOINT = &h01B5
const JIT_OP_JUMP_TABLE = &h01B6
const JIT_OP_NUM_OPCODES = &h01B7
type jit_opcode_info_t as jit_opcode_info

type jit_opcode_info
	name as const zstring ptr
	flags as long
end type

const JIT_OPCODE_DEST_MASK = &h0000000F
const JIT_OPCODE_DEST_EMPTY = &h00000000
const JIT_OPCODE_DEST_INT = &h00000001
const JIT_OPCODE_DEST_LONG = &h00000002
const JIT_OPCODE_DEST_FLOAT32 = &h00000003
const JIT_OPCODE_DEST_FLOAT64 = &h00000004
const JIT_OPCODE_DEST_NFLOAT = &h00000005
const JIT_OPCODE_DEST_ANY = &h00000006
const JIT_OPCODE_SRC1_MASK = &h000000F0
const JIT_OPCODE_SRC1_EMPTY = &h00000000
const JIT_OPCODE_SRC1_INT = &h00000010
const JIT_OPCODE_SRC1_LONG = &h00000020
const JIT_OPCODE_SRC1_FLOAT32 = &h00000030
const JIT_OPCODE_SRC1_FLOAT64 = &h00000040
const JIT_OPCODE_SRC1_NFLOAT = &h00000050
const JIT_OPCODE_SRC1_ANY = &h00000060
const JIT_OPCODE_SRC2_MASK = &h00000F00
const JIT_OPCODE_SRC2_EMPTY = &h00000000
const JIT_OPCODE_SRC2_INT = &h00000100
const JIT_OPCODE_SRC2_LONG = &h00000200
const JIT_OPCODE_SRC2_FLOAT32 = &h00000300
const JIT_OPCODE_SRC2_FLOAT64 = &h00000400
const JIT_OPCODE_SRC2_NFLOAT = &h00000500
const JIT_OPCODE_SRC2_ANY = &h00000600
const JIT_OPCODE_IS_BRANCH = &h00001000
const JIT_OPCODE_IS_CALL = &h00002000
const JIT_OPCODE_IS_CALL_EXTERNAL = &h00004000
const JIT_OPCODE_IS_REG = &h00008000
const JIT_OPCODE_IS_ADDROF_LABEL = &h00010000
const JIT_OPCODE_IS_JUMP_TABLE = &h00020000
const JIT_OPCODE_OPER_MASK = &h01F00000
const JIT_OPCODE_OPER_NONE = &h00000000
const JIT_OPCODE_OPER_ADD = &h00100000
const JIT_OPCODE_OPER_SUB = &h00200000
const JIT_OPCODE_OPER_MUL = &h00300000
const JIT_OPCODE_OPER_DIV = &h00400000
const JIT_OPCODE_OPER_REM = &h00500000
const JIT_OPCODE_OPER_NEG = &h00600000
const JIT_OPCODE_OPER_AND = &h00700000
const JIT_OPCODE_OPER_OR = &h00800000
const JIT_OPCODE_OPER_XOR = &h00900000
const JIT_OPCODE_OPER_NOT = &h00A00000
const JIT_OPCODE_OPER_EQ = &h00B00000
const JIT_OPCODE_OPER_NE = &h00C00000
const JIT_OPCODE_OPER_LT = &h00D00000
const JIT_OPCODE_OPER_LE = &h00E00000
const JIT_OPCODE_OPER_GT = &h00F00000
const JIT_OPCODE_OPER_GE = &h01000000
const JIT_OPCODE_OPER_SHL = &h01100000
const JIT_OPCODE_OPER_SHR = &h01200000
const JIT_OPCODE_OPER_SHR_UN = &h01300000
const JIT_OPCODE_OPER_COPY = &h01400000
const JIT_OPCODE_OPER_ADDRESS_OF = &h01500000

#if defined(__FB_64BIT__) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))
	const JIT_OPCODE_DEST_PTR = JIT_OPCODE_DEST_LONG
	const JIT_OPCODE_SRC1_PTR = JIT_OPCODE_SRC1_LONG
	const JIT_OPCODE_SRC2_PTR = JIT_OPCODE_SRC2_LONG
#else
	const JIT_OPCODE_DEST_PTR = JIT_OPCODE_DEST_INT
	const JIT_OPCODE_SRC1_PTR = JIT_OPCODE_SRC1_INT
	const JIT_OPCODE_SRC2_PTR = JIT_OPCODE_SRC2_INT
#endif

extern jit_opcodes(0 to 438) as const jit_opcode_info_t
#define _JIT_OPCODE_COMPAT_H
const JIT_OP_FEQ_INV = JIT_OP_FEQ
const JIT_OP_FNE_INV = JIT_OP_FNE
const JIT_OP_DEQ_INV = JIT_OP_DEQ
const JIT_OP_DNE_INV = JIT_OP_DNE
const JIT_OP_NFEQ_INV = JIT_OP_NFEQ
const JIT_OP_NFNE_INV = JIT_OP_NFNE
const JIT_OP_BR_FEQ_INV = JIT_OP_BR_FEQ
const JIT_OP_BR_FNE_INV = JIT_OP_BR_FNE
const JIT_OP_BR_DEQ_INV = JIT_OP_BR_DEQ
const JIT_OP_BR_DNE_INV = JIT_OP_BR_DNE
const JIT_OP_BR_NFEQ_INV = JIT_OP_BR_NFEQ
const JIT_OP_BR_NFNE_INV = JIT_OP_BR_NFNE
#define _JIT_UNWIND_H

#if defined(__FB_DOS__) or ((not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))))
	#define _JIT_ARCH_X86_H
	#macro _JIT_ARCH_GET_CURRENT_FRAME(f)
		scope
			dim __f as any ptr
			asm mov dword ptr [__f], ebp
			f = __f
		end scope
	#endmacro
#elseif defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
	#define _JIT_ARCH_X86_64_H
	type _jit_arch_frame_t as _jit_arch_frame

	type _jit_arch_frame
		next_frame as _jit_arch_frame_t ptr
		return_address as any ptr
	end type

	#macro _JIT_ARCH_GET_CURRENT_FRAME(f)
		scope
			dim __f as any ptr
			asm mov qword ptr [__f], rbp
			f = __f
		end scope
	#endmacro
	#define _JIT_ARCH_GET_NEXT_FRAME(n, f) scope : (n) = cptr(any ptr, iif((f), cptr(_jit_arch_frame_t ptr, (f))->next_frame, 0)) : end scope
	#define _JIT_ARCH_GET_RETURN_ADDRESS(r, f) scope : (r) = cptr(any ptr, iif((f), cptr(_jit_arch_frame_t ptr, (f))->return_address, 0)) : end scope
	#macro _JIT_ARCH_GET_CURRENT_RETURN(r)
		scope
			dim __frame as any ptr
			_JIT_ARCH_GET_CURRENT_FRAME(__frame)
			_JIT_ARCH_GET_RETURN_ADDRESS((r), __frame)
		end scope
	#endmacro
#else
	#define _JIT_ARCH_GENERIC_H
	#undef _JIT_ARCH_GET_CURRENT_FRAME
	#undef _JIT_ARCH_GET_NEXT_FRAME
	#undef _JIT_ARCH_GET_RETURN_ADDRESS
	#define _JIT_ARCH_GET_CURRENT_RETURN
#endif

type jit_unwind_context_t
	frame as any ptr
	cache as any ptr
	context as jit_context_t
end type

declare function jit_unwind_init(byval unwind as jit_unwind_context_t ptr, byval context as jit_context_t) as long
declare sub jit_unwind_free(byval unwind as jit_unwind_context_t ptr)
declare function jit_unwind_next(byval unwind as jit_unwind_context_t ptr) as long
declare function jit_unwind_next_pc(byval unwind as jit_unwind_context_t ptr) as long
declare function jit_unwind_get_pc(byval unwind as jit_unwind_context_t ptr) as any ptr
declare function jit_unwind_jump(byval unwind as jit_unwind_context_t ptr, byval pc as any ptr) as long
declare function jit_unwind_get_function(byval unwind as jit_unwind_context_t ptr) as jit_function_t
declare function jit_unwind_get_offset(byval unwind as jit_unwind_context_t ptr) as ulong
#define _JIT_UTIL_H
declare function jit_malloc(byval size as ulong) as any ptr
declare function jit_calloc(byval num as ulong, byval size as ulong) as any ptr
declare function jit_realloc(byval ptr as any ptr, byval size as ulong) as any ptr
declare sub jit_free(byval ptr as any ptr)
#define jit_new(type) cptr(type ptr, jit_malloc(sizeof(type)))
#define jit_cnew(type) cptr(type ptr, jit_calloc(1, sizeof(type)))
declare function jit_memset(byval dest as any ptr, byval ch as long, byval len as ulong) as any ptr
declare function jit_memcpy(byval dest as any ptr, byval src as const any ptr, byval len as ulong) as any ptr
declare function jit_memmove(byval dest as any ptr, byval src as const any ptr, byval len as ulong) as any ptr
declare function jit_memcmp(byval s1 as const any ptr, byval s2 as const any ptr, byval len as ulong) as long
declare function jit_memchr(byval str as const any ptr, byval ch as long, byval len as ulong) as any ptr
declare function jit_strlen(byval str as const zstring ptr) as ulong
declare function jit_strcpy(byval dest as zstring ptr, byval src as const zstring ptr) as zstring ptr
declare function jit_strcat(byval dest as zstring ptr, byval src as const zstring ptr) as zstring ptr
declare function jit_strncpy(byval dest as zstring ptr, byval src as const zstring ptr, byval len as ulong) as zstring ptr
declare function jit_strdup(byval str as const zstring ptr) as zstring ptr
declare function jit_strndup(byval str as const zstring ptr, byval len as ulong) as zstring ptr
declare function jit_strcmp(byval str1 as const zstring ptr, byval str2 as const zstring ptr) as long
declare function jit_strncmp(byval str1 as const zstring ptr, byval str2 as const zstring ptr, byval len as ulong) as long
declare function jit_stricmp(byval str1 as const zstring ptr, byval str2 as const zstring ptr) as long
declare function jit_strnicmp(byval str1 as const zstring ptr, byval str2 as const zstring ptr, byval len as ulong) as long
declare function jit_strchr(byval str as const zstring ptr, byval ch as long) as zstring ptr
declare function jit_strrchr(byval str as const zstring ptr, byval ch as long) as zstring ptr
declare function jit_sprintf(byval str as zstring ptr, byval format as const zstring ptr, ...) as long
declare function jit_snprintf(byval str as zstring ptr, byval len as ulong, byval format as const zstring ptr, ...) as long
#define _JIT_VALUE_H

union jit_constant_t_un
	ptr_value as any ptr
	int_value as jit_int
	uint_value as jit_uint
	nint_value as jit_nint
	nuint_value as jit_nuint
	long_value as jit_long
	ulong_value as jit_ulong
	float32_value as jit_float32
	float64_value as jit_float64
	nfloat_value as jit_nfloat
end union

type jit_constant_t
	as jit_type_t type
	un as jit_constant_t_un
end type

declare function jit_value_create(byval func as jit_function_t, byval type as jit_type_t) as jit_value_t
declare function jit_value_create_nint_constant(byval func as jit_function_t, byval type as jit_type_t, byval const_value as jit_nint) as jit_value_t
declare function jit_value_create_long_constant(byval func as jit_function_t, byval type as jit_type_t, byval const_value as jit_long) as jit_value_t
declare function jit_value_create_float32_constant(byval func as jit_function_t, byval type as jit_type_t, byval const_value as jit_float32) as jit_value_t
declare function jit_value_create_float64_constant(byval func as jit_function_t, byval type as jit_type_t, byval const_value as jit_float64) as jit_value_t
declare function jit_value_create_nfloat_constant(byval func as jit_function_t, byval type as jit_type_t, byval const_value as jit_nfloat) as jit_value_t
declare function jit_value_create_constant(byval func as jit_function_t, byval const_value as const jit_constant_t ptr) as jit_value_t
declare function jit_value_get_param(byval func as jit_function_t, byval param as ulong) as jit_value_t
declare function jit_value_get_struct_pointer(byval func as jit_function_t) as jit_value_t
declare function jit_value_is_temporary(byval value as jit_value_t) as long
declare function jit_value_is_local(byval value as jit_value_t) as long
declare function jit_value_is_constant(byval value as jit_value_t) as long
declare function jit_value_is_parameter(byval value as jit_value_t) as long
declare sub jit_value_ref(byval func as jit_function_t, byval value as jit_value_t)
declare sub jit_value_set_volatile(byval value as jit_value_t)
declare function jit_value_is_volatile(byval value as jit_value_t) as long
declare sub jit_value_set_addressable(byval value as jit_value_t)
declare function jit_value_is_addressable(byval value as jit_value_t) as long
declare function jit_value_get_type(byval value as jit_value_t) as jit_type_t
declare function jit_value_get_function(byval value as jit_value_t) as jit_function_t
declare function jit_value_get_block(byval value as jit_value_t) as jit_block_t
declare function jit_value_get_context(byval value as jit_value_t) as jit_context_t
declare function jit_value_get_constant(byval value as jit_value_t) as jit_constant_t
declare function jit_value_get_nint_constant(byval value as jit_value_t) as jit_nint
declare function jit_value_get_long_constant(byval value as jit_value_t) as jit_long
declare function jit_value_get_float32_constant(byval value as jit_value_t) as jit_float32
declare function jit_value_get_float64_constant(byval value as jit_value_t) as jit_float64
declare function jit_value_get_nfloat_constant(byval value as jit_value_t) as jit_nfloat
declare function jit_value_is_true(byval value as jit_value_t) as long
declare function jit_constant_convert(byval result as jit_constant_t ptr, byval value as const jit_constant_t ptr, byval type as jit_type_t, byval overflow_check as long) as long
#define _JIT_VMEM_H

type jit_prot_t as long
enum
	JIT_PROT_NONE
	JIT_PROT_READ
	JIT_PROT_READ_WRITE
	JIT_PROT_EXEC_READ
	JIT_PROT_EXEC_READ_WRITE
end enum

declare sub jit_vmem_init()
declare function jit_vmem_page_size() as jit_uint
declare function jit_vmem_round_up(byval value as jit_nuint) as jit_nuint
declare function jit_vmem_round_down(byval value as jit_nuint) as jit_nuint
declare function jit_vmem_reserve(byval size as jit_uint) as any ptr
declare function jit_vmem_reserve_committed(byval size as jit_uint, byval prot as jit_prot_t) as any ptr
declare function jit_vmem_release(byval addr as any ptr, byval size as jit_uint) as long
declare function jit_vmem_commit(byval addr as any ptr, byval size as jit_uint, byval prot as jit_prot_t) as long
declare function jit_vmem_decommit(byval addr as any ptr, byval size as jit_uint) as long
declare function jit_vmem_protect(byval addr as any ptr, byval size as jit_uint, byval prot as jit_prot_t) as long
#define _JIT_WALK_H
declare function _jit_get_frame_address(byval start as any ptr, byval n as ulong) as any ptr

#define jit_get_frame_address(n) _jit_get_frame_address(jit_get_current_frame(), (n))
const JIT_FAST_GET_CURRENT_FRAME = 1
#define jit_get_current_frame() jit_get_frame_address(0)
declare function _jit_get_next_frame_address(byval frame as any ptr) as any ptr
#define jit_get_next_frame_address(frame) _jit_get_next_frame_address(frame)
declare function _jit_get_return_address(byval frame as any ptr, byval frame0 as any ptr, byval return0 as any ptr) as any ptr
#define jit_get_return_address(frame) _jit_get_return_address((frame), 0, 0)
#define jit_get_current_return() jit_get_return_address(jit_get_current_frame())

type jit_crawl_mark_t
	mark as any ptr
end type

#define jit_declare_crawl_mark(name) dim as jit_crawl_mark_t name = {0}
declare function jit_frame_contains_crawl_mark(byval frame as any ptr, byval mark as jit_crawl_mark_t ptr) as long
#define _JIT_DUMP_H
declare sub jit_dump_type(byval stream as FILE ptr, byval type as jit_type_t)
declare sub jit_dump_value(byval stream as FILE ptr, byval func as jit_function_t, byval value as jit_value_t, byval prefix as const zstring ptr)
declare sub jit_dump_insn(byval stream as FILE ptr, byval func as jit_function_t, byval insn as jit_insn_t)
declare sub jit_dump_function(byval stream as FILE ptr, byval func as jit_function_t, byval name as const zstring ptr)
#define _JIT_DYNAMIC_H
type jit_dynlib_handle_t as any ptr
declare function jit_dynlib_open(byval name as const zstring ptr) as jit_dynlib_handle_t
declare sub jit_dynlib_close(byval handle as jit_dynlib_handle_t)
declare function jit_dynlib_get_symbol(byval handle as jit_dynlib_handle_t, byval symbol as const zstring ptr) as any ptr
declare function jit_dynlib_get_suffix() as const zstring ptr
declare sub jit_dynlib_set_debug(byval flag as long)
const JIT_MANGLE_PUBLIC = &h0001
const JIT_MANGLE_PROTECTED = &h0002
const JIT_MANGLE_PRIVATE = &h0003
const JIT_MANGLE_STATIC = &h0008
const JIT_MANGLE_VIRTUAL = &h0010
const JIT_MANGLE_CONST = &h0020
const JIT_MANGLE_EXPLICIT_THIS = &h0040
const JIT_MANGLE_IS_CTOR = &h0080
const JIT_MANGLE_IS_DTOR = &h0100
const JIT_MANGLE_BASE = &h0200
declare function jit_mangle_global_function(byval name as const zstring ptr, byval signature as jit_type_t, byval form as long) as zstring ptr
declare function jit_mangle_member_function(byval class_name as const zstring ptr, byval name as const zstring ptr, byval signature as jit_type_t, byval form as long, byval flags as long) as zstring ptr

end extern
