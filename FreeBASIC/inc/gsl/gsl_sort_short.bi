''
''
'' gsl_sort_short -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_short_bi__
#define __gsl_sort_short_bi__

#include once "gsl_errno.bi"
#include once "gsl_permutation.bi"
#include once "gsl_types.bi"

extern "c"
declare sub gsl_sort_short (byval data as short ptr, byval stride as integer, byval n as integer)
declare sub gsl_sort_short_index (byval p as integer ptr, byval data as short ptr, byval stride as integer, byval n as integer)
declare function gsl_sort_short_smallest (byval dest as short ptr, byval k as integer, byval src as short ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_short_smallest_index (byval p as integer ptr, byval k as integer, byval src as short ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_short_largest (byval dest as short ptr, byval k as integer, byval src as short ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_short_largest_index (byval p as integer ptr, byval k as integer, byval src as short ptr, byval stride as integer, byval n as integer) as integer
end extern

#endif
