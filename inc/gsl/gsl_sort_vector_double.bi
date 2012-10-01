''
''
'' gsl_sort_vector_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_vector_double_bi__
#define __gsl_sort_vector_double_bi__

#include once "gsl_errno.bi"
#include once "gsl_permutation.bi"
#include once "gsl_vector_double.bi"
#include once "gsl_types.bi"

extern "c"
declare sub gsl_sort_vector (byval v as gsl_vector ptr)
declare function gsl_sort_vector_index (byval p as gsl_permutation ptr, byval v as gsl_vector ptr) as integer
declare function gsl_sort_vector_smallest (byval dest as double ptr, byval k as integer, byval v as gsl_vector ptr) as integer
declare function gsl_sort_vector_largest (byval dest as double ptr, byval k as integer, byval v as gsl_vector ptr) as integer
declare function gsl_sort_vector_smallest_index (byval p as integer ptr, byval k as integer, byval v as gsl_vector ptr) as integer
declare function gsl_sort_vector_largest_index (byval p as integer ptr, byval k as integer, byval v as gsl_vector ptr) as integer
end extern

#endif
