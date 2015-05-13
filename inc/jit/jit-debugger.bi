''
''
'' jit-debugger -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_debugger_bi__
#define __jit_debugger_bi__

#include "jit/jit-common.bi"

type jit_debugger_t as jit_debugger ptr
type jit_debugger_thread_id_t as jit_nint
type jit_debugger_breakpoint_id_t as jit_nint

type jit_debugger_event
	type as integer
	thread as jit_debugger_thread_id_t
	function as jit_function_t
	data1 as jit_nint
	data2 as jit_nint
	id as jit_debugger_breakpoint_id_t
	trace as jit_stack_trace_t
end type

type jit_debugger_event_t as jit_debugger_event

#define JIT_DEBUGGER_TYPE_QUIT 0
#define JIT_DEBUGGER_TYPE_HARD_BREAKPOINT 1
#define JIT_DEBUGGER_TYPE_SOFT_BREAKPOINT 2
#define JIT_DEBUGGER_TYPE_USER_BREAKPOINT 3
#define JIT_DEBUGGER_TYPE_ATTACH_THREAD 4
#define JIT_DEBUGGER_TYPE_DETACH_THREAD 5

type jit_debugger_breakpoint_info
	flags as integer
	thread as jit_debugger_thread_id_t
	function as jit_function_t
	data1 as jit_nint
	data2 as jit_nint
end type

type jit_debugger_breakpoint_info_t as jit_debugger_breakpoint_info ptr

#define JIT_DEBUGGER_FLAG_THREAD (1 shl 0)
#define JIT_DEBUGGER_FLAG_FUNCTION (1 shl 1)
#define JIT_DEBUGGER_FLAG_DATA1 (1 shl 2)
#define JIT_DEBUGGER_FLAG_DATA2 (1 shl 3)
#define JIT_DEBUGGER_DATA1_FIRST 10000
#define JIT_DEBUGGER_DATA1_LINE 10000
#define JIT_DEBUGGER_DATA1_ENTER 10001
#define JIT_DEBUGGER_DATA1_LEAVE 10002
#define JIT_DEBUGGER_DATA1_THROW 10003

type jit_debugger_hook_func as sub cdecl(byval as jit_function_t, byval as jit_nint, byval as jit_nint)

declare function jit_debugger_possible cdecl alias "jit_debugger_possible" () as integer
declare function jit_debugger_create cdecl alias "jit_debugger_create" (byval context as jit_context_t) as jit_debugger_t
declare sub jit_debugging_destroy cdecl alias "jit_debugger_destroy" (byval dbg as jit_debugger_t)
declare function jit_debugger_get_context cdecl alias "jit_debugger_get_context" (byval dbg as jit_debugger_t) as jit_context_t
declare function jit_debugger_from_context cdecl alias "jit_debugger_from_context" (byval context as jit_context_t) as jit_debugger_t
declare function jit_debugger_get_self cdecl alias "jit_debugger_get_self" (byval dbg as jit_debugger_t) as jit_debugger_thread_id_t
declare function jit_debugger_get_thread cdecl alias "jit_debugger_get_thread" (byval dbg as jit_debugger_t, byval native_thread as const any ptr) as jit_debugger_thread_id_t
declare function jit_debugger_get_native_thread cdecl alias "jit_debugger_get_native_thread" (byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t, byval native_thread as any ptr) as integer
declare sub jit_debugger_set_breakable cdecl alias "jit_debugger_set_breakable" (byval dbg as jit_debugger_t, byval native_thread as const any ptr, byval flag as integer)
declare sub jit_debugger_attach_self cdecl alias "jit_debugger_attach_self" (byval dbg as jit_debugger_t, byval stop_immediately as integer)
declare sub jit_debugger_detach_self cdecl alias "jit_debugger_detach_self" (byval dbg as jit_debugger_t)
declare function jit_debugger_wait_event cdecl alias "jit_debugger_wait_event" (byval dbg as jit_debugger_t, byval event as jit_debugger_event_t ptr, byval timeout as jit_int) as integer
declare function jit_debugger_add_breakpoint cdecl alias "jit_debugger_add_breakpoint" (byval dbg as jit_debugger_t, byval info as jit_debugger_breakpoint_info_t) as jit_debugger_breakpoint_id_t
declare sub jit_debugger_remove_breakpoint cdecl alias "jit_debugger_remove_breakpoint" (byval dbg as jit_debugger_t, byval id as jit_debugger_breakpoint_id_t)
declare sub jit_debugger_remove_all_breakpoints cdecl alias "jit_debugger_remove_all_breakpoints" (byval dbg as jit_debugger_t) 
declare function jit_debugger_is_alive cdecl alias "jit_debugger_is_alive" (byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t) as integer
declare function jit_debugger_is_running cdecl alias "jit_debugger_is_running" (byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t) as integer
declare sub jit_debugger_run cdecl alias "jit_debugger_run" (byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t)
declare sub jit_debugger_step cdecl alias "jit_debugger_step" (byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t)
declare sub jit_debugger_next cdecl alias "jit_debugger_next" (byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t)
declare sub jit_debugger_finish cdecl alias "jit_debugger_finish" (byval dbg as jit_debugger_t, byval thread as jit_debugger_thread_id_t)
declare sub jit_debugger_break cdecl alias "jit_debugger_break" (byval dbg as jit_debugger_t)
declare sub jit_debugger_quit cdecl alias "jit_debugger_quit" (byval dbg as jit_debugger_t)
declare function jit_debugger_set_hook cdecl alias "jit_debugger_set_hook" (byval context as jit_context_t, byval hook as jit_debugger_hook_func) as jit_debugger_hook_func

#endif
