'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   complex/gsl_complex_math.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004, 2007 Jorma Olavi Tähtinen, Brian Gough
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 3 of the License, or (at
''   your option) any later version.
''
''   This program is distributed in the hope that it will be useful, but
''   WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
''
'' translated to FreeBASIC by:
''   Copyright Â© 2015 FreeBASIC development team

#pragma once

#include once "gsl/gsl_inline.bi"
#include once "gsl/gsl_complex.bi"

extern "C"

#define __GSL_COMPLEX_MATH_H__
declare function gsl_complex_polar(byval r as double, byval theta as double) as gsl_complex
declare function gsl_complex_rect(byval x as double, byval y as double) as gsl_complex
#define GSL_COMPLEX_ONE gsl_complex_rect(1.0, 0.0)
#define GSL_COMPLEX_ZERO gsl_complex_rect(0.0, 0.0)
#define GSL_COMPLEX_NEGONE gsl_complex_rect(-1.0, 0.0)

declare function gsl_complex_arg(byval z as gsl_complex) as double
declare function gsl_complex_abs(byval z as gsl_complex) as double
declare function gsl_complex_abs2(byval z as gsl_complex) as double
declare function gsl_complex_logabs(byval z as gsl_complex) as double
declare function gsl_complex_add(byval a as gsl_complex, byval b as gsl_complex) as gsl_complex
declare function gsl_complex_sub(byval a as gsl_complex, byval b as gsl_complex) as gsl_complex
declare function gsl_complex_mul(byval a as gsl_complex, byval b as gsl_complex) as gsl_complex
declare function gsl_complex_div(byval a as gsl_complex, byval b as gsl_complex) as gsl_complex
declare function gsl_complex_add_real(byval a as gsl_complex, byval x as double) as gsl_complex
declare function gsl_complex_sub_real(byval a as gsl_complex, byval x as double) as gsl_complex
declare function gsl_complex_mul_real(byval a as gsl_complex, byval x as double) as gsl_complex
declare function gsl_complex_div_real(byval a as gsl_complex, byval x as double) as gsl_complex
declare function gsl_complex_add_imag(byval a as gsl_complex, byval y as double) as gsl_complex
declare function gsl_complex_sub_imag(byval a as gsl_complex, byval y as double) as gsl_complex
declare function gsl_complex_mul_imag(byval a as gsl_complex, byval y as double) as gsl_complex
declare function gsl_complex_div_imag(byval a as gsl_complex, byval y as double) as gsl_complex
declare function gsl_complex_conjugate(byval z as gsl_complex) as gsl_complex
declare function gsl_complex_inverse(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_negative(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_sqrt(byval z as gsl_complex) as gsl_complex
declare function gsl_complex_sqrt_real(byval x as double) as gsl_complex
declare function gsl_complex_pow(byval a as gsl_complex, byval b as gsl_complex) as gsl_complex
declare function gsl_complex_pow_real(byval a as gsl_complex, byval b as double) as gsl_complex
declare function gsl_complex_exp(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_log(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_log10(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_log_b(byval a as gsl_complex, byval b as gsl_complex) as gsl_complex
declare function gsl_complex_sin(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_cos(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_sec(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_csc(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_tan(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_cot(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arcsin(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arcsin_real(byval a as double) as gsl_complex
declare function gsl_complex_arccos(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arccos_real(byval a as double) as gsl_complex
declare function gsl_complex_arcsec(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arcsec_real(byval a as double) as gsl_complex
declare function gsl_complex_arccsc(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arccsc_real(byval a as double) as gsl_complex
declare function gsl_complex_arctan(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arccot(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_sinh(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_cosh(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_sech(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_csch(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_tanh(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_coth(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arcsinh(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arccosh(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arccosh_real(byval a as double) as gsl_complex
declare function gsl_complex_arcsech(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arccsch(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arctanh(byval a as gsl_complex) as gsl_complex
declare function gsl_complex_arctanh_real(byval a as double) as gsl_complex
declare function gsl_complex_arccoth(byval a as gsl_complex) as gsl_complex

end extern
