''
''
'' gsl_multifit -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_multifit_bi__
#define __gsl_multifit_bi__

#include once "gsl_math.bi"
#include once "gsl_vector.bi"
#include once "gsl_matrix.bi"
#include once "gsl_types.bi"

type gsl_multifit_linear_workspace
	n as integer
	p as integer
	A as gsl_matrix ptr
	Q as gsl_matrix ptr
	QSI as gsl_matrix ptr
	S as gsl_vector ptr
	t as gsl_vector ptr
	xt as gsl_vector ptr
	D as gsl_vector ptr
end type

extern "c"
declare function gsl_multifit_linear_alloc (byval n as integer, byval p as integer) as gsl_multifit_linear_workspace ptr
declare sub gsl_multifit_linear_free (byval work as gsl_multifit_linear_workspace ptr)
declare function gsl_multifit_linear (byval X as gsl_matrix ptr, byval y as gsl_vector ptr, byval c as gsl_vector ptr, byval cov as gsl_matrix ptr, byval chisq as double ptr, byval work as gsl_multifit_linear_workspace ptr) as integer
declare function gsl_multifit_wlinear (byval X as gsl_matrix ptr, byval w as gsl_vector ptr, byval y as gsl_vector ptr, byval c as gsl_vector ptr, byval cov as gsl_matrix ptr, byval chisq as double ptr, byval work as gsl_multifit_linear_workspace ptr) as integer
end extern

#endif
