''
''
'' gsl_fft_real -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_fft_real_bi__
#define __gsl_fft_real_bi__

#include once "gsl_math.bi"
#include once "gsl_complex.bi"
#include once "gsl_fft.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_fft_real_radix2_transform (byval data as double ptr, byval stride as integer, byval n as integer) as integer
end extern

type gsl_fft_real_wavetable
	n as integer
	nf as integer
	factor(0 to 64-1) as integer
	twiddle(0 to 64-1) as gsl_complex ptr
	trig as gsl_complex ptr
end type

type gsl_fft_real_workspace
	n as integer
	scratch as double ptr
end type

extern "c"
declare function gsl_fft_real_wavetable_alloc (byval n as integer) as gsl_fft_real_wavetable ptr
declare sub gsl_fft_real_wavetable_free (byval wavetable as gsl_fft_real_wavetable ptr)
declare function gsl_fft_real_workspace_alloc (byval n as integer) as gsl_fft_real_workspace ptr
declare sub gsl_fft_real_workspace_free (byval workspace as gsl_fft_real_workspace ptr)
declare function gsl_fft_real_transform (byval data as double ptr, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_real_wavetable ptr, byval work as gsl_fft_real_workspace ptr) as integer
declare function gsl_fft_real_unpack (byval real_coefficient as double ptr, byval complex_coefficient as double ptr, byval stride as integer, byval n as integer) as integer
end extern

#endif
