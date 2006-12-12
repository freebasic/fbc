''
''
'' gsl_errno -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_errno_bi__
#define __gsl_errno_bi__

#include once "gsl_types.bi"

#ifndef FILE
type FILE as any ptr
#endif

enum 
	GSL_SUCCESS = 0
	GSL_FAILURE = -1
	GSL_CONTINUE = -2
	GSL_EDOM = 1
	GSL_ERANGE = 2
	GSL_EFAULT = 3
	GSL_EINVAL = 4
	GSL_EFAILED = 5
	GSL_EFACTOR = 6
	GSL_ESANITY = 7
	GSL_ENOMEM = 8
	GSL_EBADFUNC = 9
	GSL_ERUNAWAY = 10
	GSL_EMAXITER = 11
	GSL_EZERODIV = 12
	GSL_EBADTOL = 13
	GSL_ETOL = 14
	GSL_EUNDRFLW = 15
	GSL_EOVRFLW = 16
	GSL_ELOSS = 17
	GSL_EROUND = 18
	GSL_EBADLEN = 19
	GSL_ENOTSQR = 20
	GSL_ESING = 21
	GSL_EDIVERGE = 22
	GSL_EUNSUP = 23
	GSL_EUNIMPL = 24
	GSL_ECACHE = 25
	GSL_ETABLE = 26
	GSL_ENOPROG = 27
	GSL_ENOPROGJ = 28
	GSL_ETOLF = 29
	GSL_ETOLX = 30
	GSL_ETOLG = 31
	GSL_EOF = 32
end enum

extern "c"
declare sub gsl_error (byval reason as zstring ptr, byval file as zstring ptr, byval line as integer, byval gsl_errno as integer)
declare sub gsl_stream_printf (byval label as zstring ptr, byval file as zstring ptr, byval line as integer, byval reason as zstring ptr)
declare function gsl_strerror (byval gsl_errno as integer) as zstring ptr
end extern

type gsl_error_handler_t as any
type gsl_stream_handler_t as any

extern "c"
declare function gsl_set_error_handler (byval new_handler as gsl_error_handler_t ptr) as gsl_error_handler_t ptr
declare function gsl_set_error_handler_off () as gsl_error_handler_t ptr
declare function gsl_set_stream_handler (byval new_handler as gsl_stream_handler_t ptr) as gsl_stream_handler_t ptr
declare function gsl_set_stream (byval new_stream as FILE ptr) as FILE ptr
end extern

#endif
