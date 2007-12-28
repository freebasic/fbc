''
''
'' gsl_sort_int -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_int_bi__
#define __gsl_sort_int_bi__

#include once "gsl_errno.bi"
#include once "gsl_permutation.bi"
#include once "gsl_types.bi"

extern "c"
declare sub gsl_sort_int (byval data as integer ptr, byval stride as integer, byval n as integer)
declare sub gsl_sort_int_index (byval p as integer ptr, byval data as integer ptr, byval stride as integer, byval n as integer)
declare function gsl_sort_int_smallest (byval dest as integer ptr, byval k as integer, byval src as integer ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_int_smallest_index (byval p as integer ptr, byval k as integer, byval src as integer ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_int_largest (byval dest as integer ptr, byval k as integer, byval src as integer ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_int_largest_index (byval p as integer ptr, byval k as integer, byval src as integer ptr, byval stride as integer, byval n as integer) as integer
end extern

#endif
