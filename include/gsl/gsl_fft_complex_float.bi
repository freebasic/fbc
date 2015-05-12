''
''
'' gsl_fft_complex_float -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_fft_complex_float_bi__
#define __gsl_fft_complex_float_bi__

#include once "gsl_math.bi"
#include once "gsl_complex.bi"
#include once "gsl_fft.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_fft_complex_float_radix2_forward (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_float_radix2_backward (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_float_radix2_inverse (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_float_radix2_transform (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer, byval sign as gsl_fft_direction) as integer
declare function gsl_fft_complex_float_radix2_dif_forward (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_float_radix2_dif_backward (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_float_radix2_dif_inverse (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_float_radix2_dif_transform (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer, byval sign as gsl_fft_direction) as integer
end extern

type gsl_fft_complex_wavetable_float
	n as integer
	nf as integer
	factor(0 to 64-1) as integer
	twiddle(0 to 64-1) as gsl_complex_float ptr
	trig as gsl_complex_float ptr
end type

type gsl_fft_complex_workspace_float
	n as integer
	scratch as single ptr
end type

extern "c"
declare function gsl_fft_complex_wavetable_float_alloc (byval n as integer) as gsl_fft_complex_wavetable_float ptr
declare sub gsl_fft_complex_wavetable_float_free (byval wavetable as gsl_fft_complex_wavetable_float ptr)
declare function gsl_fft_complex_workspace_float_alloc (byval n as integer) as gsl_fft_complex_workspace_float ptr
declare sub gsl_fft_complex_workspace_float_free (byval workspace as gsl_fft_complex_workspace_float ptr)
declare function gsl_fft_complex_float_memcpy (byval dest as gsl_fft_complex_wavetable_float ptr, byval src as gsl_fft_complex_wavetable_float ptr) as integer
declare function gsl_fft_complex_float_forward (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_complex_wavetable_float ptr, byval work as gsl_fft_complex_workspace_float ptr) as integer
declare function gsl_fft_complex_float_backward (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_complex_wavetable_float ptr, byval work as gsl_fft_complex_workspace_float ptr) as integer
declare function gsl_fft_complex_float_inverse (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_complex_wavetable_float ptr, byval work as gsl_fft_complex_workspace_float ptr) as integer
declare function gsl_fft_complex_float_transform (byval data as gsl_complex_packed_array_float, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_complex_wavetable_float ptr, byval work as gsl_fft_complex_workspace_float ptr, byval sign as gsl_fft_direction) as integer
end extern

#endif
