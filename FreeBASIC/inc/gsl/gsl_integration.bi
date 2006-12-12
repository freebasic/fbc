''
''
'' gsl_integration -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_integration_bi__
#define __gsl_integration_bi__

#include once "gsl_math.bi"
#include once "gsl_types.bi"

type gsl_integration_workspace
	limit as integer
	size as integer
	nrmax as integer
	i as integer
	maximum_level as integer
	alist as double ptr
	blist as double ptr
	rlist as double ptr
	elist as double ptr
	order as integer ptr
	level as integer ptr
end type

extern "c"
declare function gsl_integration_workspace_alloc (byval n as integer) as gsl_integration_workspace ptr
declare sub gsl_integration_workspace_free (byval w as gsl_integration_workspace ptr)
end extern

type gsl_integration_qaws_table
	alpha as double
	beta as double
	mu as integer
	nu as integer
	ri(0 to 25-1) as double
	rj(0 to 25-1) as double
	rg(0 to 25-1) as double
	rh(0 to 25-1) as double
end type

extern "c"
declare function gsl_integration_qaws_table_alloc (byval alpha as double, byval beta as double, byval mu as integer, byval nu as integer) as gsl_integration_qaws_table ptr
declare function gsl_integration_qaws_table_set (byval t as gsl_integration_qaws_table ptr, byval alpha as double, byval beta as double, byval mu as integer, byval nu as integer) as integer
declare sub gsl_integration_qaws_table_free (byval t as gsl_integration_qaws_table ptr)
end extern

enum gsl_integration_qawo_enum
	GSL_INTEG_COSINE
	GSL_INTEG_SINE
end enum

type gsl_integration_qawo_table
	n as integer
	omega as double
	L as double
	par as double
	sine as gsl_integration_qawo_enum
	chebmo as double ptr
end type

extern "c"
declare function gsl_integration_qawo_table_alloc (byval omega as double, byval L as double, byval sine as gsl_integration_qawo_enum, byval n as integer) as gsl_integration_qawo_table ptr
declare function gsl_integration_qawo_table_set (byval t as gsl_integration_qawo_table ptr, byval omega as double, byval L as double, byval sine as gsl_integration_qawo_enum) as integer
declare function gsl_integration_qawo_table_set_length (byval t as gsl_integration_qawo_table ptr, byval L as double) as integer
declare sub gsl_integration_qawo_table_free (byval t as gsl_integration_qawo_table ptr)
end extern

type gsl_integration_rule as any

extern "c"
declare sub gsl_integration_qk15 (byval f as gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qk21 (byval f as gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qk31 (byval f as gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qk41 (byval f as gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qk51 (byval f as gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qk61 (byval f as gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qcheb (byval f as gsl_function ptr, byval a as double, byval b as double, byval cheb12 as double ptr, byval cheb24 as double ptr)
end extern

enum 
	GSL_INTEG_GAUSS15 = 1
	GSL_INTEG_GAUSS21 = 2
	GSL_INTEG_GAUSS31 = 3
	GSL_INTEG_GAUSS41 = 4
	GSL_INTEG_GAUSS51 = 5
	GSL_INTEG_GAUSS61 = 6
end enum

extern "c"
declare sub gsl_integration_qk (byval n as integer, byval xgk as double ptr, byval wg as double ptr, byval wgk as double ptr, byval fv1 as double ptr, byval fv2 as double ptr, byval f as gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare function gsl_integration_qng (byval f as gsl_function ptr, byval a as double, byval b as double, byval epsabs as double, byval epsrel as double, byval result as double ptr, byval abserr as double ptr, byval neval as integer ptr) as integer
declare function gsl_integration_qag (byval f as gsl_function ptr, byval a as double, byval b as double, byval epsabs as double, byval epsrel as double, byval limit as integer, byval key as integer, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_integration_qagi (byval f as gsl_function ptr, byval epsabs as double, byval epsrel as double, byval limit as integer, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_integration_qagiu (byval f as gsl_function ptr, byval a as double, byval epsabs as double, byval epsrel as double, byval limit as integer, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_integration_qagil (byval f as gsl_function ptr, byval b as double, byval epsabs as double, byval epsrel as double, byval limit as integer, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_integration_qags (byval f as gsl_function ptr, byval a as double, byval b as double, byval epsabs as double, byval epsrel as double, byval limit as integer, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_integration_qagp (byval f as gsl_function ptr, byval pts as double ptr, byval npts as integer, byval epsabs as double, byval epsrel as double, byval limit as integer, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_integration_qawc (byval f as gsl_function ptr, byval a as double, byval b as double, byval c as double, byval epsabs as double, byval epsrel as double, byval limit as integer, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_integration_qaws (byval f as gsl_function ptr, byval a as double, byval b as double, byval t as gsl_integration_qaws_table ptr, byval epsabs as double, byval epsrel as double, byval limit as integer, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_integration_qawo (byval f as gsl_function ptr, byval a as double, byval epsabs as double, byval epsrel as double, byval limit as integer, byval workspace as gsl_integration_workspace ptr, byval wf as gsl_integration_qawo_table ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_integration_qawf (byval f as gsl_function ptr, byval a as double, byval epsabs as double, byval limit as integer, byval workspace as gsl_integration_workspace ptr, byval cycle_workspace as gsl_integration_workspace ptr, byval wf as gsl_integration_qawo_table ptr, byval result as double ptr, byval abserr as double ptr) as integer
end extern

#endif
