''
''
'' gsl_fft_halfcomplex -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_fft_halfcomplex_bi__
#define __gsl_fft_halfcomplex_bi__

#include once "gsl_math.bi"
#include once "gsl_complex.bi"
#include once "gsl_fft.bi"
#include once "gsl_fft_real.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_fft_halfcomplex_radix2_backward (byval data as double ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_halfcomplex_radix2_inverse (byval data as double ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_halfcomplex_radix2_transform (byval data as double ptr, byval stride as integer, byval n as integer) as integer
end extern

type gsl_fft_halfcomplex_wavetable
	n as integer
	nf as integer
	factor(0 to 64-1) as integer
	twiddle(0 to 64-1) as gsl_complex ptr
	trig as gsl_complex ptr
end type

extern "c"
declare function gsl_fft_halfcomplex_wavetable_alloc (byval n as integer) as gsl_fft_halfcomplex_wavetable ptr
declare sub gsl_fft_halfcomplex_wavetable_free (byval wavetable as gsl_fft_halfcomplex_wavetable ptr)
declare function gsl_fft_halfcomplex_backward (byval data as double ptr, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_halfcomplex_wavetable ptr, byval work as gsl_fft_real_workspace ptr) as integer
declare function gsl_fft_halfcomplex_inverse (byval data as double ptr, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_halfcomplex_wavetable ptr, byval work as gsl_fft_real_workspace ptr) as integer
declare function gsl_fft_halfcomplex_transform (byval data as double ptr, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_halfcomplex_wavetable ptr, byval work as gsl_fft_real_workspace ptr) as integer
declare function gsl_fft_halfcomplex_unpack (byval halfcomplex_coefficient as double ptr, byval complex_coefficient as double ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_halfcomplex_radix2_unpack (byval halfcomplex_coefficient as double ptr, byval complex_coefficient as double ptr, byval stride as integer, byval n as integer) as integer
end extern

#endif
