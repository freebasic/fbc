''
''
'' gsl_sort_vector_short -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_vector_short_bi__
#define __gsl_sort_vector_short_bi__

#include once "gsl_errno.bi"
#include once "gsl_permutation.bi"
#include once "gsl_vector_short.bi"
#include once "gsl_types.bi"

extern "c"
declare sub gsl_sort_vector_short (byval v as gsl_vector_short ptr)
declare function gsl_sort_vector_short_index (byval p as gsl_permutation ptr, byval v as gsl_vector_short ptr) as integer
declare function gsl_sort_vector_short_smallest (byval dest as short ptr, byval k as integer, byval v as gsl_vector_short ptr) as integer
declare function gsl_sort_vector_short_largest (byval dest as short ptr, byval k as integer, byval v as gsl_vector_short ptr) as integer
declare function gsl_sort_vector_short_smallest_index (byval p as integer ptr, byval k as integer, byval v as gsl_vector_short ptr) as integer
declare function gsl_sort_vector_short_largest_index (byval p as integer ptr, byval k as integer, byval v as gsl_vector_short ptr) as integer
end extern

#endif
