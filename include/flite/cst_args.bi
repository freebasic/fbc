''
''
'' cst_args -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_args_bi__
#define __cst_args_bi__

declare function cst_args cdecl alias "cst_args" (byval argv as byte ptr ptr, byval argc as integer, byval description as zstring ptr, byval args as cst_features ptr) as cst_val ptr

#endif
