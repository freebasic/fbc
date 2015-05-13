''
''
'' gsl_sort_vector_uint -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_vector_uint_bi__
#define __gsl_sort_vector_uint_bi__

#include once "gsl_errno.bi"
#include once "gsl_permutation.bi"
#include once "gsl_vector_uint.bi"
#include once "gsl_types.bi"

extern "c"
declare sub gsl_sort_vector_uint (byval v as gsl_vector_uint ptr)
declare function gsl_sort_vector_uint_index (byval p as gsl_permutation ptr, byval v as gsl_vector_uint ptr) as integer
declare function gsl_sort_vector_uint_smallest (byval dest as uinteger ptr, byval k as integer, byval v as gsl_vector_uint ptr) as integer
declare function gsl_sort_vector_uint_largest (byval dest as uinteger ptr, byval k as integer, byval v as gsl_vector_uint ptr) as integer
declare function gsl_sort_vector_uint_smallest_index (byval p as integer ptr, byval k as integer, byval v as gsl_vector_uint ptr) as integer
declare function gsl_sort_vector_uint_largest_index (byval p as integer ptr, byval k as integer, byval v as gsl_vector_uint ptr) as integer
end extern

#endif
