''
''
'' gsl_histogram2d -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_histogram2d_bi__
#define __gsl_histogram2d_bi__

#include once "gsl_types.bi"

type gsl_histogram2d
	nx as integer
	ny as integer
	xrange as double ptr
	yrange as double ptr
	bin as double ptr
end type

type gsl_histogram2d_pdf
	nx as integer
	ny as integer
	xrange as double ptr
	yrange as double ptr
	sum as double ptr
end type

extern "c"
declare function gsl_histogram2d_alloc (byval nx as integer, byval ny as integer) as gsl_histogram2d ptr
declare function gsl_histogram2d_calloc (byval nx as integer, byval ny as integer) as gsl_histogram2d ptr
declare function gsl_histogram2d_calloc_uniform (byval nx as integer, byval ny as integer, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double) as gsl_histogram2d ptr
declare sub gsl_histogram2d_free (byval h as gsl_histogram2d ptr)
declare function gsl_histogram2d_increment (byval h as gsl_histogram2d ptr, byval x as double, byval y as double) as integer
declare function gsl_histogram2d_accumulate (byval h as gsl_histogram2d ptr, byval x as double, byval y as double, byval weight as double) as integer
declare function gsl_histogram2d_find (byval h as gsl_histogram2d ptr, byval x as double, byval y as double, byval i as integer ptr, byval j as integer ptr) as integer
declare function gsl_histogram2d_get (byval h as gsl_histogram2d ptr, byval i as integer, byval j as integer) as double
declare function gsl_histogram2d_get_xrange (byval h as gsl_histogram2d ptr, byval i as integer, byval xlower as double ptr, byval xupper as double ptr) as integer
declare function gsl_histogram2d_get_yrange (byval h as gsl_histogram2d ptr, byval j as integer, byval ylower as double ptr, byval yupper as double ptr) as integer
declare function gsl_histogram2d_xmax (byval h as gsl_histogram2d ptr) as double
declare function gsl_histogram2d_xmin (byval h as gsl_histogram2d ptr) as double
declare function gsl_histogram2d_nx (byval h as gsl_histogram2d ptr) as integer
declare function gsl_histogram2d_ymax (byval h as gsl_histogram2d ptr) as double
declare function gsl_histogram2d_ymin (byval h as gsl_histogram2d ptr) as double
declare function gsl_histogram2d_ny (byval h as gsl_histogram2d ptr) as integer
declare sub gsl_histogram2d_reset (byval h as gsl_histogram2d ptr)
declare function gsl_histogram2d_calloc_range (byval nx as integer, byval ny as integer, byval xrange as double ptr, byval yrange as double ptr) as gsl_histogram2d ptr
declare function gsl_histogram2d_set_ranges_uniform (byval h as gsl_histogram2d ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double) as integer
declare function gsl_histogram2d_set_ranges (byval h as gsl_histogram2d ptr, byval xrange as double ptr, byval xsize as integer, byval yrange as double ptr, byval ysize as integer) as integer
declare function gsl_histogram2d_memcpy (byval dest as gsl_histogram2d ptr, byval source as gsl_histogram2d ptr) as integer
declare function gsl_histogram2d_clone (byval source as gsl_histogram2d ptr) as gsl_histogram2d ptr
declare function gsl_histogram2d_max_val (byval h as gsl_histogram2d ptr) as double
declare sub gsl_histogram2d_max_bin (byval h as gsl_histogram2d ptr, byval i as integer ptr, byval j as integer ptr)
declare function gsl_histogram2d_min_val (byval h as gsl_histogram2d ptr) as double
declare sub gsl_histogram2d_min_bin (byval h as gsl_histogram2d ptr, byval i as integer ptr, byval j as integer ptr)
declare function gsl_histogram2d_xmean (byval h as gsl_histogram2d ptr) as double
declare function gsl_histogram2d_ymean (byval h as gsl_histogram2d ptr) as double
declare function gsl_histogram2d_xsigma (byval h as gsl_histogram2d ptr) as double
declare function gsl_histogram2d_ysigma (byval h as gsl_histogram2d ptr) as double
declare function gsl_histogram2d_cov (byval h as gsl_histogram2d ptr) as double
declare function gsl_histogram2d_sum (byval h as gsl_histogram2d ptr) as double
declare function gsl_histogram2d_equal_bins_p (byval h1 as gsl_histogram2d ptr, byval h2 as gsl_histogram2d ptr) as integer
declare function gsl_histogram2d_add (byval h1 as gsl_histogram2d ptr, byval h2 as gsl_histogram2d ptr) as integer
declare function gsl_histogram2d_sub (byval h1 as gsl_histogram2d ptr, byval h2 as gsl_histogram2d ptr) as integer
declare function gsl_histogram2d_mul (byval h1 as gsl_histogram2d ptr, byval h2 as gsl_histogram2d ptr) as integer
declare function gsl_histogram2d_div (byval h1 as gsl_histogram2d ptr, byval h2 as gsl_histogram2d ptr) as integer
declare function gsl_histogram2d_scale (byval h as gsl_histogram2d ptr, byval scale as double) as integer
declare function gsl_histogram2d_shift (byval h as gsl_histogram2d ptr, byval shift as double) as integer
declare function gsl_histogram2d_fwrite (byval stream as FILE ptr, byval h as gsl_histogram2d ptr) as integer
declare function gsl_histogram2d_fread (byval stream as FILE ptr, byval h as gsl_histogram2d ptr) as integer
declare function gsl_histogram2d_fprintf (byval stream as FILE ptr, byval h as gsl_histogram2d ptr, byval range_format as zstring ptr, byval bin_format as zstring ptr) as integer
declare function gsl_histogram2d_fscanf (byval stream as FILE ptr, byval h as gsl_histogram2d ptr) as integer
declare function gsl_histogram2d_pdf_alloc (byval nx as integer, byval ny as integer) as gsl_histogram2d_pdf ptr
declare function gsl_histogram2d_pdf_init (byval p as gsl_histogram2d_pdf ptr, byval h as gsl_histogram2d ptr) as integer
declare sub gsl_histogram2d_pdf_free (byval p as gsl_histogram2d_pdf ptr)
declare function gsl_histogram2d_pdf_sample (byval p as gsl_histogram2d_pdf ptr, byval r1 as double, byval r2 as double, byval x as double ptr, byval y as double ptr) as integer
end extern

#endif
