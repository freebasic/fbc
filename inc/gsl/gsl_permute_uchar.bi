''
''
'' gsl_permute_uchar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_permute_uchar_bi__
#define __gsl_permute_uchar_bi__

#include once "gsl_errno.bi"
#include once "gsl_permutation.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_permute_uchar (byval p as integer ptr, byval data as ubyte ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_permute_uchar_inverse (byval p as integer ptr, byval data as ubyte ptr, byval stride as integer, byval n as integer) as integer
end extern

#endif
