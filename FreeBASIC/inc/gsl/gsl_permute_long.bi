''
''
'' gsl_permute_long -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_permute_long_bi__
#define __gsl_permute_long_bi__

#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_permutation.bi"
#include once "gsl/gsl_types.bi"

declare function gsl_permute_long cdecl alias "gsl_permute_long" (byval p as integer ptr, byval data as integer ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_permute_long_inverse cdecl alias "gsl_permute_long_inverse" (byval p as integer ptr, byval data as integer ptr, byval stride as integer, byval n as integer) as integer

#endif
