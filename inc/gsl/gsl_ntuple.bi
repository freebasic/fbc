''
''
'' gsl_ntuple -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_ntuple_bi__
#define __gsl_ntuple_bi__

#include once "gsl_errno.bi"
#include once "gsl_histogram.bi"
#include once "gsl_types.bi"

type gsl_ntuple
	file as FILE ptr
	ntuple_data as any ptr
	size as integer
end type

type gsl_ntuple_select_fn
	function as function cdecl(byval as any ptr, byval as any ptr) as integer
	params as any ptr
end type

type gsl_ntuple_value_fn
	function as function cdecl(byval as any ptr, byval as any ptr) as double
	params as any ptr
end type

extern "c"
declare function gsl_ntuple_open (byval filename as zstring ptr, byval ntuple_data as any ptr, byval size as integer) as gsl_ntuple ptr
declare function gsl_ntuple_create (byval filename as zstring ptr, byval ntuple_data as any ptr, byval size as integer) as gsl_ntuple ptr
declare function gsl_ntuple_write (byval ntuple as gsl_ntuple ptr) as integer
declare function gsl_ntuple_read (byval ntuple as gsl_ntuple ptr) as integer
declare function gsl_ntuple_bookdata (byval ntuple as gsl_ntuple ptr) as integer
declare function gsl_ntuple_project (byval h as gsl_histogram ptr, byval ntuple as gsl_ntuple ptr, byval value_func as gsl_ntuple_value_fn ptr, byval select_func as gsl_ntuple_select_fn ptr) as integer
declare function gsl_ntuple_close (byval ntuple as gsl_ntuple ptr) as integer
end extern

#endif
