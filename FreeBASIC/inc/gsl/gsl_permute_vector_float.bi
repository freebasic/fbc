''
''
'' gsl_permute_vector_float -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_permute_vector_float_bi__
#define __gsl_permute_vector_float_bi__

#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_permutation.bi"
#include once "gsl/gsl_vector_float.bi"
#include once "gsl/gsl_types.bi"

declare function gsl_permute_vector_float cdecl alias "gsl_permute_vector_float" (byval p as gsl_permutation ptr, byval v as gsl_vector_float ptr) as integer
declare function gsl_permute_vector_float_inverse cdecl alias "gsl_permute_vector_float_inverse" (byval p as gsl_permutation ptr, byval v as gsl_vector_float ptr) as integer

#endif
