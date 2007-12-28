''
''
'' gsl_combination -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_combination_bi__
#define __gsl_combination_bi__

#include once "gsl_errno.bi"
#include once "gsl_types.bi"
#include once "gsl_check_range.bi"

type gsl_combination_struct
	n as integer
	k as integer
	data as integer ptr
end type

type gsl_combination as gsl_combination_struct

extern "c"
declare function gsl_combination_alloc (byval n as integer, byval k as integer) as gsl_combination ptr
declare function gsl_combination_calloc (byval n as integer, byval k as integer) as gsl_combination ptr
declare sub gsl_combination_init_first (byval c as gsl_combination ptr)
declare sub gsl_combination_init_last (byval c as gsl_combination ptr)
declare sub gsl_combination_free (byval c as gsl_combination ptr)
declare function gsl_combination_memcpy (byval dest as gsl_combination ptr, byval src as gsl_combination ptr) as integer
declare function gsl_combination_fread (byval stream as FILE ptr, byval c as gsl_combination ptr) as integer
declare function gsl_combination_fwrite (byval stream as FILE ptr, byval c as gsl_combination ptr) as integer
declare function gsl_combination_fscanf (byval stream as FILE ptr, byval c as gsl_combination ptr) as integer
declare function gsl_combination_fprintf (byval stream as FILE ptr, byval c as gsl_combination ptr, byval format as zstring ptr) as integer
declare function gsl_combination_n (byval c as gsl_combination ptr) as integer
declare function gsl_combination_k (byval c as gsl_combination ptr) as integer
declare function gsl_combination_data (byval c as gsl_combination ptr) as integer ptr
declare function gsl_combination_get (byval c as gsl_combination ptr, byval i as integer) as integer
declare function gsl_combination_valid (byval c as gsl_combination ptr) as integer
declare function gsl_combination_next (byval c as gsl_combination ptr) as integer
declare function gsl_combination_prev (byval c as gsl_combination ptr) as integer
end extern

#endif
