''
''
'' cst_error -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_error_bi__
#define __cst_error_bi__
extern cst_errjmp alias "cst_errjmp" as jmp_buf ptr

declare function cst_errmsg cdecl alias "cst_errmsg" (byval fmt as zstring ptr, ...) as integer

#endif
