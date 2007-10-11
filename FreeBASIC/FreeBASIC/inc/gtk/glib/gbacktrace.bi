''
''
'' gbacktrace -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gbacktrace_bi__
#define __gbacktrace_bi__

#include once "gtypes.bi"

declare sub g_on_error_query (byval prg_name as zstring ptr)
declare sub g_on_error_stack_trace (byval prg_name as zstring ptr)

#endif
