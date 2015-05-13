''
''
'' cst_ss -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_ss_bi__
#define __cst_ss_bi__

type cst_ss_struct
	num_samples as double
	sum as double
	sumx as double
end type

type cst_ss as cst_ss_struct

declare function new_ss cdecl alias "new_ss" () as cst_ss ptr
declare sub delete_ss cdecl alias "delete_ss" (byval ss as cst_ss ptr)
declare sub ss_reset cdecl alias "ss_reset" (byval ss as cst_ss ptr)
declare function ss_mean cdecl alias "ss_mean" (byval ss as cst_ss ptr) as double
declare function ss_variance cdecl alias "ss_variance" (byval ss as cst_ss ptr) as double
declare function ss_stddev cdecl alias "ss_stddev" (byval ss as cst_ss ptr) as double
declare sub ss_cummulate cdecl alias "ss_cummulate" (byval ss as cst_ss ptr, byval a as double)
declare sub ss_cummulate_n cdecl alias "ss_cummulate_n" (byval ss as cst_ss ptr, byval a as double, byval count as double)

#endif
