''
''
'' gsl_sort_vector_float -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_vector_float_bi__
#define __gsl_sort_vector_float_bi__

#include once "gsl_errno.bi"
#include once "gsl_permutation.bi"
#include once "gsl_vector_float.bi"
#include once "gsl_types.bi"

extern "c"
declare sub gsl_sort_vector_float (byval v as gsl_vector_float ptr)
declare function gsl_sort_vector_float_index (byval p as gsl_permutation ptr, byval v as gsl_vector_float ptr) as integer
declare function gsl_sort_vector_float_smallest (byval dest as single ptr, byval k as integer, byval v as gsl_vector_float ptr) as integer
declare function gsl_sort_vector_float_largest (byval dest as single ptr, byval k as integer, byval v as gsl_vector_float ptr) as integer
declare function gsl_sort_vector_float_smallest_index (byval p as integer ptr, byval k as integer, byval v as gsl_vector_float ptr) as integer
declare function gsl_sort_vector_float_largest_index (byval p as integer ptr, byval k as integer, byval v as gsl_vector_float ptr) as integer
end extern

#endif
