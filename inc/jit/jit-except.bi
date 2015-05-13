''
''
'' jit-except -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_except_bi__
#define __jit_except_bi__

#include "jit/jit-common.bi"

#define JIT_RESULT_OK 1
#define JIT_RESULT_OVERFLOW 0
#define JIT_RESULT_ARITHMETIC -1
#define JIT_RESULT_DIVISION_BY_ZERO -2
#define JIT_RESULT_COMPILE_ERROR -3
#define JIT_RESULT_OUT_OF_MEMORY -4
#define JIT_RESULT_NULL_REFERENCE -5
#define JIT_RESULT_NULL_FUNCTION -6
#define JIT_RESULT_CALLED_NESTED -7
#define JIT_RESULT_OUT_OF_BOUNDS -8

type jit_exception_func as sub cdecl(byval as integer)

declare function jit_exception_get_last cdecl alias "jit_exception_get_last" () as any ptr
declare function jit_exception_get_last_and_clear cdecl alias "jit_exception_get_last_and_clear" () as any ptr
declare sub jit_exception_set_last cdecl alias "jit_exception_set_last" (byval object as any ptr)
declare sub jit_exception_clear_last cdecl alias "jit_exception_clear_last" ()
declare sub jit_exception_throw cdecl alias "jit_exception_throw" (byval object as any ptr)
declare sub jit_exception_builtin cdecl alias "jit_exception_builtin" (byval exception_type as integer)
declare function jit_exception_set_handler cdecl alias "jit_exception_set_handler" (byval handler as jit_exception_func) as jit_exception_func
declare function jit_exception_get_handler cdecl alias "jit_exception_get_handler" () as jit_exception_func
declare function jit_exception_get_stack_trace cdecl alias "jit_exception_get_stack_trace" () as jit_stack_trace_t
declare function jit_stack_trace_get_size cdecl alias "jit_stack_trace_get_size" (byval trace as jit_stack_trace_t) as uinteger
declare function jit_stack_trace_get_function cdecl alias "jit_stack_trace_get_function" (byval context as jit_context_t, byval trace as jit_stack_trace_t, byval posn as uinteger) as jit_function_t
declare function jit_stack_trace_get_pc cdecl alias "jit_stack_trace_get_pc" (byval trace as jit_stack_trace_t, byval posn as uinteger) as any ptr
declare function jit_stack_trace_get_offset cdecl alias "jit_stack_trace_get_offset" (byval context as jit_context_t, byval trace as jit_stack_trace_t, byval posn as uinteger) as uinteger
declare sub jit_stack_trace_free cdecl alias "jit_stack_trace_free" (byval trace as jit_stack_trace_t)

#endif
