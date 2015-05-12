''
''
'' gsl_monte -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_monte_bi__
#define __gsl_monte_bi__

type gsl_monte_function_struct
	f as function cdecl(byval as double ptr, byval as integer, byval as any ptr) as double
	dim as integer
	params as any ptr
end type

type gsl_monte_function as gsl_monte_function_struct

#endif
