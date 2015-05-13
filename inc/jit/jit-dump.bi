''
''
'' jit-dump -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_dump_bi__
#define __jit_dump_bi__

#include "jit/jit-common.bi"

declare sub jit_dump_type cdecl alias "jit_dump_type" (byval stream as FILE ptr, byval type as jit_type_t)
declare sub jit_dump_value cdecl alias "jit_dump_value" (byval stream as FILE ptr, byval func as jit_function_t, byval value as jit_value_t, byval prefix as zstring ptr)
declare sub jit_dump_insn cdecl alias "jit_dump_insn" (byval stream as FILE ptr, byval func as jit_function_t, byval insn as jit_insn_t)
declare sub jit_dump_function cdecl alias "jit_dump_function" (byval stream as FILE ptr, byval func as jit_function_t, byval name as zstring ptr)

#endif
