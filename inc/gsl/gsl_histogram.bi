'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   histogram/gsl_histogram.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Brian Gough
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
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stdlib.bi"
#include once "crt/stdio.bi"

extern "C"

#define __GSL_HISTOGRAM_H__

type gsl_histogram
	n as uinteger
	range as double ptr
	bin as double ptr
end type

type gsl_histogram_pdf
	n as uinteger
	range as double ptr
	sum as double ptr
end type

declare function gsl_histogram_alloc(byval n as uinteger) as gsl_histogram ptr
declare function gsl_histogram_calloc(byval n as uinteger) as gsl_histogram ptr
declare function gsl_histogram_calloc_uniform(byval n as const uinteger, byval xmin as const double, byval xmax as const double) as gsl_histogram ptr
declare sub gsl_histogram_free(byval h as gsl_histogram ptr)
declare function gsl_histogram_increment(byval h as gsl_histogram ptr, byval x as double) as long
declare function gsl_histogram_accumulate(byval h as gsl_histogram ptr, byval x as double, byval weight as double) as long
declare function gsl_histogram_find(byval h as const gsl_histogram ptr, byval x as const double, byval i as uinteger ptr) as long
declare function gsl_histogram_get(byval h as const gsl_histogram ptr, byval i as uinteger) as double
declare function gsl_histogram_get_range(byval h as const gsl_histogram ptr, byval i as uinteger, byval lower as double ptr, byval upper as double ptr) as long
declare function gsl_histogram_max(byval h as const gsl_histogram ptr) as double
declare function gsl_histogram_min(byval h as const gsl_histogram ptr) as double
declare function gsl_histogram_bins(byval h as const gsl_histogram ptr) as uinteger
declare sub gsl_histogram_reset(byval h as gsl_histogram ptr)
declare function gsl_histogram_calloc_range(byval n as uinteger, byval range as double ptr) as gsl_histogram ptr
declare function gsl_histogram_set_ranges(byval h as gsl_histogram ptr, byval range as const double ptr, byval size as uinteger) as long
declare function gsl_histogram_set_ranges_uniform(byval h as gsl_histogram ptr, byval xmin as double, byval xmax as double) as long
declare function gsl_histogram_memcpy(byval dest as gsl_histogram ptr, byval source as const gsl_histogram ptr) as long
declare function gsl_histogram_clone(byval source as const gsl_histogram ptr) as gsl_histogram ptr
declare function gsl_histogram_max_val(byval h as const gsl_histogram ptr) as double
declare function gsl_histogram_max_bin(byval h as const gsl_histogram ptr) as uinteger
declare function gsl_histogram_min_val(byval h as const gsl_histogram ptr) as double
declare function gsl_histogram_min_bin(byval h as const gsl_histogram ptr) as uinteger
declare function gsl_histogram_equal_bins_p(byval h1 as const gsl_histogram ptr, byval h2 as const gsl_histogram ptr) as long
declare function gsl_histogram_add(byval h1 as gsl_histogram ptr, byval h2 as const gsl_histogram ptr) as long
declare function gsl_histogram_sub(byval h1 as gsl_histogram ptr, byval h2 as const gsl_histogram ptr) as long
declare function gsl_histogram_mul(byval h1 as gsl_histogram ptr, byval h2 as const gsl_histogram ptr) as long
declare function gsl_histogram_div(byval h1 as gsl_histogram ptr, byval h2 as const gsl_histogram ptr) as long
declare function gsl_histogram_scale(byval h as gsl_histogram ptr, byval scale as double) as long
declare function gsl_histogram_shift(byval h as gsl_histogram ptr, byval shift as double) as long
declare function gsl_histogram_sigma(byval h as const gsl_histogram ptr) as double
declare function gsl_histogram_mean(byval h as const gsl_histogram ptr) as double
declare function gsl_histogram_sum(byval h as const gsl_histogram ptr) as double
declare function gsl_histogram_fwrite(byval stream as FILE ptr, byval h as const gsl_histogram ptr) as long
declare function gsl_histogram_fread(byval stream as FILE ptr, byval h as gsl_histogram ptr) as long
declare function gsl_histogram_fprintf(byval stream as FILE ptr, byval h as const gsl_histogram ptr, byval range_format as const zstring ptr, byval bin_format as const zstring ptr) as long
declare function gsl_histogram_fscanf(byval stream as FILE ptr, byval h as gsl_histogram ptr) as long
declare function gsl_histogram_pdf_alloc(byval n as const uinteger) as gsl_histogram_pdf ptr
declare function gsl_histogram_pdf_init(byval p as gsl_histogram_pdf ptr, byval h as const gsl_histogram ptr) as long
declare sub gsl_histogram_pdf_free(byval p as gsl_histogram_pdf ptr)
declare function gsl_histogram_pdf_sample(byval p as const gsl_histogram_pdf ptr, byval r as double) as double

end extern
