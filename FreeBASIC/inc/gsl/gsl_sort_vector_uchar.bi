''
''
'' gsl_sort_vector_uchar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_vector_uchar_bi__
#define __gsl_sort_vector_uchar_bi__

#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_permutation.bi"
#include once "gsl/gsl_vector_uchar.bi"
#include once "gsl/gsl_types.bi"

declare sub gsl_sort_vector_uchar cdecl alias "gsl_sort_vector_uchar" (byval v as gsl_vector_uchar ptr)
declare function gsl_sort_vector_uchar_index cdecl alias "gsl_sort_vector_uchar_index" (byval p as gsl_permutation ptr, byval v as gsl_vector_uchar ptr) as integer
declare function gsl_sort_vector_uchar_smallest cdecl alias "gsl_sort_vector_uchar_smallest" (byval dest as ubyte ptr, byval k as integer, byval v as gsl_vector_uchar ptr) as integer
declare function gsl_sort_vector_uchar_largest cdecl alias "gsl_sort_vector_uchar_largest" (byval dest as ubyte ptr, byval k as integer, byval v as gsl_vector_uchar ptr) as integer
declare function gsl_sort_vector_uchar_smallest_index cdecl alias "gsl_sort_vector_uchar_smallest_index" (byval p as integer ptr, byval k as integer, byval v as gsl_vector_uchar ptr) as integer
declare function gsl_sort_vector_uchar_largest_index cdecl alias "gsl_sort_vector_uchar_largest_index" (byval p as integer ptr, byval k as integer, byval v as gsl_vector_uchar ptr) as integer

#endif
