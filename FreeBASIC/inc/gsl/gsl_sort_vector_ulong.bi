''
''
'' gsl_sort_vector_ulong -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_vector_ulong_bi__
#define __gsl_sort_vector_ulong_bi__

#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_permutation.bi"
#include once "gsl/gsl_vector_ulong.bi"
#include once "gsl/gsl_types.bi"

declare sub gsl_sort_vector_ulong cdecl alias "gsl_sort_vector_ulong" (byval v as gsl_vector_ulong ptr)
declare function gsl_sort_vector_ulong_index cdecl alias "gsl_sort_vector_ulong_index" (byval p as gsl_permutation ptr, byval v as gsl_vector_ulong ptr) as integer
declare function gsl_sort_vector_ulong_smallest cdecl alias "gsl_sort_vector_ulong_smallest" (byval dest as uinteger ptr, byval k as integer, byval v as gsl_vector_ulong ptr) as integer
declare function gsl_sort_vector_ulong_largest cdecl alias "gsl_sort_vector_ulong_largest" (byval dest as uinteger ptr, byval k as integer, byval v as gsl_vector_ulong ptr) as integer
declare function gsl_sort_vector_ulong_smallest_index cdecl alias "gsl_sort_vector_ulong_smallest_index" (byval p as integer ptr, byval k as integer, byval v as gsl_vector_ulong ptr) as integer
declare function gsl_sort_vector_ulong_largest_index cdecl alias "gsl_sort_vector_ulong_largest_index" (byval p as integer ptr, byval k as integer, byval v as gsl_vector_ulong ptr) as integer

#endif
