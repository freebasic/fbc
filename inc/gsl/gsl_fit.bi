''
''
'' gsl_fit -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_fit_bi__
#define __gsl_fit_bi__

#include once "gsl_math.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_fit_linear (byval x as double ptr, byval xstride as integer, byval y as double ptr, byval ystride as integer, byval n as integer, byval c0 as double ptr, byval c1 as double ptr, byval cov00 as double ptr, byval cov01 as double ptr, byval cov11 as double ptr, byval sumsq as double ptr) as integer
declare function gsl_fit_wlinear (byval x as double ptr, byval xstride as integer, byval w as double ptr, byval wstride as integer, byval y as double ptr, byval ystride as integer, byval n as integer, byval c0 as double ptr, byval c1 as double ptr, byval cov00 as double ptr, byval cov01 as double ptr, byval cov11 as double ptr, byval chisq as double ptr) as integer
declare function gsl_fit_linear_est (byval x as double, byval c0 as double, byval c1 as double, byval c00 as double, byval c01 as double, byval c11 as double, byval y as double ptr, byval y_err as double ptr) as integer
declare function gsl_fit_mul (byval x as double ptr, byval xstride as integer, byval y as double ptr, byval ystride as integer, byval n as integer, byval c1 as double ptr, byval cov11 as double ptr, byval sumsq as double ptr) as integer
declare function gsl_fit_wmul (byval x as double ptr, byval xstride as integer, byval w as double ptr, byval wstride as integer, byval y as double ptr, byval ystride as integer, byval n as integer, byval c1 as double ptr, byval cov11 as double ptr, byval sumsq as double ptr) as integer
declare function gsl_fit_mul_est (byval x as double, byval c1 as double, byval c11 as double, byval y as double ptr, byval y_err as double ptr) as integer
end extern

#endif
