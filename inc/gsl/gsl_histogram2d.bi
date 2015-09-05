'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   histogram/gsl_histogram2d.h
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

#define __GSL_HISTOGRAM2D_H__

type gsl_histogram2d
	nx as uinteger
	ny as uinteger
	xrange as double ptr
	yrange as double ptr
	bin as double ptr
end type

type gsl_histogram2d_pdf
	nx as uinteger
	ny as uinteger
	xrange as double ptr
	yrange as double ptr
	sum as double ptr
end type

declare function gsl_histogram2d_alloc(byval nx as const uinteger, byval ny as const uinteger) as gsl_histogram2d ptr
declare function gsl_histogram2d_calloc(byval nx as const uinteger, byval ny as const uinteger) as gsl_histogram2d ptr
declare function gsl_histogram2d_calloc_uniform(byval nx as const uinteger, byval ny as const uinteger, byval xmin as const double, byval xmax as const double, byval ymin as const double, byval ymax as const double) as gsl_histogram2d ptr
declare sub gsl_histogram2d_free(byval h as gsl_histogram2d ptr)
declare function gsl_histogram2d_increment(byval h as gsl_histogram2d ptr, byval x as double, byval y as double) as long
declare function gsl_histogram2d_accumulate(byval h as gsl_histogram2d ptr, byval x as double, byval y as double, byval weight as double) as long
declare function gsl_histogram2d_find(byval h as const gsl_histogram2d ptr, byval x as const double, byval y as const double, byval i as uinteger ptr, byval j as uinteger ptr) as long
declare function gsl_histogram2d_get(byval h as const gsl_histogram2d ptr, byval i as const uinteger, byval j as const uinteger) as double
declare function gsl_histogram2d_get_xrange(byval h as const gsl_histogram2d ptr, byval i as const uinteger, byval xlower as double ptr, byval xupper as double ptr) as long
declare function gsl_histogram2d_get_yrange(byval h as const gsl_histogram2d ptr, byval j as const uinteger, byval ylower as double ptr, byval yupper as double ptr) as long
declare function gsl_histogram2d_xmax(byval h as const gsl_histogram2d ptr) as double
declare function gsl_histogram2d_xmin(byval h as const gsl_histogram2d ptr) as double
declare function gsl_histogram2d_nx(byval h as const gsl_histogram2d ptr) as uinteger
declare function gsl_histogram2d_ymax(byval h as const gsl_histogram2d ptr) as double
declare function gsl_histogram2d_ymin(byval h as const gsl_histogram2d ptr) as double
declare function gsl_histogram2d_ny(byval h as const gsl_histogram2d ptr) as uinteger
declare sub gsl_histogram2d_reset(byval h as gsl_histogram2d ptr)
declare function gsl_histogram2d_calloc_range(byval nx as uinteger, byval ny as uinteger, byval xrange as double ptr, byval yrange as double ptr) as gsl_histogram2d ptr
declare function gsl_histogram2d_set_ranges_uniform(byval h as gsl_histogram2d ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double) as long
declare function gsl_histogram2d_set_ranges(byval h as gsl_histogram2d ptr, byval xrange as const double ptr, byval xsize as uinteger, byval yrange as const double ptr, byval ysize as uinteger) as long
declare function gsl_histogram2d_memcpy(byval dest as gsl_histogram2d ptr, byval source as const gsl_histogram2d ptr) as long
declare function gsl_histogram2d_clone(byval source as const gsl_histogram2d ptr) as gsl_histogram2d ptr
declare function gsl_histogram2d_max_val(byval h as const gsl_histogram2d ptr) as double
declare sub gsl_histogram2d_max_bin(byval h as const gsl_histogram2d ptr, byval i as uinteger ptr, byval j as uinteger ptr)
declare function gsl_histogram2d_min_val(byval h as const gsl_histogram2d ptr) as double
declare sub gsl_histogram2d_min_bin(byval h as const gsl_histogram2d ptr, byval i as uinteger ptr, byval j as uinteger ptr)
declare function gsl_histogram2d_xmean(byval h as const gsl_histogram2d ptr) as double
declare function gsl_histogram2d_ymean(byval h as const gsl_histogram2d ptr) as double
declare function gsl_histogram2d_xsigma(byval h as const gsl_histogram2d ptr) as double
declare function gsl_histogram2d_ysigma(byval h as const gsl_histogram2d ptr) as double
declare function gsl_histogram2d_cov(byval h as const gsl_histogram2d ptr) as double
declare function gsl_histogram2d_sum(byval h as const gsl_histogram2d ptr) as double
declare function gsl_histogram2d_equal_bins_p(byval h1 as const gsl_histogram2d ptr, byval h2 as const gsl_histogram2d ptr) as long
declare function gsl_histogram2d_add(byval h1 as gsl_histogram2d ptr, byval h2 as const gsl_histogram2d ptr) as long
declare function gsl_histogram2d_sub(byval h1 as gsl_histogram2d ptr, byval h2 as const gsl_histogram2d ptr) as long
declare function gsl_histogram2d_mul(byval h1 as gsl_histogram2d ptr, byval h2 as const gsl_histogram2d ptr) as long
declare function gsl_histogram2d_div(byval h1 as gsl_histogram2d ptr, byval h2 as const gsl_histogram2d ptr) as long
declare function gsl_histogram2d_scale(byval h as gsl_histogram2d ptr, byval scale as double) as long
declare function gsl_histogram2d_shift(byval h as gsl_histogram2d ptr, byval shift as double) as long
declare function gsl_histogram2d_fwrite(byval stream as FILE ptr, byval h as const gsl_histogram2d ptr) as long
declare function gsl_histogram2d_fread(byval stream as FILE ptr, byval h as gsl_histogram2d ptr) as long
declare function gsl_histogram2d_fprintf(byval stream as FILE ptr, byval h as const gsl_histogram2d ptr, byval range_format as const zstring ptr, byval bin_format as const zstring ptr) as long
declare function gsl_histogram2d_fscanf(byval stream as FILE ptr, byval h as gsl_histogram2d ptr) as long
declare function gsl_histogram2d_pdf_alloc(byval nx as const uinteger, byval ny as const uinteger) as gsl_histogram2d_pdf ptr
declare function gsl_histogram2d_pdf_init(byval p as gsl_histogram2d_pdf ptr, byval h as const gsl_histogram2d ptr) as long
declare sub gsl_histogram2d_pdf_free(byval p as gsl_histogram2d_pdf ptr)
declare function gsl_histogram2d_pdf_sample(byval p as const gsl_histogram2d_pdf ptr, byval r1 as double, byval r2 as double, byval x as double ptr, byval y as double ptr) as long

end extern
