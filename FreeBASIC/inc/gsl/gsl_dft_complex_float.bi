''
''
'' gsl_dft_complex_float -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_dft_complex_float_bi__
#define __gsl_dft_complex_float_bi__

#include once "gsl/gsl_math.bi"
#include once "gsl/gsl_complex.bi"
#include once "gsl/gsl_fft.bi"
#include once "gsl/gsl_types.bi"

declare function gsl_dft_complex_float_forward cdecl alias "gsl_dft_complex_float_forward" (byval data as single ptr, byval stride as integer, byval n as integer, byval result as single ptr) as integer
declare function gsl_dft_complex_float_backward cdecl alias "gsl_dft_complex_float_backward" (byval data as single ptr, byval stride as integer, byval n as integer, byval result as single ptr) as integer
declare function gsl_dft_complex_float_inverse cdecl alias "gsl_dft_complex_float_inverse" (byval data as single ptr, byval stride as integer, byval n as integer, byval result as single ptr) as integer
declare function gsl_dft_complex_float_transform cdecl alias "gsl_dft_complex_float_transform" (byval data as single ptr, byval stride as integer, byval n as integer, byval result as single ptr, byval sign as gsl_fft_direction) as integer

#endif
