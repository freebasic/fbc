''
''
'' gsl_heapsort -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_heapsort_bi__
#define __gsl_heapsort_bi__

#include once "gsl_permutation.bi"
#include once "gsl_types.bi"

type gsl_comparison_fn_t as function cdecl(byval as any ptr, byval as any ptr) as integer

extern "c"
declare sub gsl_heapsort (byval array as any ptr, byval count as integer, byval size as integer, byval compare as gsl_comparison_fn_t)
declare function gsl_heapsort_index (byval p as integer ptr, byval array as any ptr, byval count as integer, byval size as integer, byval compare as gsl_comparison_fn_t) as integer
end extern

#endif
