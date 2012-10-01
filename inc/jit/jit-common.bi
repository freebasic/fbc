''
''
'' jit-common -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_common_bi__
#define __jit_common_bi__

#include "jit/jit-defs.bi"

type jit_context_t as _jit_context ptr
type jit_function_t as _jit_function ptr
type jit_function_compiled_t as any ptr
type jit_block_t as _jit_block ptr
type jit_insn_t as _jit_insn ptr
type jit_value_t as _jit_value ptr
type jit_type_t as _jit_type ptr
type jit_stack_trace_t as jit_stack_trace ptr
type jit_label_t as jit_nuint
#define	jit_label_undefined	Cast(jit_label_t, Not Cast(jit_uint, 0))
type jit_meta_free_func as sub cdecl(byval as any ptr)
type jit_on_demand_func as function cdecl(byval as jit_function_t) as integer
type jit_on_demand_driver_func as sub cdecl(byval as jit_function_t)

#endif
