''
''
'' gsl_fft_complex -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_fft_complex_bi__
#define __gsl_fft_complex_bi__

#include once "gsl/gsl_math.bi"
#include once "gsl/gsl_complex.bi"
#include once "gsl/gsl_fft.bi"
#include once "gsl/gsl_types.bi"

declare function gsl_fft_complex_radix2_forward cdecl alias "gsl_fft_complex_radix2_forward" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_radix2_backward cdecl alias "gsl_fft_complex_radix2_backward" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_radix2_inverse cdecl alias "gsl_fft_complex_radix2_inverse" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_radix2_transform cdecl alias "gsl_fft_complex_radix2_transform" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer, byval sign as gsl_fft_direction) as integer
declare function gsl_fft_complex_radix2_dif_forward cdecl alias "gsl_fft_complex_radix2_dif_forward" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_radix2_dif_backward cdecl alias "gsl_fft_complex_radix2_dif_backward" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_radix2_dif_inverse cdecl alias "gsl_fft_complex_radix2_dif_inverse" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer) as integer
declare function gsl_fft_complex_radix2_dif_transform cdecl alias "gsl_fft_complex_radix2_dif_transform" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer, byval sign as gsl_fft_direction) as integer

type gsl_fft_complex_wavetable
	n as integer
	nf as integer
	factor(0 to 64-1) as integer ptr
	twiddle(0 to 64-1) as gsl_complex ptr ptr
	trig as gsl_complex ptr
end type

type gsl_fft_complex_workspace
	n as integer
	scratch as double ptr
end type

declare function gsl_fft_complex_wavetable_alloc cdecl alias "gsl_fft_complex_wavetable_alloc" (byval n as integer) as gsl_fft_complex_wavetable ptr
declare sub gsl_fft_complex_wavetable_free cdecl alias "gsl_fft_complex_wavetable_free" (byval wavetable as gsl_fft_complex_wavetable ptr)
declare function gsl_fft_complex_workspace_alloc cdecl alias "gsl_fft_complex_workspace_alloc" (byval n as integer) as gsl_fft_complex_workspace ptr
declare sub gsl_fft_complex_workspace_free cdecl alias "gsl_fft_complex_workspace_free" (byval workspace as gsl_fft_complex_workspace ptr)
declare function gsl_fft_complex_memcpy cdecl alias "gsl_fft_complex_memcpy" (byval dest as gsl_fft_complex_wavetable ptr, byval src as gsl_fft_complex_wavetable ptr) as integer
declare function gsl_fft_complex_forward cdecl alias "gsl_fft_complex_forward" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_complex_wavetable ptr, byval work as gsl_fft_complex_workspace ptr) as integer
declare function gsl_fft_complex_backward cdecl alias "gsl_fft_complex_backward" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_complex_wavetable ptr, byval work as gsl_fft_complex_workspace ptr) as integer
declare function gsl_fft_complex_inverse cdecl alias "gsl_fft_complex_inverse" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_complex_wavetable ptr, byval work as gsl_fft_complex_workspace ptr) as integer
declare function gsl_fft_complex_transform cdecl alias "gsl_fft_complex_transform" (byval data as gsl_complex_packed_array, byval stride as integer, byval n as integer, byval wavetable as gsl_fft_complex_wavetable ptr, byval work as gsl_fft_complex_workspace ptr, byval sign as gsl_fft_direction) as integer

#endif
