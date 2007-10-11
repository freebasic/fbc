''
''
'' gsl_sort_char -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sort_char_bi__
#define __gsl_sort_char_bi__

#include once "gsl_errno.bi"
#include once "gsl_permutation.bi"
#include once "gsl_types.bi"

extern "c"
declare sub gsl_sort_char (byval data as zstring ptr, byval stride as integer, byval n as integer)
declare sub gsl_sort_char_index (byval p as integer ptr, byval data as zstring ptr, byval stride as integer, byval n as integer)
declare function gsl_sort_char_smallest (byval dest as zstring ptr, byval k as integer, byval src as zstring ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_char_smallest_index (byval p as integer ptr, byval k as integer, byval src as zstring ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_char_largest (byval dest as zstring ptr, byval k as integer, byval src as zstring ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_sort_char_largest_index (byval p as integer ptr, byval k as integer, byval src as zstring ptr, byval stride as integer, byval n as integer) as integer
end extern

#endif
