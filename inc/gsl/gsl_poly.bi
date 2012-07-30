''
''
'' gsl_poly -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_poly_bi__
#define __gsl_poly_bi__

#include once "gsl_complex.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_poly_eval (byval c as double ptr, byval len as integer, byval x as double) as double
declare function gsl_poly_dd_init (byval dd as double ptr, byval x as double ptr, byval y as double ptr, byval size as integer) as integer
declare function gsl_poly_dd_eval (byval dd as double ptr, byval xa as double ptr, byval size as integer, byval x as double) as double
declare function gsl_poly_dd_taylor (byval c as double ptr, byval xp as double, byval dd as double ptr, byval x as double ptr, byval size as integer, byval w as double ptr) as integer
declare function gsl_poly_solve_quadratic (byval a as double, byval b as double, byval c as double, byval x0 as double ptr, byval x1 as double ptr) as integer
declare function gsl_poly_complex_solve_quadratic (byval a as double, byval b as double, byval c as double, byval z0 as gsl_complex ptr, byval z1 as gsl_complex ptr) as integer
declare function gsl_poly_solve_cubic (byval a as double, byval b as double, byval c as double, byval x0 as double ptr, byval x1 as double ptr, byval x2 as double ptr) as integer
declare function gsl_poly_complex_solve_cubic (byval a as double, byval b as double, byval c as double, byval z0 as gsl_complex ptr, byval z1 as gsl_complex ptr, byval z2 as gsl_complex ptr) as integer
end extern

type gsl_poly_complex_workspace
	nc as integer
	matrix as double ptr
end type

extern "c"
declare function gsl_poly_complex_workspace_alloc (byval n as integer) as gsl_poly_complex_workspace ptr
declare sub gsl_poly_complex_workspace_free (byval w as gsl_poly_complex_workspace ptr)
declare function gsl_poly_complex_solve (byval a as double ptr, byval n as integer, byval w as gsl_poly_complex_workspace ptr, byval z as gsl_complex_packed_ptr) as integer
end extern

#endif
