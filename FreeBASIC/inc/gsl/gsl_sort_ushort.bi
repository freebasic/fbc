''
''
'' gsl_sort_ushort -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_ushort_bi__
#define __gsl_sort_ushort_bi__

#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_permutation.bi"
#include once "gsl/gsl_types.bi"

declare sub gsl_sort_ushort cdecl alias "gsl_sort_ushort" (byval data as ushort ptr, byval stride as integer, byval n as integer)
declare sub gsl_sort_ushort_index cdecl alias "gsl_sort_ushort_index" (byval p as integer ptr, byval data as ushort ptr, byval stride as integer, byval n as integer)
declare function gsl_sort_ushort_smallest cdecl alias "gsl_sort_ushort_smallest" (byval dest as ushort ptr, byval k as integer, byval src as ushort ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_ushort_smallest_index cdecl alias "gsl_sort_ushort_smallest_index" (byval p as integer ptr, byval k as integer, byval src as ushort ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_ushort_largest cdecl alias "gsl_sort_ushort_largest" (byval dest as ushort ptr, byval k as integer, byval src as ushort ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_ushort_largest_index cdecl alias "gsl_sort_ushort_largest_index" (byval p as integer ptr, byval k as integer, byval src as ushort ptr, byval stride as integer, byval n as integer) as integer

#endif
