''
''
'' gsl_complex -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_complex_bi__
#define __gsl_complex_bi__

type gsl_complex_packed as double ptr
type gsl_complex_packed_float as single ptr
type gsl_complex_packed_long_double as double ptr
type gsl_const_complex_packed as double ptr
type gsl_const_complex_packed_float as single ptr
type gsl_const_complex_packed_long_double as double ptr
type gsl_complex_packed_array as double ptr
type gsl_complex_packed_array_float as single ptr
type gsl_complex_packed_array_long_double as double ptr
type gsl_const_complex_packed_array as double ptr
type gsl_const_complex_packed_array_float as single ptr
type gsl_const_complex_packed_array_long_double as double ptr
type gsl_complex_packed_ptr as double ptr
type gsl_complex_packed_float_ptr as single ptr
type gsl_complex_packed_long_double_ptr as double ptr
type gsl_const_complex_packed_ptr as double ptr
type gsl_const_complex_packed_float_ptr as single ptr
type gsl_const_complex_packed_long_double_ptr as double ptr

type gsl_complex_long_double
	dat(0 to 2-1) as double
end type

type gsl_complex
	dat(0 to 2-1) as double
end type

type gsl_complex_float
	dat(0 to 2-1) as single
end type

#endif
