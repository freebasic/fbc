''
''
'' gsl_histogram -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_histogram_bi__
#define __gsl_histogram_bi__

#include once "gsl_types.bi"

type gsl_histogram
	n as integer
	range as double ptr
	bin as double ptr
end type

type gsl_histogram_pdf
	n as integer
	range as double ptr
	sum as double ptr
end type

extern "c"
declare function gsl_histogram_alloc (byval n as integer) as gsl_histogram ptr
declare function gsl_histogram_calloc (byval n as integer) as gsl_histogram ptr
declare function gsl_histogram_calloc_uniform (byval n as integer, byval xmin as double, byval xmax as double) as gsl_histogram ptr
declare sub gsl_histogram_free (byval h as gsl_histogram ptr)
declare function gsl_histogram_increment (byval h as gsl_histogram ptr, byval x as double) as integer
declare function gsl_histogram_accumulate (byval h as gsl_histogram ptr, byval x as double, byval weight as double) as integer
declare function gsl_histogram_find (byval h as gsl_histogram ptr, byval x as double, byval i as integer ptr) as integer
declare function gsl_histogram_get (byval h as gsl_histogram ptr, byval i as integer) as double
declare function gsl_histogram_get_range (byval h as gsl_histogram ptr, byval i as integer, byval lower as double ptr, byval upper as double ptr) as integer
declare function gsl_histogram_max (byval h as gsl_histogram ptr) as double
declare function gsl_histogram_min (byval h as gsl_histogram ptr) as double
declare function gsl_histogram_bins (byval h as gsl_histogram ptr) as integer
declare sub gsl_histogram_reset (byval h as gsl_histogram ptr)
declare function gsl_histogram_calloc_range (byval n as integer, byval range as double ptr) as gsl_histogram ptr
declare function gsl_histogram_set_ranges (byval h as gsl_histogram ptr, byval range as double ptr, byval size as integer) as integer
declare function gsl_histogram_set_ranges_uniform (byval h as gsl_histogram ptr, byval xmin as double, byval xmax as double) as integer
declare function gsl_histogram_memcpy (byval dest as gsl_histogram ptr, byval source as gsl_histogram ptr) as integer
declare function gsl_histogram_clone (byval source as gsl_histogram ptr) as gsl_histogram ptr
declare function gsl_histogram_max_val (byval h as gsl_histogram ptr) as double
declare function gsl_histogram_max_bin (byval h as gsl_histogram ptr) as integer
declare function gsl_histogram_min_val (byval h as gsl_histogram ptr) as double
declare function gsl_histogram_min_bin (byval h as gsl_histogram ptr) as integer
declare function gsl_histogram_equal_bins_p (byval h1 as gsl_histogram ptr, byval h2 as gsl_histogram ptr) as integer
declare function gsl_histogram_add (byval h1 as gsl_histogram ptr, byval h2 as gsl_histogram ptr) as integer
declare function gsl_histogram_sub (byval h1 as gsl_histogram ptr, byval h2 as gsl_histogram ptr) as integer
declare function gsl_histogram_mul (byval h1 as gsl_histogram ptr, byval h2 as gsl_histogram ptr) as integer
declare function gsl_histogram_div (byval h1 as gsl_histogram ptr, byval h2 as gsl_histogram ptr) as integer
declare function gsl_histogram_scale (byval h as gsl_histogram ptr, byval scale as double) as integer
declare function gsl_histogram_shift (byval h as gsl_histogram ptr, byval shift as double) as integer
declare function gsl_histogram_sigma (byval h as gsl_histogram ptr) as double
declare function gsl_histogram_mean (byval h as gsl_histogram ptr) as double
declare function gsl_histogram_sum (byval h as gsl_histogram ptr) as double
declare function gsl_histogram_fwrite (byval stream as FILE ptr, byval h as gsl_histogram ptr) as integer
declare function gsl_histogram_fread (byval stream as FILE ptr, byval h as gsl_histogram ptr) as integer
declare function gsl_histogram_fprintf (byval stream as FILE ptr, byval h as gsl_histogram ptr, byval range_format as zstring ptr, byval bin_format as zstring ptr) as integer
declare function gsl_histogram_fscanf (byval stream as FILE ptr, byval h as gsl_histogram ptr) as integer
declare function gsl_histogram_pdf_alloc (byval n as integer) as gsl_histogram_pdf ptr
declare function gsl_histogram_pdf_init (byval p as gsl_histogram_pdf ptr, byval h as gsl_histogram ptr) as integer
declare sub gsl_histogram_pdf_free (byval p as gsl_histogram_pdf ptr)
declare function gsl_histogram_pdf_sample (byval p as gsl_histogram_pdf ptr, byval r as double) as double
end extern

#endif
