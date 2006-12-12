''
''
'' gsl_sort_long_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_long_double_bi__
#define __gsl_sort_long_double_bi__

#include once "gsl_errno.bi"
#include once "gsl_permutation.bi"
#include once "gsl_types.bi"

extern "c"
declare sub gsl_sort_long_double (byval data as double ptr, byval stride as integer, byval n as integer)
declare sub gsl_sort_long_double_index (byval p as integer ptr, byval data as double ptr, byval stride as integer, byval n as integer)
declare function gsl_sort_long_double_smallest (byval dest as double ptr, byval k as integer, byval src as double ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_long_double_smallest_index (byval p as integer ptr, byval k as integer, byval src as double ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_long_double_largest (byval dest as double ptr, byval k as integer, byval src as double ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_long_double_largest_index (byval p as integer ptr, byval k as integer, byval src as double ptr, byval stride as integer, byval n as integer) as integer
end extern

#endif
