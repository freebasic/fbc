''
''
'' gsl_sort_float -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_float_bi__
#define __gsl_sort_float_bi__

#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_permutation.bi"
#include once "gsl/gsl_types.bi"

declare sub gsl_sort_float cdecl alias "gsl_sort_float" (byval data as single ptr, byval stride as integer, byval n as integer)
declare sub gsl_sort_float_index cdecl alias "gsl_sort_float_index" (byval p as integer ptr, byval data as single ptr, byval stride as integer, byval n as integer)
declare function gsl_sort_float_smallest cdecl alias "gsl_sort_float_smallest" (byval dest as single ptr, byval k as integer, byval src as single ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_float_smallest_index cdecl alias "gsl_sort_float_smallest_index" (byval p as integer ptr, byval k as integer, byval src as single ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_float_largest cdecl alias "gsl_sort_float_largest" (byval dest as single ptr, byval k as integer, byval src as single ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_float_largest_index cdecl alias "gsl_sort_float_largest_index" (byval p as integer ptr, byval k as integer, byval src as single ptr, byval stride as integer, byval n as integer) as integer

#endif
